.PHONY: deploy

deploy :
	make -C bash deploy
	make -C vim deploy
	make -C X deploy
	make -C fonts deploy
