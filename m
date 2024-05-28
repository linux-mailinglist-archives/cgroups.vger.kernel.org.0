Return-Path: <cgroups+bounces-3025-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B5E8D21C1
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21C728900A
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE03172BD8;
	Tue, 28 May 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKuiVYVr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460F172BCA
	for <cgroups@vger.kernel.org>; Tue, 28 May 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914282; cv=none; b=A6cwAL20yHtJDDyVF8WeA0U+CyE7eSERAXU0qvN+pOoOXrTU823IK1ArYBSjlL0C8VCh0mQ8t5W6m+GvnXuhBfQK4tlPEdj/wJJepCvqCyRUoaR4wG8ix8eeRxqB427fY+MZfH9i1qmwifIN70OjEpW+9MLDOHuadVx8P0xOYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914282; c=relaxed/simple;
	bh=3ZOe/NyEL4NYG0CoFbAifgplo20ZW+hFcf9C3d6vBio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WakyODy5SnjU09AoqEHOuzQKKd7AAOLZdMHoFzdPs01ZAtpunNVvdF4c0BmBdbGskwg2gKkOXGXBUaU8llKwygh54xs20Dclb5AE6FjqqaHuaxmqpccW1CtYvg8te/jAmjuh8lAm3U2kQfrY2LRIoLNuy2k/59dttoSB2E82ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKuiVYVr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627e6fe0303so17527857b3.2
        for <cgroups@vger.kernel.org>; Tue, 28 May 2024 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716914280; x=1717519080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jW03SLzQXCK5cXKTLHnT3g1oG6ovCyP3JejlVIXEzpI=;
        b=QKuiVYVr9MSZ/Vm886MEqCP61q2G/8bmKDNSUbLD3G7eZeslCE1n1cX0dNvzfqGqei
         09wBmWP6f+FtBOc99abH1tmAcbifZqTaYEvuRy5JUQn9kE58TEdqOwtujJxAoWaZ0VG9
         AvVdf9xEfyiIvszMKwILUmL0WlRo5xquWizFBtv7qVQGKWS4EgJL9nUDnq8B9pLaJl4H
         4ur5WMCahwHW7j/tH0iKISQc5bxKF5qrYXBB+0UFL7XPVMSaxqN4LVm74BGyflHy8/y4
         b2O6ZDDYMIdTugnnG0PSbSZtfPrjSiEJ97OL0gexZQ8p6n87VuhhqD8f0yB538LzANGH
         G5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914280; x=1717519080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW03SLzQXCK5cXKTLHnT3g1oG6ovCyP3JejlVIXEzpI=;
        b=VMXowLnn28P7JUAh7BiqiEEs3TUb3Uy4Wt+iZtMJJ3YUf1O3P8XEmMv12hpPAZ0O3v
         vlDwXIiO8bAAy+S1OzmdW+f0rzcP7BRHabAZZkUYuartg+QsPtssFelGt/eEcO31NCDT
         SXdKIp/6IkFZoRy4jXc+YojMWnZU0y447ier+4wjZdt1IKqyuhlI2kA0ZGzEmyfwHJoW
         fViv/bIT/rNOQqhban6vrh6nCWjJoWGHU+s/eEeHpqhsK+BV+WmSlMtv6hVDrC2z5C64
         zZ6ZxZ1G1r5RcTuJFy9nqC6TMaGdUB7LvmzFuDV9SzjrKjExntJnFHzFfQq3PryTdEx1
         z1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV6ALGBNut0Ax8DwpxKEHuIuPSPG48U2HUnawJiH5DFw/iq6E+jLwPsOsxPVi+MogcgDT80lMdGGNzxlXYmnSKIszJI+BKheA==
X-Gm-Message-State: AOJu0YxJfLitjphcedRQOlLuX6770RlRkbVghxyeEZHoVi9zwFnmh4NT
	bxUUXJS7i1R0vOn57D5/5YfWJRnLglWVIqLqTYOia+ktTBWj8Jh2xeYSeAnt/r2UbjsWPvRXX3e
	1s+wVP5zF+C7diA==
X-Google-Smtp-Source: AGHT+IEeHAL3ZeW6codhun7v67I8gtG3pX20wbsoxTrzUXIW9NcEB+1vJuC4aPjpz7QlEuuQPDo0ihUnHqeFZv8=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:690c:6a06:b0:627:e167:f95c with SMTP
 id 00721157ae682-62a08dcccb2mr35974547b3.4.1716914280240; Tue, 28 May 2024
 09:38:00 -0700 (PDT)
Date: Tue, 28 May 2024 16:37:49 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528163750.2025330-1-tjmercier@google.com>
Subject: [PATCH 2/2] cgroup: Remove nr_cgrps
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, mkoutny@suse.com, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

nr_cgrps now largely overlaps with nr_css. Use nr_css instead of
nr_cgrps for v1 so that nr_cgrps can be removed.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 include/linux/cgroup-defs.h |  3 ---
 kernel/cgroup/cgroup-v1.c   |  8 ++------
 kernel/cgroup/cgroup.c      | 31 +++++++++++++++++++++++++------
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index bc1dbf7652c4..dcd47a717eac 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -576,9 +576,6 @@ struct cgroup_root {
 	/* must follow cgrp for cgrp->ancestors[0], see above */
 	struct cgroup *cgrp_ancestor_storage;
 
-	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
-	atomic_t nr_cgrps;
-
 	/*
 	 * Number of cgroups using each controller. Includes online and zombies.
 	 * Used only for /proc/cgroups.
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 9bad59486c46..d52dc62803c3 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -675,15 +675,11 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 * cgroup_mutex contention.
 	 */
 
-	for_each_subsys(ss, i) {
-		int count = cgroup_on_dfl(&ss->root->cgrp) ?
-			atomic_read(&ss->root->nr_css[i]) : atomic_read(&ss->root->nr_cgrps);
-
+	for_each_subsys(ss, i)
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
-			   count,
+			   atomic_read(&ss->root->nr_css[i]),
 			   cgroup_ssid_enabled(i));
-	}
 
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1bacd7cf7551..fb4510a28ea3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1322,12 +1322,15 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 {
 	struct cgroup *cgrp = &root->cgrp;
 	struct cgrp_cset_link *link, *tmp_link;
+	struct cgroup_subsys *ss;
+	int ssid;
 
 	trace_cgroup_destroy_root(root);
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
-	BUG_ON(atomic_read(&root->nr_cgrps));
+	for_each_subsys(ss, ssid)
+		BUG_ON(atomic_read(&root->nr_css[ssid]));
 	BUG_ON(!list_empty(&cgrp->self.children));
 
 	/* Rebind all subsystems back to the default hierarchy */
@@ -1874,6 +1877,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		} else {
 			dcgrp->subtree_control |= 1 << ssid;
 			static_branch_disable(cgroup_subsys_on_dfl_key[ssid]);
+			atomic_set(&ss->root->nr_css[ssid], 1);
 		}
 
 		ret = cgroup_apply_control(dcgrp);
@@ -2046,7 +2050,6 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup *cgrp = &root->cgrp;
 
 	INIT_LIST_HEAD_RCU(&root->root_list);
-	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
@@ -2065,6 +2068,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	LIST_HEAD(tmp_links);
 	struct cgroup *root_cgrp = &root->cgrp;
 	struct kernfs_syscall_ops *kf_sops;
+	struct cgroup_subsys *ss;
 	struct css_set *cset;
 	int i, ret;
 
@@ -2144,7 +2148,9 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	spin_unlock_irq(&css_set_lock);
 
 	BUG_ON(!list_empty(&root_cgrp->self.children));
-	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
+	do_each_subsys_mask(ss, i, ss_mask) {
+		BUG_ON(atomic_read(&root->nr_css[i]) != 1);
+	} while_each_subsys_mask();
 
 	ret = 0;
 	goto out;
@@ -5368,7 +5374,6 @@ static void css_free_rwork_fn(struct work_struct *work)
 			css_put(parent);
 	} else {
 		/* cgroup free path */
-		atomic_dec(&cgrp->root->nr_cgrps);
 		if (!cgroup_on_dfl(cgrp))
 			cgroup1_pidlist_destroy_all(cgrp);
 		cancel_work_sync(&cgrp->release_agent_work);
@@ -5387,12 +5392,27 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_rstat_exit(cgrp);
 			kfree(cgrp);
 		} else {
+			struct cgroup_root *root = cgrp->root;
 			/*
 			 * This is root cgroup's refcnt reaching zero,
 			 * which indicates that the root should be
 			 * released.
 			 */
-			cgroup_destroy_root(cgrp->root);
+
+			/*
+			 * v1 root css are first onlined as v2, then rebound
+			 * to v1 (without re-onlining) where their count is
+			 * initialized to 1. Drop the root counters to 0
+			 * before destroying v1 roots.
+			 */
+			if (root != &cgrp_dfl_root) {
+				int ssid;
+
+				do_each_subsys_mask(ss, ssid, root->subsys_mask) {
+					atomic_dec(&root->nr_css[ssid]);
+				} while_each_subsys_mask();
+			}
+			cgroup_destroy_root(root);
 		}
 	}
 }
@@ -5678,7 +5698,6 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	/* allocation complete, commit to creation */
 	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
-	atomic_inc(&root->nr_cgrps);
 	cgroup_get_live(parent);
 
 	/*
-- 
2.45.1.288.g0e0cd299f1-goog


