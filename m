Return-Path: <cgroups+bounces-13213-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3860D2084A
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B001C301EC64
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F492FFDC4;
	Wed, 14 Jan 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g8mgZCQ8"
X-Original-To: cgroups@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C82D8773;
	Wed, 14 Jan 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411351; cv=fail; b=SayPfxbHxQ0UrWE1IxSWo7nsLOHc0uyALNr12Sk86mcIRRK5m5OmE23pIxscDO2hXbsEfTf3YtEEjrHQmiXd4jUlgzXr2hSQPmixC99zVXHJaXaIXc7LqDaF720pI19OjFj/VKJ2kGPH6Neb4KgvxtN2sM1ghiIRUxZdTe0QR3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411351; c=relaxed/simple;
	bh=CLLEItyHx2aMPp407K9oO1v/K6BV4KUgVC4qE5qeIVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nTfSmJPtZ6Sy3SZqEJ0wMR5tXAS3W9eZmMMjIwK8A+ruKqLSZs25OrGT1BwlZhV6EnTeeu54rA67o2538sfP7YAHRzkx7s09oaJet7pGxQqNA0ZvOm7mqaj+atqrspR307iZbM3qe8b6Q4EGHNUNCQCZG8CgktrGqHljIPeXMks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g8mgZCQ8; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6LYlHqO5m6zhaIxImaz1MUnJLtAIy1D3Y9WDNzu7MzsP7mxkbUO5Kfptykqg3N0ItkSxeJhUDNNjbK3Vcs3eJoukuZ6zYZY9tkTWU+Ak1A+OCZd8LDhvP8hk0ApssTEOYcUfd2AQaap/Mo3r5JRKZrL4IhJhhXKDOmsLRPvQp0629BgkN6aub0uN7cGaQmGP+1859S3rucGhohaOpSWymubXSV15pwXOksUE9C1DY1fz8s0PR/VQD1r6Lb69eyyre2pW8wfaxrT6f4Nducopjq6vtmBK65X/zmlgxqYwEOGT4FaU+YtRS+gimYscwpRn5wm+EYoax8KGc+P8FbjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZgACuKl9vE4tSYzYVccCS84u8QEBci4DZNnybR1/rA=;
 b=T96rghRUXd8OvaESE4NehIMl1CToVli9KP1UOynF/O85Rew7dxMC00P0AcaBlOsCe53F/VadSwK4qCVCw68OGWa5eNm1xWd33/dxuPwaztdsEF3PMdqwkN+Y3TiE4dD0idJ9Rqq/ARKWST7Fy/8GD2CljN25lwY6ToIEi9oGUM34u9H+CxY6BfLF6AxgmHHp2/KPWJaVlwoyOhoQrVE0ySUSofWw2EAwuXkJy8B9+Pa8la2pBoge2G/uYbKyl5fqAZIKMm/0rgpVUZBdZjRoRt50o10HD68xeXB94j/dddjBb65yvLYnPVJ3NJ4Ix44tlUJKs/hkvDESz29gvarUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZgACuKl9vE4tSYzYVccCS84u8QEBci4DZNnybR1/rA=;
 b=g8mgZCQ8863Vc36n0vMtYiqJsPrprLx47F83p1+WoNaTC+2uXAZdMOznyd51tBW07NoGNUuRRS6BT5TgoV0/Mk30w+nmZiomU6bERwiKjPWS4g/dJUjnOVncwm9dn0+TtMWiw6J+YBWwA9jdGRc92UjFPbU4y+Y78RxYPs7oZgY7GlGyP016iMmCgN7p3JIg3z2PevCN3dZ3qDREhft8Ewzd4+GMwEZfipbU6JNRFbsdDA3LYCw4SgANyOSbPMNBZdkszm3KBoi2YPNgXQ1rL4xRwMDnODHCnTJ/Esp8QC+MlVwFWnYjJZPcO0TEzw9CA7FYgUQhyj4CtHetRe+BXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:22:24 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 17:22:24 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rakie Kim <rakie.kim@sk.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: use nodes_and() return value to simplify client code
Date: Wed, 14 Jan 2026 12:22:14 -0500
Message-ID: <20260114172217.861204-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114172217.861204-1-ynorov@nvidia.com>
References: <20260114172217.861204-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:408:e7::22) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9333be-7ecf-4d25-5751-08de53917bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IOWIZDGa5NTkZdzz9u8ccr+Yj4ByXhmLAJKxWuK6EJVppSE4mQgS6NlttLkB?=
 =?us-ascii?Q?hUQn+Gmoxtdkeh5tlm2TUg3IItDEwpX+rHTC+nrmJAilY/9aCsystjg1k3T7?=
 =?us-ascii?Q?APkkzhEJlekRM6RpcWmrXVY1Hb9Ja86Z+2OGJ1y0FXfbjYlHlUUOpeyMfMA1?=
 =?us-ascii?Q?eESMbRh32UEUc2B0P7FxXdWNYNSU70i0D6sz4dNFb9KXAhcMwHMurE2C6P/G?=
 =?us-ascii?Q?zyNTe38A1Ba16yNPr9F3NTfRJBCFcxk14pwfJb0WJpTWJaFTSqFikQBK4DuI?=
 =?us-ascii?Q?DgBA8HKA7JV/0yi2QBxvFtGc/GqiMSPk9o3n5YVSw0QwA0TzszsQ1q5OSTDv?=
 =?us-ascii?Q?bzt3e9GrbSlu/sEwNHzCzHMsTvocANcViUg0A4Zh7NcMmumNIySzy0VaDtRZ?=
 =?us-ascii?Q?D294NEYeaebLB5d9JwQbgP7WEnEZuVe9wO/VrgPFMUJ9/4yFIIMCFCwRKTaL?=
 =?us-ascii?Q?LGZYugohMxDcV9gNUHrHePZTVsh3kWdtwaQlFH9lXZEsDqs/7dgF6Uy+HsXE?=
 =?us-ascii?Q?GsfkKHw/GRMakjHy7UVMsniS4WtRiT9vteSspqp0o8FK5LJpfuPM7CMLSQ/B?=
 =?us-ascii?Q?SiZEJJA9v1hYRDFRiHDUFRJ7RKqqQo+PLOGwWXLgU5Q5Rcqh7MZTccCZccf+?=
 =?us-ascii?Q?mLG8Y1Nx9KIVIgbAE+SLY3ggmPJWYxht5W9CH052aa712dVpZAmWfAeUOWWr?=
 =?us-ascii?Q?UEwx3ssIf/0Mxg4a1LFmyccyQa2SGGS2L9GCVQ5cH2jpmkf/D5IgZxeP9peU?=
 =?us-ascii?Q?KAQ8mva1xjT2+xINLRLogmp12CjdTSX7Ypg3uIffAZrepLD73QgWDFhFV+Jq?=
 =?us-ascii?Q?og0R1MB92dr0tIatkrlXwnKsanQUY3s5xCaZK/rMbMjjypeioVV5EhAi1AG6?=
 =?us-ascii?Q?VZLYO3Roo0nQSP30t/dOQos2vDvh7us/QhWJTsp6UJ/dNoFGZASDep9l046C?=
 =?us-ascii?Q?ibv/wGJISJ2e3ykye/A8UPdGhdvkuCSUyyAHvz3u+5Sbf6d/1/R956TnEwLs?=
 =?us-ascii?Q?N86zxinvaTYcwd+8lRbtMb2Fs08vPmTFji5yoVkCYvJ/t+kkcezPBTMz9mcE?=
 =?us-ascii?Q?tixcRhxISdhGslrDL4YoCH3zbv9iXBn3UBBzSFK72j1R+EqVXweZdW91ZScv?=
 =?us-ascii?Q?yVjIVvtCHzHgLCGftU+KA00eeli3i9Yy2pFeF/BTER1WRk92JhZfUAm1mzj+?=
 =?us-ascii?Q?XXHwLcR1b/YWE+wYZRN47WUVhnrGellgTUDoNnK/qgr5e6aS7iJD4a+RyPI1?=
 =?us-ascii?Q?PYreZ4ssBFe3l2bpGZjrA1ANMAg7r7wO5WDwEeIu0R7TEtUMdFvCnJLufigA?=
 =?us-ascii?Q?itG4SqdXJ2O3+xcS4NZ2KcQm4A1nWJAMmj0Elf6BGoECq0jELK+BptxwHtwV?=
 =?us-ascii?Q?Uwd3p8wzf2XQ+3+yhWkVT53F8rI8pOdC9tIwFpfzfgVcoZjE9oFzhByxCjBb?=
 =?us-ascii?Q?dm32OXHS3J7Rt27ejIj0D4apZ8eS15L8rwtdEW1Th5goJX4ApdWsObL3jSNw?=
 =?us-ascii?Q?YB9hDsalVorsr9vB3PVUYUf/9bxqWthJ8TEfWEAWgXw2AZTYSXvFS9uG/7VW?=
 =?us-ascii?Q?3nh+0+LfXOUwHhdn/TmEK/u5ga2mRxW1EgBAC0XEInrdbWBtXGOTUkbWjW/c?=
 =?us-ascii?Q?Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vB/7NwnyNaXnkl638OUzAH2SQcePaIymGpFX2bcKYrBttTtQeSNEkwGSRFKp?=
 =?us-ascii?Q?3OhqSJH0rI0QSeIUtpqH60+wCNuNDyt7jULIeNCWx3kUdHjA4UC6PF2oScm2?=
 =?us-ascii?Q?Rgn7UyLXvSvyLy+9xh1rSTNFzikUD/GFHgXOWyLGjGaUFE4vmPVOKjREl4Fy?=
 =?us-ascii?Q?CM7kXdJu2alVCrBi3BdwHmbz4YSpux4YsjcLtCdtWD6dZtGR1vSLPUgNQCri?=
 =?us-ascii?Q?K3IFj165JK1q0M3eQd5pXgiLnUewQ+ckgF7cS4W1HWEDmIkTlyvyz+AqHKcF?=
 =?us-ascii?Q?+WVB3IpeBD4fcb/qK/MpYK10uZkAddTmIJFB731EbL2P3MXeVX7HG7KNKftl?=
 =?us-ascii?Q?fNPVxqI1r9Hbfn7/JW2L1ckJYTIOIQeZDcHA+GByeBN6pMEv7moSDhrlZwBT?=
 =?us-ascii?Q?1SaGTmQUnzOWeAo7Vvc2U++UwNhdvZoSkuYg6YYvlzuQR0glQ3F5TD11GAOb?=
 =?us-ascii?Q?waDO0uUEVwcAC9hrCVd8czT/WAhk3DQHzMhf0q1fy/PbkrEV34Z3NWXKXRTa?=
 =?us-ascii?Q?CJOmIzneRhZ1dWRO90LG+X77/wqxvDNvA20xacPL6wJHwtjRns5YcJ/aum6W?=
 =?us-ascii?Q?Wl2R2Edm9Kq4R7lf3mb2PARuoNWU3hd+5ksDYqG1XeDFxVY2LQhpJ7GNauG9?=
 =?us-ascii?Q?RD2bq6IQuTD9+wA7WPlfpvXnfIPmxU3mVqqKyC4ikrxWkPQj95NeUeZniDAV?=
 =?us-ascii?Q?Q1rFTurcbxJTkPjBmmBj/I6BmP2vQ0LqxSv9Zwjg+obS2pwidrUyw6JZHCe3?=
 =?us-ascii?Q?Bm8wg+mNT5o6vidjnj0GiajVdCb9yRey5EFnYNUr4J16htvXNlqxylNa5bCx?=
 =?us-ascii?Q?od3g33p/oWee9Gacne47aMh17AsncqXKjGExDnTRrD5kw6bdc7Iy0bMXp+KL?=
 =?us-ascii?Q?BWVSuRNIDBZQCGpHC017LrggtZHUMc4ZLHYTpeLMxwOA6gYgTFwNmspmp5w5?=
 =?us-ascii?Q?4odXkDIv/EzMbLMO/6KagQ8wCr6+9fxHMk3XE6XRlX4GUB6gkR/wfXRew68y?=
 =?us-ascii?Q?GVJ8yuG+WMVurmWqGpykrNCGkPR3k5lRMkDIW0YPqoQYrQBUQpitKX7l77mr?=
 =?us-ascii?Q?zZuMhrEhWYf1Y070pkx4xsXNCI8iGPIjgOxB6uKsvYn1ElnuuQ0ePqI/AaPZ?=
 =?us-ascii?Q?P8OwFgcOMK7OzN7PIqqPPQJcfkLtXMcayzD9Kfbgj0TIeQLq9Y467fr4vjWy?=
 =?us-ascii?Q?ttNQam7Pne0jjeX+jEUBaHb+llwd47ancSvQmYNFa118S+KHX704jubj28Ch?=
 =?us-ascii?Q?oiXrbwZxGMgknNRLpIeFH7Y5B0g+r9OD6DKmSvkd13dYkOkp5lm/ttNXSl5n?=
 =?us-ascii?Q?KL+DxDMJ42lkAJs9NTabRbyjQJRqcpgq6CS+9DpYnmx+d4iAHIgr+ISfQYlN?=
 =?us-ascii?Q?1eRWzTy8ApZhxDTlvp2I+d5YKWSVZtiL9jh+9tBmsl1/e0UWB60zNyymhLBW?=
 =?us-ascii?Q?PivLAylu6sqaMOmJrQl2pMvagc6E1yqvA4y+UCOrlFojCdBMcrQppdJI8G4V?=
 =?us-ascii?Q?fpZ3jkSpr+NDdvKZSb3b//ZTt7r2867Fd4YdomVVeI5w+bOL+uGDzPFTXEEj?=
 =?us-ascii?Q?0+nueJL4tjOmw9LZI/buJA+pZ5rhR7Mi8Wrq+M7+PSB/3zcSEqHtjy/1ALLP?=
 =?us-ascii?Q?g9MndRUsWwMC6NpltuOdTgIcdythWQsRIrYswIElvGQZpXpIoTyakfL5Qs4S?=
 =?us-ascii?Q?hfLRZ/rVthgttnpv5nF1I0SIGf0sNLfekxv95/67A4nhj1Esp+zRa1ho9Oin?=
 =?us-ascii?Q?K0AvneW0nJwdJvc5NCI74ADmO7LcMoThH4eLhwWQfwThL5SbKjhJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9333be-7ecf-4d25-5751-08de53917bb9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:22:24.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xyl0a6ysaNi6OVVLf17vriIZyjtARqyA7Ye8q04P6FkiEFRl57iN1CaeAycMbIzGxYFXFqTbMILrfmZjj1Uwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B

establish_demotion_targets() and kernel_migrate_pages() call
node_empty() immediately after calling nodes_and(). Now that
nodes_and() return false if nodemask is empty, drop the latter.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 mm/memory-tiers.c | 3 +--
 mm/mempolicy.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 864811fff409..2cbef49a587d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -475,8 +475,7 @@ static void establish_demotion_targets(void)
 	 */
 	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
 		tier_nodes = get_memtier_nodemask(memtier);
-		nodes_and(tier_nodes, node_states[N_CPU], tier_nodes);
-		if (!nodes_empty(tier_nodes)) {
+		if (nodes_and(tier_nodes, node_states[N_CPU], tier_nodes)) {
 			/*
 			 * abstract distance below the max value of this memtier
 			 * is considered toptier.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 68a98ba57882..92a0bf7619a2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1909,8 +1909,7 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 	}
 
 	task_nodes = cpuset_mems_allowed(current);
-	nodes_and(*new, *new, task_nodes);
-	if (nodes_empty(*new))
+	if (!nodes_and(*new, *new, task_nodes))
 		goto out_put;
 
 	err = security_task_movememory(task);
-- 
2.43.0


