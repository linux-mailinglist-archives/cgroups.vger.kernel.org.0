Return-Path: <cgroups+bounces-5529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8872A9C6FEC
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 13:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C0728B52E
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD202022F3;
	Wed, 13 Nov 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixtGG0Oy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9631F77A2
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502670; cv=none; b=HKaGTaqVT6SUkp07Ghotgk9X4l/AenJFXjwDZH5dysU625lHsxzmZEVVCpuxNRdfIaPlKcxdMO3hlLUpuQBONh1X7XVZbaCPtKpi4lB41DIHOxQSaCqm+grfqKssQCt2vMqgyLWD5LDUvVbwC27Ang3INsheWB+eBkld/rmvYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502670; c=relaxed/simple;
	bh=YmiEgT/yi/9glvt++sRIcz8wFH0eUrfmtf5tjePm8dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOBSwg8FQZvHwBR0QtmpXk8p2Kwy3taMVfPo16EXsyugNi3VC+IOW/2FOVUxoVHmMCmwebBIiByPimspwEKytygSHyFYO8UuKx4mMMoH9lgiKBqnOkkRO9pNMY1GRLJDXCcrFH5ZYzEbbaNdaO2QsMaGBVTDFKuEJNU3ZcHHem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixtGG0Oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrrjP0KEDM8lqL2NE1SqjbzvwUoKziuZjRGMfoLwWGw=;
	b=ixtGG0Oyc6iMxyjX0pkS6ltIDdPBM0gJ0XJoU4OBHHm8xhiuBA8iXDhy8Ah1yCr66Lr2hV
	pvHbDzfFpe9VuwlMv2hfJ1pgmqMQBwcrHz8l9BzHYwCaTSuCeyuhJHqyDsYAXxd/P2Kyie
	uBgqkdJdJxRYQehj+YxqZDqCAxonoJM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-HcUmAQxMOGGAzQAY3VcE-A-1; Wed, 13 Nov 2024 07:57:46 -0500
X-MC-Unique: HcUmAQxMOGGAzQAY3VcE-A-1
X-Mimecast-MFC-AGG-ID: HcUmAQxMOGGAzQAY3VcE-A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4a211177so3858639f8f.0
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 04:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502666; x=1732107466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrrjP0KEDM8lqL2NE1SqjbzvwUoKziuZjRGMfoLwWGw=;
        b=qE+iYCfOTMFodbueX6Js53GgcVzzGdELi6iqbLjrlxgoEG8LVGSMCTwL3PuH6E+DTp
         /dDI5EzZse/XZMHTB+E2mHJjANpWwvXakFFJiy2k3RgkEt1foooF4dvpIlE/ojLL8qwe
         +eqVJAEISWTSVSBrvG7/Eqpm4gz4b6oaRrKYwW4FZgtTN/q3n1pZl9o/jSsLevw1xgw5
         nk/KUaHPYDwIPkm5n/F66I1yVqzIVvJ+aiwk+0MXQqPLfKY598v7rdlckVicx5YgIZ7l
         PUJWUyVyrWDYXs9o/eCjqCRWxjenznm39IZjn13VguJxQI1s0602WNJx0SvOMNUVyqMm
         j4+g==
X-Forwarded-Encrypted: i=1; AJvYcCVoj2ML2WUsGpTRq3qt6hh+HJgmJ6JNgIet4IJWxVdoEJbRmzyQpEnikxXWigohMDbJC8uI3cRP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4dkkxT+oKHjwpSCzPM0cW3u5iyIZ2h8rDAyDARXO7WGqfeY5D
	OPRjQ7/ddF2agkOZ4N6g9THyDy6oNvB17j3ZWnozM8ZjRmNxVxUWOjbZIn9rIHGKknA4mJxan98
	8l7CA7WvAFUUgvOtEfqYzcEiNkFPMZN9Ta9D+9/+jaMamw3NEdKqCtKc=
X-Received: by 2002:a05:6000:2ce:b0:37d:4647:154e with SMTP id ffacd0b85a97d-381f1867241mr17448842f8f.9.1731502665560;
        Wed, 13 Nov 2024 04:57:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy2VCUb/YrhOG4sJTtOcm8JAiO69Hn4t+8LeX63EXs9a8zmjJu8QPDcpAHA0nH0c6/qEeDDA==
X-Received: by 2002:a05:6000:2ce:b0:37d:4647:154e with SMTP id ffacd0b85a97d-381f1867241mr17448812f8f.9.1731502665137;
        Wed, 13 Nov 2024 04:57:45 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997391sm18486834f8f.45.2024.11.13.04.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:43 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 2/2] sched/deadline: Correctly account for allocated bandwidth during hotplug
Date: Wed, 13 Nov 2024 12:57:23 +0000
Message-ID: <20241113125724.450249-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125724.450249-1-juri.lelli@redhat.com>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For hotplug operations, DEADLINE needs to check that there is still enough
bandwidth left after removing the CPU that is going offline. We however
fail to do so currently.

Restore the correct behavior by restructuring dl_bw_manage() a bit, so
that overflow conditions (not enough bandwidth left) are properly
checked. Also account for dl_server bandwidth, i.e. discount such
bandwidht in the calculation since NORMAL tasks will be anyway moved
away from the CPU as a result of the hotplug operation.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c | 33 ++++++++++++++++++++++++---------
 kernel/sched/sched.h    |  2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..d1049e784510 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8057,7 +8057,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_check_overflow(cpu);
+		int ret = dl_bw_deactivate(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e53208a50279..609685c5df05 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3467,29 +3467,31 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 }
 
 enum dl_bw_request {
-	dl_bw_req_check_overflow = 0,
+	dl_bw_req_deactivate = 0,
 	dl_bw_req_alloc,
 	dl_bw_req_free
 };
 
 static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags;
+	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
+	u64 fair_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
 
-	if (req == dl_bw_req_free) {
+	cap = dl_bw_capacity(cpu);
+	switch (req) {
+	case dl_bw_req_free:
 		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
-	} else {
-		unsigned long cap = dl_bw_capacity(cpu);
-
+		break;
+	case dl_bw_req_alloc:
 		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
 
-		if (req == dl_bw_req_alloc && !overflow) {
+		if (!overflow) {
 			/*
 			 * We reserve space in the destination
 			 * root_domain, as we can't fail after this point.
@@ -3498,6 +3500,19 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 			 */
 			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
 		}
+		break;
+	case dl_bw_req_deactivate:
+		/*
+		 * cpu is going offline and NORMAL tasks will be moved away
+		 * from it. We can thus discount dl_server bandwidth
+		 * contribution as it won't need to be servicing tasks after
+		 * the cpu is off.
+		 */
+		if (cpu_rq(cpu)->fair_server.dl_server)
+			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+
+		overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+		break;
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -3506,9 +3521,9 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	return overflow ? -EBUSY : 0;
 }
 
-int dl_bw_check_overflow(int cpu)
+int dl_bw_deactivate(int cpu)
 {
-	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+	return dl_bw_manage(dl_bw_req_deactivate, cpu, 0);
 }
 
 int dl_bw_alloc(int cpu, u64 dl_bw)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588a8f00..1fee840f1bab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -362,7 +362,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_bw_check_overflow(int cpu);
+extern int  dl_bw_deactivate(int cpu);
 extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec);
 /*
  * SCHED_DEADLINE supports servers (nested scheduling) with the following
-- 
2.47.0


