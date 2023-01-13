Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655AC6699C3
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbjAMOOx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 09:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbjAMONx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 09:13:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD156A0EC
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:49 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bs20so21200596wrb.3
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6TGebPqxsiNn0n5diQ98jmCY4ZYb1DFPf0O/f9N2dY=;
        b=kyoXFhhH4LSSWG6wMnAiaJ07jZSSGb0HZosWr9qzMojEznxN8iqtffNopToVMH/hUL
         HSaY1Cobj6yL8RFFk3xyrySF23tDrhRt8LAziuIYTh00/5o47whlA/ZFBFM9ylDKTxFb
         9EFinVeA81cLatWd6SqRGbpWGmlkmVG8EZed4HEvr+AN0C2rW8x4chbzfrnIS54JyJ6I
         Qbm/O6OMzFBNLWTO+oMb7JJhCWtZCEJCnmTlUCFxMNkAiUK2rwHwiU60qPQhW6lbzFyp
         +lDDdKUk9x57PDc9PGqF9Kmc9FzBaQJdyWVIrUZK4jp/KaNKJubP3jBIDRjMvoCUz+D4
         rAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6TGebPqxsiNn0n5diQ98jmCY4ZYb1DFPf0O/f9N2dY=;
        b=wZNM8O4vAhpzdk3bFPXPPwyth8GKkTYSzzROuOAbzDJbpDATBjwgMrl7khjGb5KukZ
         wliYmCjBn90kUlnhu28fg1qnApc2rqdPa2c4cCg5SINoMFLkCoGnw4LlzB5Na6hXGnLW
         2sYDvII3WO4GT53iON7vkJKKXo7BirK/Spi7j8/hJovdgJIAFEVHqRs4mBxN1O4VZ0/2
         N627LbRTmvPvgrk+mEhBXnCyKbO4/nNNBAGvvu7Wb5Mkxj1Njg4sqCD/uQKavafi14mq
         bE4cDMHlJBjZQ0oFEblZuUxE70Qw5rtyNmUqL7/F9s2EHxrahi41SazGNCXQgvIjYBaU
         8fOQ==
X-Gm-Message-State: AFqh2krsyuqadf3bXRqewHu/7F3vuw+anpjh1LYZRol5T1orfqpdE2Vn
        obDwOW0syPhpjNcljpOJHZ7j6Q==
X-Google-Smtp-Source: AMrXdXtwqotZ1lPmONqBdvc8S+tasAFspxeuEERqj2CJCrSy7i2iX3ieCrQLetXyp400jA63Dj0qdg==
X-Received: by 2002:a5d:4692:0:b0:2bb:e94c:fcbf with SMTP id u18-20020a5d4692000000b002bbe94cfcbfmr13297857wrq.52.1673619168889;
        Fri, 13 Jan 2023 06:12:48 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:48 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v10 7/9] sched/core: Support latency priority with sched core
Date:   Fri, 13 Jan 2023 15:12:32 +0100
Message-Id: <20230113141234.260128-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 80ad27ddb4a1..a4bfa03d096c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11971,6 +11971,9 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency prio */
+	delta -= wakeup_latency_gran(sea, seb);
+
 	return delta > 0;
 }
 #else
-- 
2.34.1

