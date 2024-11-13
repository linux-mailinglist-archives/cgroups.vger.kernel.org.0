Return-Path: <cgroups+bounces-5528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E59C6FEB
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 13:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DE81F2310F
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE432010FB;
	Wed, 13 Nov 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fG5gbnmH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A0200C8B
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502668; cv=none; b=hnu/BWOIAC1TE43c3SERX/uJJsc6ya9JEIxutfZ3ZLAB3w44lnhhdeb6j9ICHb7ARepfqSWxqek35HFsXljQx+3sUBznhDUK/0zS8HGwtMFf/1keZK3oYK9R3ToWXqPFvd/AR0KLO2TCMh70Yb/kw2cnf7sllhTco8nSmIWrhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502668; c=relaxed/simple;
	bh=9nV2wbY1mZo4SXjTdUYtTCKYi2JHtTS+27/gUn4nJy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJjCDEfdZ3PbP20YAJyOx6tIPbhznXhe3/3zA7PlYXGdEa/K7UX78ghFLLLpQCZT5d0JhwgLLviOZ7ILs3jpnVlEaZu5g8gGY+IPuQyeyKJFNEwNZb4j9hQUa7VR/d+wIqp3gPlmTkJG2CUeAQ/7xTmcopjm85BXYuC/6EeAjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fG5gbnmH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnZeUkvuRlw5kkscfU39eHV0gLyojkwTRfIApRGBUQ=;
	b=fG5gbnmHJHOo6gUaMD44d/esXf0o2/cQU4IZmIMFKrOds2i+3xAI0Bq8s3IIPUI7+txLG8
	VKV9+UYy7teJdj1TNGAPolficrejAJ+OqaagB9lbCNyaBeWWSTZpuM1+h71oxhzMAh/o89
	3pTXUNGLb26hAh2WT/qGKzmVNxiHK8I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-JX9O5dyXMkCY1yKf-UGVzQ-1; Wed, 13 Nov 2024 07:57:44 -0500
X-MC-Unique: JX9O5dyXMkCY1yKf-UGVzQ-1
X-Mimecast-MFC-AGG-ID: JX9O5dyXMkCY1yKf-UGVzQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so3944289f8f.3
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 04:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502663; x=1732107463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYnZeUkvuRlw5kkscfU39eHV0gLyojkwTRfIApRGBUQ=;
        b=ZQ9Ru69pLHN7kxppq75/SQ/VfjfdeBUo+p1piw1pSRCkyeDDxDfTQ0DUKpXxnBNZP6
         gq+Pqow3tp+3BPS98tnsADnrMuOf/Rl4ibalwrtwSJlhRdSes3PZNXuKFZSEinPIi7H8
         X/iaQD9lxsdPUiowDV3Hp/nLQqlgcScjJEI1nPIbDSKn269VJ3AJEPTUTdtOVAwh8Fdh
         JQ8jXNSsd7Qy1e2/yD1a63OODb++CxSCgumuHRFQRn+Ak2+ri5+5PZonJm2T2Ko1lJyJ
         CJxMlcyE0HAnAkfH/xvCF+KPDsC18neMeZiGR+xVW1qM1/xQ9NOxA/5k99AtCv0Q2dXw
         wk3w==
X-Forwarded-Encrypted: i=1; AJvYcCUDrLbJHr84SELFmpmwDAU/KdSk+T9r7ZAvnsFk78zeUI2TALYHvpVWtYV8Hqm2XgidW3VLEWg6@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoZnZmBgyDZS1ZGe/isOX3WqoY22fVfIuLBFItsHSfVwBhmQO
	ga0sAOlJnjZFCMVYYl4DBiKHLEbSXcKPGCB6H5Mudze1pMDoz0hwgCn6Ak4Nj24bHKYxT1pKWYm
	NAwYC4yV0wjeJgJNktMFIzTBTCfNVcSOMW+o0PCciUr5aAd2eW9CP3eY=
X-Received: by 2002:a05:6000:1887:b0:37d:9476:45f6 with SMTP id ffacd0b85a97d-3820df5bd22mr2507910f8f.7.1731502663455;
        Wed, 13 Nov 2024 04:57:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHrumD/OT1idbJaqmC3Z6XovpgeNb263RD6kDIiP4jRdzbHk85f8YsC09RkcCYCsxeE36n+w==
X-Received: by 2002:a05:6000:1887:b0:37d:9476:45f6 with SMTP id ffacd0b85a97d-3820df5bd22mr2507882f8f.7.1731502663056;
        Wed, 13 Nov 2024 04:57:43 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997391sm18486834f8f.45.2024.11.13.04.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:41 -0800 (PST)
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
Subject: [PATCH 1/2] sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes
Date: Wed, 13 Nov 2024 12:57:22 +0000
Message-ID: <20241113125724.450249-2-juri.lelli@redhat.com>
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

When root domain non-destructive changes (e.g., only modifying one of
the existing root domains while the rest is not touched) happen we still
need to clear DEADLINE bandwidth accounting so that it's then properly
restore taking into account DEADLINE tasks associated to each cpuset
(associated to each root domain). After the introduction of dl_servers,
we fail to restore such servers contribution after non-destructive
changes (as they are only considered on destructive changes when
runqueues are attached to the new domains).

Fix this by making sure we iterate over the dl_server attached to
domains that have not been destroyed and add them bandwidth contribution
back correctly.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/deadline.h |  2 +-
 kernel/cgroup/cpuset.c         |  2 +-
 kernel/sched/deadline.c        | 18 +++++++++++++-----
 kernel/sched/topology.c        | 10 ++++++----
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 3a912ab42bb5..82c966a55856 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -33,7 +33,7 @@ static inline bool dl_time_before(u64 a, u64 b)
 
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
-extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_clear_root_domain(struct root_domain *rd, bool restore);
 
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 142303abb055..4d3603a99db3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -954,7 +954,7 @@ static void dl_rebuild_rd_accounting(void)
 	 * Clear default root domain DL accounting, it will be computed again
 	 * if a task belongs to it.
 	 */
-	dl_clear_root_domain(&def_root_domain);
+	dl_clear_root_domain(&def_root_domain, false);
 
 	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ce93d0bf452..e53208a50279 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2968,13 +2968,21 @@ void dl_add_task_root_domain(struct task_struct *p)
 	task_rq_unlock(rq, p, &rf);
 }
 
-void dl_clear_root_domain(struct root_domain *rd)
+void dl_clear_root_domain(struct root_domain *rd, bool restore)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
+	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
 	rd->dl_bw.total_bw = 0;
-	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
+
+	if (restore) {
+		int i;
+
+		for_each_cpu(i, rd->span) {
+			struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
+
+			if (dl_server(dl_se))
+				rd->dl_bw.total_bw += dl_se->dl_bw;
+		}
+	}
 }
 
 #endif /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..e9e7a7c43dd6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2721,12 +2721,14 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
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
-				dl_clear_root_domain(rd);
+				dl_clear_root_domain(rd, true);
 				goto match1;
 			}
 		}
-- 
2.47.0


