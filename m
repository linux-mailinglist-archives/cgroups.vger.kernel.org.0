Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC56CD9CA
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjC2M65 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjC2M64 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 08:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2901BFF
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680094655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+tcCpHoOz8e5BKcWtXtUbqlaYi7I1AwPgxgJKpvzd4=;
        b=bJOy1WK2fsp9544pdH7jJadQMXLaYGBaVORyqbH5lpLXFTi1s5YSR2gzsRN3do5sQZUd0p
        RopLEn8RzEtsRXHb+7CYl7zE/g6hOKSj5IqfqvHTVosfwm1LuDIP94MQRbjhCogT/hljRs
        JdyjlRq7iO6d0ovklMM5oASkJ+mOYcE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-E02AldomNhO98QuY0AwGXA-1; Wed, 29 Mar 2023 08:56:42 -0400
X-MC-Unique: E02AldomNhO98QuY0AwGXA-1
Received: by mail-qt1-f199.google.com with SMTP id v10-20020a05622a130a00b003e4ee70e001so4207713qtk.6
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+tcCpHoOz8e5BKcWtXtUbqlaYi7I1AwPgxgJKpvzd4=;
        b=FA5aCONztMScJY1bJnEg08DBOS1iOXum4PbFFMBMKP5fIWd22PAbgqCyw4dp+LGtOr
         Scz6rjzd4ObvYZfn6Ni455yqJ3AtZcBLHIUu0DwZsFqNwoOqzDumbwj+8dB93ABXYGUw
         +Gk5RO54V6qKUXjPOdzq22OcykJ6UY0qEtTKk8EoG2ekYCfA3x6kSo8m1XilfzpTKugo
         WoVzdjE+F2iRm2Ta+P9iU+NRUPol9jh/boZAchE4lyWNdf1hV2WiepBYF11ff6F1h8As
         U6PZ4fRsDE/2i7ybFGYZ5zy71bnUcM2x4jaJTwCAs+cY4WM027FOykP418Wg8uMvQRkV
         iJvw==
X-Gm-Message-State: AAQBX9fK3m/4+227JU532iecMJTGPBFJhd7grpTTAgQUAm+MlQ4YDKtJ
        26UHfbJZgFmH6dnmc1VMZsfkXX/muO9hOT4f9CJnWtuVlAG1biffD8CVA3zVcwBH5milP0crgW5
        Ah4MKP7W9Czh8jj9bMw==
X-Received: by 2002:a05:6214:1c8d:b0:5df:466f:9edc with SMTP id ib13-20020a0562141c8d00b005df466f9edcmr8412286qvb.22.1680094592823;
        Wed, 29 Mar 2023 05:56:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z1Sl6LFOn/BaeDPuoXqwznc7+9dI6+sBZGfPRBKiEimotSo5nQZJyb2S09U6E9M7cyMCzZCA==
X-Received: by 2002:a05:6214:1c8d:b0:5df:466f:9edc with SMTP id ib13-20020a0562141c8d00b005df466f9edcmr8412238qvb.22.1680094592489;
        Wed, 29 Mar 2023 05:56:32 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b007436d0e9408sm13527134qke.127.2023.03.29.05.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:56:32 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 3/6] sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
Date:   Wed, 29 Mar 2023 14:55:55 +0200
Message-Id: <20230329125558.255239-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Qais reported that iterating over all tasks when rebuilding root domains
for finding out which ones are DEADLINE and need their bandwidth
correctly restored on such root domains can be a costly operation (10+
ms delays on suspend-resume).

To fix the problem keep track of the number of DEADLINE tasks belonging
to each cpuset and then use this information (followup patch) to only
perform the above iteration if DEADLINE tasks are actually present in
the cpuset for which a corresponding root domain is being rebuilt.

Reported-by: Qais Yousef <qyousef@layalina.io>
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h  |  4 ++++
 kernel/cgroup/cgroup.c  |  4 ++++
 kernel/cgroup/cpuset.c  | 25 +++++++++++++++++++++++++
 kernel/sched/deadline.c | 14 ++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 355f796c5f07..0348dba5680e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -71,6 +71,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void inc_dl_tasks_cs(struct task_struct *task);
+extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
@@ -196,6 +198,8 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void inc_dl_tasks_cs(struct task_struct *task) { }
+static inline void dec_dl_tasks_cs(struct task_struct *task) { }
 static inline void cpuset_lock(void) { }
 static inline void cpuset_unlock(void) { }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..ff27b2d2bf0b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -57,6 +57,7 @@
 #include <linux/file.h>
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/deadline.h>
 #include <linux/psi.h>
 #include <net/sock.h>
 
@@ -6673,6 +6674,9 @@ void cgroup_exit(struct task_struct *tsk)
 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 	cset->nr_tasks--;
 
+	if (dl_task(tsk))
+		dec_dl_tasks_cs(tsk);
+
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
 	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fbc10b494292..eb0854ef9757 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -193,6 +193,12 @@ struct cpuset {
 	int use_parent_ecpus;
 	int child_ecpus_count;
 
+	/*
+	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
+	 * know when to rebuild associated root domain bandwidth information.
+	 */
+	int nr_deadline_tasks;
+
 	/* Invalid partition error code, not lock protected */
 	enum prs_errcode prs_err;
 
@@ -245,6 +251,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
+void inc_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks++;
+}
+
+void dec_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks--;
+}
+
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
@@ -2477,6 +2497,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
+
+		if (dl_task(task)) {
+			cs->nr_deadline_tasks++;
+			cpuset_attach_old_cs->nr_deadline_tasks--;
+		}
 	}
 
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4cc7e1ca066d..8f92f0f87383 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,8 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 
+#include <linux/cpuset.h>
+
 /*
  * Default limits for DL period; on the top end we guard against small util
  * tasks still getting ridiculously long effective runtimes, on the bottom end we
@@ -2595,6 +2597,12 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
+	/*
+	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
+	 * keep track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	dec_dl_tasks_cs(p);
+
 	if (!task_on_rq_queued(p)) {
 		/*
 		 * Inactive timer is armed. However, p is leaving DEADLINE and
@@ -2635,6 +2643,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 		put_task_struct(p);
 
+	/*
+	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
+	 * track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	inc_dl_tasks_cs(p);
+
 	/* If p is not queued we will update its parameters at next wakeup. */
 	if (!task_on_rq_queued(p)) {
 		add_rq_bw(&p->dl, &rq->dl);
-- 
2.39.2

