Return-Path: <cgroups+bounces-6582-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4318A39131
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CFD3A64D0
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA58186295;
	Tue, 18 Feb 2025 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJWpQv6D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DFD1581E5
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848517; cv=none; b=QfPEVSDX7fan4l75L8euBPfjo4b003ZeAuCFBBR8BvoVoc9u274W5eJmCnG5PzgDcn5Hngp/P2K3dBCALj654OIYb1trjZkVJ9NLi7qMlnsiDtgqNcsSIUHAKJE2/GY21CodekbRjq5NvEV4e6XxyhdcL2CCLpuCi6DgMTAPI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848517; c=relaxed/simple;
	bh=m6LjBP8WZ5SOwOF1pjvW9x7ycE/LrvbikoRWRhttwA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC6ywAniGMyeYWDkXqmiGLuAngpAHO4cpMSWZdD08fzDF0jhEhXOqx+MHJ0CE1+H/1EZTGkn4X0u8tPdcjq8J8snFd6e5WEntyZol1B+6nzJO0CU+c1dqShB6IEErMap17YCm07EvfswfLe8f+x6RmfPO7IPvKVFRYAFtAp5piE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJWpQv6D; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220f4dd756eso60921165ad.3
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848514; x=1740453314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXMdWzZanXBYybZlSePKoVtUVs1ExwxhVBifYgxpSeU=;
        b=RJWpQv6D5SS2lir3jhB4KkqT++S/rYesZvP09IsxNV4ujQzrrbeJNFpr3jHNrZqpPZ
         HUpViRT/AgQzHLXmBAIlhXPEl9gLttpB83BH3HnFcN2regwvsccj5IPP3D1yIqkHTSH8
         SYpM/yqCTsaaq6qKZ5uYLKQc7qwh9AlC/12e4X7G1U1kryqfHMLztjTtmxrV0wKd2nrL
         bz3PNL5do5DFLiCvJm6ySchKa3PFvLDtyZIoI3s9WotNlN8+WtWAxZ/9/hBpLWSjNS4i
         wNtZCoZ5F4Ld/zYqynsK0ykOGyo6rmULtFKPxMrPwtZ6sPOnub+gGsbEqrb/TcAjSYik
         hoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848514; x=1740453314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXMdWzZanXBYybZlSePKoVtUVs1ExwxhVBifYgxpSeU=;
        b=s5NMDiE/GTatPfnSu5mqLPG4thxV3+a2DD4aQ+aWkLDgbG9t57e9qcRqlgH3219tmg
         QGe6z/4luUIGOS5HeLBAMvgbee2ltZb0AYTczOjaHEu1nLVOe+6wDQsMy7cX5OVImCVh
         qyQ9UXUUa1wuSv32A/8lcqszZw8ePLCWZCInumhW50xvN89RiJc3DH9hKh2Y06sNvVJr
         tUVs0YkDPhpllyB/1LXZAhsxpb61fIh1S0RMJGVx7mFnuZZvq8dPF0s9K+SHrpGnKYZ/
         BvatmMmH9F3AfBQY2XA+xbppLDCLSgHoLhSN5inAWD0BzW53YpIqqpjJzlXsXlv2HnDS
         i7+g==
X-Forwarded-Encrypted: i=1; AJvYcCWRq3PX+v1yNFMXMKbbNCvi0kz47TDxhlOK/HXX68WkiJCfqe7qR4hkEK99NYoNRE05WHgVbYvS@vger.kernel.org
X-Gm-Message-State: AOJu0YxfoyYznjdYaTero5AOWsLXMgBidhlrV1szX+h0nIWKVsZ+kvV9
	c/oQXdKxF3mR9QwUIDoDqPTUQom7LisZQ1GvmZa5n0VbEVXrzp26
X-Gm-Gg: ASbGncuVzYYy5X0pq/E87A8i38JpFlYjPobFNqLv0WXINlDJZj3k7JtU2AyNSB+HVL+
	Y4cd5bVeA7fCmTfqa4HP+iZPjww6pP4QQNzdw/vnlCjRPbrWmJO5NzPCd2xZDA/SS6bJWT8Lb9m
	DESzjlQDacU4j0Yuk/+16sqetN4l3oVOhCyBXBq4UqFASSyGaOkoJ2zVXN86nw4wqQ3buU8cM1U
	mLWN62lhk6h0i9YCZM1zwnoQcCxpdFReU67Of2mxS/TDQDAv/9UPpUUNmZ9IBvjq54GMft4yLKY
	wxZ93mKLhik8qp9Uw8coFwOklT1FSDIxR7deJWAXc89OvRcol+Jr
X-Google-Smtp-Source: AGHT+IFwOfJPEGgpHYiuDd9xb8LF4nSMRJ63khUyuJwnxeuzlQfZkRMasq2TDIXK5ON9SxXG0Sczxw==
X-Received: by 2002:a05:6a00:22cc:b0:730:9467:b4af with SMTP id d2e1a72fcca58-732619005bfmr17987615b3a.23.1739848513618;
        Mon, 17 Feb 2025 19:15:13 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:13 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 08/11] cgroup: rstat cpu lock indirection
Date: Mon, 17 Feb 2025 19:14:45 -0800
Message-ID: <20250218031448.46951-9-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Where functions access the global per-cpu lock, change their signature
to accept the lock instead as a paremeter. Change the code within these
functions to only access the parameter. This indirection allows for
future code to accept different locks, increasing extensibity. For
example, a new lock could be added specifically for the bpf cgroups and
it would not contend with the existing lock.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 74 +++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 4cb0f3ffc1db..9f6da3ea3c8c 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -177,7 +177,7 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *lock, int cpu,
 }
 
 static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
-		struct cgroup_rstat_ops *ops)
+		struct cgroup_rstat_ops *ops, raw_spinlock_t *cpu_lock)
 {
 	struct cgroup *cgrp;
 	unsigned long flags;
@@ -194,7 +194,7 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
 		return;
 
 	cgrp = ops->cgroup_fn(rstat);
-	flags = _cgroup_rstat_cpu_lock(&cgroup_rstat_cpu_lock, cpu, cgrp, true);
+	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
 	/* put @rstat and all ancestors on the corresponding updated lists */
 	while (true) {
@@ -222,7 +222,7 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
 		rstat = parent;
 	}
 
-	_cgroup_rstat_cpu_unlock(&cgroup_rstat_cpu_lock, cpu, cgrp, flags, true);
+	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
 }
 
 /**
@@ -236,13 +236,15 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
  */
 void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	__cgroup_rstat_updated(&css->rstat, cpu, &rstat_css_ops);
+	__cgroup_rstat_updated(&css->rstat, cpu, &rstat_css_ops,
+			&cgroup_rstat_cpu_lock);
 }
 
 #ifdef CONFIG_CGROUP_BPF
 __bpf_kfunc void bpf_cgroup_rstat_updated(struct cgroup *cgroup, int cpu)
 {
-	__cgroup_rstat_updated(&(cgroup->bpf.rstat), cpu, &rstat_bpf_ops);
+	__cgroup_rstat_updated(&(cgroup->bpf.rstat), cpu, &rstat_bpf_ops,
+			&cgroup_rstat_cpu_lock);
 }
 #endif /* CONFIG_CGROUP_BPF */
 
@@ -319,7 +321,8 @@ static struct cgroup_rstat *cgroup_rstat_push_children(
  * here is the cgroup root whose updated_next can be self terminated.
  */
 static struct cgroup_rstat *cgroup_rstat_updated_list(
-		struct cgroup_rstat *root, int cpu, struct cgroup_rstat_ops *ops)
+		struct cgroup_rstat *root, int cpu, struct cgroup_rstat_ops *ops,
+		raw_spinlock_t *cpu_lock)
 {
 	struct cgroup_rstat_cpu *rstatc = rstat_cpu(root, cpu);
 	struct cgroup_rstat *head = NULL, *parent, *child;
@@ -327,7 +330,7 @@ static struct cgroup_rstat *cgroup_rstat_updated_list(
 	unsigned long flags;
 
 	cgrp = ops->cgroup_fn(root);
-	flags = _cgroup_rstat_cpu_lock(&cgroup_rstat_cpu_lock, cpu, cgrp, false);
+	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -364,7 +367,7 @@ static struct cgroup_rstat *cgroup_rstat_updated_list(
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu, ops);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(&cgroup_rstat_cpu_lock, cpu, cgrp, flags, false);
+	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
 	return head;
 }
 
@@ -422,43 +425,46 @@ static inline void __cgroup_rstat_unlock(spinlock_t *lock,
 
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat,
-		struct cgroup_rstat_ops *ops)
-	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
+		struct cgroup_rstat_ops *ops, spinlock_t *lock,
+		raw_spinlock_t *cpu_lock)
+	__releases(lock) __acquires(lock)
 {
 	int cpu;
 
-	lockdep_assert_held(&cgroup_rstat_lock);
+	lockdep_assert_held(lock);
 
 	for_each_possible_cpu(cpu) {
 		struct cgroup_rstat *pos = cgroup_rstat_updated_list(
-				rstat, cpu, ops);
+				rstat, cpu, ops, cpu_lock);
 
 		for (; pos; pos = pos->rstat_flush_next)
 			ops->flush_fn(pos, cpu);
 
 		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
+		if (need_resched() || spin_needbreak(lock)) {
 			struct cgroup *cgrp;
 
 			cgrp = ops->cgroup_fn(rstat);
-			__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, cpu);
+			__cgroup_rstat_unlock(lock, cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, cpu);
+			__cgroup_rstat_lock(lock, cgrp, cpu);
 		}
 	}
 }
 
 static void __cgroup_rstat_flush(struct cgroup_rstat *rstat,
-		struct cgroup_rstat_ops *ops)
+		struct cgroup_rstat_ops *ops, spinlock_t *lock,
+		raw_spinlock_t *cpu_lock)
+	__acquires(lock) __releases(lock)
 {
 	struct cgroup *cgrp;
 
 	might_sleep();
 	cgrp = ops->cgroup_fn(rstat);
-	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
-	cgroup_rstat_flush_locked(rstat, ops);
-	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
+	__cgroup_rstat_lock(lock, cgrp, -1);
+	cgroup_rstat_flush_locked(rstat, ops, lock, cpu_lock);
+	__cgroup_rstat_unlock(lock, cgrp, -1);
 }
 
 /**
@@ -476,26 +482,29 @@ static void __cgroup_rstat_flush(struct cgroup_rstat *rstat,
  */
 void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush(&css->rstat, &rstat_css_ops);
+	__cgroup_rstat_flush(&css->rstat, &rstat_css_ops,
+			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
 }
 
 #ifdef CONFIG_CGROUP_BPF
 __bpf_kfunc void bpf_cgroup_rstat_flush(struct cgroup *cgroup)
 {
-	__cgroup_rstat_flush(&(cgroup->bpf.rstat), &rstat_bpf_ops);
+	__cgroup_rstat_flush(&(cgroup->bpf.rstat), &rstat_bpf_ops,
+			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
 }
 #endif /* CONFIG_CGROUP_BPF */
 
 static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat,
-		struct cgroup_rstat_ops *ops)
-	__acquires(&cgroup_rstat_lock)
+		struct cgroup_rstat_ops *ops, spinlock_t *lock,
+		raw_spinlock_t *cpu_lock)
+	__acquires(lock)
 {
 	struct cgroup *cgrp;
 
 	might_sleep();
 	cgrp = ops->cgroup_fn(rstat);
-	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
-	cgroup_rstat_flush_locked(rstat, ops);
+	__cgroup_rstat_lock(lock, cgrp, -1);
+	cgroup_rstat_flush_locked(rstat, ops, lock, cpu_lock);
 }
 
 /**
@@ -509,7 +518,8 @@ static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat,
  */
 void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush_hold(&css->rstat, &rstat_css_ops);
+	__cgroup_rstat_flush_hold(&css->rstat, &rstat_css_ops,
+			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
 }
 
 /**
@@ -517,13 +527,13 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
  * @rstat: rstat node used to find associated cgroup used by tracepoint
  */
 static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat,
-		struct cgroup_rstat_ops *ops)
-	__releases(&cgroup_rstat_lock)
+		struct cgroup_rstat_ops *ops, spinlock_t *lock)
+	__releases(lock)
 {
 	struct cgroup *cgrp;
 
 	cgrp = ops->cgroup_fn(rstat);
-	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
+	__cgroup_rstat_unlock(lock, cgrp, -1);
 }
 
 /**
@@ -532,7 +542,8 @@ static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat,
  */
 void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush_release(&css->rstat, &rstat_css_ops);
+	__cgroup_rstat_flush_release(&css->rstat, &rstat_css_ops,
+			&cgroup_rstat_lock);
 }
 
 static void __cgroup_rstat_init(struct cgroup_rstat *rstat)
@@ -605,7 +616,8 @@ int bpf_cgroup_rstat_init(struct cgroup_bpf *bpf)
 
 void bpf_cgroup_rstat_exit(struct cgroup_bpf *bpf)
 {
-	__cgroup_rstat_flush(&bpf->rstat, &rstat_bpf_ops);
+	__cgroup_rstat_flush(&bpf->rstat, &rstat_bpf_ops,
+			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
 	__cgroup_rstat_exit(&bpf->rstat);
 }
 #endif /* CONFIG_CGROUP_BPF */
-- 
2.48.1


