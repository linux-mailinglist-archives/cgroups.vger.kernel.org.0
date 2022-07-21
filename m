Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D257C321
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiGUEFX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiGUEFO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE72EA1
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w7so671332plp.5
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvvOz2ooNKkLxp1jXKzvkeS5wEgSxLKRgm307TatvVA=;
        b=ckpgDrLr6CFyxohwrqrpXwyXKp11JVoiQ5DiMMTylXQa6I8xWS3YYhh2dta4ECXV7Y
         vTIbxjVYUENY381COkF0BRbUPBUYVORJWIqY2OUWTgTWOOAxKfAZu6dl8Lz3Y4A1NKFD
         jlijrV7S3zgzVs/RUtm7sH9g4u2y3/w7UIAoU7BtZqVC99Fv7S2494Bu9tR3W0xK+vHX
         ZaBd3K32+MGH5I/mM7pSXZklcuCPk6DY8Q/gZefUKml2rPT3teNNVZ+od0kPRqPXwkHB
         3fk6nKf974fgJYcPhIIJoGu8eaHUnYL9J15Y6ZowtSnP6E0bzgwAs5z5JVE0QALCyNoV
         /pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvvOz2ooNKkLxp1jXKzvkeS5wEgSxLKRgm307TatvVA=;
        b=4jt24NRmoaVZTH/A5sVJJGDLo75iI8P9NVoD7u0tzSWSRAzt6d20c7oV4BBvjQAsE6
         p5FxJYwWU4Fs5y9zpynWVcr9AfVvtbsDJgfhRXyUri79dz9SWHjycrjvJtuYGhzkSPE/
         rqAApB5S8P7Gpv3PcWw7o1vHBsx+KH0In9xQdUzNvoDgLAWJLLFerXBAPrW8Z4M25sIh
         A8XG5NEt9el6M9GNaABiUyWSt0wkpznoZp2vBN/wmJq0OEy0PpNyFeZxinSGmNeeBfV4
         dOwHh7fGlZLoshC5QgnZQZXER0/RvzuwOBfo2RJityha3GzxwWFYUpUzQLtgrWDq4gzM
         ttrw==
X-Gm-Message-State: AJIora/PLfxwU/MzLGPA9mQagKgf4BWTZ0+HmAFeJckX5SLz8kEBXQgj
        ozzQvbSeYklu1wEMsUYOquQWSA==
X-Google-Smtp-Source: AGRyM1sTf0wPzfxVI0+e4iyKEpi2Pmdf28lKPn7ux0IdbOj3q31jhmFOwSQ0nuCDaFIu5xd/qhUvhA==
X-Received: by 2002:a17:90b:17c1:b0:1f0:1fc9:bcc7 with SMTP id me1-20020a17090b17c100b001f01fc9bcc7mr9332859pjb.53.1658376309176;
        Wed, 20 Jul 2022 21:05:09 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:08 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 3/9] sched/psi: move private helpers to sched/stats.h
Date:   Thu, 21 Jul 2022 12:04:33 +0800
Message-Id: <20220721040439.2651-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch move psi_task_change/psi_task_switch declarations out of
PSI public header, since they are only needed for implementing the
PSI stats tracking in sched/stats.h

psi_task_switch is obvious, psi_task_change can't be public helper
since it doesn't check psi_disabled static key. And there is no
any user now, so put it in sched/stats.h too.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi.h  | 4 ----
 kernel/sched/stats.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 89784763d19e..aa168a038242 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -18,10 +18,6 @@ extern struct psi_group psi_system;
 
 void psi_init(void);
 
-void psi_task_change(struct task_struct *task, int clear, int set);
-void psi_task_switch(struct task_struct *prev, struct task_struct *next,
-		     bool sleep);
-
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index baa839c1ba96..c39b467ece43 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -107,6 +107,10 @@ __schedstats_from_se(struct sched_entity *se)
 }
 
 #ifdef CONFIG_PSI
+void psi_task_change(struct task_struct *task, int clear, int set);
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep);
+
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
-- 
2.36.1

