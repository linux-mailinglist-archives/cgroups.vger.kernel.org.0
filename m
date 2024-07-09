Return-Path: <cgroups+bounces-3580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0E92BB0F
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72D028436F
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56A15DBB9;
	Tue,  9 Jul 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hquBD+Ca"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327B158A0D
	for <cgroups@vger.kernel.org>; Tue,  9 Jul 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531751; cv=none; b=RhZpArd1Z0u1e6LhPsTFBeCmeeXDiCPpEo5WKtdxqSlb5dpP9oZU/DXHDN4MzqbjpKWyr5Ud5zgW9an7NLE7O/aBu5o337cYr2O5Aa4pYYu/s38TiDVGK6vhgasQR1NsKQUkeoDkwNsbrFkEjAMb6OI6y7L8nO6cT2hpjDSP0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531751; c=relaxed/simple;
	bh=c+nnO9LMTahdthMrpi4qg1EXjDO3xxfybk7lUVAGKz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWSZpYpWHzTFpC6MX6qaWpGDUmgMJJN42EpCq6Bmh90RG2Bmdg7bG/cpakNQkEVQ8qkx8CRz3HCK+HHAkS2w//svLQS8PGdZtOxQM5H4CtfXP2InaeDHacnGnNqlaDu+u/wKt2r9Rs97JOj7M5dAH29lUIpXXQPTaij72FAjQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hquBD+Ca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720531747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qubRVCLAojwM88nAZiz+jBh5XpRB8iC1kGfHwMyytLA=;
	b=hquBD+CaODtzoJ+sfUkPExG+8BOizjwv6XWMyPxR73g6jb5f1gNhIR7rTtKhX+8N1qdI9e
	BzjjyDuxts3sjy56PorsH8QvmzUCeVt3uCC+g7UtGseGfH6Ykze3KRIiYHkRIyjQ3yiUSy
	zW6yb6xXDbNmvxxooUhH5CNlWA3oeGo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-VogK5-7ONjKpEcMdc7WqKg-1; Tue,
 09 Jul 2024 09:29:03 -0400
X-MC-Unique: VogK5-7ONjKpEcMdc7WqKg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCBE81920C78;
	Tue,  9 Jul 2024 13:28:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F28CE1955DDD;
	Tue,  9 Jul 2024 13:28:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2] cgroup: Show # of subsystem CSSes in root cgroup.stat
Date: Tue,  9 Jul 2024 09:28:14 -0400
Message-Id: <20240709132814.2198740-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The /proc/cgroups file shows the number of cgroups for each of the
subsystems.  With cgroup v1, the number of CSSes is the same as the
number of cgroups. That is not the case anymore with cgroup v2. The
/proc/cgroups file cannot show the actual number of CSSes for the
subsystems that are bound to cgroup v2.

So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
we can't tell by looking at /proc/cgroups which cgroup subsystems may be
responsible.  This patch adds CSS counts in the cgroup_subsys structure
to keep track of the number of CSSes for each of the cgroup subsystems.

As cgroup v2 had deprecated the use of /proc/cgroups, the root
cgroup.stat file is extended to show the number of outstanding CSSes
associated with all the non-inhibited cgroup subsystems that have been
bound to cgroup v2.  This will help us pinpoint which subsystems may be
responsible for the increasing number of dying (nr_dying_descendants)
cgroups.

The cgroup-v2.rst file is updated to discuss this new behavior.

With this patch applied, a sample output from root cgroup.stat file
was shown below.

	nr_descendants 53
	nr_dying_descendants 34
	nr_cpuset 1
	nr_cpu 40
	nr_io 40
	nr_memory 87
	nr_perf_event 54
	nr_hugetlb 1
	nr_pids 53
	nr_rdma 1
	nr_misc 1

In this particular case, it can be seen that memory cgroup is the most
likely culprit for causing the 34 dying cgroups.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++--
 include/linux/cgroup-defs.h             |  3 +++
 kernel/cgroup/cgroup.c                  | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 52763d6b2919..65af2f30196f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -981,6 +981,12 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+	  nr_<cgroup_subsys>
+		Total number of cgroups associated with that cgroup
+		subsystem, e.g. cpuset or memory.  These cgroup counts
+		will only be shown in the root cgroup and for subsystems
+		bound to cgroup v2.
+
   cgroup.freeze
 	A read-write single value file which exists on non-root cgroups.
 	Allowed values are "0" and "1". The default is "0".
@@ -2930,8 +2936,8 @@ Deprecated v1 Core Features
 
 - "cgroup.clone_children" is removed.
 
-- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
-  at the root instead.
+- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
+  "cgroup.stat" files at the root instead.
 
 
 Issues with v1 and Rationales for v2
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b36690ca0d3f..522ab77f0406 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -776,6 +776,9 @@ struct cgroup_subsys {
 	 * specifies the mask of subsystems that this one depends on.
 	 */
 	unsigned int depends_on;
+
+	/* Number of CSSes, used only for /proc/cgroups */
+	atomic_t nr_csses;
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..48eba2737b1a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3669,12 +3669,27 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
 static int cgroup_stat_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct cgroup_subsys *ss;
+	int i;
 
 	seq_printf(seq, "nr_descendants %d\n",
 		   cgroup->nr_descendants);
 	seq_printf(seq, "nr_dying_descendants %d\n",
 		   cgroup->nr_dying_descendants);
 
+	if (cgroup_parent(cgroup))
+		return 0;
+
+	/*
+	 * For the root cgroup, shows the number of csses associated
+	 * with each of non-inhibited cgroup subsystems bound to it.
+	 */
+	do_each_subsys_mask(ss, i, ~cgrp_dfl_inhibit_ss_mask) {
+		if (ss->root != &cgrp_dfl_root)
+			continue;
+		seq_printf(seq, "nr_%s %d\n", ss->name,
+			   atomic_read(&ss->nr_csses));
+	} while_each_subsys_mask();
 	return 0;
 }
 
@@ -5375,6 +5390,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 		int id = css->id;
 
 		ss->css_free(css);
+		atomic_dec(&ss->nr_csses);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
 
@@ -5567,6 +5583,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 	if (IS_ERR(css))
 		return css;
 
+	atomic_inc(&ss->nr_csses);
 	init_and_link_css(css, ss, cgrp);
 
 	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
@@ -6005,6 +6022,8 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	/* Create the root cgroup state for this subsystem */
 	ss->root = &cgrp_dfl_root;
 	css = ss->css_alloc(NULL);
+	atomic_set(&ss->nr_csses, 1);
+
 	/* We don't handle early failures gracefully */
 	BUG_ON(IS_ERR(css));
 	init_and_link_css(css, ss, &cgrp_dfl_root.cgrp);
-- 
2.39.3


