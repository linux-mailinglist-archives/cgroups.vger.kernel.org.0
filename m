Return-Path: <cgroups+bounces-7827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F512A9BD34
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 05:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F09B7B3430
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F418870C;
	Fri, 25 Apr 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EHG/SvYC"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013035.outbound.protection.outlook.com [40.107.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB618C322;
	Fri, 25 Apr 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745551202; cv=fail; b=edNbdS/aLeT5hsMlJS6J0t2S6Ycf2cCEAEKJVCWfttig82ASX+H9fJB33pFAinSHPNv5kIVQpgQMO9x9uPWLMVr6s9CGBAy1KJJ2HGaQTGldxuMvreef2oZaeiGEAQg2MI1SZTV7NQM03ngAxgZK9j42DGQ+rKcKFUMP+nnk8LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745551202; c=relaxed/simple;
	bh=WxWLkyQzf5/ZsC/4gYyk0jgzAzlBj83mEvE3B14SL9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nl1zRcgmU64gq0GlDKyG8F+9EHBrx/gpkvu4k01F8jvqCN3z9AlW8cP05wH4UpIt8qJAx3BOq82rVPp3UKGljB3z6rFPQVgIU6mc8b4tX9XLL4LJ2osf9USkM7sVcnOgKcYt8i0yzMQZ9U3dq8evltpkYFagVGZObWJtOfoHeGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EHG/SvYC; arc=fail smtp.client-ip=40.107.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5iRyytq4vu0c8NrWPADlxtYvoL3AGxtuG37LjOumhOp9J/V2N/CZNn37BCdKEY7ojye5MQ6JAqaBLDUowzQq1DYA8zwv3+AEmrz+jT2K6YMKRznLNc2d1ps8ezYsCCArKzdYIazpk1Ni3cGMcv20/MGqEOSyZ84kQhlnukFpEsUumAIVYqXah4+Sy0lpM4EasfNLQVSUVadnPXTdrOmQCoiUC3xTMBfPugwLmMVFpAus9gM2+I1AY3ZvdDrAAc9KkJFR2C4B/kGDksKfTwiMhcB+7CCaoHdUSSp/TQverx/zo9B0u+olYaPF/jUm5gD2jUq9h81QA6N18g4mlw7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZnwIRsVy5aS4gC12g/h83XUUTeCoE14KfIB3VHKBA0=;
 b=r+eI1+0DzfO0BYYhyz1Vw76sCYBkqLsy/I9NZPYbCbSEsOfVYnocUL46TXmld4X0B1UBlEdPl2xy++0GdzbxZjiMSpWqVwqmjqaVujNjd1JV/4EU7qFzSwAAGzxflY7yTdYX+zFS4sFVIfhSxTku3G6bYOgJi8WD8TUkLmk040Z6t6Wu0qkrLcvBXS+98tcw6uyFTFzMfRiLpy6vGUyJjDawQA9Izroua9k0p/6Z9MRewRXUNhR0ZYwZx1kgjJJtittF/fW6Spw5/oCYp93KGu//l7o2L8Dq6bDeReSNBATlwkzQF764jSHabyp0i2xd3NkSPc7DicVdxUPBN+5GQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZnwIRsVy5aS4gC12g/h83XUUTeCoE14KfIB3VHKBA0=;
 b=EHG/SvYC96+qLG0HxoOA+e8NF57vEBoDGZb5TFxeV6RfZoCiRrgYvHnq6/EgQBGdIg09EIPynFYRZQJgfYBD/nPtoRShc2PMmw+rvNB2hWCN9l5iE4jMIfjw8oRCF3h+qdRqih3W6uQwS5Xp4780ug7GFBRc9xTEcg1vA08VxgEJbeCIP2/LpS4+3U8VqBlBEC+0cfBdkkcEWv+agIGMsmbi8s/o67x8NCAKsdbthP5JxZDr77P7QvEJ9myUY3K9kfexiYMwxr9+Ac/Wl0O16O1dqCOuMNok37MDmCUxVAJ8QEk+su6aMvrs9ut/bRolttjnI25WfYXytc/cy27tDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6604.apcprd06.prod.outlook.com (2603:1096:990:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Fri, 25 Apr
 2025 03:19:57 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Fri, 25 Apr 2025
 03:19:57 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Francesco Valla <francesco@valla.it>,
	Raul E Rangel <rrangel@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huan Yang <link@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 2/3] mm/memcg: use kmem_cache when alloc memcg
Date: Fri, 25 Apr 2025 11:19:24 +0800
Message-ID: <20250425031935.76411-3-link@vivo.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425031935.76411-1-link@vivo.com>
References: <20250425031935.76411-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: d6eeea4a-74d6-4645-c9f1-08dd83a80e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7YSVeieC0qIcyCzLb/jeqnLvi+2LKINDFwfGfYJwZqR9wfg9X1emQ8RWtGk?=
 =?us-ascii?Q?R1v2IiK23o8WsbD6G+0eXHi3FtQLNRcEHxq2mJNibN1NLvWCt0N9PRiP7wOc?=
 =?us-ascii?Q?tJXHHFvs0dcu24/fediZ6KKykQXWYJ0AfYICkybP4qk2V9dxQDHPvBSXi4/8?=
 =?us-ascii?Q?wNKVgS/fFpQzVTUOUZbA4vcbLDYGvMY9zvhIbzot9dC0Pg8hVanDtojrYkpB?=
 =?us-ascii?Q?ux5DXXjNnqyrLXp1ICEYbjOxkjMsy8VMX/9m5amcn0LVFT4UAI56Qi6CcjrM?=
 =?us-ascii?Q?ihGv2UgDtbyuTyDN93LVElTqQqThHKd+ELZOnAnJOCVEFn5RSDKno8cuj9Yx?=
 =?us-ascii?Q?tzm7KFjUgAiueUNdMZGVZvugbh8y0lqDVQ8NmsNMoJryv8e82b9IfOJk2myr?=
 =?us-ascii?Q?U7Dw2gPMyh1DQGFlk0bktqECvFugWbq7t1RSaGRwvjImsXlxDtlvE4t6qlZ6?=
 =?us-ascii?Q?e70plENFvysHXqZ5Glhc91LM7gPKqvToi+vAfzPyJvqjLEbN0BwLIcovIxyI?=
 =?us-ascii?Q?4fk1cn7eosETj20lFVwg8/bnpIl4OkWmeGP7Q6WBOYZaG8o6xsRrH/pUHnMw?=
 =?us-ascii?Q?eh9l1eYY3BhTByajNNTGMgF78cDgHR9Hbd2t4tST4Z9E7iy6zY7x0ENXm4dh?=
 =?us-ascii?Q?+JEv1ghj6aYcic0Rt9Ja9FrTxoWDyslGBrniBDYijtNmGpxT3XS5Bgw7qGRu?=
 =?us-ascii?Q?fq51lQx5knfqTsHCxgvah4OausxvbTgWY09xPEFVLsg2fyqNY0CLhMH4387E?=
 =?us-ascii?Q?17YnBeW1egD0WQF1LCqpCQnTuMfpcM4XYhShYzBBXwkL6MT+pYcBe9gwDk72?=
 =?us-ascii?Q?9NUWvRCjegNbHoLUI14uLD4aO/d4ZajzxdqNy07hzBiZnzsikjlgTcUeJ7uf?=
 =?us-ascii?Q?eKXEZEpyp9NmUZ2097Q9yv/33gsKQrareHS36xBd45X5IRA7aZ4DJcD5KBd+?=
 =?us-ascii?Q?HMVrzBqmaXsHZCm/ocR/1d0C+YsJSgpExIRDGuryRthqKnQnvegfFML8B7Kv?=
 =?us-ascii?Q?NGqEscClYVonF5E8Z/SVQw/BwAT9AgdNJAVSNBRTj9qHrVxJcLmAu5HYAEwc?=
 =?us-ascii?Q?FdnNaOX5EjA5bp7CRDk5MIDH9oFqoZktqLot+g5G+/ICqDROpc+SP+OyFYWK?=
 =?us-ascii?Q?BJenGw8rKq4h7Z2l5aNm6DtWCN+vKwx+QoFPamabVdNlXvePHodRXNio1Es/?=
 =?us-ascii?Q?TIeGfjEfPO3Xtiqh9S6rv1ow7bJTYLPFzGZACF1WRMcWbYZYaDc4gGzMXdKm?=
 =?us-ascii?Q?XNXmaZeup5GfNUwe4B2EzzSMXK16EOfLskBy7nUVgupYAXagthSbQNx+v8Cq?=
 =?us-ascii?Q?lgxrwM0dIavZOTAxpaWw1vR45eAh++gEHcCWYF9cDzHP00AOfplwTriLoqAB?=
 =?us-ascii?Q?eFFQqMH6AZEDZb4zhDrvk71/uHzK89gd8LEAk/7sqJZ4i/O/AvQwvl3RTtwJ?=
 =?us-ascii?Q?PzplTRQLHoJakd5FXUc7Cu7rCZDSRJyZtQ/qGpu/ihwdKUUsvXgmfRO8hMui?=
 =?us-ascii?Q?2BeUwCOIAqTL3+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8A0XDhXFwYCIITSh2Zzi/qqiIpPtwqTilTEkkEhXQ/f79CqFn9H/89AwZL3F?=
 =?us-ascii?Q?/CvenPNlVdz1P+5Lgbh3hkNPKKebGq5fMu5xAERxo7laTMiyY/ZPuz5sq1Qs?=
 =?us-ascii?Q?IA0pSTxEVob2hNQ5XW3inbIK8deDceIxxPpuZbpDxwX6ub3ECDL6kD0j0n/H?=
 =?us-ascii?Q?Xvg/0R9NR9LAUSgLLqQUN0vVKBczoyBc1mP/U3MBJpZr7vqPlMWyhVxaIGQY?=
 =?us-ascii?Q?cBtSLYTOb0W90H2MelLjrxL9XXY3kbMXdJKRpJQs1C/PlhhWewBkqOyeUdrH?=
 =?us-ascii?Q?AWieuxeX1pL95gH5iej+oK5crzP+NTDyCl+U0Ed+Qd647Oz4u5a/XW3Ti/pW?=
 =?us-ascii?Q?QxaJ1js106lTb9sTeTXWqlYVsW4JoBqIRrNylwy7yNK6CgoQRmRArn/7dqS6?=
 =?us-ascii?Q?MbL056m7UhAyRhEw+BGe3xCl0sMQ61imhZYmDELBIK4nKbaBSUxHWeixDgz3?=
 =?us-ascii?Q?zIJaESWmMLjkOy/vDMB232RWR3gPD6euFtZyqxn+MpYfGa62HX/qsfc9Cfc5?=
 =?us-ascii?Q?ALQdGxLLGuo/KR0wUE8EVPMIlG5PB1U3EMaVRf9JygX84enN9S3rtIRWV1Pj?=
 =?us-ascii?Q?tQ9pFADxkLXxXhMvh35vkOOWlZx0oGVpa+8faLiQ8Nl3q7WClrDSgWaarMxH?=
 =?us-ascii?Q?9uVX1pnkPOdmR2E42TjcYo8Y8/4bJ7ZliSBCe7GDBlwCVczexB0WcpxrRuW/?=
 =?us-ascii?Q?mLPJ8aVPIoHvSWO479Sh+bRtqRW30gneZbSjZ3q6wBFC/0kJix+0BSmF4Fj/?=
 =?us-ascii?Q?VN0jsmGxndOAu2oUxH6eAglwHV19F4qbwA2Q9eTCbDzwZSla8ZwE58YoSsen?=
 =?us-ascii?Q?+VWoHIXynPul9LVk2zjf2WVs2+Z5TAXq/0F7hS0dXtRxtZ5yp43CQIGxN1I/?=
 =?us-ascii?Q?ejM7t9ABSMrjW81dbUByrbtc31hwn60vYi8NP/ESFfo2+E9MS2jzd/I5BtKl?=
 =?us-ascii?Q?edzVVelY7tzLezlkgovoV5jQL3kF2HfKUC+ASzCO1MDz9SZuAZiRQkOSphOo?=
 =?us-ascii?Q?A2heaKZoCh/x7E/7JBWcovPeEJnA/twJRmbNeA+HIBj/LleJIvhXN1j1qEFr?=
 =?us-ascii?Q?PuboybWi3HFQjyhwLjbFXzVVeIxZohBhHfxMkE3outdSfCtwiTzU+6I+4/hn?=
 =?us-ascii?Q?LGl+pklZ2w+gA3sf3nnxfLxSWNNuRlCEWt85bMUpkTZ8JM2P8mpOA/0OY//0?=
 =?us-ascii?Q?9IgQow/gVc7BWoeiuMe0j1FAxNRx3zBvhWPIX9jPdVP/NLjEjRc3htx/YA4Z?=
 =?us-ascii?Q?iiyRFf21NXFZaJJlJqGzOhCIkfl3c0oNOq2M/sdu7cT4AHOqSPGGfQ17b3wl?=
 =?us-ascii?Q?XRl1vkWMBtH3twhwmFXeRfcwDzH/pwg3PeYCSTm2ombJ9RH4akCL0CJMW8Th?=
 =?us-ascii?Q?voPsT4Jhg9GmQucULcqmeam/wRZbMej6YU2PcXep2vJhutzTWKwNDSWRiySG?=
 =?us-ascii?Q?Pq9wS7xB03RJbGV0a5l1HOuRKxWad1pWM9hE4QxxpXf45LU/u8TuiarYA3YT?=
 =?us-ascii?Q?r+/yIlFsw021NcFji9CPW7AAlKt0Ds7IXDgapMwgqDrdgKgKPhUD4SdqqCfI?=
 =?us-ascii?Q?Sp6EFsgyfsSk1FrwzExT2sV0xzzUZVu7pmJIGsEN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eeea4a-74d6-4645-c9f1-08dd83a80e34
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 03:19:57.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oLuZzPjWQy9qb0JXjA27kn2vdNCZY7mA5gcdeIoafP0FlhwGzZ01T11PSIVtdRDJS9GT0pNC/3qhaR7FWJAfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6604

When tracing mem_cgroup_alloc() with kmalloc ftrace, we observe:

kmalloc: call_site=mem_cgroup_css_alloc+0xd8/0x5b4 ptr=000000003e4c3799
    bytes_req=2312 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
    accounted=false

The output indicates that while allocating mem_cgroup struct (2312 bytes),
the slab allocator actually provides 4096-byte chunks. This occurs because:

1. The slab allocator predefines bucket sizes from 64B to 8096B
2. The mem_cgroup allocation size (2312B) falls between the 2KB and 4KB
   slabs
3. The allocator rounds up to the nearest larger slab (4KB), resulting in
   ~1KB wasted memory per allocation

This patch introduces a dedicated kmem_cache for mem_cgroup structs,
achieving precise memory allocation. Post-patch ftrace verification shows:

kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0xbc/0x5d4
    ptr=00000000695c1806 bytes_req=2312 bytes_alloc=2368
    gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1 accounted=false

Each memcg alloc offer 2368bytes(include hw cacheline align), compare to
4096, avoid waste.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/memcontrol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64a4213227c4..e34216e55688 100644
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
@@ -3652,7 +3654,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	int __maybe_unused i;
 	long error;
 
-	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
+	memcg = kmem_cache_zalloc(memcg_cachep, GFP_KERNEL);
 	if (!memcg)
 		return ERR_PTR(-ENOMEM);
 
@@ -5038,6 +5040,7 @@ __setup("cgroup.memory=", cgroup_memory);
  */
 int __init mem_cgroup_init(void)
 {
+	unsigned int memcg_size;
 	int cpu;
 
 	/*
@@ -5055,6 +5058,10 @@ int __init mem_cgroup_init(void)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_stock);
 
+	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
+	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
+					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
+
 	return 0;
 }
 
-- 
2.48.1


