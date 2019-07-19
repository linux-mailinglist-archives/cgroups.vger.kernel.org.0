Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4929A6E70A
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfGSOAi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 10:00:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39621 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbfGSOAh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 10:00:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so32349453wrt.6
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2019 07:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEnO8M8EBFWP7FMl3HHTOAuUC3PoWINzgxFrtc73J0k=;
        b=eZuSqTBq4eq2OqJjf0BNv4afcFLZD21XE1QRx8O6XSdD1IT1Scs/NqxVI/LFxhPF0j
         vTFj7D+KSuThbcC7s6IjeYIELJakaOxZ3SW335un8c2yikCxRYLDVTiSpxBYW9dKd1Cv
         tmPyjnwFEqai/xVv108++a51tqmRrRpz2tkf3ijSVjgtZb8TEr123vfuHJ2zILVjj8VR
         r4rutJN/qwmFPZWMXrRRKYL0duVqT+AVomhdUSvzKPD2XQBjkL7CqNRJyMq1LLoA4yZj
         HweTX2GZcW5gmofGHE4gVDUsgwB6K3nukLOcDEE5GeSxj25v7S9LeIoXymV/iMsVqBpb
         Vgow==
X-Gm-Message-State: APjAAAWCpsMkO30EZ3Ovs4TLCrNNN6BY6NcdGJz/QfmyFzQXV0PL4ofo
        YDUuGgdZkbYcrRkgbP2LSPS3Kw==
X-Google-Smtp-Source: APXvYqyYuazD407y/OnmGsXK78pyk/N+Ie2sWVQNb2hoP7KPo19pr40MwtYAtFQvQhyUHxPC+b2yMw==
X-Received: by 2002:a5d:48cf:: with SMTP id p15mr5977966wrs.151.1563544834868;
        Fri, 19 Jul 2019 07:00:34 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:34 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v9 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
Date:   Fri, 19 Jul 2019 15:59:58 +0200
Message-Id: <20190719140000.31694-7-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cpuset_rwsem is going to be acquired from sched_setscheduler() with a
following patch. There are however paths (e.g., spawn_ksoftirqd) in
which sched_scheduler() is eventually called while holding hotplug lock;
this creates a dependecy between hotplug lock (to be always acquired
first) and cpuset_rwsem (to be always acquired after hotplug lock).

Fix paths which currently take the two locks in the wrong order (after
a following patch is applied).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h |  8 ++++----
 kernel/cgroup/cpuset.c | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 934633a05d20..7f1478c26a33 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -40,14 +40,14 @@ static inline bool cpusets_enabled(void)
 
 static inline void cpuset_inc(void)
 {
-	static_branch_inc(&cpusets_pre_enable_key);
-	static_branch_inc(&cpusets_enabled_key);
+	static_branch_inc_cpuslocked(&cpusets_pre_enable_key);
+	static_branch_inc_cpuslocked(&cpusets_enabled_key);
 }
 
 static inline void cpuset_dec(void)
 {
-	static_branch_dec(&cpusets_enabled_key);
-	static_branch_dec(&cpusets_pre_enable_key);
+	static_branch_dec_cpuslocked(&cpusets_enabled_key);
+	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
 }
 
 extern int cpuset_init(void);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 85491d09f3d3..93414ea63252 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1026,8 +1026,8 @@ static void rebuild_sched_domains_locked(void)
 	cpumask_var_t *doms;
 	int ndoms;
 
+	lockdep_assert_cpus_held();
 	percpu_rwsem_assert_held(&cpuset_rwsem);
-	get_online_cpus();
 
 	/*
 	 * We have raced with CPU hotplug. Don't do anything to avoid
@@ -1036,19 +1036,17 @@ static void rebuild_sched_domains_locked(void)
 	 */
 	if (!top_cpuset.nr_subparts_cpus &&
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
-		goto out;
+		return;
 
 	if (top_cpuset.nr_subparts_cpus &&
 	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
-		goto out;
+		return;
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
 	partition_and_rebuild_sched_domains(ndoms, doms, attr);
-out:
-	put_online_cpus();
 }
 #else /* !CONFIG_SMP */
 static void rebuild_sched_domains_locked(void)
@@ -1058,9 +1056,11 @@ static void rebuild_sched_domains_locked(void)
 
 void rebuild_sched_domains(void)
 {
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	rebuild_sched_domains_locked();
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 }
 
 /**
@@ -2298,6 +2298,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
@@ -2335,6 +2336,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return retval;
 }
 
@@ -2345,6 +2347,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2359,6 +2362,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return retval;
 }
 
@@ -2397,6 +2401,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	kernfs_break_active_protection(of->kn);
 	flush_work(&cpuset_hotplug_work);
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2422,6 +2427,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	free_cpuset(trialcs);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
@@ -2552,6 +2558,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		return -EINVAL;
 
 	css_get(&cs->css);
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2559,6 +2566,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	retval = update_prstate(cs, val);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	css_put(&cs->css);
 	return retval ?: nbytes;
 }
@@ -2764,6 +2772,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 
 	set_bit(CS_ONLINE, &cs->flags);
@@ -2816,6 +2825,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	spin_unlock_irq(&callback_lock);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return 0;
 }
 
@@ -2834,6 +2844,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 
 	if (is_partition_root(cs))
@@ -2854,6 +2865,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	clear_bit(CS_ONLINE, &cs->flags);
 
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
-- 
2.17.2

