Return-Path: <cgroups+bounces-8988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12EB1C1A9
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 09:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA97616C258
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DC21ADB5;
	Wed,  6 Aug 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="LywlzRf2"
X-Original-To: cgroups@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012003.outbound.protection.outlook.com [40.107.75.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3031D7E31;
	Wed,  6 Aug 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467141; cv=fail; b=NviLQgl8JwDkd9VJ2MvlDRdkh5TnhbXXBy0RqWOMOKeidx/gdN94n7WfCGMXLRZ9a8Mhs5sToiQ37TFB89bfjkUps+Q4M10SY5UFfoTlkzoUm8xcYgs9LycumN2rjPtuXCOxBh5ZCC+r99lOx9On5Hh5e2wG8wnROUviQgrvF0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467141; c=relaxed/simple;
	bh=EmqzsYWt9yX/0In4gOug4J0Oh1F2KxNHZzYYbISOkfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iugm5QCHro2OJd3smcWXUtGsOsI9xANxgvsA07gcJATYOKstyspMEFf8AsOX2GuQshuBtayyfyUpQ4DKO/RjrnH3VUnAKUgGVxz+4XwL+FfpYLc7qPoI/Xu6w0wNMzF+ko6hTNNn4u7RBDvSWd0XLox0TC8v0w334c7IMsV54Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=LywlzRf2; arc=fail smtp.client-ip=40.107.75.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEwMf8mD3nIA31KTQHZ3D24+jHprUdVh/3pdb40XZotquza2yXP++pFlIP3/agU96wnSoarfhU1P2NMreSbL2o5Y2VoLRX77wjvHupkxUtglezQRrNpTgR1WWrYjPbzIsrS41ztmwadCn7A8xdLItTKg35o6wTmqvszvlmGsuYeR3JfEgD5wSdFud6UeV9oXnWvQ4q3QX+CvmKyRz7WiUrvBvwMqMtA3AdLJdlYWqriWMcefbezoUnrnfQszR18W2z2Ilu5iTjKMnK80s4CNNYhz87dLnXOt7vKOyoBCaNhzLvS79jZNhfHg0QxfoT7713tgGLPxN7IQRbMCR8rcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ/QPCLXZKXIEZCEakIviSdn/+RPfABzX2l78knwRzI=;
 b=LO7S1EEz+y0tBMxMqP1/pgH+1/gS8andvc+1Gjp2MZmX5jyuZvPkez8uEPrBxlwfm3jTwJK22o57LEWPbEp+5YD4vBTgryxp0KodPamIrIEqk+QXFVkjQ2cI2mjNc0XHuOj7SdBPXa1yXft/rORkzYKPdePQabvUf0/XmjTDkNKbwIHBZWICmWyolMysg4fZJucYeI5A5DTWcE3GAfvpaX2K7/PmN9pZru1jADHl7thRUbmQARiPAV/22EvhoHBbT4FaANgbv7MLrydw1EpI5t1r6c/ct3hBtXEfcTuLAx5NzVvjmOo35/JVaG/jDPFybLdWGOBVJEwBhPG5LvkSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=bytedance.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ/QPCLXZKXIEZCEakIviSdn/+RPfABzX2l78knwRzI=;
 b=LywlzRf26dt6dyGcMAMb+nPt9N7kehpQf9wZfLMUKtiKYPASUBjCLnUyGe7X4WLsknzobr3SueSltxPm1zHFbHiNpcYE2Hsq1xoFd3ZOQdLnQ7sUOoRysZW80aynj3DAlKCTq2fsA0nCeV1peVq5ieIQMdXpoFol8Ms3H5LdUo4=
Received: from SI1PR02CA0002.apcprd02.prod.outlook.com (2603:1096:4:1f7::16)
 by SEZPR02MB6946.apcprd02.prod.outlook.com (2603:1096:101:19e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 07:58:52 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:1f7:cafe::fd) by SI1PR02CA0002.outlook.office365.com
 (2603:1096:4:1f7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 07:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 07:58:51 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 15:58:50 +0800
From: xupengbo <xupengbo@oppo.com>
To: <ziqianlu@bytedance.com>
CC: <bsegall@google.com>, <cgroups@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, <xupengbo@oppo.com>
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Wed, 6 Aug 2025 15:58:45 +0800
Message-ID: <20250806075845.27047-1-xupengbo@oppo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806071848.GA629@bytedance>
References: <20250806071848.GA629@bytedance>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR02MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 3116aefb-b569-4fb4-4907-08ddd4bf1527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eayplN0xvfVqE0LZLxv+Ehop1XpxUyX7NYMDQh0593V6XBmebGpiwsdy+Vzl?=
 =?us-ascii?Q?Xsj5cW+F8BqkZhf1X/FHEt7nadcBhSOlGXF7ZV/nq3hjY3Ip+rNLbRUMHmvo?=
 =?us-ascii?Q?rASFiVtYwlnAvEMeTX5NBJPiSrU8KMiSuOcLaVMXpLiZpuiKG3BxHBZrSn4Q?=
 =?us-ascii?Q?M1n2+25mcYA/5aDI/b8ysYx0rXFt9hYVj/Rt2nZlR4ApLem/CFoDsRlzAVRm?=
 =?us-ascii?Q?b+exN2ExlB16rr8vlilWFlafFM8PS7pf+ObyTkJC+8XDXcYKKHFYNtny4mZL?=
 =?us-ascii?Q?ocJm0xBPJ+9/VrsiF9+TkTi5C8E0GfJEd2s/VRV4aU+XNqMRo8KJuEmhut5p?=
 =?us-ascii?Q?4jgV6Jc/RTx3CSLxNpDxRxVSiRaUWHYZuetHeUqI8EtkZAVQNjq5/aaD5cQd?=
 =?us-ascii?Q?jPGjljQDxwwPONup6WmDD5sKyqOP3Bs0Yhg24xu2CRq7W4r/AOF8gJ53EmgL?=
 =?us-ascii?Q?JnrZsL6unqAuhxN/YErFfXOYDW41xrGGAYvD1ukEbzOoC6CTZ9UAtHBPJDAj?=
 =?us-ascii?Q?9IfRrjgVDL1Zj3NfWbeF9/4bqx6VnTzSNytcOhByzcm7FeDzjul2t9u7O97J?=
 =?us-ascii?Q?bwDvGaORIWCGA/I93BmloxTSfMWoWtsbyfurD/uJGeBOMZty84dhCjXisFyF?=
 =?us-ascii?Q?WegOtzDsdfx0T/TYahKOiyVn7CxJqYZq80a6n8dqOL+nx6X+Yfwh8M3ic2vR?=
 =?us-ascii?Q?I7nm3eAwV83C0JpeEfp+YzYWgNUr9VopvwRrU4sKtQzPgOm9LijQM4Y7rObe?=
 =?us-ascii?Q?2JjZKFpLgtEEtwrUFB4pVDPTPk/c3tAiFZNQXjXfhNtgMJv/iQEQHwC5Lufg?=
 =?us-ascii?Q?yKImyMk6iMPllN0JCLkFfk1Pp9l+l9yL2urqn2Yghv+Giyo3QKRVhOyIvqVk?=
 =?us-ascii?Q?PFG+nTTmbzjEFp5q4Ry9wwhLFN/0ozHvXIhDP5r6L3Vd48PF1ccFFZ31Z+LB?=
 =?us-ascii?Q?Zr1hGB9foP3B7OlANnQRQVD2ViNDKRMbI4s4i5enUStw4sLNjTQpkfdiyfix?=
 =?us-ascii?Q?ireDbvIe2ogzK1DiEHGP7fDTr5MnQ4PTfgO1POiJZR9sRmhia7pwtmUEOuLu?=
 =?us-ascii?Q?HwRXLp12ITxf3/3kq21IiDx8fJF2pO9EggmJHM7uYiG8FDwowjWYWHDElWpN?=
 =?us-ascii?Q?IriAuxCpuRTePTbjnyKkth7D26lhlC+gfn9qAjA2bMp9dI1qRxjlVaAo0Gs8?=
 =?us-ascii?Q?xlWckYD9zm6eM7d6F4FnMzcJvaehAOdGYmIRkxXBpv2flUTeCIQIfFZ9SUOa?=
 =?us-ascii?Q?rhaLLLskhywGxSR0ZJ6r0LasEiu8PIPeffTY7Xg7C2rBUWtZXH8/CoJNg+yE?=
 =?us-ascii?Q?vrQybh28U267UNd6P1TcILnNAR61aMCsV5JP3MarroAAdSATTUIN7PbFwr6U?=
 =?us-ascii?Q?ZeHtGgbO4v3ff1aEvyWZN1+6CK32TXjiwYvP+uH6ZHy6c71z62HJDArkkClw?=
 =?us-ascii?Q?F4kYnXv+U0Pw1nf678SaEBJgYG8oCoYeWV1yv6Ds5S/6ZJuNhL/tBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:58:51.4073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3116aefb-b569-4fb4-4907-08ddd4bf1527
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6946

On Wed, Aug 06, 2025 at 02:31:58PM +0800, xupengbo wrote:
> > >On Tue, 5 Aug 2025 at 16:42, xupengbo <xupengbo@oppo.com> wrote:
> > > >
> > > > When a task is migrated out, there is a probability that the tg->load_avg
> > > > value will become abnormal. The reason is as follows.
> > > >
> > > > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > > > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > > > when a task migrates out.
> > > > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > > > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > > > function cfs_rq_is_decayed() does not check whether
> > > > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > > > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > > > updated to tg->load_avg.
> > > >
> > > > I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> > > > which blocks the case (2.) mentioned above. I follow the condition in
> > > > update_tg_load_avg() instead of directly checking if
> > > > cfs_rq->tg_load_avg_contrib is null. I think it's necessary to keep the
> > > > condition consistent in both places, otherwise unexpected problems may
> > > > occur.
> > > >
> > > > Thanks for your comments,
> > > > Xu Pengbo
> > > >
> > > > Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> > > > Signed-off-by: xupengbo <xupengbo@oppo.com>
> > > > ---
> > > > Changes:
> > > > v1 -> v2:
> > > > - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in
> > > > cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> > > > - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/T/#u
> > > >
> > > >  kernel/sched/fair.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index b173a059315c..a35083a2d006 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -4062,6 +4062,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > > >         if (child_cfs_rq_on_list(cfs_rq))
> > > >                 return false;
> > > >
> > > > +       long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > > > +
> > > > +       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
> > > 
> > >I don't understand why you use the above condition instead of if
> > >(!cfs_rq->tg_load_avg_contrib). Can you elaborate ?
> > > 
> > >strictly speaking we want to keep the cfs_rq in the list if
> > >(cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg) and
> > >cfs_rq->avg.load_avg == 0 when we test this condition
> > 
> > 
> > I use this condition primarily based on the function update_tg_load_avg().
> > I want to absolutely avoid a situation where cfs_rq_is_decay() returns 
> > false but update_tg_load_avg() cannot update its value due to the delta 
> > check, which may cause the cfs_rq to remain on the list permanently. 
> > Honestly, I am not sure if this will happen, so I took this conservative 
> > approach.
> 
> Hmm...it doesn't seem we need worry about this situation.

yeah, I am worried about this situation, but I can't find any evidence 
that it exists.

> Because when cfs_rq->load_avg is 0, abs(delta) will be
> cfs_rq->tg_load_avg_contrib and the following condition:
> 
> 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
> becomes:
> 	if (cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64)
> 
> which should always be true, right?


It actually becomes:
    if (cfs_rq->tg_load_avg_contrib > 0)
if cfs_rq->tg_load_avg_contrib == 0 , it will be false. As it is an unsigned
long, this condition is equivalent to :
    if (!cfs_rq->tg_load_avg_contrib)

Thanks,
Xupengbo

> Thanks,
> Aaron
> 
> > 
> > In fact, in the second if-condition of cfs_rq_is_decay(), the comment in 
> > the load_avg_is_decayed() function states:"_avg must be null when _sum is 
> > null because _avg = _sum / divider". Therefore, when we check this newly 
> > added condition, cfs_rq->avg.load_avg should already be 0, right?
> > 
> > After reading your comments, I carefully considered the differences 
> > between these two approaches. Here, my condition is similar
> > to cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg but weaker. In 
> > fact, when cfs_rq->avg.load_avg is already 0, 
> > abs(delta) > cfs_rq->tg_load_avg_contrib / 64 is equivalent to 
> > cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64,
> > Further reasoning leads to the condition cfs_rq->tg_load_avg_contrib > 0.
> > However if cfs_rq->avg.load_avg is not necessarily 0 at this point, then
> > the condition you propose is obviously more accurate, simpler than the
> > delta check, and requires fewer calculations.
> > 
> > I think our perspectives differ. From the perspective of 
> > update_tg_load_avg(), the semantics of this condition are as follows: if
> > there is no 1ms update limit, and update_tg_load_avg() can continue 
> > updating after checking the delta, then in cfs_rq_is_decayed() we should
> > return false to keep the cfs_rq in the list for subsequent updates. As 
> > mentioned in the first paragraph, this avoids that tricky situation. From
> > the perspective of cfs_rq_is_decayed(), the semantics of the condition you
> > proposed are that if cfs_rq->avg.load_avg is already 0, then it cannot be
> > removed from the list before all load_avg are updated to tg. That makes 
> > sense to me, but I still feel like there's a little bit of a risk. Am I 
> > being paranoid?
> > 
> > How do you view these two lines of thinking?
> > 
> > It's a pleasure to discuss this with you, 
> > xupengbo.
> > 
> > > > +               return false;
> > > > +
> > > >         return true;
> > > >  }
> > > >
> > > > --
> > > > 2.43.0
> > > >


