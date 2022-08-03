# tibero-docker-image
make Tibero image with Docker


## Prerequisites

- Login to Tmax [TechNet](https://technet.tmaxsoft.com/ko/front/main/main.do)
    - download Tibero6 for Linux (x86) 64-bit and rename it as “tibero.tar.gz”
    - put .tar.gz file in res/ folder
    - get license from TechNet and put license.xml file in /res/ folder
        <img width="702" alt="스크린샷 2022-08-04 오전 12 52 32" src="https://user-images.githubusercontent.com/42398891/182653146-ec4ec3a2-cd17-4704-8c71-1052c3aaa486.png">
        
- Install [Docker](https://docs.docker.com/engine/install/ubuntu/) > 18.09(BuildKit has implemented)

## How to make tibero image

```bash
$ ./make_img.sh [IMAGE_NAME]
```

## **The difference from other Tibero images is**

- All Tibero settings are finished in build time with Ubuntu image 20.04 based
    - By default, `docker build` runs temporal container for Dockerfile `From`  image which hostname is hardcoded by ‘buildkitsandbox’
    - **This constraint made it difficult to initialize by booting Tibero at build time.**
    - Because booting into Tibero requires a license check.
    - Initializing query and some settings for Tibero in build time well worth it
- How did I solved?
    - Latest docker engine supports buildKit([0.8.1](https://dailydevsblog.com/troubleshoot/resolved-how-to-check-the-default-buildkit-version-54775/)), but not up to date enough to provide HOSTNAME settings
    - So I set script to execute docker buildKit(VERSION >[1.4.2](https://github.com/moby/buildkit/releases/tag/dockerfile%2F1.4.0)) which could set HOSTNAME option in build time
    - Script parses license.xml for HOSTNAME and set it for docker buildx(buildKit)
- Purpose of this project
    - Futher more, by customizing InitAccount.sql, InitSchema.sql[TBD] you could build your own image in `docker build` time
    - without Tibero base image(only Ubuntu)
    

## Referenced

- [https://github.com/moby/buildkit/issues/1301](https://github.com/moby/buildkit/issues/1301)
- [https://forums.docker.com/t/customizing-hostname-during-docker-build-phase/13029](https://forums.docker.com/t/customizing-hostname-during-docker-build-phase/13029)
- [https://stackoverflow.com/questions/28898787/how-to-handle-specific-hostname-like-h-option-in-dockerfile](https://stackoverflow.com/questions/28898787/how-to-handle-specific-hostname-like-h-option-in-dockerfile)
- [https://stackoverflow.com/questions/45443510/passing-the-hostname-to-a-docker-container-at-build](https://stackoverflow.com/questions/45443510/passing-the-hostname-to-a-docker-container-at-build)
- [https://docs.docker.com/build/buildx/](https://docs.docker.com/build/buildx/)
- [https://docs.docker.com/engine/reference/builder/](https://docs.docker.com/engine/reference/builder/)
- [https://docs.docker.com/engine/reference/commandline/buildx_build/](https://docs.docker.com/engine/reference/commandline/buildx_build/)
