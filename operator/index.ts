function main() {
  // Print current timestamp every second
  setInterval(() => {
    const currentTimestamp = new Date().toISOString();
    console.log(`현재 타임스탬프: ${currentTimestamp}`);
  }, 1000);
}

main();
