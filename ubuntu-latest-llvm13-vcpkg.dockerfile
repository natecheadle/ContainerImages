FROM ghcr.io/natecheadle/ubuntu-latest-llvm13:latest
RUN git clone https://github.com/microsoft/vcpkg && \
    ./vcpkg/bootstrap-vcpkg.sh

CMD [ "powershell" ]