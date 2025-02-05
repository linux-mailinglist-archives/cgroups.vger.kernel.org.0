Return-Path: <cgroups+bounces-6430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48103A287A1
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 11:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C6F3A258C
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20B22A80B;
	Wed,  5 Feb 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj+SFF8k"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9122A4E5
	for <cgroups@vger.kernel.org>; Wed,  5 Feb 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750342; cv=none; b=F26PXer7cmbCHxi8HvNvzKEiNqUkdKxmfqber0MbyWMuzC1pbN4iWiyb0lLo1TnRhYUYLB6Orh4xCnvPXnzzuqhDRYkQ40frm6Sss1BvSdsqZkd4wyODR4Hg/A0jB5URYBPmb+RotJdDVrhTBBWLaOmkhz9N8Gk9rW1B+fz9D+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750342; c=relaxed/simple;
	bh=a2P+2eH17up+Ofa94del8h0XUqFDuWoe68Y1Hf85Cm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeMZpBc+KU9Rj+e3NfH4O9X2ICKQiAcTYHCvglySiX6ST9E0VR3sX/270+/aiOTvXkgRAZOyo8XjUaJjrp0OI4s2kOH229czYMh4gdXg8wkuyDW+OcsGtcBWAm4i+tqttcN9jHAqAoPF4jrKg84LqtyAYoPb3whS9/uF/bNba/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj+SFF8k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738750339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08znvKD929SmLMJj92WNC0Au1O4yxtiLADSy4vJ5xMg=;
	b=Oj+SFF8kXXURp6wOlV7bDrpt/gK8AeUFXuLj9M0r1IGyr6+IJ9NYR7PuYQX6b2cCBfTAgc
	uK7DL5xuskvSr4x0drWBTHVHYzZ9kWABNe7SD/G7NcwIO8bpdGZYj4SbX1vXMk1+emhskP
	bPu4n1Zc4YwTq5EBQ7zoprdLDvxqb+g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-WpcXGTyYMU-QK22M1pvG7Q-1; Wed, 05 Feb 2025 05:12:18 -0500
X-MC-Unique: WpcXGTyYMU-QK22M1pvG7Q-1
X-Mimecast-MFC-AGG-ID: WpcXGTyYMU-QK22M1pvG7Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38db47fd683so398804f8f.0
        for <cgroups@vger.kernel.org>; Wed, 05 Feb 2025 02:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738750337; x=1739355137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08znvKD929SmLMJj92WNC0Au1O4yxtiLADSy4vJ5xMg=;
        b=LMfK3JJ7xNjhP84RyPTLCffVy6DLSMYzO+4ciZTO1ICAtkcrMSPQt/Qz1ZH+vCPx5F
         DUEJU4asxhzABmOPtGrVInKgIx9a0w0FNTKgWp7Isxj6Cuili89r8x8730fhzVN0CMNP
         Ras73RZTG/LFZQFDFGFrXPAmJich0iKu29Zw5nnjt8NSpruoQb4HoguRfw4FVuVyQr5U
         Idpr/h+eNjpq6f/9GuTbdy69XqG5QGUpYvM+Uavo3HuVFRAITcwS+Se2A8inTwuGC5Ai
         z6BC1ZB2OT16EJz2w9LkihBV8iSC3OZ8XznNerZMvYpwSzUuqmQ4owFbIb2L3xEJ5tTO
         xYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnTJ816M74odds5aQqKLr/OfJeH8NWl8XnoZQXR2nI4KoR78bQhL+3/l7V6QgComjdFl0DDnT8@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqCP4WX9mvXIa8pbkUSpvu1dwOFfbFBTxmxnQ3VqGKJ9T+Bc3
	UJjfJ8VoJD4bAsC0QAS3tsUHQM17NeXQwLI1SqrPgaAoqQRf9J3ZqGbHJKgbsAqk767ZAOS13If
	aV36VtI0enloI2hoxlB4MnIMfhZyxfCINoQL13RiZF07UxYvaIYC4Qlk=
X-Gm-Gg: ASbGnctjV2n9E9k1NNLDtS9nfIK63yedoIKgqiqgYfBA63QMG7btgGYhHeqcCI0T8DE
	Oa4Aulq9yVblDDAxQEvyGUQd/VIW74LzxpzcNfU36D4Bwt6nbzVQhtD5PT59/sKSn7Ux4IeBY8u
	NjmZnFmGuOio6T2y8LWXjQ3li/Bq81XghZx7W88nD/PRr5VKSUdk1Qn7MdEAaqfRdEn0InVROEQ
	Nul9u4VqJI6dF9HoxSr8wfPTzQTSJMvrNB7Qz2hDiiutQW8Sd7vtimV8HI3Pdhx5+4uWUyM3QJh
	3btnEBLTAVeEh5z1Y9ucyBiA7UVyeZ1ByjPt
X-Received: by 2002:a5d:4d8f:0:b0:38b:ed18:2f3b with SMTP id ffacd0b85a97d-38db48fde1cmr1533519f8f.48.1738750336891;
        Wed, 05 Feb 2025 02:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBp5ds39K1Z0cI93vntWmYRE9t9+g0+e2YclFwvxaztwPXTJF7S8AlnkTaxvuqyjPtyZlBXQ==
X-Received: by 2002:a5d:4d8f:0:b0:38b:ed18:2f3b with SMTP id ffacd0b85a97d-38db48fde1cmr1533479f8f.48.1738750336470;
        Wed, 05 Feb 2025 02:12:16 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.128.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38da8f6691bsm4315071f8f.42.2025.02.05.02.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 02:12:15 -0800 (PST)
Date: Wed, 5 Feb 2025 11:12:13 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
References: <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>

On 05/02/25 07:53, Juri Lelli wrote:
> On 03/02/25 11:01, Jon Hunter wrote:
> > Hi Juri,
> > 
> > On 16/01/2025 15:55, Juri Lelli wrote:
> > > On 16/01/25 13:14, Jon Hunter wrote:
> 
> ...
> 
> > > > [  210.595431] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
> > > > [  210.606269] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
> > > > [  210.617281] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
> > > > [  210.627205] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2
> > > > [  210.637752] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1
> > >                                                                            ^
> > > Different than before but still not what I expected. Looks like there
> > > are conditions/path I currently cannot replicate on my setup, so more
> > > thinking. Unfortunately I will be out traveling next week, so this
> > > might required a bit of time.
> > 
> > 
> > I see that this is now in the mainline and our board is still failing to
> > suspend. Let me know if there is anything else you need me to test.
> 
> Ah, can you actually add 'sched_verbose' and to your kernel cmdline? It
> should print our additional debug info on the console when domains get
> reconfigured by hotplug/suspends, e.g.
> 
>  dl_bw_manage: cpu=3 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
>  CPU0 attaching NULL sched-domain.
>  CPU3 attaching NULL sched-domain.
>  CPU4 attaching NULL sched-domain.
>  CPU5 attaching NULL sched-domain.
>  CPU0 attaching sched-domain(s):
>   domain-0: span=0,4-5 level=MC
>    groups: 0:{ span=0 cap=766 }, 4:{ span=4 cap=908 }, 5:{ span=5 cap=989 }
>  CPU4 attaching sched-domain(s):
>   domain-0: span=0,4-5 level=MC
>    groups: 4:{ span=4 cap=908 }, 5:{ span=5 cap=989 }, 0:{ span=0 cap=766 }
>  CPU5 attaching sched-domain(s):
>   domain-0: span=0,4-5 level=MC
>    groups: 5:{ span=5 cap=989 }, 0:{ span=0 cap=766 }, 4:{ span=4 cap=908 }
>  root domain span: 0,4-5
>  rd 0,4-5: Checking EAS, CPUs do not have asymmetric capacities
>  psci: CPU3 killed (polled 0 ms)
> 
> Can you please share this information as well if you are able to collect
> it (while still running with my last proposed fix)?

Also, if you don't mind, add the following on top of the existing
changes.

Just to be sure we don't get out of sync, I pushed current set to

https://github.com/jlelli/linux.git experimental/dl-debug

---
 kernel/sched/deadline.c | 2 +-
 kernel/sched/topology.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9a47decd099a..504ff302299a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3545,7 +3545,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		printk_deferred("%s: cpu=%d cap=%lu fair_server_bw=%llu total_bw=%llu dl_bw_cpus=%d\n", __func__, cpu, cap, fair_server_bw, dl_b->total_bw, dl_bw_cpus(cpu));
+		printk_deferred("%s: cpu=%d cap=%lu fair_server_bw=%llu total_bw=%llu dl_bw_cpus=%d type=%s span=%*pbl\n", __func__, cpu, cap, fair_server_bw, dl_b->total_bw, dl_bw_cpus(cpu), (cpu_rq(cpu)->rd == &def_root_domain) ? "DEF" : "DYN", cpumask_pr_args(cpu_rq(cpu)->rd->span));
 		if (dl_b->total_bw - fair_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 93b08e76a52a..996270cd5bd2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -137,6 +137,7 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 
 	if (!sd) {
 		printk(KERN_DEBUG "CPU%d attaching NULL sched-domain.\n", cpu);
+		printk(KERN_CONT "span=%*pbl\n", cpumask_pr_args(def_root_domain.span));
 		return;
 	}
 
@@ -2534,8 +2535,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_cluster)
 		static_branch_inc_cpuslocked(&sched_cluster_active);
 
-	if (rq && sched_debug_verbose)
+	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
+		pr_info("default domain span: %*pbl\n", cpumask_pr_args(def_root_domain.span));
+	}
 
 	ret = 0;
 error:


