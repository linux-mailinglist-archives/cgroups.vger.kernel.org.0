Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627872127B1
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2020 17:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgGBPWc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jul 2020 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgGBPWb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jul 2020 11:22:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22AC08C5C1
        for <cgroups@vger.kernel.org>; Thu,  2 Jul 2020 08:22:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m7so20790335pgv.12
        for <cgroups@vger.kernel.org>; Thu, 02 Jul 2020 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fvCHMx7ekQRuQtz/ZOAdDgYnmiZwvEUkEXK/eR9Jts4=;
        b=pZubqb6XNvquvfKR87FBbq5Vq+bs6IEZhzmbISTfXpLxbmqp+7PQw1jW29cruGHIvp
         etrXLrT+fa4/fz7tqOAAMxU8ovpL0XoFwnFidDwYzyz/PzCsuBdbHOev2Sl/46Qr9SVe
         jkgdI72PaMDVR7hsWbbUSKpY02rCKqklL9ZMgCXoIhte1timnfpKbYYMnNjLT7OTuoI4
         vG7axFjj/UF6SUcKWefpq7TvsZW9H20v2rJWXxpUcv83dsQV6S+lHWUZJfwzZfedLxmn
         1JoiBWEKaVdB8MHVFp3x2Y+vtqio/oZV9HBvVfHLimPpVAdJSZYBvgezUyP23/lWxi8e
         PsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fvCHMx7ekQRuQtz/ZOAdDgYnmiZwvEUkEXK/eR9Jts4=;
        b=BIoRvpooseZKyzsRsOi+3obIvtMoB+ooinuFJL00/r40uxWZUEGGnubAfXU5kLdGni
         yMrjWhGtsepKKOrzt5n+UUpay1eG4YoJoy8izbFic32e+5/C10dtgwXQlXcVb6cDFvt6
         lJcH1Qd6QdIKcAov+wcNKUlA04vm2JpL6GK3klZCP14IJ/dQbamjYnKuEvQ8qLJqFPnQ
         Nqv645wQW9L7P7NJkvXr5jDolHRdOZs1/2A91cHbLMbc/jp61KBk1zMENPyjlbuQGxpy
         2jKJQMVeC1o2e9JJWPhhQHbqxNhJOTAsxnu+0cAzdlQsi0OcnEFGNMsMrKhLflDzOoB9
         Ft3w==
X-Gm-Message-State: AOAM531n0QmiVLzsozmXl13+DBR+IuwP5Q6S9VzCwviLJ1WFk+SCqmdP
        Dhfndi5Q7UI5tYLOMI3q4O6jns5es1VJ6w==
X-Google-Smtp-Source: ABdhPJwj+md0ZOHNj16pZZFoE29ZHv1GpYL6OT2vN92hgsSm76Jn3lIdj/tbgslrqtBMH90PK/BDBHq9X3/GDg==
X-Received: by 2002:a17:90b:2393:: with SMTP id mr19mr34124195pjb.46.1593703351283;
 Thu, 02 Jul 2020 08:22:31 -0700 (PDT)
Date:   Thu,  2 Jul 2020 08:22:22 -0700
Message-Id: <20200702152222.2630760-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a proposal to expose an interface to the user space to trigger
memory reclaim on a memory cgroup. The proposal contains potential use
cases, benefits of the user space interface and potential implementation
choices.

Use cases:
----------

1) Per-memcg uswapd:

Usually applications consists of combination of latency sensitive and
latency tolerant tasks. For example, tasks serving user requests vs
tasks doing data backup for a database application. At the moment the
kernel does not differentiate between such tasks when the application
hits the memcg limits. So, potentially a latency sensitive user facing
task can get stuck in memory reclaim and be throttled by the kernel.

This problem has been discussed before [1, 2].

One way to resolve this issue is to preemptively trigger the memory
reclaim from a latency tolerant task (uswapd) when the application is
near the limits. (Please note that finding 'near the limits' situation
is an orthogonal problem and we are exploring if per-memcg MemAvailable
notifications can be useful [3]).

2) Proactive reclaim:

This is a similar to the previous use-case, the difference is instead of
waiting for the application to be near its limit to trigger memory
reclaim, continuously pressuring the memcg to reclaim a small amount of
memory. This gives more accurate and uptodate workingset estimation as
the LRUs are continuously sorted and can potentially provide more
deterministic memory overcommit behavior. The memory overcommit
controller can provide more proactive response to the changing workload
of the running applications instead of being reactive.

Benefit of user space solution:
-------------------------------

1) More flexible on who should be charged for the cpu of the memory
reclaim. For proactive reclaim, it makes more sense to centralized the
overhead while for uswapd, it makes more sense for the application to
pay for the cpu of the memory reclaim.

2) More flexible on dedicating the resources (like cpu). The memory
overcommit controller can balance the cost between the cpu usage and
the memory reclaimed.

3) Provides a way to the applications to keep their LRUs sorted, so,
under memory pressure better reclaim candidates are selected.

Interface options:
------------------

1) memcg interface e.g. 'echo 10M > memory.reclaim'

+ simple
+ can be extended to target specific type of memory (anon, file, kmem).
- most probably restricted to cgroup v2.

2) fadvise(PAGEOUT) on cgroup_dir_fd

+ more general and applicable to other FSes (actually we are using
something similar for tmpfs).
+ can be extended in future to just age the LRUs instead of reclaim or
some new use cases.

[Or maybe a new fadvise2() syscall which can take FS specific options.]

[1] https://lwn.net/Articles/753162/
[2] http://lkml.kernel.org/r/20200219181219.54356-1-hannes@cmpxchg.org
[3] http://lkml.kernel.org/r/alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com

The following patch is my attempt to implement the option 2. Please ignore
the fine details as I am more interested in getting the feedback on the
proposal the interface options.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/kernfs/dir.c                 | 20 +++++++++++++++
 include/linux/cgroup-defs.h     |  2 ++
 include/linux/kernfs.h          |  2 ++
 include/uapi/linux/fadvise.h    |  1 +
 kernel/cgroup/cgroup-internal.h |  2 ++
 kernel/cgroup/cgroup-v1.c       |  1 +
 kernel/cgroup/cgroup.c          | 43 +++++++++++++++++++++++++++++++++
 mm/memcontrol.c                 | 20 +++++++++++++++
 8 files changed, 91 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..96b3b67f3a85 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1698,9 +1698,29 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 }
 
+static int kernfs_dir_fadvise(struct file *file, loff_t offset, loff_t len,
+			      int advise)
+{
+	struct kernfs_node *kn  = kernfs_dentry_node(file->f_path.dentry);
+	struct kernfs_syscall_ops *scops = kernfs_root(kn)->syscall_ops;
+	int ret;
+
+	if (!scops || !scops->fadvise)
+		return -EPERM;
+
+	if (!kernfs_get_active(kn))
+		return -ENODEV;
+
+	ret = scops->fadvise(kn, offset, len, advise);
+
+	kernfs_put_active(kn);
+	return ret;
+}
+
 const struct file_operations kernfs_dir_fops = {
 	.read		= generic_read_dir,
 	.iterate_shared	= kernfs_fop_readdir,
 	.release	= kernfs_dir_fop_release,
 	.llseek		= generic_file_llseek,
+	.fadvise	= kernfs_dir_fadvise,
 };
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 52661155f85f..cbe46634875e 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -628,6 +628,8 @@ struct cgroup_subsys {
 	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
 				   struct cgroup_subsys_state *css);
+	int (*css_fadvise)(struct cgroup_subsys_state *css, loff_t offset,
+			   loff_t len, int advise);
 
 	int (*can_attach)(struct cgroup_taskset *tset);
 	void (*cancel_attach)(struct cgroup_taskset *tset);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 89f6a4214a70..3e188b6c3402 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -175,6 +175,8 @@ struct kernfs_syscall_ops {
 		      const char *new_name);
 	int (*show_path)(struct seq_file *sf, struct kernfs_node *kn,
 			 struct kernfs_root *root);
+	int (*fadvise)(struct kernfs_node *kn, loff_t offset, loff_t len,
+		       int advise);
 };
 
 struct kernfs_root {
diff --git a/include/uapi/linux/fadvise.h b/include/uapi/linux/fadvise.h
index 0862b87434c2..302eacc4df44 100644
--- a/include/uapi/linux/fadvise.h
+++ b/include/uapi/linux/fadvise.h
@@ -19,4 +19,5 @@
 #define POSIX_FADV_NOREUSE	5 /* Data will be accessed once.  */
 #endif
 
+#define FADV_PAGEOUT		100 /* Pageout/reclaim pages. */
 #endif	/* FADVISE_H_INCLUDED */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc17a9d..f6077d170112 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -243,6 +243,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode);
 int cgroup_rmdir(struct kernfs_node *kn);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
+int cgroup_fadvise(struct kernfs_node *kn, loff_t offset, loff_t len,
+		   int advise);
 
 int __cgroup_task_count(const struct cgroup *cgrp);
 int cgroup_task_count(const struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 191c329e482a..d5becb618a50 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1094,6 +1094,7 @@ struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,
+	.fadvise		= cgroup_fadvise,
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1ea181a58465..c5c022bde398 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5564,11 +5564,54 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	return ret;
 }
 
+static int cgroup_ss_fadvise(struct cgroup *cgrp, struct cgroup_subsys *ss,
+			     loff_t offset, loff_t len, int advise)
+{
+	struct cgroup_subsys_state *css;
+	int ret;
+
+	if (!ss->css_fadvise)
+		return 0;
+
+	css = cgroup_tryget_css(cgrp, ss);
+	if (!css)
+		return 0;
+
+	ret = ss->css_fadvise(css, offset, len, advise);
+	css_put(css);
+	return ret;
+}
+
+int cgroup_fadvise(struct kernfs_node *kn, loff_t offset, loff_t len,
+		   int advise)
+{
+	struct cgroup *cgrp;
+	struct cgroup_subsys *ss;
+	int ret = 0, ssid;
+
+	if (kernfs_type(kn) != KERNFS_DIR)
+		return 0;
+
+	cgrp = kn->priv;
+	if (!cgroup_tryget(cgrp))
+		return 0;
+
+	for_each_subsys(ss, ssid) {
+		ret = cgroup_ss_fadvise(cgrp, ss, offset, len, advise);
+		if (ret)
+			break;
+	}
+
+	cgroup_put(cgrp);
+	return ret;
+}
+
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.show_options		= cgroup_show_options,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,
+	.fadvise		= cgroup_fadvise,
 };
 
 static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b1a644224383..a38812aa6cde 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -59,6 +59,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/fadvise.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -5369,6 +5370,24 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
 
+static int mem_cgroup_css_fadvise(struct cgroup_subsys_state *css,
+				  loff_t offset, loff_t len, int advise)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	unsigned long nr_pages = page_counter_read(&memcg->memory);
+	unsigned long nr_to_reclaim;
+
+	if (advise != FADV_PAGEOUT || offset <= 0 || len <= 0)
+		return 0;
+
+	nr_to_reclaim = len >> PAGE_SHIFT;
+
+	if (nr_pages >= nr_to_reclaim)
+		try_to_free_mem_cgroup_pages(memcg, nr_to_reclaim, GFP_KERNEL,
+					     true);
+	return 0;
+}
+
 #ifdef CONFIG_MMU
 /* Handlers for move charge at task migration. */
 static int mem_cgroup_do_precharge(unsigned long count)
@@ -6418,6 +6437,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_released = mem_cgroup_css_released,
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
+	.css_fadvise = mem_cgroup_css_fadvise,
 	.can_attach = mem_cgroup_can_attach,
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
-- 
2.27.0.212.ge8ba1cc988-goog

