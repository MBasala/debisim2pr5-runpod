# DEBISim2p5 - RunPod Serverless

RunPod serverless deployment for the [DEBISim2p5](https://github.com/avm-debatr/debisim2) dual-energy CT baggage simulation pipeline.

## Architecture

This repo contains only the RunPod serverless wrapper. The simulation code lives in the base Docker image `fly0ut/debisim2p5:cuda12.6`.

```
fly0ut/debisim2p5:cuda12.6      (base: simulation pipeline + deps)
  └── fly0ut/debisim2p5-runpod   (this repo: handler.py + runpod SDK)
```

## Build & Push

```bash
docker build -t fly0ut/debisim2p5-runpod:latest .
docker push fly0ut/debisim2p5-runpod:latest
```

## API

### Input

```json
{
  "input": {
    "config": "configs/config_calibration_phantom_dect.py",
    "sim_dir": "results/simulation/",
    "num_bags": 1,
    "num_workers": 1
  }
}
```

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `config` | string | `configs/config_calibration_phantom_dect.py` | Config file path |
| `sim_dir` | string | `results/simulation/` | Output directory |
| `num_bags` | int | `1` | Number of bags to simulate |
| `num_workers` | int | `1` | Parallel worker count |

### Output (streamed)

The handler yields two messages:

1. **started** — GPU info and job parameters
2. **completed** — elapsed time and output paths

## Available Configs

| Config | Description |
|--------|-------------|
| `config_calibration_phantom_dect.py` | 5x5 material calibration phantom |
| `config_default_parallelbeam_3d_dect.py` | Full baggage simulation with STL objects |

## Requirements

- RunPod GPU endpoint (Ampere or Ada, 24+ GB VRAM recommended)
- CUDA 12.x driver on host
