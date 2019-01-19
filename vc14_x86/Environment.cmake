include(${CMAKE_CURRENT_LIST_DIR}/../common/Environment.cmake)

SET(ENV{BOOST_ROOT} ${CMAKE_CURRENT_LIST_DIR}/boost/boost_1_63_0)

set(ENV{GTEST_ROOT} ${CMAKE_CURRENT_LIST_DIR}/googletest/googletest-release-1.8.0/googletest)
set(ENV{GMOCK_ROOT} ${CMAKE_CURRENT_LIST_DIR}/googletest/googletest-release-1.8.0/googlemock)

set(ENV{OMNIORB4_DIR} ${CMAKE_CURRENT_LIST_DIR}/omniORB/omniORB_branch_4_2_6346)
SET(ENV{ACE_ROOT} ${CMAKE_CURRENT_LIST_DIR}/tao/6.4.1)
SET(ENV{TAO_ROOT} ${CMAKE_CURRENT_LIST_DIR}/tao/6.4.1/TAO)

set(ENV{LOG4CXX_ROOT} ${CMAKE_CURRENT_LIST_DIR}/log4cxx/log4cxx-0.10.0)
set(ENV{LOG4CPLUS_ROOT} ${CMAKE_CURRENT_LIST_DIR}/log4cplus/log4cplus-1.2.0)

set(ENV{QWT_ROOT} ${CMAKE_CURRENT_LIST_DIR}/qwt/qwt-6.1.3
