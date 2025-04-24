Return-Path: <cgroups+bounces-7796-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDCA9ACF0
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 14:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F41943A81
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74112327A7;
	Thu, 24 Apr 2025 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gzDhZ2H0"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013018.outbound.protection.outlook.com [40.107.44.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216E22C35E;
	Thu, 24 Apr 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496629; cv=fail; b=lHMmFlzrxTZO6DO1DvjvwYGUJp2aDkfI197m0NNz4vjRshHYt/bQrdnRmcdWeOUt6MiJ37CeR0E6LsgFjE94CMsmW/HQwP+Argu9ios7Pd0VcC7VvL3pXyDSHYxJibeBSmu8ZUpIbgYgo4aN+5NEh+7S7F167x0lNrHC7AOg6so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496629; c=relaxed/simple;
	bh=9Zj0Xe+qTY2mi+3frp4QttQJQh+cS7tcI92RKJylvNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeqppZQD+4A/3hcvLjjyM2yZt5pWnPD7vLUUso2jzbnRcplyBtjIjwtnSwMVPZg4u8GHttpji4E6hAQc7ogCl2h/In3V4W2eXSHoEmOLHvkjgcQGy4QY/6yc5UfHm5+uK44K8oUmli3kdb9crFMcNbbMaC/YLnKQgSJi23HiZNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gzDhZ2H0; arc=fail smtp.client-ip=40.107.44.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izK7hes6Hh6aOHX0QN85FGJGyFr4QR5uCzT5iiBWK5F1NSxER8yIeF46aHY3lwZCUR0dRAvHzRdA+wtOw2BtxNs0KPDR2634uLcye3J84tg172047hEraEr2XB8q6suBsY8QYAFlHxwcFfGBfc0Pau+qpX2SQM+Qbu9JIsEh9NpY303P9baROdWtP7S1KBFb/6Y7FygKHXbZntLPSYXWDHdXXbjGqo7XGlulUEJIefdXVsjT78IKEDaLrsQXtzz0RTWXnLoIRlecOfjsUf546J3Vnez54vhhrsAOI/K2HCA9Z5OlyhMDq/Gu93HKLPLblRQOj3SsRhEzdmZH2onT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTG9y9RUaNT3fbhnMONNS+cTgOS+hXCV2Q4q50H2Hqo=;
 b=JE1ueWoifp+V0KQvivxfTp7HXt4PEd7oc2RPgk4SAQrWTVfaL2zRSvBUMuj2EhjZ8U1kuQ51mHLvPV4mwngT5jFxHxvchn4kPIernlDUBH46vtc6LH3I3cEET4p1p0LDC++s7BmVklhOzuqPYkLvEPyfJGutdFw40UEJFv5/inMuisFdbb7dGr6iAYRutJjaLSj1AYo4Y2QuYrsC3SBp0XsX+EdVNJjQxjHAVk4xeaMwq2jNV27d2V15vQPzMq00gUG7vMtyOsZ9792MqdFI3u7I9GT2KCaQSfR9yyTXGXXJcYzO3FOQqZl+dxnMBSTQ9V+SGxLAkV/d74X2ysqdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTG9y9RUaNT3fbhnMONNS+cTgOS+hXCV2Q4q50H2Hqo=;
 b=gzDhZ2H0CZtAueysYX/g/iL60aR6qqIH1yGTE6fmX/woViid7nwgY1L+CRD8pCNZCua/Y7xd0S3QdocPUrlqHD4uzqEfc5wXGzhxCm1O3ZW5gzlcA3CzGDUQQZe5QblFIi4R6JtW21AHcib8DC91326ASK/44e/G4nJil0u8gcM2dND63VqssPnbESBhYA+M4jWiFMHpyQBeizhMfFdBwsS+veFnsuTk1gBBXSuBvlCC6GmdRluU8feXK6qKte4R7k1vLP2ZQW1+BSM+WVgkP/wupyMIt+P0VG53xtPqIu0PZBDMV5W72x1hvv/IU6zHRZEdIm8nOXRGwFHPV8xb5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6231.apcprd06.prod.outlook.com (2603:1096:101:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 12:10:22 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Thu, 24 Apr 2025
 12:10:22 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Huan Yang <link@vivo.com>,
	Francesco Valla <francesco@valla.it>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	KP Singh <kpsingh@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Raul E Rangel <rrangel@chromium.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 1/3] mm/memcg: use kmem_cache when alloc memcg
Date: Thu, 24 Apr 2025 20:09:27 +0800
Message-ID: <20250424120937.96164-2-link@vivo.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424120937.96164-1-link@vivo.com>
References: <20250424120937.96164-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: cc007d01-5a7f-441a-a0b5-08dd8328fced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/a75LKxcGjVV9m14ZISU7a65nBPJ5ItXvQzlKHyAHXK0mFMZwm0FgOlQKmn?=
 =?us-ascii?Q?4268e57/8apjJt++rpDQx/q2yOGSk8cpR6OnWPBXzkBVysGAqBBKgwhgkKAI?=
 =?us-ascii?Q?OZCimpVG/WX2/TSys/v8jfesBmB86QFNL7YgdrkE5YAZIK/a3SVy6JQl9Yye?=
 =?us-ascii?Q?ScJd0FCG8HBnsuvDEgpHlrnCaSu8cWB8wmYTPiIyT5FGJeaPNGz1CiS93e+C?=
 =?us-ascii?Q?YiWmi1yEWYeOmw1RaQCn7a5a2ubXPqQUfxjgmzSpSXkTlr1ISZRqIP3NVGIs?=
 =?us-ascii?Q?9yqEmLrsqEIS3T0JRJMjBbJg2lbMnW6tbpbYHvBqiDvfAaP8C/30uWaTNzym?=
 =?us-ascii?Q?PEj3F04itajVnKtF6rPOdfAXEkICKTeKW7jbJenOJd/eAeM2LzD3eE4Flc6D?=
 =?us-ascii?Q?8RVLZGFwxq3W8XP4wm9bu1Oem0iKA8iNE/GjTBHC6PND1/sGbEqh2vjPxF36?=
 =?us-ascii?Q?7msZh0VLSKsJsw4Z9HnkuE6XvXYdodcBOXPOODJYSkEXpTDby7wBfHbw7bX1?=
 =?us-ascii?Q?0NQ76ONv2wBN2V9Z9ecrPwlUm1syU5eAbJcL/szY+eY7LeRozqYmSff0R0JK?=
 =?us-ascii?Q?oxYIxVdH+AQwuxazI4sFO450WXOZ9/hU1y04ISnPYq0wfkLSq3WJ18Hp9IPQ?=
 =?us-ascii?Q?wJO303Tw+XqF+eskGtnwfCjbrM5wifjI+zZdbgetTks9I2VRXeR2igDumupz?=
 =?us-ascii?Q?zio0SNmrlqtZJOc2QzZ/WBBuGTfPm4Dh7PvpS00+jidVfw5WLLoMdX8yvlCP?=
 =?us-ascii?Q?SqIsglYi92RDqNoajC6xUQ7cmjcHjpzjKqzFAC9SEaST0S2//DbLmcJqn91P?=
 =?us-ascii?Q?dBy7Esp8zCG+IEPrSD0SmAqPMqf2P8HEIW01AcoWih8vQxAsv8aCsAnTPUVt?=
 =?us-ascii?Q?U8K5a7er+NCybyYWUVSCQximi3LUjac+wQ6uE8wisL4ruwlBQRfqBvvlj6rQ?=
 =?us-ascii?Q?pVlScDVFY/ud5ml3o6fSDQ5v3FLPCzA2C5cT2hN6Zj+uM1zXYBH9Rrpy5uJ5?=
 =?us-ascii?Q?A0QVhApfZHPkSMD0gejH/KDCPgvARR5QEUSxg3T3w9EP6b0pz1cRrO7hPd3f?=
 =?us-ascii?Q?EkROZfmv9/jaQeOwaS/AWKhzKfvhALcPIHNWJVBpFOlXvJN8i28khrw1JoeW?=
 =?us-ascii?Q?4fi0qV04hojod7pLuJHa6+nWdrWKYrdzqGcIGP9uJQHXRgAInVUIw7lwi9FC?=
 =?us-ascii?Q?ub4cTwExkpeXk3rhLL72vI1T1MahbwrxiiL+uLZTjFIQukYz7c6kvExxkh/C?=
 =?us-ascii?Q?/jkaziRmJOJetkrY0g6vc0UY3BC9BhwGua8uEWs1YgSKlQA/iHn/Tp7BA7q8?=
 =?us-ascii?Q?htFc9sdoto9LxDbz5c+pBlrIVZHVx4PZVqzctzydOWRHxRTGgnAOUIJ5vgaZ?=
 =?us-ascii?Q?ph6Pj20/TRGaiZKC11PQrGYlFRtZpaKM9gKh7eKIP1RZ5ygxXjzG0S9npoFP?=
 =?us-ascii?Q?PY33O3IYabfifESMxzfIQ4M8EyAbORsvQutuqndTThXZIRsm4yiw4vNljpNr?=
 =?us-ascii?Q?OcUldLhiszmUkYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MU+ElZtsldezDy0Ep5Vpy7DTc43HZrE82+5rEVp2rcqnKsmydOQ7Mo14zNmb?=
 =?us-ascii?Q?KoyndkIUZRA3tMDw0MpdNX9PagxXPVRW4toF1kb3UZpbyLRvORla2iRzNF5l?=
 =?us-ascii?Q?Xf2fYiGDhGMCSY1T/4z0zgAj2wz1p+9MbU6mVdpAIVkyiD+Bsa0fxPoDAGw3?=
 =?us-ascii?Q?Gg4JgnFiLOfKSflFaZI71+GubnU6XlehdkrUhcN7Q+lUBUYczr+WkrXHjPGY?=
 =?us-ascii?Q?dTu1PtXmaytikh6UkvtBpi4kBJs9WSaD9tbOlzcqWSKcGTEqXHB6jViY6k2/?=
 =?us-ascii?Q?BwTveShQpgsW9FpD4W+/V1pYEwco2T6pyUqGrAffPw9wQd2cqPD/ykjm2EoE?=
 =?us-ascii?Q?niKsq5DBZ48JsXY/Bs2iOO2RxnLUyUzGWNVZqppL6la54CcbFA3dRrBZfG7k?=
 =?us-ascii?Q?cvHKBXdDGgAC+ntOxz9/uvszPVzdT5bkSW8n44PCa0a/X8yYkktgfUHy7Jmp?=
 =?us-ascii?Q?KYcxzkDRPoIBw2m6KKq/VOQbGRJbQv79fbVPOSQz4+xUDjicpB9EpI37jV7R?=
 =?us-ascii?Q?PBd6YEoLSqygpoEyhACXQHOTYnK+ZUz/GDQq3//ppsqYPKlDdb52O7Jo698O?=
 =?us-ascii?Q?OP6qIXlXYZq6aONaOG4H3AIJbGhyojRQxIRcY0L8g00nLl7ivw5oWfpXZbH5?=
 =?us-ascii?Q?dr8Bx8C51VegnKKmLAwOKsqodc8g5wVxijybXU4kOwro7K8S4yjZHcCx19Eb?=
 =?us-ascii?Q?rIsCc9khq1vNmzd6jFrpQPj6pUy+KgM9GoAKe42a4pTDz3RRMVhpZGyQTkNb?=
 =?us-ascii?Q?Jv3rEPXA7WskrAtk4GU6B28RJizzY9UNW2sfeuYJ9JmHNtsvzlp+zM22aG/c?=
 =?us-ascii?Q?W2UPou3BmhR4zGNAyeP9Q7F80nHCVdiaaxjQdhm0WDHeAyVj3D16TXHplWZu?=
 =?us-ascii?Q?MGxdkGWgOfpuYqmxsnSxXQzUtuq7g/GYtgIuirI222v6NND9gBzfbkaANcnZ?=
 =?us-ascii?Q?8H8Q9HjB//jmsFuz++mK871fwdWOnFyn2NGMCz+iXW6ZEMLZnK9zUBQBX96T?=
 =?us-ascii?Q?bR5ipx1Idxy75BoM5us+TmCwsb/U2NkGdOts66DWixq/eJdRExVQWMw90Sn3?=
 =?us-ascii?Q?jwtCjINdX5uySBe1ppqsaFw05DHF30NEbsdEdyOcX1RHkzIgUeqsMyujXLLO?=
 =?us-ascii?Q?HKXwXtq9LeSuxtEpuOjSbNKeyzBN9b0aLkaXc9e8VFmNeJUCsTrPk0ztE4Xt?=
 =?us-ascii?Q?R1LrbR55sKLC+W6ULck3fIcdQlpVVsxmijotP1YcM4dt4pY29CX5mr/4927F?=
 =?us-ascii?Q?wGT7/5FZScAYfyBi1434FXRC7msohUDUifkcUqGXmxIuVT9jCqPTf8iqMmMk?=
 =?us-ascii?Q?iaK4vLWxlA2rF7Jaio/tx0cFh9VzF1yZ+iYmh/oHQIEwyqu84zi+NnT2duUI?=
 =?us-ascii?Q?t9ODTVgT62GgMDl2LfZ74E5jTb+oU9IwNyGNZXYxesyUxzOtu/2G676Z1Y50?=
 =?us-ascii?Q?3TqiRfR6iMWA5954cYEpg+PNHeZE91AIQ09vMVz/pOud3HwQqjJhBmd8ZiJu?=
 =?us-ascii?Q?tHkrVO5kk1TwGmtAhXnp6bNaZyw3gBzGWsGtqgB8UkBzvGQ4FKZFTJgrOUDT?=
 =?us-ascii?Q?WpP9M+woHSM8LWt0gr9tzjuFyY2fyVzicxQ6AYTJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc007d01-5a7f-441a-a0b5-08dd8328fced
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:10:22.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIS56IYewmdSdSNc7TlpvRRKwQ2rXHyIxaAftmeJLxbcAaV0P4TgDmXk5La+BNn5b2APKihQmxCQ8qttUajTOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6231

When tracing mem_cgroup_alloc() with kmalloc ftrace, we observe:

kmalloc: call_site=mem_cgroup_css_alloc+0xd8/0x5b4 ptr=000000003e4c3799
    bytes_req=2312 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
    accounted=false

The output indicates that while allocating mem_cgroup struct (2312 bytes),
the slab allocator actually provides 4KB chunks. This occurs because:

1. The slab allocator predefines bucket sizes from 64B to 8096B
2. The mem_cgroup allocation size (2312 bytes) falls between the 2KB and
   4KB slabs
3. The allocator rounds up to the nearest larger slab (4KB), resulting in
   ~1KB wasted memory per allocation

This patch introduces a dedicated kmem_cache for mem_cgroup structs,
achieving precise memory allocation. Post-patch ftrace verification shows:

kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0xbc/0x5d4
    ptr=00000000695c1806 bytes_req=2312 bytes_alloc=2368
    gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1 accounted=false

Each memcg alloc offer 2368 bytes(include hw cacheline align), compare to
4KB, avoid waste.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/memcontrol.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e2ea8b8a898..cb32a498e5ae 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -95,6 +95,8 @@ static bool cgroup_memory_nokmem __ro_after_init;
 /* BPF memory accounting disabled? */
 static bool cgroup_memory_nobpf __ro_after_init;

+static struct kmem_cache *memcg_cachep;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
@@ -3652,7 +3654,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	int __maybe_unused i;
 	long error;

-	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
+	memcg = likely(memcg_cachep) ?
+			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
+			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
+				GFP_KERNEL);
 	if (!memcg)
 		return ERR_PTR(-ENOMEM);

@@ -5039,6 +5044,7 @@ __setup("cgroup.memory=", cgroup_memory);
 static int __init mem_cgroup_init(void)
 {
 	int cpu;
+	unsigned int memcg_size;

 	/*
 	 * Currently s32 type (can refer to struct batched_lruvec_stat) is
@@ -5055,6 +5061,10 @@ static int __init mem_cgroup_init(void)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_stock);

+	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
+	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
+					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
+
 	return 0;
 }
 subsys_initcall(mem_cgroup_init);
--
2.48.1


