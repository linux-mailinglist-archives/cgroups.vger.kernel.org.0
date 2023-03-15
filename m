Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041386BB0B6
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjCOMUl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjCOMUN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 08:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D250E1AF
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678882752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgxzsfQSDKWEcDKochbw04bI9bnEC0kJv7FwQRZ5yy0=;
        b=N5MnOEMk27Cd9Mcdg5mvl36XEE28qKz8hZIBqs+vw4kiNtu9cuLMxIScQg2J1mgFH1YJFG
        rCTxR7+RTishFjsP7xtwS6ezRBs6qaVfJ+OYfCFbMWURlwn2qCsAscF1VbCsAGsPAejMhM
        nAa+mVJEli5gwBPYgalNwQdnSEpYd4I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-M55WEreVMQ-ajt8WXzC4Og-1; Wed, 15 Mar 2023 08:19:11 -0400
X-MC-Unique: M55WEreVMQ-ajt8WXzC4Og-1
Received: by mail-qv1-f70.google.com with SMTP id g6-20020ad45426000000b005a33510e95aso7254530qvt.16
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 05:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgxzsfQSDKWEcDKochbw04bI9bnEC0kJv7FwQRZ5yy0=;
        b=Mf0EcKkTZS9dtjyaSkdPo7xUvDTgKMqfDzeaJ1uLP4oiyqqQGRuYhNmuPBIx9qVoGt
         /1Cve4oQhs3gpL4zOQxzzXgR/9PpbIQ/GzLuhAyYkHC9OFIZtW0v750dSkBJlZxbpkZK
         +Zb7rtgtOQ9VOWf/2JmdxBRaFn+OWCjzSP+26n1kkP9CdojfdicJC80F8gz/BYsVsguh
         x52b7c9rgjcuk6Zg70cVUwCT3LyTzWOj7gvJ0nMIjTCvl34OSE2HZoIUQJEOEXRQKmbq
         eolEeyWpOe00Z8gwHBM7SeR5+2sq0hJIcdOPZ6Z2t0/ig7IkXrunFFbPV6k4j7IQdL49
         d5KA==
X-Gm-Message-State: AO0yUKUU4+YQmW3xUGz7o0gRWat4kIyhHnVJm1GW00tG6gQQaecpczV3
        sMKG/JdKyYSpLEKqt5XLV3bsnbkJxtx/LvJrxchafkmhzAzZbKRSltN8WxI4L8TpVVOD2T66pDa
        o2lpKwvb8B2ApkfbrlA==
X-Received: by 2002:ac8:7fc1:0:b0:3bf:b973:3078 with SMTP id b1-20020ac87fc1000000b003bfb9733078mr74469222qtk.13.1678882749785;
        Wed, 15 Mar 2023 05:19:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+/wStHq1rXJJw0yYzUIy3bNydpf3AKFTqXM2HUyMGI/0vx+gHZYLe3UMWwBwuE5JsQH3PJPg==
X-Received: by 2002:ac8:7fc1:0:b0:3bf:b973:3078 with SMTP id b1-20020ac87fc1000000b003bfb9733078mr74469175qtk.13.1678882749503;
        Wed, 15 Mar 2023 05:19:09 -0700 (PDT)
Received: from localhost.localdomain.com ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8014b000000b003bd21323c80sm3672595qtg.11.2023.03.15.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:19:09 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks in cpusets
Date:   Wed, 15 Mar 2023 12:18:11 +0000
Message-Id: <20230315121812.206079-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315121812.206079-1-juri.lelli@redhat.com>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h |  4 ++++
 kernel/cgroup/cgroup.c |  4 ++++
 kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
 kernel/sched/core.c    | 10 ++++++++++
 4 files changed, 43 insertions(+)

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
index c099cf3fa02d..357925e1e4af 100644
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
index 8d82d66d432b..57bc60112618 100644
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
@@ -2472,6 +2492,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5902cbb5e751..d586a8440348 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7683,6 +7683,16 @@ static int __sched_setscheduler(struct task_struct *p,
 		goto unlock;
 	}
 
+	/*
+	 * In case a task is setscheduled to SCHED_DEADLINE, or if a task is
+	 * moved to a different sched policy, we need to keep track of that on
+	 * its cpuset (for correct bandwidth tracking).
+	 */
+	if (dl_policy(policy) && !dl_task(p))
+		inc_dl_tasks_cs(p);
+	else if (dl_task(p) && !dl_policy(policy))
+		dec_dl_tasks_cs(p);
+
 	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
-- 
2.39.2

