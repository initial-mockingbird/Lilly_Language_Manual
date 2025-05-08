default: serve

serve:
  ./build_scripts/serve_on_bg.sh &

stop-serve:
  ./build_scripts/close_serve.sh

build:
  mdbook build

clean:
  mdbook clean
  echo "" > .serve_pids

setup:
  echo "Setting up the environment..."
  chmod +x ./build_scripts/*
  echo "Environment setup complete."
