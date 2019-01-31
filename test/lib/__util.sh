__ok() {
  echo -e " \e[32mOK\e[0m"
}

__fail() {
  __exit_code=1
  echo -e " \e[31mFAIL\e[0m"
}
