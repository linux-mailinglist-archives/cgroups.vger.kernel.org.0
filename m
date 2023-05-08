Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39A6FA1D4
	for <lists+cgroups@lfdr.de>; Mon,  8 May 2023 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjEHIBm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 May 2023 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjEHIAb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 May 2023 04:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C472156B
        for <cgroups@vger.kernel.org>; Mon,  8 May 2023 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683532759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTly/dq6nflZ7NNnQHSKsbObWzSa+OiTyAm+yiHs0cM=;
        b=dW/Dgz7IYeeTRIJmWAZ5BYekFuBhL3crHsYiyXwcQMJ84l9FyNjbKJlkspGmnDALoNB+Po
        /6GvMKmZwBfUrYuhoGskNjZMXAQAmw5jGvnBwmY6KAlzpfkMI+aRWzHuiOznVK0pjnWXp0
        MQr4g0bhGeJ8ixpYdCmZT0xCV5HcN+o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-UZDOAbqGOj-JAXrNaLp0pg-1; Mon, 08 May 2023 03:59:18 -0400
X-MC-Unique: UZDOAbqGOj-JAXrNaLp0pg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f315735edeso105295475e9.1
        for <cgroups@vger.kernel.org>; Mon, 08 May 2023 00:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532757; x=1686124757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTly/dq6nflZ7NNnQHSKsbObWzSa+OiTyAm+yiHs0cM=;
        b=TheYIaN/RdNFbnp8yBH8C/OaLTjdGbF2PyNZ9TURx7AMykrop5jWgZONGUGl68zwm+
         jYExKY80zjy+rB+rl5zXw3tL0M96NM6eyTFcIr0hIPJKTOoIuJxVrSXfcPgQMqG2ftUS
         slhlK8kYlyunPIBWKQ1g7EFs1KE/6ri63XAni5eeTDKI+M7KkhjsGqgRy7dhN6pE7RE2
         KRcRh2XgNZLy4fG9YGI2hzETUeM/6vf4gBw1AnotqXAr+zjLs8snSGKpZ7c1aV8Iz6kJ
         05+ZjsAyK6P6cGA/GVSHBafQgM2gOuQ+S+jYwr+cByM2F5/z+Lm3A2AFFmO64AMFdeNg
         McPQ==
X-Gm-Message-State: AC+VfDzvkMDa73kwKgyC+k6DwLpCkWIyYlFVPS4Y0oMH21YOfuZPg8uo
        kP95ZmZOnrxh5JqmMUHHAt2lVcIsagcoOI2uc/oMaFZ5ro9rwnEJj0kKNrqF+zFxkrdy2t78I/y
        WSpEgFxGeqaH1zOA1rA==
X-Received: by 2002:adf:ea82:0:b0:307:7d12:9bc9 with SMTP id s2-20020adfea82000000b003077d129bc9mr6905503wrm.21.1683532756798;
        Mon, 08 May 2023 00:59:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72oqmWaz+HH8uisYuEukmeyO8qPh3BQ397yy+v4IT4CxgMzrYBYigEy0MPXlDjQswqJ+l4wg==
X-Received: by 2002:adf:ea82:0:b0:307:7d12:9bc9 with SMTP id s2-20020adfea82000000b003077d129bc9mr6905490wrm.21.1683532756432;
        Mon, 08 May 2023 00:59:16 -0700 (PDT)
Received: from localhost.localdomain.com ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm250423wmj.23.2023.05.08.00.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:59:16 -0700 (PDT)
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
Subject: [PATCH v3 5/6] sched/deadline: Create DL BW alloc, free & check overflow interface
Date:   Mon,  8 May 2023 09:58:53 +0200
Message-Id: <20230508075854.17215-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508075854.17215-1-juri.lelli@redhat.com>
References: <20230508075854.17215-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

While moving a set of tasks between exclusive cpusets,
cpuset_can_attach() -> task_can_attach() calls dl_cpu_busy(..., p) for
DL BW overflow checking and per-task DL BW allocation on the destination
root_domain for the DL tasks in this set.

This approach has the issue of not freeing already allocated DL BW in
the following error cases:

(1) The set of tasks includes multiple DL tasks and DL BW overflow
    checking fails for one of the subsequent DL tasks.

(2) Another controller next to the cpuset controller which is attached
    to the same cgroup fails in its can_attach().

To address this problem rework dl_cpu_busy():

(1) Split it into dl_bw_check_overflow() & dl_bw_alloc() and add a
    dedicated dl_bw_free().

(2) dl_bw_alloc() & dl_bw_free() take a `u64 dl_bw` parameter instead of
    a `struct task_struct *p` used in dl_cpu_busy(). This allows to
    allocate DL BW for a set of tasks too rather than only for a single
    task.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched.h   |  2 ++
 kernel/sched/core.c     |  4 ++--
 kernel/sched/deadline.c | 53 +++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h    |  2 +-
 4 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..0bee06542450 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1853,6 +1853,8 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int dl_bw_alloc(int cpu, u64 dl_bw);
+extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d826bec1c522..df659892d7d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9319,7 +9319,7 @@ int task_can_attach(struct task_struct *p,
 
 		if (unlikely(cpu >= nr_cpu_ids))
 			return -EINVAL;
-		ret = dl_cpu_busy(cpu, p);
+		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
 	}
 
 out:
@@ -9604,7 +9604,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_cpu_busy(cpu, NULL);
+		int ret = dl_bw_check_overflow(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e11de074a6fd..166c3e6eae61 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3058,26 +3058,38 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int dl_cpu_busy(int cpu, struct task_struct *p)
+enum dl_bw_request {
+	dl_bw_req_check_overflow = 0,
+	dl_bw_req_alloc,
+	dl_bw_req_free
+};
+
+static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags, cap;
+	unsigned long flags;
 	struct dl_bw *dl_b;
-	bool overflow;
+	bool overflow = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cap = dl_bw_capacity(cpu);
-	overflow = __dl_overflow(dl_b, cap, 0, p ? p->dl.dl_bw : 0);
 
-	if (!overflow && p) {
-		/*
-		 * We reserve space for this task in the destination
-		 * root_domain, as we can't fail after this point.
-		 * We will free resources in the source root_domain
-		 * later on (see set_cpus_allowed_dl()).
-		 */
-		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
+	if (req == dl_bw_req_free) {
+		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
+	} else {
+		unsigned long cap = dl_bw_capacity(cpu);
+
+		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
+
+		if (req == dl_bw_req_alloc && !overflow) {
+			/*
+			 * We reserve space in the destination
+			 * root_domain, as we can't fail after this point.
+			 * We will free resources in the source root_domain
+			 * later on (see set_cpus_allowed_dl()).
+			 */
+			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
+		}
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -3085,6 +3097,21 @@ int dl_cpu_busy(int cpu, struct task_struct *p)
 
 	return overflow ? -EBUSY : 0;
 }
+
+int dl_bw_check_overflow(int cpu)
+{
+	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+}
+
+int dl_bw_alloc(int cpu, u64 dl_bw)
+{
+	return dl_bw_manage(dl_bw_req_alloc, cpu, dl_bw);
+}
+
+void dl_bw_free(int cpu, u64 dl_bw)
+{
+	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
+}
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..0ad712811e35 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -330,7 +330,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_cpu_busy(int cpu, struct task_struct *p);
+extern int  dl_bw_check_overflow(int cpu);
 
 #ifdef CONFIG_CGROUP_SCHED
 
-- 
2.40.1

