# build number auto-generator
set(BUILD_NUM_GENERATE_SRCS ${PROJECT_SOURCE_DIR}/_build_number/generate.c)
set(BUILD_NUM_GENERATE_OUTPUT ${PROJECT_BINARY_DIR}/generate)
set(BUILD_NUM_VERSION_OUTPUT ${PROJECT_SOURCE_DIR}/src/version.h)
set(BUILD_NUM_VERSION_MAJOR 0)
set(BUILD_NUM_VERSION_MINOR 1)
set(BUILD_NUM_VERSION_PATCH 0)
set(BUILD_NUM_VERSION_META "-alpha")

# Create command to compile the generate command
add_custom_command(
        OUTPUT ${BUILD_NUM_GENERATE_OUTPUT}
        COMMAND gcc -o ${BUILD_NUM_GENERATE_OUTPUT} ${BUILD_NUM_GENERATE_SRCS}
        DEPENDS ${BUILD_NUM_GENERATE_SRCS}
)

string(TOUPPER "${CMAKE_PROJECT_NAME}" UPPER_PROJECT_NAME)
add_custom_target(generate_version
        COMMAND ${BUILD_NUM_GENERATE_OUTPUT}
        -P ${UPPER_PROJECT_NAME}
        -M ${BUILD_NUM_VERSION_MAJOR}
        -m ${BUILD_NUM_VERSION_MINOR}
        -p ${BUILD_NUM_VERSION_PATCH}
        -a "${BUILD_NUM_VERSION_META}"
        -F "${PROJECT_SOURCE_DIR}/buildnumber"
        -i
        > ${BUILD_NUM_VERSION_OUTPUT}
        DEPENDS ${BUILD_NUM_GENERATE_OUTPUT}
        VERBATIM
        )

