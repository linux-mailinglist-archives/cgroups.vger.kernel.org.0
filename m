Return-Path: <cgroups+bounces-6585-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B4A39134
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE196188E11C
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564315E5C2;
	Tue, 18 Feb 2025 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1nC3iBj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CA14AD02
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848521; cv=none; b=n4YMD8+z+6Ee4Vl3KIshhZnhVwse+tOOpm6nz9ofMMGl34crPztWvp1/NYUk147Vvm3tJT0h7OTNcM0p2I34phXyB+ogWsceqGxiU1DBepg472ZdPDwsZVZGbIAUWF+CzPXr8S17MfdI0nse+niTJoK/F+hKYeAExYIGn9SYBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848521; c=relaxed/simple;
	bh=D/CZ9Un6uJ+Dlfb0vDnXP2QKDPQWVG1mEM3CgJfW8P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfkkzC4RdDtVsAus9+PrrGzToAGMIllKkpENjT69u/dKN34tUTmI+QWfzRfH0/49rRTYGQ63ksc2GBIFG2kiog2ZqsJCn7PGjdxqjv3ru2hA8EPlJUkNDavJew+FxC3SQYGT1NNrnXDWC8qf7+KTB9lbK0vDkUEwon0nd1KqDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1nC3iBj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso89556105ad.2
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848519; x=1740453319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAAYrMp38Dbf1h36ApVAoOaASM18TrELMrU+bZs87zk=;
        b=l1nC3iBjlks31LJ/LiZOuSlVls92zEmgAtWSJqDCH0M9jaf4sR2zJoDjP94dNdg96K
         lxdFSRlCVJu0TVWU3kGu9w7LbB3Z4x8+btGsMrL6ffXFLTHkM3AVwpRDU2Tz4rMHwTFG
         NKknGEFwY3r9ebx3TeuRRt4sOQ52azs1w4vL3S5oJcKPhw65LZB6hHQM3E6MImb0o/L9
         ycPZKhuE864QTEuYohRfORBwaeHU0bSEVvw2SWrcPW0AaE6molpG8irKJuU9KhJ2xF8V
         p8Djr/aCLgVnIK1uA+3R5h7T8aPJZFxCwy2ktlZMgmRmKKOfizHRa/xcBt7Eb43sTsHl
         p4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848519; x=1740453319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAAYrMp38Dbf1h36ApVAoOaASM18TrELMrU+bZs87zk=;
        b=EteWRgid0CPwtKyLd9xVecDVyTBluuFGCDXd44olOsMk6JwL4ZkqlA1vZt9KU4Pg+v
         yYvKqWa7t0FbK1FZbnqB7XVIqmzvVoxJU7H8shg2ddXd4ss/VfPh0/htPOHHm83LGpob
         s+76CyYpCanTzihLu29tJ6w6hVQBObGXBf7NnApbbbUz9Eeyv//oRI4SoNo+TB2dMYtf
         AJtPn7UpUPo1FmgBv2oYVIxy1jE/XSNjcKRUBo2h+qoSt34Ei8aZ0ge8hIS4bvO0rQav
         /z1WVZRa+fEg31dWgaOixF1DSBGIlhFGZ9WghmRrJjTlstEwgoltTj/cpA/7fzmAfZ6m
         DFvw==
X-Forwarded-Encrypted: i=1; AJvYcCUgnj3x2YgGBGEt6jH8hPxw4MBsj38DFhXfa9Ce6dqcqNLp8NsMWeOM7jYbPXk0jnGWt7PVe3T/@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCt1nL4EVMWOCSdhHuYnxImkGvP2kgd+NnJrfQ1Vj4We5OHzL
	vpiCBo1Pn5zzPmeoqvQuRmmqTW7uHaA/PfPznO203VK02dB00oZ0
X-Gm-Gg: ASbGncv/rpjlLrPwnH+RrrzhgMywXjooqzbWsNEZPXsrNV86ApXraWbw1e8HExggT+X
	BEko/vWDdhY09TrFiAuC1S8Ezl53eabVWifL7kfldbQs9VWa5ucYVZxN6XpnLI7uUVz6Wmv+aoW
	/f9maun6QJTO7hYzs6+4KBX0JgJMK/HGmxWwBxrtsjkBZtGYHpcvocUPTNjYrjttNOB7Ii+yi02
	32hz6nf0o+HmS+awOGzqqSVxZvtpYvIT+Iwky8NMjGhBp/9GH2SXhM5FqErAcQaQ34HgZePu6+h
	7eE/864PdTrF2R9QKP+0vJJApw1+vZ+lXjfXg+McoKfMEnp/Yz79
X-Google-Smtp-Source: AGHT+IF+gu3zHN9lsAlpDAPTExtIPOeyPRNrR7IkVwslhKU3Ky0hB0noFRxqnw8wTCYxNUTtfjP8iQ==
X-Received: by 2002:a05:6a21:6da7:b0:1ee:5d05:a18f with SMTP id adf61e73a8af0-1ee8cc25a7cmr22443182637.35.1739848519160;
        Mon, 17 Feb 2025 19:15:19 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:18 -0800 (PST)
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
Subject: [PATCH 11/11] cgroup: separate rstat list pointers from base stats
Date: Mon, 17 Feb 2025 19:14:48 -0800
Message-ID: <20250218031448.46951-12-inwardvessel@gmail.com>
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

A majority of the cgroup_rstat_cpu struct size is made up of the base stat
entities. Since only the "self" subsystem state makes use of these, move
them into a struct of their own. This allows for a new compact
cgroup_rstat_cpu struct that the formal subsystems can make use of.
Where applicable, decide on whether to allocate the compact or the full
struct including the base stats.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup_rstat.h |  8 +++++-
 kernel/cgroup/rstat.c        | 55 +++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup_rstat.h b/include/linux/cgroup_rstat.h
index 780b826ea364..fc26c0aa91ef 100644
--- a/include/linux/cgroup_rstat.h
+++ b/include/linux/cgroup_rstat.h
@@ -27,7 +27,10 @@ struct cgroup_rstat_cpu;
  * resource statistics on top of it - bsync, bstat and last_bstat.
  */
 struct cgroup_rstat {
-	struct cgroup_rstat_cpu __percpu *rstat_cpu;
+	union {
+		struct cgroup_rstat_cpu __percpu *rstat_cpu;
+		struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
+	};
 
 	/*
 	 * Add padding to separate the read mostly rstat_cpu and
@@ -60,7 +63,10 @@ struct cgroup_rstat_cpu {
 	 */
 	struct cgroup_rstat *updated_children;	/* terminated by self */
 	struct cgroup_rstat *updated_next;		/* NULL if not on the list */
+};
 
+struct cgroup_rstat_base_cpu {
+	struct cgroup_rstat_cpu self;
 	/*
 	 * ->bsync protects ->bstat.  These are the only fields which get
 	 * updated in the hot path.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 93b97bddec9c..6b14241d0924 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -33,6 +33,12 @@ static struct cgroup_rstat_cpu *rstat_cpu(struct cgroup_rstat *rstat, int cpu)
 	return per_cpu_ptr(rstat->rstat_cpu, cpu);
 }
 
+static struct cgroup_rstat_base_cpu *rstat_base_cpu(
+		struct cgroup_rstat *rstat, int cpu)
+{
+	return per_cpu_ptr(rstat->rstat_base_cpu, cpu);
+}
+
 static inline bool is_base_css(struct cgroup_subsys_state *css)
 {
 	/* css for base stats has no subsystem */
@@ -597,6 +603,18 @@ static void __cgroup_rstat_init(struct cgroup_rstat *rstat)
 		struct cgroup_rstat_cpu *rstatc = rstat_cpu(rstat, cpu);
 
 		rstatc->updated_children = rstat;
+	}
+}
+
+static void __cgroup_rstat_base_init(struct cgroup_rstat *rstat)
+{
+	int cpu;
+
+	/* ->updated_children list is self terminated */
+	for_each_possible_cpu(cpu) {
+		struct cgroup_rstat_base_cpu *rstatc = rstat_base_cpu(rstat, cpu);
+
+		rstatc->self.updated_children = rstat;
 		u64_stats_init(&rstatc->bsync);
 	}
 }
@@ -607,13 +625,21 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
 
 	/* the root cgrp has rstat_cpu preallocated */
 	if (!rstat->rstat_cpu) {
-		rstat->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!rstat->rstat_cpu)
-			return -ENOMEM;
+		if (is_base_css(css)) {
+			rstat->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+			if (!rstat->rstat_base_cpu)
+				return -ENOMEM;
+
+			__cgroup_rstat_base_init(rstat);
+		} else {
+			rstat->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+			if (!rstat->rstat_cpu)
+				return -ENOMEM;
+
+			__cgroup_rstat_init(rstat);
+		}
 	}
 
-	__cgroup_rstat_init(rstat);
-
 	return 0;
 }
 
@@ -718,9 +744,10 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = rstat_cpu(&(cgrp->self.rstat), cpu);
+	struct cgroup_rstat_base_cpu *rstatc = rstat_base_cpu(
+			&(cgrp->self.rstat), cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
-	struct cgroup_rstat_cpu *prstatc;
+	struct cgroup_rstat_base_cpu *prstatc;
 	struct cgroup_base_stat delta;
 	unsigned seq;
 
@@ -748,25 +775,25 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
 		delta = rstatc->subtree_bstat;
-		prstatc = rstat_cpu(&(parent->self.rstat), cpu);
+		prstatc = rstat_base_cpu(&(parent->self.rstat), cpu);
 		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
 		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
 		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
 	}
 }
 
-static struct cgroup_rstat_cpu *
+static struct cgroup_rstat_base_cpu *
 cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatc;
 
-	rstatc = get_cpu_ptr(cgrp->self.rstat.rstat_cpu);
+	rstatc = get_cpu_ptr(cgrp->self.rstat.rstat_base_cpu);
 	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
 
 static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct cgroup_rstat_cpu *rstatc,
+						 struct cgroup_rstat_base_cpu *rstatc,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
@@ -776,7 +803,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatc;
 	unsigned long flags;
 
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
@@ -787,7 +814,7 @@ void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 void __cgroup_account_cputime_field(struct cgroup *cgrp,
 				    enum cpu_usage_stat index, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatc;
 	unsigned long flags;
 
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
-- 
2.48.1


