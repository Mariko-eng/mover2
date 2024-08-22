module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module",
  },
  ignorePatterns: [
    "/lib/**/*", // Ignore built files.
  ],
  plugins: [
    "@typescript-eslint",
    "import",
  ],
  rules: {
    "quotes": "off",
    // "quotes": ["error", "double"],
    "import/no-unresolved": 0,
    "object-curly-spacing": "off",
    "indent" : "off",
    "no-unused-vars": "off",
    "@typescript-eslint/no-unused-vars": "warn",
    "@typescript-eslint/no-var-requires": "off",
    'max-len': 'off',
    'prefer-const': 'off',
    'key-spacing': 'off',
    'eol-last': 'off',
    'new-cap': 'off',
    'spaced-comment': 'off',
    'padded-blocks': 'off',
  },
};