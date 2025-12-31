# WorkingHours #

Compute the number of working hours in a given period. There are 8 working hours per day, Monday to Friday, with no allowance made for holidays.

Both CLI and CGI versions are provided.

## CLI Usage ##

```
Usage: WorkingHours [-s|--start DATE] [-e|--end DATE]

Available options:
  -h,--help                Show this help text
  -s,--start DATE          The start of the period (default: 2026-01-01)
  -e,--end DATE            The end of the period (default: 2026-01-16)
```

The default dates are the start of the current year and today. The starting and ending days are included in the total.

## CGI Usage ##

Parameters:

| Name  | Value | Default |
| ----- |:----- |:------- |
| start | The start of the period | The start of the current year |
| end   | The end of the period   | Today |

The starting and ending days are included in the total.

## Installation ##

Run `cabal install` or `nix profile add`.
