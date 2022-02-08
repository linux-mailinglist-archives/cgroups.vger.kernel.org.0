Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BBA4AE114
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 19:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385156AbiBHSm0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 13:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385146AbiBHSmT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 13:42:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8095C0612C3;
        Tue,  8 Feb 2022 10:42:17 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso2105924pjg.0;
        Tue, 08 Feb 2022 10:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DVqQIGXek9gqjDYZ5x5feEwzLs2GJZs4gUa7i+kzwxU=;
        b=eZkvb8+7UyFnR21L5G1zcGI8qmb7Z6a9FPI1whMSBLG+SQouRtRGXHvgWofofksj4X
         gZB5sFr6ghXQvJW/Qq3wOP/ubVYRVVqZWpEXOJmHLHA+9yVi2iic/bTxbCgLKsYFNUWx
         nWOGj1PItndZXy9CxHYxkoPIZYgXs+AvTDgCbI5hEiHLb/9u/ASKrijJAysQub7y88RG
         FMA3a1+KBL0mqLyGYcIfSihA58L1nbkquzmiHjIu9u28yKitN1sxuU6vO4J9BW61CWiX
         1gvLzqO7GENqtEdf8SQH8I9Z6MeL3HfDxjye5PqXcFHWOAn5lm2GV0kMVKD8KMbkYT/q
         pwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DVqQIGXek9gqjDYZ5x5feEwzLs2GJZs4gUa7i+kzwxU=;
        b=QEzwdvk1lVt9FjghcctL+1QZHRinBTR8kAjnaN6x7kbm6JQIbh968JAVLQahrbsdv4
         q2jjAPfYYLU/I0lnutC/UUK1D0euVn4fG+nSi22WPU6FfYmMGN7zUChbZUxXYoQ38btF
         21YfoBvSnTtLAACnTPzzo1eHN78v9kfMpwp2vg2sBZURkkf0MpiEqmN98neNGdW46T8A
         00PGXUuVNci6JbLcAlPE7Ce6XgUQ8fXCysGx4VPeNQE5t6kiXQBK1mp81R1hdwRSPJ84
         LLfOVAj6CwGzU5qsov9sMVJKS4Fn1UElKqMfB35ILqGXBjqsvi0ACRMynIODYxTAbHG/
         rLIA==
X-Gm-Message-State: AOAM532y7BOlvAlkN0hAQLFL/YS4hOdcgPhTDkjigRnrIST91gE/PUeq
        zPmZkq6uD4YHd7kKFFSDqLs=
X-Google-Smtp-Source: ABdhPJwsjxQ3u2LpAw1F/tqKqnFKbzNVq4Q+hoDFw5+tcDW6bW7HXozAs0DUWSMEaDvFGixXm0DrNg==
X-Received: by 2002:a17:903:20ca:: with SMTP id i10mr6101929plb.112.1644345737400;
        Tue, 08 Feb 2022 10:42:17 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id l14sm3517027pjf.1.2022.02.08.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:42:16 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 02/12] cgroup: rstat: Make cgroup_rstat_cpu_lock name readable
Date:   Tue,  8 Feb 2022 10:41:58 -0800
Message-Id: <20220208184208.79303-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The raw_spin_lock_init() uses the argument to name its lockdep map.
But passing per_cpu_ptr() macro directly makes it a very very long
name as it expanded like below:

  ({ do { const void *__vpp_verify = (typeof((&cgroup_rstat_cpu_lock) ...

Let's fix it by passing a local variable instead.  With this change,
the name now looks like:

  cgrp_rstat_cpu_lock

Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/cgroup/rstat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9d331ba44870..d1845f1196c9 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -286,9 +286,12 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 void __init cgroup_rstat_boot(void)
 {
 	int cpu;
+	raw_spinlock_t *cgrp_rstat_cpu_lock;
 
-	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+	for_each_possible_cpu(cpu) {
+		cgrp_rstat_cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+		raw_spin_lock_init(cgrp_rstat_cpu_lock);
+	}
 }
 
 /*
-- 
2.35.0.263.gb82422642f-goog

