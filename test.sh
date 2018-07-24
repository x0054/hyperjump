function oneTimeSetUp() {
    alias read="read -u0";  # to ensure we're not reading from the terminal
    source "$(dirname "$0")/hyperjump" 2>/dev/null;
    export START_DIR="$PWD";
    export TEST_DIR="$START_DIR/test";
    export JUMP_DIR="$TEST_DIR/jump_dir";
    export HYPERJUMP_DB="$TEST_DIR/.hyperjumpdb";
    rm -rf "$TEST_DIR";
}

function oneTimeTearDown() {
    unalias read;
}

function setUp() {
    COMPREPLY=(XXXXXX);  # garbage contents so it doesn't fool a test
    mkdir "$TEST_DIR";
    mkdir "$JUMP_DIR";
    echo "test_jump:$JUMP_DIR
other_jump:$TEST_DIR/other_jump_dir" > "$HYPERJUMP_DB";
    cd "$TEST_DIR";
}

function tearDown() {
    cd "$START_DIR";
    rm -rf "$TEST_DIR";
}

# Skip all asserts after this is called in zsh. Syntax errors will still trigger failures.
function skip_on_zsh() {
    if [[ -n "${ZSH_VERSION-}" ]]; then
        startSkipping;
    fi
}

function test_jj() {
    jj test_jump >/dev/null;
    assertEquals "$JUMP_DIR" "$PWD";
}

function test_jj_bad_name() {
    assertEquals "Jump Nickname isn't in the Database" "$(jj missing_jump)";
    assertEquals "$TEST_DIR" "$PWD";
}

function test_jj_autocompletion_from_empty() {
    skip_on_zsh;
    COMP_CWORD=1;
    COMP_WORDS=(jj );
    _jj;
    assertEquals "test_jump other_jump" "${COMPREPLY[*]}";
}

function test_jj_autocompletion_match() {
    skip_on_zsh;
    COMP_CWORD=1;
    COMP_WORDS=(jj te);
    _jj;
    assertEquals "test_jump" "${COMPREPLY[*]}";
}

function test_jj_autocompletion_miss() {
    skip_on_zsh;
    COMP_CWORD=1;
    COMP_WORDS=(jj xxx);
    _jj && fail "jj shouldn't be able to autocomplete \"xxx\"";
    assertEquals "" "${COMPREPLY[*]}";
}

function test_jf_by_name() {
    echo y | jf test_jump >/dev/null;
    jj test_jump >/dev/null;
    assertEquals "$TEST_DIR" "$PWD";
}

function test_jf_by_name_cancel() {
    echo n | jf test_jump >/dev/null || fail "could not cancel jf";
    jj test_jump >/dev/null;
    assertEquals "$JUMP_DIR" "$PWD";
}

function test_jf_bad_name() {
    assertEquals "This nickname is not in the database!" "$(jf test_missing)";
}

function test_jf_by_dir() {
    cd "$JUMP_DIR";
    echo y | jf >/dev/null;
    cd "$TEST_DIR";
    jj test_jump >/dev/null;
    assertEquals "$TEST_DIR" "$PWD";
}

function test_jf_by_dir_cancel() {
    cd "$JUMP_DIR";
    echo n | jf >/dev/null;
    cd "$TEST_DIR";
    jj test_jump >/dev/null;
    assertEquals "$JUMP_DIR" "$PWD";
}

function test_jf_bad_dir() {
    assertEquals "This directory is not in the database!" "$(jf)";
}

function test_jr_by_name() {
    mkdir test_jr_name_dir;
    cd test_jr_name_dir;
    echo y | jr "jr_name" >/dev/null;
    cd "$TEST_DIR";
    jj jr_name >/dev/null;
    assertEquals "$TEST_DIR/test_jr_name_dir" "$PWD";
}

function test_jr_by_dir() {
    mkdir test_jr_dir;
    cd test_jr_dir;
    echo u | jr >/dev/null;
    cd "$TEST_DIR";
    jj test_jr_dir >/dev/null;
    assertEquals "$TEST_DIR/test_jr_dir" "$PWD";
}

function test_jr_cancel() {
    mkdir test_jr_dir;
    cd test_jr_dir;
    echo c | jr >/dev/null;
    assertEquals "Jump Nickname isn't in the Database" "$(jj test_jr_dir)"
}

function test_jr_choose_name() {
    mkdir test_jr_dir;
    cd test_jr_dir;
    echo "ntest_jump_name" | jr >/dev/null;
    cd "$TEST_DIR";
    jj test_jump_name >/dev/null;
    assertEquals "$TEST_DIR/test_jr_dir" "$PWD";
}

function test_jr_already_added() {
    cd "$JUMP_DIR";
    jr_output=$(jr);
    assertEquals "This directory is already added to the database. Run 'jf' to forget it." "$jr_output"
}

function test_jr_autocompletion_from_empty() {
    skip_on_zsh;
    mkdir weird_dir_name;
    cd weird_dir_name;
    COMP_WORDS=(jr );
    COMP_CWORD=1;
    _jr;
    assertEquals "weird_dir_name" "${COMPREPLY[*]}";
}

function test_jr_autocompletion_partial_fill() {
    skip_on_zsh;
    mkdir weird_dir_name;
    cd weird_dir_name;
    COMP_WORDS=(jr weir);
    COMP_CWORD=1;
    _jr;
    assertEquals "weird_dir_name" "${COMPREPLY[*]}";
}

function test_jr_autocompletion_miss() {
    skip_on_zsh;
    mkdir weird_dir_name;
    cd weird_dir_name;
    COMP_WORDS=(jr other);
    COMP_CWORD=1;
    _jr && fail "jr can't autocomplete unless it's to the working dir";
    assertEquals "" "${COMPREPLY[*]}";
}

SHUNIT_PARENT="$0" . shunit2
