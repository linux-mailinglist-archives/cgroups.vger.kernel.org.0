Return-Path: <cgroups+bounces-14430-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I5TLqpnoGkejQQAu9opvQ
	(envelope-from <cgroups+bounces-14430-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:32:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC01A8C47
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42C2E31B83E2
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209A3ED130;
	Thu, 26 Feb 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="myWhZTpA"
X-Original-To: cgroups@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF3A937;
	Thu, 26 Feb 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118838; cv=fail; b=f8leRo0ZnJaBdmsfRP44JMxf8XWo70xvWIGaCX8/0ZJvUz0+k9ha6JherCwUOhoIyb+Km4CJocuyzRS52E7sZESn2F5oxMArAt6XD23ef9cO2UhZjJEx5fxFE+6lth4dqdB/mwM2d4flhIirJsq8EtSdNLq0OgLwcrSAFBdIbjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118838; c=relaxed/simple;
	bh=5RfSEZL9pb5DIZ7qITgWIhIvDdDX/a7yyLsa2c7TaKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9wFHVmpMoSWPY587k/rjAN02qPJKKHIBYxxIvmYI5AQmTN7cTJnJLfGu3kBOEkv6hxZlzTPzoQ9+RQiD3GUp3mMNHCNNbcj82BoJKS9h6pQSY7631VVOrpz3sXbFaeKINRQx5zTJSJssV9w/KUp/5s0RkBO8kO6X/B1M1AgXV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=myWhZTpA; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyGQoKu6+HorY0G6cd8Db3SzUE67IEGjwgULEYsi9PS55U6avSjbmeDT4JHeq1D73eLPItD4wdQ27pEr/SbinZeC7lAnwpjq8bW+4G4lyDS7/rgY/LsQFclNkSPdnET4VTYnjf9mlFYNbiY79CWsuITtS1Gr5bRbZi4mvKkZoGGXw6uyF6NzNpBYebeJxoc5d5AWlbx91QJrJBN5pPGuOOvcRHVaOyKdI79WC6o/HF7mnG99SVdundHvd7fTh19SMFiGUI5sm65JNkKGReHf/tmcOhED7+y9+PifLRw9AW3T+6ceu24f70x261zyzh9HBjm8EcAoWZdR7tfB6O4EJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=835n0P0VvXSxETSbV7nf0pdbeNya+1ViI4YepcVI6Ng=;
 b=fNMQD8h4l4/eKXVhwhAShw0b5edlWpcxJmqOispfH+fNJD6W7hIY7hbU2IyLFxjYpV/Gb2xSi69i8QtmUaOwxdh7zd7dSmAfyMGI2QBqTA3XxCft9xPhge/Yjipd96bkOsGn0UUUgVeH9B3BWMvgXIaMZEd3id96UpJAEVfLJKA9GN8NycuEmvWPE3/6KuLVIwDZMPTnwbEJMRc7cCKDMog+dT2Ki5SKvhzoOD8pvh9UO//fmTOoQkOo605ZKSGl1hI8uH9pe97scSlbdReEjsRoBis8VT00TqJaCniWEdJ/3U2V7FNW8WkKdTPPLewyYVfpTkikspg4+dRsbrEMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=835n0P0VvXSxETSbV7nf0pdbeNya+1ViI4YepcVI6Ng=;
 b=myWhZTpATpZaYc8oBCTuT6qSqJggAp/hUMWHJ+GkyruR+n3NHYslz4MfdDlq+j5BKpcA+DlNNuGYftGBq1Bzh2/9zS930SlpLBqmTk/bW6aLWzVi203JdULCjt1IaGWl9F/my9MolYfV4d1XqPU31oGgtVBg53tAzOc6tKI2QOjr7/iSfvZr88ir1mrZn2XMQ8N5ZyZ6PWD8vXMctMAC1cbWo/F5JRvftN5SUM2afHw6eBr+ELfKX2tbPAn6iYXdIOAhkVM8NTYtRiHFYg2hvLkYOQpDD8F3qczBvFnFuipWLdCbEpGX+iiylLq/2Izwj/aSM4WdUE/cyvTvew/60A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:13:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:13:52 +0000
Date: Thu, 26 Feb 2026 16:13:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 11/34] sched_ext: Enforce scheduler ownership when
 updating slice and dsq_vtime
Message-ID: <aaBjHUr29afGuKVh@gpd4>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-12-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225050109.1070059-12-tj@kernel.org>
X-ClientProxiedBy: ZR2P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: c56dd4be-9d4b-4bb8-a2f8-08de7549a6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	x0w+FSDdRbIbk2I7CLbRFInPwhwV2fEKdlduzGEgZneH0EDfEIibgCcdo8BmRQN47PusyeDBzKLL5uui2BoQVxcIUciHYdax8ty8haCphD1i3+VYNi+ZWqFzERZ18UDo2r9Qr0gDaRB0MHiRvOirZ2wTcW4ljQoTX9ntUNqkNjUyOBcqDFwzTkdCmb8BbLuvPt+/uzYPWX9XQ4/4AnRp2TIZ1hoQ09TyU4r0V5+11CYzSm2jjk/JnLp7XbT+/nalvw+1f3SoEEzMqF194Sj64Q/NQt9AwbutJGgCCPecYnljKDteT+OiMCFdSltDT6+9A0nj98qH/djByk3IldkNIuD6FRYCtm6LddZP7lG6cGPg3sx+Xdbc1NpWef5WHq9ah0Tp/JBxJ7qdp021l3wVq4lvzspouZ9bMp6+UUrjHj1J0C6I3PRFkfmhKAUlqnN6ZxoZsmOEeJR1gl6MncjBOU8tYZpBAhuAUL5ZSRocgfg11CNhlevF2CHV8j/+x5agegW1LZDNCrlpSSGGY1G2W7spF6gCk2jgRhpFcrGiaznJPm+Walz2KQTNhjdNyyFPBY5k/pBJkYc9NO5eoQwATt9Ee5yaP8hzrNVhAWqiCJ0DM0o/W1gCpmOKGTWss12cjBeiksCcOcUwggMvjCwJWa6f3Z+curAdZO1l6jXOYLPKYYi+9szJ8JrL5o4LLebAbeWBgrfpIzggbP1G9bg0Bsrg15PgB74e32CVF7naygo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mz5ykBEKFmoIMVkJnfjUndJrZ3yKGjx8ImsmK7RHWDTR+Lg53Yi7UGPq281C?=
 =?us-ascii?Q?ID4dWt4idUKv6XgZTLAINpZkXgGEHIv/mYrFj24PVBg6ANTKG6enkfPe7XTw?=
 =?us-ascii?Q?yk3kv0qGTkQj2priVmNXLUoxXi0PLWrB/fSg6A6ByVVyavurkf0/oiIttC7Q?=
 =?us-ascii?Q?isyfEfAuZ+lKWENQCRcxWkn9EsTZ5w+ADXfzdKek5LrJHJSgGhSMVzZ4qd8K?=
 =?us-ascii?Q?dk6ZV2s9ns1ta5aCIJOo9FB698N+GObKS4mg1FWrzKSnZryAgQJalhTU8APf?=
 =?us-ascii?Q?asSXzO6bKxeRNHEWRBn5peoUpcclKYI3T6ZeqsBrlxdkS63d4dxKqxwFR7YX?=
 =?us-ascii?Q?SZQJZqn7Uz6AtX6MD0RbIQ3JwsgmgZOQpYiqatg3lBHqFO+pbAeEvjaf5daf?=
 =?us-ascii?Q?ghYnHIWELcxA1Nq9BXcEk8MOyq9xYHiyNdCSfQ0IshQ8ylWC0pgrPNR7DMUo?=
 =?us-ascii?Q?QmDTMmEqa653Ig3zwddbDby9XWy1UiqQR5zp/JVSU97CTwBzzYKnNpu+AARD?=
 =?us-ascii?Q?Tbu5kOmKvnKk+QlkC8SMgDDYAYNK9Oab5khuApv4pVl88PLK1jUF8enHKrHh?=
 =?us-ascii?Q?RmX1hrEfmySscjS5dQntCVi1eQdlRimSbGJh8BIX55/mVhN+X0MVukCXVPiC?=
 =?us-ascii?Q?I8UOiF0+NYDTR4Lh5dirTyxnVk8MBCULIaUQm508eu63Q1LorQGjY9VO4cTp?=
 =?us-ascii?Q?hnxzaKu+rChTnWPi6gkwux0Y+BH5vWLkrNjKjZ8L4nQ64aFuYzFctp36KgFE?=
 =?us-ascii?Q?Aq2g1lfuK8B8rfPSR0Mu2BFJx2/Txhi4Zg+aFmYVTBQjEgmkbFnYEHF9Iu0R?=
 =?us-ascii?Q?9F2QHSIb6LJxGmfmu+PyEOzWy+eDKV4I9178lWOm6qcLTqEwWHv025Y6wS8k?=
 =?us-ascii?Q?X62gGDfDQ35FuIS+Rg7Q6c1Pqxz1+yQIbFOi1SHvUEZOX4Ynzob475nf+bRD?=
 =?us-ascii?Q?xWLr0K+1A/6vjvxh+I0QhLNMkL5cg7hz4MKwpNdTvMn/dT+mW73mc7CHNmON?=
 =?us-ascii?Q?9UG3IsuaMDLqJW9ZuTQ8ySO3MoKoAyA8LVzEKqrOgAx29NOvYse+MS+xThQ8?=
 =?us-ascii?Q?CqxXXu6/01WbSECBhVp1daJ/4bvWiCUHg7OhSKzz2c6SJ8QBNE9g4ZTJYJgU?=
 =?us-ascii?Q?imYPlKKza1RgfcPak0xWBLzONzGr+aEE/zQ9u834Wc46xN9InfXPWtIjJIUv?=
 =?us-ascii?Q?rGhz34GM5H+S8+BM0x0ujSx9mIH1XP07sCO6+V2b0nHVYav4bC78dUvie92x?=
 =?us-ascii?Q?dAlCICTH/gfFvROq9171DnHf9Xgxu+/H1VVq9XNjGGrgpGbqyO792GyocQAE?=
 =?us-ascii?Q?9nizCKlnm08MIRYa5WeQxXZ7WiDbNoRsRSFCXA8ff9ja+zCsOGxYbuBUZH5G?=
 =?us-ascii?Q?BfUeKfObq6mAn4b6VD21GsOzLlKnONFqILC1AeejQe6C3gtO611YZ5vBhGLO?=
 =?us-ascii?Q?GVmV4iSR1zGJHsSTyGeZ5Ch66YOAN+TX8ymJc7iVITSdj7PSavGdcrUuA1Y2?=
 =?us-ascii?Q?oAPwIzq01vBmpDdEHWuLUsYQzf4vsMFdsYZZJJTKoOi+xOyoRyWeOWVbC70t?=
 =?us-ascii?Q?XRbABT3116C57ulUIS+pmRX+k8AYEO9ZsrIQ88bCXK0J9jDeIYSfF54bzQOv?=
 =?us-ascii?Q?cFoybsBA35Gsa4i6rMFY+mXPhOx4pFREwummQ4NjjvYoTaFGzCj9xxS7mpvt?=
 =?us-ascii?Q?VF3Bqeg944QMpQOGzajhWlXymhlRrfdG01JqoSDrGchABwX6s9vjw4vcijCx?=
 =?us-ascii?Q?cEWltm86mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56dd4be-9d4b-4bb8-a2f8-08de7549a6ab
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:13:52.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jBqar9p77NQEc9VFxQNTDRst5f/jKMMSvMEx4RSgdwWxbB4xQAFqiBlm4tRO/pltkrOlrQVGSZcJldqceh+9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14430-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22DC01A8C47
X-Rspamd-Action: no action

Hi Tejun,

On Tue, Feb 24, 2026 at 07:00:46PM -1000, Tejun Heo wrote:
> scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() now verify that
> the calling scheduler has authority over the task before allowing updates.
> This prevents schedulers from modifying tasks that don't belong to them in
> hierarchical scheduling configurations.
> 
> Direct writes to p->scx.slice and p->scx.dsq_vtime are deprecated and now
> trigger warnings. They will be disallowed in a future release.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

My concern with this is that we may introduce some overhead for those
schedulers that require frequent adjustment of slice / dsq_vtime directly.
While the scx_task_on_sched() check itself has likely zero impact, the
kfunc invocations can potentially introduce measurable overhead.

I'm wondering if we could instead delegate the authority check at
verification time, introducing something similar to PTR_TRUSTED
(PTR_SCX_AUTH?) to struct task_struct * to represent that the scheduler has
authority to access the task and allow direct writes to p->scx.slice /
p->scx.dsq_vtime only when the register has that flag.

Then:
 - for tasks passed from the core opts (enqueue, dispatch, etc.) we
   automatically tag them with PTR_SCX_AUTH,
 - tasks obtained externally (e.g., via bpf_task_from_pid()): they don't
   have the flag (so no modification allowed) and in this case maybe we
   provide a scx_bpf_auth_task() kfunc to perform the scx_task_on_sched()
   check that returns p (or NULL) setting the auth flag if the scheduler
   has full access to the task.

What do you think?

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 56ac2d5655a2..f16ce4deed88 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5872,12 +5872,17 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
>  
>  	t = btf_type_by_id(reg->btf, reg->btf_id);
>  	if (t == task_struct_type) {
> -		if (off >= offsetof(struct task_struct, scx.slice) &&
> -		    off + size <= offsetofend(struct task_struct, scx.slice))
> -			return SCALAR_VALUE;
> -		if (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
> -		    off + size <= offsetofend(struct task_struct, scx.dsq_vtime))
> +		/*
> +		 * COMPAT: Will be removed in v6.23.
> +		 */
> +		if ((off >= offsetof(struct task_struct, scx.slice) &&
> +		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
> +		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
> +		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
> +			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
>  			return SCALAR_VALUE;
> +		}
> +
>  		if (off >= offsetof(struct task_struct, scx.disallow) &&
>  		    off + size <= offsetofend(struct task_struct, scx.disallow))
>  			return SCALAR_VALUE;
> @@ -7096,12 +7101,21 @@ __bpf_kfunc_start_defs();
>   * scx_bpf_task_set_slice - Set task's time slice
>   * @p: task of interest
>   * @slice: time slice to set in nsecs
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
>   * Set @p's time slice to @slice. Returns %true on success, %false if the
>   * calling scheduler doesn't have authority over @p.
>   */
> -__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
> +__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
> +					const struct bpf_prog_aux *aux)
>  {
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!scx_task_on_sched(sch, p)))
> +		return false;
> +
>  	p->scx.slice = slice;
>  	return true;
>  }
> @@ -7110,12 +7124,21 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
>   * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
>   * @p: task of interest
>   * @vtime: virtual time to set
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
>   * Set @p's virtual time to @vtime. Returns %true on success, %false if the
>   * calling scheduler doesn't have authority over @p.
>   */
> -__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
> +__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
> +					    const struct bpf_prog_aux *aux)
>  {
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!scx_task_on_sched(sch, p)))
> +		return false;
> +
>  	p->scx.dsq_vtime = vtime;
>  	return true;
>  }
> @@ -7995,8 +8018,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_any)
> -BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
> -BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
> +BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
> +BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> -- 
> 2.53.0
> 

