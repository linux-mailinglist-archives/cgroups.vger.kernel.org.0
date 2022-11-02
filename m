Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF962615748
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 03:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKBCEq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiKBCEi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 22:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FF660CA
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 19:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667354625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMSAt3GthE2zWUBTJjLiVIVQICwCKfwnNgpg1Ix0oWM=;
        b=VTYqX+oBfJTKfIr/hUEjVrAwQ5eU1flJmRBcaqpCDAKndBHpTohSyN9M/xdqQPVsW0W1n9
        sR6WEXNoTSgFCFsSuzry8kmWI1ObrPUQvEohVE1R1FdBJT3vmbpLjYTNA7xHTolSyUqLP/
        rvl5DBdMR/Df5t2j3mPMmdGk5H0+X0U=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-340-Z_Ba2IRzNYyAklvT-Iv7Bg-1; Tue, 01 Nov 2022 22:03:44 -0400
X-MC-Unique: Z_Ba2IRzNYyAklvT-Iv7Bg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13b6f7d8bf4so8114701fac.7
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 19:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMSAt3GthE2zWUBTJjLiVIVQICwCKfwnNgpg1Ix0oWM=;
        b=MGy33s4il+3w/0d+89tS15ydHRuCoB3T8KVVdVOdQ7XH8zGrJKt8r37D9zoAFLkBfF
         VaZRKY97pEvCWHZIgUhScxembfNQcY7D/Eam7Gntx/uLDDnUF/U0W8PZnaHuqLI6LDHi
         cEkeKgR+irY/zMyKH/XEHPqlb4qkEYxV2IbzmOLekZ2OXKQLS6X4kJb+JM7ob4oJpbhN
         uyjdiCGYXkTQJ458tz1FALYCuKpqLvh1FXLwliduJ7ixFJRQ84x14kiVm2RctY5Y2YbR
         syz5dE+ahGOfausgKfp0qH5CjU//RqqF7qN4ei6dlD1zpdI2Fqeb3aT5ssAQgfP7+Riq
         wlgw==
X-Gm-Message-State: ACrzQf3a/XCN75Vwm/KlPxjVhJKOBOGWZevaoY00OYu/db56yTmcgu+L
        tydUObTTEloK7VzUJx7ePv2MU67e8pt9Z0cVr5oyUelcYmZcN88npjbEvJ0qRDwtGvyA3CT0I6I
        UWNZ0mlLSLE6ENqp7lQ==
X-Received: by 2002:a05:6870:d250:b0:13b:3100:abcc with SMTP id h16-20020a056870d25000b0013b3100abccmr13089108oac.3.1667354624055;
        Tue, 01 Nov 2022 19:03:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zv2uj8jD1EUkakgeYhALybaybY7reFpZn0f4powVIbb55KSIq40hrRxQHM4RpX4sgR1KnYw==
X-Received: by 2002:a05:6870:d250:b0:13b:3100:abcc with SMTP id h16-20020a056870d25000b0013b3100abccmr13089090oac.3.1667354623748;
        Tue, 01 Nov 2022 19:03:43 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:1099:7cb2:3a49:6197:5307])
        by smtp.gmail.com with ESMTPSA id h15-20020a9d6f8f000000b00665919f7823sm4526624otq.8.2022.11.01.19.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:03:43 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 1/3] =?UTF-8?q?sched/isolation:=20Add=20housekeep=C3=AD?= =?UTF-8?q?ng=5Fany=5Fcpu=5Ffrom()?=
Date:   Tue,  1 Nov 2022 23:02:41 -0300
Message-Id: <20221102020243.522358-2-leobras@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102020243.522358-1-leobras@redhat.com>
References: <20221102020243.522358-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As of today, there is a function called housekeepíng_any_cpu() that
returns a housekeeping cpu near the current one. This function is very
useful to help delegate tasks to other cpus when the current one is
isolated.

It also comes with the benefit of looking for cpus in the same NUMA node
as the current cpu, so any memory activity could be faster in NUMA systems.

On the other hand, there is no function like that to find housekeeping cpus
in the same NUMA node of another CPU.

Change housekeepíng_any_cpu() into housekeepíng_any_cpu_from(), so it
accepts a cpu_start parameter and can find cpus in the same NUMA node as
any given CPU.

Also, reimplements housekeepíng_any_cpu() as an inline function that calls
housekeepíng_any_cpu_from() with cpu_start = current cpu.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/sched/isolation.h | 11 ++++++++---
 kernel/sched/isolation.c        |  8 ++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 8c15abd67aed9..95b65be44f19f 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -20,7 +20,7 @@ enum hk_type {
 
 #ifdef CONFIG_CPU_ISOLATION
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
-extern int housekeeping_any_cpu(enum hk_type type);
+extern int housekeeping_any_cpu_from(enum hk_type type, int cpu_start);
 extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
@@ -29,9 +29,9 @@ extern void __init housekeeping_init(void);
 
 #else
 
-static inline int housekeeping_any_cpu(enum hk_type type)
+static inline int housekeeping_any_cpu_from(enum hk_type type, int cpu_start)
 {
-	return smp_processor_id();
+	return cpu_start;
 }
 
 static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
@@ -58,4 +58,9 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 	return true;
 }
 
+static inline int housekeeping_any_cpu(enum hk_type type)
+{
+	return housekeeping_any_cpu_from(type, smp_processor_id());
+}
+
 #endif /* _LINUX_SCHED_ISOLATION_H */
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc5..6ebeac11bb350 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -36,22 +36,22 @@ bool housekeeping_enabled(enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
-int housekeeping_any_cpu(enum hk_type type)
+int housekeeping_any_cpu_from(enum hk_type type, int cpu_start)
 {
 	int cpu;
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
 		if (housekeeping.flags & BIT(type)) {
-			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
+			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], cpu_start);
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
 			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
 		}
 	}
-	return smp_processor_id();
+	return cpu_start;
 }
-EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
+EXPORT_SYMBOL_GPL(housekeeping_any_cpu_from);
 
 const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
-- 
2.38.1

