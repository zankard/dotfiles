return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
        ["neotest-golang"] = {
          go_test_args = { "-v", "-count=1", "-timeout=60s", "-short" },
        },
      },
    },
  },
}
