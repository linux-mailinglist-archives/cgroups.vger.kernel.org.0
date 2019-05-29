Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D872E6B4
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 22:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfE2Uzs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 16:55:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39906 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfE2Uzq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 May 2019 16:55:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so4371438qta.6
        for <cgroups@vger.kernel.org>; Wed, 29 May 2019 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lGipepVj2u8Tp/fDWarsFyYov9ji5eADqMS219ioPSw=;
        b=AGTa2aaZw6oFESMv2b1LWJ5n5XMguXBErvIuXHc2rj4tJojqfocI0JawYNLc0S+YAV
         9AOY+H6C3W7MtXfDPw2Q8RSCzOU6bKyRbiryKq0SOEUJ3u4xbvxr2U9i4/g2qRRuCzbG
         myni4kLCcmQ7WJ5OyMO76NgXCm0warOezLhoNppqO37OTuTr+Ju9rXvHNt/JTqLiDdhH
         UXCTq7ilnhsb1DdWPTX5b08w322QJX5kBpZWtetZtPqR8g7mpv2vQwKv0nZ2ZQyBoanz
         poQtmPdtv4JuUBSHbQQcey11b9RBTPcGBIukY8m7qCVgYGLoqLFSZUOxBRqzwAxMXf3M
         RoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=lGipepVj2u8Tp/fDWarsFyYov9ji5eADqMS219ioPSw=;
        b=bJAMQaDMujkoJF5wX6vEQHHSiF1bdinHccfhI2ZVvFjse+NbeGaxCtzc28L0U2wD6t
         gkbplRaITV984GRDYi2G6n+Si3ZrBEKqHFFM/N8rUtm3UZC9DN9Rgld6D8kTKeQvIXOh
         g0iniJqBtw0jtrWX1Zjf9uoKIRvQcP384u74SRfnvhzraelwXXf4mx24AcKTuk5j7t+r
         4otdjJXbW/cq3Oaoz5YzRvdsFeZKLmX4QkYBq6QusdvtrVHu+tVsGLpqcPJ+FA+KtrYj
         RA2tpu+hVxfvLZbg3gmAf1XqLb0Te+X9r4RP2fq9eocVgxfKPhD/oygNCcbcO2YPBBOg
         m/1A==
X-Gm-Message-State: APjAAAVcuyyq+MxpbbvV9JO7tntVku2szKsxmzlGCXEDh9kzoyt8wIlN
        bxsj6zC//QtwS1bjMbBHwNM=
X-Google-Smtp-Source: APXvYqwwguNMdWDzgtgab6X2FfADmRJoKzWd2BNUL0upCBTYIUeskG6ao2awcbP3RHMijJGizNZKeA==
X-Received: by 2002:a0c:8ae9:: with SMTP id 38mr49952qvw.157.1559163345753;
        Wed, 29 May 2019 13:55:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:849f])
        by smtp.gmail.com with ESMTPSA id y19sm321423qty.43.2019.05.29.13.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:55:44 -0700 (PDT)
Date:   Wed, 29 May 2019 13:55:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH cgroup/for-5.2-fixes] cgroup: Use css_tryget() instead of
 css_tryget_online() in task_get_css()
Message-ID: <20190529205542.GO374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Applied the following patch to cgroup/for-5.2-fixes.

Thanks.

------ 8< ------
From 18fa84a2db0e15b02baa5d94bdb5bd509175d2f6 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 29 May 2019 13:46:25 -0700

A PF_EXITING task can stay associated with an offline css.  If such
task calls task_get_css(), it can get stuck indefinitely.  This can be
triggered by BSD process accounting which writes to a file with
PF_EXITING set when racing against memcg disable as in the backtrace
at the end.

After this change, task_get_css() may return a css which was already
offline when the function was called.  None of the existing users are
affected by this change.

  INFO: rcu_sched self-detected stall on CPU
  INFO: rcu_sched detected stalls on CPUs/tasks:
  ...
  NMI backtrace for cpu 0
  ...
  Call Trace:
   <IRQ>
   dump_stack+0x46/0x68
   nmi_cpu_backtrace.cold.2+0x13/0x57
   nmi_trigger_cpumask_backtrace+0xba/0xca
   rcu_dump_cpu_stacks+0x9e/0xce
   rcu_check_callbacks.cold.74+0x2af/0x433
   update_process_times+0x28/0x60
   tick_sched_timer+0x34/0x70
   __hrtimer_run_queues+0xee/0x250
   hrtimer_interrupt+0xf4/0x210
   smp_apic_timer_interrupt+0x56/0x110
   apic_timer_interrupt+0xf/0x20
   </IRQ>
  RIP: 0010:balance_dirty_pages_ratelimited+0x28f/0x3d0
  ...
   btrfs_file_write_iter+0x31b/0x563
   __vfs_write+0xfa/0x140
   __kernel_write+0x4f/0x100
   do_acct_process+0x495/0x580
   acct_process+0xb9/0xdb
   do_exit+0x748/0xa00
   do_group_exit+0x3a/0xa0
   get_signal+0x254/0x560
   do_signal+0x23/0x5c0
   exit_to_usermode_loop+0x5d/0xa0
   prepare_exit_to_usermode+0x53/0x80
   retint_user+0x8/0x8

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org # v4.2+
Fixes: ec438699a9ae ("cgroup, block: implement task_get_css() and use it in bio_associate_current()")
---
 include/linux/cgroup.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c0077adeea83..a7e4611e20c8 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -487,7 +487,7 @@ static inline struct cgroup_subsys_state *task_css(struct task_struct *task,
  *
  * Find the css for the (@task, @subsys_id) combination, increment a
  * reference on and return it.  This function is guaranteed to return a
- * valid css.
+ * valid css.  The returned css may already have been offlined.
  */
 static inline struct cgroup_subsys_state *
 task_get_css(struct task_struct *task, int subsys_id)
@@ -497,7 +497,13 @@ task_get_css(struct task_struct *task, int subsys_id)
 	rcu_read_lock();
 	while (true) {
 		css = task_css(task, subsys_id);
-		if (likely(css_tryget_online(css)))
+		/*
+		 * Can't use css_tryget_online() here.  A task which has
+		 * PF_EXITING set may stay associated with an offline css.
+		 * If such task calls this function, css_tryget_online()
+		 * will keep failing.
+		 */
+		if (likely(css_tryget(css)))
 			break;
 		cpu_relax();
 	}
-- 
2.17.1

