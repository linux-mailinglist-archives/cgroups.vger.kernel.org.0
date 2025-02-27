Return-Path: <cgroups+bounces-6733-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22121A48AE7
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 22:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AB73A4BA3
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD98272918;
	Thu, 27 Feb 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1VUozsp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ACC272906
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693364; cv=none; b=HzyThZR5iNkdiV24xyAfGhRYXAWd4L/a9dHFdV4KwFQ7Bs0dbSyKR89RiYF/lrCX8IZa6eip6dXTlvg/giboifz3vSMs79hjaOPLnxVbOJkXxlM1RKBE3lsB5w9mS0n5HSqpbDUdKksfXM4lgsbhNvD1SM9DYnr+4Pr+h2SQPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693364; c=relaxed/simple;
	bh=owzSLblQJ6FOPqe4IAw8TIWzwKSo+/j2ue8jcLITrlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NU62twi9s5P0CjZVbBNOvHQZo1ah39FU/qzip93x8wPZFJwQZCmNakmCq3JqkjFzYGHB3m1ttdckq5AIEFRCkEJnAnJNstDprG77Ou1wtYLe/CpdzT1E97HtjaPbT7IK1tXzJUL4X0GAorhzGLblMFrU+37w7UktgR1DS8iGZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1VUozsp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22185cddbffso45831335ad.1
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 13:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693361; x=1741298161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvG0OX+5jTFPX8q84psW6K+/pHLcZfB+bAlB9DXTHr4=;
        b=l1VUozspdwCXPZBmVn3fVd5Rb3snHfasyhszs1osrdpQYUUfbJ24UiDMMF5epZ3xYq
         mQVimVgpRMUKov2MC/s34EGPDeUF5IYfPDaPNu3FCxlusK/n+ab8k3v/GkKzdCep9UYP
         wCZi9sQ5zKL4wUi5asEU+l/B7BfYa0jPjc2DBwCKPSN9GS3U9lTKBto5MK5M1VnRZHxp
         /P0CYIbkeE/1pUfrrYT2hZjh5PGkARE24KqEszrTa1QSzEwcCO2xwawaciNTxt3P2Kq3
         JO+Bu56N6gcotMonn3I/zEntzdHkaFHb7QUEkPG9COrTIQdgI2hc4FiYTWIBdWIgo8fu
         YAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693361; x=1741298161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvG0OX+5jTFPX8q84psW6K+/pHLcZfB+bAlB9DXTHr4=;
        b=ORElbdRGjtkVa9eePP/cSus45/VGqfSqLHxyuPrzK0CqoeqExsprE1DnSxMNndtByB
         gzo0vylR80yEEKj1I1vnL8+X+OzdtD24rIgeHTtFdeJ6iiEfHPSgxdtDgkRGHwxvP7+/
         vbgGRpqzVcmHVX5mzd0DdAnJedglWfV65qpCfMzFN/s3k9/xSn//6VBhL1Ch9csrvjQ4
         IdhaB7oX7LgvnIsfbd8UFPBfdxOiJAkdTY4CF8QFAAA6Pnh9hVW/HRp2kLg93hE82+dE
         wfV4hQB6Dt/4T1Au0sy/UPJKlAK0wGSsCcArSiELmG5o8sF5Pe2peQA0/VA2rROqcM7O
         ZF0A==
X-Forwarded-Encrypted: i=1; AJvYcCVgECU4x2yygc1h1OjnxcqK6AK8d94AjvaS+fpEKRwixRUH0E4RlNvCSeeTBjJyI4KiYnMMJJFs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlc9tYGSIbuTR95Bvbxi4EubfiD2KlHO2lZXW1yi6C464Uvkfr
	d8GbFf9vLX21/PyD3eLbadmzEZz9gZkEg2/clIv+Ew0sRqtWKNx7
X-Gm-Gg: ASbGncuKtTh81roEiC0+R1alXzsm32j+UILnb+N+aZ6VJLj2ZF0TZ2uihYlR8kJgn/T
	iZR+rEZ4YkjOYol1TkYEkHZ7Y5clM3RXQvKbtO/JN480ZWfJU6UyR4EYKusG9/LS8yGc3i/VCrG
	6DRewVW4UktUq3bKjUWlDmtGAxRPa09NBz6Hf3ifaHrvmlf9NcwTktEXXaJc/AQ+HknVEzLm7KV
	zKKjXZXTuoEK6+px9Bwlt5kFixnR3mkiOa11KbW3T/fUx+wtPIQ69fLFwG1ljb/qMwXeOTdxq5Y
	l6CNP/KJilO9c361HO8WlSo4KUL9mB5MTpvA+Rlvbr0977p6jd6vGA==
X-Google-Smtp-Source: AGHT+IGjcfGKUg2ZVaYBK69vGrD7xJHUiP7Dd4hYZ4nUyRcwKvzSQp8A3/7Xj1SqgiBaouRBh9iJAA==
X-Received: by 2002:a05:6a00:22c5:b0:732:6a48:22f6 with SMTP id d2e1a72fcca58-7349d2f51cbmr7384522b3a.9.1740693361344;
        Thu, 27 Feb 2025 13:56:01 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:4d60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb65sm2301321b3a.149.2025.02.27.13.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:56:00 -0800 (PST)
From: inwardvessel <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 4/4 v2] cgroup: separate rstat list pointers from base stats
Date: Thu, 27 Feb 2025 13:55:43 -0800
Message-ID: <20250227215543.49928-5-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215543.49928-1-inwardvessel@gmail.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JP Kobryn <inwardvessel@gmail.com>

A majority of the cgroup_rstat_cpu struct size is made up of the base
stat entities. Since only the "self" subsystem state makes use of these,
move them into a struct of their own. This allows for a new compact
cgroup_rstat_cpu struct that the formal subsystems can make use of.
Where applicable, decide on whether to allocate the compact or full
struct including the base stats.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h | 37 ++++++++++++++----------
 kernel/cgroup/rstat.c       | 57 +++++++++++++++++++++++++------------
 2 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1598e1389615..b0a07c63fd46 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -170,7 +170,10 @@ struct cgroup_subsys_state {
 	struct percpu_ref refcnt;
 
 	/* per-cpu recursive resource statistics */
-	struct cgroup_rstat_cpu __percpu *rstat_cpu;
+	union {
+		struct cgroup_rstat_cpu __percpu *rstat_cpu;
+		struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
+	};
 
 	/*
 	 * siblings list anchored at the parent's ->children
@@ -356,6 +359,24 @@ struct cgroup_base_stat {
  * resource statistics on top of it - bsync, bstat and last_bstat.
  */
 struct cgroup_rstat_cpu {
+	/*
+	 * Child cgroups with stat updates on this cpu since the last read
+	 * are linked on the parent's ->updated_children through
+	 * ->updated_next.
+	 *
+	 * In addition to being more compact, singly-linked list pointing
+	 * to the cgroup makes it unnecessary for each per-cpu struct to
+	 * point back to the associated cgroup.
+	 *
+	 * Protected by per-cpu cgroup_rstat_cpu_lock.
+	 */
+	struct cgroup_subsys_state *updated_children;	/* terminated by self */
+	struct cgroup_subsys_state *updated_next;		/* NULL if not on list */
+};
+
+struct cgroup_rstat_base_cpu {
+	struct cgroup_rstat_cpu self;
+
 	/*
 	 * ->bsync protects ->bstat.  These are the only fields which get
 	 * updated in the hot path.
@@ -382,20 +403,6 @@ struct cgroup_rstat_cpu {
 	 * deltas to propagate to the per-cpu subtree_bstat.
 	 */
 	struct cgroup_base_stat last_subtree_bstat;
-
-	/*
-	 * Child cgroups with stat updates on this cpu since the last read
-	 * are linked on the parent's ->updated_children through
-	 * ->updated_next.
-	 *
-	 * In addition to being more compact, singly-linked list pointing
-	 * to the cgroup makes it unnecessary for each per-cpu struct to
-	 * point back to the associated cgroup.
-	 *
-	 * Protected by per-cpu cgroup_rstat_cpu_lock.
-	 */
-	struct cgroup_subsys_state *updated_children;	/* terminated by self */
-	struct cgroup_subsys_state *updated_next;		/* NULL if not on list */
 };
 
 struct cgroup_freezer_state {
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index b3eaefc1fd07..c08ebe2f9568 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -24,6 +24,12 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(
 	return per_cpu_ptr(css->rstat_cpu, cpu);
 }
 
+static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
+		struct cgroup_subsys_state *css, int cpu)
+{
+	return per_cpu_ptr(css->rstat_base_cpu, cpu);
+}
+
 static inline bool is_base_css(struct cgroup_subsys_state *css)
 {
 	return css->ss == NULL;
@@ -438,17 +444,31 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
 
 	/* the root cgrp's self css has rstat_cpu preallocated */
 	if (!css->rstat_cpu) {
-		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!css->rstat_cpu)
-			return -ENOMEM;
-	}
+		if (is_base_css(css)) {
+			css->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+			if (!css->rstat_base_cpu)
+				return -ENOMEM;
 
-	/* ->updated_children list is self terminated */
-	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(css, cpu);
+			for_each_possible_cpu(cpu) {
+				struct cgroup_rstat_base_cpu *rstatc;
+
+				rstatc = cgroup_rstat_base_cpu(css, cpu);
+				rstatc->self.updated_children = css;
+				u64_stats_init(&rstatc->bsync);
+			}
+		} else {
+			css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+			if (!css->rstat_cpu)
+				return -ENOMEM;
+
+			for_each_possible_cpu(cpu) {
+				struct cgroup_rstat_cpu *rstatc;
+
+				rstatc = cgroup_rstat_cpu(css, cpu);
+				rstatc->updated_children = css;
+			}
+		}
 
-		rstatc->updated_children = css;
-		u64_stats_init(&rstatc->bsync);
 	}
 
 	return 0;
@@ -522,9 +542,10 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(&cgrp->self, cpu);
+	struct cgroup_rstat_base_cpu *rstatc = cgroup_rstat_base_cpu(
+			&cgrp->self, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
-	struct cgroup_rstat_cpu *prstatc;
+	struct cgroup_rstat_base_cpu *prstatc;
 	struct cgroup_base_stat delta;
 	unsigned seq;
 
@@ -552,25 +573,25 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
 		delta = rstatc->subtree_bstat;
-		prstatc = cgroup_rstat_cpu(&parent->self, cpu);
+		prstatc = cgroup_rstat_base_cpu(&parent->self, cpu);
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
 
-	rstatc = get_cpu_ptr(cgrp->self.rstat_cpu);
+	rstatc = get_cpu_ptr(cgrp->self.rstat_base_cpu);
 	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
 
 static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct cgroup_rstat_cpu *rstatc,
+						 struct cgroup_rstat_base_cpu *rstatc,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
@@ -580,7 +601,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatc;
 	unsigned long flags;
 
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
@@ -591,7 +612,7 @@ void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 void __cgroup_account_cputime_field(struct cgroup *cgrp,
 				    enum cpu_usage_stat index, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatc;
 	unsigned long flags;
 
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
-- 
2.43.5


