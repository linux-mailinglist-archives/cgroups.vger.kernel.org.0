Return-Path: <cgroups+bounces-7343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC447A7B55C
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E67172FE2
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517191862A;
	Fri,  4 Apr 2025 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imIdgh2Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBCE571
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729069; cv=none; b=JYFqeWGSbevTXSQ0sYkjZZEzUZ8Ba6JH3qginBgh1ds4a6TgQd7rQs6+mySSH76BDi/mmRwc2Wv2Af3zqENxMX4Sx9pcUkBXk7iuANb+UKmGhT0lp4DmoiMnhA+FyyhNwPa684fbwu5dvwv0oIHLSlDAD5VAT/5xA3SOyRMu7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729069; c=relaxed/simple;
	bh=OlXbJE4cgWCeAGDl+z8DiyoILQXTWNco/AkklIQfztY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFtrKIEK0VrLcc2hpunYVm0JGOQEFAR0taqQs6vYlp8gg+fQ/dcTWMo+KYEnCLh0FBBwHBI0IiXBle62xXr1482noau4Mx1rlofCy5wNPbtI5D43LWptjxIEOxxINukBByTibuQrfQQ996IJVD+heT3QLrSSBOHmWwsITVOp53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imIdgh2Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227d6b530d8so14319695ad.3
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743729066; x=1744333866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vwLVvjlWc9f28WdHegVpOwSu3QlhWLOaVgP+ftxD/Q=;
        b=imIdgh2QTQgmV2cw+ZUsHAiHW2krb/LCt9FosIxrJ0nZm+qNxZIdF939ROo7sOC8Ye
         2hnD2V1p+F55hlU1nn97iuY46dJfEGzGqx8jOByWxT7OxEmXmkiShbpLBW0J9xYB+fYs
         MeqCRRer3IwdiTwxn8MLNKPVERDrwEHRNPug7vV70DF21mDZ81qWGtGrvAmQCHaUjVfh
         YAsEwZ42FwTxNxFy7mN2MF7SluYfgOBnPEJn/o2I/VsU0UjF51mrqp1Ycj+6JpZr59bZ
         FFSQRh6OlI27CrLbe5C46izZ4mIAaeAnqNKLiFEE9lmFlTsmlo8fIkF492v0raBdbSXO
         QIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743729066; x=1744333866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vwLVvjlWc9f28WdHegVpOwSu3QlhWLOaVgP+ftxD/Q=;
        b=ZgxAFNztLl1yUhOZZZPLVlsTIxQTtzY/Xot8bMFFsbPjQUeMsp8gZ3WphiyYxFbHLg
         IcjNe1eAV1l/lhOMThuVTmKYjfgw+FOEyM+7w0ygq7Xt4iQGJR6FBKNHkHxwO/tVVnKl
         OqvsLxxLZ9IVCago72JHFcoTF7pdIvKr3y+ZWJ0p7wMPAs8ArjlewKUJc2fhPgQ18rW8
         JnABFpE8X9PjWyjlyvx5ufTIFPxtfw1BsZhnzJvPzMUT5D4irahi9G8cJ20CaDUaR/H6
         Xr7eAZm5jQb5k+fjzpadb1PUcpbP4VZLW6GdDsNTbEPh51iGVLDLR1+DE/fo9ay5HUVt
         5rng==
X-Forwarded-Encrypted: i=1; AJvYcCWZPiJxjCpffnA7du12V9wOX+HiYihDFEIKqynDAPx8NfC26tMSNNplCCqtbomatkZvZihWkoZK@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7Z0quOPyAr7Y9SJNo6gNWDoPEDArYcjYsqUQvleucd5wFP7o
	5E5fa3zL98qZEIV3GN6eP7D7KbhgMZoBcjxXDatFPwkVUbHL3G8twr4iPA==
X-Gm-Gg: ASbGncuYAmREQkL7jpdMEGlT3Z+Kav9ywdT0J126uzwJinqCYl00ckzrAU8crHz55QD
	DBr1DR8N8vgry84IOvD5GPCKKTkVwXpK7i4Kp+fVZmpYZFKjqwmrheGfMP/bffmO3H/5xF5LTH4
	58BGjbXyH1Qn8ioje7GTn0faZl9uHlsMsjv+Y5X/xM+dA7UQU0Pi5WUrNCUgYIplDbivP821fJA
	JrZ/RmBH4Ixe+tdQuaTR2ic36lav2XMwajabY5vD720IVuYkZzlH8PfP4bP8+0kbl4chjGfgoLF
	K/Yj0F7Lxpa+QKveNP9UYl/Pgd3Jmcqn5kE28uGZCkT01vDh0NTTzufpPJOMFK0h4+pxmXbb
X-Google-Smtp-Source: AGHT+IG6qH+9OB7e70FWVAVKaHc6KOpA4SpNNU673ZRvU1zuYUnkNGSyYQV0Xdr1X73Ttnd1YAuaDw==
X-Received: by 2002:a17:902:e5c4:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22a8a0b40c8mr14656445ad.48.1743729066265;
        Thu, 03 Apr 2025 18:11:06 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:9b28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9a0sm21268675ad.39.2025.04.03.18.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 18:11:05 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 3/5] cgroup: change rstat function signatures from cgroup-based to css-based
Date: Thu,  3 Apr 2025 18:10:48 -0700
Message-ID: <20250404011050.121777-4-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404011050.121777-1-inwardvessel@gmail.com>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This non-functional change serves as preparation for moving to
subsystem-based rstat trees. To simplify future commits, change the
signatures of existing cgroup-based rstat functions to become css-based and
rename them to reflect that.

Though the signatures have changed, the implementations have not. Within
these functions use the css->cgroup pointer to obtain the associated cgroup
and allow code to function the same just as it did before this patch. At
applicable call sites, pass the subsystem-specific css pointer as an
argument or pass a pointer to cgroup::self if not in subsystem context.

Note that cgroup_rstat_updated_list() and cgroup_rstat_push_children()
are not altered yet since there would be a larger amount of css to
cgroup conversions which may overcomplicate the code at this
intermediate phase.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 block/blk-cgroup.c                            |  6 +-
 include/linux/cgroup-defs.h                   |  2 +-
 include/linux/cgroup.h                        |  4 +-
 kernel/cgroup/cgroup-internal.h               |  4 +-
 kernel/cgroup/cgroup.c                        | 30 ++++---
 kernel/cgroup/rstat.c                         | 83 +++++++++++--------
 mm/memcontrol.c                               |  4 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |  9 +-
 8 files changed, 80 insertions(+), 62 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5905f277057b..0560ea402856 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1144,7 +1144,7 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 /*
  * We source root cgroup stats from the system-wide stats to avoid
  * tracking the same information twice and incurring overhead when no
- * cgroups are defined. For that reason, cgroup_rstat_flush in
+ * cgroups are defined. For that reason, css_rstat_flush in
  * blkcg_print_stat does not actually fill out the iostat in the root
  * cgroup's blkcg_gq.
  *
@@ -1253,7 +1253,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		css_rstat_flush(&blkcg->css);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -2243,7 +2243,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
+	css_rstat_updated(&blkcg->css, cpu);
 	put_cpu();
 }
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6d177f770d28..e4a9fb00b228 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -536,7 +536,7 @@ struct cgroup {
 	/*
 	 * A singly-linked list of cgroup structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
-	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
+	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
 	 */
 	struct cgroup	*rstat_flush_next;
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 7c120efd5e49..b906c53953b9 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -693,8 +693,8 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup scalable recursive statistics.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
-void cgroup_rstat_flush(struct cgroup *cgrp);
+void css_rstat_updated(struct cgroup_subsys_state *css, int cpu);
+void css_rstat_flush(struct cgroup_subsys_state *css);
 
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 95ab39e1ec8f..c161d34be634 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -270,8 +270,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 /*
  * rstat.c
  */
-int cgroup_rstat_init(struct cgroup *cgrp);
-void cgroup_rstat_exit(struct cgroup *cgrp);
+int css_rstat_init(struct cgroup_subsys_state *css);
+void css_rstat_exit(struct cgroup_subsys_state *css);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 00eb882dc6e7..f8cee7819642 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1375,7 +1375,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_unlock();
 
-	cgroup_rstat_exit(cgrp);
+	css_rstat_exit(&cgrp->self);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -2150,7 +2150,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = cgroup_rstat_init(root_cgrp);
+	ret = css_rstat_init(&root_cgrp->self);
 	if (ret)
 		goto destroy_root;
 
@@ -2192,7 +2192,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	cgroup_rstat_exit(root_cgrp);
+	css_rstat_exit(&root_cgrp->self);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -5449,7 +5449,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			cgroup_rstat_exit(cgrp);
+			css_rstat_exit(css);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5479,7 +5479,7 @@ static void css_release_work_fn(struct work_struct *work)
 
 		/* css release path */
 		if (!list_empty(&css->rstat_css_node)) {
-			cgroup_rstat_flush(cgrp);
+			css_rstat_flush(css);
 			list_del_rcu(&css->rstat_css_node);
 		}
 
@@ -5507,7 +5507,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		cgroup_rstat_flush(cgrp);
+		css_rstat_flush(css);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5700,17 +5700,13 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	ret = cgroup_rstat_init(cgrp);
-	if (ret)
-		goto out_cancel_ref;
-
 	/* create the directory */
 	kn = kernfs_create_dir_ns(parent->kn, name, mode,
 				  current_fsuid(), current_fsgid(),
 				  cgrp, NULL);
 	if (IS_ERR(kn)) {
 		ret = PTR_ERR(kn);
-		goto out_stat_exit;
+		goto out_cancel_ref;
 	}
 	cgrp->kn = kn;
 
@@ -5720,6 +5716,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	cgrp->root = root;
 	cgrp->level = level;
 
+	/*
+	 * Now that init_cgroup_housekeeping() has been called and cgrp->self
+	 * is setup, it is safe to perform rstat initialization on it.
+	 */
+	ret = css_rstat_init(&cgrp->self);
+	if (ret)
+		goto out_stat_exit;
+
 	ret = psi_cgroup_alloc(cgrp);
 	if (ret)
 		goto out_kernfs_remove;
@@ -5790,10 +5794,10 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 out_psi_free:
 	psi_cgroup_free(cgrp);
+out_stat_exit:
+	css_rstat_exit(&cgrp->self);
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
-out_stat_exit:
-	cgroup_rstat_exit(cgrp);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a20e3ab3f7d3..5bca55b4ec15 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -34,9 +34,10 @@ static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
  * operations without handling high-frequency fast-path "update" events.
  */
 static __always_inline
-unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
-				     struct cgroup *cgrp, const bool fast_path)
+unsigned long _css_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
+				     struct cgroup_subsys_state *css, const bool fast_path)
 {
+	struct cgroup *cgrp = css->cgroup;
 	unsigned long flags;
 	bool contended;
 
@@ -67,10 +68,12 @@ unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
 }
 
 static __always_inline
-void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
-			      struct cgroup *cgrp, unsigned long flags,
+void _css_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
+			      struct cgroup_subsys_state *css, unsigned long flags,
 			      const bool fast_path)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	if (fast_path)
 		trace_cgroup_rstat_cpu_unlock_fastpath(cgrp, cpu, false);
 	else
@@ -80,16 +83,17 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
 }
 
 /**
- * cgroup_rstat_updated - keep track of updated rstat_cpu
- * @cgrp: target cgroup
+ * css_rstat_updated - keep track of updated rstat_cpu
+ * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
- * @cgrp's rstat_cpu on @cpu was updated.  Put it on the parent's matching
- * rstat_cpu->updated_children list.  See the comment on top of
+ * @css->cgroup's rstat_cpu on @cpu was updated. Put it on the parent's
+ * matching rstat_cpu->updated_children list. See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-__bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
+	struct cgroup *cgrp = css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
@@ -104,7 +108,7 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
 		return;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
+	flags = _css_rstat_cpu_lock(cpu_lock, cpu, css, true);
 
 	/* put @cgrp and all ancestors on the corresponding updated lists */
 	while (true) {
@@ -132,7 +136,7 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 		cgrp = parent;
 	}
 
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
+	_css_rstat_cpu_unlock(cpu_lock, cpu, css, flags, true);
 }
 
 /**
@@ -213,7 +217,7 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	struct cgroup *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root, false);
+	flags = _css_rstat_cpu_lock(cpu_lock, cpu, &root->self, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -250,14 +254,14 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_css_rstat_cpu_unlock(cpu_lock, cpu, &root->self, flags, false);
 	return head;
 }
 
 /*
  * A hook for bpf stat collectors to attach to and flush their stats.
- * Together with providing bpf kfuncs for cgroup_rstat_updated() and
- * cgroup_rstat_flush(), this enables a complete workflow where bpf progs that
+ * Together with providing bpf kfuncs for css_rstat_updated() and
+ * css_rstat_flush(), this enables a complete workflow where bpf progs that
  * collect cgroup stats can integrate with rstat for efficient flushing.
  *
  * A static noinline declaration here could cause the compiler to optimize away
@@ -285,9 +289,11 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
+static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
+		int cpu_in_loop)
 	__acquires(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
 	bool contended;
 
 	contended = !spin_trylock_irq(&cgroup_rstat_lock);
@@ -298,36 +304,41 @@ static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
 	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
 
-static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
+static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
+		int cpu_in_loop)
 	__releases(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
 /**
- * cgroup_rstat_flush - flush stats in @cgrp's subtree
- * @cgrp: target cgroup
+ * css_rstat_flush - flush stats in @css->cgroup's subtree
+ * @css: target cgroup subsystem state
  *
- * Collect all per-cpu stats in @cgrp's subtree into the global counters
+ * Collect all per-cpu stats in @css->cgroup's subtree into the global counters
  * and propagate them upwards.  After this function returns, all cgroups in
  * the subtree have up-to-date ->stat.
  *
- * This also gets all cgroups in the subtree including @cgrp off the
+ * This also gets all cgroups in the subtree including @css->cgroup off the
  * ->updated_children lists.
  *
  * This function may block.
  */
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
+__bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	might_sleep();
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
+		struct cgroup *pos;
 
 		/* Reacquire for each CPU to avoid disabling IRQs too long */
-		__cgroup_rstat_lock(cgrp, cpu);
+		__css_rstat_lock(css, cpu);
+		pos = cgroup_rstat_updated_list(cgrp, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
@@ -340,14 +351,15 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-		__cgroup_rstat_unlock(cgrp, cpu);
+		__css_rstat_unlock(css, cpu);
 		if (!cond_resched())
 			cpu_relax();
 	}
 }
 
-int cgroup_rstat_init(struct cgroup *cgrp)
+int css_rstat_init(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	/* the root cgrp has rstat_cpu preallocated */
@@ -378,11 +390,12 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 	return 0;
 }
 
-void cgroup_rstat_exit(struct cgroup *cgrp)
+void css_rstat_exit(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	cgroup_rstat_flush(cgrp);
+	css_rstat_flush(&cgrp->self);
 
 	/* sanity check */
 	for_each_possible_cpu(cpu) {
@@ -489,7 +502,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatbc->bsync, flags);
-	cgroup_rstat_updated(cgrp, smp_processor_id());
+	css_rstat_updated(&cgrp->self, smp_processor_id());
 	put_cpu_ptr(rstatbc);
 }
 
@@ -591,12 +604,12 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	struct cgroup_base_stat bstat;
 
 	if (cgroup_parent(cgrp)) {
-		cgroup_rstat_flush(cgrp);
-		__cgroup_rstat_lock(cgrp, -1);
+		css_rstat_flush(&cgrp->self);
+		__css_rstat_lock(&cgrp->self, -1);
 		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &bstat.cputime.utime, &bstat.cputime.stime);
-		__cgroup_rstat_unlock(cgrp, -1);
+		__css_rstat_unlock(&cgrp->self, -1);
 	} else {
 		root_cgroup_cputime(&bstat);
 	}
@@ -618,10 +631,10 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	cgroup_force_idle_show(seq, &bstat);
 }
 
-/* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
+/* Add bpf kfuncs for css_rstat_updated() and css_rstat_flush() */
 BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
-BTF_ID_FLAGS(func, cgroup_rstat_updated)
-BTF_ID_FLAGS(func, cgroup_rstat_flush, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, css_rstat_updated)
+BTF_ID_FLAGS(func, css_rstat_flush, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_rstat_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421740f1bcdc..140b31821b48 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -582,7 +582,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+	css_rstat_updated(&memcg->css, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
 		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
@@ -614,7 +614,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	css_rstat_flush(&memcg->css);
 }
 
 /*
diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index c74362854948..ff189a736ad8 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -37,8 +37,9 @@ struct {
 	__type(value, struct attach_counter);
 } attach_counters SEC(".maps");
 
-extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
-extern void cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
+extern void css_rstat_updated(
+		struct cgroup_subsys_state *css, int cpu) __ksym;
+extern void css_rstat_flush(struct cgroup_subsys_state *css) __ksym;
 
 static uint64_t cgroup_id(struct cgroup *cgrp)
 {
@@ -75,7 +76,7 @@ int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
 	else if (create_percpu_attach_counter(cg_id, 1))
 		return 0;
 
-	cgroup_rstat_updated(dst_cgrp, bpf_get_smp_processor_id());
+	css_rstat_updated(&dst_cgrp->self, bpf_get_smp_processor_id());
 	return 0;
 }
 
@@ -141,7 +142,7 @@ int BPF_PROG(dumper, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 		return 1;
 
 	/* Flush the stats to make sure we get the most updated numbers */
-	cgroup_rstat_flush(cgrp);
+	css_rstat_flush(&cgrp->self);
 
 	total_counter = bpf_map_lookup_elem(&attach_counters, &cg_id);
 	if (!total_counter) {
-- 
2.47.1


