Return-Path: <cgroups+bounces-5995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9AF9FB828
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE791164EC6
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AFBE46;
	Tue, 24 Dec 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ77T6ZQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D864689
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002857; cv=none; b=VdUYIg0PmiiSXRqZFNgoDIQKFw6+bkodJjPpCsPBhgzg29+32H1X8GiYI1oNlnEvb0M8Au/Rfw2hTrWeFPwQX83RoJQThMMxn/pPnH5SlHoY5Sa/CpWQb3x+Fmrg1q1k+Si6vzflsPhLzcErYPHPTkY5261VhvGpPU5hLubHH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002857; c=relaxed/simple;
	bh=w6KoYDkxU3feFbP2WTg9tP9sS2rU8Z5rVEfI+2VQvlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuX2jr3Fq66D/CmAAwEjmQxrrk/eWwEihhPoze+wo5It6+ARZmOkVKum2avDjEfglICsE1RLihf8z4ZdVzT2WydvGyZBsnlsfQh8OJc5lErNAkhnKRHpFzZG98tLy4O6I0BAynegxhIXq/PnOuIA86lpLvy43OC57u9ibUO+MN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ77T6ZQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21669fd5c7cso45794855ad.3
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002855; x=1735607655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYtPz7aK9YIb0L/ZbBa0RixlCtZNyuJIN6JSdj1lrsk=;
        b=TZ77T6ZQpG2rvumItrNGyFzklpIJmEApps52Gt3BgmHWPH+K6FHQ4QRpMe2e+FuLrK
         EgExl2qa5Ol7Be4Mm6V+XxS3JozuSo4ICWXFH2J8KOeJoo4AkgHm8QII0T+Au9nsppr0
         fqoUXH46k5nCHbUZZjqbkzPGzs2yEnKY8KW7wzvmV15Wkp0BxCDaleSMhOJg2KXYY9/W
         qYSU5KScprGaIC3WSsiGViNpHaJ5zuPtWErB7tNE2FT+udwKRcBP4+c5DPUDe6jjDsyI
         4QOpX0opajX4DpWoscaAmHxnmLlzCt74AQ8QQtfun3ZUEWOmqtaOxXLvINTuriTmMeip
         Uq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002855; x=1735607655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYtPz7aK9YIb0L/ZbBa0RixlCtZNyuJIN6JSdj1lrsk=;
        b=Ik4hdkPPf4RGPALNyEq7GaywRv1kGQJi6QGFADZcMP4cqrxSdhwoAsmUknzHPkJ/Hk
         /z23zlUgSTLnBb6sjvDoKHExIM8I+wSJ8u/JxkQjW7J6PV/8xR83bnTbz+vw7Biqelsv
         bnFEJ95akEYD4jR+s1nVv+SKh5crVVoJomX8m5ORx88/DuXyQayYulvlknN3+RfEY8YP
         uOvgnLLW0Ek0UDu0BddpDaJLr43xPG+6JPJU1EE4XLl17g7XseLk/T3QQ3Pf1Pj/rXMe
         /k5N4NvgYQx169Feonoi/dJ7fQfo6FRTfIHt3wV2ATvwjclotDoBo92A3Q8f/bkD0BUl
         letg==
X-Forwarded-Encrypted: i=1; AJvYcCUJlV0zGYOFz0fH75aqS1dBnODfDhF8EsYE1e/+K5EGuhAanvAncFjz/NuxCvNY23HI5C3F6+uu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/NQPPl/Bxu7249mIJ41ov9hCXPbDm6B+U22tcPytT8PfnINHk
	18s6Oq3fNwNCWqn0FGmrEbM7V0d6wU7rrGkMmsyOGoGZ6MhJOvFu
X-Gm-Gg: ASbGncufzwa1DTTOhOBQR/x3noMSnFYkUX2YO5cwnMmoTQ60pvCxtPLQDBO0cXeZ+aj
	97NJH29vJB8KV5rjltyfL5XahrReMEjjk4Y0lRJGqT+h1d8hn2qZZnNbSpcEvDxccu60dwhmTcv
	Mddv7Ng5gFuFfNChmjrTyFtI32lCPWq8mzRJ+9rT90Ut04biJMX4NsDa/i4jJ5Cy9nXEQvsHJOO
	nK3FRSrXt0UT8IfHvpKCtThECIEHgNuT6LnbR/vvZ+jCf3Nb2b04k7WTcE/O7lXsmTEp19yoGNS
	OBm3Fa5VG+WhCVefEg==
X-Google-Smtp-Source: AGHT+IHxt/8FXT3EeHlti8KBRnrfHz4fCj1K+PzJkO4GExu/s7GdqY6WQo4vKMy3RCnOcrAt/99eqA==
X-Received: by 2002:a17:902:e5c7:b0:216:393b:23e0 with SMTP id d9443c01a7336-219e6f2e9d4mr214204245ad.36.1735002854611;
        Mon, 23 Dec 2024 17:14:14 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:14 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 1/9 RFC] change cgroup to css in rstat updated and flush api
Date: Mon, 23 Dec 2024 17:13:54 -0800
Message-ID: <20241224011402.134009-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change API calls to accept a cgroup_subsys_state instead of a cgroup.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 block/blk-cgroup.c     |  4 ++--
 include/linux/cgroup.h |  8 ++++----
 kernel/cgroup/cgroup.c |  4 ++--
 kernel/cgroup/rstat.c  | 28 +++++++++++++++++++---------
 mm/memcontrol.c        |  4 ++--
 5 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 45a395862fbc..98e586ae21ec 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1200,7 +1200,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		cgroup_rstat_flush(&blkcg->css);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -2183,7 +2183,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
+	cgroup_rstat_updated(&blkcg->css, cpu);
 	put_cpu();
 }
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634..eec970622419 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -687,10 +687,10 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup scalable recursive statistics.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
-void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_hold(struct cgroup *cgrp);
-void cgroup_rstat_flush_release(struct cgroup *cgrp);
+void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu);
+void cgroup_rstat_flush(struct cgroup_subsys_state *css);
+void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css);
+void cgroup_rstat_flush_release(struct cgroup_subsys_state *css);
 
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 43c949824814..fdddd5ec5f3c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5465,7 +5465,7 @@ static void css_release_work_fn(struct work_struct *work)
 
 		/* css release path */
 		if (!list_empty(&css->rstat_css_node)) {
-			cgroup_rstat_flush(cgrp);
+			cgroup_rstat_flush(css);
 			list_del_rcu(&css->rstat_css_node);
 		}
 
@@ -5493,7 +5493,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		cgroup_rstat_flush(cgrp);
+		cgroup_rstat_flush(css);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 5877974ece92..1ed0f3aab0d9 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -82,8 +82,9 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-__bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+__bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
+	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
@@ -346,8 +347,10 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  *
  * This function may block.
  */
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
+__bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	might_sleep();
 
 	__cgroup_rstat_lock(cgrp, -1);
@@ -364,9 +367,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
  *
  * This function may block.
  */
-void cgroup_rstat_flush_hold(struct cgroup *cgrp)
+void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 	__acquires(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	might_sleep();
 	__cgroup_rstat_lock(cgrp, -1);
 	cgroup_rstat_flush_locked(cgrp);
@@ -376,9 +381,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
  * @cgrp: cgroup used by tracepoint
  */
-void cgroup_rstat_flush_release(struct cgroup *cgrp)
+void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 	__releases(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
@@ -408,7 +415,7 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 {
 	int cpu;
 
-	cgroup_rstat_flush(cgrp);
+	cgroup_rstat_flush(&cgrp->self);
 
 	/* sanity check */
 	for_each_possible_cpu(cpu) {
@@ -512,8 +519,10 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 						 struct cgroup_rstat_cpu *rstatc,
 						 unsigned long flags)
 {
+	struct cgroup_subsys_state *css = &cgrp->self;
+
 	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
-	cgroup_rstat_updated(cgrp, smp_processor_id());
+	cgroup_rstat_updated(css, smp_processor_id());
 	put_cpu_ptr(rstatc);
 }
 
@@ -612,16 +621,17 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
 
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
-	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct cgroup_subsys_state *css = seq_css(seq);
+	struct cgroup *cgrp = css->cgroup;
 	u64 usage, utime, stime, ntime;
 
 	if (cgroup_parent(cgrp)) {
-		cgroup_rstat_flush_hold(cgrp);
+		cgroup_rstat_flush_hold(css);
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &utime, &stime);
 		ntime = cgrp->bstat.ntime;
-		cgroup_rstat_flush_release(cgrp);
+		cgroup_rstat_flush_release(css);
 	} else {
 		/* cgrp->bstat of root is not actually used, reuse it */
 		root_cgroup_cputime(&cgrp->bstat);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..97552476b844 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -579,7 +579,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+	cgroup_rstat_updated(&memcg->css, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
 		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
@@ -611,7 +611,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	cgroup_rstat_flush(&memcg->css);
 }
 
 /*
-- 
2.47.1


