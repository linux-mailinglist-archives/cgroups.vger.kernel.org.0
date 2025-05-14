Return-Path: <cgroups+bounces-8174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1171AAB61A7
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 06:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0DD189FA25
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 04:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB61F0E37;
	Wed, 14 May 2025 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMD8L/wS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2F1CFBC;
	Wed, 14 May 2025 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197886; cv=none; b=NgNZLr6o2sfjDXxMzH5w36nwgyoxSaRPAvfQ2yHjhuzJIjjBEEkz96U+d4yisIjAr7RdrgTFCZWNMy7qGvCbzcfUaV53jxpO/L1B6hU4V06quKbIJ3gTkk7spmQQHdi387gPlnQjGgT3IRXOuBNBgbiWKfrqgZ15Kh9VZwRNPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197886; c=relaxed/simple;
	bh=JM6s38ilKaapWxY0omjoFSzpjd/zCOTMNCd1O7dR9kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYJ9bxtGcoaFvwqgzOlV3Y1cVaDRHySBhwntskmMwEwUshK9jeA8DKsay9FR6vqnG7ljDJgkHe80Eew56Sn204dRK24TvhfENME1LAfjiLdnloHdKZfY7CXUL3HTsEp5OF4hbBN1LMsBt2iJfjkT5KhFSSfInwsz0ESJ/NX/364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMD8L/wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17DBC4CEED;
	Wed, 14 May 2025 04:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747197886;
	bh=JM6s38ilKaapWxY0omjoFSzpjd/zCOTMNCd1O7dR9kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMD8L/wSneZiTW9DAja5Mg8OPQIqeRru3Lt+eMZ+fSkUbkhaYIbpCqLxvAysV9X9t
	 daLvQDzpyykqZxcXH6EGExVynYu9HoUq9DgFo9vozDw5/klxoLkKmz5kj20DsFBwDT
	 RnHwG32nByUR3c2CFqrYVRBPlyLSV4x23s0YE6Beo9lr1q+R5DfM4u/g+xBFtOh8zf
	 A3lwqZgJD/K+56bEIqA5lwxeeHPJqtM8fgynbmh52ELAcIADC7G1M486E6tD5vs6jY
	 MranxhUd3yRzQb5Crq7B/MZCOgjEKyQFH9pKAtrtke0m8lDZmyPfTXEfSiCZsJ7IRJ
	 IWyih44qoxL8g==
Date: Wed, 14 May 2025 00:44:44 -0400
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/3 cgroup/for-6.16] sched_ext: Introduce
 cgroup_lifetime_notifier
Message-ID: <aCQfvCuVWOYkv_X5@mtj.duckdns.org>
References: <aCQfffBvNpW3qMWN@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCQfffBvNpW3qMWN@mtj.duckdns.org>

Other subsystems may make use of the cgroup hierarchy with the cgroup_bpf
support being one such example. For such a feature, it's useful to be able
to hook into cgroup creation and destruction paths to perform
feature-specific initializations and cleanups.

Add cgroup_lifetime_notifier which generates CGROUP_LIFETIME_ONLINE and
CGROUP_LIFETIME_OFFLINE events whenever cgroups are created and destroyed,
respectively.

The next patch will convert cgroup_bpf to use the new notifier and other
uses are planned.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h |    9 ++++++++-
 kernel/cgroup/cgroup.c |   27 ++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -19,6 +19,7 @@
 #include <linux/kernfs.h>
 #include <linux/jump_label.h>
 #include <linux/types.h>
+#include <linux/notifier.h>
 #include <linux/ns_common.h>
 #include <linux/nsproxy.h>
 #include <linux/user_namespace.h>
@@ -40,7 +41,7 @@ struct kernel_clone_args;
 
 #ifdef CONFIG_CGROUPS
 
-enum {
+enum css_task_iter_flags {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
 	CSS_TASK_ITER_SKIPPED  = (1U << 16), /* internal flags */
@@ -66,10 +67,16 @@ struct css_task_iter {
 	struct list_head		iters_node;	/* css_set->task_iters */
 };
 
+enum cgroup_lifetime_events {
+	CGROUP_LIFETIME_ONLINE,
+	CGROUP_LIFETIME_OFFLINE,
+};
+
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
 extern spinlock_t css_set_lock;
+extern struct blocking_notifier_head cgroup_lifetime_notifier;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -95,6 +95,9 @@ EXPORT_SYMBOL_GPL(cgroup_mutex);
 EXPORT_SYMBOL_GPL(css_set_lock);
 #endif
 
+struct blocking_notifier_head cgroup_lifetime_notifier =
+	BLOCKING_NOTIFIER_INIT(cgroup_lifetime_notifier);
+
 DEFINE_SPINLOCK(trace_cgroup_path_lock);
 char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
 static bool cgroup_debug __read_mostly;
@@ -1335,6 +1338,7 @@ static void cgroup_destroy_root(struct c
 {
 	struct cgroup *cgrp = &root->cgrp;
 	struct cgrp_cset_link *link, *tmp_link;
+	int ret;
 
 	trace_cgroup_destroy_root(root);
 
@@ -1343,6 +1347,10 @@ static void cgroup_destroy_root(struct c
 	BUG_ON(atomic_read(&root->nr_cgrps));
 	BUG_ON(!list_empty(&cgrp->self.children));
 
+	ret = blocking_notifier_call_chain(&cgroup_lifetime_notifier,
+					   CGROUP_LIFETIME_OFFLINE, cgrp);
+	WARN_ON_ONCE(notifier_to_errno(ret));
+
 	/* Rebind all subsystems back to the default hierarchy */
 	WARN_ON(rebind_subsystems(&cgrp_dfl_root, root->subsys_mask));
 
@@ -2159,6 +2167,10 @@ int cgroup_setup_root(struct cgroup_root
 		WARN_ON_ONCE(ret);
 	}
 
+	ret = blocking_notifier_call_chain(&cgroup_lifetime_notifier,
+					   CGROUP_LIFETIME_ONLINE, root_cgrp);
+	WARN_ON_ONCE(notifier_to_errno(ret));
+
 	trace_cgroup_setup_root(root);
 
 	/*
@@ -5753,6 +5765,15 @@ static struct cgroup *cgroup_create(stru
 			goto out_psi_free;
 	}
 
+	ret = blocking_notifier_call_chain_robust(&cgroup_lifetime_notifier,
+						  CGROUP_LIFETIME_ONLINE,
+						  CGROUP_LIFETIME_OFFLINE, cgrp);
+	ret = notifier_to_errno(ret);
+	if (ret) {
+		cgroup_bpf_offline(cgrp);
+		goto out_psi_free;
+	}
+
 	/* allocation complete, commit to creation */
 	spin_lock_irq(&css_set_lock);
 	for (i = 0; i < level; i++) {
@@ -5980,7 +6001,7 @@ static int cgroup_destroy_locked(struct
 	struct cgroup *tcgrp, *parent = cgroup_parent(cgrp);
 	struct cgroup_subsys_state *css;
 	struct cgrp_cset_link *link;
-	int ssid;
+	int ssid, ret;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -6041,6 +6062,10 @@ static int cgroup_destroy_locked(struct
 	if (cgrp->root == &cgrp_dfl_root)
 		cgroup_bpf_offline(cgrp);
 
+	ret = blocking_notifier_call_chain(&cgroup_lifetime_notifier,
+					   CGROUP_LIFETIME_OFFLINE, cgrp);
+	WARN_ON_ONCE(notifier_to_errno(ret));
+
 	/* put the base reference */
 	percpu_ref_kill(&cgrp->self.refcnt);
 

