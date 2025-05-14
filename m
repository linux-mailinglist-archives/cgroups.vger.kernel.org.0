Return-Path: <cgroups+bounces-8173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A6AB61A4
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 06:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F61A3BA31D
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 04:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B081F09B4;
	Wed, 14 May 2025 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMExfkS2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39D1CFBC;
	Wed, 14 May 2025 04:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197823; cv=none; b=sOCjPdUsvqAqTr4cz0THA0hBAomlHVD/XKSFqPF40k4OHY4NLQYKvvxAuHH5D7UGUydk1PpoE4KL2I8m2/Ni1bdamTqqDDwj5eUAgFXlRUWdbNfUXyUPlKjKAMsCr4Irn6yIMD+MFK4P4FlSOdD+2lFw+1mB+J7jMs2PRx/quA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197823; c=relaxed/simple;
	bh=VwSIJA+wb/j9BMRwnFIEhKMNbP6NKUJalfyZ4f/bLXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nTmKYTgiTfto+AQf7n1Nhj/o/d+28VBttqYrAMfrnIxY5zeyaDxjVRvVtXieUcvPRcz6IlMu48Tm5PvJHAm9A2i8XAkh/7TsGsfkNg936ik/pdBKq4tZkY0mdrVgBFwYNYeF6xJ/U2yZ3sKQ5ekSvddzpr7LPrGLIyTpNxdcVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMExfkS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E03C4CEED;
	Wed, 14 May 2025 04:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747197823;
	bh=VwSIJA+wb/j9BMRwnFIEhKMNbP6NKUJalfyZ4f/bLXI=;
	h=Date:From:To:Cc:Subject:From;
	b=oMExfkS28DDprxPjeb/zD7ZImjE//XG+3/r01BwASKFKzpyEqf8o/7g5m6KfmuRZ6
	 +IHt4YYJnuLlUaHHqj5T7+PSwds2BmP0GE87ddTp97lIBF0+327wtrjsh95q63REjg
	 liPOBMoWbUujlcy4dQifr+r6fEXNCYxW+PaBWdKA9K9isrlX/VgFDjzg3CR84s0/KQ
	 3kGh6b4w0mcGthJMiEM5a1Utn/ijo99PcXol1JFJDvPXZr1npfRl/oibH/0SmpTOB1
	 2a23Aw9AXS1PaUizpkhNnLKTq/Nm2QsVaQgpSeT3shsOXcAn1eQTxSHaLCSu/KHevk
	 A/QkuPsPWBCdA==
Date: Wed, 14 May 2025 00:43:41 -0400
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/3 cgroup/for-6.16] cgroup: Minor reorganization of
 cgroup_create()
Message-ID: <aCQfffBvNpW3qMWN@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

cgroup_bpf init and exit handling will be moved to a notifier chain. In
prepartion, reorganize cgroup_create() a bit so that the new cgroup is fully
initialized before any outside changes are made.

- cgrp->ancestors[] initialization and the hierarchical nr_descendants and
  nr_frozen_descendants updates were in the same loop. Separate them out and
  do the former earlier and do the latter later.

- Relocate cgroup_bpf_inherit() call so that it's after all cgroup
  initializations are complete.

No visible behavior changes expected.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5684,7 +5684,7 @@ static struct cgroup *cgroup_create(stru
 	struct cgroup_root *root = parent->root;
 	struct cgroup *cgrp, *tcgrp;
 	struct kernfs_node *kn;
-	int level = parent->level + 1;
+	int i, level = parent->level + 1;
 	int ret;
 
 	/* allocate the cgroup and its ID, 0 is reserved for the root */
@@ -5720,11 +5720,8 @@ static struct cgroup *cgroup_create(stru
 	if (ret)
 		goto out_kernfs_remove;
 
-	if (cgrp->root == &cgrp_dfl_root) {
-		ret = cgroup_bpf_inherit(cgrp);
-		if (ret)
-			goto out_psi_free;
-	}
+	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp))
+		cgrp->ancestors[tcgrp->level] = tcgrp;
 
 	/*
 	 * New cgroup inherits effective freeze counter, and
@@ -5742,24 +5739,6 @@ static struct cgroup *cgroup_create(stru
 		set_bit(CGRP_FROZEN, &cgrp->flags);
 	}
 
-	spin_lock_irq(&css_set_lock);
-	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
-		cgrp->ancestors[tcgrp->level] = tcgrp;
-
-		if (tcgrp != cgrp) {
-			tcgrp->nr_descendants++;
-
-			/*
-			 * If the new cgroup is frozen, all ancestor cgroups
-			 * get a new frozen descendant, but their state can't
-			 * change because of this.
-			 */
-			if (cgrp->freezer.e_freeze)
-				tcgrp->freezer.nr_frozen_descendants++;
-		}
-	}
-	spin_unlock_irq(&css_set_lock);
-
 	if (notify_on_release(parent))
 		set_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
 
@@ -5768,7 +5747,28 @@ static struct cgroup *cgroup_create(stru
 
 	cgrp->self.serial_nr = css_serial_nr_next++;
 
+	if (cgrp->root == &cgrp_dfl_root) {
+		ret = cgroup_bpf_inherit(cgrp);
+		if (ret)
+			goto out_psi_free;
+	}
+
 	/* allocation complete, commit to creation */
+	spin_lock_irq(&css_set_lock);
+	for (i = 0; i < level; i++) {
+		tcgrp = cgrp->ancestors[i];
+		tcgrp->nr_descendants++;
+
+		/*
+		 * If the new cgroup is frozen, all ancestor cgroups get a new
+		 * frozen descendant, but their state can't change because of
+		 * this.
+		 */
+		if (cgrp->freezer.e_freeze)
+			tcgrp->freezer.nr_frozen_descendants++;
+	}
+	spin_unlock_irq(&css_set_lock);
+
 	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
 	atomic_inc(&root->nr_cgrps);
 	cgroup_get_live(parent);

