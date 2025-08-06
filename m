Return-Path: <cgroups+bounces-8990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650EB1C24D
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F85E16AF10
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3A288CA1;
	Wed,  6 Aug 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="EYSdc+YJ"
X-Original-To: cgroups@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012047.outbound.protection.outlook.com [52.101.126.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8D26E70E;
	Wed,  6 Aug 2025 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469505; cv=fail; b=b6RFwUHiunsrzImOaUaX4jQ9gp7NXNkhYEjL5fxRiUxj1VfDA6Kj4uI9DvG7s0mXHCfQYSRT79ngKIPYG0AvAauREmtlVmXvMslNUVRK17ta4HPqMUm1BKL2cLlTtccixLsD7O2wHu63npkjQnp18xM96bZ6dPBk4b/j+jE7q0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469505; c=relaxed/simple;
	bh=XcbLjnhtzjjVOT0bkJoHN23F7XVVkjRIdNZw9Oiy57I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFmSzYOp3AttRV0HwBvsWvKdXudTa88BWvCHXnfCKWHbPwz1KlkcjkhFk2iDTjXOdsRRVYJqI13fM2q5bO7KlbhzgOak+9vC3xbd7KyvI9VMQxUNblUwgb3SBiPG4YnM+SRyjbRFbtqSgLCB8cjwng+ZO7Fk62ZURC+vSFPOBCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=EYSdc+YJ; arc=fail smtp.client-ip=52.101.126.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsNRkC3Abux3qin0zue8y1HwY1+cHocnbcIucCSREBoIVc7K2P7XtKLb7gBdVJU/J9laPINH4EVhh/zaTl04+B/EkokOBYDl/g8RY/PqZZvXcCByWDubIsZ0Pe8S3u3e9SbimniPqNRxGLRT+GWWFZaRf3V6z6PDiTPAtGXzO0SvYH5+i4W+G3XooO60Jyc45uV4UjWLRoUvnvCR5PY00fLuB7n3dX7Q79+XGNmXdB/OahPAD+MSi6aCsXCBPD3ZXrEkaQ8AkyswaF2mYItoC+KFZMpLdkYUqGwoNTjhVt9ppb/Q5r4Cli+KQHtwL+cxDqe7Zjkd3UQBbdOu7O1jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COucDmA/gogHHeLhmdTC1Md70EyJ9FBK6MY7hBnODqA=;
 b=CHA43MQDiYvErqBSs1o3fUg1+CzYnwRMoSAIvsGGkRBQ4dAehKlsqfJWzGIYt2AckIFmxwi/FD4hdUCsgdlr6aiKWH+3On9wB/yefqhBI1USJdu4CpYlTh46zAM3zKgkz9pWlTDDBeSaHWtyPoCfqo+6uDaV1tWVXcBmawtmU07EXrY5iOD6HN+GtNw2DuGKFDhhp/Ayux331deDt/GidcfN0itNfCwdMv8F3PC/3ahOVpbg8X17n60tV63GL9kRqHkr84KhT1oekqycRMjlvZylpf6pMOf3nAFg6oSbcbZIJTYUvFxK9E0hdS1VK59qmrkPFDCftF95Cz7IVChTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=bytedance.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COucDmA/gogHHeLhmdTC1Md70EyJ9FBK6MY7hBnODqA=;
 b=EYSdc+YJSix8FfQCtGkCSI1pyEkRLzbfuk9Z7DBqV0+5UVtjzGGxXJKnpEOCrU+IPznAxhjeaTX2HCYln+6DxcLKBYh1t0HHpckwSq5+BsYzn2I12IQNeIxOkWcnPZERwJIO13ckgT9ZOF518LEgv89Pb90MiqMnvDy2gm1aHhk=
Received: from SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) by KL1PR02MB6974.apcprd02.prod.outlook.com
 (2603:1096:820:104::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 08:38:17 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:189:cafe::6) by SG2PR01CA0183.outlook.office365.com
 (2603:1096:4:189::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 08:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 08:38:16 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 16:38:15 +0800
From: xupengbo <xupengbo@oppo.com>
To: <ziqianlu@bytedance.com>
CC: <bsegall@google.com>, <cgroups@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, <xupengbo@oppo.com>
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Wed, 6 Aug 2025 16:38:10 +0800
Message-ID: <20250806083810.27678-1-xupengbo@oppo.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|KL1PR02MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c34df5-446c-4065-15be-08ddd4c496d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hn1cLPW1eY/jw1s//awhN9f5Wd2vCLzvWlbi/zkH5IdPTN3zEL7ifz7VbCGm?=
 =?us-ascii?Q?HNHNrw2iulU7uI1JrM17EF2hinyiPfZfg/kunl7tkXF4BqUvuxfQpn8pj0pr?=
 =?us-ascii?Q?1fmvfHIDSyxdB1QAb6SouLl+Qqhte9qlCAZlyAdq1sxRdp08Q8MzK+m65Pv0?=
 =?us-ascii?Q?QMDGH76NvMezxuLgHk9ZveLl0kLdkDqH83V5cY9SMrMA2YimxcTEPBpidy5p?=
 =?us-ascii?Q?fdyO6i2PFqNoj9DhVp/yY5lMNVMP8yMhW9eVDyOk5ILic0p2XfZix1bQllWR?=
 =?us-ascii?Q?0thhveKNjNW3CA8Awoz//md+hb4c9csxM3dzaS6LA39zQZVZbcZzm0cIYoUK?=
 =?us-ascii?Q?tyDVh2lu0HxCrPHMG2zJm7FC/eVtoFHannh9yovflVq5JeRa+/+0+B6W/39o?=
 =?us-ascii?Q?0Ax2ylflrCSrrVlw4G6c9FvsYfEWYS2YcscUMEniY4w1Nr2JuljK1kGMU8Ed?=
 =?us-ascii?Q?lYBal4crQTCnX9rCLpIgVxFYqbfL7rvjeXD+N2HUJhIwLsDIoeo9fprcBSWi?=
 =?us-ascii?Q?x1Vc3uScLyh8ItxAy+4G3+e7A/5/1mdidtnFdLdXYGxwUdZ2GUj/Jel2R4a8?=
 =?us-ascii?Q?s5XOoBR8MzAhCCzHgC9hjhqxhX49llWwEWGYdJjiDt+tD1SRLLN8ngQvlp4/?=
 =?us-ascii?Q?EN/NqxM3eJ/xGiDGFXDsaA3Ld8cXSnpZwnVzESvOMQZBjATzuehUPbT6/vp9?=
 =?us-ascii?Q?X2aBDvhpRCW+mwByfdB/8S6eNWpe75NPgcT+g3ANztpR2Wp8C1gbYiiRN9eY?=
 =?us-ascii?Q?XgISu5tumDWUW4QtL+yexbTcjUBgN3wqF6+F9Ers8ZmmlAWParYM7dlk4bOP?=
 =?us-ascii?Q?zcSfFP6917MizFHnK7/PiQF/4YLwOXAZAV23sGgjV7aQn9ALzatbI+VMee+k?=
 =?us-ascii?Q?hCoGdNFFLjmtyVsoc9zeUc7cepQ1NKSWSCc2w6YXPyvDPPVuFEsEup+QyP2V?=
 =?us-ascii?Q?eMs/pOoQq+YHr4K5ZwtigfV54m1JL2fjyygntk6nvCL+VxlHZZHxY12cLAtV?=
 =?us-ascii?Q?piOK5nSLYvKKZltLYlZE7FpkyBtP83YBSdWK9VOMni67DiswUiwyxy3UgRjS?=
 =?us-ascii?Q?8SeSchUenJjHiGMZ31ycq8zD5SY0cet2mbgrwdenutTWURZAttikMCiBs+9R?=
 =?us-ascii?Q?YmnZyKj5X4BQ/QNAIx1/0OUDmHE8QgPJG+iwny3tkW0Da7vGimpwNfeQ60pp?=
 =?us-ascii?Q?56iBAzxlIsH+fIOQs82NAA+iJZqPAtPoxBnSoL6smKTvPhkhYfD+zMF6IuOI?=
 =?us-ascii?Q?krS/JVKbz5f23yOB9QbPXA6M6Yfq55ZwQiPM2R+Zp2jJGEuec+xux+jeoyZW?=
 =?us-ascii?Q?WvbZpJlKDkJGneCagi+pFlFk+IwTK5BzJqVkbllTmGtL85F2TDs/WPHtAdlX?=
 =?us-ascii?Q?qO9qrsVmFmJ9IslnmV+vpQLWuqMLSy5C5arpKhztAZMT9Y8kyGNnDwwhi+nO?=
 =?us-ascii?Q?lygbC9zYWz4Iw+fJG4b8FbiN1foDVLHmsZzvEKkvXmf8FdX+ezD1LA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:38:16.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c34df5-446c-4065-15be-08ddd4c496d9
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6974

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

Sorry I was misled here, I think it should be if (cfs_rq->tg_load_avg_contrib ! = 0)

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
    if (cfs_rq->tg_load_avg_contrib)

Sorry I just made a mistake. 
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


