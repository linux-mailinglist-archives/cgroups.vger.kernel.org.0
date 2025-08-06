Return-Path: <cgroups+bounces-8986-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F177B1C072
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 08:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA1D3B4EAB
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3581F03FB;
	Wed,  6 Aug 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="TH8XNkpu"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013065.outbound.protection.outlook.com [40.107.44.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CE7346F;
	Wed,  6 Aug 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461930; cv=fail; b=ZYmzyUjQT1UXGxbXr8psl9gR2t5+9xfS0hfQlKppqCCnOuf7+V8geZAFKSCqLwpwgmhUcuS1Cn1QBnltP0qxsbHbcrNkf8U+x/QDo3g8S20BtVsVRbnpu4Uj7v6PVki6dagI0kRLl7FsUexWDPbUlwRzmNxskfVXySCtbEOIvoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461930; c=relaxed/simple;
	bh=Ewzq3b2SqiOfKoT/ZuaN9IMa3CUWkRbE97AqzxSF9k4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKqcwzkE+YrH3hT9PGrafINYBWtzk+LnLyJxY1GOXoM3q+FM6TE+9Cc6rTaK66z4C+uXeC8Jm26jtyCfNHUiLkMun8lDy9FFPN1lI4MlWOiZ9Vg7m4CDAtxi+QxzZRoq1jClZhSLCyM/EStgIR7XoVqQPLNgHmbP2FPz9KHslb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=TH8XNkpu; arc=fail smtp.client-ip=40.107.44.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGWTuSKAw4lophcIjEYOFnU8vGU/5QEqUrcCj7YM/ZHalVFcn/aRm0EG2KBYqMXKj/lvjKwrCp2IBJrUXrvPdDDb0/FtuRkv1R2XyDVjTZsUplhK1kLV+hXgmv1ajLGxmWODVP8hnuj/gw5J5wOvuj0UlC06WLINWptKIcxiuJmsP95vJ0iGO4ZJeGbSGabT/1nOQlgrXGGWg/qgSJKtIQxiPmqA0IUEBWxG5UbaoCeByt9vW1seVWKKHSNl3jtnf9Xpl1LTZjQ2oCboJqTM2mNxMTwtHvOoh6J13MFyApWxAoq/xozCDnxb5yNqW7yEG218iB0vgvEcDxRoKlr/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNHjWskjiPr0A1Q5ql2puxmqii3H9/Xins+B5SdZ0XM=;
 b=wTVUcgPq1C7LQYQ/4RToI1wSakggtbh3wev2S23omcpcts7GCSXN5wR+jm6AibIiG9YiDwSlaY7svLEqDRBgiwXJr3EhTLvc4ajbSLNShL/UG3IZsNMSG3oBqfsFt3Rp462ty47HaFTJ1fA0MQ+ffX4ifEF/U2aoF6MJBUN77radazWDcQqIt2+U7mCaLepXgxAbY/1GLhiBub3XdFT8/2OhhkAO+78xVFIhfN0wX+YAwLiYgLsPef/4WdakpF4oizfrMZ87JAfQRKF5r+zUNbeU6NJMWDEbcAXTOKBBN77CBooBh9kkY3OJV2xdYc0mqysucQ6VjbVjvWGA6DNaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linaro.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNHjWskjiPr0A1Q5ql2puxmqii3H9/Xins+B5SdZ0XM=;
 b=TH8XNkpu47KTYb+IEUdxt7O1mamfrrQiR1GFk8uMEihEuWx+fCr7WfOc1On3mUKEFtB2kjbJNrC6LoiSpYRd9jh6g+1vRosC0WsFgASLEPe2oTOTgZVOWQMQPuZZM2mEp7Hqac7J7i238ULBBhfcdKpjiemdiNznZz/bnzuZCwc=
Received: from TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) by KUZPR02MB8823.apcprd02.prod.outlook.com
 (2603:1096:d10:4b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 06:32:05 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:404:8000:cafe::29) by TY2PR0101CA0025.outlook.office365.com
 (2603:1096:404:8000::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 06:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 06:32:04 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 14:32:03 +0800
From: xupengbo <xupengbo@oppo.com>
To: <vincent.guittot@linaro.org>
CC: <bsegall@google.com>, <cgroups@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vschneid@redhat.com>,
	<xupengbo@oppo.com>, <ziqianlu@bytedance.com>
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Wed, 6 Aug 2025 14:31:58 +0800
Message-ID: <20250806063158.25050-1-xupengbo@oppo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKfTPtDexWX5N0jaMRqVQEnURSaPhVa6XQr_TexpU2SGU-e=9A@mail.gmail.com>
References: <CAKfTPtDexWX5N0jaMRqVQEnURSaPhVa6XQr_TexpU2SGU-e=9A@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|KUZPR02MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b70786b-0878-4e74-fad2-08ddd4b2f5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ry3SAZe3omE0xX3JA6xRVNM5k+Bu1QM6BMcKtzmWhOIvdsy2PXHzddIfx6zv?=
 =?us-ascii?Q?YzJJE1LSwZbRkQ2x90+bWTgBArgeiOvcTm5TMxxQQ3RxuJunsjRaZJeQEFGt?=
 =?us-ascii?Q?Im1K0sEFiAa5kmbnBAY3sch1zUegLd69pzygOdvLmqUhRvlqsST7TuOCXZFS?=
 =?us-ascii?Q?11SH5i9Rw1bW47RCryWC1MkinzdSvysljTcVmy3ggy7pCxaYFIMnUggD0qUB?=
 =?us-ascii?Q?OkN7ACYo6vTlV57XNWmSfC91+4M9+twuk1hFn30S9oNG21Iuhe+uWFdH+AoU?=
 =?us-ascii?Q?oO3jBxX5MiRhcrXaklEP/D3hXFZkts0WUbuwKGgLOtHAlXgYrtH5TXQoM65v?=
 =?us-ascii?Q?Je25xaiy94Q60kRyZ/ZULy9cp61euFb78HxpQGpSH+WbrVymkRZfFojVe68G?=
 =?us-ascii?Q?lI+jZG6QH9YWdpk27REswc5eG77UoXx+wA/909CAtiJkjrUu0LZJWlJgumAF?=
 =?us-ascii?Q?H7XYvlmlG/wNRKL3LZehBlq7Odnww1dnuWpK6WkTSlUBsoidj6iTS4wh6ctU?=
 =?us-ascii?Q?FwwSseAlACjDQaGgZfyyBZ/IBqgElquMiVK41e9nz5oX4sH37z/S8NgCLu6S?=
 =?us-ascii?Q?R2n3y2qbyFvE+nZ4XV2+ca77Dh4UZiZNTpUgEK1yO+jSXnYd3RQBn/ihgLnd?=
 =?us-ascii?Q?cJNQi0YIPwFwqMW9T+bIjQK25fyX8+LzFfseObRCWXh7xFZiXMZVUK5SuSIw?=
 =?us-ascii?Q?9lapURBE8opXI2f+FJqlDsoPnu2Tgl31s5Fsp7UIiyYvIJPTi9IGaDufGQbq?=
 =?us-ascii?Q?lj6tXSy5/Eki4ZT96eXlwV5K6o4dAUSh5omzr8gwdkCQZ0G9dmOiGZavznnr?=
 =?us-ascii?Q?biaeT31btdcMRLOvjBkDsGDdDzjjnqpYegYEtgqNBmAAyfEZZ+EFF88I370P?=
 =?us-ascii?Q?CREqMUN9zxv07p/2jCDP5lPeuLjmlIh7tOlLelbVM2RndkEIqxU3g9C7Z/6M?=
 =?us-ascii?Q?3v0aeOLdH1dKehuT/W/+4zZTk8n3MkPYPuqfKDbOyQpXWkT9yNhVc5RSXbFT?=
 =?us-ascii?Q?inKScjx3ZoCCBHjOYI03AN70gVxHmkh/9Fw3gG3tP/Uw6zY+uIXpq5WAovzm?=
 =?us-ascii?Q?I5warV4N8g5mzua9FnQUuA+OXGTH6p1y0v0uuTX2E6IsIfAf2KyGBYVqEkaF?=
 =?us-ascii?Q?V6lG3mHjuXwpuevTBaA0YH2DqsIOfW37SVLeP9WLihNf+4bG5pjA50gYmjIE?=
 =?us-ascii?Q?s4oTW51i50FMA7kNabuZ0eUrJsAe3r90uTk30N5ylqwF7dMKkmjcSCIu6UEf?=
 =?us-ascii?Q?kYJN0HR4wdu5iXLlqSI9ltRqA7pjA42cJLxM0uz7DCNdDqGSfFOURSHkqc4s?=
 =?us-ascii?Q?Z6Itq8k881aNMBbO1GD3Zm5tzCywq0g42i2DR9kg6aLqJ9ucT430HFgIeUvz?=
 =?us-ascii?Q?dyMMuyOli8h6PDMMIZBqBHVZcqzXSCP4TEEIfuZ+P8cXszQLYP1UiDqdeuxn?=
 =?us-ascii?Q?x2pUt+7MV2qGljbSlNVL/L89kT95ZUQ+bryClG/ta7yQ1M6CD3uuHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 06:32:04.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b70786b-0878-4e74-fad2-08ddd4b2f5a6
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB8823

> >On Tue, 5 Aug 2025 at 16:42, xupengbo <xupengbo@oppo.com> wrote:
> >
> > When a task is migrated out, there is a probability that the tg->load_avg
> > value will become abnormal. The reason is as follows.
> >
> > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > when a task migrates out.
> > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > function cfs_rq_is_decayed() does not check whether
> > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > updated to tg->load_avg.
> >
> > I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> > which blocks the case (2.) mentioned above. I follow the condition in
> > update_tg_load_avg() instead of directly checking if
> > cfs_rq->tg_load_avg_contrib is null. I think it's necessary to keep the
> > condition consistent in both places, otherwise unexpected problems may
> > occur.
> >
> > Thanks for your comments,
> > Xu Pengbo
> >
> > Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> > Signed-off-by: xupengbo <xupengbo@oppo.com>
> > ---
> > Changes:
> > v1 -> v2:
> > - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in
> > cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> > - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/T/#u
> >
> >  kernel/sched/fair.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b173a059315c..a35083a2d006 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4062,6 +4062,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >         if (child_cfs_rq_on_list(cfs_rq))
> >                 return false;
> >
> > +       long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +
> > +       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
> 
>I don't understand why you use the above condition instead of if
>(!cfs_rq->tg_load_avg_contrib). Can you elaborate ?
> 
>strictly speaking we want to keep the cfs_rq in the list if
>(cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg) and
>cfs_rq->avg.load_avg == 0 when we test this condition


I use this condition primarily based on the function update_tg_load_avg().
I want to absolutely avoid a situation where cfs_rq_is_decay() returns 
false but update_tg_load_avg() cannot update its value due to the delta 
check, which may cause the cfs_rq to remain on the list permanently. 
Honestly, I am not sure if this will happen, so I took this conservative 
approach. 

In fact, in the second if-condition of cfs_rq_is_decay(), the comment in 
the load_avg_is_decayed() function states:"_avg must be null when _sum is 
null because _avg = _sum / divider". Therefore, when we check this newly 
added condition, cfs_rq->avg.load_avg should already be 0, right?

After reading your comments, I carefully considered the differences 
between these two approaches. Here, my condition is similar
to cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg but weaker. In 
fact, when cfs_rq->avg.load_avg is already 0, 
abs(delta) > cfs_rq->tg_load_avg_contrib / 64 is equivalent to 
cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64,
Further reasoning leads to the condition cfs_rq->tg_load_avg_contrib > 0.
However if cfs_rq->avg.load_avg is not necessarily 0 at this point, then
the condition you propose is obviously more accurate, simpler than the
delta check, and requires fewer calculations.

I think our perspectives differ. From the perspective of 
update_tg_load_avg(), the semantics of this condition are as follows: if
there is no 1ms update limit, and update_tg_load_avg() can continue 
updating after checking the delta, then in cfs_rq_is_decayed() we should
return false to keep the cfs_rq in the list for subsequent updates. As 
mentioned in the first paragraph, this avoids that tricky situation. From
the perspective of cfs_rq_is_decayed(), the semantics of the condition you
proposed are that if cfs_rq->avg.load_avg is already 0, then it cannot be
removed from the list before all load_avg are updated to tg. That makes 
sense to me, but I still feel like there's a little bit of a risk. Am I 
being paranoid?

How do you view these two lines of thinking?

It's a pleasure to discuss this with you, 
xupengbo.

> > +               return false;
> > +
> >         return true;
> >  }
> >
> > --
> > 2.43.0
> >

