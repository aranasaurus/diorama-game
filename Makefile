BUILD_DIR = build
SRC_DIR = game

.PHONY: run build clean

run:
	love $(SRC_DIR)

build: $(BUILD_DIR)/diorama.love

$(BUILD_DIR)/diorama.love: clean
	cd $(SRC_DIR) && zip -9 -q -r diorama.love .
	mv $(SRC_DIR)/diorama.love $(BUILD_DIR)/

clean:
	rm -rf $(BUILD_DIR)/diorama.love

