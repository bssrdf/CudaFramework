#The name of the project
PROJECT(RunAll)

message(STATUS "==============================Project: ${PROJECT_NAME} ==================================")
include(PrintListMacro)

#The CMake Minimum version that is required. The FindCUDA script
#is distributed since version 2.8
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

#include directories
set(INCLUDE_DIRS
        #${PROJECT_SOURCE_DIR}/inc
        ${COMMON_INCLUDE_DIR}
        ${EIGEN_INCLUDE_DIR}
        ${Boost_INCLUDE_DIR}

        ${ContactIterationKernel_INCLUDE_DIR}
        ${ConvergenceCheckKernel_INCLUDE_DIR}
        ${JORProxVelKernel_INCLUDE_DIR}
        ${ReductionKernel_INCLUDE_DIR}
        ${ContactInitKernel_INCLUDE_DIR}
        ${BodyInitKernel_INCLUDE_DIR}
        ${JORProxVelCommon_INCLUDE_DIRS}
)

include_directories(${INCLUDE_DIRS})
PRINTLIST("Include Directories are:" "${INCLUDE_DIRS}")


#src directories
set(SOURCE_FILES
      ${COMMON_FILES_SRC}
      ${PROJECT_SOURCE_DIR}/src/main.cpp

      ${ConvergenceCheckKernel_SRC}
      ${ContactIterationKernel_SRC}
      ${ConvergenceCheckKernel_SRC}
      ${JORProxVelKernel_SRC}
      ${ReductionKernel_SRC}
      ${ContactInitKernel_SRC}
      ${BodyInitKernel_SRC}


)

#src directories
set(INCLUDE_FILES
      ${COMMON_FILES_INC}
      ${ConvergenceCheckKernel_INC}
      ${ContactIterationKernel_INC}
      ${ConvergenceCheckKernel_INC}
      ${JORProxVelKernel_INC}
      ${ReductionKernel_INC}
      ${ContactInitKernel_INC}
      ${BodyInitKernel_INC}


)

PRINTLIST("Source Files:" "${SOURCE_FILES}")


#link directories
set(LINK_DIRS ${Boost_LIBRARY_DIRS})
link_directories(${LINK_DIRS})
PRINTLIST("Link directories are:" "${LINK_DIRS}")

set(LINKED_LIBS  ${Boost_LIBRARIES})
PRINTLIST("Linked libraries are:" "${LINKED_LIBS}")

#Adding src directory to the project
#The rule to build the executable program
CUDA_ADD_EXECUTABLE(${PROJECT_NAME} ${SOURCE_FILES} ${INCLUDE_FILES} )
target_link_libraries(${PROJECT_NAME}  ${LINKED_LIBS})

message(STATUS "=========================================================================")
