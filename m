Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA526A18D2
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBXJfG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 04:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBXJfE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 04:35:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A61DBE6
        for <cgroups@vger.kernel.org>; Fri, 24 Feb 2023 01:35:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so1351158wms.0
        for <cgroups@vger.kernel.org>; Fri, 24 Feb 2023 01:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe0Uu935GUv7Os5h4xnlj3hjmH+1d59YLoRXBZZGIAY=;
        b=M/oQDDEh1x3rok6xB3rswBzsh2CRxoaZDID2byS65RkMGb0GDD3MqQmZH9MppTnquq
         fTby+i2kplGA5hVWZsaxpw1fs5xuLjf142dgQ0zIhorxZwv1qQC743lB+ZBvxIB3XpgX
         ejykMcqofVFzvaWswtOlR/1nyi3ch4k59aW9F2s1awuNUohXaJ6NmHbZ042zD6GD2Lwm
         8ex+yj1V149qNPNyUdSrZ1rxeAVrMLA081+RP1BnvvM8je801xgRaPigur0shh0gwhxr
         PCqmbsxGGIhXYM9IQZM/+ChhpzH7cxxHHVenlx5XW5jPf/1IM8YtzbrnZziibwY+MF2w
         zS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe0Uu935GUv7Os5h4xnlj3hjmH+1d59YLoRXBZZGIAY=;
        b=ByWsxB7JxnuD6EMR+TQ4VFvYlYxnxEMnj2rubmdyny6jW80aL+YTCh/DTlV5TkODa7
         tY29KlcetkGzglmM055eJ+EKVApptmzH2ErFxjk1ZFasVpe5dZ4bgXyuPF/EqnUAGKKw
         MKuzcYxpkvcLk1dfNtRCJCgCxGsdNJFGJUdBIv7JSgqgCAq874P5QGk5sf6BedJWBcMe
         lE4SI3zEuyXj5gdkXbEZZ+rxS/9kWAhcZuUVexDJwuYUEHtunTynZksn7fPjeMFDsnej
         baT9t+9TpOC6sywqxI+fc3T5iDkf1r8eS/6zTPUarji2++A50yPlit5VhArpWqBgGZl8
         WRgQ==
X-Gm-Message-State: AO0yUKUmv4dgjLoG6s41fd9AUD696pAa47ETt0L7nyrkSxNv/fj7njz3
        v2EoP8hZhU3r4X8sFJvJ6h5/5g==
X-Google-Smtp-Source: AK7set+xMZxhRq4ndKSsTAbRyLVW0BPP5eScr44PemySFzZM4/83yLQ82at9XptNkLffGiE0Y/0znQ==
X-Received: by 2002:a05:600c:4d21:b0:3ea:e4bb:340c with SMTP id u33-20020a05600c4d2100b003eae4bb340cmr2641552wmp.18.1677231301533;
        Fri, 24 Feb 2023 01:35:01 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b003e6dcd562a6sm2239179wmq.28.2023.02.24.01.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 01:35:00 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v12 3/8] sched/core: Propagate parent task's latency requirements to the child task
Date:   Fri, 24 Feb 2023 10:34:49 +0100
Message-Id: <20230224093454.956298-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224093454.956298-1-vincent.guittot@linaro.org>
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Clone parent task's latency_nice attribute to the forked child task.

Reset the latency_nice value to default value when the child task is
set to sched_reset_on_fork.

Also, initialize init_task.latency_nice value with DEFAULT_LATENCY_NICE
value

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 init/init_task.c    | 1 +
 kernel/sched/core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..7dd71dd2d261 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,6 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
+	.latency_nice	= DEFAULT_LATENCY_NICE,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4580fe3e1d0c..28b397f9698b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4681,6 +4681,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.34.1

