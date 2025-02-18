Return-Path: <cgroups+bounces-6587-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F30A39932
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9611898C43
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7284123BF90;
	Tue, 18 Feb 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjJLc63e"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9C1AA1DA
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874624; cv=none; b=tn1KRh/Z156kOSKcdI3V4oBtZJHYoHgowsVang13+YoZUh6JU92emS6wSsmKwK31TxwP4PTdwglOXQoPRpcVqnqs+FiBrCn+EGLqgF5lNCowvd4ZGnh3V73JRpl3/KLmCRcwDahbjyKRQ55B3imgZKjU+q6eGU6VwwZWZxa86Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874624; c=relaxed/simple;
	bh=1v1+yGs8+/N/RADI56i+Ihhjc+nbn3bPS4R/90SHXDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5mqrwNZ3E/g+OTWG07S7mSbuOh8/CxSizmuaEQQx1C6RcMc6rfFD4+EUtIxpdp9adMy8UsVZdPw9MWdlirrObNHVkRMOBLm5qlZGMXMm2pmjXf4onl1W8Zjgylo7AhruLQttubX6jTtdIQ42W9XHm9wMFYuX5IIkg6mMejz+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjJLc63e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LauAAAlEvHKS7dRj8knYYOQs4SxKuXcQYbrkVAvMEW0=;
	b=UjJLc63es1tjDpBjdVGRKBD563OvmCfV6jWZ8YrG+aX346JKo/e1epgxwpIK9hpg27VX5i
	0s/t39LywdMdfuxd3uwJAnR4x500zLffvhdkuK+Jb4vstdA0mfmdv8bnnDjym7/1OAzlAX
	u9fm6x4yQc9o9saufcEk3oClAmUXIyk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-4VRQ3BKFMzOA98Ts87OeDQ-1; Tue, 18 Feb 2025 05:30:19 -0500
X-MC-Unique: 4VRQ3BKFMzOA98Ts87OeDQ-1
X-Mimecast-MFC-AGG-ID: 4VRQ3BKFMzOA98Ts87OeDQ_1739874618
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935bcec0aso42298605e9.3
        for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 02:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874618; x=1740479418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LauAAAlEvHKS7dRj8knYYOQs4SxKuXcQYbrkVAvMEW0=;
        b=q5epy9FgjuevZwPrzdQXFvG9wYjTYB5aLtSj9F6yAEatHFD1ajxuGb1OjPow8bKDz+
         no1e+Q+LGtiwsKFhd9Wyx11QPpe3doS4+ZfbgMHVvluUfEkcbDVlxrCQ2V6Obkpibt7x
         QPSdClYnoIPNuoOyQFBTR4Qp32Z3lEirz78T5YssWcrL97wRPrhbQqNV3WBWVKCcA4SX
         BKIBOCgQvwuNrNB8B4cZ1WjkIPu2QXD1IERB69Ge6S7IXpdT4f8Wgq0iDPyoTuAgpBUo
         Kqo6foZE2w3MPwe+E2EdFUGxoJIAiWjuKMCWmI4ssb7oBU7w/deZmzwiC3+sG0ZCZiav
         OEGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUto5pKrl/W9Gw67KYqQRxFbXt5qvN7XckJO/PsJWAdVmxnNQ9/iwF1+yGqtPQIUnBPjUIlJeuV@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCkpwqjJlYOGY2pEgcrV4taBfTQCGbqv2gvv5yYxCwub0UpOS
	MxAgXqzAOhySflZ+7kbsOPz09+Efhlpyr2azFwiU1nmCjkIeUsmgR6Fe0FHoWpy7uyUEjXVZIXq
	eliifqEEl4Io02bhK/+FTo2UwcxF5z9DP86QwCIyxaMYuvHRE35D6XQs=
X-Gm-Gg: ASbGncvthia7sBoXFStHVmFaH4qDR4VLvL3uJsbqhMp5wbJ7bSrJyL0HbMSYnrhg527
	IYZhCJ9eL+N4dLDUf7cdPmMduP7FnTR/3CZ1Zn+y6jdxru+j8ZfUs9uNJzy/MdfHoNDOG5T0TNS
	luaMsiKTipvtdIUi5teaK+K9WNEa69TvV8xuVNVRJcM1yDu+ntPB7b5mJJzaxp81yjXHV+qN96a
	a3poslNklQXBTVuUFGU/PbUPNM8Y5UJLpwe0ddtNbEypxuYY3GtqqxSv+RN+F+HgmFp+SgIm51R
	2KdADOhmQ3ML+GrtJfT3tfhG3EtAjPvyUw==
X-Received: by 2002:a05:600c:154c:b0:439:89d1:30dc with SMTP id 5b1f17b1804b1-43989d1328bmr59335605e9.10.1739874617836;
        Tue, 18 Feb 2025 02:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7aSbjVJTqNJv0ShEPIOLOehhZvYvDsEaV+3YYWlbmMTitPYqsZW8oRj+7KN2zheWWGsk4LA==
X-Received: by 2002:a05:600c:154c:b0:439:89d1:30dc with SMTP id 5b1f17b1804b1-43989d1328bmr59335065e9.10.1739874617351;
        Tue, 18 Feb 2025 02:30:17 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f22fsm176610635e9.5.2025.02.18.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:30:16 -0800 (PST)
Date: Tue, 18 Feb 2025 11:30:14 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7RhNmLpOb7SLImW@jlelli-thinkpadt14gen4.remote.csb>
References: <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>

On 18/02/25 10:58, Juri Lelli wrote:
> Hi!
> 
> On 17/02/25 17:08, Juri Lelli wrote:
> > On 14/02/25 10:05, Jon Hunter wrote:
> 
> ...
> 
> > At this point I believe you triggered suspend.
> > 
> > > [   57.290150] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> > > [   57.335619] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
> > > [   57.353364] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> > > [   57.397022] Disabling non-boot CPUs ...
> > 
> > Offlining CPU5.
> > 
> > > [   57.400904] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0,3-5
> > > [   57.400949] CPU0 attaching NULL sched-domain.
> > > [   57.415298] span=1-2
> > > [   57.417483] __dl_sub: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> > > [   57.417487] __dl_server_detach_root: cpu=0 rd_span=0,3-5 total_bw=157284
> > > [   57.417496] rq_attach_root: cpu=0 old_span=NULL new_span=1-2
> > > [   57.417501] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DEF
> > > [   57.417504] __dl_server_attach_root: cpu=0 rd_span=0-2 total_bw=157284
> > > [   57.417507] CPU3 attaching NULL sched-domain.
> > > [   57.454804] span=0-2
> > > [   57.456987] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=3-5 type=DYN
> > > [   57.456990] __dl_server_detach_root: cpu=3 rd_span=3-5 total_bw=104856
> > > [   57.456998] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> > > [   57.457000] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-3 type=DEF
> > > [   57.457003] __dl_server_attach_root: cpu=3 rd_span=0-3 total_bw=209712
> > > [   57.457006] CPU4 attaching NULL sched-domain.
> > > [   57.493964] span=0-3
> > > [   57.496152] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=4-5 type=DYN
> > > [   57.496156] __dl_server_detach_root: cpu=4 rd_span=4-5 total_bw=52428
> > > [   57.496162] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> > > [   57.496165] __dl_add: cpus=5 tsk_bw=52428 total_bw=262140 span=0-4 type=DEF
> > > [   57.496168] __dl_server_attach_root: cpu=4 rd_span=0-4 total_bw=262140
> > > [   57.496171] CPU5 attaching NULL sched-domain.
> > > [   57.532952] span=0-4
> > > [   57.535143] rq_attach_root: cpu=5 old_span= new_span=0-4
> > > [   57.535147] __dl_add: cpus=5 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
> > 
> > Maybe we shouldn't add the dl_server contribution of a CPU that is going
> > to be offline.
> 
> I tried to implement this idea and ended up with the following. As usual
> also pushed it to the branch on github. Could you please update and
> re-test?

And now for the actual change

---
 kernel/sched/topology.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8830acb4f1b2..c6a140d8d851 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -497,12 +497,14 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->rd) {
 		old_rd = rq->rd;
 
-		if (rq->fair_server.dl_server)
-			__dl_server_detach_root(&rq->fair_server, rq);
-
-		if (cpumask_test_cpu(rq->cpu, old_rd->online))
+		if (cpumask_test_cpu(rq->cpu, old_rd->online)) {
 			set_rq_offline(rq);
 
+			if (rq->fair_server.dl_server)
+				__dl_server_detach_root(&rq->fair_server, rq);
+		}
+
+
 		cpumask_clear_cpu(rq->cpu, old_rd->span);
 
 		/*
@@ -529,16 +531,17 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	}
 
 	cpumask_set_cpu(rq->cpu, rd->span);
-	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
+	if (cpumask_test_cpu(rq->cpu, cpu_active_mask)) {
 		set_rq_online(rq);
 
-	/*
-	 * Because the rq is not a task, dl_add_task_root_domain() did not
-	 * move the fair server bw to the rd if it already started.
-	 * Add it now.
-	 */
-	if (rq->fair_server.dl_server)
-		__dl_server_attach_root(&rq->fair_server, rq);
+		/*
+		 * Because the rq is not a task, dl_add_task_root_domain() did not
+		 * move the fair server bw to the rd if it already started.
+		 * Add it now.
+		 */
+		if (rq->fair_server.dl_server)
+			__dl_server_attach_root(&rq->fair_server, rq);
+	}
 
 	rq_unlock_irqrestore(rq, &rf);


