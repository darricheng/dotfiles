return {
	settings = {
		tailwindCSS = {
			-- For use with the `class-variance-authority` library,
			-- makes it such that we get tailwindCSS autocomplete in
			-- the `cva` and `cx` functions.
			-- See: https://cva.style/docs/getting-started/installation#intellisense
			classFunctions = { "cva", "cx" },
		},
	},
}
