Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA726A1043
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 20:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjBWTLa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 14:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjBWTLS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 14:11:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10675AB7D
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bw19so926028wrb.13
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFfq5teius6pAK1nmf1oSiYVaS3V8Wiqx9qF8KZNMCQ=;
        b=MJINS6Ehzxb0sA/shHfydBxkVARhkb5euAB6EGVMRuXxdAsAG6pDXdb4flSMzFT+yY
         PRjYJgKcy2c1kAx+kPy8dM5434vOLqdKjuKNeHCfiB8RKQbmGwyIuo4Ot0oXQb7muZ+l
         ZWC/DmvpqT63kO80J2s1A6myyM17DfUAmx3G55JMJo00DO8RkBo79sMzI6rv3ETm/bSg
         MZA8gNYLVzi9ZMwaLPg4IFzSrFXLkNnJk18xeVlUlJLothZxzfx19MCHKH5vD1Xot+6E
         jEnLaGltetRClluH4JSZ/6EniN60YkdoFAN5xk4I3XztP6jpTyMUAPpAM8IJgGi3E8Kx
         DmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFfq5teius6pAK1nmf1oSiYVaS3V8Wiqx9qF8KZNMCQ=;
        b=ejAcX4wofsjngx5MxK0RLFHr9S0vRT4xyh8etOZ/TD1QeSgkXG1UJ2zrVSMmG7MyJo
         E5o836fq7kW2u948ecuuvAxuuqUl262s2Z9KSNShkXHH8KYhwEMJcTxrIS7TGsoyNVK8
         o5SHL1oIRy61njFwDlNSNCMsLCkV8oOhMcyfJASnEr/SnMlvRK9zf2/HGIPw69gssQ+N
         yXKqtZyymT2N4qC/XShqBjBVQ0lPX2E1htwTBEDsphzqika2/YHi9KUOiwOlwDFi6Js6
         29gUmKSvoDT034BD9HlHhNlJt3BBQIFWzUhVzN9VqcjrBvRLmm6/TgSrxvugb/PY5gfL
         VbfA==
X-Gm-Message-State: AO0yUKV2W3fyFIq7lZg7Yz+XiICJc6ZJwbX+Xq0PXHfMRYTckyusoTRZ
        A1WaaUCphKB53klh5jlOGrNY/w==
X-Google-Smtp-Source: AK7set/lPhrFKk1EDZZ4MO4SEWW9fv6y2VB8bmJO+3IiZdOFX52CZnJ7RT7NDHoOghMoTq6S965n+A==
X-Received: by 2002:adf:e412:0:b0:2c7:148c:b04f with SMTP id g18-20020adfe412000000b002c7148cb04fmr2398501wrm.37.1677179455369;
        Thu, 23 Feb 2023 11:10:55 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm9844481wro.92.2023.02.23.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:10:54 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v11 7/8] sched/core: Support latency priority with sched core
Date:   Thu, 23 Feb 2023 20:10:40 +0100
Message-Id: <20230223191041.577305-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223191041.577305-1-vincent.guittot@linaro.org>
References: <20230223191041.577305-1-vincent.guittot@linaro.org>
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

