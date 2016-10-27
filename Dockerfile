FROM ubuntu:trusty

RUN echo "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.5 main" >> /etc/apt/sources.list

RUN echo "Package: *\nPin: release n=llvm-toolchain-trusty-3.5\nPin-Priority: 500" >> /etc/apt/preferences.d/llvm

RUN apt-get update && apt-get install -y --force-yes llvm-3.5

RUN apt-get install -y vim\
		libedit-dev\
		libboost-all-dev\
		gcc\
		g++\
		bison\
		cmake\
		flex\
		libyaml-cpp-dev\
		git

RUN git clone https://github.com/gibix/monicelli.git /opt/monicelli && mkdir /opt/monicelli/build

RUN sed -i '/set(LLVM_CMAKE_DIR "\/usr\/lib\/llvm-3.5\/share\/llvm\/cmake")/c\set(LLVM_CMAKE_DIR "\/usr\/share\/llvm-3.5\/cmake")' /usr/share/llvm-3.5/cmake/LLVMConfig.cmake

WORKDIR /opt/monicelli/build

RUN cmake ..
RUN make
