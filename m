Return-Path: <cgroups+bounces-2960-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFC28C95A8
	for <lists+cgroups@lfdr.de>; Sun, 19 May 2024 19:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16EE1C20ED1
	for <lists+cgroups@lfdr.de>; Sun, 19 May 2024 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9751C49;
	Sun, 19 May 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wg9+zWz8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E054DA1F
	for <cgroups@vger.kernel.org>; Sun, 19 May 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716140833; cv=none; b=KsBEuhm2G3IQngfnhazJkrqmPINSoUZkWGM4MZoK+w0AG22OGpqisC1j+zdf/zYVsblsF6IAHJMKv1/Ak8EJQbn/kSQWZl6YCm2vmmOyjmRQf6yhubE6zigBb2G7DAW8+S7jVZoEmimVWWzldzwruoN+44cez+uRGnZgiXHocpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716140833; c=relaxed/simple;
	bh=myeE3XBIP2ogQpDASkBLoktTJIKPRWi5o4H6xIR1cnY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YRvH99aM4gToqFh0dNvkjtJ8kyoWt0+s+yHuLZ2wutytuKxnCnmTvNkqWR21Tzv5nJPM0m8faJ8KgErq57rBrFXXATzcCRPYNNVMZbxE1h7d4VQaWA8Q74vhxYXHm7dWkNDdHrii/BRrSnPs4t6lHmyJCuoCqSymZJveBsSmNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wg9+zWz8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dee8315174dso14327660276.0
        for <cgroups@vger.kernel.org>; Sun, 19 May 2024 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716140830; x=1716745630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MxyPPkoyb/v1Xne3FZ/GVon/lPLE77xcyrrXPBy+OCs=;
        b=Wg9+zWz8Phj8rGeihP9ZmlThaCerTWGwuBNe6erRKpHD9roiJYcZPvautUJ1UhLK5U
         7jdDXdEGi+MHHBy9ofLc9EZPj9BtRAP+IuR3Me+dVeFN3jAZyx+hrSsX6oiiVypAUVbc
         uRzS978iWZY2CjFIvgmcLIOG9/tPG100umeQaNvyaOVn6vn5zQa5ZT1s9qkI+U1VXoLA
         Iyu6ZG46BQlQyVLq6ZZHlhSyfTovm5EqeLYksVfqHWqtQAlRENi20BDFIYh5Not4usxE
         vyeXrrVOJHHBH4/gQHQfiZ5+5s69rRx+VEgke/ONPlEC6/8w7IcT6WE4gBk9k9Exnv/d
         L8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716140830; x=1716745630;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxyPPkoyb/v1Xne3FZ/GVon/lPLE77xcyrrXPBy+OCs=;
        b=vQFIyWzmre0opC1wSKrQg/2wu418Kbs7pg6v0oDkGbTN+PmE2pokRGlhGofEcbk1uh
         ZZl8CzhHynshIJ3DTMyHmkOCKQ8WWeWSmorlX/J6Qzy2usBtBuFJoy1z7+QzFCpYuJVH
         z4CxfANrx9X5ULOFktE80fGaV13vIzzF48g26K1U9MuT8tbVb6BKCvUxT/cUrr/IPhJz
         g3MGJdjrj4geOE3Molwk7T5xCmPtab5NEF2HvaUp0DFquwszX15ZvAMb71K7V3pL/P4Q
         S6W5WlEZ8LNBhhWVXTQpeBPqWZhGC9UQVejhA8RAU8n1Pxt6tvRkC1O8UDrm5Wl3mYAo
         lJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0Q+L2pjHfht6cARQb7pxNfZdGgsZ+Ox108Z7vNw9jwJfQAfosDDB0isf0ns3IoeM8lHNBJnLmymqYWzBPWC//diYEyvdXpg==
X-Gm-Message-State: AOJu0YwhirnpGoq1s/k6b9+RZmmZ/zhk0DL5V9daY+5Tcw5Gf9mb2qeF
	cPk0l4u2w5wFLiTnylrxCr4Xd7SWkeDa4qEOGXdcHV/zFx5UEhMcGbdlIy8uq3Nwvz/RmPm2aGK
	YGM3ZGKO6VkHznQ==
X-Google-Smtp-Source: AGHT+IHT8sDGPigxr7FKHw6oIx0bTcsFvuCkPczlxcIrNezaHNHMldcSmu36Fnmq8zyuYkZ3A+DQbfeCn2NHlVk=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a25:b18f:0:b0:de6:569:325c with SMTP id
 3f1490d57ef6-df490711195mr1058902276.4.1716140830204; Sun, 19 May 2024
 10:47:10 -0700 (PDT)
Date: Sun, 19 May 2024 17:46:48 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240519174650.559538-1-tjmercier@google.com>
Subject: [RFC] cgroup: Fix /proc/cgroups count for v2
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Cc: shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The /proc/cgroups documentation says that the num_cgroups value is,
"the number of control groups in this hierarchy using this controller."

The value printed is simply the total number of cgroups in the hierarchy
which is correct for v1, but not for the shared v2 hierarchy.

Consider:
controllers="cpuset cpu io memory hugetlb pids rdma misc"
for c in $controllers
do
  echo +$c > /sys/fs/cgroup/cgroup.subtree_control
  mkdir /sys/fs/cgroup/$c
  echo +$c > /sys/fs/cgroup/$c/cgroup.subtree_control
  for i in `seq 100`; do mkdir /sys/fs/cgroup/$c/$i; done
done
cat /proc/cgroups

#subsys_name	hierarchy	num_cgroups	enabled
cpuset	0	809	1
cpu	0	809	1
cpuacct	0	809	1
blkio	0	809	1
memory	0	809	1
devices	0	809	1
freezer	0	809	1
net_cls	0	809	1
perf_event	0	809	1
net_prio	0	809	1
hugetlb	0	809	1
pids	0	809	1
rdma	0	809	1
misc	0	809	1
debug	0	809	1

A count of 809 is reported for each controller, but only 109 should be
reported for most of them since each controller is enabled in only part
of the hierarchy. (Note that io depends on memcg, so its count should be
209.)

The number of cgroups using a controller is an important metric since
kernel memory is used for each cgroup, and some kernel operations scale
with the number of cgroups for some controllers (memory, io). So users
have an interest in minimizing/tracking the number of them.

- - - - - - - - - -

Why is this functional patch currently a RFC:
The point at which the new counters are incremented/decremented for most
enumerated v2 controllers works fine. However for some controllers (the
v2 documentation calls them "utility controllers") online_css and
kill_css are never called: cpuacct, devices, freezer, net_cls, net_prio,
debug.

To deal with num_cgroups being reported as 1 for those utility
controllers regardless of the number of cgroups that exist and support
their use, I added is_v2_utility_controller which checks if a controller
is among a hardcoded list instead of looking at some property of the
cgroup_subsys since I don't think any such property currently exists.
It'd be easy to miss adding a new utility controller to this list, so
I am interested in hearing if folks have other ideas. I checked if I
could use the presence of online_css in cgroup_subsys, but that only
works for cpuacct and debug.
---
 include/linux/cgroup-defs.h |  6 ++++++
 kernel/cgroup/cgroup-v1.c   | 36 ++++++++++++++++++++++++++++++++++--
 kernel/cgroup/cgroup.c      |  4 ++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ea48c861cd36..400311222337 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -579,6 +579,12 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
+	/*
+	 * Number of cgroups using each controller. Includes online and zombies.
+	 * Used only for v2 controllers in /proc/cgroups.
+	 */
+	atomic_t nr_css[CGROUP_SUBSYS_COUNT];
+
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 520a11cb12f4..8146bcc31421 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -663,6 +663,30 @@ struct cftype cgroup1_base_files[] = {
 	{ }	/* terminate */
 };
 
+static bool is_v2_utility_controller(int ssid)
+{
+	return
+#ifdef CONFIG_CGROUP_CPUACCT
+		ssid == cpuacct_cgrp_id ||
+#endif
+#ifdef CONFIG_CGROUP_DEVICE
+		ssid == devices_cgrp_id ||
+#endif
+#ifdef CONFIG_CGROUP_FREEZER
+		ssid == freezer_cgrp_id ||
+#endif
+#ifdef CONFIG_NET_CLS_CGROUP
+		ssid == net_cls_cgrp_id ||
+#endif
+#ifdef CONFIG_CGROUP_NET_PRIO
+		ssid == net_prio_cgrp_id ||
+#endif
+#ifdef CONFIG_CGROUP_DEBUG
+		ssid == debug_cgrp_id ||
+#endif
+		false;
+}
+
 /* Display information about each subsystem and each hierarchy */
 int proc_cgroupstats_show(struct seq_file *m, void *v)
 {
@@ -675,11 +699,19 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 * cgroup_mutex contention.
 	 */
 
-	for_each_subsys(ss, i)
+	for_each_subsys(ss, i) {
+		int count;
+
+		if (!cgroup_on_dfl(&ss->root->cgrp) || is_v2_utility_controller(i))
+			count = atomic_read(&ss->root->nr_cgrps);
+		else
+			count = atomic_read(&ss->root->nr_css[i]);
+
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
-			   atomic_read(&ss->root->nr_cgrps),
+			   count,
 			   cgroup_ssid_enabled(i));
+	}
 
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..f25d0e77ae8a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2047,6 +2047,8 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 
 	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
+	for (int i = 0; i < CGROUP_SUBSYS_COUNT; ++i)
+		atomic_set(&root->nr_css[i], 0);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
@@ -5362,6 +5364,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
+		atomic_dec(&ss->root->nr_css[ss->id]);
 
 		if (parent)
 			css_put(parent);
@@ -5503,6 +5506,7 @@ static int online_css(struct cgroup_subsys_state *css)
 		atomic_inc(&css->online_cnt);
 		if (css->parent)
 			atomic_inc(&css->parent->online_cnt);
+		atomic_inc(&ss->root->nr_css[ss->id]);
 	}
 	return ret;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


