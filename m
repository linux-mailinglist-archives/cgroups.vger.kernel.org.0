Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F859593
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfF1IGi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 04:06:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF1IGi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 04:06:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so8117569wme.4
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 01:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8yrjFRKlFsxVAR2E0++WqOpY0GWxGblducHQHkY1HEY=;
        b=tu+PMwacWd6QonNVlMtGCZw3ICZvDtH4bQe5Dk1bnse0pK9gqGOZK9GBW70PUbliyg
         Dg2TfYsBTQsM47JisFjiJfbvzVjChr4TUQpwoDMn4KoQosxHyf/uBOcwrHdbLbD6Orby
         r93l+IkHOcUcijn3InoWpaGq7AvQmexC6i2cF+cg4+PbTmPThQCGK0QIR5t/Uoe3vjJV
         HewQw0yG2U3hmoLoCYPb0F+2IVwGZqy+stvZ1pa7VVvOEaZ0IoSIjQhomGTBypkeAEgK
         KMkoMA4qInDZ23fq8huSJy6rigMBzs0V8ASimspv6KUgANXBlGr9lqgKG6NLsCXilip6
         xTBQ==
X-Gm-Message-State: APjAAAVtgfbV94StnDLobjbVLqJbENaTkDh9OhjviRjH/0Ia9T9gkBi/
        sb7xMYyblkrcxq0kzp35SFFwLQ==
X-Google-Smtp-Source: APXvYqwRK7CZkRc1vo47CIwxpUN6JR3FHX2gIXsNzQ4RyfUPc9tghM7/usCJxedDw/AXj9aWA8luMQ==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr6147993wmc.176.1561709195943;
        Fri, 28 Jun 2019 01:06:35 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:35 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v8 1/8] sched/topology: Adding function partition_sched_domains_locked()
Date:   Fri, 28 Jun 2019 10:06:11 +0200
Message-Id: <20190628080618.522-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190628080618.522-1-juri.lelli@redhat.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Introducing function partition_sched_domains_locked() by taking
the mutex locking code out of the original function.  That way
the work done by partition_sched_domains_locked() can be reused
without dropping the mutex lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/topology.c        | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index cfc0a89a7159..d7166f8c0215 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -161,6 +161,10 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void partition_sched_domains_locked(int ndoms_new,
+					   cpumask_var_t doms_new[],
+					   struct sched_domain_attr *dattr_new);
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -213,6 +217,12 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 
 struct sched_domain_attr;
 
+static inline void
+partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+			       struct sched_domain_attr *dattr_new)
+{
+}
+
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f53f89df837d..362c383ec4bd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2159,16 +2159,16 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  * ndoms_new == 0 is a special case for destroying existing domains,
  * and it will not create the default domain.
  *
- * Call with hotplug lock held
+ * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
 	int i, j, n;
 	int new_topology;
 
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -2251,6 +2251,15 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
-- 
2.17.2

