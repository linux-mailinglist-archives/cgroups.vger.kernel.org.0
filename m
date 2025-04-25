Return-Path: <cgroups+bounces-7828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFAA9BD36
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008299A08BB
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968B17B50F;
	Fri, 25 Apr 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GDVNi0wD"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013011.outbound.protection.outlook.com [40.107.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6917A2EE;
	Fri, 25 Apr 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745551207; cv=fail; b=rOnq/JhS3S9x7SWiPlsLEnVxr9/0vnFCbH/1JRVOZvg1YVhjnRAq8ETGUmPM+px4FZkH49WJKUupsRiAau8FkHOnSlVxKbFlKMP5+9iNPdNcnKfSmiz5KZ8DEEt2iGlm/en6Oj40EBYTCY2awyTp6StdfCuDIc6JQL45rZaZBzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745551207; c=relaxed/simple;
	bh=Y+ac5lb/7LhofykYEaf40DBKbWsoD+FOroeMExCVteo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LshbPwED5Zhk8RhkTewlVFe7R5g2K98K4TkZmKugKDWJX9UL1Ufyr0XFGUaWI9fV3i9rPa19G/5Q3WYyPXbvqDGDRpfI/sJuhowV+GFmCfjUBzO+9j3U3ngzvjl21gvXo7sTvCShJiTPh0oLiPnPy4VUkvYxShdJCPKlS/nCS5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GDVNi0wD; arc=fail smtp.client-ip=40.107.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfd/lbQSwW9OKSkqxllZqqoqdMJCKgIcq+MjGC1oGEKVDxI9aWkmR1EcDfGBoglpsdPkzoSrVinOMrbKSfpQmXsmz2fhnYXAiQ5S7J17/6FEFXcT4N7ecCaT8oONs1AcISvnWeuACza2gYxRa4VpX1a1h/cEeQU5ABFxGtR7ywVtK/G7nGO3B5gtuEC+VJaDluOgVWNnH2AtobabpS2VaTcpvBoKHZedPaX8gM/HjJnRV3OcDKIn6E1hzl1pJiPPItoJbeCVaY9ACe4ubOg1DJmmF/V/8h0Zi3Mn2lYvKwoJcaG+0zAFdsUPsmmPa/Y7bvt/iBkMAQQuuaJkcWGSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYkUu5uAQA/JUR8dG9F1TnP4gtM6yeNourk+mB9taYo=;
 b=rpp0GHaAtuvrGQprtbsWra3wQQD3xB4Tk1u/cw7/Nxvie1ACZvrEazDIOnAALRJZW/DTaTsHKeQ2AQq612CfQG3khnBLJN8ciBWoSnQyK3fgkCZQSrgcx2cm1rE0wl7sDb2AG4P70aBSyqzw7vW09mvDYrOjyK7/LxONgSuhynJx9PLb0tT9DSKkJKsrNYSVmZBH2NwPgFtgKcWd+Cpv5KzLYb8i6jeAd/AVSZ71uLi/Er/iI13XSiQgIV02faoD77LmBfDr0G4nnAc5yE6SMEWp9SFdSD7DaFzj5Q5ZpcvkM8d51v5HwXhUZwFJFAqjrWIRKoRVfLkbiy0j5JfW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYkUu5uAQA/JUR8dG9F1TnP4gtM6yeNourk+mB9taYo=;
 b=GDVNi0wDyO8a18iG9BIMrB02sG+r/Zkk8lQNC7kXKyV2ATcYEIh764sG2RBUcZkbOWdHbzSi9KCdnXXxCLKBhrEfZWIAEq0rn13PPgVl7zqRVeKFyZFxjR5OWTJPvOyel0vbWUCNQNr5LmcMZmSIzByKGYVizK/5ULvkhrOMEfczQIcypO7EO6YXRgYAtMu1nOyUhm3ujAmBwlSOY9aZG7nhAdRA8iwa69q8m3vygYyfORs+0aQoi/focb6X7hXHUj1bRAZKNrBY8puyN4MnAVclu0gorXQ7VcHKJ32fWUaLJJLcFjmSao3wwZ+uobw/sT1c2JVXl9Q+knksnZvPPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6604.apcprd06.prod.outlook.com (2603:1096:990:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Fri, 25 Apr
 2025 03:20:03 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Fri, 25 Apr 2025
 03:20:03 +0000
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
	Huan Yang <link@vivo.com>,
	Hyeonggon Yoo <hyeonggon.yoo@sk.com>,
	Paul Moore <paul@paul-moore.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 3/3] mm/memcg: use kmem_cache when alloc memcg pernode info
Date: Fri, 25 Apr 2025 11:19:25 +0800
Message-ID: <20250425031935.76411-4-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f7f7f69-f217-45bc-4de9-08dd83a811b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nEk/tf67XXoj7G653VpVA5nXuKeU64Jd3QF7epSybniGWhVNzEmlRYJVOyOL?=
 =?us-ascii?Q?MW/9oy03vAIa1OvCwOrFPQ/rtgbK/qyiX3RUN5/wqB27SvOgUlWWbBD8wltY?=
 =?us-ascii?Q?umizIc+3dLgqwo/TRaZTOd/L5KunMxD5z/WK+vmWjYOz7Jn2gfyR24sd/ACI?=
 =?us-ascii?Q?6c17lBKH7GqdTQG8PhBjVAPVix8YtiULtN4M26u2ZmKiz4AitiCym2yRt0eS?=
 =?us-ascii?Q?+alNjI3ggCxT0vO8DVt9KF7Mz+CRWB3vjKOtDtgT7Hqcpv6L/aQY4VEP2rP+?=
 =?us-ascii?Q?fPxFpBog8kUBiql1MwU3OKjbhHoqb2rKIQOX0JUZ+ZLdR/wOJm839HNh5z1q?=
 =?us-ascii?Q?Htk5lCuvCHV3tFGbqee4T9eJOp0Sd7QmrsO/MYE3pH/NGu8V219RO3BKvQjk?=
 =?us-ascii?Q?boA8jLsyoAvDnu8+eSf1XMt3sZWjOVz5B6N0lTFmvHzrgUA840ikFjoUFDg7?=
 =?us-ascii?Q?M5+DZrMUmt1937sNMLftSqLoteqL3uLRyaYRFFent/tZk5xiKYf1C0NRIzAc?=
 =?us-ascii?Q?dCw/D0dagCNcA3jLoRnErsCd7qyvKz5JVMPvsSugXtxziCDeC9zPLmN5ui2i?=
 =?us-ascii?Q?o5JShg/XhqJo69GRUXJye6//5423NA2ZKYCN5VBTeVKupq4fPjUcjdh+imxO?=
 =?us-ascii?Q?62XzqW/LHpPUGD/d1+mW85R0CU06MYEdAGjy0uN4WzvRMQxPIKQPjN/ZgIhg?=
 =?us-ascii?Q?lQJOdpBB0wxInC0YyXM3iTG+V8JZ2pN3/AFCrkiG/rx5r4X44vOdV3JBYrJM?=
 =?us-ascii?Q?s2xv7BEZFZmETUofB1hMO+s64+8HtFaP+jkytVu5/nqucRpY9jIVrt9JkjMJ?=
 =?us-ascii?Q?rTA/Vm2pxo4FJDWhv7L5p2/AqoJZCgxvtM8EHf3/1Ewbpa10Q8QG8Zz3Suig?=
 =?us-ascii?Q?wR0IxdnHAAmO7kCPn7aQfJ9d9f03/w8SvX9dtx/wHpFft3jv6YWhuBPJKMHw?=
 =?us-ascii?Q?W3WQgPCualoIyGz9yFOhWPWT89iUTpWlFAn8rI8Kb1cTHQ2AcQbOXzjU/Wou?=
 =?us-ascii?Q?3ZdUf+htVsqgMTY8or+qptMtJjGxG+ngssNGLtjK9PgsYIQk8D0ZJNs+v6b7?=
 =?us-ascii?Q?b7xGmsdzzh7x7+E1+THenliy8WPNwWznggigEFmFc0rZDLqF448QRarYhftZ?=
 =?us-ascii?Q?/aBvV/OSyabpdHMtXsPhXCsZg4FmFHXGxEBFNfT93ruxFPaRN65LKWBu6f8i?=
 =?us-ascii?Q?jBFM1vzj/Nk9Ecj22bVO6Ciluol/4j8RgqlOB40oR9BhKZ0Qt7G1X0NOUsTK?=
 =?us-ascii?Q?P7aknCpcKJQLbG7Z4lRlMRKeeT+V6pWagGxC8kCaO5LL3AQGFxggeKczREJh?=
 =?us-ascii?Q?86VbS/FOMLl6nx2Q4KgRbT4+pIxv+nElfJLN5TtkNQ3ptHiGci3IW2Junmvj?=
 =?us-ascii?Q?WZTpWxCW/GUmVSKo0MvDeQh+jXxL/mqmCaLC+cP+3u2fxeSlu7ZwjuSjnQ+b?=
 =?us-ascii?Q?A5jZt+3KrhZDGILPAQFvw+OZQLnDd824MDovyRjysSXmSD2yRhD54cfIRs6u?=
 =?us-ascii?Q?Y7KRmGF1DVKMRUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opcHjkzf3q4Lsjoay3cuTRr55xwVNbJJFPSvoDli8FYqx2btNTggZzGs2vod?=
 =?us-ascii?Q?g+yUo/iSzv8XpvmueumfRFwxQgbx8qgQJ5YGI8GlHAWI53CZKaBcgSZWAP4q?=
 =?us-ascii?Q?oVfE1vkLMt/Se6/O6zUb27LNz+vSzwY05DcHVrFxcp9y8XX0Y/4GH+nfwC/p?=
 =?us-ascii?Q?voZYKURzJ4yXhBwRnv9nba+RxPqhWOH36Yo6/6Nx+SqtoZsoKJ/G1bvF5PZq?=
 =?us-ascii?Q?MTn6IaTFTDAW+caLqPdkHqdXrKF13QqLBRNlPcwDGvMjhbQMLxkwLt8E7N3X?=
 =?us-ascii?Q?7KZWXAzq/DZkgWs+XiKB8CTd3IGX85y/SvaX1dsPS2DNz+JEwxfwAlw09Wnn?=
 =?us-ascii?Q?Ud1JiPOCVJ7q76UnOqyZnAL0+ODoAePk1DVIiusaKh10yeQiIST9c6XBKnVE?=
 =?us-ascii?Q?o3huo6Z2aIwQgK06EF23XzjRGoPC1fp01nK11DqbOPa+Q6uB84Yf4Imi60lK?=
 =?us-ascii?Q?VXzpilqNMMN88oywtVYL1HgFjVDbW6ZrUULcl4W8fduiE/GnWqvo0GxayIeq?=
 =?us-ascii?Q?R5zzPxIhZnOJCuYGAFI6JusIdnxWcsly8JNy/JSNAZs2OK2c6r+X/xDyRId+?=
 =?us-ascii?Q?PejSR+1QjexPeQFirT4et4v5SsbM/c/eFjBHPpNl1lO7l6DIyfbuRFt+Rp3d?=
 =?us-ascii?Q?5BoyW5IPztEgD2BQtVmJx/BFb1praKRpoNQkCIIY/g1dJci7zUOm4H2BzLR5?=
 =?us-ascii?Q?hKk5eOX41pLBi5PSrWnzJWzKPkGs5TNDpz8j7ZkgG2QM+NJ1ivIpsjyfbwqb?=
 =?us-ascii?Q?5xUnZOoxI2mglSaMC4KO9nJYQQObkVs0VxWZuyZcF7Cx+us5kj6Do6l0fS8F?=
 =?us-ascii?Q?dtlosdkleDK4b2Om9mggpP7PW1l4ZldRoFhbFHlq7qt3nUzcD/SUZgsCd4gg?=
 =?us-ascii?Q?j2ofahEw+gPtS0C9VUFIob2JJJ2b7q93Et96A5GXMTfN63MJfYt1uQ5H9u9e?=
 =?us-ascii?Q?E2oYdn5k1CKArUT/21+rJmLVIMg0tyePuVHpejpZboR5yO1xRFijDuUanZH5?=
 =?us-ascii?Q?KHTfa4skejLm1Q0vd3twpIhUZ0Tp6Zxv4nEOP8ns5W5jEXrEel3UaT9SU7Y8?=
 =?us-ascii?Q?By1K1bvAQSGDPyFkWxsu/LFhMAGbcecbnYZvIaoNLUt0+UjXNlgVdU7a/WPx?=
 =?us-ascii?Q?B3rauFEZmfCabiPGy5BfO3BdLjfdwcDOktmTou5kA1iiF/3W/LMePLVjNWnQ?=
 =?us-ascii?Q?qz9MX5YTGDBdq3Amuan/8TM0SHL13xxYlDVa4XjYUpAPRGtS4pUwc1F4XAqn?=
 =?us-ascii?Q?BtHc0AhjkMVoInVqLFCnNT0rEjJds4AWslcFrOMHQkmimWB6z5WqxLgLuGGG?=
 =?us-ascii?Q?yKxRzZkvM8P5ZKi+j9bxDIkjCR4WpbJjRmFrCOnKzPPAQ48MCABDcDNw3czz?=
 =?us-ascii?Q?SQwUYKL+CHnRwupR3zwU531Cw8s1QYSwhI28B9VGkaErTtt4FRWLrRB+OrXw?=
 =?us-ascii?Q?IM/Ct8Ks967tKUk+GWV5OtsBlqa8voel2nledU3BXUcbvDwEoEWK/Y3Tlakk?=
 =?us-ascii?Q?csg4zCGXla1uoSZEhbv9lkwglUNHc9hrwdOkkJhpexfiZ0FBaQLiZjRBrE2x?=
 =?us-ascii?Q?/jvDbVVy9zJSR8zqYr1XDZFFyv0uMZrTCb5tE3UC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7f7f69-f217-45bc-4de9-08dd83a811b1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 03:20:03.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IHXr8tq+W0Pf4Wxgi4qqfW72ziYjQaJCKyfMYoMIHr1gm+u25V5u6IEGiNYcwPp00kWwFaPopClbkg5qL/hYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6604

When tracing mem_cgroup_per_node allocations with kmalloc ftrace:

kmalloc: call_site=mem_cgroup_css_alloc+0x1d8/0x5b4 ptr=00000000d798700c
    bytes_req=2896 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
    accounted=false

This reveals the slab allocator provides 4096B chunks for 2896B
mem_cgroup_per_node due to:

1. The slab allocator predefines bucket sizes from 64B to 8096B
2. The mem_cgroup allocation size (2312B) falls between the 2KB and 4KB
   slabs
3. The allocator rounds up to the nearest larger slab (4KB), resulting in
   ~1KB wasted memory per memcg alloc - per node.

This patch introduces a dedicated kmem_cache for mem_cgroup structs,
achieving precise memory allocation. Post-patch ftrace verification shows:

kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0x1b8/0x5d4
    ptr=000000002989e63a bytes_req=2896 bytes_alloc=2944
    gfp_flags=GFP_KERNEL|__GFP_ZERO node=0 accounted=false

Each mem_cgroup_per_node alloc 2944bytes(include hw cacheline align),
compare to 4096, it avoid waste.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/memcontrol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e34216e55688..af1cd5adfd6c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,6 +96,7 @@ static bool cgroup_memory_nokmem __ro_after_init;
 static bool cgroup_memory_nobpf __ro_after_init;
 
 static struct kmem_cache *memcg_cachep;
+static struct kmem_cache *memcg_pn_cachep;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
@@ -3601,7 +3602,8 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = kmem_cache_alloc_node(memcg_pn_cachep, GFP_KERNEL | __GFP_ZERO,
+				   node);
 	if (!pn)
 		return false;
 
@@ -5062,6 +5064,9 @@ int __init mem_cgroup_init(void)
 	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
 					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
 
+	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
+				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
+
 	return 0;
 }
 
-- 
2.48.1


