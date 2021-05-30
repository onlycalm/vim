cmake_minimum_required(VERSION 3.14)

set(CMAKE_SYSTEM_NAME Linux)

SET (CMAKE_C_COMPILER "/usr/bin/clang")
SET (CMAKE_CXX_COMPILER "/usr/bin/clang++")

SET (CMAKE_C_FLAGS "-Wall -std=c99")
SET (CMAKE_CXX_FLAGS "-Wall")


# 1. 声明要求的cmake最低版本
#cmake_minimum_required(VERSION 3.14)

# 2. 添加c++11标准支持
#set(CMAKE_CXX_FLAGS "-std=c++11")

# 3. 声明一个cmake工程
PROJECT(rpt_main)

MESSAGE(STATUS "Project: SERVER") #打印相关消息消息

# 4. 头文件
include_directories(
${PROJECT_SOURCE_DIR}/A
${PROJECT_SOURCE_DIR}/B
)

# 5. 通过设定SRC变量，将源代码路径都给SRC，如果有多个，可以直接在后面继续添加
set(SRC
${PROJECT_SOURCE_DIR}/main.c
${PROJECT_SOURCE_DIR}/A/A.c
${PROJECT_SOURCE_DIR}/B/B.c
)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)

set(LIB_NAME rpt_main_lib)

add_library(${LIB_NAME} STATIC ${SRC})

target_link_libraries(${LIB_NAME} pthread dl)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

add_executable(${PROJECT_NAME} ${SRC})

target_link_libraries(${PROJECT_NAME} pthread dl ${LIB_NAME})

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)      #使能生成compile_command.json文件

