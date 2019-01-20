include(${CMAKE_CURRENT_LIST_DIR}/../common/PwEnvironment.cmake)

SET(ENV{BOOST_ROOT} ${CMAKE_CURRENT_LIST_DIR}/boost/boost_1_68_0)
set(ENV{Boost_ARCHITECTURE} "-x32") # required for boost 1.66 and higher: https://gitlab.kitware.com/cmake/cmake/merge_requests/2568

set(ENV{QWT_ROOT} ${CMAKE_CURRENT_LIST_DIR}/qwt/qwt-6.1.3)
