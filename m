Return-Path: <cgroups+bounces-7747-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F71A983FE
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 10:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C939B3A5B16
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E026F469;
	Wed, 23 Apr 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LyAATyFY"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011038.outbound.protection.outlook.com [52.101.129.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFE26B2C3;
	Wed, 23 Apr 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397875; cv=fail; b=cwQZC2jwo5qnzG6QxAEtfURuw0mgarh6giHd2kPgAHnBF1CEympz6v9kDq8tNG/+2roG4uCa0U67Jrrf267XNm8FzkRVqaKf2uuSdLsC2KvIJD1GoCCOC6XiEZovlZouj9OGurpFmOd6YQshxOvJcxaWOL1+HRsP/9Bt/vdhs5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397875; c=relaxed/simple;
	bh=hkxGm/cxkHIB2UHUwWlxx36tWdohDFgzgfaoW5zHjBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ukWdgnTTus4v1QPx6j83qWHv//fqTXdUyYu5SW4NOErMV9By9AZG/0mLUIgXol0Xy6xlyquBp6O+PM0CDL3l/roDpdZKCSo393J51wyj+VNGHOFRw5xO87GRzrUZ4esAZJrHVC3FJOoxZQy/d0oTVPAvLjop1cph9Mmu9dDcHuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LyAATyFY; arc=fail smtp.client-ip=52.101.129.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB3i3efFnUQkEE+OnGuxu/nonyCwzCuE0sz8iqaqkd3gl8Vp3dXDOnezdchxAbguAgs0ZVFO5D6ZczZSgLjxKcnFo9iiYAppaGgx2sZfTKYvGMMP09Nlxq5fL5G9SDY71RxxPkDCgPouRS6KZP1fcp/76TtmcNldVfnSmZMXwFt0TKa1a/A8c0PchWzL/SVcPLUJCVQAg2eeKG3PW+skDpW6K2JhXkY/ggsI5lKnw7PhE42Uv42KqBhuW3ZW2obhBsFXZ9bC8yJiTj+5TpYVkzk9jtNCnBsOKfzm6N7uDWgemn1FT/kc4G44vYjqsY0Pk5rjGjECZw7oboi8XFutqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dkj5cVHxKIsG2Sx6wH0Vn2VjO66YRdldPUq0Jpu4mYQ=;
 b=xSTDivbIxHU6+TiTdwH1Gu2cheMkdaD3yUJDVE2bJS49vtEVYQkkipLeBDkzRgqGvZP/U4e9ur/3aa6xP6Pdo4dSn87+ytGoochHm8srdSMrkRSfsRE04dcWvKRaTsRo8e8KkOLlRpA4sMG1bJSWOgx0x4YASONFaBkTkrhXIicpWv72m1FzaG+MCPIMVch1d4lvH0s6JpDk5h9CxkBIgMdpFIfZXEmkxDpFpVldiGGvrAc1FIC7dSafNpPqTP7XY0E8Hk0IPk6QK/ZnQ/PZDbSSMmFqS81jHHp0DWVZR+pl7MuJIGScIJT18/tShHtAyKZbpfFJ6PCVHrdVGFpcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkj5cVHxKIsG2Sx6wH0Vn2VjO66YRdldPUq0Jpu4mYQ=;
 b=LyAATyFYZs/21WC7XXDljlGvfDQxaHFQHyozGdFSXLzsQBgdD9sFmAqY5ws3+4Eh3SFp6MCkSJtdBT3gTA3K/k/nq0MuwpCFXBfs/yrurzzgTnkYULCnpJxzNFDW1009/wNiJqaDGnHVFu65HI2/2iSQhNPO/R4fKSCAYzLsKtbN3lw554d82gpnFSPMoA5AqW1lCnYal/23hddVPQH5OzlSic+Ve/B64TFMYw0X3EyFbOM89LV27of4ykfM/RNkZUB/FdZ0w0r/zEk/bjLK73jBn2RjF/IRdgZjXeqSdyzq54HOMA12QP0hU5+HJOZG+TQiWLqUFlEo18LmUMmkQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB7275.apcprd06.prod.outlook.com (2603:1096:405:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 08:44:27 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Wed, 23 Apr 2025
 08:44:26 +0000
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
Subject: [PATCH 2/2] mm/memcg: use kmem_cache when alloc memcg pernode info
Date: Wed, 23 Apr 2025 16:43:05 +0800
Message-ID: <20250423084306.65706-3-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f006b816-563c-41a9-6639-08dd82430def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TbdctyTuMmmAi4r96T0fHeAydh3iCqUi4n2ZD3DgdmzioHup09dnFaj1ooE1?=
 =?us-ascii?Q?JpjTTk9rGsDNB4H/iJ10+32xG7uh8RD4WlAc7duMZIl77oayAPmkD8gv9we0?=
 =?us-ascii?Q?I1MiP+B7Srjn+d4lg4mPINK2li1XgUN2Xty4LBCDXWJSOPMC42ZLUvSLaAIu?=
 =?us-ascii?Q?7QOU/MpidVhd+S0XD2NH0VSp6YIV/2qn7PAGFCwEe7jbbIXNiU3gNHY2PNVx?=
 =?us-ascii?Q?Tka7JP1YmYhw14agxgMhbFvYqKMdi+LH0AN4zGJ8QMRBUcaL+5sAFhHZBWMJ?=
 =?us-ascii?Q?LKcGp5FSw6IvibiP8sD6Fk44RDivIAnm58WpCe9+D1JiU8GRzTWk7EjV0byL?=
 =?us-ascii?Q?7BfqGFH5lMgcxSytVSRFtIxNbCRL1SAc7eJwEZJIYt6G7Iuz8qZf8zJfjiy3?=
 =?us-ascii?Q?SAoHsBMB3uZj1w7XC7NwOXG+GS13qf5Q4D0qcG/qvqG+HYKOg2IfnZ2owiMg?=
 =?us-ascii?Q?gpMDpEdH170OkaAOcXwhKX+IPquuUlwArpkz7UsJRuE/8GUNyf6mdt4CHnUs?=
 =?us-ascii?Q?Uy1JGrXyw5qPREPQSYiftAsvmhcYvlG5E5ZLWC6SCe63DvAKe137FFx67hhu?=
 =?us-ascii?Q?/dAR0oOoiUFNUbwg4AnyweISGveRycFe5PMgi5sM/fI1AcB6tGxGVQdyr5fq?=
 =?us-ascii?Q?DF0R3v/MPifoCiMqmF46l8TKKh0uk+Uva4bP6yzWRNKrl51asNAkbYcKMnAk?=
 =?us-ascii?Q?vwqLL2LT9UMBmRVhmHK80j0yurF77LX6SpOyXlwrKZ3yWnjbEDWHvaHFALAS?=
 =?us-ascii?Q?mYEiTSYj9O2qhiVzS9Zjb5yf9hDjS8iW+dmeJjo6/QI9p+2G12+E0lYcyjJ4?=
 =?us-ascii?Q?OjiAz8HOLgVsQprai4HuW8BTjKNJONrhh+wI7udrJ4AbR4NoyatvaLFQNeS3?=
 =?us-ascii?Q?0zJeFzGp4ABNLzcI79T/jYq/qfMFRF1wdMKsuZ/SHPWphHgcQtSRIM8YbYUZ?=
 =?us-ascii?Q?M1mt8S8rpEO3P7VfnvpBVH/CCWlKRYiik9q8WP/nzcmevU532NLG5i3rXc4S?=
 =?us-ascii?Q?3tIqrcR1Ve/gf6G/+T2z+vHI5d6ccSYpCVQWfdS9Y1xVgsgtaxCdvqEPncX5?=
 =?us-ascii?Q?yNcAmoMjMidLwWNUSntSawtYxH1P4w1t5m81C++sCf+Gzk8f0e/5voRogoZq?=
 =?us-ascii?Q?Dr3QV9F6XY59cQNUNYb8bssG2l887cnRw1Sbq2vRYktINfkJsfYNdXsOSZtF?=
 =?us-ascii?Q?LnrVPYNV3oZwJytqF5wh4LYY8X7kM4sr7uFOgQghYQSDWneDEnWVZ3+y+F1a?=
 =?us-ascii?Q?AUdssvccxlr2LIifxrrJAlKIG96ruQmORnMTx9WInz/7Z/csjOVb357nBNl1?=
 =?us-ascii?Q?JTyfHc5Fuw/7dfrXBcmZJxKGnzhe+Huz6SQ5wc2LkWTCEt2z35PE6ZkOsL+f?=
 =?us-ascii?Q?VcQWT7Dsgglnog4lF6X1t+yIK/oUbKFNTNtZmC/X7lOWxGhR09MMvz9T1crY?=
 =?us-ascii?Q?Kbwdblu/V2Rp7SN93hb8GabKA+ZMKY6kGtyq+OiAgGq4JsU09Y3Mmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZ51vdHO+b4vPMZpque+wzNA5OS28WxlmOZgLQyVWY7bqzjgEA+aGeEJoCaI?=
 =?us-ascii?Q?sGGwy0D84FWrHnzjRYg8xope/TNYZu8ZwPbq/IzM6iUjDVDnrXixsyC5zt3z?=
 =?us-ascii?Q?RgIqZ637iSyJ3VOgqfHBpuIRQ7riyeku/PqPxDRcEJsKfcHP67AcQqr2lDg6?=
 =?us-ascii?Q?CitjrCCTJGgtpZBVl5tDt9iDjItiYKwFtfXnnaTAcXNVvALGHmuaPvuhBxgc?=
 =?us-ascii?Q?Abz46PyPaEqznG7U5HNwpNUVOUyPj5HUfBv32gpsBWbESw/mKLHHCnweDc0Y?=
 =?us-ascii?Q?LyRWHZKHEfS3bz0Bqlw7NRPwROKy8lr5Ce5e5hAn+ZS/agN5aPJ9B8vxOcEK?=
 =?us-ascii?Q?FlO6mSfMybU+BuYZFYNc9VyOvXAy3fNbFS0iQO/fchrITT7qKusAEKdnN6Wp?=
 =?us-ascii?Q?/hQ6mI1RtLwCG5mw/2tCOF73U7UPq3yDT2SYmhOtKnkhPaL4vPMSm2w1A8/c?=
 =?us-ascii?Q?/j7efpCBeZ0mhB0GbKo62IjrxZVNw+fzlM3wz7yML5kyTd1zjwD8YR3ReHNi?=
 =?us-ascii?Q?FA7SWVSMUskwxD4Zxfgke+ErUPyuqiCr2Sbz7btWym8DQdcSPEmICoMKYreN?=
 =?us-ascii?Q?EmnwChAoSL/Pfry9/A7acxOG6NDIHXnigtyIF8OWVBxqNtvNpG2Zv1KyCFSB?=
 =?us-ascii?Q?scmjELW8+4bSXM41v0t1lhIYGvVKD2VCYo1eCv3jm6dbSqP700eRQtTwzPek?=
 =?us-ascii?Q?6lyadG8/cit+acShB9BTLGENy8NixSscyPBrEACaEmWhkCPMSo2GZS4QhAtG?=
 =?us-ascii?Q?Ca1NfQQj8rfCspMB0h/BZBsr3yoGGZmkp0dRvTxqDkddiMyTTVeTZK22JdpB?=
 =?us-ascii?Q?bFSP4Wc+gLzs1amdm33wUMrb+Oc3EyEoIM2/H7piAAQdYwJBUiDEx4zvbEXK?=
 =?us-ascii?Q?SeIKdE0RgIP6PE1FuWsPYExZrg9NW7ogujFl9xqfHqdg6LQ2F/647dnmYDkx?=
 =?us-ascii?Q?pNubMAX9H58YzDWRXzGrR/KGJgi4TpMeBvEWXxHnrGnVEeI/9KLb7AyiPlVp?=
 =?us-ascii?Q?88VbHnev9cwUaZdW4TFBt2O0YsWaviGPZ2Sy/4LGKOtOPbdJ5DNgAW+Sn3lb?=
 =?us-ascii?Q?/rdzPnFPro6nodA25hrwOlU/l/+CLHZcv0z9i7w2DqVCAOT0mErEdf0qlhpM?=
 =?us-ascii?Q?FmdM14zKYtiOPKspPrYyhu6+YFWqC6H9cX9pu9Fe2pZwswNn4T6Ti+uCssyK?=
 =?us-ascii?Q?4HZ/X9dCVQ3db2C31RkruaLIoCqmNbsD7jchquWeZK8myaFW5Ejv7jcU95/l?=
 =?us-ascii?Q?7DxdnI7O0uvN4Uy5fjWxqNqgxEHEPnW2/4Mu0+8p2QGpj9ZJA/8Cx+V82NGu?=
 =?us-ascii?Q?UAY3ZCeGT88E2FogOKzVsyyY+wpdZeesKkfGQH7hwebiBH09X+SWTrJjy2rW?=
 =?us-ascii?Q?SRl3HmrlviM2Am/8W0j+QyXz7k5vJcA+AF/J02qDr+7GqIy45L0WRI5Es3PY?=
 =?us-ascii?Q?nKGr6Xbcybt6RWtOQuEw+88Gdj3esD81WlyI/IVvLZ7KsELXYA11rcdSUTaL?=
 =?us-ascii?Q?gOG6ZvYvSRq1o3mSMBsEjYpk3PXyu42Oe4LEu628fV00CBH+2Xk9MEmli9PO?=
 =?us-ascii?Q?k+w3YsHwX+bIqu4lW4IEVPhHXSzQxVKHG01EHQ8h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f006b816-563c-41a9-6639-08dd82430def
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:44:26.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbcF9kNWaGeERghcDPUFUrSNmceR4xHWpi6XGqMDxDtNUSEsCsYiZW3hB39GaEL18n35iElX5uUN/1UG1RdE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7275

When trace mem_cgroup_alloc using trace_kmalloc, may get this output:

kmalloc: call_site=mem_cgroup_css_alloc+0x1d8/0x5b4 ptr=00000000d798700c
bytes_req=2896 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
accounted=false

Due to each memcg will alloc per_nodeinfo for each NUMA node, and each
NUMA node is 2896bytes but kmalloc also given 4096bytes, that mean 1
memcg on each NUMA node will waste 1200bytes.

This patch use kmem_cache when alloc mem_cgroup_per_nodeinfo for each
NUMA node. By this, ftrace how like:

kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0x1b8/0x5d4
ptr=000000002989e63a bytes_req=2896 bytes_alloc=2944
gfp_flags=GFP_KERNEL|__GFP_ZERO node=0 accounted=false

Compare to kmalloc, this only "waste" 48bytes per node due to HW
cacheline align

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/memcontrol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb32a498e5ae..e8797382aeb4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,6 +96,7 @@ static bool cgroup_memory_nokmem __ro_after_init;
 static bool cgroup_memory_nobpf __ro_after_init;
 
 static struct kmem_cache *memcg_cachep;
+static struct kmem_cache *memcg_pn_cachep;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
@@ -3601,7 +3602,10 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = likely(memcg_pn_cachep) ?
+		     kmem_cache_alloc_node(memcg_pn_cachep,
+					   GFP_KERNEL | __GFP_ZERO, node) :
+		     kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
 	if (!pn)
 		return false;
 
@@ -5065,6 +5069,9 @@ static int __init mem_cgroup_init(void)
 	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
 					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
 
+	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
+				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
+
 	return 0;
 }
 subsys_initcall(mem_cgroup_init);
-- 
2.48.1


