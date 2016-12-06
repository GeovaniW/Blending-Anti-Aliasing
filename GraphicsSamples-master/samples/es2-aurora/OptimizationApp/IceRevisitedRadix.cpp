//----------------------------------------------------------------------------------
// File:        es2-aurora\OptimizationApp/IceRevisitedRadix.cpp
// SDK Version: v3.00 
// Email:       gameworks@nvidia.com
// Site:        http://developer.nvidia.com/
//----------------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Contains source code from the article "Radix Sort Revisited".
 *    \file        IceRevisitedRadix.cpp
 *    \author        Pierre Terdiman
 *    \date        April, 4, 2000
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Revisited Radix Sort.
 *    This is my new radix routine:
 *  - it uses indices and doesn't recopy the values anymore, hence wasting less ram
 *  - it creates all the histograms in one run instead of four
 *  - it sorts words faster than dwords and bytes faster than words
 *  - it correctly sorts negative floating-point values by patching the offsets
 *  - it automatically takes advantage of temporal coherence
 *  - multiple keys support is a side effect of temporal coherence
 *  - it may be worth recoding in asm... (mainly to use FCOMI, FCMOV, etc) [it's probably memory-bound anyway]
 *
 *    History:
 *    - 08.15.98: very first version
 *    - 04.04.00: recoded for the radix article
 *    - 12.xx.00: code lifting
 *    - 09.18.01: faster CHECK_PASS_VALIDITY thanks to Mark D. Shattuck (who provided other tips, not included here)
 *    - 10.11.01: added local ram support
 *    - 01.20.02: bugfix! In very particular cases the last pass was skipped in the float code-path, leading to incorrect sorting......
 *
 *    \class        RadixSort
 *    \author        Pierre Terdiman
 *    \version    1.3
 *    \date        August, 15, 1998
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
To do:
    - add an offset parameter between two input values (avoid some data recopy sometimes)
    - unroll ? asm ?
*/

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "IceRevisitedRadix.h"

//!    A function to clear a buffer.
//!    \param    addr        buffer address
//!    \param    size        buffer length
//!    \see    FillMemory
//!    \see    CopyMemory
//!    \see    MoveMemory
inline void ZeroMemory(void* addr, udword size)                    { memset(addr, 0, size);        }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Constructor.
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadixSort::RadixSort() : mIndices(null), mIndices2(null), mCurrentSize(0), mPreviousSize(0), mTotalCalls(0), mNbHits(0)
{
#ifndef RADIX_LOCAL_RAM
    // Allocate input-independent ram
    mHistogram        = new udword[256*4];
    mOffset            = new udword[256];
#endif
    // Initialize indices
    ResetIndices();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Destructor.
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadixSort::~RadixSort()
{
    // Release everything
#ifndef RADIX_LOCAL_RAM
    DELETEARRAY(mOffset);
    DELETEARRAY(mHistogram);
#endif
    DELETEARRAY(mIndices2);
    DELETEARRAY(mIndices);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Resizes the inner lists.
 *    \param        nb                [in] new size (number of dwords)
 *    \return        true if success
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool RadixSort::Resize(udword nb)
{
    // Free previously used ram
    DELETEARRAY(mIndices2);
    DELETEARRAY(mIndices);

    // Get some fresh one
    mIndices        = new udword[nb];    CHECKALLOC(mIndices);
    mIndices2        = new udword[nb];    CHECKALLOC(mIndices2);
    mCurrentSize    = nb;

    // Initialize indices so that the input buffer is read in sequential order
    ResetIndices();

    return true;
}

#define CHECK_RESIZE(n)                                                                            \
    if(n!=mPreviousSize)                                                                        \
    {                                                                                            \
                if(n>mCurrentSize)    Resize(n);                                                    \
        else                        ResetIndices();                                                \
        mPreviousSize = n;                                                                        \
    }

#define CREATE_HISTOGRAMS(type, buffer)                                                            \
    /* Clear counters */                                                                        \
    ZeroMemory(mHistogram, 256*4*sizeof(udword));                                                \
                                                                                                \
    /* Prepare for temporal coherence */                                                        \
    type PrevVal = (type)buffer[mIndices[0]];                                                    \
    bool AlreadySorted = true;    /* Optimism... */                                                \
    udword* Indices = mIndices;                                                                    \
                                                                                                \
    /* Prepare to count */                                                                        \
    ubyte* p = (ubyte*)input;                                                                    \
    ubyte* pe = &p[nb*4];                                                                        \
    udword* h0= &mHistogram[0];        /* Histogram for first pass (LSB)    */                        \
    udword* h1= &mHistogram[256];    /* Histogram for second pass        */                        \
    udword* h2= &mHistogram[512];    /* Histogram for third pass            */                        \
    udword* h3= &mHistogram[768];    /* Histogram for last pass (MSB)    */                        \
                                                                                                \
    while(p!=pe)                                                                                \
    {                                                                                            \
        /* Read input buffer in previous sorted order */                                        \
        type Val = (type)buffer[*Indices++];                                                    \
        /* Check whether already sorted or not */                                                \
        if(Val<PrevVal)    { AlreadySorted = false; break; } /* Early out */                        \
        /* Update for next iteration */                                                            \
        PrevVal = Val;                                                                            \
                                                                                                \
        /* Create histograms */                                                                    \
        h0[*p++]++;    h1[*p++]++;    h2[*p++]++;    h3[*p++]++;                                            \
    }                                                                                            \
                                                                                                \
    /* If all input values are already sorted, we just have to return and leave the */            \
    /* previous list unchanged. That way the routine may take advantage of temporal */            \
    /* coherence, for example when used to sort transparent faces.                    */            \
    if(AlreadySorted)    { mNbHits++; return *this;    }                                            \
                                                                                                \
    /* Else there has been an early out and we must finish computing the histograms */            \
    while(p!=pe)                                                                                \
    {                                                                                            \
        /* Create histograms without the previous overhead */                                    \
        h0[*p++]++;    h1[*p++]++;    h2[*p++]++;    h3[*p++]++;                                            \
    }

#define CHECK_PASS_VALIDITY(pass)                                                                \
    /* Shortcut to current counters */                                                            \
    udword* CurCount = &mHistogram[pass<<8];                                                    \
                                                                                                \
    /* Reset flag. The sorting pass is supposed to be performed. (default) */                    \
    bool PerformPass = true;                                                                    \
                                                                                                \
    /* Check pass validity */                                                                    \
                                                                                                \
    /* If all values have the same byte, sorting is useless. */                                    \
    /* It may happen when sorting bytes or words instead of dwords. */                            \
    /* This routine actually sorts words faster than dwords, and bytes */                        \
    /* faster than words. Standard running time (O(4*n))is reduced to O(2*n) */                    \
    /* for words and O(n) for bytes. Running time for floats depends on actual values... */        \
                                                                                                \
    /* Get first byte */                                                                        \
    ubyte UniqueVal = *(((ubyte*)input)+pass);                                                    \
                                                                                                \
    /* Check that byte's counter */                                                                \
    if(CurCount[UniqueVal]==nb)    PerformPass=false;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Main sort routine.
 *    This one is for integer values. After the call, mIndices contains a list of indices in sorted order, i.e. in the order you may process your data.
 *    \param        input            [in] a list of integer values to sort
 *    \param        nb                [in] number of values to sort
 *    \param        signedvalues    [in] true to handle negative values, false if you know your input buffer only contains positive values
 *    \return        Self-Reference
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadixSort& RadixSort::Sort(const udword* input, udword nb, bool signedvalues)
{
    // Checkings
    if(!input || !nb)    return *this;

    // Stats
    mTotalCalls++;

    // Resize lists if needed
    CHECK_RESIZE(nb);

#ifdef RADIX_LOCAL_RAM
    // Allocate histograms & offsets on the stack
    udword mHistogram[256*4];
    udword mOffset[256];
#endif

    // Create histograms (counters). Counters for all passes are created in one run.
    // Pros:    read input buffer once instead of four times
    // Cons:    mHistogram is 4Kb instead of 1Kb
    // We must take care of signed/unsigned values for temporal coherence.... I just
    // have 2 code paths even if just a single opcode changes. Self-modifying code, someone?
    if(!signedvalues)    { CREATE_HISTOGRAMS(udword, input);    }
    else                { CREATE_HISTOGRAMS(sdword, input);    }

    // Compute #negative values involved if needed
    udword NbNegativeValues = 0;
    if(signedvalues)
    {
        // An efficient way to compute the number of negatives values we'll have to deal with is simply to sum the 128
        // last values of the last histogram. Last histogram because that's the one for the Most Significant Byte,
        // responsible for the sign. 128 last values because the 128 first ones are related to positive numbers.
        udword* h3= &mHistogram[768];
        for(udword i=128;i<256;i++)    NbNegativeValues += h3[i];    // 768 for last histogram, 128 for negative part
    }

    // Radix sort, j is the pass number (0=LSB, 3=MSB)
    for(udword j=0;j<4;j++)
    {
        CHECK_PASS_VALIDITY(j);

        // Sometimes the fourth (negative) pass is skipped because all numbers are negative and the MSB is 0xFF (for example). This is
        // not a problem, numbers are correctly sorted anyway.
        if(PerformPass)
        {
            // Should we care about negative values?
            if(j!=3 || !signedvalues)
            {
                // Here we deal with positive values only

                // Create offsets
                mOffset[0] = 0;
                for(udword i=1;i<256;i++)        mOffset[i] = mOffset[i-1] + CurCount[i-1];
            }
            else
            {
                // This is a special case to correctly handle negative integers. They're sorted in the right order but at the wrong place.

                // Create biased offsets, in order for negative numbers to be sorted as well
                mOffset[0] = NbNegativeValues;                                                // First positive number takes place after the negative ones
                for(udword i=1;i<128;i++)        mOffset[i] = mOffset[i-1] + CurCount[i-1];    // 1 to 128 for positive numbers

                // Fixing the wrong place for negative values
                mOffset[128] = 0;
                for(udword i=129;i<256;i++)            mOffset[i] = mOffset[i-1] + CurCount[i-1];
            }

            // Perform Radix Sort
            ubyte* InputBytes    = (ubyte*)input;
            udword* Indices        = mIndices;
            udword* IndicesEnd    = &mIndices[nb];
            InputBytes += j;
            while(Indices!=IndicesEnd)
            {
                udword id = *Indices++;
                mIndices2[mOffset[InputBytes[id<<2]]++] = id;
            }

            // Swap pointers for next pass. Valid indices - the most recent ones - are in mIndices after the swap.
            udword* Tmp    = mIndices;    mIndices = mIndices2; mIndices2 = Tmp;
        }
    }
    return *this;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Main sort routine.
 *    This one is for floating-point values. After the call, mIndices contains a list of indices in sorted order, i.e. in the order you may process your data.
 *    \param        input            [in] a list of floating-point values to sort
 *    \param        nb                [in] number of values to sort
 *    \return        Self-Reference
 *    \warning    only sorts IEEE floating-point values
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadixSort& RadixSort::Sort(const float* input2, udword nb)
{
    // Checkings
    if(!input2 || !nb)    return *this;

    // Stats
    mTotalCalls++;

    udword* input = (udword*)input2;

    // Resize lists if needed
    CHECK_RESIZE(nb);

#ifdef RADIX_LOCAL_RAM
    // Allocate histograms & offsets on the stack
    udword mHistogram[256*4];
    udword mOffset[256];
#endif

    // Create histograms (counters). Counters for all passes are created in one run.
    // Pros:    read input buffer once instead of four times
    // Cons:    mHistogram is 4Kb instead of 1Kb
    // Floating-point values are always supposed to be signed values, so there's only one code path there.
    // Please note the floating point comparison needed for temporal coherence! Although the resulting asm code
    // is dreadful, this is surprisingly not such a performance hit - well, I suppose that's a big one on first
    // generation Pentiums....We can't make comparison on integer representations because, as Chris said, it just
    // wouldn't work with mixed positive/negative values....
    { CREATE_HISTOGRAMS(float, input2); }

    // Compute #negative values involved if needed
    udword NbNegativeValues = 0;
    // An efficient way to compute the number of negatives values we'll have to deal with is simply to sum the 128
    // last values of the last histogram. Last histogram because that's the one for the Most Significant Byte,
    // responsible for the sign. 128 last values because the 128 first ones are related to positive numbers.
    udword* h3= &mHistogram[768];
    for(udword i=128;i<256;i++)    NbNegativeValues += h3[i];    // 768 for last histogram, 128 for negative part

    // Radix sort, j is the pass number (0=LSB, 3=MSB)
    for(udword j=0;j<4;j++)
    {
        // Should we care about negative values?
        if(j!=3)
        {
            // Here we deal with positive values only
            CHECK_PASS_VALIDITY(j);

            if(PerformPass)
            {
                // Create offsets
                mOffset[0] = 0;
                for(udword i=1;i<256;i++)        mOffset[i] = mOffset[i-1] + CurCount[i-1];

                // Perform Radix Sort
                ubyte* InputBytes    = (ubyte*)input;
                udword* Indices        = mIndices;
                udword* IndicesEnd    = &mIndices[nb];
                InputBytes += j;
                while(Indices!=IndicesEnd)
                {
                    udword id = *Indices++;
                    mIndices2[mOffset[InputBytes[id<<2]]++] = id;
                }

                // Swap pointers for next pass. Valid indices - the most recent ones - are in mIndices after the swap.
                udword* Tmp    = mIndices;    mIndices = mIndices2; mIndices2 = Tmp;
            }
        }
        else
        {
            // This is a special case to correctly handle negative values
            CHECK_PASS_VALIDITY(j);

            if(PerformPass)
            {
                // Create biased offsets, in order for negative numbers to be sorted as well
                mOffset[0] = NbNegativeValues;                                                // First positive number takes place after the negative ones
                for(udword i=1;i<128;i++)        mOffset[i] = mOffset[i-1] + CurCount[i-1];    // 1 to 128 for positive numbers

                // We must reverse the sorting order for negative numbers!
                mOffset[255] = 0;
                for(udword i=0;i<127;i++)        mOffset[254-i] = mOffset[255-i] + CurCount[255-i];    // Fixing the wrong order for negative values
                for(udword i=128;i<256;i++)    mOffset[i] += CurCount[i];                            // Fixing the wrong place for negative values

                // Perform Radix Sort
                for(udword i=0;i<nb;i++)
                {
                    udword Radix = input[mIndices[i]]>>24;                                // Radix byte, same as above. AND is useless here (udword).
                    // ### cmp to be killed. Not good. Later.
                    if(Radix<128)        mIndices2[mOffset[Radix]++] = mIndices[i];        // Number is positive, same as above
                    else                mIndices2[--mOffset[Radix]] = mIndices[i];        // Number is negative, flip the sorting order
                }
                // Swap pointers for next pass. Valid indices - the most recent ones - are in mIndices after the swap.
                udword* Tmp    = mIndices;    mIndices = mIndices2; mIndices2 = Tmp;
            }
            else
            {
                // The pass is useless, yet we still have to reverse the order of current list if all values are negative.
                if(UniqueVal>=128)
                {
                    for(udword i=0;i<nb;i++)    mIndices2[i] = mIndices[nb-i-1];

                    // Swap pointers for next pass. Valid indices - the most recent ones - are in mIndices after the swap.
                    udword* Tmp    = mIndices;    mIndices = mIndices2; mIndices2 = Tmp;
                }
            }
        }
    }
    return *this;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Resets the inner indices. After the call, mIndices is reset.
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void RadixSort::ResetIndices()
{
    for(udword i=0;i<mCurrentSize;i++)    mIndices[i] = i;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *    Gets the ram used.
 *    \return        memory used in bytes
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
udword RadixSort::GetUsedRam() const
{
    udword UsedRam = sizeof(RadixSort);
#ifndef RADIX_LOCAL_RAM
    UsedRam += 256*4*sizeof(udword);            // Histograms
    UsedRam += 256*sizeof(udword);                // Offsets
#endif
    UsedRam += 2*mCurrentSize*sizeof(udword);    // 2 lists of indices
    return UsedRam;
}
