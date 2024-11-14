Return-Path: <cgroups+bounces-5556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB84D9C8CDC
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 15:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8211F21423
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DE7E110;
	Thu, 14 Nov 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmMUHUEW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD276C61
	for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594512; cv=none; b=oIp1J09ZO02OQanKr6oKfp4nwaVegSTz0r/CZIOl/89Y6asobz77itHtZKFMYX1qZaJDo2wOcyeO5aByTbXo/WQmkgC2LvMOA1EA0enjljncgMCUbbWC0VEciIAJCBzVeBASmDrFCxibbRAjMv4SsVrejpqehKUQTR3CISUTDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594512; c=relaxed/simple;
	bh=lSow07/Kr5HZ3FFHHBUM39UBwM8/bfL+yg1mPjBwL2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qh/lLs5LtYJzjN3OAdmR/J7DH3gUYUQxeVotVtpkVmSRaGQKZ0MuhiZOMJPpKZPravx9lACzIX4IIfKbfRsIPeCUw60xG232R8cHai+ZtgdbLR3uBIyZ3qjcLhvz8V4rR59gwdsUqdreLX8I8Gn/M9fUzP4tJwJk/H3rCUFzPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmMUHUEW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731594509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYX1M87GENqgHT7DQ1pmqocVV2CQv6P6u65y9xqj4r8=;
	b=bmMUHUEWk+P4DM4oPZdfphQAkwW3q2AeAs59yWPA/d82zNEBUwooPamuItJ5cnStHNVHDt
	N2DFw8bossJA5BqtWtMZdo8Rj33UGmYec6HlKcvWNkmWc4oTTK4QIEapo87K0g5kvs2STd
	zNW4kjBsC7iocLR/i98qearSHeQRaiE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-IWjhn-W1NbyqoVxVdxs5-g-1; Thu, 14 Nov 2024 09:28:28 -0500
X-MC-Unique: IWjhn-W1NbyqoVxVdxs5-g-1
X-Mimecast-MFC-AGG-ID: IWjhn-W1NbyqoVxVdxs5-g
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460b71eb996so8240091cf.3
        for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 06:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594507; x=1732199307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYX1M87GENqgHT7DQ1pmqocVV2CQv6P6u65y9xqj4r8=;
        b=YuxGxmccUEXhEvoUU6DG4vXwjaj4ObT54iy2xGJyu/HOUKumpaF6wQYx3LaMjSi67z
         5DJxtWJe2S2R52/bOW6QgmeHaisBvjfCFP23A1SJ2BVKilrs6CKiSXS4y0z8iAadfe0c
         V+KJAhiDFOLrzhbvxJNl2+W0W61bEz+zE9E5QfSjPmVaAetvrb5Wv1bHmsp6RThgtQL+
         8+E9mwYqV++KXQPSzKB6frwuM3l8mlgDZd6ww1WJ4Eax9AYbR5tDxhTD5Slfr+oNQrdQ
         pKNK0tvphHPskRed1KPs5BwWKZWxXEo6RpxZQlVOsLO8GLemZ7UyU0uS7OnxPz0Fw+U3
         t0yA==
X-Forwarded-Encrypted: i=1; AJvYcCUPao6cSoW5NAVEQ0BbaJ0N6AEcbnJvI72DdqKPurrha05UptRoF93qWYfq3tKlf34WHbZynKjF@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbKpnh7EfzvaulJTBiknbXL98cvASdt6XvBOjChBvi5Ost9sO
	KcUveDe69XUBOjlqMJ905ivb5kq1XJ6IRZrjKXENlTL8Qr1fpwu2xk7jc1jyyVi+KX7+G9pOn4c
	+7PF0NM4QyhyCBP+96ppF81JJMgl3RMWGgMzy6nXWsrjs3JNxNSfCuhc=
X-Received: by 2002:ac8:59c7:0:b0:461:6157:99d0 with SMTP id d75a77b69052e-463093f2082mr329327131cf.41.1731594507517;
        Thu, 14 Nov 2024 06:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWJg+aYSnVi03KcGgXI5uWcHil7Jzy82MCwjxAfH8vdfQY5bVa8bXIa2RN030Agrcf6P1dBg==
X-Received: by 2002:ac8:59c7:0:b0:461:6157:99d0 with SMTP id d75a77b69052e-463093f2082mr329326791cf.41.1731594507041;
        Thu, 14 Nov 2024 06:28:27 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab25bc8sm6068211cf.69.2024.11.14.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 06:28:23 -0800 (PST)
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
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>
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
Subject: [PATCH v2 1/2] sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes
Date: Thu, 14 Nov 2024 14:28:09 +0000
Message-ID: <20241114142810.794657-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114142810.794657-1-juri.lelli@redhat.com>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When root domain non-destructive changes (e.g., only modifying one of
the existing root domains while the rest is not touched) happen we still
need to clear DEADLINE bandwidth accounting so that it's then properly
restored, taking into account DEADLINE tasks associated to each cpuset
(associated to each root domain). After the introduction of dl_servers,
we fail to restore such servers contribution after non-destructive
changes (as they are only considered on destructive changes when
runqueues are attached to the new domains).

Fix this by making sure we iterate over the dl_servers attached to
domains that have not been destroyed and add their bandwidth
contribution back correctly.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---
v1->v2: always restore, considering a root domain span (and check for
        active cpus)
---
 kernel/sched/deadline.c | 17 ++++++++++++++---
 kernel/sched/topology.c |  8 +++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ce93d0bf452..a9cdbf058871 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2970,11 +2970,22 @@ void dl_add_task_root_domain(struct task_struct *p)
 
 void dl_clear_root_domain(struct root_domain *rd)
 {
-	unsigned long flags;
+	int i;
 
-	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
+	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
 	rd->dl_bw.total_bw = 0;
-	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
+
+	/*
+	 * dl_server bandwidth is only restored when CPUs are attached to root
+	 * domains (after domains are created or CPUs moved back to the
+	 * default root doamin).
+	 */
+	for_each_cpu(i, rd->span) {
+		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
+
+		if (dl_server(dl_se) && cpu_active(i))
+			rd->dl_bw.total_bw += dl_se->dl_bw;
+	}
 }
 
 #endif /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..9c405f0e7b26 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2721,9 +2721,11 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
 				/*
 				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.  It
-				 * will be recomputed in function
-				 * update_tasks_root_domain().
+				 * its dl_bw->total_bw needs to be cleared.
+				 * Tasks contribution will be then recomputed
+				 * in function dl_update_tasks_root_domain(),
+				 * dl_servers contribution in function
+				 * dl_restore_server_root_domain().
 				 */
 				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
 				dl_clear_root_domain(rd);
-- 
2.47.0


