# ffmpeg useful commands

## convert m3u8 to mp4

```bash
ffmpeg -i ./input.m3u8 -c copy -bsf:a aac_adtstoasc output.mp4
```
