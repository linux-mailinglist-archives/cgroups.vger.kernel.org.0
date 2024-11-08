Return-Path: <cgroups+bounces-5482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2889C2004
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 16:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA05283F1E
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678111F4706;
	Fri,  8 Nov 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hlW+7xSn"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60A1D0400
	for <cgroups@vger.kernel.org>; Fri,  8 Nov 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078391; cv=fail; b=K1ZQJdzrYk0VMwX+2iBpPJVsQLuz9vFRXssUZbCzeg5GtfU/2MwE9rpCcvIYCcKkTqLY1YImCubc1bcd7xUY68mpkdcNa2tm03UY9d4aStKeT8DptVYxDBqsR/xToryvViIbwXUsn7k1pOS53f9r3JyXVWQZbmDBGVxOFN+22/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078391; c=relaxed/simple;
	bh=Q41W6tpbVhdSCHKqH7igVdyAOcj8GDXDOHJu+vJr4A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5phHZjxgRLUg+bUSq8OboazniJ+DtBftlIfx9KUTH2iPwc7Gh2qBCFFU+5Zt7fFmA/XOcjV60GUsF60BXB8osmQ0Lev9GIU7MN+iWemH9nqdrNgZW9JMKxvCGOyX4CahYcLu7xe/4LPW+4Joj5msPIKHtqC3ko/BT6U2jmOEAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hlW+7xSn; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELBEjeTxpjBbXnWwVX2XdI6DL8L0oxku7wGnbY8c/rxyp/H+wrRGx1L9nto/qkFEzDq/hUeTZD7qypieBkpSgzmfdx9z3O3/I+2zhLBWUtlvyLi6pLQA8V6wNLjKexHq5tSydI4IM6p8UereRgGrqLT2Cmj5+7Vd0kCnN4gXr1XQeNVaviqSywXp5R721BKBrKZHoQy+JATnNMFjwV9jW5PV2dLZbFemVZReRBsZ8fPTKHzdHpmxSs5FqxDcC34wIieJaTfMOU6ZtgF02UO5CRT2NtqCpVEqsqtAst+stDBEWSBxqsZDV+dHzv2UbjzQAyVB3YIT1mbxJGRfVOg97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFeVaG3uGKI6DpxQBvXve0iBOzk7f55IoxByTrJ+Lqw=;
 b=iXpmU38JiYkT6h+sxjk+ej84uqRTx8I8LBRWwjDEoWNU1a5OC6C/eCpnWLXeqba37ON56Xv7NNbjnkNLtbG3ZU4YVItSRmq7TyHrDc9EAMiopujSTVNnicpbpQ3bqs4kUjK930s/P30+Y1qKO2xErV0h7vcOMyrS9XHuL8So1w7hfXStab0tTCFgoxkzayqC14rqTNvfiJtF+pHbvJkhYz42hmzHJ6z0zsOBah1mFc3UXOzAFZBTL6EY0NsnH6tTKZjSEsValP36vKODneO90ldo+XhwLtuoMbkfLFtiOMHzGpLCkUZK5m5s5VQPOWsu6AzMaZrvI+tsp88jH3R8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFeVaG3uGKI6DpxQBvXve0iBOzk7f55IoxByTrJ+Lqw=;
 b=hlW+7xSn36oNwpUkq36SkJwZetVSbidlr6ZL+gWk77CVr1H9WG+KGUfMlUnR5+6iLWA6HLUOYJDr4uRQGDpv/fLpAVLHULHTqCLtq2KHIIOVw/hViEKgCgwz105ReB9M0CFng/5xCWsCoRyle6F/fSB/nGiZUm9CdvhwxDEDMIoj90ZRpIQlExE8ApaxnfqNcKsl51DL6Yk1rvpJTNGOzjq/IMazxr9DRXxCu5Eep3kNuOyu/EFVWKa+iCG8zZrJHua5i2RUcW4JHvYe7DYu7XcYYp+ix2KvplLJM1GnL1Vc2eQhhtbmXzD75TERKWY18XVt9SSxSu9jcoe8wIUOsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 15:06:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 15:06:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm: Simplify split_page_memcg()
Date: Fri, 08 Nov 2024 10:06:23 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <3F94EF44-A68D-45A9-A07D-7CAF32F520E5@nvidia.com>
In-Reply-To: <20241104210602.374975-3-willy@infradead.org>
References: <20241104210602.374975-1-willy@infradead.org>
 <20241104210602.374975-3-willy@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_22CD0F45-0F44-44FE-8218-62207CDC0868_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0312.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c22b1c4-ddb1-44ed-42a9-08dd0006ea13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHUhxJiBzxUGjsPpX/dYBbs9IhJ/mOgxugMfi+l+avTjLaTZYeFmL5QGxyC9?=
 =?us-ascii?Q?zdjSaCIy0p3dmYYYI+xUHAlQrsTwnw2aPELLE7libkDxDny3kIuzEzkoA/8p?=
 =?us-ascii?Q?zJbIs38UCVDCnPnc1gKJCcPipyzANqyrVtCxTBV3WDOEasZNOADSR+aBToRe?=
 =?us-ascii?Q?mvChdztJlijj+UtM9rOfvTa8wNJEETqpb/R9ptP5k4Zo9NJN+HtL/E36nfpB?=
 =?us-ascii?Q?35UWHFLUNL0+aTjcPGTXLRjywvGS/HazpbEU2uMkFwAc86/+DG7Nc6lE1aL7?=
 =?us-ascii?Q?lW+Zb697jpOy6QGJZ5e9Z8Hb0iDuDU+QMvL+/jNEwR8Mxg2FfcRS4nVmSBJp?=
 =?us-ascii?Q?qT31YCkbIpdvkdLtkQvNyEzb2ZZ3QF2f4F9CeyzwYQCISypI1f4I55a51331?=
 =?us-ascii?Q?CRWu+JkXEVNhmrPoxkQmsAjbUH+KwQMOMkxPpDpgB2uAesmAeZzsOMfT+8hR?=
 =?us-ascii?Q?z4wPN5buidCaglf4T7Wy8Ttq6J1jctPhBN7J3i7V3E/38XtWW15YHt0et0HR?=
 =?us-ascii?Q?afCWqUz8VybY46I0gomyY1UzKoTtlPFwictz3NTStzaLJGVQYg1ku8W67tRs?=
 =?us-ascii?Q?xGuUg56BHn+hkRByxlLSouXXuQ6BIMZEWMMFpGcZlaW4pHD1naw7ZsdIbC/P?=
 =?us-ascii?Q?8b8vAezUHnI1GpIIHEZJ+JI9oU5TFkVzZQkJgHSyPYgKIIq1s/Sev6iMGLgB?=
 =?us-ascii?Q?7dMuq9IRBBLsIxZIk1W4y8oqHXcn7gfXZOGKN+8xh341Yuag+wmbTg9ajLGz?=
 =?us-ascii?Q?EKolEQR2YgVMs3HRoQ9+fWU5831uw6YQEf5CR4YMnPjk/O0AMUoZsu2W4DP2?=
 =?us-ascii?Q?YxLyOTd1JtkWFllLcOmX9LFpdZlO4Cuu38xwOkpS/HGU425LdUT6ZxfFbtkK?=
 =?us-ascii?Q?/H531YgPRnFzfdcS5qzx/OSHw+lBoFwd3lt0IJIwFI68ZIgvpHndtz76Pvyj?=
 =?us-ascii?Q?xxKEb3hp7j3+imQTxP35+pVBlFEZOVXRne+97/h6SDhVpo2XxQoBilf0fMAX?=
 =?us-ascii?Q?ez7T9nbqLCBNm8BTofWRvwygugE1zavPkMB1WLuVD6cXF/j8q6YLaECqGtNA?=
 =?us-ascii?Q?MCT7IHV0oQJ5lmWwsDpn1ayoePvFN6qQpzaDmrsAIOP6/dPTThx2P1gKe//s?=
 =?us-ascii?Q?v30hQ5hQUx+kpQavhDLvx46BiF/5jOI5Sarfn/iqc8QzZgwcAk69KJmHTiei?=
 =?us-ascii?Q?5pJhJ6hhowC5m+lVcqjFeziD4gQPuetF612SMGDwWOl6euUsSJhV1Kwf87Gz?=
 =?us-ascii?Q?qBZrAnFThf39gNWDj60/Khbfsaa2/TjPVr2h8GN/lwRUpituCZlsl9b0Rf8B?=
 =?us-ascii?Q?OsNF5L2BCvhxOtM1/eISwyzt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PTH8SfBOC9sjzkuQFMhgfiXxSSgJFjEmuicEpq2/WqG4vNBUCoOn70Ds6ch2?=
 =?us-ascii?Q?318Eg5T06mUsXfbGEaTwHhaonlIO51vyOowfNULP0o4rqTxGA+2BqTPwxaPx?=
 =?us-ascii?Q?XgGvUPkriBiaJvc6I8TN8zpEUGhGeIyOR7dm7MZuAYo7DyNpT84l6/TpBR0u?=
 =?us-ascii?Q?tJO//BAdx5SSiecjc4kCnDyvfTR3FTnSIMaWzTEfjL2Gj4KeqggdbqUeKFL9?=
 =?us-ascii?Q?o24tGugwiHK/1PxfDQAv13+zjkyU+tehRVnvfPyc+KA4u4ZigCx5Q5sftECZ?=
 =?us-ascii?Q?uaDDIHqmMmdS28vBxw2CPlvMe5jyOWyBFPbyBqCDj8n4a0eyu4+henQAIwDS?=
 =?us-ascii?Q?9jsOpUyfp0FvirnpGgujLNewCbbQ0+Ltm3Cgcr+/cwbcjFnD243/OGEz+KBC?=
 =?us-ascii?Q?Q5fRY4Z1oBtASaREjpkRZjJWv1vcYTalaScgm4Pw+r3VGjx4uhB83K2ksDiw?=
 =?us-ascii?Q?F1MG7gdPUC3VLmlNLOxfbppmuTDkEo7ck1w+CaFAn53LPLWG/QRNb6DyFpuv?=
 =?us-ascii?Q?3yzBs+3/8n+JmNJ3DFooNi41fi7ecIiXB3+a/c85uFL9mboZ0pscaMLq+rd4?=
 =?us-ascii?Q?FUVXFf47AVdxr8FqI2q8O8zQHNN06XTlvTOV3PcdBfXxa+Lw8qR2y5eXVxuK?=
 =?us-ascii?Q?VYjIGMW/6thCyn2yTdrqTDduPF8xIZD77yF3t6vHaGRSyF1ui0fdfxAs+XnG?=
 =?us-ascii?Q?yPZhQ9L1Szx1j/quQ41tuo9lA/R3mM42pmy6fU6IqVWKUDTrkQbeeq6mP6g0?=
 =?us-ascii?Q?dCAa1LOr2IcGm82NNZLHr1WktemvHmYBtft9o3wR05VUiHL8X7dhLQBX/f4u?=
 =?us-ascii?Q?rN6GLBeUIiFcnPOClI6Ve2VGNZPk6mD1MM93jdO1my8R5x91hxgXMiRyHzNL?=
 =?us-ascii?Q?hT4CIn7TFVZX3rulbewLQ7AIpISLw8aaGalrsvTrrWVhmkJasWu0BDGrvGhf?=
 =?us-ascii?Q?zmbrFHaUkc3GY4opoo61i0f8kWoK+1zGCJNzsXB8LzhzyuLD7XoNjn9dQxkh?=
 =?us-ascii?Q?JzmCOG2wEQG4o5t+gwv1/TCFGOVLL379X4+zN5k3j3OrRZfPCeBkgavHwAkh?=
 =?us-ascii?Q?uZ4+nFioKhX1/mqrKD+BuiDpjENPtuw5II6j98YAuezID5Kql+1s20urF8ur?=
 =?us-ascii?Q?fgClnyKO4aVujqM6c8GcWDya5K1vSVfzP6I/MOOHLy/hzqQqQ1jx6XNj/eD2?=
 =?us-ascii?Q?oqC5h0aCUPnAznHdt6IgFbePpYQfUhN/FVlxKky58GYX6PEMMHeBj4OVZBl+?=
 =?us-ascii?Q?1lZx98/uRmFtf6Z3Vj/8iWF2/0QbZj7vLnFjEzfsjjtSe5A312y2OLkt5exD?=
 =?us-ascii?Q?Lm1q8HyM83i76MwcU54C2EaekKl0w+N/omcWC1uI8qLPVTvMahqujve2r3LO?=
 =?us-ascii?Q?8TUi5S5KbHZlsHa1DCOB0A++XVRDzV6/s95qV3sSabs1Rsrn+Af8U7Wpyh5+?=
 =?us-ascii?Q?GBNo28GNrd4VnajyqfPOzjgsGOLeow0OFD4nfEEWelVuOWMIJoWMBkasQ3HU?=
 =?us-ascii?Q?e22hjRM25THWtXqgjXIJ94erXsCcn2vEfhDjfH5LXYXNS0Dk065PmAmeezPW?=
 =?us-ascii?Q?zjrhvSbzpAQIgqWGJefLeR60Hgu/TwRE7xwlvR+C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c22b1c4-ddb1-44ed-42a9-08dd0006ea13
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 15:06:25.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5tU2O1fc5cakCMm8KAcIP8Wdhbt2ft7fJBkhVAxIu6agl2pQb6nQQaZ+frwxM/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

--=_MailMate_22CD0F45-0F44-44FE-8218-62207CDC0868_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Nov 2024, at 16:05, Matthew Wilcox (Oracle) wrote:

> The last argument to split_page_memcg() is now always 0, so remove it,
> effectively reverting commit b8791381d7ed.

You forgot to cc me about this.

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/memcontrol.h |  4 ++--
>  mm/memcontrol.c            | 26 ++++++++++++++------------
>  mm/page_alloc.c            |  4 ++--
>  3 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..a787080f814f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1044,7 +1044,7 @@ static inline void memcg_memory_event_mm(struct m=
m_struct *mm,
>  	rcu_read_unlock();
>  }
>
> -void split_page_memcg(struct page *head, int old_order, int new_order)=
;
> +void split_page_memcg(struct page *first, int order);
>
>  #else /* CONFIG_MEMCG */
>
> @@ -1463,7 +1463,7 @@ void count_memcg_event_mm(struct mm_struct *mm, e=
num vm_event_item idx)
>  {
>  }
>
> -static inline void split_page_memcg(struct page *head, int old_order, =
int new_order)
> +static inline void split_page_memcg(struct page *first, int order)
>  {
>  }
>  #endif /* CONFIG_MEMCG */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e44d6e7591e..506439a5dcfe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3034,25 +3034,27 @@ void __memcg_slab_free_hook(struct kmem_cache *=
s, struct slab *slab,
>  }
>
>  /*
> - * Because folio_memcg(head) is not set on tails, set it now.
> + * The memcg data is only set on the first page, now transfer it to al=
l the
> + * other pages.
>   */
> -void split_page_memcg(struct page *head, int old_order, int new_order)=

> +void split_page_memcg(struct page *first, int order)

So split_page_memcg() only handles kmem pages, it is better to rename it
to split_kmem_page_memcg() to avoid confusion. Especially if this patchse=
t
is merged before my folio_split() patchset and I did not notice it, my
patchset would cause memcg issues, since I was still using split_page_mem=
cg()
during folio split.


--
Best Regards,
Yan, Zi

--=_MailMate_22CD0F45-0F44-44FE-8218-62207CDC0868_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcuKO8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUr9wP+wahoBpnsWPzlCDrPqxyrZEW2+93KiVIJWx2
PIY5jMFDg5ows3q0HX9a1Mt5YY9m/yxVkBcpF3XacXhB5Ldf1SJM7fz7mkpByh9W
lwmQij4zGrALiI9/OEAR+E0fHliGjEMIVI2atUHwnyaHaenrpl3IdbC6IfFJ7HwF
1YP7ZZdHqCpweogRk7GoqqjJuJ4UCvsDjJYSXuwxh+hB9LZHI1sl+6E4bMiw7pFa
RpnQ/hyf81albKYW2E6INkhrbYAgMSpGDoUunKYyUD+ZTdVHNPm8LQ4rTo6eNviH
j3mT8nd+Hlr5mn5ki8aWVjVpnCeIVlvLAVpM39f+uyH0hNsu6nr+OvmjVivXC/rK
ggmMG2k0F5SSuc6pr0XJlRdJYPmzcXstDgg6pvDFOyN4M09n4Z9335bBr5/blbz4
6iSUV2pQGgf2p3x6KskURlsaua/svoEEFghEPotZVSGQiCoJS5L57DP7ww6kFawK
380GYFDRILZScUC+qwnDOUxn9mT8xEFH9HSA7c2Mg3Q9Yog2tX+Xx+HkMr8PYTRr
lQkPfitf8wA12Ub59aynBoHOsLzNKyUGouRrnkTuWojQQgD4i4qO74A9uHHliY1H
Tcjx4K0KBovnQYRF7uxiuC9Ll/DxrwgnL6uiSBKEo2Bcz4kCxna11bdwJsBSjgh+
gktw7rmY
=JtZQ
-----END PGP SIGNATURE-----

--=_MailMate_22CD0F45-0F44-44FE-8218-62207CDC0868_=--

