Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E380D387946
	for <lists+cgroups@lfdr.de>; Tue, 18 May 2021 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349408AbhERM4V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 May 2021 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349404AbhERM4U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 May 2021 08:56:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956BC061756
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 05:55:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f12so11431660ljp.2
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWKAKWFCOFChPGwAbKymaVFn6SZ1ozwG8tvGIzigvls=;
        b=T4f1OcTND4D2vmi8JrodCfZl8q4Pm5TExZMTTG1Zoxr0hAiQtEtmblc5RhdE04AjQ0
         rJApzDKqbiryagcoQe9DeVMsABy3iXA6PD9KQfZk2sVnoWJ+Eecgxauaeqy+GqMzTuo6
         EO0qyzYY68FZxf6F1RMfexc+NvYh8lAgQ81QCLFCDskgs3MMvFrIyqz5P0aPCbzuwglN
         PJWTk2TfAaSKhT2z/qD3Kp2rIK/317slxAI6Nt9xHIILSOUdyvIvjy9NF4oELjeq42Ox
         n+j/AYmuO9qhzKEtkXpEnFIoQNdDRTUv94zP/zNPz5ynLwPQ4crOOB8PTtKhJNoRIZq8
         A+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWKAKWFCOFChPGwAbKymaVFn6SZ1ozwG8tvGIzigvls=;
        b=J85+lZW11XjaelF/5gL52dDr9Df7JkldKmadkySBxBJR5Hg/XUWXGfYBPY8zmx+qP0
         ZTXI4rAg9P8/QJmhzGMiowr5uRAUYvjzM5nRgSa+hKEiqj4rZl35oBNuMfj9NXC5gXWd
         AXM1102490u7picw5Fz7TrtKFctX/v3xtRk7tQZqMjR5ZboYF7JBAUZf31cRKiTIQXL8
         7YNOrdPfmFc1sW3eQoYP3flMuGhEVw6jCWcDZf18DlkTfXvIuoPty6cFl1HZPjn0pNrZ
         zj3YlmFw5qijgLuGjrSpLengRL2jaKtsAhYuyodJ6QJjuoL3bAnMXCtJFCF8IYCZ0Fpj
         FfGA==
X-Gm-Message-State: AOAM532gSG5rMVXc5zxx7sk6uTQ+77XypxWSu+98HQl/gfKVIUf+0lEZ
        3i//gwl66rPZ3oBNigWyTRJbrA==
X-Google-Smtp-Source: ABdhPJyhXsR+7M52rZ7CmLZwGoS3Gd8871cFPsiYy/hpGtsfF2wSZNAOlP6D8WG+ngSwdVI5vQKlXQ==
X-Received: by 2002:a2e:9193:: with SMTP id f19mr4063066ljg.41.1621342500096;
        Tue, 18 May 2021 05:55:00 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id v14sm2265898lfb.201.2021.05.18.05.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:54:59 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 3/3] sched/fair: Fix ascii art by relpacing tabs
Date:   Tue, 18 May 2021 14:52:02 +0200
Message-Id: <20210518125202.78658-4-odin@uged.al>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518125202.78658-1-odin@uged.al>
References: <20210518125202.78658-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When using something other than 8 spaces per tab, this ascii art
makes not sense, and the reader might end up wondering what this
advanced equation "is".

Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7423d658389..c872e38ec32b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3142,7 +3142,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->load.weight
  *   ge->load.weight = -----------------------------               (1)
- *			  \Sum grq->load.weight
+ *                       \Sum grq->load.weight
  *
  * Now, because computing that sum is prohibitively expensive to compute (been
  * there, done that) we approximate it with this average stuff. The average
@@ -3156,7 +3156,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->avg.load_avg
  *   ge->load.weight = ------------------------------              (3)
- *				tg->load_avg
+ *                             tg->load_avg
  *
  * Where: tg->load_avg ~= \Sum grq->avg.load_avg
  *
@@ -3172,7 +3172,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->load.weight
  *   ge->load.weight = ----------------------------- = tg->weight   (4)
- *			    grp->load.weight
+ *                         grp->load.weight
  *
  * That is, the sum collapses because all other CPUs are idle; the UP scenario.
  *
@@ -3191,7 +3191,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->load.weight
  *   ge->load.weight = -----------------------------		   (6)
- *				tg_load_avg'
+ *                             tg_load_avg'
  *
  * Where:
  *
-- 
2.31.1

