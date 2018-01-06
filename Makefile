.PHONY: deploy

deploy :
	make -C vim deploy
	make -C bash deploy
	make -C X deploy
