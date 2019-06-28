Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30423595A1
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfF1IHD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 04:07:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33830 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfF1IGo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 04:06:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so5269703wrl.1
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 01:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TOSEYwTQZU+8YMFaWDDlqE3RS7Uyb+pCfC/yU4MwW18=;
        b=FW9w5ac+nmhp4FHPVKSJ0IXMKz/bQ7h7kKBFN5TLCBe0SC9hpB0e96okUY1SHZuRdc
         Ymm7n09g00nSoBKvvt4sQ0hbYgTwxp9hBzAy7NYA0ZXmztmCe4zBbML+68UGcJ47p23G
         Mz0/p3b8oTwS/xx/p8bdFArIK/uV5BOZHJg6o79NV+FDbKTF8VfnKaWkbY/abOW30TE/
         nUcDiDBTQG7SPF+U91xO7NBqCSOQhQZAYNR/tVyDN8LJVTDOy0SDzUs/WgwCELby4MkQ
         Tgg3Z6JC60dHq9bf5ODh0g1siJbD4WKGGlSDxLsHfYCGaIjth4SlcElEnpazLnUzoCxC
         kGog==
X-Gm-Message-State: APjAAAUu2suGkCZ9TlCQcdqsqdcghFnJZGq/F0tlAalJyBvJESd8y2eO
        X8yc4k9/3ZhGPvraSD1ApErLKw==
X-Google-Smtp-Source: APXvYqyAQ4xskoM7YESfIYCE9+XR+K9FGolVBsAJkB0pCM005CDb8Xp0LhnOtH+Qn6U/KxQlaPvv0A==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr284223wrl.155.1561709201276;
        Fri, 28 Jun 2019 01:06:41 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:40 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v8 5/8] cgroup/cpuset: convert cpuset_mutex to percpu_rwsem
Date:   Fri, 28 Jun 2019 10:06:15 +0200
Message-Id: <20190628080618.522-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190628080618.522-1-juri.lelli@redhat.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Holding cpuset_mutex means that cpusets are stable (only the holder can
make changes) and this is required for fixing a synchronization issue
between cpusets and scheduler core.  However, grabbing cpuset_mutex from
setscheduler() hotpath (as implemented in a later patch) is a no-go, as
it would create a bottleneck for tasks concurrently calling
setscheduler().

Convert cpuset_mutex to be a percpu_rwsem (cpuset_rwsem), so that
setscheduler() will then be able to read lock it and avoid concurrency
issues.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 68 ++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 48d29a6112cb..a7c0c8d8f132 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -333,7 +333,7 @@ static struct cpuset top_cpuset = {
  * guidelines for accessing subsystem state in kernel/cgroup.c
  */
 
-static DEFINE_MUTEX(cpuset_mutex);
+DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
 static DEFINE_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
@@ -966,7 +966,7 @@ static void rebuild_root_domains(void)
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
 
-	lockdep_assert_held(&cpuset_mutex);
+	percpu_rwsem_assert_held(&cpuset_rwsem);
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -1026,7 +1026,7 @@ static void rebuild_sched_domains_locked(void)
 	cpumask_var_t *doms;
 	int ndoms;
 
-	lockdep_assert_held(&cpuset_mutex);
+	percpu_rwsem_assert_held(&cpuset_rwsem);
 	get_online_cpus();
 
 	/*
@@ -1058,9 +1058,9 @@ static void rebuild_sched_domains_locked(void)
 
 void rebuild_sched_domains(void)
 {
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	rebuild_sched_domains_locked();
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /**
@@ -1166,7 +1166,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
 	bool part_error = false;	/* Partition error? */
 
-	lockdep_assert_held(&cpuset_mutex);
+	percpu_rwsem_assert_held(&cpuset_rwsem);
 
 	/*
 	 * The parent must be a partition root.
@@ -2154,7 +2154,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_read(&cpuset_rwsem);
 
 	/* allow moving tasks into an empty cpuset if on default hierarchy */
 	ret = -ENOSPC;
@@ -2178,7 +2178,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs->attach_in_progress++;
 	ret = 0;
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_read(&cpuset_rwsem);
 	return ret;
 }
 
@@ -2188,9 +2188,9 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_first(tset, &css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_read(&cpuset_rwsem);
 	css_cs(css)->attach_in_progress--;
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_read(&cpuset_rwsem);
 }
 
 /*
@@ -2213,7 +2213,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	/* prepare for attach */
 	if (cs == &top_cpuset)
@@ -2267,7 +2267,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /* The various types of files and directories in a cpuset file system */
@@ -2298,7 +2298,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -2334,7 +2334,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	return retval;
 }
 
@@ -2345,7 +2345,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2358,7 +2358,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	return retval;
 }
 
@@ -2397,7 +2397,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	kernfs_break_active_protection(of->kn);
 	flush_work(&cpuset_hotplug_work);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2421,7 +2421,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
@@ -2552,13 +2552,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		return -EINVAL;
 
 	css_get(&cs->css);
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
 	retval = update_prstate(cs, val);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	css_put(&cs->css);
 	return retval ?: nbytes;
 }
@@ -2764,7 +2764,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
@@ -2815,7 +2815,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	return 0;
 }
 
@@ -2834,7 +2834,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	if (is_partition_root(cs))
 		update_prstate(cs, 0);
@@ -2853,7 +2853,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
@@ -2865,7 +2865,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
@@ -2878,7 +2878,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 	}
 
 	spin_unlock_irq(&callback_lock);
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /*
@@ -2922,6 +2922,8 @@ int __init cpuset_init(void)
 {
 	int err = 0;
 
+	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
+
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
@@ -2997,7 +2999,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
@@ -3007,7 +3009,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	if (is_empty)
 		remove_tasks_in_empty_cpuset(cs);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 }
 
 static void
@@ -3057,14 +3059,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	/*
 	 * We have raced with task attaching. We wait until attaching
 	 * is finished, so we won't attach a task to an empty cpuset.
 	 */
 	if (cs->attach_in_progress) {
-		mutex_unlock(&cpuset_mutex);
+		percpu_up_write(&cpuset_rwsem);
 		goto retry;
 	}
 
@@ -3132,7 +3134,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /**
@@ -3162,7 +3164,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
@@ -3212,7 +3214,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		update_tasks_nodemask(&top_cpuset);
 	}
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 
 	/* if cpus or mems changed, we need to propagate to descendants */
 	if (cpus_updated || mems_updated) {
-- 
2.17.2

