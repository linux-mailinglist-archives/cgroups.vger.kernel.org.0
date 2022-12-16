Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9626564F52F
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 00:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiLPXf2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 18:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLPXfJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 18:35:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C9A72610
        for <cgroups@vger.kernel.org>; Fri, 16 Dec 2022 15:35:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso2815713wmp.3
        for <cgroups@vger.kernel.org>; Fri, 16 Dec 2022 15:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0VtzC74LzR2drrGRcJjmM7+tpdFp4NU23zKURKWjt4=;
        b=gfzD/GKB7u5dlxmxEaH6dLYg6YiMvLoKLMxgIkMoYyeq8S3M3btEvu7gt8MXbWzZQa
         G6GWiXE1LS463y8W7c+a+8TF5sjpiYS1ywoBTty38GltUXu05+DWuenht2Ws/g8TvmNe
         iyqheFyZquS57ZRuN+238btFfCxOGFaP6xtKQvuIZQM7dyu262r+ICz2EdaTOkqOsUvd
         mEBFXa8jyLZeeBRo8UenQzbQSrLrGhXEOu+pLOfwZQZIuxwUoLHeco8xLOg03ZSVQVgR
         2B0MKR+nQJO/RifdfQ51o4Jz8gbV7gamHgytNu5OdbfBwQEGy62XkdaDwqRwDUB8XiCI
         e+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0VtzC74LzR2drrGRcJjmM7+tpdFp4NU23zKURKWjt4=;
        b=ZyLxx4JEQu0FbeNGKChurKh7gPdNIVqy6hsiXIggSKsGE5f742kPdMLuzJouLzrMf+
         eItb7ApSKmuZ6cakTPl2AZjxHkBov5NOmZsqeHMiOw3lGzoSBMueC9PlWKeEbGnRGdkK
         C5GVouGtD6nnN+SoAhC886JSvsNSHkU1GZIGGUkmG0jy4iZkMxr5MUOuKrZuOCjcUtJg
         clFG+l1oB9VvF56ZNDWOJwoppL6ilR12xFywYMp/iQD8E+tsQdqpGG90KMzdymHTZHjS
         kCGQfLcSdyGGJ/ULSx0P0o9Ec0xICgxQ20CBTdKbLyyb8DRlBiZRg4TA8Kz0tzKXbWiT
         2JrA==
X-Gm-Message-State: AFqh2kpa9gFnvy9n1wRmUnCnM+Ge1hRk7mOWOWxsXqscrZz5mJ+i8hTb
        axxstPAQy7oYFGBjK2sbyVaHrg==
X-Google-Smtp-Source: AMrXdXvFvrAx2wjFerv1hrGW9YLwPEWJ+CnrtJ/yL2ZcStDyiRN/YTr3lukNz8P7mAoYsh/kYqITOw==
X-Received: by 2002:a05:600c:601b:b0:3d3:4cbf:3a51 with SMTP id az27-20020a05600c601b00b003d34cbf3a51mr40341wmb.14.1671233703215;
        Fri, 16 Dec 2022 15:35:03 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05600c1e0e00b003cfd4a50d5asm11026391wmb.34.2022.12.16.15.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:35:02 -0800 (PST)
Date:   Fri, 16 Dec 2022 23:35:01 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        dietmar.eggemann@arm.com, cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20221216233501.gh6m75e7s66dmjgo@airbuntu>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190719140000.31694-4-juri.lelli@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

On 07/19/19 15:59, Juri Lelli wrote:
> When the topology of root domains is modified by CPUset or CPUhotplug
> operations information about the current deadline bandwidth held in the
> root domain is lost.
> 
> This patch addresses the issue by recalculating the lost deadline
> bandwidth information by circling through the deadline tasks held in
> CPUsets and adding their current load to the root domain they are
> associated with.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---

We see that rebuild_root_domain() can take 10+ ms (I get a max of 20ms quite
consistently) on suspend/resume.

Do we actually need to rebuild_root_domain() if we're going through
a suspend/resume cycle?

ie: would something like the below make sense? We'd skip this logic if
cpuhp_tasks_frozen is set which indicates it's not a real hotplug operation but
we're suspending/resuming.


Cheers

--
Qais Yousef


--->8---


From 4cfd50960ad872c5eb810ad3038eaf840bab5182 Mon Sep 17 00:00:00 2001
From: Qais Yousef <qyousef@layalina.io>
Date: Tue, 29 Nov 2022 19:01:52 +0000
Subject: [PATCH] sched: cpuset: Don't rebuild sched domains on suspend-resume

Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
enabled rebuilding sched domain on cpuset and hotplug operations to
correct deadline accounting.

Rebuilding sched domain is a slow operation and we see 10+ ms delays
on suspend-resume because of that.

Since nothing is expected to change on suspend-resume operation; skip
rebuilding the sched domains to regain some of the time lost.

Debugged-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/cgroup/cpuset.c  | 6 ++++++
 kernel/sched/deadline.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b8..2ff68d625b7b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1067,6 +1067,9 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cpuhp_tasks_frozen)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
@@ -1084,6 +1087,9 @@ static void rebuild_root_domains(void)
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
+	if (cpuhp_tasks_frozen)
+		return;
+
 	rcu_read_lock();
 
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0d97d54276cc..42c1143a3956 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
 {
 	unsigned long flags;
 
+	if (cpuhp_tasks_frozen)
+		return;
+
 	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
 	rd->dl_bw.total_bw = 0;
 	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
-- 
2.25.1

