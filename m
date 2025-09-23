Return-Path: <cgroups+bounces-10400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E69BB96A20
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF36A4862EC
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B44257820;
	Tue, 23 Sep 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hj/zZzXe"
X-Original-To: cgroups@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E173256C8D;
	Tue, 23 Sep 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642255; cv=fail; b=AU5VYdCKH7BrjcbUVFZBo7y+yUoeNO/PsN9drkhimC9Ghu8d5TT8eY/v6znl9XXT5c3ysYvR2wcIGEMKp6WJNZczAT0ewlzrWkLTGrqtO7qkDunJ4kQ8TGHq7duY4rcbRXsn+8czkwrJRi5Dotq1s02GKUC/Qi+waU1rgDZCIPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642255; c=relaxed/simple;
	bh=arFuc7nSOeo7G7SfC0+avTbMH6Skkfs1oeiYT++qvmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgC5WxlbQZCgwIENySWXFTchQJbLrkj/ffla0TuO9ZIlGn+CRhwuOfnHoCdhmpcxOyqEZk5GjoUZhqkdoFYYSckQjIeGm4ikrryPbHo5EjX6TgfhAzhl2huyZvTFSQxys9y61pPvwkkjM4BJiJDnxaugvMijszsuzGfVxbHURYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hj/zZzXe; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWhdGt7ctZtinAgr7tw/gWVHzTrUrpFU4AOMIH3FwqOmUxpeLG+hjobZ+u0sYikhGz4Zk7/EwRkJFF5i63TuoPdIOMkBsgrul6/EjS0OGFXUzDhu4dWwEkBl4NugaihzHXCuvEFFwzOFMcxKvf5/vuy6W6jj/S2tRjKMwkIKPGjSjSMsfowDYfjeEA4X6pvOH5S26bJOLjTwW77CMhvPmU49TS2I2weSwokM3+yb597iQXzXmt58ANAOKgZaOytTPWl7DSKARSam3BaFzUhelhx9k68sIX5m6UxBX7pZ0t9MjaCdieEuWlsojFGGpvlFZ69ktntYFYciJNoywajFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUAFnOtD6hOK3vUMhEzjjGAdHqcxnHYcIN3u0IGALV0=;
 b=JbXoKJkKh2vSYMt1+U6SdybCSkvuQj9OJnLKtNNyCAL+uvtlEqrLU0Mw2HZLqPs6a0TaTb+s0BTVTnMaGLZjFU0xPimU943gKGd1RNlLbGxhSgHjnskFOaGSR4SAhIm8hgdFGRKTUQND+6eB8WNMkfeJ3IK7uOCo0IwZTmIL8YYCEx41FZSn8JDgMlR/66taYv38yKs4p0jy2m2CIkEu2tdvcmrWOaMbwVEmoCA/7zh6bK/n0uGEX+Hv9Y6mnIRmGGXX0U1yj1bE8stC8r0HgPAOmVvPXSsOO2AJBRXNY0goxP5/F/1Q31HNhnpw/bFbjvgY5R8UYjKsWo6VafqyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUAFnOtD6hOK3vUMhEzjjGAdHqcxnHYcIN3u0IGALV0=;
 b=hj/zZzXeOXC0Y7gsrrG+muUs4ur7BEKRCSg4jPCGFdbiA6mIyAFZjzgXPmwbiTfw1IJxTYsvAFl4zPhqZsfIzl9dq1DvapZCgspvG7p+3jvjdKAgvrcY5twth3E4wpGbQDEXBKVxqfErIYfVM+KdTzdJQ78eyFlVNI+hE2gPkLltrh1Aq/Dpc9PccrsZ8BaW9p6bGwXzAInnOoZVWKs3JbZ4NFaZzKugxsroQeWK76lwOgkTHs6596U/MkzGgB1LobQWUFGMYu24qumd4Ln4kYHSni3JTpbo2TtACpbLZ93C3tAcb0dL/MBGUaxDqMzq4/w+Ue6XL5vYfxBpxay/HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 15:44:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:44:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
Date: Tue, 23 Sep 2025 11:44:03 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <303D9A50-FC6D-4710-8405-2283A05CD41D@nvidia.com>
In-Reply-To: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:408:fc::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3261c9d2-87dd-4429-f207-08ddfab807e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7NydiKtIlIfIfX2wrCSPxI5/gI+rBoows0RxN6yiBtJKVe6s9f0xANpFWgAD?=
 =?us-ascii?Q?sA9b0DvuzvGsnerrOCJ0jBOWOQR+LPt+u9++d9nlbm/5jD0o4AgQXfkna7+/?=
 =?us-ascii?Q?MfSfeWWgn554kbf9m6GnQIHKPcCTPDYEJD53TcJ0Og0DstmkAUMOJJ2e9yZl?=
 =?us-ascii?Q?9M8XtWuqdhlWDD+1rRQbmCWwSRyk1gv0GjeL5j9WSMcB5BKznXNN6B4zE18z?=
 =?us-ascii?Q?bEDcVe7PX1VgUs47UD2jaF1PJaVX349zR7eOh0XydUvUOX2Tr0QUnzIBeiqd?=
 =?us-ascii?Q?8wm51hoc+98IDI2OtfPuaAxc3gyy4vrBpBFXEHd8z4g74rgEVH3YTjebpyi3?=
 =?us-ascii?Q?ybRr6IznDE4pzG5eDZi4JxQS+y+hYPP5bEfBLt+8qOzU0eeagGofhlQRvzCG?=
 =?us-ascii?Q?MOKD9EXwRZBf0JfRGphqd/DDtD2+H22o1gNvLXchT104fU9wU6VKRw6AJt1i?=
 =?us-ascii?Q?TWzIpmT7upwbNakVSg0e5F1lOlwBATQeNLxdR/Yy2HAa2oaD7NHynzxIlAf/?=
 =?us-ascii?Q?kl3tR1JdA0ILzqnEqxPckwjLwa/FADnbwA4F03dtTJ+ghVGSMEApx760XeYx?=
 =?us-ascii?Q?CvTEMI9nFHV5pXCR7E8lGoShMmIRqspu3YhjntIiJ0D6WrvthtRymDRDymQG?=
 =?us-ascii?Q?ifjNqNOHpZvM8MiAcJKATWBmkAuVpFCCe4UPuL2pPXSIqXrXYhUTYmgaCTxd?=
 =?us-ascii?Q?kp3LgY39QW/rTq8slVngPNdOn3iYgPdg2Lt/Ax5VAxUU8ddTzGBLDLEO5B3n?=
 =?us-ascii?Q?Qh40jn5HSuoKc3Tca2zSXWCq26PfQ3Cc8P8VT012EPjOW1CaCBZ8+e+Jc2w+?=
 =?us-ascii?Q?Ps9j5d0raMu8jII++7k5EgoDeNGSpTlqHVV67pTU6FMhFw4RzmKMvvZBNafD?=
 =?us-ascii?Q?jqcOB3/adMqb1tY413oyxH0sbdRa5S2WmVpK/s8DJysmllJvif+jTDdjaMwq?=
 =?us-ascii?Q?zc3pFPu6qP2KlO1W5f3fat1ew+Q4AXw1nOpDy+q6V59hmhAJM5Z5o7jHw7jO?=
 =?us-ascii?Q?ITXgB5EcCiCoaNcdv7xZJEglNv2h6zLbuh+A+2wOO207orFYZHA89JlmMXZO?=
 =?us-ascii?Q?wGKPULBntuhHtlZ9n/fzInDumWFn52jxo5AXMtPkgbk6QCF/zBsqnOhWoKN0?=
 =?us-ascii?Q?3YWebcfkkE68QUhkF/pKhKqD9IencB8FfP1w8BvktBYQlA+BqDVBsC3V5LcR?=
 =?us-ascii?Q?rAu6UDJqrXlkP4OYv+f6jp5j4jGZa+9esCyqsLC5HNvjQMk/xmHf/dS1gf7r?=
 =?us-ascii?Q?bEdNqeTu5vvoFjBmdalZ4yja7Z7kx/4qEbjxSC2WQQjjYymWi7ViL1EL/Dl6?=
 =?us-ascii?Q?djf9COmJTRMtDR754LH7XMIM475pZc/LxUDVj89PsaJ+zXootts5E5/hcgb3?=
 =?us-ascii?Q?z1/k7dJh2OCocFVmQ/qdD6aQDH7SWozd/lGlSSgNI3M/nytz3VvPN1XSJHnu?=
 =?us-ascii?Q?JGugZGzqxKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2p+gg80f2tbFDhmlm6rLOgCCY0uyV2LkWCR8f1Y6AwJ4n9BBWJ0AVqu1stf9?=
 =?us-ascii?Q?6Jrzkkq9aluQ6xCx/PBZzmpoXui1HTSkv+Kjul+MOGJ/NrP+DtDZz+QT4ILC?=
 =?us-ascii?Q?upgRdE9Rcamogv0T904/kUjKLAOYEcP/ytlK1KlUN4kzZ+FwzH5hg5vukPf5?=
 =?us-ascii?Q?ZGyrMPlrPJzcNPyyHOWEcYUbV3o/AA72GirKiyP03mRU6ldbDrsqiBzcJQ+t?=
 =?us-ascii?Q?QaTQ9lrbRTSq+b6TRCVOY+J1EP8mAfZr7ga1X5pyQRWpbdY8rOga+jZ00HVJ?=
 =?us-ascii?Q?QKNosrOJSRWxlDu2VWmSJYSnLcfvIXAn/yQJY6s6qWTj1e0Vs2vtz8K+vZqm?=
 =?us-ascii?Q?u4+JmVkOi21mzNw9UbpRGUrsYEEVNlyK1xRdEBTDm4HJ8QW8PQCIRLElF9+y?=
 =?us-ascii?Q?jgqv046c9SiqUVAynRN+sfCR2g8F3fu+DFBZlj67d+rYs6o2DF6BC3X5HOSG?=
 =?us-ascii?Q?YoIzhEZ+f5f3xjU9xGD86FAm+8NE9HgB+D6pYtDoI2jXochKZVfZo2kRrCF2?=
 =?us-ascii?Q?cCKC9k9IMw46Bb6eTuE/KiEIvmFeX8OEiJN1cUnDM+dBIF7m279kEq3aqsFY?=
 =?us-ascii?Q?yyW1/0LijwBReu2ZdsxxgNgLmuTAMQmn20RvzO4SyQVn9wEA4zpTGoBjLq77?=
 =?us-ascii?Q?122CA8CUdhN6KDgGrDxYD/3GDWSSLB9nZKP3rePMnyIFUE1Kt3zXXAKH+DK7?=
 =?us-ascii?Q?rch9UrVYFi5SPQCLNyO4SXS0wyEG2BjD3ptUi2w3nAecykeXOuuOi2VGLNVT?=
 =?us-ascii?Q?b4pwVFRI+oxo+2ZOD8Ip50k9zyzyf2zGz5FRBbU0fJWOOkHSzH4w3GJSY73a?=
 =?us-ascii?Q?FHtrzN+NALTcW/uq2l/efUnwx0WodemhgavvHfLDJWL1FNkJkeFDYLi1Yzpm?=
 =?us-ascii?Q?z+gqambXzKYgDkZrSV/SQp/fuIg5b+jmcBq5LjaxF8sjEjkR+/iGjy4skloM?=
 =?us-ascii?Q?RAYWH7qVoZsxvQDIfSK7CTR0tTZ3llN87QJgr5t0ddlEp7l0aaAc2ROeSZHl?=
 =?us-ascii?Q?lClrhBSBLzPjodNn5gjA+HzjkOQHIeEhtL3ry00wbfQa6hVqAI8TY0MrpKB5?=
 =?us-ascii?Q?OzD+CcdQBBfpmICLu8MBIdk/CvDG2dEe/M36+uwDX+duiT4FTaECndSsbetd?=
 =?us-ascii?Q?NO6fZNyUxWJujtAcDLQHFC2IWPy66NjQhejK6f//kmZkzXq0bhcOfM0vxNWP?=
 =?us-ascii?Q?4BMtcxFaB51zDvDss4l0KdDAi/PdAvoQKjcS+8G0RP2f1GFSZt7X1BNJS7LD?=
 =?us-ascii?Q?eguOx3SGNft2+CYJFX6EW2pRqKz74se3RnLoDBngFIqEIPckrexqKheFGShI?=
 =?us-ascii?Q?pDem+KcckSROOlucZ8OKfRV/Fb++QxNRkXhC3hC/WgQnYQvm6MgDQGccvh1w?=
 =?us-ascii?Q?CR4KKKMmZs5ohOQKPsJsc5pDM7kSLkPqHrZxOXRu/giQByRXaQDJgXdTu5nF?=
 =?us-ascii?Q?6NlE3rIeVhjks/gPH2f41sfLzXSeyKVg246zeP32aEgDEtluDq2qf/6F+Wfp?=
 =?us-ascii?Q?yoaojD6WCw40QyB6L8pZY3Z16NTLcZT/RifCXGfUFKPo6sTvVL3lOwI9hvcR?=
 =?us-ascii?Q?afA0pEMk9sURClSNkkiNnx/sNitZxyEUNE78trsy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3261c9d2-87dd-4429-f207-08ddfab807e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:44:07.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfFbd8RDp7D5xZ38q14Sb2ij6VXvyrakseO300Ja/fCY7VQQhv6YGVA/tAmBQBUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

On 23 Sep 2025, at 5:16, Qi Zheng wrote:

> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split qu=
eue
> to its parent.
>
> Similar to list_lru, the split queue is relatively independent and does=

> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the same mechanism as list_lru=

> to reparent the split queue separately when memcg is offine.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/huge_mm.h |  2 ++
>  include/linux/mmzone.h  |  1 +
>  mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c         |  1 +
>  mm/mm_init.c            |  1 +
>  5 files changed, 44 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc9852..a0d4b751974d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page=
)
>  	return split_huge_page_to_list_to_order(page, NULL, ret);
>  }
>  void deferred_split_folio(struct folio *folio, bool partially_mapped);=

> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze);
> @@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *fol=
io, struct page *page,
>  }
>
>  static inline void deferred_split_folio(struct folio *folio, bool part=
ially_mapped) {}
> +static inline void reparent_deferred_split_queue(struct mem_cgroup *me=
mcg) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7fb7331c57250..f3eb81fee056a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1346,6 +1346,7 @@ struct deferred_split {
>  	spinlock_t split_queue_lock;
>  	struct list_head split_queue;
>  	unsigned long split_queue_len;
> +	bool is_dying;
>  };
>  #endif
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 48b51e6230a67..de7806f759cba 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_=
lock(struct folio *folio)
>  	struct deferred_split *queue;
>
>  	memcg =3D folio_memcg(folio);
> +retry:
>  	queue =3D memcg ? &memcg->deferred_split_queue :
>  			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>  	spin_lock(&queue->split_queue_lock);
> +	if (unlikely(queue->is_dying =3D=3D true)) {
> +		spin_unlock(&queue->split_queue_lock);
> +		memcg =3D parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>
>  	return queue;
>  }
> @@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio *fol=
io, unsigned long *flags)
>  	struct deferred_split *queue;
>
>  	memcg =3D folio_memcg(folio);
> +retry:
>  	queue =3D memcg ? &memcg->deferred_split_queue :
>  			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>  	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> +	if (unlikely(queue->is_dying =3D=3D true)) {
> +		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
> +		memcg =3D parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>
>  	return queue;
>  }
> @@ -4284,6 +4296,33 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
>  	return split;
>  }
>
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *parent =3D parent_mem_cgroup(memcg);
> +	struct deferred_split *ds_queue =3D &memcg->deferred_split_queue;
> +	struct deferred_split *parent_ds_queue =3D &parent->deferred_split_qu=
eue;
> +	int nid;
> +
> +	spin_lock_irq(&ds_queue->split_queue_lock);
> +	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NES=
TING);
> +
> +	if (!ds_queue->split_queue_len)
> +		goto unlock;

Should ds_queue still be marked as dying even if it is empty?
Otherwise, new folios still can be added to it, based on my
understanding of the changes to folio_split_queue_lock*().

> +
> +	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split=
_queue);
> +	parent_ds_queue->split_queue_len +=3D ds_queue->split_queue_len;
> +	ds_queue->split_queue_len =3D 0;
> +	/* Mark the ds_queue dead */
> +	ds_queue->is_dying =3D true;
> +
> +	for_each_node(nid)
> +		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));=

> +
> +unlock:
> +	spin_unlock(&parent_ds_queue->split_queue_lock);
> +	spin_unlock_irq(&ds_queue->split_queue_lock);
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static void split_huge_pages_all(void)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e090f29eb03bd..d03da72e7585d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3887,6 +3887,7 @@ static void mem_cgroup_css_offline(struct cgroup_=
subsys_state *css)
>  	zswap_memcg_offline_cleanup(memcg);
>
>  	memcg_offline_kmem(memcg);
> +	reparent_deferred_split_queue(memcg);
>  	reparent_shrinker_deferred(memcg);
>  	wb_memcg_offline(memcg);
>  	lru_gen_offline_memcg(memcg);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3db2dea7db4c5..cbda5c2ee3241 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1387,6 +1387,7 @@ static void pgdat_init_split_queue(struct pglist_=
data *pgdat)
>  	spin_lock_init(&ds_queue->split_queue_lock);
>  	INIT_LIST_HEAD(&ds_queue->split_queue);
>  	ds_queue->split_queue_len =3D 0;
> +	ds_queue->is_dying =3D false;
>  }
>  #else
>  static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
> -- =

> 2.20.1


Best Regards,
Yan, Zi

