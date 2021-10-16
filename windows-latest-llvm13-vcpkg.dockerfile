FROM ghcr.io/natecheadle/windows-latest-llvm13:latest
RUN git clone https://github.com/microsoft/vcpkg && \
    .\vcpkg\bootstrap-vcpkg.bat
