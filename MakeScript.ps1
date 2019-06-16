param([string] $userCommand = "")

$SERVER_OUT = "bin/server"
$CLIENT_OUT = "bin/client"
$API_OUT = "api/api.pb.go"
$API_REST_OUT = "api/api.pb.gw.go"
$API_SWAG_OUT = "api/api.swagger.json"
$PKG = "grpc_sandbox"
$SERVER_PKG_BUILD = "${PKG}/server"
$CLIENT_PKG_BUILD = "${PKG}/client"
$SRC = "C:\Users\chanson\go\src"
$PROTOC_BASE_COMMAND = "protoc -I api/ -I${SRC} -I${SRC}/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis"

Write-Output $SERVER_OUT
Write-Output $CLIENT_OUT
Write-Output $API_OUT
Write-Output $API_REST_OUT
Write-Output $API_SWAG_OUT
Write-Output $PKG
Write-Output $SERVER_PKG_BUILD
Write-Output $CLIENT_PKG_BUILD

if($userCommand -eq "clean")
{
    #remove server build
    $SERVER_FILE_PATH = "${SRC}\${PKG}\${SERVER_OUT}";
    If(Test-Path $SERVER_FILE_PATH)
    {
        Remove-Item -Path "$SERVER_FILE_PATH"
    }
    #remove client build
    $CLIENT_FILE_PATH = "${SRC}\${PKG}\${CLIENT_OUT}"
    If(Test-Path $CLIENT_FILE_PATH)
    {
        Remove-Item -Path "$CLIENT_FILE_PATH"
    }
    #remove api protoc
    $API_OUT_PATH = "${SRC}\${PKG}\${API_OUT}"
    If(Test-Path $API_OUT_PATH)
    {
        Remove-Item -Path "$API_OUT_PATH"
    }
    #remove api rest
    $API_REST_OUT_PATH = "${SRC}\${PKG}\${API_REST_OUT}"
    If(Test-Path $API_REST_OUT_PATH)
    {
        Remove-Item -Path "$API_REST_OUT_PATH"
    }
    #remove api swag
    $API_SWAG_OUT_PATH = "${SRC}\${PKG}\${API_SWAG_OUT}"
    If(Test-Path $API_SWAG_OUT_PATH)
    {
        Remove-Item -Path "$API_SWAG_OUT_PATH"
    }
}

#generate the API.PB.GO file
$PROTOC_API_OUT = "${PROTOC_BASE_COMMAND} --go_out=plugins=grpc:api api/api.proto"

cmd /c ${PROTOC_API_OUT}

#generate the API.PB.GW.GO file
$PROTOC_GATEWAY_OUT = "${PROTOC_BASE_COMMAND} --grpc-gateway_out=logtostderr=true:api api/api.proto"
cmd /c ${PROTOC_GATEWAY_OUT}

#generate the API.Swagger.Json file
$PROTOC_SWAGGER_OUT = "${PROTOC_BASE_COMMAND} --swagger_out=logtostderr=true:api api/api.proto"
cmd /c ${PROTOC_SWAGGER_OUT}

##Skipping the build process for now, just running the server/main.go and client/main.go files 

## Get the dependencies
#cmd /c "go get -v -d ./..."

## Build the binary file for server
#cmd /c "go build -i -v -o ${SERVER_OUT} ${SERVER_PKG_BUILD}"

## Build the binary file for client
#cmd /c "go build -i -v -o ${CLIENT_OUT} ${CLIENT_PKG_BUILD}"

Read-Host "Press any Key to exit..."
exit

#Below are lines of code that can be discarded after the script runs w/o issues for a while
#They are basic debugging / possible solution lines that can be quickly referenced
#Instead of researching / debugging again

#$CMDCOMMAND = "C:\Windows\System32\cmd.exe"
#cmd /c "ping google.com"
#Write-Output "${CMDCOMMAND} ${PROTOC_API_OUT}"

#cmd /c "${CMDCOMMAND} ${PROTOC_API_OUT} exit"
#Invoke-Command -ScriptBlock {$CMDCOMMAND $PROTOC_API_OUT}