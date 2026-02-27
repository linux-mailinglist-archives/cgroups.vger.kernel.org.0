Return-Path: <cgroups+bounces-14483-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBieM9AuommQ0gQAu9opvQ
	(envelope-from <cgroups+bounces-14483-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 00:54:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 527461BF3A1
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 00:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4D483134521
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CBF3E8C65;
	Fri, 27 Feb 2026 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWBWnzcd"
X-Original-To: cgroups@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39053A1E66;
	Fri, 27 Feb 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236281; cv=fail; b=kRu/amTloP1NpC5ud7x01QljIrZUJGWkTNHoK48Z0jpoPqo0rsjR2RTxM8Sv2zT4eBwd2X3kvcOBx4i/gs3sEvnFuC7Z3m5gtbyHguv/8nWH2NKO20J818i288MCp0RSS3ufVS69tTMSQgcXJ6FXJWqM6taFXFeJe/Na2n4tWMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236281; c=relaxed/simple;
	bh=copYfQV1+gwjNBsbgobkVXCOB0kvVafxTjbHCKcb+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AE6hMK5vW9w8f6TFS+sXKzqtQx2O88uT1pY5sqnScIdxzUntTLIknQjWssVBLgxspLQ+cHJSISyS53dOdTkidf42weNor/mcgnm9EDDaAq1pJo1YnTy0etpFjlCPbIsFr72adbdW4wYiV9xPed+cSWlWLy3yRPsH+3zHnA/WVjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWBWnzcd; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFdkDTPSE+kEdv5iYD7F7ke3X48iEuIqLiUQXD5Z/ORvlKpm6hI2sQ4DbSnuMMAm1A2PpSOmGPWCbOl11JQ7g1YNhRllgimvJocaWGule9kwoELCdftLcvfnFy7U5AbShpHsCw+dl1oLj8NxkqheZsHxWZmnvHIBVjsbpR8bQo7tdfrcQ91OF/kb3UNiJu2ROguToIhvlnNhBwFVd0XKbkytY6ITpidhEqFOqgQ5xkLaHsLmpwZ9H4Dn1LR1cS8VUbT3ip/YtKyZ/xYEN2mKVbHqS5IhxnP2ihiw5XygAs7hvyHJRU8qWhODLXsAI5k6iMRv9IrZn79ghbv2MG9cPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2Qf1k0U10yVGM/h39ZqX5ZJhhYMH0owWgJEPscJY+A=;
 b=N7Oc2d+Nt97oKl9pNmrjMFzvln187ouIPNVUVIDffaI5BuYErWcwVpLeS9vyuq8TacRcXme4Z4fuCOM0oHrI11DtuCIqFsiqYKQ+TaRw56PutQMFXYi1/b0dPjbCxXCbIPw0saZ9s/ujPnL+huvQfkQpwhAcllKGAbAtl1yJmb/IvevRxs/DyG5CnzTyX5Ydd1ByIlJG+DtmAS2uwxmuZkT/lJA5H3kbWJLxivfuRGeu9ht57XOL390/t9vYcEDIPSKiZ8XhaQPCBuFHe/6l0J2w26l/IzZnkaFsJCW6khlTIn5i3AeRrMDV7OjPtCDrMeNk1uvWA5uWm0v3nyjSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2Qf1k0U10yVGM/h39ZqX5ZJhhYMH0owWgJEPscJY+A=;
 b=PWBWnzcda9mpK5LfFE0U81mkrjg9TzW4xPr4qKd8qtZYfipK/GLk9yD4xXmEvteYHfIR7ytBg7KQSHM1SAyyv5mWzxqI7UVSS8C/qt4Ltxhzsge7TZsT5Jq3TkIms+fciTdxpsfaXzx8kynK/B4BR2vdoyy6gekTpSngc1OulbwRnNl+X/wyNG6DaBPKhHMSnM3UO4m//IYhdAOJfF/xtP1EclYxO3MTmxZReRq270QdHnQ6tWdYHEbIzNqmaNVYocw0Zq4e2b8KJ8aJX3+LXClGbPaoRB3FUQ/ICu/2RMOBLGyMWnP2mPrA0s7V53xDaWQbHVGYPjSSqPjA6lzhHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 23:51:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 23:51:07 +0000
Date: Sat, 28 Feb 2026 00:50:57 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 11/34] sched_ext: Enforce scheduler ownership when
 updating slice and dsq_vtime
Message-ID: <aaIt4aZzWAZSktJg@gpd4>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-12-tj@kernel.org>
 <aaBjHUr29afGuKVh@gpd4>
 <aaIZ6aeNJrZp14kh@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaIZ6aeNJrZp14kh@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: d685efd7-85cc-4f54-b49b-08de765b13a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	8LLWbxeYvc2ZOWvWcYmq0oJs/lH8rxdOV+vBAZvIyic0+P+XXZgRpN3HY1nIA1F7VNVRmM+T3nab9LxXSpImbm/wfXiJKGXfgBRU4tnXCykhTo0ghUXdCSvxZMUZI58FttzumJIggrwwSyMwtvCVqyuwikctxoJ0tGS4cZ2CCVX6rAvjviFosJskGtsCQSIjkOU48ic4KuCipqM5TWYiw5kMkIWVTKxb0mmvIyuZTSD8Xrq7mAsBmkwkJ5KELw86f7s2aeFI4jT4dYASlROgS7Rmqyr6uvJPtkRIEoKA3vEO6z49IUKkEevT/5AqQ5rTpNw5U4LYEEj8ofwuH26H/c+9p3mQfcoWlwSnNVOrSp0DpR0bQwhcpqn/DTvQFkgbI3D+Q6mbMJbJPysgH+x4pmeqwvpKT25kWDwZFHENGdkWoWBIdaAJ9RkAVyovlPpxKHgfx36+9U0OJHVQwe02L8yPiHX0aJNr6xJ9LDsSpMBRUg7b/gY8go3uncSKMoeTCR2IIEWoYUM4rGL2dmFuEc/QlLysJ6OcM9PZsCBkwV2ONj4YUMJK1bmx9x4u5ZEqetu0IpSaP5yEltZCXanSFs4TgzX/Gxl1U8W7q3O9c/LEiqLnb4MpWebaM68zs+B/3zDKtWnZA4/sWBLT9bWNxKsDmtjw1YpSkAd/mU3bMMDjJWaV+rFNZCNKpHPQwG/vF3KVsTJbjFDRiWVVIr4e1yLBji0roKr/VjG4bV3WFk8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSDqFOiVLaGQxh8iUpyHLoC9FwjZ/0c9dP/3ViUVJbtL88WgicfibroIzSqa?=
 =?us-ascii?Q?OKHKDsGisdHjuwPLGuXZFZHFI/nR3u5HhofvV/PrOid7wxefC5gME1um+Z3N?=
 =?us-ascii?Q?7z5ZpyhPDuSnLikzsruf/VSIW9eq+/sNUQtc1JBCbSJi4xePDZ937aHQim26?=
 =?us-ascii?Q?kF7jSbB3Hpkt1tmnBKHkOIPXSrGXakXVFK0zOuU1LCBJsONjuK09zXRKiy6w?=
 =?us-ascii?Q?XJp4wK73sTxgtv6+YgRF9i5zuM8AswazlSgM+xQkjEOX41n7Im8JNINZsRIo?=
 =?us-ascii?Q?yjYay/GR6P6S8ML0FiZS3MmkLWZpl5TpDl+87rUHBU8cGRc1frQkq61917jr?=
 =?us-ascii?Q?SS9SAFnYuBh78G1pOikYFxLr3+jLLU3KBp1uRBWpJALL1lE6+zFV2Kn9yE4V?=
 =?us-ascii?Q?LzDgWqugx4MYIli/B275ZTESdwgAH8Ek7m4KrAxQ24LgxCS6XCZFbIaauLqa?=
 =?us-ascii?Q?FHijiuYZtFBacYdByF+0egtuDDL1yCjpT/l4u7Pm1OydVWY2UA6xSCGoiYhi?=
 =?us-ascii?Q?lH6QtNB5zBTEtwVxVHjeESZteJ6aXY0jj2qrOs0Dgl7TUf0lRfbP1qRExyc3?=
 =?us-ascii?Q?Km5VvczlADB/PBnTy1ZtFFt8RsP10NwPQ5FubeIdgNiEsGScAeLIWkox6mMy?=
 =?us-ascii?Q?g+RNK9PObQ7RR8OLAvc5ZgnSWZjnGKblf0PYDWPSmJiw0FBDl7UnvVVvIxKl?=
 =?us-ascii?Q?HM0NxuWrbKwsAaUwTlMRfw5xU9F0Z3esQ+r07prZRfdtg+j5QLp4+GC1+peh?=
 =?us-ascii?Q?fKPMyAI2u5DmkdGYFM73A6RHcdkRR+MrnxeQXSNpmKWZyWrIvszhXtP5+7Ye?=
 =?us-ascii?Q?i6/8b0FmQGLWw0rIAUqjI6cqsnaSP8Mt5Hx/LdIMt0I3OB9nMiwNVYl4b3cL?=
 =?us-ascii?Q?BRHxiP7ZOBMs9i+QLUZdsOGJqFRbSpng4q8BdrgOEXnnGoag1wW4DcAwlVa1?=
 =?us-ascii?Q?I32uaULACzCX0CEwXEbFHRLmeOcI5wdegmYjAhg2XmKkxIhbqy8vaeqYrhLe?=
 =?us-ascii?Q?ZMr1+gFH8w+uaPh8LiqAMhxQIwWO9Iph2mEH037QtFiHnBgk8RQFbjxn8iEo?=
 =?us-ascii?Q?ZorZ4b6RGAxJGrUtrsQtExk7VDdeRfwB3kQn9U/cAe7pXnTJehPrrgb2tm01?=
 =?us-ascii?Q?0mW7CuzNOLGMG2LvR1P87N5QZzkF/aSg8oPq3GmwcSXn4dbLnBAp1LgDO96o?=
 =?us-ascii?Q?EE2tkwWZQ2ODth8scBpDxNhcC4mLL7Ww+qrzHeHgwJOEFgKNQnRt5LtiIIM6?=
 =?us-ascii?Q?1+GeTmoG1nZMc/14zot44HBqHNUYEVzzcL/E6WVlR9ck7YRsVQxWfAE/5foc?=
 =?us-ascii?Q?zTVXDpSaXut7yev0cGHG/xDkXOQwxgG++0bEkDMUH3W78Sl7OIN47Dl5o6hX?=
 =?us-ascii?Q?Kl8grLxc9RJwxAxG82tF/UV1PJ28FlOjNd5PUKk8tlUGD/XdgZi4lsOampmn?=
 =?us-ascii?Q?TFRONYo849l+oKuducfYsogsV2RMqjEVnEoT/hn4msU0U0wVi9ny8427yhab?=
 =?us-ascii?Q?pfMtULJZdT6CMbIpCLVGLr4+Uymp3bw1NtqRsPonil6LxIRYmZ2g/cQNv+2N?=
 =?us-ascii?Q?NtydRpBeQ1DnGdpjjwjx76puPIgtitkNtR+buSuLjMYS8HyyhzVfEd2nPdRF?=
 =?us-ascii?Q?H7sT0De+LgtdH6vNcoKKHkO9I4VqzkF5CMBa7giKMAdsZxMRvF2I+0PTxOmU?=
 =?us-ascii?Q?dJ0R5yctKURyl2A0CruyLeSsqyPxzdGKnZNdlOt5U8th0TUeZj5qva1S72zo?=
 =?us-ascii?Q?kUDYqE06aQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d685efd7-85cc-4f54-b49b-08de765b13a7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 23:51:07.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1xonHvfB2ysRq85VgMEbyW6WaBCrRCVb+oSs6y++R2X18+PodJh1k0WgxRDuYzPV+KCBv3NVONYdwM2Ft6wnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14483-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 527461BF3A1
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:25:45PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Thu, Feb 26, 2026 at 04:13:33PM +0100, Andrea Righi wrote:
> > My concern with this is that we may introduce some overhead for those
> > schedulers that require frequent adjustment of slice / dsq_vtime directly.
> 
> I'm a bit skeptical about the premise. Unless p->scx.vtime/slice are used
> for BPF side book-keeping, the only times they need to be modified are:
> 
> - When inserting into a vtime DSQ, vtime needs to be set. However, the
>   interface functions already have provisions for setting vtime, so direct
>   manipulation isn't necessary.
> 
> - slice can be simliar but can also be a bit more complicated. As slice only
>   affects when the task actually gets on the CPU and a task may not have its
>   eventual slice known at the time of its insertion into a user DSQ. In such
>   cases, it may be necessary to set the slice as the task starts execution
>   from e.g. ops.running().
> 
> - While a task is running, slice modification can be used to give the task
>   more or less CPU time. Most commonly, these would be either extending
>   slice to keep running the current task or preemting the task by setting
>   the slice to zero and triggering a scheduling event.
> 
> So, as long as p->scx.vtime/slice are used to instruct the kernel what to
> do, as opposed to being used for BPF side book-keeping, vtime doesn't need
> to be directly modified at all and while slice may need to be modified,
> those are mostly directly tied to actual scheduling operations and context
> switches. I'd be surprised if the kfunc overhead is noticeable at all. kfunc
> calls aren't expensive unless you're banging on it in a tight loop. Also,
> note that in the lowest overhead scheduling scenario - direct dispatch to a
> local DSQ from select_cpu()/enqueue() - neither is needed. It'd just be a
> single scx_bpf_dsq_insert() call.
> 
> > While the scx_task_on_sched() check itself has likely zero impact, the
> > kfunc invocations can potentially introduce measurable overhead.
> > 
> > I'm wondering if we could instead delegate the authority check at
> > verification time, introducing something similar to PTR_TRUSTED
> > (PTR_SCX_AUTH?) to struct task_struct * to represent that the scheduler has
> > authority to access the task and allow direct writes to p->scx.slice /
> > p->scx.dsq_vtime only when the register has that flag.
> > 
> > Then:
> >  - for tasks passed from the core opts (enqueue, dispatch, etc.) we
> >    automatically tag them with PTR_SCX_AUTH,
> >  - tasks obtained externally (e.g., via bpf_task_from_pid()): they don't
> >    have the flag (so no modification allowed) and in this case maybe we
> >    provide a scx_bpf_auth_task() kfunc to perform the scx_task_on_sched()
> >    check that returns p (or NULL) setting the auth flag if the scheduler
> >    has full access to the task.
> 
> So, I'm not sure this is something we need to invest complexity into. The
> only cases I can think of where the overhead might become visible is if the
> BPF sched uses these fields for internal bookkeeping and keeps updating a
> lot more times than there are actual scheduling events. However, I don't
> think that's a usage model that we want to encourage.

Ack, also we don't necessarily need to make it perfect right now, we can
begin with the set_slice/set_dsq_vtime kfuncs and refine the appraoch later
if we find performance regressions.

Thanks,
-Andrea

