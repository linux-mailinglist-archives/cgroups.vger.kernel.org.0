Return-Path: <cgroups+bounces-5572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90D9CDDB7
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 12:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6131F22479
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB91B6D17;
	Fri, 15 Nov 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7XF5kcK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938352F9E
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671318; cv=none; b=KpCTd0oSuVWCK4xwk9wNnYpzPenr0UiMoSXKtJ8JgQypTS9YesYFMD2EW8uQVAj6onqiqa4Qn91EMUznq7eZ1LbOLDEI0XUbGP4yl4BZn3tLxsnmu2rV+WpsV4O0CmFIaHnfM61C6DrG2arkE4MdHJz3GcjquPY+8K0174Da7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671318; c=relaxed/simple;
	bh=UAoDimOwp13wZS34aCKx3iW2aQwgJV3zOt5qRLLTOAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+m0Pfx8nq9fRlUo5WjlFcqSiyGRvcLTjwuQ8YVCz0tqFxxWh3jd2yDQG/pphBLPQA9xvn2K7yOyZG/5FktaG9d+KuPFUj0wd27vMTHE5u2BMZYji6hyQh7n3pUkfCTFxOhQzfC3r8S3vGD9/jaP8HgjWTcdJW+hXowcjpFmk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7XF5kcK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731671315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5Myvkj760K68jN4/CxybPiP+G9N9utEoeb8mQtoXFA=;
	b=i7XF5kcKsmPZHg7nbu4H7zAs+JRk71nXjPR1kKTcJrwXjdTvOsacv/MnYRy+9YRZDz4t0j
	YsLJy76wqPHNjWiDcVbEwNcTttcmIk8t83zUa0g5ZyXYc1uUnAWqTbkvKEyefASx00kQ/G
	97nW+cxZe3uY20EO9XyuEdrs5G/hu7g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-bcbqgUKAM-CG4iOtx1iRuQ-1; Fri, 15 Nov 2024 06:48:34 -0500
X-MC-Unique: bcbqgUKAM-CG4iOtx1iRuQ-1
X-Mimecast-MFC-AGG-ID: bcbqgUKAM-CG4iOtx1iRuQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-381e8cf69a6so1023527f8f.1
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 03:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671313; x=1732276113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5Myvkj760K68jN4/CxybPiP+G9N9utEoeb8mQtoXFA=;
        b=k4RnZdZczz+pZsn0BgR5MMxYxvW7lu21aagcKZ1YgAXhY5wnqI4oL05jGi3M7qo2K1
         3djHwYVrctZywYFD7IxR6vpdnHOcvWmqz0ismNF+jJmtfgK0Nw2U1gQrENHmVL4IgFp2
         E1BmaYww3LVvH8HRjZ4nedXWF5NT7JusKjKiWo2Eme9d6FtVU2HJLW5HR4nUVkQz8n07
         BzKaeYgW7RMt5SnhomuS94B/ETpWW+8lxrrYYH7C3dkCFGQZObPey5y8GhD3/qoJ7gU5
         nx6+qY+1rX3WCro8ozKghmNoDL25UpWDahGUYeAm05WFS7cPuyfLy3BCSDz2bnZYNBqd
         Qaew==
X-Forwarded-Encrypted: i=1; AJvYcCVayEYy6gR0jQ2TTgoUJGJlvt7gPh8RRTMpt4rsZv3gnOiqypA9i81I67To7m5cLIxf5dYeZFQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxC774R+La7eszu0LaoGvt3FG8uex4rwiNT1qatvjhLco60nO
	j7M8erZ1gifCAwjgL8ft7dIhyz7ElRjDAZFs5l2a6D4FIO0h0fbF6P1RiiEj94VyuFpYKUehk1j
	lIQ0/5d6lt2lL0iRxxltV/Xz3uMKzGIhwb1YRwvHs29mFI0k/6/O3tpc=
X-Received: by 2002:a05:6000:1863:b0:382:1c00:d47a with SMTP id ffacd0b85a97d-38225a91de7mr1970147f8f.36.1731671312704;
        Fri, 15 Nov 2024 03:48:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkdaxF08qnytbdOrAtWS1OCHChT9d+cqHL0CIRbJlmylx2cropfzqREiAIuunfvnBv8d922w==
X-Received: by 2002:a05:6000:1863:b0:382:1c00:d47a with SMTP id ffacd0b85a97d-38225a91de7mr1970123f8f.36.1731671312264;
        Fri, 15 Nov 2024 03:48:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbeb7dsm4100827f8f.58.2024.11.15.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:48:31 -0800 (PST)
Date: Fri, 15 Nov 2024 11:48:29 +0000
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
Subject: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier for
 hotplug
Message-ID: <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>

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

By doing so we also simplify sched_cpu_deactivate(), as there is no need
anymore for any kind of roll-back if we fail early.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Thanks Waiman and Phil for testing and reviewing the scratch version of
this change. I think the below might be better, as we end up with a
clean-up as well.

Please take another look when you/others have time.
---
 kernel/sched/core.c     | 22 +++++++---------------
 kernel/sched/deadline.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d1049e784510..e2c6eacf793e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8054,19 +8054,14 @@ static void cpuset_cpu_active(void)
 	cpuset_update_active_cpus();
 }
 
-static int cpuset_cpu_inactive(unsigned int cpu)
+static void cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_deactivate(cpu);
-
-		if (ret)
-			return ret;
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
 		partition_sched_domains(1, NULL, NULL);
 	}
-	return 0;
 }
 
 static inline void sched_smt_present_inc(int cpu)
@@ -8128,6 +8123,11 @@ int sched_cpu_deactivate(unsigned int cpu)
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
@@ -8173,15 +8173,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 		return 0;
 
 	sched_update_numa(cpu, false);
-	ret = cpuset_cpu_inactive(cpu);
-	if (ret) {
-		sched_smt_present_inc(cpu);
-		sched_set_rq_online(rq, cpu);
-		balance_push_set(cpu, false);
-		set_cpu_active(cpu, true);
-		sched_update_numa(cpu, true);
-		return ret;
-	}
+	cpuset_cpu_inactive(cpu);
 	sched_domains_numa_masks_clear(cpu);
 	return 0;
 }
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
-- 
2.47.0


