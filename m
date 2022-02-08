Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9A4AE343
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 23:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiBHWVj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 17:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386197AbiBHTnl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 14:43:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47AC0613CB;
        Tue,  8 Feb 2022 11:43:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z13so302851pfa.3;
        Tue, 08 Feb 2022 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ufb8JerL9tDT7g1v4aJC4XJXyEpEyj9Y7QxoUEiNuQM=;
        b=l8GUnslAu32x2n2gXuW8E6fzALxUMJ0TwywQoY3fKUoNyKJBqq58O/62kH0swgU77u
         DbHskTdVQLu0Tdr9fEJ2kCUH9L/S//grixVe8rw4M3vpH1XFpXDTqUJYyKMEILKF1MkG
         hNgLMNVINDbz/fRhL7lq0u7gY3Q1eRgLlyHbu5XWBWVJD7moK9FcLDHoF21NtVZMRtp5
         wWo93xO3wzaNO8NKVWPxd2UX00xbuNMSUxt45F9VVuVGAAxCzn4Ya+E2pjQbOiAsQzlG
         YHCeOJSR/NtzKWhs/gvZ0VKN22ynW8TsN+SOc0Ur0FgHjnIbTvjt2eQHzwWd/JDEO7iN
         CgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ufb8JerL9tDT7g1v4aJC4XJXyEpEyj9Y7QxoUEiNuQM=;
        b=csvpIatJnEJoQKMXVojIT0mD9sQV1EC8REOW0yI1irlbsKUgmKxHOnP6kW5P/uW3Ct
         a6wu3mKHUxOK9GubuUfkbyTyVD9/WX/BeUGNYI7AQSeNDTpXH1MbVKW4gCOq1aH7b0Bw
         TmhIANCAo/A0te++7j4IsOSpyUJBn9smV0v+RAyStbMiG7xr6hSMUvRAag+BjD1wadSk
         vrji/mTSfaSUw0ID3vZISlS2znIYGz6b7pom3OjzIs9vVxg1mMHAsCJUgVue5hDddeOZ
         I2vUQw0Q2TxJzVtAo5HBx95h9aSj/Lec6jiURvefH/2HcIWQuQgJzWIr1BKV6sVRDn7y
         A/ig==
X-Gm-Message-State: AOAM530j0J9Uio0fbfmev4RML+gxc9a3O0b5tcumNhhh404s1KMW4ln3
        sLMhXRkUkd3mRFG4yGpkRbQ=
X-Google-Smtp-Source: ABdhPJwrwivlWofm2UOfe8OdlqbFVCbp5LnU7jaGnUKTctny/cMMRUv76SfiAeYangOlGnt5tOCHAw==
X-Received: by 2002:a65:4d0d:: with SMTP id i13mr4696818pgt.483.1644349420393;
        Tue, 08 Feb 2022 11:43:40 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:39 -0800 (PST)
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/12] cgroup: rstat: Make cgroup_rstat_cpu_lock name readable
Date:   Tue,  8 Feb 2022 11:43:14 -0800
Message-Id: <20220208194324.85333-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
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

Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/cgroup/rstat.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9d331ba44870..371f54a59c38 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -286,9 +286,17 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 void __init cgroup_rstat_boot(void)
 {
 	int cpu;
+	raw_spinlock_t *cgrp_rstat_cpu_lock;
 
-	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+	for_each_possible_cpu(cpu) {
+		/*
+		 * raw_spin_lock_init() uses the argument to name the lock in
+		 * lockdep results.  Passing per_cpu_ptr() directly created a
+		 * cryptic name as the macro was expanded before stringified.
+		 */
+		cgrp_rstat_cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+		raw_spin_lock_init(cgrp_rstat_cpu_lock);
+	}
 }
 
 /*
-- 
2.35.0.263.gb82422642f-goog

