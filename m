Return-Path: <cgroups+bounces-7798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C50A9ACF4
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980F6923B8F
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F22367A5;
	Thu, 24 Apr 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KrDa1lXh"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013018.outbound.protection.outlook.com [52.101.127.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A322F743;
	Thu, 24 Apr 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496636; cv=fail; b=dhNvEmVUkjAka8hp4wXLYqypCZOoSZ/U+0LDnJlgqhRlIlLkXnZ/JnVU6c3ZhXgF7nv5vaQRWIx8zL6k5Vb1PM66I0Z1d2SVGpVe72cTPcJrPZT7p+oz5tFkLyTEqniLl+Bz+90+pacrrbW9RXtnkUn+9V1e8FCrC28Q2zlSWrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496636; c=relaxed/simple;
	bh=2Atqiwrk1bX4lVh8KLY8Ms964TnYvnefAK9Jw3pblCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f10YV8Q04asZAUMSK2n2ZmRH2KUeER7Ei1x5TFNa2k+GIn1W/6Fk7as9hFlfpo3pzeP61blklqW7wH+TOwK/MR3E9oRiJG+MsvjZcnnxM8h6LbrPHsmmz9eodxm+H4NzSUxnRTg6hBYLJLLX5IqDaepLBpkIQrDHHdf40JM03gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KrDa1lXh; arc=fail smtp.client-ip=52.101.127.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPn6EJoPy9WJAJfrgKFkOo76StDBa+AG7rChTyxSn2CE/0pa2UcGEmF0tfb3x0avfFznfRgE/WzxEF63CHqF+pjuwBmfQ+dZf4qGxezX2qTs88ZI3MArSCSbpJp5yH7VA5Agl42wp3PrQsBZ7RkzInvNFzQWmr+0LdE1hJ4MkV87gd4hzF8taLll+BRdA1ezeTVvm0Bi52mkId/x1aAg3b+MQzHDU9e/nJubLylXfUfpyslJAQhqjotnQpLjLuQXP75UjRJnznDQl8SfTt69yfCxMQEAp5aZqx5nu7TvQN+pzdCTueVjzPq7Zvvy/5wtBgcSpCCEtFQWLcb5Tn2obQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2NULMSx/SoJwJqJ0bqSDKpg8Ei1TuQRy9P/VGZ5RyM=;
 b=QomC9Zom2WJdHD5zjPuImaDPSsed+GETSg7V67OYv+Fp2nDi0Y1GLA8zjrd1bfKZhyD6HWfgPUIXUZuJ1fhMB07UVOpqx5667Nu+jwtZZzhUvCEOhbFF7WKLuD1EtM0aE0P0J0WSy5rRdqcu2sdY0I1gl0Y8xB+E0E2BLxTdNwpKz1oIzOWJIwz8wF4VEYskBH+9xxDtfZZfoT8CHqGZM2PuDBL3r8DoqhZGjxZ1BXafbYM20IT6cQS0iME9lg9+yGNK0msgrW7tuaeLroiNaro9VoPTZm3YEEymF34UgO9El5Zku+9I0yVlkmd9NL4F+Z3iaAjl1tDGFqT9YNJOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2NULMSx/SoJwJqJ0bqSDKpg8Ei1TuQRy9P/VGZ5RyM=;
 b=KrDa1lXhFnqMVPCigcFTw3Z4tlcxlv9tA6CrAsYYPqEeHsGRn005Mhn9d4+7hDUsXNt7Uf6eXv044OHC9VXR/jHSrfkLYdiaVICcEjoHvylnj9apSanCj1DxglrDs/+uPN2e/9acUFVkkvWXJT8HQYUG+Xf4yrG7zFzXe+wpfv+yTG9Sys/k6Dyb7P5vKnqBIhkNV8lYRFuWG5h8ZHEEeomux/tsqy7UeB9vFtRcSZ1nko5dI9i9IHkgS3AyJbJ8WVBZtHR5+TuWrsgdm0DNRiFZ6oYNxIzdBiIYl2yNtJ3rXxgiymZV4ulGIJlx8Bly2bl6kb1eRIMaPs59Fnbecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6231.apcprd06.prod.outlook.com (2603:1096:101:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 12:10:32 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Thu, 24 Apr 2025
 12:10:32 +0000
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
	Paul Moore <paul@paul-moore.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 3/3] mm/memcg: introduce mem_cgroup_early_init
Date: Thu, 24 Apr 2025 20:09:29 +0800
Message-ID: <20250424120937.96164-4-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ad29a89-7353-4c8e-9825-08dd832902d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+XIJbNXm5zweKLZJUCvT1tE6yW+k6TRH7Jrm1NUiaEFAjlOGyMc+5F5nQNRA?=
 =?us-ascii?Q?7g2yE0Tu6QDXnJWK5urjVmoKyhwOe0hIP2Ytnh5M2hTgaSHp3+Kbbg56qTso?=
 =?us-ascii?Q?sDPIyzPCBTjsS5Sg8ALncY3JnC9vm25sADDFRC90pym+Z/Hn2TBwBQnWcrgW?=
 =?us-ascii?Q?VT41ZDYdDQvoFpHGokQI1Gl+dJHKa9A2Kmk75n9CQnzLyEgEIR0XXSdBcgCv?=
 =?us-ascii?Q?DYHdMo7iGZu8Y3oMOJiduI2DVtuNK6QRjyz7SfjPsMfPLp5ziW+8sJadNaoo?=
 =?us-ascii?Q?7pdaaH41jdMMCzHFDbNwDRgr6iqgfbCjUq4o5WcC56vvOWykqU/SH/Lhl3th?=
 =?us-ascii?Q?SVbxxMKKaBUQ4oxjcsauLKDjcAK5jbGyQxLQw+MJkeDRJRmaoQTHt8sLToP5?=
 =?us-ascii?Q?6mWKWi2X91VxCj5Ka0AeVf899CoSA6lR9Xs4JRkf2nG4lQEe6V8jYUnOWfmW?=
 =?us-ascii?Q?wlqDAWA7YqRNViUA9vHMI49EIrHdDay+J5SNBSZL4qDiygDnrWkSCi11MPuX?=
 =?us-ascii?Q?JptGz/5sn105B+BPDZ6G9T8rWGSf5hVAK6kB9eckX6ZNHl3HRKtSZEf1Bu1v?=
 =?us-ascii?Q?zs0/hyInke0Q9ggOcuV/PxblyHV92+aPs76RmszyzegH1Ktmnnt60JHciyuW?=
 =?us-ascii?Q?3S+LzgV0qCqL0oVor7D0XOi38NcsABt1NskkUC9ZCyhoKbibHG/w/vRe54G5?=
 =?us-ascii?Q?F/0MCzCD3FhNUQ+skFHrKKXWrhOeKZHijwDG+7mhDZoIi108SlKtV5VhBij7?=
 =?us-ascii?Q?FNbuwEm57a4BtUteorbvqKa1Hw+8OCZSi4mFB6ErXWa6KSGbtUbBJ2oZNv08?=
 =?us-ascii?Q?fdfj7sS7FJvemS0ISnXNV5UkNRdBJ1j60/B8YygHkdjHiU4ySsCtKEt87TH/?=
 =?us-ascii?Q?KH891wF94Qi5vidHURJEqKx2AKp4bZAA2t3y6AImsvlRKA91NXGCsMT1JqHR?=
 =?us-ascii?Q?0qZd7FUCa4XagjsjMVtECCEeTHSu7u6KAm+BIEFcEGPaZDrnI4xKGC8cfP7r?=
 =?us-ascii?Q?4D0pZrJIhHnOp5iwx9p27IpS41LbFtcZBq0M8BFfzhWk4wRTFHX+vibPAvyD?=
 =?us-ascii?Q?nBONoCCZJ4Wj2Vq+tAblsm276IWXhcjVB7GSaGh517tqlfoe4JbYc05MUdoZ?=
 =?us-ascii?Q?x5GLG2+kKjZYW8jNXfhCEWnDdAOmmAKtK6g0ZqyyJvQsoL//d2nG5WUFb0jJ?=
 =?us-ascii?Q?1hwAe13u53vwra+s7JoWYnnArDfYkbSx4dBHke3eYdJOc1uq3y4kdwe7XI33?=
 =?us-ascii?Q?gRkZDxd5aJpXBuM4xoY4f9QNsoLJaXZeZvzygeeYJllr6F5zJIzrAWM1TS1H?=
 =?us-ascii?Q?WioQ8cQ7/fFvULrHnrPvW2WcyiLMPleP0eQz1WAy+vcWN27uvXJrPATlbt9m?=
 =?us-ascii?Q?p5Yr+UtMzanj4pdHwYRoYPkJSgMuWAn8KwMvTgopwVWax71Im1f7ng9zvg5O?=
 =?us-ascii?Q?tRYFxdWoNagI7oXfYuYURJp0VhwJFbkbdRS9cr82iWTFBZSuGW+ovbw88072?=
 =?us-ascii?Q?cA/R045PnWbu6+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zAc5p1TMNEe6/RFe3U/The5Ny2fhDpPqDHc3q1e1DaemdcqN1tzyaWCA8x3i?=
 =?us-ascii?Q?FVchCCTonk+irmxOUbv1cmAKZ7IWemfoME3tlD9/bEoYAxf+eVyMECP80SNg?=
 =?us-ascii?Q?qUsnBIWJcMkYSziNcZQ1siG+T5FYGoc/7QfxJMG533T28CePknJj6zjYz7gy?=
 =?us-ascii?Q?3S575rQjMKfo7T9ZgWW+4WDRQgjA7BA8lobfytV5kkvs7gHK35QCob//mKJT?=
 =?us-ascii?Q?Pv49lu5YY4GoeiP/6A/cijfkNhqZj5EDaKMN6kRMKSLsiZ7LXC8Yx1/827zY?=
 =?us-ascii?Q?CAxKiNQC/2wPB+qcl0jtqXdC6/MEk+s7q25Na6nxuJv515Yhjg02LpWw5/gy?=
 =?us-ascii?Q?dJTdFllEGRwrfOl/UmBYiIjW+uMwADoCY4YdWP7DIhmmxRR0FF7i7qug4kPa?=
 =?us-ascii?Q?Zm+p7j29gB4j65clT4Nv+EfquOd2oIYmyW+3sSlhuI0LMw5ki10ZsvIYZ0Kl?=
 =?us-ascii?Q?TwLuzt8JQJT/L/EjWExKhTehXYl8DpI4eDOHbvuw9HhBRB96WCfeUw9uTe4+?=
 =?us-ascii?Q?lOUtAYAOXdqgMBSQ/+X6VPTVCpGI5rHTO6MphnyOo4GuM3RdJ70hflffrPSH?=
 =?us-ascii?Q?HYE83gAq9kB+ykcpmgpTzRIs8JTNtxdgPTpk+Mo7q0BCkTJlfUF24cTvI/xp?=
 =?us-ascii?Q?OwmxunTUO24BqY9FpZmuHfVepw+z+VD2z/I96/EKgA9l68dssMJPBtit5xvK?=
 =?us-ascii?Q?wIIaV2MolOkx2Al+f5cq0U3MMx2jWxX3P6XOWeuRUOT2p9biPpnXd5HX5F1o?=
 =?us-ascii?Q?spcEnRmWusZHgBmboLtDY5SJTc/CYO2ypNq/aVhfZEeo6LuwbFD//IF7/ZID?=
 =?us-ascii?Q?a3uYMtUekITFo89SYCA67E6R/gV84h2KshgVYw2jJxW/4rSPAzOxMldO7+gr?=
 =?us-ascii?Q?XZxEjPnJUV3dxrne8FP++rcFDwltMK5F/lo/998zWs66pFATPEhIrWUqaZuQ?=
 =?us-ascii?Q?qQCfDoDQnLwkp9I7WLIjYTtN6fy8OqigvdH5ynnJM6ryZmuexj73LXOQ8rhF?=
 =?us-ascii?Q?friq80Un4l2XzPz9MN2YRKKEwhsNis2p9MEIGSs1fzoRTn9O4MIzFaRboUmK?=
 =?us-ascii?Q?TfReeEyTXYRAiztmnHBjvJIRCQcUV+cTjMSUECIUxZvfXstCJfzaUeQhJ7hW?=
 =?us-ascii?Q?UywlvyhMMZzMPMeQ2r2S3xZwB7tZVLWEYX4eN0Aq+5XJ6Fw/i3konKNdUwph?=
 =?us-ascii?Q?iWtllCCXaomATFWaOJT7o9r4EPbHlmv/KOnJjcUo7U0cfh+GUXY4bq6Z5wav?=
 =?us-ascii?Q?pfcTMyoEOU+34LQRCRp78AbSReMzKHrXji0Mhsa/mBVuDKa0EBf+Btf50eBN?=
 =?us-ascii?Q?7KIkFB7KB2V4p+8D9EflfS5ytxX+JGzc4yKa6eqpGL0s50fOCIKjeivFbNU7?=
 =?us-ascii?Q?tirVoHAw6kdldOxKSsrypGaNLQK9qhpKPLNRSWW76Czvcy8AN024FOa69WF2?=
 =?us-ascii?Q?fNbM34iBHtg2LmQ9szRzBtQvzLIOrbmb82HscqSKJ2fUI8Y3oRT0HwkNmInA?=
 =?us-ascii?Q?gppDeABy/3hLhUX6sZFBVs5R8U2zmBipDkl2/+wFBa+7w7P2WNULtjis7xmF?=
 =?us-ascii?Q?pkxaKEzNNa5xItLT24NDf0bpdHooF8uWNXV8GZzQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad29a89-7353-4c8e-9825-08dd832902d3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:10:32.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxLRpAxweoBQXOjqvcQnFBgKTugr15P7Jz6WdT5xJ/00b5CNKeo0s4nfwC4/gSmnyZzFmCWf4OMzGf3/CmN0NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6231

When cgroup_init() creates root_mem_cgroup through css_online callback,
some critical resources might not be fully initialized, forcing later
operations to perform conditional checks for resource availability.

This patch introduces mem_cgroup_early_init() to address the init order,
it invoke before cgroup_init, so, compare mem_cgroup_init which invoked
by initcall, mem_cgroup_early_init can use to prepare some key resources
before root_mem_cgroup alloc.

Signed-off-by: Huan Yang <link@vivo.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h |  5 +++++
 init/main.c                |  2 ++
 mm/memcontrol.c            | 40 +++++++++++++++++++++++---------------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5264d148bdd9..231f3c577294 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1057,6 +1057,7 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 	return id;
 }
 
+extern void mem_cgroup_early_init(void);
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1472,6 +1473,10 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 {
 	return 0;
 }
+
+static inline void mem_cgroup_early_init(void)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 /*
diff --git a/init/main.c b/init/main.c
index 6b14e6116a1f..fd59d5ba2dc7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -50,6 +50,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
+#include <linux/memcontrol.h>
 #include <linux/cgroup.h>
 #include <linux/efi.h>
 #include <linux/tick.h>
@@ -1087,6 +1088,7 @@ void start_kernel(void)
 	nsfs_init();
 	pidfs_init();
 	cpuset_init();
+	mem_cgroup_early_init();
 	cgroup_init();
 	taskstats_init_early();
 	delayacct_init();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8797382aeb4..bef1be3aad6f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3602,10 +3602,8 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
-	pn = likely(memcg_pn_cachep) ?
-		     kmem_cache_alloc_node(memcg_pn_cachep,
-					   GFP_KERNEL | __GFP_ZERO, node) :
-		     kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = kmem_cache_alloc_node(memcg_pn_cachep, GFP_KERNEL | __GFP_ZERO,
+				   node);
 	if (!pn)
 		return false;
 
@@ -3658,10 +3656,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	int __maybe_unused i;
 	long error;
 
-	memcg = likely(memcg_cachep) ?
-			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
-			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
-				GFP_KERNEL);
+	memcg = kmem_cache_zalloc(memcg_cachep, GFP_KERNEL);
 	if (!memcg)
 		return ERR_PTR(-ENOMEM);
 
@@ -5037,6 +5032,27 @@ static int __init cgroup_memory(char *s)
 }
 __setup("cgroup.memory=", cgroup_memory);
 
+/**
+ * Before cgroup_init() create root_mem_cgroup, we can prepare
+ * something in here which root_mem_cgroup may need.
+ * This currently initializes:
+ *   1) memcg_cachep  - kmem_cache for mem_cgroup struct allocations
+ *   2) memcg_pn_cachep - kmem_cache for mem_cgroup_per_node structs
+ *      (one per NUMA node)
+ */
+void __init mem_cgroup_early_init(void)
+{
+	struct mem_cgroup *memcg;
+	unsigned int memcg_size;
+
+	memcg_size = struct_size(memcg, nodeinfo, nr_node_ids);
+	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
+					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
+
+	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
+				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
+}
+
 /*
  * subsys_initcall() for memory controller.
  *
@@ -5048,7 +5064,6 @@ __setup("cgroup.memory=", cgroup_memory);
 static int __init mem_cgroup_init(void)
 {
 	int cpu;
-	unsigned int memcg_size;
 
 	/*
 	 * Currently s32 type (can refer to struct batched_lruvec_stat) is
@@ -5065,13 +5080,6 @@ static int __init mem_cgroup_init(void)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_stock);
 
-	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
-	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
-					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
-
-	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
-				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
-
 	return 0;
 }
 subsys_initcall(mem_cgroup_init);
-- 
2.48.1


