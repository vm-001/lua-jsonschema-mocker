build:
	luarocks make

clean:
	luarocks remove jsonschema-mocker --force

test:
	busted spec/

dev:
	luarocks install lua-cjson
	luarocks install busted
	luarocks install penlight
