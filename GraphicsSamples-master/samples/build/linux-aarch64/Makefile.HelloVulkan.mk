# Makefile generated by XPJ for linux-aarch64
-include Makefile.custom
ProjectName = HelloVulkan
HelloVulkan_cppfiles   += ./../../vk10-kepler/HelloVulkan/HelloVulkan.cpp
HelloVulkan_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl   += ./../../vk10-kepler/HelloVulkan/assets/src_shaders/simple.glsl

HelloVulkan_cpp_debug_dep    = $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(HelloVulkan_cppfiles)))))
HelloVulkan_cc_debug_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.debug.P, $(HelloVulkan_ccfiles)))))
HelloVulkan_c_debug_dep      = $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(HelloVulkan_cfiles)))))
HelloVulkan_debug_dep      = $(HelloVulkan_cpp_debug_dep) $(HelloVulkan_cc_debug_dep) $(HelloVulkan_c_debug_dep)
-include $(HelloVulkan_debug_dep)
HelloVulkan_cpp_release_dep    = $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.P, $(HelloVulkan_cppfiles)))))
HelloVulkan_cc_release_dep    = $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.release.P, $(HelloVulkan_ccfiles)))))
HelloVulkan_c_release_dep      = $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.P, $(HelloVulkan_cfiles)))))
HelloVulkan_release_dep      = $(HelloVulkan_cpp_release_dep) $(HelloVulkan_cc_release_dep) $(HelloVulkan_c_release_dep)
-include $(HelloVulkan_release_dep)
HelloVulkan_debug_hpaths    := 
HelloVulkan_debug_hpaths    += ./../../vk10-kepler/HelloVulkan
HelloVulkan_debug_hpaths    += ./../../../extensions/include
HelloVulkan_debug_hpaths    += ./../../../extensions/include/NsFoundation
HelloVulkan_debug_hpaths    += ./../../../extensions/include/NvFoundation
HelloVulkan_debug_hpaths    += ./../../../extensions/externals/include
HelloVulkan_debug_hpaths    += ./../../../extensions/externals/include/GLFW
HelloVulkan_debug_hpaths    += ./../../../extensions/include/NvVkUtil/nosdk
HelloVulkan_debug_hpaths    += $(VK_SDK_PATH)/include
HelloVulkan_debug_hpaths    += ./../../../extensions/include/NvVkUtil
HelloVulkan_debug_lpaths    := 
HelloVulkan_debug_lpaths    += $(VK_SDK_PATH)/build-arm/loader
HelloVulkan_debug_lpaths    += ./../../../extensions/lib/linux-aarch64
HelloVulkan_debug_lpaths    += ./../../../extensions/externals/lib/linux-aarch64
HelloVulkan_debug_defines   := $(HelloVulkan_custom_defines)
HelloVulkan_debug_defines   += LINUX=1
HelloVulkan_debug_defines   += NV_LINUX
HelloVulkan_debug_defines   += GLEW_NO_GLU=1
HelloVulkan_debug_defines   += GW_APP_NAME=\"HelloVulkan\"
HelloVulkan_debug_defines   += _DEBUG
HelloVulkan_debug_libraries := 
HelloVulkan_debug_libraries += NvVkUtilD
HelloVulkan_debug_libraries += NsFoundationD
HelloVulkan_debug_libraries += NvAppBaseD
HelloVulkan_debug_libraries += NvAssetLoaderD
HelloVulkan_debug_libraries += NvModelD
HelloVulkan_debug_libraries += NvGLUtilsD
HelloVulkan_debug_libraries += NvGamepadD
HelloVulkan_debug_libraries += NvImageD
HelloVulkan_debug_libraries += NvUID
HelloVulkan_debug_libraries += HalfD
HelloVulkan_debug_libraries += glfw3
HelloVulkan_debug_libraries += vulkan
HelloVulkan_debug_libraries += NvAppBaseD
HelloVulkan_debug_libraries += NvUID
HelloVulkan_debug_libraries += NvAssetLoaderD
HelloVulkan_debug_libraries += NvModelD
HelloVulkan_debug_libraries += NvGLUtilsD
HelloVulkan_debug_libraries += NvGamepadD
HelloVulkan_debug_libraries += NvImageD
HelloVulkan_debug_libraries += HalfD
HelloVulkan_debug_libraries += GLEW
HelloVulkan_debug_libraries += GL
HelloVulkan_debug_libraries += X11
HelloVulkan_debug_libraries += Xrandr
HelloVulkan_debug_libraries += Xxf86vm
HelloVulkan_debug_libraries += Xi
HelloVulkan_debug_libraries += Xinerama
HelloVulkan_debug_libraries += Xcursor
HelloVulkan_debug_libraries += dl
HelloVulkan_debug_common_cflags	:= $(HelloVulkan_custom_cflags)
HelloVulkan_debug_common_cflags    += -MMD
HelloVulkan_debug_common_cflags    += $(addprefix -D, $(HelloVulkan_debug_defines))
HelloVulkan_debug_common_cflags    += $(addprefix -I, $(HelloVulkan_debug_hpaths))
HelloVulkan_debug_common_cflags  += -funwind-tables -Wall -Wextra -Wno-unused-parameter -Wno-ignored-qualifiers -Wno-unused-but-set-variable -Wno-switch -Wno-unused-variable -Wno-unused-function -pthread
HelloVulkan_debug_common_cflags  += -funwind-tables -O0 -g -ggdb -fno-omit-frame-pointer
HelloVulkan_debug_cflags	:= $(HelloVulkan_debug_common_cflags)
HelloVulkan_debug_cppflags	:= $(HelloVulkan_debug_common_cflags)
HelloVulkan_debug_cppflags  += -Wno-reorder -std=c++11
HelloVulkan_debug_cppflags  += -Wno-reorder
HelloVulkan_debug_lflags    := $(HelloVulkan_custom_lflags)
HelloVulkan_debug_lflags    += $(addprefix -L, $(HelloVulkan_debug_lpaths))
HelloVulkan_debug_lflags    += -Wl,--start-group $(addprefix -l, $(HelloVulkan_debug_libraries)) -Wl,--end-group
HelloVulkan_debug_lflags  += -Wl,--unresolved-symbols=ignore-in-shared-libs -pthread
HelloVulkan_debug_objsdir  = $(OBJS_DIR)/HelloVulkan_debug
HelloVulkan_debug_cpp_o    = $(addprefix $(HelloVulkan_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(HelloVulkan_cppfiles)))))
HelloVulkan_debug_cc_o    = $(addprefix $(HelloVulkan_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(HelloVulkan_ccfiles)))))
HelloVulkan_debug_c_o      = $(addprefix $(HelloVulkan_debug_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(HelloVulkan_cfiles)))))
HelloVulkan_debug_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl_o += ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs
HelloVulkan_debug_obj      =  $(HelloVulkan_debug_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl_o) $(HelloVulkan_debug_cpp_o) $(HelloVulkan_debug_cc_o) $(HelloVulkan_debug_c_o) 
HelloVulkan_debug_bin      := ./../../bin/linux-aarch64/HelloVulkanD

clean_HelloVulkan_debug: 
	@$(ECHO) clean HelloVulkan debug
	@$(RMDIR) $(HelloVulkan_debug_objsdir)
	@$(RMDIR) $(HelloVulkan_debug_bin)
	@$(RMDIR) $(DEPSDIR)/HelloVulkan/debug

build_HelloVulkan_debug: postbuild_HelloVulkan_debug
postbuild_HelloVulkan_debug: mainbuild_HelloVulkan_debug
mainbuild_HelloVulkan_debug: prebuild_HelloVulkan_debug $(HelloVulkan_debug_bin)
prebuild_HelloVulkan_debug:

$(HelloVulkan_debug_bin): $(HelloVulkan_debug_obj) build_NvVkUtil_debug build_NsFoundation_debug build_NvAppBase_debug build_NvAssetLoader_debug build_NvModel_debug build_NvGLUtils_debug build_NvGamepad_debug build_NvImage_debug build_NvUI_debug build_Half_debug 
	mkdir -p `dirname ./../../bin/linux-aarch64/HelloVulkanD`
	$(CCLD) $(filter %.o, $(HelloVulkan_debug_obj)) $(HelloVulkan_debug_lflags) -o $(HelloVulkan_debug_bin) 
	$(ECHO) building $@ complete!

$(HelloVulkan_debug_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl_o): $(HelloVulkan_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl) 
	@mkdir -p `dirname ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs`
	$(ECHO) ../../../BuildTools/spir-v/bin/glsl2spirv.sh -o ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs ../../vk10-kepler/HelloVulkan/assets/src_shaders/simple.glsl
	../../../BuildTools/spir-v/bin/glsl2spirv.sh -o ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs ../../vk10-kepler/HelloVulkan/assets/src_shaders/simple.glsl

HelloVulkan_debug_DEPDIR = $(dir $(@))/$(*F)
$(HelloVulkan_debug_cpp_o): $(HelloVulkan_debug_objsdir)/%.o:
	$(ECHO) HelloVulkan: compiling debug $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(HelloVulkan_debug_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cppfiles))))))
	cp $(HelloVulkan_debug_DEPDIR).d $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(HelloVulkan_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cppfiles))))).P; \
	  rm -f $(HelloVulkan_debug_DEPDIR).d

$(HelloVulkan_debug_cc_o): $(HelloVulkan_debug_objsdir)/%.o:
	$(ECHO) HelloVulkan: compiling debug $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(HelloVulkan_debug_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_ccfiles))))))
	cp $(HelloVulkan_debug_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_ccfiles))))).debug.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(HelloVulkan_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_ccfiles))))).debug.P; \
	  rm -f $(HelloVulkan_debug_DEPDIR).d

$(HelloVulkan_debug_c_o): $(HelloVulkan_debug_objsdir)/%.o:
	$(ECHO) HelloVulkan: compiling debug $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(HelloVulkan_debug_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cfiles))))))
	cp $(HelloVulkan_debug_DEPDIR).d $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(HelloVulkan_debug_DEPDIR).d >> $(addprefix $(DEPSDIR)/HelloVulkan/debug/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_debug_objsdir),, $@))), $(HelloVulkan_cfiles))))).P; \
	  rm -f $(HelloVulkan_debug_DEPDIR).d

HelloVulkan_release_hpaths    := 
HelloVulkan_release_hpaths    += ./../../vk10-kepler/HelloVulkan
HelloVulkan_release_hpaths    += ./../../../extensions/include
HelloVulkan_release_hpaths    += ./../../../extensions/include/NsFoundation
HelloVulkan_release_hpaths    += ./../../../extensions/include/NvFoundation
HelloVulkan_release_hpaths    += ./../../../extensions/externals/include
HelloVulkan_release_hpaths    += ./../../../extensions/externals/include/GLFW
HelloVulkan_release_hpaths    += ./../../../extensions/include/NvVkUtil/nosdk
HelloVulkan_release_hpaths    += $(VK_SDK_PATH)/include
HelloVulkan_release_hpaths    += ./../../../extensions/include/NvVkUtil
HelloVulkan_release_lpaths    := 
HelloVulkan_release_lpaths    += $(VK_SDK_PATH)/build-arm/loader
HelloVulkan_release_lpaths    += ./../../../extensions/lib/linux-aarch64
HelloVulkan_release_lpaths    += ./../../../extensions/externals/lib/linux-aarch64
HelloVulkan_release_defines   := $(HelloVulkan_custom_defines)
HelloVulkan_release_defines   += LINUX=1
HelloVulkan_release_defines   += NV_LINUX
HelloVulkan_release_defines   += GLEW_NO_GLU=1
HelloVulkan_release_defines   += GW_APP_NAME=\"HelloVulkan\"
HelloVulkan_release_defines   += NDEBUG
HelloVulkan_release_libraries := 
HelloVulkan_release_libraries += NvVkUtil
HelloVulkan_release_libraries += NsFoundation
HelloVulkan_release_libraries += NvAppBase
HelloVulkan_release_libraries += NvAssetLoader
HelloVulkan_release_libraries += NvModel
HelloVulkan_release_libraries += NvGLUtils
HelloVulkan_release_libraries += NvGamepad
HelloVulkan_release_libraries += NvImage
HelloVulkan_release_libraries += NvUI
HelloVulkan_release_libraries += Half
HelloVulkan_release_libraries += glfw3
HelloVulkan_release_libraries += vulkan
HelloVulkan_release_libraries += NvAppBase
HelloVulkan_release_libraries += NvUI
HelloVulkan_release_libraries += NvAssetLoader
HelloVulkan_release_libraries += NvModel
HelloVulkan_release_libraries += NvGLUtils
HelloVulkan_release_libraries += NvGamepad
HelloVulkan_release_libraries += NvImage
HelloVulkan_release_libraries += Half
HelloVulkan_release_libraries += GLEW
HelloVulkan_release_libraries += GL
HelloVulkan_release_libraries += X11
HelloVulkan_release_libraries += Xrandr
HelloVulkan_release_libraries += Xxf86vm
HelloVulkan_release_libraries += Xi
HelloVulkan_release_libraries += Xinerama
HelloVulkan_release_libraries += Xcursor
HelloVulkan_release_libraries += dl
HelloVulkan_release_common_cflags	:= $(HelloVulkan_custom_cflags)
HelloVulkan_release_common_cflags    += -MMD
HelloVulkan_release_common_cflags    += $(addprefix -D, $(HelloVulkan_release_defines))
HelloVulkan_release_common_cflags    += $(addprefix -I, $(HelloVulkan_release_hpaths))
HelloVulkan_release_common_cflags  += -funwind-tables -Wall -Wextra -Wno-unused-parameter -Wno-ignored-qualifiers -Wno-unused-but-set-variable -Wno-switch -Wno-unused-variable -Wno-unused-function -pthread
HelloVulkan_release_common_cflags  += -funwind-tables -O2 -fno-omit-frame-pointer
HelloVulkan_release_cflags	:= $(HelloVulkan_release_common_cflags)
HelloVulkan_release_cppflags	:= $(HelloVulkan_release_common_cflags)
HelloVulkan_release_cppflags  += -Wno-reorder -std=c++11
HelloVulkan_release_cppflags  += -Wno-reorder
HelloVulkan_release_lflags    := $(HelloVulkan_custom_lflags)
HelloVulkan_release_lflags    += $(addprefix -L, $(HelloVulkan_release_lpaths))
HelloVulkan_release_lflags    += -Wl,--start-group $(addprefix -l, $(HelloVulkan_release_libraries)) -Wl,--end-group
HelloVulkan_release_lflags  += -Wl,--unresolved-symbols=ignore-in-shared-libs -pthread
HelloVulkan_release_objsdir  = $(OBJS_DIR)/HelloVulkan_release
HelloVulkan_release_cpp_o    = $(addprefix $(HelloVulkan_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cpp, %.cpp.o, $(HelloVulkan_cppfiles)))))
HelloVulkan_release_cc_o    = $(addprefix $(HelloVulkan_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.cc, %.cc.o, $(HelloVulkan_ccfiles)))))
HelloVulkan_release_c_o      = $(addprefix $(HelloVulkan_release_objsdir)/, $(subst ./, , $(subst ../, , $(patsubst %.c, %.c.o, $(HelloVulkan_cfiles)))))
HelloVulkan_release_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl_o += ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs
HelloVulkan_release_obj      =  $(HelloVulkan_release_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl_o) $(HelloVulkan_release_cpp_o) $(HelloVulkan_release_cc_o) $(HelloVulkan_release_c_o) 
HelloVulkan_release_bin      := ./../../bin/linux-aarch64/HelloVulkan

clean_HelloVulkan_release: 
	@$(ECHO) clean HelloVulkan release
	@$(RMDIR) $(HelloVulkan_release_objsdir)
	@$(RMDIR) $(HelloVulkan_release_bin)
	@$(RMDIR) $(DEPSDIR)/HelloVulkan/release

build_HelloVulkan_release: postbuild_HelloVulkan_release
postbuild_HelloVulkan_release: mainbuild_HelloVulkan_release
mainbuild_HelloVulkan_release: prebuild_HelloVulkan_release $(HelloVulkan_release_bin)
prebuild_HelloVulkan_release:

$(HelloVulkan_release_bin): $(HelloVulkan_release_obj) build_NvVkUtil_release build_NsFoundation_release build_NvAppBase_release build_NvAssetLoader_release build_NvModel_release build_NvGLUtils_release build_NvGamepad_release build_NvImage_release build_NvUI_release build_Half_release 
	mkdir -p `dirname ./../../bin/linux-aarch64/HelloVulkan`
	$(CCLD) $(filter %.o, $(HelloVulkan_release_obj)) $(HelloVulkan_release_lflags) -o $(HelloVulkan_release_bin) 
	$(ECHO) building $@ complete!

$(HelloVulkan_release_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl_o): $(HelloVulkan_GLSLC_src_vk10-kepler_HelloVulkan_assets_src_shaders_simple_glsl) 
	@mkdir -p `dirname ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs`
	$(ECHO) ../../../BuildTools/spir-v/bin/glsl2spirv.sh -o ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs ../../vk10-kepler/HelloVulkan/assets/src_shaders/simple.glsl
	../../../BuildTools/spir-v/bin/glsl2spirv.sh -o ../../vk10-kepler/HelloVulkan/assets/src_shaders/../shaders/simple.nvs ../../vk10-kepler/HelloVulkan/assets/src_shaders/simple.glsl

HelloVulkan_release_DEPDIR = $(dir $(@))/$(*F)
$(HelloVulkan_release_cpp_o): $(HelloVulkan_release_objsdir)/%.o:
	$(ECHO) HelloVulkan: compiling release $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cppfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(HelloVulkan_release_cppflags) -c $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cppfiles)) -o $@
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cppfiles))))))
	cp $(HelloVulkan_release_DEPDIR).d $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cppfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(HelloVulkan_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cpp.o,.cpp, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cppfiles))))).P; \
	  rm -f $(HelloVulkan_release_DEPDIR).d

$(HelloVulkan_release_cc_o): $(HelloVulkan_release_objsdir)/%.o:
	$(ECHO) HelloVulkan: compiling release $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_ccfiles))...
	mkdir -p $(dir $(@))
	$(CXX) $(HelloVulkan_release_cppflags) -c $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_ccfiles)) -o $@
	mkdir -p $(dir $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_ccfiles))))))
	cp $(HelloVulkan_release_DEPDIR).d $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_ccfiles))))).release.P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(HelloVulkan_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .cc.o,.cc, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_ccfiles))))).release.P; \
	  rm -f $(HelloVulkan_release_DEPDIR).d

$(HelloVulkan_release_c_o): $(HelloVulkan_release_objsdir)/%.o:
	$(ECHO) HelloVulkan: compiling release $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cfiles))...
	mkdir -p $(dir $(@))
	$(CC) $(HelloVulkan_release_cflags) -c $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cfiles)) -o $@ 
	@mkdir -p $(dir $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cfiles))))))
	cp $(HelloVulkan_release_DEPDIR).d $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cfiles))))).P; \
	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
		-e '/^$$/ d' -e 's/$$/ :/' < $(HelloVulkan_release_DEPDIR).d >> $(addprefix $(DEPSDIR)/HelloVulkan/release/, $(subst ./, , $(subst ../, , $(filter %$(strip $(subst .c.o,.c, $(subst $(HelloVulkan_release_objsdir),, $@))), $(HelloVulkan_cfiles))))).P; \
	  rm -f $(HelloVulkan_release_DEPDIR).d

clean_HelloVulkan:  clean_HelloVulkan_debug clean_HelloVulkan_release
	rm -rf $(DEPSDIR)

export VERBOSE
ifndef VERBOSE
.SILENT:
endif
