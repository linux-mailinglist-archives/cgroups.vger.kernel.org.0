Return-Path: <cgroups+bounces-5561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F137E9C8F73
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 17:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF39C289B90
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9970214E2D6;
	Thu, 14 Nov 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqX5sU7c"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596076026
	for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600848; cv=none; b=h1I5lFj8MminVDtTYQtlji4DtcNJ12ykBf/aiNYzBSEeAOIhype6LFdZRVoqkB+9/N+jL//OTB9gq4CAtM4ZoyLgoVWDBXwcdXQIabbcsuU7/RZBfqugoQXKm/sAo+u/Bl59txQjiv/1gVFX8Hfy/NasISkx/dDGJltcyUf2I+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600848; c=relaxed/simple;
	bh=1RN7tyr/xpi1Iyz9+0tasAurFfALZXmSFk2Z51jBvn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBOqaE7llYluRrt7PvWoSZH9pQNfJwQDnOZfCioRcLFJrDj9d6N+JeZAGiVLvUsWAAaZO8fSsVeESyUHlvofL/ehbHsmTlE6LdZcWooFwFq5sZG1K6xU+w5ayjmdiqCeyVzJxT5mZgla9/U2+icsEQYhU2xCUgVXZTdYylyARUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqX5sU7c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731600845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaWMQRDcdpd2bCtg+kKRN9VG9vMpZyor3XYx/XAZPJQ=;
	b=TqX5sU7cIXQ2wfJ6ZNuEBb4BkXE6R9C4jWeXV60I0lY8DdkoH6dNTGFLnGXg2ONX+vmPHf
	cdMspCzn+8NaKNq0j6o1iGP02fiVvJNrK6nzzJrehW2Fm/vnUGgAvuFRr9cle6e7AxDWyK
	GhsrpCFqId8rCFQ0gvFiQQ7PIu4vdYg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-jSBDEq8LOiuDRGIZu6Mwlg-1; Thu, 14 Nov 2024 11:14:04 -0500
X-MC-Unique: jSBDEq8LOiuDRGIZu6Mwlg-1
X-Mimecast-MFC-AGG-ID: jSBDEq8LOiuDRGIZu6Mwlg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d603515cfso424729f8f.1
        for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 08:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600843; x=1732205643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaWMQRDcdpd2bCtg+kKRN9VG9vMpZyor3XYx/XAZPJQ=;
        b=Y3ek7cf7q2ODrViCnkT59L4h8rp1xuBimLNsUEHQS8Yu7xtzyhYXOKidmmKu92Sp/v
         l/Bv9RT1J/nMJCZP3AFq+amjq4sC2oOX6F/C05kbch/vFQY9eRvwfqJLwbigVj4VCkQU
         7bKq3CumvPgLzLH0ZCEMPg3f563BCK0uC/854gdyNukCoX/uQj5ZHPnxQvMq3jPTSLnv
         PzNq6Pwo5HP1zT6swdTb0v4f4n4eCbwpdhtJAEkc5GawSZojGaIc4JPty0D08rtbev3G
         wHTfo0hY62/Mj8spMRsNm3YjqqGNNTjKujkG+b+vBDF/tusc2pixhKfh+5yf7svVgw/J
         NhGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPAvQKaTFRrYeQGW1bBTum8gECvfgDA/oZncWfdmwq6xwj8lkaEQzFnW1QAWDzSbVGqifdR/D+@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWi5cGie0J6hspqtGnrmD4u+yzzAA8vlfRvFDHp3+YMldextv
	hBWyE1hjM47RzMwHnle1JsPPxtAa3CyrOvjoXQFR1ILWKh2wBkDnSzSDJF6fIwNE0ScDDHmUZH5
	9MF0Z1zJPqV2+a3+l6mV5nq8algWE68hTur8I3aqhn2CRfmkGFQeouws=
X-Received: by 2002:a05:6000:4711:b0:378:7f15:d51e with SMTP id ffacd0b85a97d-38218538e3amr1984783f8f.43.1731600843190;
        Thu, 14 Nov 2024 08:14:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUIYjCdU1AwFvWay9cBvZfF3w9KboS3jI296juNq/s23tFCuYm+rB8xd5g8if1KJ/qTUtszw==
X-Received: by 2002:a05:6000:4711:b0:378:7f15:d51e with SMTP id ffacd0b85a97d-38218538e3amr1984757f8f.43.1731600842791;
        Thu, 14 Nov 2024 08:14:02 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbc44sm1879839f8f.45.2024.11.14.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:14:02 -0800 (PST)
Date: Thu, 14 Nov 2024 16:14:00 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix DEADLINE bandwidth accounting in root domain
 changes and hotplug
Message-ID: <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114142810.794657-1-juri.lelli@redhat.com>

Thanks Waiman and Phil for the super quick review/test of this v2!

On 14/11/24 14:28, Juri Lelli wrote:

...

> In all honesty, I still see intermittent issues that seems to however be
> related to the dance we do in sched_cpu_deactivate(), where we first
> turn everything related to a cpu/rq off and revert that if
> cpuset_cpu_inactive() reveals failing DEADLINE checks. But, since these
> seem to be orthogonal to the original discussion we started from, I
> wanted to send this out as an hopefully meaningful update/improvement
> since yesterday. Will continue looking into this.

About this that I mentioned, it looks like the below cures it (and
hopefully doesn't regress wrt the other 2 patches).

What do everybody think?

---
Subject: [PATCH] sched/deadline: Check bandwidth overflow earlier for hotplug

Currently we check for bandwidth overflow potentially due to hotplug
operations at the end of sched_cpu_deactivate(), after the cpu going
offline has already been removed from scheduling, active_mask, etc.
This can create issues for DEADLINE tasks, as there is a substantial
race window between the start of sched_cpu_deactivate() and the moment
we possibly decide to roll-back the operation if dl_bw_deactivate()
returns failure in cpuset_cpu_inactive(). An example is a throttled
task that sees its replenishment timer firing while the cpu it was
previously running on is considered offline, but before
dl_bw_deactivate() had a chance to say no and roll-back happened.

Fix this by directly calling dl_bw_deactivate() first thing in
sched_cpu_deactivate() and do the required calculation in the former
function considering the cpu passed as an argument as offline already.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c     |  9 +++++----
 kernel/sched/deadline.c | 12 ++++++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d1049e784510..43dfb3968eb8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8057,10 +8057,6 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_deactivate(cpu);
-
-		if (ret)
-			return ret;
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
@@ -8128,6 +8124,11 @@ int sched_cpu_deactivate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	int ret;
 
+	ret = dl_bw_deactivate(cpu);
+
+	if (ret)
+		return ret;
+
 	/*
 	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
 	 * load balancing when not active
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 267ea8bacaf6..6e988d4cd787 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3505,6 +3505,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		}
 		break;
 	case dl_bw_req_deactivate:
+		/*
+		 * cpu is not off yet, but we need to do the math by
+		 * considering it off already (i.e., what would happen if we
+		 * turn cpu off?).
+		 */
+		cap -= arch_scale_cpu_capacity(cpu);
+
 		/*
 		 * cpu is going offline and NORMAL tasks will be moved away
 		 * from it. We can thus discount dl_server bandwidth
@@ -3522,9 +3529,10 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		if (dl_b->total_bw - fair_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
-			 * wise thing to do.
+			 * wise thing to do. As said above, cpu is not offline
+			 * yet, so account for that.
 			 */
-			if (dl_bw_cpus(cpu))
+			if (dl_bw_cpus(cpu) - 1)
 				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
 			else
 				overflow = 1;


