Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EAD3DEFFB
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhHCORj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbhHCOR1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 10:17:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D051C061799;
        Tue,  3 Aug 2021 07:17:13 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp7gi69XNNgEmtaHo/BkgdaOmbU6gfKgVITw3Sb4bDo=;
        b=pZuEAiATXelgJB7kY7qWD2cbi4f8LLoQhrpHKJfrIKv5+3a8xbrg2ZLf0++/FzO5s7ofti
        7xKbu318U9CR0xRUdB8yaB/72Ln39xSKN3rjpvVYLh7fVLlY9LD5qS0ggNZlAqHE0cbeZs
        biNbyeIgyISIr74cDb07sjxQ7N4xqe0TIygG9FkfLwk52YDdKG4gjmm7fJsunFNw4c/k/x
        Kq6xDnvP7aPTxYYc4ao95OOKOeX11UYy5uh2AkHCUcyd2Z9h/xHhuEAGDMl9zxeyELCHjR
        TAT3GqG5sU26q8uHYBKzz6r7nCODPoXg+z1rGtiy1HQmxuYBAkmfizFx8pDEIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp7gi69XNNgEmtaHo/BkgdaOmbU6gfKgVITw3Sb4bDo=;
        b=kKKvn84SpRZSnRr1Sy/iC/LQy1hcruUhzHKsLiGRfWQZjbw47NUHCs5uHOSeJdk69+w56v
        QTP/s6X/q8RG7oDg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 24/38] cgroup: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:07 +0200
Message-Id: <20210803141621.780504-25-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cgroup/cpuset.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190c44296..bd2b998249e8b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -979,7 +979,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpum=
ask_var_t doms_new[],
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
  *
- * Call with cpuset_mutex held.  Takes get_online_cpus().
+ * Call with cpuset_mutex held.  Takes cpus_read_lock().
  */
 static void rebuild_sched_domains_locked(void)
 {
@@ -1040,11 +1040,11 @@ static void rebuild_sched_domains_locked(void)
=20
 void rebuild_sched_domains(void)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 	rebuild_sched_domains_locked();
 	percpu_up_write(&cpuset_rwsem);
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 /**
@@ -2282,7 +2282,7 @@ static int cpuset_write_u64(struct cgroup_subsys_stat=
e *css, struct cftype *cft,
 	cpuset_filetype_t type =3D cft->private;
 	int retval =3D 0;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs)) {
 		retval =3D -ENODEV;
@@ -2320,7 +2320,7 @@ static int cpuset_write_u64(struct cgroup_subsys_stat=
e *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
-	put_online_cpus();
+	cpus_read_unlock();
 	return retval;
 }
=20
@@ -2331,7 +2331,7 @@ static int cpuset_write_s64(struct cgroup_subsys_stat=
e *css, struct cftype *cft,
 	cpuset_filetype_t type =3D cft->private;
 	int retval =3D -ENODEV;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2346,7 +2346,7 @@ static int cpuset_write_s64(struct cgroup_subsys_stat=
e *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
-	put_online_cpus();
+	cpus_read_unlock();
 	return retval;
 }
=20
@@ -2385,7 +2385,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_ope=
n_file *of,
 	kernfs_break_active_protection(of->kn);
 	flush_work(&cpuset_hotplug_work);
=20
-	get_online_cpus();
+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2411,7 +2411,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_ope=
n_file *of,
 	free_cpuset(trialcs);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
-	put_online_cpus();
+	cpus_read_unlock();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
@@ -2542,7 +2542,7 @@ static ssize_t sched_partition_write(struct kernfs_op=
en_file *of, char *buf,
 		return -EINVAL;
=20
 	css_get(&cs->css);
-	get_online_cpus();
+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2550,7 +2550,7 @@ static ssize_t sched_partition_write(struct kernfs_op=
en_file *of, char *buf,
 	retval =3D update_prstate(cs, val);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
-	put_online_cpus();
+	cpus_read_unlock();
 	css_put(&cs->css);
 	return retval ?: nbytes;
 }
@@ -2756,7 +2756,7 @@ static int cpuset_css_online(struct cgroup_subsys_sta=
te *css)
 	if (!parent)
 		return 0;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
=20
 	set_bit(CS_ONLINE, &cs->flags);
@@ -2809,7 +2809,7 @@ static int cpuset_css_online(struct cgroup_subsys_sta=
te *css)
 	spin_unlock_irq(&callback_lock);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
-	put_online_cpus();
+	cpus_read_unlock();
 	return 0;
 }
=20
@@ -2828,7 +2828,7 @@ static void cpuset_css_offline(struct cgroup_subsys_s=
tate *css)
 {
 	struct cpuset *cs =3D css_cs(css);
=20
-	get_online_cpus();
+	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
=20
 	if (is_partition_root(cs))
@@ -2849,7 +2849,7 @@ static void cpuset_css_offline(struct cgroup_subsys_s=
tate *css)
 	clear_bit(CS_ONLINE, &cs->flags);
=20
 	percpu_up_write(&cpuset_rwsem);
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static void cpuset_css_free(struct cgroup_subsys_state *css)
--=20
2.32.0

