Return-Path: <cgroups+bounces-2172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595488CAC0
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 18:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ECCB23D0A
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814A1CFA0;
	Tue, 26 Mar 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdiCl3vq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B51CD30
	for <cgroups@vger.kernel.org>; Tue, 26 Mar 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473985; cv=none; b=u3Xl4gQiY+r6AtfoKHvQToDiAyM4e+xQ7bTQ74FLDABkUjVC+JjsQhDb+hfZDFzSmVO7hID7z1dxGhdw9Zte6S062yuimDD8wyqHdSKzEK1IPKaP4yHt8Fg4DOC40eKFh94K3vKDQMrBbcMNEin48oTL2/WzvjZgXuXTsRkwID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473985; c=relaxed/simple;
	bh=231sOgOjYRYKR4/1G/mFoB8TwrkVUS74HDdf1Cm89DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teyevfgbR+dH6TcUoilphok7U1w5MR4yv9BsYD9XZR7gGeZCMwq7PwLShYO8/SuccAfcegNHEStk8eHqlcMlvTM1hFrHmecbRnuK5ilOY0ax/2OhPB6K/LgX4TkZ4CtZtYXF+bqGMzdSNMZk/uSLOBRqu9D6NryX9YAIvkJbb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdiCl3vq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0189323b4so44665015ad.1
        for <cgroups@vger.kernel.org>; Tue, 26 Mar 2024 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711473983; x=1712078783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ym7SqthJT0G4e4E1tr5HwPb0B7bvcxbP/psYJ4cnNQ=;
        b=FdiCl3vqp9pwNal9nU0rQCRsDI86215oMIIdPrJMYuSr9y16zKV/qSwgtkoqF6eA7d
         fAeWR3j6qHimxujzXPJkHrvz2DvVF2BL2+9HZMr+xkwlLx/hn9zeRvqULV7NBZqXxY4X
         qJFXkOxIZksb7b07fUWYp3/Qr0RkGr3JmS+qes3+k2ooUgvxITwNE2dc2PMukW+9h703
         vmRlsmeWSB8ueBvwLbC5zgoQCOPzltkawR3TPTr2NmQrRavkERhqcsJ4iTyfGav7IWqS
         c19SlysiNTu6++mwDiRYia9Mkbl1KxQN40LpilyIALIbbmNIISMDffRFRESRIsYgf0Kl
         ssUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473983; x=1712078783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ym7SqthJT0G4e4E1tr5HwPb0B7bvcxbP/psYJ4cnNQ=;
        b=HNNJN6A96AL5UhNH9UhHeogTPG7bUUKpZBii8QS8zirLeTTNkQPw5J/Et6BOH8ms0f
         CknLsGzBcm1YmzXyckwmDY9f4vACZelK7zhf6QS2Kw3IWdOvZ4vUBk5gZtm1VcyrmwXo
         sTPxF6Sv+a65tQV0iqeG5RiAyVTG9AcD/eoJ8F+rRfFTgueX6BBFKQMrkcTU5sognu/y
         2xVjBJgDhm/V4KGV3t25KDZcbu1gDvSCdKj4xJ1VKp8jmdegqPOwX2N5foN5DQWKP54v
         V6YU49AkqjQSyFldPPJoYMwiS2/ch8F4Iy/WeO1KzsCAwPPHzWc10M+ZOyPgWa4jo6pq
         +SGw==
X-Gm-Message-State: AOJu0YwtuCYCqITEB580fnBbFyTCYpHrm0fbw0N8S6npcgMGt5VmrJzl
	QFUWMrJW6NHk+Y31W/Is0yWhsHQx22/kJHWB+ZcGo3hCG90JvZ4T
X-Google-Smtp-Source: AGHT+IHtKkDBzzRkb+u2ico1X6zkdlG1X5aLWU2JMimBhYKMUIexL4P+29Z8CbO2nU+W0ua1jtr14w==
X-Received: by 2002:a17:902:f545:b0:1e1:214:1b67 with SMTP id h5-20020a170902f54500b001e102141b67mr260378plf.37.1711473982691;
        Tue, 26 Mar 2024 10:26:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:29ff])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902db1000b001e0b2851db7sm5396699plx.105.2024.03.26.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:26:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 26 Mar 2024 07:26:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: cgroups@vger.kernel.org, longman@redhat.com, tj@kernel.orgv,
	hughd@google.com, wuyun.abel@bytedance.com,
	hezhongkun.hzk@bytedance.com, chenying.kernel@bytedance.com,
	zhanghaoyu.zhy@bytedance.com
Subject: Re: [problem] Hung task caused by memory migration when cpuset.mems
 changes
Message-ID: <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
References: <20240325144609.983333-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325144609.983333-1-zhouchuyi@bytedance.com>

Hello,

On Mon, Mar 25, 2024 at 10:46:09PM +0800, Chuyi Zhou wrote:
> In our production environment, we have observed several cases of hung tasks
> blocked on the cgroup_mutex. The underlying cause is that when user modify
> the cpuset.mems, memory migration operations are performed in the
> work_queue. However, the duration of these operations depends on the memory
> size of workloads and can consume a significant amount of time.
> 
> In the __cgroup_procs_write operation, there is a flush_workqueue operation
> that waits for the migration to complete while holding the cgroup_mutex.
> As a result, most cgroup-related operations have the potential to
> experience blocking.
> 
> We have noticed the commit "cgroup/cpuset: Enable memory migration for
> cpuset v2"[1]. This commit enforces memory migration when modifying the
> cpuset. Furthermore, in cgroup v2, there is no option available for
> users to disable CS_MEMORY_MIGRATE.
> 
> In our scenario, we do need to perform memory migration when cpuset.mems
> changes, while ensuring that other tasks are not blocked on cgroup_mutex
> for an extended period of time.
> 
> One feasible approach is to revert the commit "cgroup/cpuset: Enable memory
> migration for cpuset v2"[1]. This way, modifying cpuset.mems will not
> trigger memory migration, and we can manually perform memory migration
> using migrate_pages()/move_pages() syscalls.
> 
> Another solution is to use a lazy approach for memory migration[2]. In
> this way we only walk through all the pages and sets pages to protnone,
> and numa faults triggered by later touch will handle the movement. That
> would significantly reduce the time spent in cpuset_migrate_mm_workfn.
> But MPOL_MF_LAZY was disabled by commit 2cafb582173f ("mempolicy: remove
> confusing MPOL_MF_LAZY dead code")

One approach we can take is pushing the cpuset_migrate_mm_wq flushing to
task_work so that it happens after cpuset mutex is dropped. That way we
maintain the operation synchronicity for the issuer while avoiding bothering
anyone else.

Can you see whether the following patch fixes the issue for you? Thanks.

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..8a8bd3f157ab 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -42,6 +42,7 @@
 #include <linux/spinlock.h>
 #include <linux/oom.h>
 #include <linux/sched/isolation.h>
+#include <linux/task_work.h>
 #include <linux/cgroup.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -2696,6 +2697,26 @@ static void cpuset_migrate_mm_workfn(struct work_struct *work)
 	kfree(mwork);
 }
 
+static void flush_migrate_mm_task_workfn(struct callback_head *head)
+{
+	flush_workqueue(cpuset_migrate_mm_wq);
+}
+
+static int schedule_flush_migrate_mm(void)
+{
+	struct callback_head *flush_cb;
+
+	flush_cb = kzalloc(sizeof(*flush_cb), GFP_KERNEL);
+	if (!flush_cb)
+		return -ENOMEM;
+
+	flush_cb->func = flush_migrate_mm_task_workfn;
+	if (task_work_add(current, flush_cb, TWA_RESUME))
+		kfree(flush_cb);
+
+	return 0;
+}
+
 static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
 							const nodemask_t *to)
 {
@@ -2718,11 +2739,6 @@ static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
 	}
 }
 
-static void cpuset_post_attach(void)
-{
-	flush_workqueue(cpuset_migrate_mm_wq);
-}
-
 /*
  * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
  * @tsk: the task to change
@@ -3276,6 +3292,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	bool cpus_updated, mems_updated;
 	int ret;
 
+	ret = schedule_flush_migrate_mm();
+	if (ret)
+		return ret;
+
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	oldcs = cpuset_attach_old_cs;
@@ -3584,7 +3604,11 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 {
 	struct cpuset *cs = css_cs(of_css(of));
 	struct cpuset *trialcs;
-	int retval = -ENODEV;
+	int retval;
+
+	retval = schedule_flush_migrate_mm();
+	if (retval)
+		return retval;
 
 	buf = strstrip(buf);
 
@@ -3613,8 +3637,10 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
-	if (!is_cpuset_online(cs))
+	if (!is_cpuset_online(cs)) {
+		retval = -ENODEV;
 		goto out_unlock;
+	}
 
 	trialcs = alloc_trial_cpuset(cs);
 	if (!trialcs) {
@@ -3643,7 +3669,6 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	cpus_read_unlock();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
-	flush_workqueue(cpuset_migrate_mm_wq);
 	return retval ?: nbytes;
 }
 
@@ -4283,7 +4308,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 	.can_attach	= cpuset_can_attach,
 	.cancel_attach	= cpuset_cancel_attach,
 	.attach		= cpuset_attach,
-	.post_attach	= cpuset_post_attach,
 	.bind		= cpuset_bind,
 	.can_fork	= cpuset_can_fork,
 	.cancel_fork	= cpuset_cancel_fork,

-- 
tejun

