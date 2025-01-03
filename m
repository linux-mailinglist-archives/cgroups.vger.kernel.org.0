Return-Path: <cgroups+bounces-6025-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF065A00282
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13E4162EBD
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5321527AC;
	Fri,  3 Jan 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT0ZJzDz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD11154C0F
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869035; cv=none; b=CroagbZePaoGHmzA9C1/oPNIPl49PzYOqFRxIlt7qmUqm9BiiQxA7nGBgKL+6PuJ0xKqRkICX6jeQtzSiBDHoIltX08XkDt+QsrUbD+OxySbuXJayy/b1JBwJ84MX00zzR1wu+zfPOE6wnZc+AKdFa+nCxVafMkzVXjeqggzQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869035; c=relaxed/simple;
	bh=pYhZzq0EYKck+dPxTPlyrzClB1xuRcv5G1sRYpNeRH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwt1HaDrSX7tKq4dtWpSuexKNUGwu2c58jjOsT2FckdR60g3dF8NRcRsmikkJwaDstsm3ki6L7d2xsGwCAfp7edq3W7PArhEWYjWyMqr9a1DZM04ynq3bFHirvirFj0w/3oGKCcLeNyX0pwM9bAsc+eU4seHBoTVptzrwh6Xejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT0ZJzDz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21619108a6bso151366815ad.3
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869032; x=1736473832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04f8f3o/yaDsG08ligEdR1CTtfIwVHAWlueUkfYDoXo=;
        b=RT0ZJzDzgTv8tVZrvHF0IkDbL3WPcUeVp0s4ezrv14dAVf/wQPuYOWLJjPldMRAIxo
         tdmMVcaE1zpk8IPrG7bUvLn4gg8ixN1eGGJIv+v/hrBJDMOW9ef3ol7ev9e4Ub9vTg+U
         XRQz/3SXk5v2gSWptxijncCSBURplufch0k5oETGBiP5BHcb/DxaC6bIspnBCymgRBVt
         NkA1o+NblIQLotD+r97wPaJLj5Yaru71+YYJHJITGSyipUc6WpozInAnPfV+y8Lz/Vi4
         9W1Ob6FNHs8sNu+zgS9pVRAIJgcN3Q7GqZ/fHrA794XakPfS5F23mlVSL9tiwFwEGCpk
         JRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869032; x=1736473832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04f8f3o/yaDsG08ligEdR1CTtfIwVHAWlueUkfYDoXo=;
        b=bOPQDWRGZ7OSRxeezN+U2fCWds33nWvTvlyxC4XRwvNeovpkdW38H5xgm2oIYrQ7b7
         JSg3ir7cHqLmafj5SODQQmkDyywpQ30IxqkfbW/Apjw8nSEvFOgN3RFi3xDypPE25s4t
         WeHSEgHpyfqPE6bjIEKefg1LfI4vYP8Ic/F1ie76woyevVKPyp5Pi7msapw3hznSOOj1
         wE8rAeWY7yqTX8D7hyo71aVIvRTBniOF5CydbHKJQpbYrbihq289tANKEt/8OolegvoB
         pGncDcLnRtCai0JjPRoW8fyODQoNfASiHs6AxefffUkqZ4Wv4jWdz+K3pDswnvUffMda
         6wKA==
X-Forwarded-Encrypted: i=1; AJvYcCW/zzHI/yL0dJE3Wb6RIZeg201e3eLABruL5UnsJyUrxOJBDXupAcA8up24tOxJ/RiTyPK8zNSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnlBalIfd6ClZy9GXb4OeHTrZpMM7sfpeSTMLyPDFpQkJvNeP
	SVgc9MQPNk7R7Z/nzayraqyuNRWM0rwnnuP7h9EPDoYES6F+6wl0
X-Gm-Gg: ASbGncsbRHh+OY2J6D0eg2GJGX69mGZwDrsNFuXoVSFfs+m4IEh2WSFKuzfOKCax4Hj
	EvEv9QypShaXorh2CujW6wx5Ges8VUJq4JJjXZ7MhZbB1dbf1/6ivI9S3IPn8GYOc9XF+CiFK09
	6BPTOvxTZGCldP12CfSo3mV4N9hhZ9OCfAGlJWHSfjEFiarxaQ5qraSN5QIqJKDN1Uwe9bcxqTR
	v5RiY0GutIWrzXEQiYFRrviU75ZtH3pOcRCTXXk2bMdpZcOFUUemuHUBz+1QfZm8LfyoQ+ay4mT
	rsTQv88gfEgvNR8wHg==
X-Google-Smtp-Source: AGHT+IGDhdL6/CNaSo3pGtV64+fqNxC6hz2SLueRvx2WGBRXmMrSjYEpM/Emx32nG9JYyUBV8OcXLA==
X-Received: by 2002:a17:903:234f:b0:216:4b6f:ddda with SMTP id d9443c01a7336-219e6f0e6c3mr678754295ad.35.1735869032286;
        Thu, 02 Jan 2025 17:50:32 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:31 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 1/9 v2] cgroup: change cgroup to css in rstat updated and flush api
Date: Thu,  2 Jan 2025 17:50:12 -0800
Message-ID: <20250103015020.78547-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change rstat flush and updated API calls to accept a cgroup_subsys_state
instead of a cgroup.

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


