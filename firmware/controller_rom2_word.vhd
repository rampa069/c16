library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"a6c487c7",
     1 => x"c578c048",
     2 => x"48a6c487",
     3 => x"66c478c1",
     4 => x"ee49731e",
     5 => x"86c887df",
     6 => x"ef49e0c0",
     7 => x"a5c487ef",
     8 => x"f0496a4a",
     9 => x"c6f187f0",
    10 => x"c185cb87",
    11 => x"abb7c883",
    12 => x"87c7ff04",
    13 => x"264d2626",
    14 => x"264b264c",
    15 => x"4a711e4f",
    16 => x"5af2f0c2",
    17 => x"48f2f0c2",
    18 => x"fe4978c7",
    19 => x"4f2687dd",
    20 => x"711e731e",
    21 => x"aab7c04a",
    22 => x"c287d303",
    23 => x"05bfddd1",
    24 => x"4bc187c4",
    25 => x"4bc087c2",
    26 => x"5be1d1c2",
    27 => x"d1c287c4",
    28 => x"d1c25ae1",
    29 => x"c14abfdd",
    30 => x"a2c0c19a",
    31 => x"87e8ec49",
    32 => x"bfc5d1c2",
    33 => x"ddd1c249",
    34 => x"48fcb1bf",
    35 => x"e8fe7871",
    36 => x"4a711e87",
    37 => x"721e66c4",
    38 => x"87eee949",
    39 => x"1e4f2626",
    40 => x"bfddd1c2",
    41 => x"87c8e649",
    42 => x"48e6f0c2",
    43 => x"c278bfe8",
    44 => x"ec48e2f0",
    45 => x"f0c278bf",
    46 => x"494abfe6",
    47 => x"c899ffc3",
    48 => x"48722ab7",
    49 => x"f0c2b071",
    50 => x"4f2658ee",
    51 => x"5c5b5e0e",
    52 => x"4b710e5d",
    53 => x"c287c8ff",
    54 => x"c048e1f0",
    55 => x"e5497350",
    56 => x"497087ee",
    57 => x"cb9cc24c",
    58 => x"f8cd49ee",
    59 => x"4d497087",
    60 => x"97e1f0c2",
    61 => x"e2c105bf",
    62 => x"4966d087",
    63 => x"bfeaf0c2",
    64 => x"87d60599",
    65 => x"c24966d4",
    66 => x"99bfe2f0",
    67 => x"7387cb05",
    68 => x"87fce449",
    69 => x"c1029870",
    70 => x"4cc187c1",
    71 => x"7587c0fe",
    72 => x"87cdcd49",
    73 => x"c6029870",
    74 => x"e1f0c287",
    75 => x"c250c148",
    76 => x"bf97e1f0",
    77 => x"87e3c005",
    78 => x"bfeaf0c2",
    79 => x"9966d049",
    80 => x"87d6ff05",
    81 => x"bfe2f0c2",
    82 => x"9966d449",
    83 => x"87caff05",
    84 => x"fbe34973",
    85 => x"05987087",
    86 => x"7487fffe",
    87 => x"87d5fb48",
    88 => x"5c5b5e0e",
    89 => x"86f80e5d",
    90 => x"ec4c4dc0",
    91 => x"a6c47ebf",
    92 => x"eef0c248",
    93 => x"1ec078bf",
    94 => x"49f7c11e",
    95 => x"c887cdfd",
    96 => x"02987086",
    97 => x"c287f3c0",
    98 => x"05bfc5d1",
    99 => x"7ec187c4",
   100 => x"7ec087c2",
   101 => x"48c5d1c2",
   102 => x"fcca786e",
   103 => x"0266c41e",
   104 => x"a6c487c9",
   105 => x"dccfc248",
   106 => x"c487c778",
   107 => x"cfc248a6",
   108 => x"66c478e7",
   109 => x"87fbc849",
   110 => x"1ec186c4",
   111 => x"49c71ec0",
   112 => x"c887c9fc",
   113 => x"02987086",
   114 => x"49ff87cd",
   115 => x"c187c1fa",
   116 => x"fbe149da",
   117 => x"c24dc187",
   118 => x"bf97e1f0",
   119 => x"d687c302",
   120 => x"f0c287ef",
   121 => x"c24bbfe6",
   122 => x"05bfddd1",
   123 => x"c287e1c1",
   124 => x"02bfc5d1",
   125 => x"c487f0c0",
   126 => x"c0c848a6",
   127 => x"d1c278c0",
   128 => x"976e7ec9",
   129 => x"486e49bf",
   130 => x"7e7080c1",
   131 => x"87c0e171",
   132 => x"c3029870",
   133 => x"b366c487",
   134 => x"c14866c4",
   135 => x"a6c828b7",
   136 => x"05987058",
   137 => x"c387dbff",
   138 => x"e3e049fd",
   139 => x"49fac387",
   140 => x"7387dde0",
   141 => x"99ffc349",
   142 => x"49c01e71",
   143 => x"7387d2f9",
   144 => x"29b7c849",
   145 => x"49c11e71",
   146 => x"c887c6f9",
   147 => x"87c7c686",
   148 => x"bfeaf0c2",
   149 => x"df029b4b",
   150 => x"d9d1c287",
   151 => x"d0c849bf",
   152 => x"05987087",
   153 => x"c087c4c0",
   154 => x"c287d34b",
   155 => x"f4c749e0",
   156 => x"ddd1c287",
   157 => x"87c6c058",
   158 => x"48d9d1c2",
   159 => x"497378c0",
   160 => x"c00599c2",
   161 => x"ebc387cf",
   162 => x"c3dfff49",
   163 => x"c2497087",
   164 => x"c2c00299",
   165 => x"734cfb87",
   166 => x"0599c149",
   167 => x"c387cfc0",
   168 => x"deff49f4",
   169 => x"497087ea",
   170 => x"c00299c2",
   171 => x"4cfa87c2",
   172 => x"99c84973",
   173 => x"87cfc005",
   174 => x"ff49f5c3",
   175 => x"7087d1de",
   176 => x"0299c249",
   177 => x"c287d6c0",
   178 => x"02bff2f0",
   179 => x"4887cac0",
   180 => x"f0c288c1",
   181 => x"c2c058f6",
   182 => x"c14cff87",
   183 => x"c449734d",
   184 => x"cfc00599",
   185 => x"49f2c387",
   186 => x"87e4ddff",
   187 => x"99c24970",
   188 => x"87dcc002",
   189 => x"bff2f0c2",
   190 => x"b7c7487e",
   191 => x"cbc003a8",
   192 => x"c1486e87",
   193 => x"f6f0c280",
   194 => x"87c2c058",
   195 => x"4dc14cfe",
   196 => x"ff49fdc3",
   197 => x"7087f9dc",
   198 => x"0299c249",
   199 => x"c287d5c0",
   200 => x"02bff2f0",
   201 => x"c287c9c0",
   202 => x"c048f2f0",
   203 => x"87c2c078",
   204 => x"4dc14cfd",
   205 => x"ff49fac3",
   206 => x"7087d5dc",
   207 => x"0299c249",
   208 => x"c287d9c0",
   209 => x"48bff2f0",
   210 => x"03a8b7c7",
   211 => x"c287c9c0",
   212 => x"c748f2f0",
   213 => x"87c2c078",
   214 => x"4dc14cfc",
   215 => x"03acb7c0",
   216 => x"c487d5c0",
   217 => x"d8c14866",
   218 => x"6e7e7080",
   219 => x"c7c002bf",
   220 => x"4bbf6e87",
   221 => x"0f734974",
   222 => x"f0c31ec0",
   223 => x"49dac11e",
   224 => x"c887c9f5",
   225 => x"02987086",
   226 => x"c287d9c0",
   227 => x"7ebff2f0",
   228 => x"91cb496e",
   229 => x"714a66c4",
   230 => x"c0026a82",
   231 => x"4b6a87c6",
   232 => x"0f73496e",
   233 => x"c0029d75",
   234 => x"f0c287c8",
   235 => x"f049bff2",
   236 => x"d1c287f9",
   237 => x"c002bfe1",
   238 => x"c24987dd",
   239 => x"987087f3",
   240 => x"87d3c002",
   241 => x"bff2f0c2",
   242 => x"87dff049",
   243 => x"fff149c0",
   244 => x"e1d1c287",
   245 => x"f878c048",
   246 => x"87d9f18e",
   247 => x"6b796f4a",
   248 => x"20737965",
   249 => x"4a006e6f",
   250 => x"656b796f",
   251 => x"6f207379",
   252 => x"0e006666",
   253 => x"5d5c5b5e",
   254 => x"4c711e0e",
   255 => x"bfeef0c2",
   256 => x"a1cdc149",
   257 => x"81d1c14d",
   258 => x"9c747e69",
   259 => x"c487cf02",
   260 => x"7b744ba5",
   261 => x"bfeef0c2",
   262 => x"87e1f049",
   263 => x"9c747b6e",
   264 => x"c087c405",
   265 => x"c187c24b",
   266 => x"f049734b",
   267 => x"66d487e2",
   268 => x"4987c802",
   269 => x"7087eec0",
   270 => x"c087c24a",
   271 => x"e5d1c24a",
   272 => x"f0ef265a",
   273 => x"00000087",
   274 => x"11125800",
   275 => x"1c1b1d14",
   276 => x"91595a23",
   277 => x"ebf2f594",
   278 => x"000000f4",
   279 => x"00000000",
   280 => x"00000000",
   281 => x"4a711e00",
   282 => x"49bfc8ff",
   283 => x"2648a172",
   284 => x"c8ff1e4f",
   285 => x"c0fe89bf",
   286 => x"c0c0c0c0",
   287 => x"87c401a9",
   288 => x"87c24ac0",
   289 => x"48724ac1",
   290 => x"5e0e4f26",
   291 => x"0e5d5c5b",
   292 => x"d4ff4b71",
   293 => x"4866d04c",
   294 => x"49d678c0",
   295 => x"87f0d8ff",
   296 => x"6c7cffc3",
   297 => x"99ffc349",
   298 => x"c3494d71",
   299 => x"e0c199f0",
   300 => x"87cb05a9",
   301 => x"6c7cffc3",
   302 => x"d098c348",
   303 => x"c3780866",
   304 => x"4a6c7cff",
   305 => x"c331c849",
   306 => x"4a6c7cff",
   307 => x"4972b271",
   308 => x"ffc331c8",
   309 => x"714a6c7c",
   310 => x"c84972b2",
   311 => x"7cffc331",
   312 => x"b2714a6c",
   313 => x"c048d0ff",
   314 => x"9b7378e0",
   315 => x"7287c202",
   316 => x"2648757b",
   317 => x"264c264d",
   318 => x"1e4f264b",
   319 => x"5e0e4f26",
   320 => x"f80e5c5b",
   321 => x"c81e7686",
   322 => x"fdfd49a6",
   323 => x"7086c487",
   324 => x"c2486e4b",
   325 => x"c6c303a8",
   326 => x"c34a7387",
   327 => x"d0c19af0",
   328 => x"87c702aa",
   329 => x"05aae0c1",
   330 => x"7387f4c2",
   331 => x"0299c849",
   332 => x"c6ff87c3",
   333 => x"c34c7387",
   334 => x"05acc29c",
   335 => x"c487cdc1",
   336 => x"31c94966",
   337 => x"66c41e71",
   338 => x"c292d44a",
   339 => x"7249f6f0",
   340 => x"dad1fe81",
   341 => x"4966c487",
   342 => x"49e3c01e",
   343 => x"87d5d6ff",
   344 => x"d5ff49d8",
   345 => x"c0c887ea",
   346 => x"e6dfc21e",
   347 => x"eaedfd49",
   348 => x"48d0ff87",
   349 => x"c278e0c0",
   350 => x"d01ee6df",
   351 => x"92d44a66",
   352 => x"49f6f0c2",
   353 => x"cffe8172",
   354 => x"86d087e2",
   355 => x"c105acc1",
   356 => x"66c487cd",
   357 => x"7131c949",
   358 => x"4a66c41e",
   359 => x"f0c292d4",
   360 => x"817249f6",
   361 => x"87c7d0fe",
   362 => x"1ee6dfc2",
   363 => x"d44a66c8",
   364 => x"f6f0c292",
   365 => x"fe817249",
   366 => x"c887eecd",
   367 => x"c01e4966",
   368 => x"d4ff49e3",
   369 => x"49d787ef",
   370 => x"87c4d4ff",
   371 => x"c21ec0c8",
   372 => x"fd49e6df",
   373 => x"d087eeeb",
   374 => x"48d0ff86",
   375 => x"f878e0c0",
   376 => x"87d1fc8e",
   377 => x"5c5b5e0e",
   378 => x"711e0e5d",
   379 => x"4cd4ff4d",
   380 => x"487e66d4",
   381 => x"06a8b7c3",
   382 => x"48c087c5",
   383 => x"7587e2c1",
   384 => x"fbddfe49",
   385 => x"c41e7587",
   386 => x"93d44b66",
   387 => x"83f6f0c2",
   388 => x"c8fe4973",
   389 => x"83c887f7",
   390 => x"d0ff4b6b",
   391 => x"78e1c848",
   392 => x"49737cdd",
   393 => x"7199ffc3",
   394 => x"c849737c",
   395 => x"ffc329b7",
   396 => x"737c7199",
   397 => x"29b7d049",
   398 => x"7199ffc3",
   399 => x"d849737c",
   400 => x"7c7129b7",
   401 => x"7c7c7cc0",
   402 => x"7c7c7c7c",
   403 => x"7c7c7c7c",
   404 => x"78e0c07c",
   405 => x"dc1e66c4",
   406 => x"d8d2ff49",
   407 => x"7386c887",
   408 => x"cefa2648",
   409 => x"5b5e0e87",
   410 => x"1e0e5d5c",
   411 => x"d4ff7e71",
   412 => x"c21e6e4b",
   413 => x"fe49def1",
   414 => x"c487d2c7",
   415 => x"9d4d7086",
   416 => x"87c3c302",
   417 => x"bfe6f1c2",
   418 => x"fe496e4c",
   419 => x"ff87f1db",
   420 => x"c5c848d0",
   421 => x"7bd6c178",
   422 => x"7b154ac0",
   423 => x"e0c082c1",
   424 => x"f504aab7",
   425 => x"48d0ff87",
   426 => x"c5c878c4",
   427 => x"7bd3c178",
   428 => x"78c47bc1",
   429 => x"c1029c74",
   430 => x"dfc287fc",
   431 => x"c0c87ee6",
   432 => x"b7c08c4d",
   433 => x"87c603ac",
   434 => x"4da4c0c8",
   435 => x"ecc24cc0",
   436 => x"49bf97d7",
   437 => x"d20299d0",
   438 => x"c21ec087",
   439 => x"fe49def1",
   440 => x"c487c6c9",
   441 => x"4a497086",
   442 => x"c287efc0",
   443 => x"c21ee6df",
   444 => x"fe49def1",
   445 => x"c487f2c8",
   446 => x"4a497086",
   447 => x"c848d0ff",
   448 => x"d4c178c5",
   449 => x"bf976e7b",
   450 => x"c1486e7b",
   451 => x"c17e7080",
   452 => x"f0ff058d",
   453 => x"48d0ff87",
   454 => x"9a7278c4",
   455 => x"c087c505",
   456 => x"87e5c048",
   457 => x"f1c21ec1",
   458 => x"c6fe49de",
   459 => x"86c487da",
   460 => x"fe059c74",
   461 => x"d0ff87c4",
   462 => x"78c5c848",
   463 => x"c07bd3c1",
   464 => x"c178c47b",
   465 => x"c087c248",
   466 => x"4d262648",
   467 => x"4b264c26",
   468 => x"5e0e4f26",
   469 => x"710e5c5b",
   470 => x"0266cc4b",
   471 => x"c04c87d8",
   472 => x"d8028cf0",
   473 => x"c14a7487",
   474 => x"87d1028a",
   475 => x"87cd028a",
   476 => x"87c9028a",
   477 => x"497387d7",
   478 => x"d087eafb",
   479 => x"c01e7487",
   480 => x"87e0f949",
   481 => x"49731e74",
   482 => x"c887d9f9",
   483 => x"87fcfe86",
   484 => x"dec21e00",
   485 => x"c149bffa",
   486 => x"fedec2b9",
   487 => x"48d4ff59",
   488 => x"ff78ffc3",
   489 => x"e1c848d0",
   490 => x"48d4ff78",
   491 => x"31c478c1",
   492 => x"d0ff7871",
   493 => x"78e0c048",
   494 => x"00004f26",
   495 => x"00000000",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;
