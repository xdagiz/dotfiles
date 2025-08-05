local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
	s("div", {
		t("<div>"),
		i(1),
		t("</div>"),
	}),
	s("span", {
		t("<span>"),
		i(1),
		t("</span>"),
	}),
	s("p", {
		t("<p>"),
		i(1),
		t("</p>"),
	}),
	s("a", {
		t('<a href="">'),
		i(1),
		t("</a>"),
	}),
	s("btn", {
		t("<button>"),
		i(1),
		t("</button>"),
	}),
	s("ul", {
		t("<ul>"),
		i(1),
		t("</ul>"),
	}),
	s("li", {
		t("<li>"),
		i(1),
		t("</li>"),
	}),
	s("inp", {
		t('<input type="text" />'),
	}),
	s("img", {
		t('<img src="" alt="" />'),
	}),
	s("form", {
		t("<form>"),
		i(1),
		t("</form>"),
	}),
	s("sect", {
		t("<section>"),
		i(1),
		t("</section>"),
	}),
	s("header", {
		t("<header>"),
		i(1),
		t("</header>"),
	}),
	s("footer", {
		t("<footer>"),
		i(1),
		t("</footer>"),
	}),
}
