Return-Path: <cgroups+bounces-10574-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B48BC099E
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1D61887CC8
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67322D3737;
	Tue,  7 Oct 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GX336C+G"
X-Original-To: cgroups@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7832D29D6;
	Tue,  7 Oct 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825270; cv=fail; b=dEkiNkNCjEwa14GXal29neyoeSjrmSpHp2rlwUTBaZxcDHw9pDaNXdOv88XtGUFKV+bJd/szDChN2sOtBgSuCbtoEONEwbxrzRZVxgPUA6xXw8KDd8wD88S4+R804WQPQ9NRqXa/QZg5c9XUqKWn781oWVPxdOGex1paInBrB/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825270; c=relaxed/simple;
	bh=30f2xpNAVp/4hNQPXrITQVqqQqICWTQAuWKSSO+lIVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hU31X92jkoyIQ+A7tT4JKz3SRublmDZ/ytjRP/j7DEuDw6kuEQmQ+nbOfnqjMd8HrdD+e1Z/W6xnWIRzbK8Teqc7tN8qkpVHGZJsqYQKY8lRqTSkAz445Iyb2frrC6tcfOcAFL6iv15ps1g/KBqI6GkxBwfUU8aH4XcZUyGpqIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GX336C+G; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt+EwwKquCLZiiue78POI+Tl24AtN02/fkUCkkCmOB2+uObmMLodmyNvd61hWfbbZWOm4nf3ADnFezz+t2QodVnrI4nlEMcrHR9bjiHunUK4RW8fovX2bvZyZqcx/tDfRqTWj9QMPSgE/KjYW+4DXK4nYQIcTupoJi4jnEzhvk48dBWyck4NSRefPfecHHAGlL8NWJcRewMgmx/1KSNy2Y//afgqj9WJU61gwnzfiMXJKfw9ooOOPZVEzXWmGkr50TI1Ail6XxTfzl201lenyxb1/nkQM9BNvV32odO584xVyLt5ze823nLEawJILpDPOUmOQDUS0Avu8uj9noG9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdTRSb8Vs+X1dFIvoA016rlVXnbXM+FvgX4qnV7yoZo=;
 b=uHoOZeGgo/+GtFqg5a8Ou0YgAhXlBclTVqDnLmOFjnnyp8K7hBEtk/dxryxQC7Ix7Hm6/tP5kGtmLyaBN3YeLyuVYVl5xzx6MpDcFU3zI8uZE7NaR5PxTokO2ESMqy0lDxCkrOKyhRstuvMByWqeSjY9w/ePNxhKhAju9NyOlnFfuZKzN0mLt36rt6FwrdTXz9ZMq1TC3niaKuSkgBrKSCEYo0nKfzjboo79Uvb4fHstXChRq7faYGR7c5z+5XZMsRw5qf729BvaxH/19uj+qexYcI7QUkHcFCzR7Mp2wb7ccvlHs0+mOuwV7opy+lTIy6R8QaiiY1VN72UaeKvwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdTRSb8Vs+X1dFIvoA016rlVXnbXM+FvgX4qnV7yoZo=;
 b=GX336C+GAbtV7XjQQ/xm5l7uYArzCcuzEPsp5fJf8AHBe62RkKbceB1PZ2LmrM0nUwcUN5LBqWDStuStk1h3tlc/ULo41z6buyqkXnwccdszD6FO40tlLbRMre7BhS3YfXet9Azdknzw+L43fKkK3AbzezZ6x78nco2BsCwLqFgo6sozUMewh86Eom+IjmP97mmrwDf70wvrNR4ZXDsv2hKVgq6jdeJpZhZVk8GVq1QV2tuOmfqG1qqOlTXjYXIKU+BAd6rScZaMU+MZEz8zgt0bgwJIrnOWK6yZIwD/gWxpU19MotFdwUSM1pd6jUUNeHtm6ZZDwcXDtZnL9uik5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Tue, 7 Oct
 2025 08:21:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 08:21:00 +0000
Date: Tue, 7 Oct 2025 10:20:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 01/12] sched: Employ sched_change guards
Message-ID: <aOTNXPTyk4zth-1C@gpd4>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.613879143@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104526.613879143@infradead.org>
X-ClientProxiedBy: ZR0P278CA0150.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: e9816338-ab14-4a93-ee5f-08de057a72d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQDR9e/0TlZQiAIt2a4ZOWyhZQuJiqGL/fu10tAp8ZqcNMgDtryA0a4prbsU?=
 =?us-ascii?Q?uiglEw/CVztjMhoc9wgDT9JSwZKFCO3hrUAXQc9sekEunH5C/pN36H4BZrOH?=
 =?us-ascii?Q?5jvsD96cjuM/gRcokGySgHjrQstLe7x+eg9cPiZEBZx5+N4EAs5XTjL1vLxJ?=
 =?us-ascii?Q?Xi+WVLqFNeOdmeArJ+ptnAzATlDNH6PmY2ARHxFEwNElbmJUnzj4PdFZoZvL?=
 =?us-ascii?Q?RBSpma3gmDFpX9SXFQ59jlFGb39SaZgOBtq6o78tY7D+HkqQV4PeTKO/C+1q?=
 =?us-ascii?Q?y6gFDlmxBos8kxegLQC2dLuihP1IJXSFnFbattl1bcqupYGWmebgBT1wZ7Rd?=
 =?us-ascii?Q?IYIoAe/5SGnUwTQk+0tP3HX4o0y6GkZjgs3HDG9ji4k9+A4hKs9MRV1DCFj/?=
 =?us-ascii?Q?Jzvu4rzwit54Bf3lMQTu+FG4O6trWdIFaUstEWjN3uhCVRD1FRNBoM26xGUa?=
 =?us-ascii?Q?dx/GR4bfmAc8BWzjsPME/szq0rwE4lIzI2LEk6n8leyjZIs/kjgnv5VPOW5M?=
 =?us-ascii?Q?CgQyrCetuQzeYd56S8vM/WiOQTbByszuokdezWt30n+9CviVCVeGKv7EojyG?=
 =?us-ascii?Q?AvfyBELWMiGUy6Mtzu0xZS8tdAhDB/Dw6VHk+3z+M7mw5pdEbCTOdFtpX08R?=
 =?us-ascii?Q?Uy+I/SnghFPJ8MNIEaHqcdm2SMjNQYj/m44Y7OtqvVpc4SHIXeFVaq7SUoZS?=
 =?us-ascii?Q?Xnx8fpeIhsU3A/Ru71eAtMCFWli96MfnVTumVW2LHxLhbrjRfj64+3WheBa5?=
 =?us-ascii?Q?vaRvKPovqeJIxZVXkc1cUE5nM9odyFNFOxmgdIRAvXrRrQK1b59xqc4PJptc?=
 =?us-ascii?Q?nZmGx5ZsB0AX6or1jd7VfANBouqORDElNZpDcQuFb1YcMn1lOoteKrrDcQIk?=
 =?us-ascii?Q?mlaD6/6YxRkJwlvxk3NXWqlEfMtrBqnHvkb/bJFSOhMA3xz+xgGqjt2bOdrl?=
 =?us-ascii?Q?N37PTKdq385hQnZ9uLIXuIvtA4gnQptrANZ7bQnz+C0PcOCd2Db636vWG/1J?=
 =?us-ascii?Q?D0Pf8WVRIgCqSyblbxTwHuBlSWx1vf6GPv2bTp6uINgmi2IZ4D1ZcUzxGvHi?=
 =?us-ascii?Q?MeG6k/Pi9ttQeNHQIb7br4SRWYtnyRiZblzLll6AoOvUl1gfWaEC29ci29v/?=
 =?us-ascii?Q?vq7eDTYpONJdld/qLZx2u8/iB19smXfKeu3fTOI/WyjVyLMqwyNOczOySQEC?=
 =?us-ascii?Q?F7/0wejs4IALssovPKXS6oAbZwt0IShqnWEA0bSzTgFNdqW/VjVMw/lNu1kt?=
 =?us-ascii?Q?F0quhvvZd7d1l9kHSEzE5Tl3OlOQwGsnMiwG0M473u04kwupJT547Xx6EM8Q?=
 =?us-ascii?Q?X8CGPWcVc8vpnpXaNY8moL50rChRr4csdJQuYNunho23HsPLpLPwtIrrBoQ1?=
 =?us-ascii?Q?lq6ikFpZOxHYnn4SMAO69+VbYvmjiu59r4wSVyS4UBMey6XQwrIi0m44NMPx?=
 =?us-ascii?Q?zOGEMa8VFiLCQwguVY9FlnxF9jm/38+i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZelJSGYLJmHOeDsCFuE5GldHaNhE7hwMhqOP6Qu4pOJ7+8BaViJ/+rfEvx9?=
 =?us-ascii?Q?wLRM0L8Ab5v/kZgDv9vP6bKYmT1VGZE9kG9L+br02/bA1Pa6hQQqxpeYx+2Q?=
 =?us-ascii?Q?yfLM0rMgSphlUkc85YugIk9MI0LZTmky2+PB+gsOxENNw/i/iAF59SyOvxmd?=
 =?us-ascii?Q?V5qTlXSNtrwCkzHQGed534x24AVqG8de8dEcGZ5is0MxVedw53Ih6oUN7Nem?=
 =?us-ascii?Q?3lJRielBkAxZhPfxpz0h4n0Z5cLnuS1Qu9xBDT4iD29FM/CG5Isc1LmSzXpy?=
 =?us-ascii?Q?bk9oSRB/i+2IMTvzfWO+hNkftiP3qhM+bNAiPRPz0Bk3wgPO8MF5GJNZYCMI?=
 =?us-ascii?Q?ZOTvCNAn42Q2CL/MLmbtFBnJQsT6uxilNy+Q0IjvC+nH1IX2MeWQLpD0wIxV?=
 =?us-ascii?Q?BoeI0u+8CW7JQtNWKzOHsIG1uIa5luqmiIb1QiQQkEC7cZ9r/MlNIP6l+pgE?=
 =?us-ascii?Q?/EUL/nHM/Mf/Csgv7b+X87n2TKZrkuhO4tRK4bFEOVpmXwEUTHHjXW9hQkwh?=
 =?us-ascii?Q?r0ZuDH7Q1dvogy9ah1ZL/dwM/1YSN5nWuzAY5PTp+CM9QvgxyH3oy5salHVY?=
 =?us-ascii?Q?lkQqCHcBdwqRDisoHsDyjpq2oUyfAm4Q6zPRl7EAdyNhmaOYB8Yka5GrTOUF?=
 =?us-ascii?Q?mRUNcR12SwwC5GwZIT7iCe7MogO/2NKB3UIboyDZlOhXlN3GthfbG8oflEqZ?=
 =?us-ascii?Q?wWiKVAWtCH+JJzUi/rVY+TVw/jHmPxyMxMI4iz7kyqJFCQobvUdfHyB8E5Jn?=
 =?us-ascii?Q?NAZjXc5WzGIdB1ppoobR3RM2toVXO/vqWuzxY2XJXb1LQaQSzt6C15mY5xtr?=
 =?us-ascii?Q?HSri8AXyswd2Yh7ZJcAZkrEqXC2Y2wk6Wl5Foy4coeCduUOjJQwYxQqYTjMN?=
 =?us-ascii?Q?laJnCcYpWZVy0O7AY/F1GkxHJug3FeFDUB6OPUD3tqYr3a5q4EKiYabJFwPt?=
 =?us-ascii?Q?M5QoaO5jNGV0kaKLsgDUx567eSAeyAr89Om5K2vv8Se5TmjcljgNFqMWA+Ns?=
 =?us-ascii?Q?9AyMVacBuCMIhgGV7AboxmTf9Ka8khC+Q5wJvcX7eQdbfkBWmBUEcWSM8X8b?=
 =?us-ascii?Q?uGvP+Cb3PgPrR58gL1dzVy3S6sQItbK6SjcCv7kLA3V0J8cERisIRGjnsTCU?=
 =?us-ascii?Q?tlZaymJ9l8jAZ3FlT10CWBnQsdlqpR6uRjgBrwr7zO51yD3SlNsh13o16D5E?=
 =?us-ascii?Q?Ip4LZpNv4Sc3Ju5VN30E4lacDyBIcaZ6Q3NK2zu9GUkf5VrrzCsK3i/rLgFB?=
 =?us-ascii?Q?UEFQVIyF1bVaDCHGYdupEgaKJZnlIMAeTURJWXUk1jFxPT8Lb8eq9xIGa07h?=
 =?us-ascii?Q?zZqJsHZGj6pLkJ55sbpP11qjbFdzzN/cE/aVGc1lmqfv4AUESp2l7AuIEfft?=
 =?us-ascii?Q?VAvr4pNKyhhd0J1ztmaW4VlxU+fK4F2+3w5LLxCmwLSdEZB17ZwMr7Wa7x0Q?=
 =?us-ascii?Q?rJEQ4KHWpVd0q+9Fdpq15+aSmqjsVsWbYN5jb0pu5zlscNUhR3EUjJrepQ2m?=
 =?us-ascii?Q?E9JyxBthe79TmNRqTap6ykIms7qettIpy3qVxfrym24Lj/7bx2G01/qR7UHv?=
 =?us-ascii?Q?Qdo8P4LfXRx9j1gdx06v60sDTnFtgcIEAyfIGBc2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9816338-ab14-4a93-ee5f-08de057a72d1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:21:00.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qs6NhTMuRmiC1tHvySF1Z7OlmwRtjtxKZaet4/pr7hfLICn3/EGPuDGhKkbEZnCQ4K0PL1i0j/V8ANa/Uxicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

Hi Peter,

On Mon, Oct 06, 2025 at 12:44:03PM +0200, Peter Zijlstra wrote:
> As proposed a long while ago -- and half done by scx -- wrap the
> scheduler's 'change' pattern in a guard helper.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
...
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3885,23 +3885,22 @@ extern void check_class_changed(struct r
>  extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
>  extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
>  
> -#ifdef CONFIG_SCHED_CLASS_EXT
> -/*
> - * Used by SCX in the enable/disable paths to move tasks between sched_classes
> - * and establish invariants.
> - */
> -struct sched_enq_and_set_ctx {

Not necessarily for this patch, we can add it later, but I kinda liked the
comment that briefly explained how the context is used. Maybe having
something along these lines could be helpful?

/*
 * Used to ensure the correct sequence of task state transitions, such as
 * switching between sched_classes, changing CPU affinity, priority, or
 * updating the queued/running state.
 */

> +struct sched_change_ctx {
>  	struct task_struct	*p;
> -	int			queue_flags;
> +	int			flags;
>  	bool			queued;
>  	bool			running;
>  };
>  
> -void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
> -			    struct sched_enq_and_set_ctx *ctx);
> -void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
> +struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags);
> +void sched_change_end(struct sched_change_ctx *ctx);
>  
> -#endif /* CONFIG_SCHED_CLASS_EXT */
> +DEFINE_CLASS(sched_change, struct sched_change_ctx *,
> +	     sched_change_end(_T),
> +	     sched_change_begin(p, flags),
> +	     struct task_struct *p, unsigned int flags)
> +
> +DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>  
>  #include "ext.h"
>  
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -64,7 +64,6 @@ static int effective_prio(struct task_st
>  
>  void set_user_nice(struct task_struct *p, long nice)
>  {
> -	bool queued, running;
>  	struct rq *rq;
>  	int old_prio;
>  
> @@ -90,22 +89,12 @@ void set_user_nice(struct task_struct *p
>  		return;
>  	}
>  
> -	queued = task_on_rq_queued(p);
> -	running = task_current_donor(rq, p);
> -	if (queued)
> -		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
> -	if (running)
> -		put_prev_task(rq, p);
> -
> -	p->static_prio = NICE_TO_PRIO(nice);
> -	set_load_weight(p, true);
> -	old_prio = p->prio;
> -	p->prio = effective_prio(p);
> -
> -	if (queued)
> -		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
> -	if (running)
> -		set_next_task(rq, p);
> +	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
> +		p->static_prio = NICE_TO_PRIO(nice);
> +		set_load_weight(p, true);
> +		old_prio = p->prio;
> +		p->prio = effective_prio(p);
> +	}
>  
>  	/*
>  	 * If the task increased its priority or is running and
> @@ -515,7 +504,7 @@ int __sched_setscheduler(struct task_str
>  			 bool user, bool pi)
>  {
>  	int oldpolicy = -1, policy = attr->sched_policy;
> -	int retval, oldprio, newprio, queued, running;
> +	int retval, oldprio, newprio;
>  	const struct sched_class *prev_class, *next_class;
>  	struct balance_callback *head;
>  	struct rq_flags rf;
> @@ -698,33 +687,25 @@ int __sched_setscheduler(struct task_str
>  	if (prev_class != next_class && p->se.sched_delayed)
>  		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
>  
> -	queued = task_on_rq_queued(p);
> -	running = task_current_donor(rq, p);
> -	if (queued)
> -		dequeue_task(rq, p, queue_flags);
> -	if (running)
> -		put_prev_task(rq, p);
> -
> -	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
> -		__setscheduler_params(p, attr);
> -		p->sched_class = next_class;
> -		p->prio = newprio;
> -	}
> -	__setscheduler_uclamp(p, attr);
> -	check_class_changing(rq, p, prev_class);
> +	scoped_guard (sched_change, p, queue_flags) {
>  
> -	if (queued) {
> -		/*
> -		 * We enqueue to tail when the priority of a task is
> -		 * increased (user space view).
> -		 */
> -		if (oldprio < p->prio)
> -			queue_flags |= ENQUEUE_HEAD;
> +		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
> +			__setscheduler_params(p, attr);
> +			p->sched_class = next_class;
> +			p->prio = newprio;
> +		}
> +		__setscheduler_uclamp(p, attr);
> +		check_class_changing(rq, p, prev_class);
>  
> -		enqueue_task(rq, p, queue_flags);
> +		if (scope->queued) {
> +			/*
> +			 * We enqueue to tail when the priority of a task is
> +			 * increased (user space view).
> +			 */
> +			if (oldprio < p->prio)
> +				scope->flags |= ENQUEUE_HEAD;
> +		}
>  	}
> -	if (running)
> -		set_next_task(rq, p);
>  
>  	check_class_changed(rq, p, prev_class, oldprio);
>  
> 
> 

Thanks,
-Andrea

