.PHONY: dependency-graph docs clean #. phony targets are not real output file. just a command

BUILD_DIR := build

#. create the build directory if not already exist
$(shell mkdir -p $(BUILD_DIR))

dependency-graph:
	cd $(BUILD_DIR) && cmake .. -DCRS_IS_COMPILE_EXECUTABLE_SET=ON --graphviz=depGraph.dot && dot -Tpng depGraph.dot -o depGraphImage.png

docs:
	cd $(BUILD_DIR) && cmake ..
	cmake --build $(BUILD_DIR) --target build-docs

clean:
	@echo "deleting build directory"
	rm -rf $(BUILD_DIR)
