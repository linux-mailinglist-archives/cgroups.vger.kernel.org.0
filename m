Return-Path: <cgroups+bounces-7745-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA1A983FC
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 10:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B411D3A9FB1
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCF721CC68;
	Wed, 23 Apr 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="erW4+cav"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011038.outbound.protection.outlook.com [52.101.129.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3A1DE4E6;
	Wed, 23 Apr 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397871; cv=fail; b=ZxAFkEe+4M5Ak+k7BH5gq1Lxix4R/SHTIuZmouZvJAQfRQj3y2GMCNqhGOdQK83R0sp2IIa5fL9yPK+b+Q4E+q4MM39HNSU3JTQXCn0WgY2CAvhGNt1Ju+ayU175vJb+n/tZL3lfTiI1pTBZ1kiRQigtfslRWOAET2vIxxR3AbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397871; c=relaxed/simple;
	bh=TOkKqfpzzgxAq3dt2VNlCsM7z8hF8n+29cvxrlJZ3Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANpB4919fjL4U2WooD/jYFt/nsvibvssEjSBQcNCOn2ylQoR5rtfaBYNq8QJ2yAAT1b9VHxyPRsVhsm1T3vQeweCihkvlkSiJCvDtskAFzfQ05j3LdWaHwVsFhxAe6+SbcB1Kg8UgsiLJ7gc29geO5b5myi9Tb29S+H0R4cKP4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=erW4+cav; arc=fail smtp.client-ip=52.101.129.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSeLEIzXTVHbGPQw+hNGZu2+HR9KJrHSF4/obIyJF5aZlW2XE0tr9YIw+/oSYq/iUF4brAUoakgl3+aOQOcHh1qV+NvPvZSdsMfgYKYaNOk5xhGBb+1WHyTB2yQ+VY1cgvkKM6w/xgzwrG7dL+Gpt3GLle0FHq2uDbF2Lmfkhpi5Bdtvi3k1vD3sdboAYAYJ8VIHU8Rz4duv+i3oznTRandDZyCO5isw9H0RnxuJT96mxCwx+LM3QKlwfKnzTSCdUE7BxqbvlW6Nxubj80WB+oiLHg4Ob2OeScQ87Fpd+cNRfCHLnebHNL1KQ5ToP2MrztLk5qmSGJoz51xmCfEOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuyvaVqxm3m2Doy7IqRZiX1HwlxJeyBYElsaTp41uzY=;
 b=uXQv3yfxFGmfyrL68s8Lj076Cecsrym+d/NtmY21IHIpbALb2NuqXdZre9VhZ6BJtcFrVht2worNYsJxj8QWTDqs0b7oY3Ztodg/0l7DTrEqjkGr4yKMa3Ng29y3SXz5KvKk6K151E7XM+lbZ7pTWmUADQxrKS0cx1c1a3mjVQp7Tww9XsUvU1r1sLXx3SSbL3S+HlWgPRz9KwmjiR/NSes3ftGev8nwfEucSU8hYVFcoVaPWBgZbklwkK3B2DSY5c36og6eSIWY7ANrS6e7DP/Oy2lLj1FAki/gbboKsgllgEjF7o7JR1uXXDETA7V+Wqt/3CS8U2wzJx5o2BVyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuyvaVqxm3m2Doy7IqRZiX1HwlxJeyBYElsaTp41uzY=;
 b=erW4+cavqQgFh6IA+rKBRMGejnimoHpx0Dp4Zr+ii82weFZO+9kvhq+e/44DIpEF7c/8CQAFcxm76AGDXRIo9fh+xLrfhZSbg0NhHCU663Wnn6vdi6vC8cTeUFJkstzS4+wkIGQcabZMVATFrx51mTlPZOERT5ufymWQesbciUXh6X+3aWC/JJ7/Nd/sJ7jxs0gskon7HUtNpcUIQyGzCKGO72soKAWGgSr34GBZd0rQqDC/bA3rcntY2FuEigtDFhFI6JDLncsjDKDJuL32niYmypzLZOfY7yN4DDMe86VO8lWqKWqp9ko0STCRLsm6RSL96BqgpVmkjPF+0fQ7XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB7275.apcprd06.prod.outlook.com (2603:1096:405:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 08:44:24 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Wed, 23 Apr 2025
 08:44:24 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH 1/2] mm/memcg: use kmem_cache when alloc memcg
Date: Wed, 23 Apr 2025 16:43:04 +0800
Message-ID: <20250423084306.65706-2-link@vivo.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423084306.65706-1-link@vivo.com>
References: <20250423084306.65706-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: e35f5369-f3c2-4276-09f1-08dd82430c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+QLwmGoWcui5mzmDC6uuEp9B6Wg+K0dVemVYErWpJK6LUrdy1ySjncXcu8h4?=
 =?us-ascii?Q?XcdjvFsbhgEeXgAk5QPhtzreRK6T2pfT0DU6R6p7iXOb5FYKvl5OI+SCmGhk?=
 =?us-ascii?Q?uOq4Ho3ZGcfFNj7dGoWMlIqsMTpuZ5+HvFYpueieiD7tzznMt6sR7Kfg5PbY?=
 =?us-ascii?Q?m+Ok3ev0W3+4QsFIL8zMV+2C1/tgmSpwunLjkWSy4ddHok8RROul3TWsL8pq?=
 =?us-ascii?Q?JCFNonI2OJbna6UM2hOaiKM+qtHSzZVqwxRtmdCZ6IwAWdLDr2dby5O8da1M?=
 =?us-ascii?Q?Itfg9q+UgLBYfhImCj4BOW6u9wh1J27SyQiiP48jYOI1/WyXWoYW3CCk/t3l?=
 =?us-ascii?Q?6gu2+itcG+09kh6s9G7VCvXVq2Mz4fcFqpFXjyO24nVcZnFOc2DbtW7dcxXf?=
 =?us-ascii?Q?ZPT0F0mT9VIqepprAlCpRaxC1b+Jm/FZ/bxFlBohp2GuqL5237esqox3akWi?=
 =?us-ascii?Q?ggy0Iozc7KNwmf1BRjrHWaTPCnjLrlX2m2t9j4yWout9dz6R/mH8vD7PV2Y4?=
 =?us-ascii?Q?LplaprEJZYutVy2q7h4fyQuCE2vFUAG/a15r1mfT4EDUptXORIIr5nZRgkNX?=
 =?us-ascii?Q?6Ps+D9PavbotD+Iu/ynspOzNuj7PSQlJv5Cr/26jF8sVNNEGvIvTyUs7IIHO?=
 =?us-ascii?Q?/TNoGXE7DmmEk4htm08kEF5KceIq9ZhSe9+GmJQnYPxwHvjDwBnL8OZ93HF+?=
 =?us-ascii?Q?vEugMtaPawSKVhgNXrTlkxF7JZXVlyk55SxVw2aOP4nzR9lhMiql10FC++L0?=
 =?us-ascii?Q?C9d+Nf5NW2ASr2/8WB255OAxzyi64yN7N/HUCForICb0KHuRwlfwsyZEEO4f?=
 =?us-ascii?Q?QACOKsym/vBK5nznspCZF/Z20hDKSjPJI31yNqJNL5mwjFLTqlV3itRPsf09?=
 =?us-ascii?Q?tRYJ229hPObfFzLbL6zxqtEQm8e+8B8rXzs5nF4DVCmmAE5A9lj2ee4ntCFj?=
 =?us-ascii?Q?fJTQhOAmd1Z7d6cywO/RNIGVPcaHwE9ojDjjFOxWZmyRK2jrJp2EiYOEX+0r?=
 =?us-ascii?Q?4sRCBWAR1P02jYbVP+FS7xSkVpkilVg/OOMiyADZ0rsE4QcqOqn3bqGC1YI1?=
 =?us-ascii?Q?87nvl3xzljBm5hebBZC7UMdpwA9xUlR/VuMXuOG7sugB9Ksx3MvAINmEJwci?=
 =?us-ascii?Q?1J5ovOqJW3IiEbO46/hqQojUiPTie30WCtgYigzRcxkhvMcf1CQMWTNF6s+g?=
 =?us-ascii?Q?AkIJ71e4DcI5Qp2V4bAFdnIPYyMLY2+G3D72Vh5yznMyRSTRI7O9Jzmx4bJY?=
 =?us-ascii?Q?77x+uJ9VB4gVPmfrPFs6UOVWQe/pyw0/raEOoGscaEGz+kqj3SRRO411OeKg?=
 =?us-ascii?Q?HB7TplAAPEevPJ4L9kzVbzUyOBj312Go24JIcj7rvrT3GF9iMlC3Taur/mGh?=
 =?us-ascii?Q?dqXlcZzdZSnIIhVfSPFdAySKkMGrmDKPYNST9MFU/AmTA8+LjYfcKWq479y8?=
 =?us-ascii?Q?aZ9+JsvA/sOyc9uaGdqmpRfX2u6LPwNlKa/3S7CkifG191z36+T1Ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9+WLdH9zUvqZSI3VRW9sdekWL4IWYZJTW6XnO8/0qOZoGOssI9t7lZb0sp3V?=
 =?us-ascii?Q?zhGPe+x0JdCA4petK08woPYXvnJu+fsMEN0T5i9zUczde+TrWCch1fuRf2vW?=
 =?us-ascii?Q?BZAY449ZJP4RSNuKwRuU/P9nQOeJnEP1i0g+/iwZ/IeE3OyjQWF7+3nlkOLk?=
 =?us-ascii?Q?AHeEvaJDkR4Rr5aRMJAxLmFh3ZbZrA8S5rcxh56a7487hUtqOG99Qr3MD0YL?=
 =?us-ascii?Q?ujbOnroyE3oYQn89GwEdb0G9SH+0kFNtUSe2hh4WJR3bl5xOxhP1laiFfM5j?=
 =?us-ascii?Q?MX9WUPMSEm8mOR73mwP4CD9oTxJSEYWH6XYW+2gXssTd/GCDdjYIz6EoGcWR?=
 =?us-ascii?Q?su2d62QZ+ImE56Se2Uv8/UES8Uagc10M4tEvjTIya8Ne4jSohr6Xk+3IDiJY?=
 =?us-ascii?Q?rT2IcKW/dbZ697N0flBlEHBV8Dv8bLDhCHOpXrvfULc7zRbqOc/iHuKgfDU0?=
 =?us-ascii?Q?1SAtH3kiE0RidLQKTS1H8sp1CmlGdgzuCCXh8UYh8lkKTxfTDtGpN+5FNnv7?=
 =?us-ascii?Q?BsLEmMDRUgtnKP0PxF4FjSmUkGSZVi9+k/iyfywgFMMTmk4dHZd1ZJPGO/pc?=
 =?us-ascii?Q?RwwygJdL+gBOpIuwuqhruQBfx6KvUgLMHTwSiqPBieZIPaO2PmITBAS/fOxV?=
 =?us-ascii?Q?gsWyrQSyzaYQpIKwzFUX02YpnjUWMmtmNRLmsacthZxCyWkJOzdkBeT3/4sf?=
 =?us-ascii?Q?NHA+4HMAhDEczn7DrzcAwojJLrzqJKOvfxzKJJnCLsduOPYO6GfvI4jDoTbS?=
 =?us-ascii?Q?mJXl9dSbuvo/EpA+WT06fbdD4ci0onxNikE02Aq4Fot2td4C2fuG+ap0W0XE?=
 =?us-ascii?Q?fphdGhK1kdyKqmRsbFMNtSWZeYe+aLIdxQ6k73lxf9JgdAbETVgWMPCrLjym?=
 =?us-ascii?Q?k6z4YOeGuieLgh4LrN0qoQnqUaEyGmJytni/P9XKuHsVppv39eAWQXHconXO?=
 =?us-ascii?Q?H7TgF+5YK3BIxMqgvDo4XCEq0/ImvaTNEQ7izExKscriCYHPnbWhr02WNk50?=
 =?us-ascii?Q?lbhTVr3Jo0zPPFu/JeeknEmG/1vPzmbgUKN3qCJYn10ro4lMJxs31w+AwGrx?=
 =?us-ascii?Q?Q4Xl8Idqb7jIFCDEzz+apC4VFw7+03dvh3fw2WyUWvrTD0ZTzBTtNnmipTKx?=
 =?us-ascii?Q?sBAy01Xw4RO3bY++L5O0pDNGlTR9DDHosqajGD0UcmBsyFAzUkQ3ma7J7Rcx?=
 =?us-ascii?Q?E45OBo5TtK8qbz87G1FCYfkpkvmpkMz90JoBV8jcVsAx/c2N3X+l9FW/irEd?=
 =?us-ascii?Q?NstL5c2VvbHJUNJMPW5+UIufKtHuhYz3SM4vW6V9kGPvxCQB4mbh2Jra1r+/?=
 =?us-ascii?Q?V7pq177muhAQYqhQ8pSxYUy7oKF7gwSkBWp17lzv6QXBdLqM942Vwd952AWs?=
 =?us-ascii?Q?fkNy7gMzxz6Gc4qG1N5T2gBtgVNH6x1OdptybjrW5llTK86t2+eSXp6GhvtP?=
 =?us-ascii?Q?c9EdFftS5g+n7O0uRMDIJ7o/cgrvOs9j8VPCcoZP+BeqAhm2VB27Pa1FMicP?=
 =?us-ascii?Q?JvKCPA2r3jowSyUqwMlEhB494Qq50FD5WcsmTIrV55m6r41KhrjYpkfofG3A?=
 =?us-ascii?Q?VOH7b61ZeyALq7RszJSsMSLYlIbG2RUceC5Nvl//?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35f5369-f3c2-4276-09f1-08dd82430c55
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:44:24.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ca07GumfoH9n94Pp45mmj4ucQiEJg90cfZxRNJ5kbaeFj9MxwG4U+0cex1OfNi5TNoOktSvUM4Oqh/vq+EBoGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7275

When trace mem_cgroup_alloc using trace_kmalloc, may get this output:

kmalloc: call_site=mem_cgroup_css_alloc+0xd8/0x5b4 ptr=000000003e4c3799
bytes_req=2312 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
accounted=false

If multi NUMA node, maybe above a little than 2312(8bytes * nr_node_ids).

Which mean each mem_cgroup struct only need 2312bytes but kmalloc give
4096, due to we only have kmalloc-2k and kmalloc-4k, so fallback into
kmalloc-4k. This is waste a little.

This patch use kmem_cache_alloc to alloc mem_cgroup struct. Ftrace show
like this:

kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0xbc/0x5d4
ptr=00000000695c1806 bytes_req=2312 bytes_alloc=2368
gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1 accounted=false

Compare to 1 memcg waste 1784bytes, this only 'waste' 56bytes due to hw
cacheline align.

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


