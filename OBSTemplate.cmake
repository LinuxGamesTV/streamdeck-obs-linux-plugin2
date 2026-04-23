cmake_minimum_required(VERSION 3.1.1 ...  4.1.1)

# We must remove this, because the requested path and file is not available 
### include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/common/bootstrap.cmake" NO_POLICY_SCOPE)

set(_name StreamDeckPlugin${PROJECT_SUFFIX} )

option(ENABLE_FRONTEND_API "Use obs-frontend-api for UI functionality" ON)
option(ENABLE_QT "Use Qt functionality" OFF)

# This part is not needed, becaus we get erros in the configuration of the Linuxbuild
### include(compilerconfig)
### include(defaults)
### include(helpers)

add_library(${CMAKE_PROJECT_NAME} MODULE)

find_package(libobs REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE OBS::libobs)

if(ENABLE_FRONTEND_API)
  find_package(obs-frontend-api REQUIRED)
  target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE OBS::obs-frontend-api)
endif()

if(ENABLE_QT)
  find_package(Qt6 COMPONENTS Widgets Core)
  target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE Qt6::Core Qt6::Widgets)
  target_compile_options(
    ${CMAKE_PROJECT_NAME}
    PRIVATE $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-quoted-include-in-framework-header -Wno-comma>
  )
  set_target_properties(
    ${CMAKE_PROJECT_NAME}
    PROPERTIES AUTOMOC ON AUTOUIC ON AUTORCC ON
  )
endif()


set(PROJECT_DEFINITIONS )
list(APPEND PROJECT_DEFINITIONS
    -DASIO_STANDALONE
    -D_WEBSOCKETPP_CPP11_STL_
)
list(APPEND PROJECT_DEFINITIONS
    -DVERSION_STR=\"${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}\"
)

target_compile_definitions(${PROJECT_NAME} PRIVATE ${PROJECT_DEFINITIONS})

# Add your custom source files here - header files are optional and only required for visibility
# e.g. in Xcode or Visual Studio

if(NOT BUILD_LOADER)
    target_sources(${CMAKE_PROJECT_NAME} PRIVATE
            "source/module.hpp"
            "source/module.cpp"
            "source/json-rpc.hpp"
            "source/json-rpc.cpp"
            "source/server.hpp"
            "source/server.cpp"
            "source/handlers/handler-system.hpp"
            "source/handlers/handler-system.cpp"
            "source/handlers/handler-obs-frontend.hpp"
            "source/handlers/handler-obs-frontend.cpp"
            "source/handlers/handler-obs-source.hpp"
            "source/handlers/handler-obs-source.cpp"
            "source/handlers/handler-obs-scene.hpp"
            "source/handlers/handler-obs-scene.cpp"
            "source/details-popup.cpp"
            "source/details-popup.hpp"
            "${PROJECT_BINARY_DIR}/generated/module.cpp"

    )

    target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
            "${PROJECT_BINARY_DIR}/generated"
            "${PROJECT_SOURCE_DIR}/source"
            "third-party/nlohmann-json/single_include/"
            "third-party/websocketpp/"
            "third-party/asio/asio/include"
    )
else()
    target_sources(${CMAKE_PROJECT_NAME} PRIVATE
        "source/loader/module.cpp"
    )
    #set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)
endif()


# Import libobs as main plugin dependency
find_package(libobs REQUIRED)
include(cmake/ObsPluginHelpers.cmake)


if(NOT BUILD_LOADER)
    # Uncomment these lines if you want to use the OBS Frontend API in your plugin
    find_package(obs-frontend-api REQUIRED)
    target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE OBS::obs-frontend-api)

    find_qt(COMPONENTS Widgets Core)
    target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE Qt::Core Qt::Widgets)
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        AUTOMOC ON
        AUTOUIC ON
        AUTORCC ON
        AUTOUIC_SEARCH_PATHS "${PROJECT_SOURCE_DIR};${PROJECT_SOURCE_DIR}/ui"
    )
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

# Configure Files
configure_file(
    "templates/config.hpp.in"
    "generated/config.hpp"
)

configure_file(
    "templates/version.hpp.in"
    "generated/version.hpp"
)
configure_file(
    "templates/module.cpp.in"
    "generated/module.cpp"
)

if(D_PLATFORM_WINDOWS) # Windows Support
    set(PROJECT_PRODUCT_NAME "${PROJECT_FULL_NAME}")
    set(PROJECT_COMPANY_NAME "${PROJECT_AUTHORS}")
    set(PROJECT_COPYRIGHT "${PROJECT_COPYRIGHT_YEARS}, ${PROJECT_AUTHORS}")
    set(PROJECT_LEGAL_TRADEMARKS_1 "")
    set(PROJECT_LEGAL_TRADEMARKS_2 "")

    configure_file(
        "templates/version.rc.in"
        "generated/version.rc"
        @ONLY
    )
endif()

# This function don't work:
### set_target_properties_plugin()
### New function:
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES OUTPUT_NAME ${_name})
