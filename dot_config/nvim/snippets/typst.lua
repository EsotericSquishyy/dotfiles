local ls = require("luasnip");
local s = ls.snippet;
local t = ls.text_node;
local i = ls.insert_node;
local c = ls.choice_node;

return {
  s("#defn", {
    t("#defn"),
    c(1, {
      {t({"[", "  "}), i(1, "/* title */"), t({"", "]"})},
      t("[]"),
    }),
    c(2, {
      {t({"[", "  "}), i(1, "/* statement */"), t({"", "]"})},
      t("[]"),
    }),
  })
}, {
  s("#ex", {
    t("#ex"),
    c(1, {
      {t("(name: ["), i(1, "/* title */"), t("])")},
      t(""),
    }),
    c(2, {
      {t({"[", "  "}), i(1, "/* statement */"), t({"", "]"})},
      t("[]"),
    }),
  })
}, {
  s("#thm", {
    t("#thm"),
    c(1, {
      {t("(name: ["), i(1, "/* title */"), t("])")},
      t(""),
    }),
    c(2, {
      {t({"[", "  "}), i(1, "/* statement */"), t({"", "]"})},
      t("[]"),
    }),
    c(3, {
      {t({"[", "  "}), i(1, "/* proof */"), t({"", "]"})},
      t("[]"),
    }),
  })
}
