Return-Path: <cgroups+bounces-7826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09BA9BD32
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 05:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F49E9A0333
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5718132A;
	Fri, 25 Apr 2025 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IO4lgKUq"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013041.outbound.protection.outlook.com [40.107.44.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD71531D5;
	Fri, 25 Apr 2025 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745551197; cv=fail; b=ckl2HDWWhHP/bctIMsuZ20+FgCAN3pdqSVgVhtQUKxToGwNAD1vYJBErDxIVG4gTADwZk0yOVabFWelNVtDV+AqbvdEeNAejgvDWgSAsib23jU5Wxfx3JFWKCatNGNlvAkRBSi44odClOnwyaegmJ/TsxS1XxeDMimp7n9CQHOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745551197; c=relaxed/simple;
	bh=i5z5ykrSug1RCbHfiyXya76UD5ADNrXhOdrFJ8ItDVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2VU/qWx5H6CiEeEzulP+nfNz1ULgcptlY5JzUAf8TZ8O4vMu0nHERyEbPM5KiPS1Fmo3GPIOunesKoMIyZif+4Fo3gQpZgCehQJW8RPm5evT+j3pWdnjTLQrvZedXIpg9zYAdDUKZazhMCb3gMnXymwjxKAMRQdYtwgYhG7Hc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IO4lgKUq; arc=fail smtp.client-ip=40.107.44.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPxZspInrNpNYoso+U3qQ1ziOKHrtO8GbiGiBCmQ/lXssdDf4l1tfReoIuRq/mHmZf8zRfxul+ZHy2YV1UTAfF1SPO60GJFW15DT6gF85659paQbY6m/opoucEK5i83QvDeu4e3lkxfBQRPNVzYHivDbzv0taKIKEZK7YmdcGD4pYyc1P3pX10JWfqP/Gn/7/c4SjOEFEY+Og8nXTYug9qFogDv2MerWEGaoEYs5UKIHmqO+k3VJWLXWRrkFeoqfidgOfwpHor8Fahls87N7SWYmj6myLMIR/DunNBILL4O1o5hiIFbWpR/i+l/XOKHuIsOJGkEeICXzagBB2jUoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om5dM8V1eF3CShSU2uqcSNGMn3eCPeY5ZdMAH4gfcRY=;
 b=e9v7DAbOgayYQBQOuF4HCOM5ylvgu+NezWYIhgieZVi+godmqcwjoVgDvFvcuWLj9uZeF2eetdWQf5V+M8Mfn/re9symHFsd3EPgUmGXSBLxncfyn+YRylL2OuuyUwyEXf8lEGRNjJa5WOLPtdFCYmX5z6TrRvk1qht70jwHT+FnePDciamwx/5wDLUsH6axaqfnymcceSNU5KMQnOrplzkVo+kkDHBbarmlo6jyTOvZb6EclEwAgOpOWQ9R1MdWCbwlLLLGDiuGCGiI4K0HGfHrCcCYRw7lI6eAMjsXykeU5obgtfZvaJ8ItpuRkQq4nQk4Dy5eO767mCv0sHQwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om5dM8V1eF3CShSU2uqcSNGMn3eCPeY5ZdMAH4gfcRY=;
 b=IO4lgKUqz2HZo0Xzuu0+yVFA84AUJDXb46xg76do2lB22DmWbp3BMi16NV6aW34YBMigCrbBqSq7tX9eLyDuup+n5z+G0V6xYp6RYzw/OJUrUbQpswbCBTnTU7Peyo2/Nowv1DI2F5XOWSbEidfolGFqHXV/+amKEGncZv+UfGoansckYG2LDCT2u1A4tPLkxfiy3SS4SEeiPDE6NJcmcuQFExh8b9qUH2yPBk35zCRVq6GNCj3kq9CdDVAk10/iNkkMeTyoOURA1YJTFNpYo0+rqbuJ84m/x6x2hG+1fucjA9AsavqEZiD40rGes71W0KmIvNosatVm13/3gj+yYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6604.apcprd06.prod.outlook.com (2603:1096:990:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Fri, 25 Apr
 2025 03:19:53 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Fri, 25 Apr 2025
 03:19:52 +0000
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
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 1/3] mm/memcg: move mem_cgroup_init() ahead of cgroup_init()
Date: Fri, 25 Apr 2025 11:19:23 +0800
Message-ID: <20250425031935.76411-2-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74e7959c-4808-401c-1898-08dd83a80b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3a8UEjmLe5B901LfPZa3W/SjWWBCH0UZnFYMkfbA0rm/J08nusv6T1MgebqB?=
 =?us-ascii?Q?uKZfiumTXrHDkcZGjfVXKM9NrMZl3TnwWSR9zQvzgKLWIjMLU2iVc+EU3LHQ?=
 =?us-ascii?Q?O6SqeNW2Z40oq8D4xm9Uj2b8bkp1RcXHrcBdZFRKKjoUYBf4gLbX3v3oiVDt?=
 =?us-ascii?Q?YXTL6wvlsNtaQvna2SjxAGuAQXOOij5g1PM1XtAUNH0j+e15GaNQqruL3h2O?=
 =?us-ascii?Q?fzQ7+U4tBO2pi1FpvOdHKfXTXKhmMjXuy/CBxwmOkDZvFd7no9FQv9Amav3V?=
 =?us-ascii?Q?W4TpFi2ctpGTrRMIuQY9Sr31ZHK6d4P/wTGDCVyKsikxRm1pRgpiNjbPuFf1?=
 =?us-ascii?Q?fooxjehJrVaPD3o7xhhmV31MSdhPs1x2RbfYTh0HOG/4aQcdeFm36et7SoOY?=
 =?us-ascii?Q?3+hMjvC9gh6ExblsoXlj2YZMjkfjCJzOeeBDq4+SAfa61I9I6ieg2kinyYwU?=
 =?us-ascii?Q?az7riy/GTjxPeGhWo7PG946YwaYK9HSuAWUefUXaUU3mQfD5dU7E0eUJ9YbR?=
 =?us-ascii?Q?CnXLCC9L5qXX9LcGmFHo2y23F8tvz4zp1WbZJ/yZWQkK7jBASDm1nxfx+Iln?=
 =?us-ascii?Q?RUrbtoewSjun33Ild1tV4BEMxqzKJVz/Griio05uq/0bcm/yoxU76TEfvQaN?=
 =?us-ascii?Q?JxQ5czoYd0mpPuTkyFUIuHYl9hV1Qq3tDZ9xjxRHJTGMtEIgLOF3LNYE/LUd?=
 =?us-ascii?Q?1LdU4KWPeouAuigjLqx6ppPpWi18u0EQZgBaFu4bXIyUYs+6uQ6Mme/GxDuN?=
 =?us-ascii?Q?2LncujbrDqSSa+qJXL1voh9WqzAacUPve12Ym/C4BgO7mSrgONIu2KPREyzu?=
 =?us-ascii?Q?z1erFRFodTMKrZlM/9Xko7pRpYQQ5HRe+eF3k7/+NsRsnepTKbzANxmIo/JB?=
 =?us-ascii?Q?vtX2Op1GkvW7ilqFrZZ4KPRSKTjWZNM3m39fRa1DJDGWgSTwF38aBm6L/ir/?=
 =?us-ascii?Q?nJr3Mor7pOGwEV04rRb+GuQa5fJ4m300v13nAemZk4MbDA5H5Fq161Omwhou?=
 =?us-ascii?Q?+lauvAF98Qx5hWz/p3Ge2nVA6GH6y/FCyBOZM+atvzezoMjIDcStbZFRIsPD?=
 =?us-ascii?Q?UD6FL6rb6RzhPAyFlfgZ+Y46d/vVSlT1Yp1I/kVR3LLRGpVW6zDzpCY0sa7x?=
 =?us-ascii?Q?LTJsk/GKiE1xYdDWwIhkbRQYlbZH0Q2yhaNElHdTHfggdop/41X/V92xyogd?=
 =?us-ascii?Q?1I6kJMdVE/+nphUylYKPZnLqbCsgAB1EhgXGl0GksYS6N+IG+AuO/ZnWJSZa?=
 =?us-ascii?Q?eayFMd94pEcCztNyyXiC/fjRgqbGpJqfFPQvDvskrGcgJLurvEAdpnBO2L9h?=
 =?us-ascii?Q?xhjptzcat/F/hGAJsZleVDEZ2HFCdgobvHXjBz7jmElmDHU4nkiZk1jFkOKp?=
 =?us-ascii?Q?7EWaSG0Tiy3B8ZlzcCgOmWhvQjiC4JUHUPsw5sMpmLIb2wLqzOsmkANfs8yC?=
 =?us-ascii?Q?2Q7EUPSyp/cgGpQQ6UXzru+BF8oFWYgryTG91w05X1eKBIYKaKH7+YCLjzmb?=
 =?us-ascii?Q?0jU4gch/3fHtxp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ohLy5VxrWzz475PCRDrbKmZ7LW5cMRAe4mipW56Dd2ocyknlIid+HzAMWxkx?=
 =?us-ascii?Q?wogYUBHLusq7WlN0cqusjEbn14caSKA+EQABSmUF4VWE54xhGZKD+Ju4/TGi?=
 =?us-ascii?Q?HxrU1lQSmzJKmM996QcsV8YUgCaCzFSCCCMRJjstwfcYGECg5SpF8g29PjMO?=
 =?us-ascii?Q?HKrFx/vKUnjSf/8aAxO+bpjkv8Lz+5VMlfwTQ1d0yioXTv70j0aiOeC1nkEG?=
 =?us-ascii?Q?OvrrjR8O5F/ZxWlbACnbbTnbjMZgeu46O95Dqto7c8urZKG99mP9TWGoCLcq?=
 =?us-ascii?Q?KmTBKyQr7x8hvIaiIS7i5cg4LAoWd1rmmjQnpdR18PrGlwsbxMmFtd0YOIPo?=
 =?us-ascii?Q?faQO+g/3zgVjfklD+/Q91ukbl0uxvBW+tSHynuTipZmPcp3HdPdxOhKUvMVy?=
 =?us-ascii?Q?Ql2uT6w0wD7uLUGWYJe9TG0fV7Suzro6LEsf188BqL8kCeIOKC8zQLacocnQ?=
 =?us-ascii?Q?TSF8gk8vYCVSidkLgvkJQT9EkVPHj8NberWJ5pULUpjvQhbPIkcdkKOXqA2a?=
 =?us-ascii?Q?1tASpq1/Ht8xCJ5+zsdMvyF0wxD2fDNaDz6dA3jnNxzd3nxi19neYM9KI1Ve?=
 =?us-ascii?Q?u/VzDUE0hgrpnTip1EfCngAtXR+6+fL8rMZHKJQzLGqLNZQhK9jOcX721wp8?=
 =?us-ascii?Q?/EDHMboAkJMM7ApDR2mbX3xg1w1O4TcEJJnA0+zxzzfnwOS4enybuufnMbDX?=
 =?us-ascii?Q?X7sXub8fmPIP7aHZbC//Bc7hNhoAyqM8mMLupyx6yufXe/yza2gk0cK6bJV5?=
 =?us-ascii?Q?gkjuUx3DKIORaDpYcAZR8S03kdcXcop3+hsavn9Sgu8YQB4Phu9VooPFSvtH?=
 =?us-ascii?Q?t4hBWI4HHIC6WhiapOdNsGCsqB+PAgr9061c1sQqS0au06Bmc7F8MSO4ZREP?=
 =?us-ascii?Q?7huvc/BEBgWXqfvqMvxd8A08EjPv2mxQ9MsCxgQKD2uwQ2qYqUw0cYSS/DI3?=
 =?us-ascii?Q?UQkPXvbGDPqZiyqTPVvv/NEaC+rWLTiJw292qwAdqkaAL/Siu0LnRuao7d7u?=
 =?us-ascii?Q?JNtiJeu7oLAwjCX93XBC7eaYa07asZoFm2fbtu8rwkety2RQnEIAeUFbvrlW?=
 =?us-ascii?Q?GoZdDzUuwJB3F6/GMzqoTBwE8HkIK6Zlov2NQBwJ+jqwKQZSl0TKoB/oD0xp?=
 =?us-ascii?Q?Q0BhIVKKFd+B+PYqKeP/z4/ZE6GPgCFK8VGYr5MZaM50JYvGzhTKX7x1s6sl?=
 =?us-ascii?Q?tWXTMPlz/gQEYuCi8ALpVE/jWjm4A8By1k4zz8g1A2uFSvKq4Wqvp7konvPa?=
 =?us-ascii?Q?DkiomqSM38Y540NUBbD/wggF+/pr4l5zV4/wDzIf+xcefV6dQVd1CMaKNj6n?=
 =?us-ascii?Q?iW7x7enaiFzXRF2gHWITOXGZFtaUhXE3anJX0v4CDDvsja/fZ++N6wHM7/AY?=
 =?us-ascii?Q?76CZDQ+x0dsu9Buf9M15KKHfel/7c3bE/uG8xudhLhYYepCLYHZA2WovddEC?=
 =?us-ascii?Q?fTMmt6AzU8d7XYJGPNbk/IDnfwZ/ghOEPEKT+curGJ39wcCZLb+O2pSATJaE?=
 =?us-ascii?Q?1VyqvsNnGPHZz6gKEuQQASsPE34jovkzjsaCgBcC9/dUH8Ypt8ILXpFu/ptF?=
 =?us-ascii?Q?Y8KdSfETcOqBamzDDauq5HIEyrqrVpPmabwPCx/0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e7959c-4808-401c-1898-08dd83a80b6f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 03:19:52.8320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWkTqcSWbwAqpLQMIlOKUf67geHNynemQigb6v6jqjjik7nrfMNx1wGcW55vefFTt7mCJQHCcgIocOZD3OIuJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6604

When cgroup_init() creates root_mem_cgroup through css_alloc callback,
some critical resources might not be fully initialized, forcing later
operations to perform conditional checks for resource availability.

This patch move mem_cgroup_init() to address the init order, it invoke
before cgroup_init, so, compare to subsys_initcall, it can use to prepare
some key resources before root_mem_cgroup alloc.

Signed-off-by: Huan Yang <link@vivo.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 3 +++
 init/main.c                | 2 ++
 mm/memcontrol.c            | 5 ++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5264d148bdd9..a6bbdd9cab5b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1057,6 +1057,7 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 	return id;
 }
 
+extern int mem_cgroup_init(void);
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1472,6 +1473,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 {
 	return 0;
 }
+
+static inline int mem_cgroup_init(void) { return 0; }
 #endif /* CONFIG_MEMCG */
 
 /*
diff --git a/init/main.c b/init/main.c
index 6b14e6116a1f..d9c646960fdd 100644
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
+	mem_cgroup_init();
 	cgroup_init();
 	taskstats_init_early();
 	delayacct_init();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e2ea8b8a898..64a4213227c4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5029,14 +5029,14 @@ static int __init cgroup_memory(char *s)
 __setup("cgroup.memory=", cgroup_memory);
 
 /*
- * subsys_initcall() for memory controller.
+ * Memory controller init before cgroup_init() initialize root_mem_cgroup.
  *
  * Some parts like memcg_hotplug_cpu_dead() have to be initialized from this
  * context because of lock dependencies (cgroup_lock -> cpu hotplug) but
  * basically everything that doesn't depend on a specific mem_cgroup structure
  * should be initialized from here.
  */
-static int __init mem_cgroup_init(void)
+int __init mem_cgroup_init(void)
 {
 	int cpu;
 
@@ -5057,7 +5057,6 @@ static int __init mem_cgroup_init(void)
 
 	return 0;
 }
-subsys_initcall(mem_cgroup_init);
 
 #ifdef CONFIG_SWAP
 /**
-- 
2.48.1


