Return-Path: <cgroups+bounces-3677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952D931748
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A1E1F21F2D
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF918F2DD;
	Mon, 15 Jul 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYI2xqbm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF718EFE8
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055657; cv=none; b=gxSZUG8e84cEMyJO9LKr4/C9mt9vT/oetPiWOGH85VvZyaBYKjmlwgrwu/se9kY4UzDR2YTvwSt4BUa7qhz5P3Yq0auMIMZLguwg9YnxoA6M+WRg5te8ybs1iGHlabjp/reCr1oOfbHKOGFEmisgsGj+jzjH+dmTGNrV+awTQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055657; c=relaxed/simple;
	bh=j325IHElo6ZuouPg44z5dlzCsgdNWRS3ROXO9BZUDDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwC2SS4u8ssbqibnOw0XJwXW8+yNtCBEi9Ly3WlEdzmU82Ic1js/JMXcgorAnR4j7a0NRLDN/o/3YCypFqVqPN4Xhj1jcBnS+g+YYNkndf7IL3i31qSsNrx1cPqsqhrT8yRw4Uqaj7xbhRF8i6wVODNNglsjvi7Gt47OuO1VQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYI2xqbm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721055654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tb4l87oDxCeQh2eMPiDUUXOzH1cMP9tAKpWCk95Hjis=;
	b=bYI2xqbmPUHUtndeknGCpOANG0vIoCEgjoLzduksZ9WRDeXRttq0PmNLSk9mdIGMTZHX/t
	Ne3/Y6HVO3jjAaiNXwVXHapDO96eeYJ6zBz3w1wtrPhaqXAQPyFAuPWxX4u2FSpFFHngDs
	iSTTISsUFNyOBYMdI6UKgClySwSQI/g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-dNr3_IDpMXi3AMx9JZ2hiA-1; Mon,
 15 Jul 2024 11:00:48 -0400
X-MC-Unique: dNr3_IDpMXi3AMx9JZ2hiA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83E751955F43;
	Mon, 15 Jul 2024 15:00:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.29])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B268A1955D42;
	Mon, 15 Jul 2024 15:00:41 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v7] cgroup: Show # of subsystem CSSes in cgroup.stat
Date: Mon, 15 Jul 2024 11:00:34 -0400
Message-Id: <20240715150034.2583772-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
help manage different structures in various cgroup subsystems by being
an embedded element inside a larger structure like cpuset or mem_cgroup.

The /proc/cgroups file shows the number of cgroups for each of the
subsystems.  With cgroup v1, the number of CSSes is the same as the
number of cgroups.  That is not the case anymore with cgroup v2. The
/proc/cgroups file cannot show the actual number of CSSes for the
subsystems that are bound to cgroup v2.

So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
we can't tell by looking at /proc/cgroups which cgroup subsystems may
be responsible.

As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
cgroup.stat file is now being extended to show the number of live and
dying CSSes associated with all the non-inhibited cgroup subsystems that
have been bound to cgroup v2. The number includes CSSes in the current
cgroup as well as in all the descendants underneath it.  This will help
us pinpoint which subsystems are responsible for the increasing number
of dying (nr_dying_descendants) cgroups.

The CSSes dying counts are stored in the cgroup structure itself
instead of inside the CSS as suggested by Johannes. This will allow
us to accurately track dying counts of cgroup subsystems that have
recently been disabled in a cgroup. It is now possible that a zero
subsystem number is coupled with a non-zero dying subsystem number.

The cgroup-v2.rst file is updated to discuss this new behavior.

With this patch applied, a sample output from root cgroup.stat file
was shown below.

	nr_descendants 56
	nr_subsys_cpuset 1
	nr_subsys_cpu 43
	nr_subsys_io 43
	nr_subsys_memory 56
	nr_subsys_perf_event 57
	nr_subsys_hugetlb 1
	nr_subsys_pids 56
	nr_subsys_rdma 1
	nr_subsys_misc 1
	nr_dying_descendants 30
	nr_dying_subsys_cpuset 0
	nr_dying_subsys_cpu 0
	nr_dying_subsys_io 0
	nr_dying_subsys_memory 30
	nr_dying_subsys_perf_event 0
	nr_dying_subsys_hugetlb 0
	nr_dying_subsys_pids 0
	nr_dying_subsys_rdma 0
	nr_dying_subsys_misc 0

Another sample output from system.slice/cgroup.stat was:

	nr_descendants 34
	nr_subsys_cpuset 0
	nr_subsys_cpu 32
	nr_subsys_io 32
	nr_subsys_memory 34
	nr_subsys_perf_event 35
	nr_subsys_hugetlb 0
	nr_subsys_pids 34
	nr_subsys_rdma 0
	nr_subsys_misc 0
	nr_dying_descendants 30
	nr_dying_subsys_cpuset 0
	nr_dying_subsys_cpu 0
	nr_dying_subsys_io 0
	nr_dying_subsys_memory 30
	nr_dying_subsys_perf_event 0
	nr_dying_subsys_hugetlb 0
	nr_dying_subsys_pids 0
	nr_dying_subsys_rdma 0
	nr_dying_subsys_misc 0

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 +++++-
 include/linux/cgroup-defs.h             | 14 +++++++
 kernel/cgroup/cgroup.c                  | 55 ++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 52763d6b2919..abf3adad04bd 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -981,6 +981,14 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+	  nr_subsys_<cgroup_subsys>
+		Total number of live cgroup subsystems (e.g memory
+		cgroup) at and beneath the current cgroup.
+
+	  nr_dying_subsys_<cgroup_subsys>
+		Total number of dying cgroup subsystems (e.g. memory
+		cgroup) at and beneath the current cgroup.
+
   cgroup.freeze
 	A read-write single value file which exists on non-root cgroups.
 	Allowed values are "0" and "1". The default is "0".
@@ -2930,8 +2938,8 @@ Deprecated v1 Core Features
 
 - "cgroup.clone_children" is removed.
 
-- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
-  at the root instead.
+- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
+  "cgroup.stat" files at the root instead.
 
 
 Issues with v1 and Rationales for v2
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b36690ca0d3f..3cb049f104f6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -210,6 +210,14 @@ struct cgroup_subsys_state {
 	 * fields of the containing structure.
 	 */
 	struct cgroup_subsys_state *parent;
+
+	/*
+	 * Keep track of total numbers of visible descendant CSSes.
+	 * The total number of dying CSSes is tracked in
+	 * css->cgroup->nr_dying_subsys[ssid].
+	 * Protected by cgroup_mutex.
+	 */
+	int nr_descendants;
 };
 
 /*
@@ -470,6 +478,12 @@ struct cgroup {
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
 
+	/*
+	 * Keep track of total number of dying CSSes at and below this cgroup.
+	 * Protected by cgroup_mutex.
+	 */
+	int nr_dying_subsys[CGROUP_SUBSYS_COUNT];
+
 	struct cgroup_root *root;
 
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..601600afdd20 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3669,12 +3669,40 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
 static int cgroup_stat_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct cgroup_subsys_state *css;
+	int dying_cnt[CGROUP_SUBSYS_COUNT];
+	int ssid;
 
 	seq_printf(seq, "nr_descendants %d\n",
 		   cgroup->nr_descendants);
+
+	/*
+	 * Show the number of live and dying csses associated with each of
+	 * non-inhibited cgroup subsystems that is bound to cgroup v2.
+	 *
+	 * Without proper lock protection, racing is possible. So the
+	 * numbers may not be consistent when that happens.
+	 */
+	rcu_read_lock();
+	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
+		dying_cnt[ssid] = -1;
+		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
+		    (cgroup_subsys[ssid]->root !=  &cgrp_dfl_root))
+			continue;
+		css = rcu_dereference_raw(cgroup->subsys[ssid]);
+		dying_cnt[ssid] = cgroup->nr_dying_subsys[ssid];
+		seq_printf(seq, "nr_subsys_%s %d\n", cgroup_subsys[ssid]->name,
+			   css ? (css->nr_descendants + 1) : 0);
+	}
+
 	seq_printf(seq, "nr_dying_descendants %d\n",
 		   cgroup->nr_dying_descendants);
-
+	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
+		if (dying_cnt[ssid] >= 0)
+			seq_printf(seq, "nr_dying_subsys_%s %d\n",
+				   cgroup_subsys[ssid]->name, dying_cnt[ssid]);
+	}
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -5424,6 +5452,8 @@ static void css_release_work_fn(struct work_struct *work)
 	list_del_rcu(&css->sibling);
 
 	if (ss) {
+		struct cgroup *parent_cgrp;
+
 		/* css release path */
 		if (!list_empty(&css->rstat_css_node)) {
 			cgroup_rstat_flush(cgrp);
@@ -5433,6 +5463,14 @@ static void css_release_work_fn(struct work_struct *work)
 		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
 		if (ss->css_released)
 			ss->css_released(css);
+
+		cgrp->nr_dying_subsys[ss->id]--;
+		WARN_ON_ONCE(css->nr_descendants || cgrp->nr_dying_subsys[ss->id]);
+		parent_cgrp = cgroup_parent(cgrp);
+		while (parent_cgrp) {
+			parent_cgrp->nr_dying_subsys[ss->id]--;
+			parent_cgrp = cgroup_parent(parent_cgrp);
+		}
 	} else {
 		struct cgroup *tcgrp;
 
@@ -5517,8 +5555,11 @@ static int online_css(struct cgroup_subsys_state *css)
 		rcu_assign_pointer(css->cgroup->subsys[ss->id], css);
 
 		atomic_inc(&css->online_cnt);
-		if (css->parent)
+		if (css->parent) {
 			atomic_inc(&css->parent->online_cnt);
+			while ((css = css->parent))
+				css->nr_descendants++;
+		}
 	}
 	return ret;
 }
@@ -5540,6 +5581,16 @@ static void offline_css(struct cgroup_subsys_state *css)
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
 
 	wake_up_all(&css->cgroup->offline_waitq);
+
+	css->cgroup->nr_dying_subsys[ss->id]++;
+	/*
+	 * Parent css and cgroup cannot be freed until after the freeing
+	 * of child css, see css_free_rwork_fn().
+	 */
+	while ((css = css->parent)) {
+		css->nr_descendants--;
+		css->cgroup->nr_dying_subsys[ss->id]++;
+	}
 }
 
 /**
-- 
2.39.3


