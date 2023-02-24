Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6D6A18DF
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 10:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBXJfY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 04:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBXJfU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 04:35:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE665323
        for <cgroups@vger.kernel.org>; Fri, 24 Feb 2023 01:35:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so1698288wms.1
        for <cgroups@vger.kernel.org>; Fri, 24 Feb 2023 01:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFfq5teius6pAK1nmf1oSiYVaS3V8Wiqx9qF8KZNMCQ=;
        b=UPtzcx8EFj1zlSxQ6lMU0mkanMgYYtKeaO2lWxoPNm90eUsDg5dZ1+YuhJFLZ9eA1C
         GwVX/XBU0wi8bbZqS4brymorHHXxUfabheM649o6i0SQ/aVibdS9bgWV9lK6GXWoyCxV
         DDBMfSwJFsDs+VxTsL6tGbeInl0ZqUq5wfYvFDMQ9DRbPWoCbA/6Cvincqhb8n8A/JMv
         yF2u9O9DHpm/uv9CcBKmrH4ca42lGrIqrseUJRNneFVCwHJafcuPzxjA18lvOlidR6dV
         8ry4CjCYix+BYGvJUnF6KeUvdaZAfzJwDqJXYi1r+dRV7oZAoBl3+BLYwTygm+t5PEOr
         SgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFfq5teius6pAK1nmf1oSiYVaS3V8Wiqx9qF8KZNMCQ=;
        b=vsDcrrhYXSyCMueLkuJP057DDaAPDice5eRN9Sbo14PK+fiLul/Tv/qU54dbWTuYUU
         frZEt8X6ZDaqy0xNaOFlr4Q73XPDv3lQN28oGEhHcFdWHOvagrP3nzsHptuicz6ytrOa
         Minusg3UyghxfDhbJ8Pp3HQ3iDrpLKPnJP6LYTB3ZFFmNwmKXjHRw7ZGshJ7mmuWGL0g
         ecQmcJh3/YhIfTJuqS7U/sRa/eXTTZz9mwNxWtJbyMq1NcPLv5ACa+6lK3JhXDmM36Ah
         8Gz65w6AQhl7v8UhECg8OSYPcD54B/tfeX4X4QSrkuis/NaLyiMWVwxjyqB+50gK2JVr
         tVZQ==
X-Gm-Message-State: AO0yUKUstq9Tb5imWZ1josPRfkAQ+XA3X4qrIA/69NG0Ot/6IBs5xDqr
        eZ9mJgYhDKAE0PEEybuTLT7wGA==
X-Google-Smtp-Source: AK7set8uakOUbvmySBPvXTJA5HuapKBeA4BG/N82btii8y/1ofW049QHU4eTRDVwR0fxueKtyIIuAw==
X-Received: by 2002:a05:600c:1da2:b0:3ea:ed4d:38fc with SMTP id p34-20020a05600c1da200b003eaed4d38fcmr2179606wms.31.1677231307168;
        Fri, 24 Feb 2023 01:35:07 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b003e6dcd562a6sm2239179wmq.28.2023.02.24.01.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 01:35:06 -0800 (PST)
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
Subject: [PATCH v12 7/8] sched/core: Support latency priority with sched core
Date:   Fri, 24 Feb 2023 10:34:53 +0100
Message-Id: <20230224093454.956298-8-vincent.guittot@linaro.org>
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

Take into account wakeup_latency_gran() when ordering the cfs threads.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dc7570f43ebe..125a6ff53378 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11949,6 +11949,9 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency offset */
+	delta -= wakeup_latency_gran(sea, seb);
+
 	return delta > 0;
 }
 #else
-- 
2.34.1

