.PHONY: dependency-graph docs clean install prepare conan_d conan_r#. phony targets are not real output file. just a command

BUILD_DIR := build

#. create the build directory if not already exist
$(shell mkdir -p $(BUILD_DIR))

all: prepare

install:
	sudo apt-get install gcc g++ cmake make doxygen git llvm pkg-config curl zip unzip tar python3-dev clang-format clang-tidy

prepare:
	rm -rf build
	mkdir build

dependency-graph:
	cd $(BUILD_DIR) && cmake .. -DCRS_IS_COMPILE_EXECUTABLE_SET=ON --graphviz=depGraph.dot && dot -Tpng depGraph.dot -o depGraphImage.png

docs:
	cd $(BUILD_DIR) && cmake ..
	cmake --build $(BUILD_DIR) --target build-docs

# debug build type
conan_d:
	rm -rf $(BUILD_DIR)
	mkdir $(BUILD_DIR)
	cd $(BUILD_DIR) && conan install .. -s build_type=Debug -s compiler.cppstd=17 --output-folder=. --build missing

# Release build type
conan_r:
	rm -rf $(BUILD_DIR)
	mkdir $(BUILD_DIR)
	cd $(BUILD_DIR) && conan install .. -s build_type=Release -s compiler.cppstd=17 --output-folder=. --build missing

clean:
	@echo "deleting build directory"
	rm -rf $(BUILD_DIR)