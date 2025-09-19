Return-Path: <cgroups+bounces-10293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D78AB8A5B4
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24071169ECB
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E226531BC8E;
	Fri, 19 Sep 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W+VEj1zS"
X-Original-To: cgroups@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0C31A819;
	Fri, 19 Sep 2025 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296372; cv=fail; b=BOprlHX2nmLEulojUxib6TEu4FhhN3J9qKzH7ytmFanbaecaA8ZJnUVObklaogGrl/FyTZ2zSfERJt7knBOP6aShbB3rBVaRFh+R/vrW/1G2wD1P8zrDZNItGDY/F0UvIWVccOKw3WRBWRBWginsPo75hr6PMs9Mz+XSkFpic0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296372; c=relaxed/simple;
	bh=UrO/0BPl+Sqr/J5nrv/WJWk3SOfYnetobw9HDqlH/DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rK20cn+rIEVR4weQg9Uk8vE6+QCWnjoG0MKX7YZOJwllRt0J3MAwp2dHOo/m+BemTDuToQv9OoFHI67huSQO7jdx/TZmMyuOhuWMvNTw9PeU0mwrrX+f+yFT/nGXagPZVkWSTmQbLxrOtTbzH35UADI6cODH37s9PTBm0dRptJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W+VEj1zS; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=repGRHn0oZkXdyZJFCQ4GMjZv8MUEJlpF3kPU2LKkmpjmuAFe6hjL2X15OmcdUoINdVUXXyl3j0ZZS0kVCUXN5Q6mrDv7aDPRTxSBEuulMNylZ9/eQ58cAp4ZSyg2pswQicK20TyoBaqUcTeaFc8ddXHmNTvRI5iDCPGR1mvjR2h5V9BF1G2w8Z6BzrbZAYu7msWHaAy379ASzKXEpIu2I/VChwmmx8GfNOUmu0pLUzKWEXEAmt1vZA49gfB+xQYpeTA0UWluCvSJLZziBsiIuFAk8bpZJpOnFAvHaUpqRlej5ZayVS5Wxs2Xzfl0T7BVEYyIx3Amo/c9UYKa4vWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVbrm7mVv1n2mD5F4qZ02G2kUWK1URtIE1tShgYizjA=;
 b=VC8p3D3iKWBppXQehh67UzANVukNuKNGOA9bxXXn7ahyHSIBub2bbq2JLPkrifC85KdWA08J7obuftdjtA1S4nkkyNl/gASMVzIJcT8eXBWUtbvnrlQQCkBNgu6gXQk+qKShl2VRlukygSQ2lJYWgmo3idSICSfZzPXz+Ko4KP4jBxLkKOULcZSNu9Hrsyh7Lpyj3ElBnSsoSuPTi7HQ6lJwyolne2CG7bZ76bcK+ZexO5E/hp9Dg8kT+lakexBZwbRMCUMnTORYIUoYmMsgXbEt3rIlWYSf47BcdGdZl5Dc+VwrSa2qJMRIZG3vsG56w9JtQSEZJq1+CzS02u5PTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVbrm7mVv1n2mD5F4qZ02G2kUWK1URtIE1tShgYizjA=;
 b=W+VEj1zSKVKKtcWJGnZH4BJcuf/+5f1NB22znEkq1bheY5PWpzqQq7E44FLXbO5jBvFjwUikEM1+B70+sY4i/S5d56/wIGBAHnh1RlQdT+1HK/0+qONZQVrrmtGlvlkTC0M6enTNzDn+GAbHHzPik77d46kj2VDPAdbmNrf1xGwOzcDWuqAtKPK5CnRh2sNff1lrl8vwpihov+xklGW87eS2uKLp2+JDEaOmXxs1lDyyp4CHzFhCx1/x1p9PjTebdnW6MKUh/10R4XgJU1KPOTuQqEAynBO9UFka/fCKe4fIYm6EvXQ+kckbsPBUc2vpJzZhUUnF3msAr6QnF4CmTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 15:39:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 15:39:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/4] mm: thp: introduce folio_split_queue_lock and its
 variants
Date: Fri, 19 Sep 2025 11:39:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E62A91B2-4221-43B2-9C17-1E48AA5D5544@nvidia.com>
In-Reply-To: <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2253cb1b-5380-4c34-84b4-08ddf792b6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l2MPTlMCES2d+Oe1XF4DzQOcPE8EXcFkwaR3vwyfH/JAfF2K6PrnzJ8dFL19?=
 =?us-ascii?Q?s6+TqXUk1f/F2B4UcyfSIE3FbfMkhzvl1tF0RuR9juNOD5bZZ/gSnpRRtuPX?=
 =?us-ascii?Q?f0EOgIHR8QlBxkg6TAxoddLvOVNn95qYXh9FJAfmE1hiTSWuD9PN8jB5+/+e?=
 =?us-ascii?Q?jfWnOedm9MfGnoPukWLgBHgqxmrJWUjVQHBhLlV40giEeCRqhA5zbakRlFjl?=
 =?us-ascii?Q?7P492QwIQt4Fk0bE1WWsyI6a1yx4gR3SKfNEhrZBrNRq87V+MGDltQ/dIm0F?=
 =?us-ascii?Q?oEStgOf3BfyyIJ4riTB2kZ1V97ZV4KtYLdao5fNN17rTh0RXsQ0nkPjmFcC8?=
 =?us-ascii?Q?xIzsnjDRpDcV1kpmZpDTAk2vyK9+wKrVZU/x2o2btTfKvCaErlfFrHKmcJ/r?=
 =?us-ascii?Q?w0Ss3LhYWWTWNPNtV2YYG3dfzN9si8cccsKRIyBemG+8y1TmyfiwmbR98377?=
 =?us-ascii?Q?8DnDHG6E/IZJQCC0kACaUwinj463ANpc19lPAKA1mLZ3IF2dJPhM9wNxle3T?=
 =?us-ascii?Q?SYO2JJrIasqpbg+tmQsfXbHYnEm0JElnZDbPT86w75bsu1pe3JBeJswsEuYe?=
 =?us-ascii?Q?7pPWp528NTZ0xR+kgxDTDZqiSLIidr5aMSBkTFcXZ+r5GrGwrk+HthKKqfhw?=
 =?us-ascii?Q?TG3yTvnk+1jZ47OlOW7Ht/wpsWS5jihu9dUdz3meY2p3aN/GYyS3giHb4BMN?=
 =?us-ascii?Q?HdARn2iiHg42B9fltjlhZNdehQQ+TnaXh516DH4jmMJ1ZRPTIzaDB7Z38D4t?=
 =?us-ascii?Q?tyemJxTgh3Eg7bEJWeS3sxlv2pl/YFlOVnPJgqJa13+ZdyitILaa1qF4uWzH?=
 =?us-ascii?Q?jeEFskBBhk5PDAfNKVxuIWrkEIo6iujXgoc/Izzid3koXxE2rEbvP8wCcgVV?=
 =?us-ascii?Q?1JCH/QjcsuAzy74TB5gxqONHKh5O7SeV0U0b5PCD07WYkcjxQIaaLZvjQPRZ?=
 =?us-ascii?Q?7m/DJGQTH6KTnuS+ebPz/TTKoccBut0GGJYKEu+306BSglOpO/pr/YGSj6Qa?=
 =?us-ascii?Q?WQIVgq68P85ZdJpkBICl8ZwJIzAhjaDsCoTNVxbMQ/i63lcczLyo1MpkkeW3?=
 =?us-ascii?Q?azyVO27KHztHMPtIXXBtjY/6Z7V9NkwByDpxHE2gs/4fLQ8OT7AyCsvipNdO?=
 =?us-ascii?Q?/9B3gw6K/d4tW0waMrlm0AgM3GmtGzpTYIo2v7ZvZNaFz9FTCLaxlkEfHQ6k?=
 =?us-ascii?Q?abC5XPxYfLFsmEEvs9rTUwVcslCMN42wMWB7HQowXXp8hC7WNTQzA42y2lHk?=
 =?us-ascii?Q?9tUMQpfmIwnY9eJQ/zd2nkFMqP9WAio77YJs2hTyJQqqs/aG8jzWDU9RhGjX?=
 =?us-ascii?Q?LMxW+M0sDZz1bFLRnFXnj68AyHYDevi51qiUY5T+qG9CmcMxP8/SIaeR54AK?=
 =?us-ascii?Q?cXlwqigTbmqeeRAcMqFgXB5BP1lNwLFIoernD8AlpJAqXCt5LxQFncjUyNMy?=
 =?us-ascii?Q?QfRXkYvAWrU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWoKcJ3ix7fGU7bF4LA22n3kNF3+nP9dQPJnM2LQFdrqIBU60g9HM2s5WTNA?=
 =?us-ascii?Q?W9jyCPaL5FvL470DffR/M0Tj3wVzXO6N6T57dTCJ035bzI+4Bwzc//BVjqOu?=
 =?us-ascii?Q?vLllbUs76+EAKd2ztje5Keq80ZtcKyIgs6FIrlFYEJAAPUZ1L4mCBoWZhk1I?=
 =?us-ascii?Q?9EWC8grPkzy1xvRxdvtFIiODoIJGwMCiP/H9iVn8Cze1gVl9v9aWuvyGmHYS?=
 =?us-ascii?Q?c3OynI52yd688heFeUqPXGzd5zQUPcDCqGQLF5aLTpoDY0OuoJ39LKavKni9?=
 =?us-ascii?Q?SoZdSlQXoRQ3KmYLiN/lFe8fAl8YbgZHgfVi1Mb8a0Q4ZKdMLtRTans83M4S?=
 =?us-ascii?Q?v5N8sx32C5Rzi1qxyEV6D3Vt7tPDnam6VLxsX525nDhobaA+Hx4VScEZdvUz?=
 =?us-ascii?Q?WK5UyMynczCX5HA/oFVuMxoH/M95F3RzAaKBqKwbE47Sr8uAq2I9XWef0lDG?=
 =?us-ascii?Q?Q8b7WfG4PlzoP6L5Stnw8F9MuJQuB8AmpoaGAMVBsrX2Ag6PeswLu35uqTYx?=
 =?us-ascii?Q?Foh9+IxnWisROUp+v8A8YmkzFS/lEPeTy6qvjWxHTYsuoXf9U0md7KI8k7Xq?=
 =?us-ascii?Q?99i6MNftrsjUqhegXKjq+MUbU1Wl0Xv44hPE6wub3EzhJb0/BCZljO1lNNRe?=
 =?us-ascii?Q?rdCAG7C990S6M6H17yyUxlTyGbMpL7nYN5sIwvNw2X/PjuxOxqK8yZhJiLm9?=
 =?us-ascii?Q?hPP4niv3S6zLVUweq/bykDLOf501XfgC4m5VWrVw0zQcTaWZ9xs7euVkoCo7?=
 =?us-ascii?Q?5fXhO7au8UDyFkj6Clrb96gCUOZBs1x4cz+T4NGU4stMbAWkxGFeczeE764t?=
 =?us-ascii?Q?ss0KrQ+r442XiwCM757AIWK6Aes4c2BG34Zt98V/pwVyRScN4IBR9oDYOUVB?=
 =?us-ascii?Q?os6UrfhJgZIx+lfgXM3dqNfJwkP8WK5uQJe4JfVzk9etg24D3HmAcyDva4KV?=
 =?us-ascii?Q?keHkN9Avwv4N70uVbwuJsnW5bj8YsioZ/0Y36Xy9sQQr3krNMMuHocSmMSVL?=
 =?us-ascii?Q?G7WrQBNmjfWyGU6nmeUn/Aq0CJ3Pesao2X1a3E17x1PzUw5jImkxUi6Ysgdb?=
 =?us-ascii?Q?VpVaw1gTtuHPHmxHZdVVvLouB/jfiZAyZpoEwnGS1ZF24/1Xwtxg/Q9env4/?=
 =?us-ascii?Q?JswAp7ipDQSJggMS5IPBiuP0/aYFqQLo2b2HejHNDvSa5JoGCH6ZWwWj1gYX?=
 =?us-ascii?Q?qiZUwuGRxkEZqXu+L3z7eqYW39GH6Hs2n7B7dyAAJXIWrL4xR/PPjf2KQXI+?=
 =?us-ascii?Q?y/z3YgnY7F8Yl55oj0kN3Vl6xi0HNyTjV6fYVNb0gTpvOD/Am+G3ufikF9Zc?=
 =?us-ascii?Q?eL+hYnF6Oi4aXuyAjBp01jjDaJwQPWXfi5Me+RKWpFQj5orCFMqYddoEJNOY?=
 =?us-ascii?Q?j6VfzffsuKrH13Lj3AwPOippZ0FeZohHXASk36OWkJxo+jjSkPCF/ici+2B/?=
 =?us-ascii?Q?7myoqtMwd5KZJFFEOaNUr4+C50RSaUljd0Y0Wttq82DdFDBymuImGqlNCExc?=
 =?us-ascii?Q?i3qAl8NjbIajvTOak1VY13/1VOTIA/++APlu/jAR/43prXfMgxggyOYdBYA+?=
 =?us-ascii?Q?96OCHPD7cKTnoblX2eLXbs6rWTJHMcFe7vWaOt1G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2253cb1b-5380-4c34-84b4-08ddf792b6fa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:39:26.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij6onDW6qRkZXlKt7doZalRzSzqmtbkH750GSZXASfDbLuFs0EdyZCrsWWpZFclR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723

On 18 Sep 2025, at 23:46, Qi Zheng wrote:

> From: Muchun Song <songmuchun@bytedance.com>
>
> In future memcg removal, the binding between a folio and a memcg may
> change, making the split lock within the memcg unstable when held.
>
> A new approach is required to reparent the split queue to its parent. This
> patch starts introducing a unified way to acquire the split lock for
> future work.
>
> It's a code-only refactoring with no functional changes.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/memcontrol.h | 10 +++++
>  mm/huge_memory.c           | 89 ++++++++++++++++++++++++++------------
>  2 files changed, 71 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 16fe0306e50ea..99876af13c315 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1662,6 +1662,11 @@ int alloc_shrinker_info(struct mem_cgroup *memcg);
>  void free_shrinker_info(struct mem_cgroup *memcg);
>  void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
>  void reparent_shrinker_deferred(struct mem_cgroup *memcg);
> +
> +static inline int shrinker_id(struct shrinker *shrinker)
> +{
> +	return shrinker->id;
> +}
>  #else
>  #define mem_cgroup_sockets_enabled 0
>
> @@ -1693,6 +1698,11 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
>  				    int nid, int shrinker_id)
>  {
>  }
> +
> +static inline int shrinker_id(struct shrinker *shrinker)
> +{
> +	return -1;
> +}
>  #endif
>
>  #ifdef CONFIG_MEMCG
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 582628ddf3f33..d34516a22f5bb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1078,26 +1078,62 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>
>  #ifdef CONFIG_MEMCG
>  static inline
> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> +struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
> +					   struct deferred_split *queue)
>  {
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> -
> -	if (memcg)
> -		return &memcg->deferred_split_queue;
> -	else
> -		return &pgdat->deferred_split_queue;
> +	if (mem_cgroup_disabled())
> +		return NULL;
> +	if (&NODE_DATA(folio_nid(folio))->deferred_split_queue == queue)
> +		return NULL;
> +	return container_of(queue, struct mem_cgroup, deferred_split_queue);
>  }
>  #else
>  static inline
> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> +struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
> +					   struct deferred_split *queue)
>  {
> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> -
> -	return &pgdat->deferred_split_queue;
> +	return NULL;
>  }
>  #endif
>
> +static struct deferred_split *folio_split_queue_lock(struct folio *folio)
> +{
> +	struct mem_cgroup *memcg;
> +	struct deferred_split *queue;
> +
> +	memcg = folio_memcg(folio);
> +	queue = memcg ? &memcg->deferred_split_queue :
> +			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
> +	spin_lock(&queue->split_queue_lock);
> +
> +	return queue;
> +}
> +
> +static struct deferred_split *
> +folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
> +{
> +	struct mem_cgroup *memcg;
> +	struct deferred_split *queue;
> +
> +	memcg = folio_memcg(folio);
> +	queue = memcg ? &memcg->deferred_split_queue :
> +			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
> +	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> +
> +	return queue;
> +}

A helper function to get queue from a folio would get rid of duplicated
code in the two functions above. Hmm, that is the deleted
get_deferred_split_queue(). So probably retain it.

Otherwise, LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

