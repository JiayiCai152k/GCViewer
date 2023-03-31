import subprocess

# Build the Docker image
subprocess.run(["docker", "build", ".", "-t", "gcv"])

# Run the Docker container in detached mode
run_command = subprocess.run(["docker", "run", "-d", "gcv"], stdout=subprocess.PIPE)
container_id = run_command.stdout.decode().strip()

# Copy the jar file from the container to the host machine
subprocess.run(["docker", "cp", f"{container_id}:/usr/local/lib/gcviewer-1.37-SNAPSHOT.jar", "."])

# Start the gcviewer
subprocess.run(["java", "-jar", "gcviewer-1.37-SNAPSHOT.jar"])