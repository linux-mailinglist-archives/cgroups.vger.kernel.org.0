Return-Path: <cgroups+bounces-15666-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAFcHVnA/GnSTAAAu9opvQ
	(envelope-from <cgroups+bounces-15666-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 18:39:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA0C4EC59D
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 943943010486
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1243EFD0F;
	Thu,  7 May 2026 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="G+FgMCfU"
X-Original-To: cgroups@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021087.outbound.protection.outlook.com [52.101.70.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C01F09AD;
	Thu,  7 May 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171987; cv=fail; b=CiR1pk/tDqT0itununELIpDF4jgFmhsIEJU0IOoH+qdfc/V9g1Y5/yVBtcv1Nrdpot7sHJPzW1nJdmXLvG3wYPIolHOyWZPCTCVwItUk6zcU2iM8NbL1Bc/8cvM/QuCPHZerYA3P3UwDHqCNA1Gy1w7Rrx5Nr4ro6Xz2181il/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171987; c=relaxed/simple;
	bh=A+SY0T2pxDpC36U1sBOsWmclESaKvplCTtxDn5qj9lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbWO/9boIa18AwPJ3wjyYJKoNQmKwbMNkz97boJcQeRoDM1R4QOx7Xr9eyFkpcZxrKsbII1cDCQHVjsgagAyKvYHU736KTDYXQVE8iviUn+OrRGy4jagkGRr83A5vGoMslk51x6z8m+viuBsOPsiNYrm3CyZ4mi1jApcDrZZEN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=G+FgMCfU; arc=fail smtp.client-ip=52.101.70.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx9TtwF9vErHMIE0gulUT3hlNzvi59L+0pD6otfLFt6leb7LzQVNEIpLe7NaIx46qmmwxeJ9EWI18CksUN5rPFxbx23c5kw+P7IY84CBTGEHlwhya+RqbgQda2mjP1qyK19faPVT2tiW5xTVTh0lto5nXrg7CsDBjPyGpq6ywSmb4kf1Vf2z8aktnRubBU7H0nrsVM9oRX77csegwp+Hy+o0zslhM1MPrGPmYNzaIzzCNL35UhjgREDA05gxNjQsizH2uJflqNmY32VAMkjXwxOMlnV3YaMq2yLUFgQAU7pffuvRj5hc2KhY7Tzo8OzBAnigre7HSVnsmmq0/d+efQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FQxbKuOJJC6dpQqXoeJvMkJty8+FJHxn0jqCtRCefQ=;
 b=Jr1kZx1gSlZ52vFcDj4S0D5ScrWrk+d7PDZha71T/4lv13e5Q05xhVrGERaXyVcs9JBWJ5uLjydRGLDzeA0EGw/QIsHhoEsfX3jZ56y+HYEBj2TptkI9VZmX2BwWv6oxm9XFdXQZg4BtwICuTvJ4V88mpdWJxKkImwu5F8BaXb9QF//o3P+4nWqlPDARk5LUH34bKdge3gSuCS3bnbok/3t1tOwMVcokpP1IUxJdD9USaa7NI2wjKcRP4NsiERUV/6MpC+hrYFgumqYT8UQAMc4zLTOHUBD0Xfeb6Mnfe+LJZK45dZX2+SVUOOn3gy6bQtiPmt/fCzANwDHuM8hKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FQxbKuOJJC6dpQqXoeJvMkJty8+FJHxn0jqCtRCefQ=;
 b=G+FgMCfUuxs5nzS+qG/eJn05SEaOyfLcGba6tW/xP9jJr06S+Ip0AQvACszbo0AEviUflN8vNVm2OVIXKn0R9W/CkV72k7egNooSzjfSFGEPqavrYrMm76/TRPl2ZWnhbV3zOVrrGEW1fkB9Fb0sT1AvtajMOJlSMksyBEklG8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by PA4PR03MB7472.eurprd03.prod.outlook.com (2603:10a6:102:10c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 16:39:37 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:39:37 +0000
Date: Thu, 7 May 2026 18:39:31 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Yuri
 Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, Yuri
 Andriaccio <yuri.andriaccio@santannapisa.it>, hannes@cmpxchg.org,
 mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies
 of RT cgroups
Message-ID: <20260507183931.3915dc59@nowhere>
In-Reply-To: <afypzfyH0M7Rcge2@jlelli-thinkpadt14gen4.remote.csb>
References: <20260430213835.62217-1-yurand2000@gmail.com>
	<20260430213835.62217-21-yurand2000@gmail.com>
	<20260505151523.GF3102624@noisy.programming.kicks-ass.net>
	<afpLir8tD0Ycb3D8@slm.duckdns.org>
	<20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
	<afypzfyH0M7Rcge2@jlelli-thinkpadt14gen4.remote.csb>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|PA4PR03MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ea44af-7cfe-4e14-5649-08deac573a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|786006|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kh3X/YVnmRvrd/lWVrjURvkrlO4P/HK4GlaZxl5G0IeeTM5zOs7uhGxivpKZqlAYhQQk41MdjyqSfuK4t6gVkxM8C81WRckbQveIu46YX8qCoB9Vnh0GFb5RHBomlz0pvq0WGby9zRsM1v75KWLsNSeexSF/rxgJb7reiY4mJ3uP8ddG5PQsENmY6U75+4EpJODyRR1yNk3RdKu6Uc3SqsrZ0x7xEYcIlBLAFmfPYcBJZKsEqYnZqCsbdVZU9PhEHwKnj03DlGiiCTxCx3zOSrNFNgf8+Y7fBQxLnZED3AxJRRUi6PJY54Bshu7VUPQ9zGrK/5msn1CaGrfL6NJZvm4TXdyXLWde+E1dbs3HFGBH6eWmOArDUfwPJ44A/SJVUJQjBmbxohhxfQ1PFLMj0O6cyTotaBGzvV2wWg7p1jLLFL5/p4W2wpLveMwenr28IKAbOKHbVr6UjFIufxh7VejjzdW3XthOdpTi1mBO02JOpKLyfbFEjoqnYz/U0Ab2os4yMC/frEs2zFxDLdtcOyIkfBtM5z1R0zU3PbjC+RgUx8iK5QWuVJOSRFLuhaBVG+QEShjznpEiPqzsEfxzSd/atHEqOS3MsnTBID25df3NeYALTlDPgEQeZpZPBi0T+bajlCnhSipa8UJSXLRg6XmgnPHvTOXFukZXPHcd96juuUQe5cIh8BlsE0Opf+ZG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(786006)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?08yNkmvb7Zu3w87qPh3AZVJSKvu0TMxbvMcMnl4dgNXbL5pCZqUsXBeFQ97t?=
 =?us-ascii?Q?PVgP0byFxtKehNHAFlMRZNgvoWMqjTbcHEmgmTGMWYaBD4ItAdFKZrie+pJJ?=
 =?us-ascii?Q?oLdwFabad9yI1SlP3mJyjsQ3dIzRdB/vB8Czxoog5ERTFbOCcA09ITrEJVtU?=
 =?us-ascii?Q?F7GwpSLaZDSe7TYbhU+VhdhY0Le/T9iW1I/Qv6F2MeFCDTQAEfMZsAhnUGoV?=
 =?us-ascii?Q?XKrRtp7qzW7vrBAORW8RpgHfiMcO37lCUjImOyJ353XPrnj6OAXKJ+AFU6vO?=
 =?us-ascii?Q?SMKk5XYWglHF0ez1xvkKyZ6Q4XJ+GYqNH9fn+zMQ6lVCvXLl3FVmctD9DvCh?=
 =?us-ascii?Q?RBEOVGGXl329x77/TT0y1BNROdKK5LSF6O0G6ZW9VMP6SjxmiXTg1MUneOS8?=
 =?us-ascii?Q?zvtRbRjwq6RrwmV2+D5yfZT1pnIR3/s9JdemxyVctP5GgD+ihGz94QFeo2lO?=
 =?us-ascii?Q?oSj4e6it15IedjYPPj4AKKaYWvZbsn/XqW4T8oba6pnTldEADzg2jOIh/Wo1?=
 =?us-ascii?Q?kznbjLxSlEterLJ76JUaDykt/PAJFTEEM5gDVwelVXjlvNxxhSpL3z3GXBql?=
 =?us-ascii?Q?Nd/vWjlu8Igr9reo8c12zUlUUvqeEDiUA+1EzMLDP5m8b6F+nes/9s/pSw24?=
 =?us-ascii?Q?YwmSSOizG5APhpiH3CSQ5fPfKoIJS8L1i3qpYqr09zGOSz8jXAkmZNI0wUy7?=
 =?us-ascii?Q?HW2iGhHVyJ8QH7lpW5R4kIodhXFNpkhNZ9DvYm56rM9lemBfEDieCRHTS8F1?=
 =?us-ascii?Q?hE4UiPxLwQMjv5Q+Ly/Iq1j5OtBDEclv/iU8joz2JyIEeOp7CY5BLnJbc2yW?=
 =?us-ascii?Q?AoKgJ9JVIBv30Y1DTjkdE7DoVWJDejL0uXZxG9fgbsxNc75Epn55Y6dV27+B?=
 =?us-ascii?Q?Adp4b7cd0CYVzi4EzGwJtN6yhY6ZKFGHgcf1IsRx3YvjQZGJ3tWISCezb1wm?=
 =?us-ascii?Q?KSpIF3lmknKHB5tNP0dTEXEYgNcBgerayV0z3QvRg3/JMubiXU01RcxaGNue?=
 =?us-ascii?Q?7Za7RCHjpEdHyEVebrTwL3ogIUIImIDk1rAKxvbOozrGr4Lzd3ihaGfD+6qK?=
 =?us-ascii?Q?QyLVIPDX1CNui47czg+8R6Xie2ZJXQmRCUYNDYDPcfOYfYBsqCLHjntl/33d?=
 =?us-ascii?Q?3vzd5Dd1HNckklZNlykMX7oH2XzcHhDF3MkKCk7o/kUetsMAnm1RPMWFaWy8?=
 =?us-ascii?Q?VjguvisUpbFo9UCEmtl7/VYOI4Y/TG9wTXDaDebwmmtnG/7T6H8BkphF8SUj?=
 =?us-ascii?Q?JIxqWLruVhdlcypuHhKXKIlSbxg62tKOjQNPZzHpdvA/WAGVNsF4gerAuMMX?=
 =?us-ascii?Q?Sx8e+ahUY/UhFLOiwYwy/U+K8BOa8Z/8UO4M8SihMcYl1wld8dyVPAq9PeNY?=
 =?us-ascii?Q?N1O2mdfF8sd7fhw96PBds3Dd6e0bpYbNXdW0NW1YiwROO2uqJypkRDLWSfmq?=
 =?us-ascii?Q?k4yu7OMl0XypA0jKhK07Xy6Er/7J/wT+1enJ2JTPJMn7uLagwcz44ssatNYq?=
 =?us-ascii?Q?AoxSTC0wThkhmoNP2BnRqrRYpf/4+DsDQpZSNXfmgK9fbR0zZ5Qo6HhR1puk?=
 =?us-ascii?Q?Feh4lm2kF0wbHMq9HS4dIv1SzWS9PWZr9o5o65nN/MlsNwfeuw1rqSGqZOnh?=
 =?us-ascii?Q?04tI5zZt4iXgif1HPMLb97Pd91quYq7IOyxJe4cAtz+Rux3KuEnRI/mmep0m?=
 =?us-ascii?Q?0RWlvR19zOwGDtraAiLnzmh0n7jFRk2Ev1QEY/Mr7ovmP74M4pVwSHBB2qmK?=
 =?us-ascii?Q?UOBldf7VWgLa0h9mIaEy2DRn6LdiTMvLYrUuaoJLdSZLJNrrSdACX6pruOEs?=
X-MS-Exchange-AntiSpam-MessageData-1: jCq8lpYpdGgEUa3imeQGGzQWA6NrMPzD2rE=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ea44af-7cfe-4e14-5649-08deac573a19
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:39:37.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GXwBT5YHPXoq/Akp3F5kluVKn+MeQKnPxf25uzdh0eQj2ZKwgTfQ5KHq+QG6OcwZp8La8RsQ+0etw4sjbiffHKMFRziugpxiHTae1kfFEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7472
X-Rspamd-Queue-Id: DDA0C4EC59D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15666-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi,

On Thu, 7 May 2026 17:03:41 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> On 07/05/26 12:53, Peter Zijlstra wrote:
> > On Tue, May 05, 2026 at 09:56:58AM -1000, Tejun Heo wrote:  
> 
> ...
> 
> > > - However, the cpu controller is a threaded controller which
> > > means that it can have threaded sub-hierarchy where the
> > > no-internal-process rule doesn't apply. This was created
> > > explicitly for cpu controller. The proposed change blocks it
> > > effectively forcing cpu controller into regular domain controller
> > > behavior subject to no-internal-process rule. Note these are
> > > enforced at controller granularity and this means that users who
> > > use the threaded mode will be forced to pick between the two.  
> > 
> > Right... this then means we need two controls, one to do
> > hierarchical bandwidth distribution, and one to assign bandwidth to
> > the internal group -- which is then subject to its own bandwidth
> > distribution constraint.
> > 
> > This might be a little confusing, but there is no way around that
> > AFAICT.  
> 
> Just to check if I'm following, you are thinking something like below?
> 
> groupA/
>   cpu.rt.max = "50 50 100"       <- 0.5 from root
>   cpu.rt.internal = "20 20 100"  <- 0.2 from groupA for threads at
> this level
>   + threadA                               <
>   + threadB                               <
>   +- group1/
>        cpu.rt.max = "30 30 100"  <- 0.3 from groupA
>        + threadC
> 
> And we still keep it flat, so 2 dl-entities (per CPU), one handles
> threads at groupA level and the other threads inside group1?

An alternative idea I was thinking about: we create 2 dl entities (one
for "groupA" and one for "group1"); we set cpu.rt.max for groupA, and
we subtract group1's utilization from it (so, if groupA's cpu.rt.max is
"50 100" and group1's cpu.rt.max is "30 100", groupA is served by a dl
entity (50-30,100)=(20,100) while group1 is served by a dl entity
(30,100)).

Basically, with this idea the "internal" reservation is automatically
computed based on rt.max and on the children cgroups. A possible issue
is that if the children consume all the groupA's utilization the groupA
RT tasks remain with 0 runtime (and never execute).


				Luca

