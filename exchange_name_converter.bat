@echo off
setlocal enabledelayedexpansion

:: Check if a file was passed as an argument
if "%~1"=="" (
    echo No file provided. Please drag and drop a CSV file onto this script.
    pause
    exit /b
)

:: Set the input file (dragged file) and output file
set input_file=%~1
set output_file=output.csv

:: Create or clear the output file
:: Create/overwrite the output file without the first empty line
> "%output_file%" (

    :: Flag to check if it's the first row (header)
    set firstRow=true

	:: Read the CSV file line by line
	for /f "tokens=1,* delims=," %%a in (%input_file%) do (
        if !firstRow! == true (
            :: Copy the first row (header) directly to the output file
            echo %%a
            set firstRow=false
        ) else (
             :: Modify the first column if it matches certain values
            for /f "tokens=1,* delims=," %%i in ("%%a") do (
                if "%%a"=="New York Stock Exchange Inc." (
                    echo NYSE, %%b
                ) else (
                    echo %%a,%%b
                )
            )
        )
	)
)

echo Process complete. Output written to %output_file%.
endlocal