*** Settings ***
Documentation    Fizzbuzz kata
Library    BuiltIn

*** Test Cases ***

Print Fizzbuzz
    [Documentation]    Print the numbers 1-100 in the log.html file, replacing 
    ...                all numbers that are divisible by 3 with "fizz", 5 with 
    ...                "buzz", and if divisible by both "fizzbuzz".

    Fizzbuzz

*** Keywords ***

Fizzbuzz
    FOR    ${number}    IN RANGE    1    101
        ${divisible_by_3}=    Is Mod Zero    ${number}    3
        ${divisible_by_5}=    Is Mod Zero    ${number}    5
        ${divisible_by_15}=   Is Mod Zero    ${number}   15
        Run keyword if    ${divisible_by_15}    Log to Console    FIZZBUZZ
        ...    ELSE IF    ${divisible_by_3}     Log to Console    FIZZ
        ...    ELSE IF    ${divisible_by_5}     Log to Console    BUZZ
        ...    ELSE    Log to Console    ${number}
    END

Is Mod Zero
    [Documentation]    Returns whether the modulus of two numbers is zero.
    [Arguments]        ${dividend}    ${divisor}
    [Return]           ${is_modulus_zero}
    # Go-go gadget Python!
    ${is_modulus_zero}=    Evaluate    divmod(${dividend},${divisor})[1] == 0