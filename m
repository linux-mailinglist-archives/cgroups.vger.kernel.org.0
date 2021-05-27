Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB1392DF4
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhE0MbE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhE0MbC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 08:31:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4526C0613CE
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:29:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h3so94805wmq.3
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QWStSJ3Mvu9DtMYYM9x+7xh68F47755bbITjY+nefqs=;
        b=AHaKDLnLuRJfIci3AkxXBqi4e05z2oMlIvhgL33xmK0xo03xisGDmxUic9JzYcZ9IL
         9KJ9ZIn9KZpnuLnaXq2+C8HtvBVTsp46oFuBsBBrrt3yd8z2VjgVfMyqyVKi/wmNPBwF
         tqfDXoPXKzMpmzRQQ/2R+ir8B4PHzGdoYQoXLoboyJ+Sbap97hGDlFQhWtDf/+UpLnqK
         dLDmXirnm85YDscTHrlOB6H9huSPBuReQ+MVJi0QVtAjzrnSxwHOc3miY22XzIXGK+GV
         q5bJFwtaV10CDUsDZM8zFi7vy3OjyXkSLrUWOW64DFCJNAg8Tmdd0C8C1rH/A6Q/tZqH
         zuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QWStSJ3Mvu9DtMYYM9x+7xh68F47755bbITjY+nefqs=;
        b=ivaOJ0rOeXMY7V+2zADMK7N2dPGjnm2Bn463csi3kP1VLb/0jz59tqwhH1x1wFnWFK
         q8K0ih6ajqlzjhCfDh+APwBDBrqQ/tO7bOOzdDq0qoO8DH7r9RsN1ZTWDUoGCnSQu9Au
         JcyoXZhYnEoEduv0dt136PW1erA+sekJInIC9goIq2kZyvdx4gRXf8yrJk1DTpwnf17P
         cquANXFACvUB6xQ2an9fj0mkgj+4zihE9rs6ZeTlFBUl+b2CQyN73Oc2Wzg5Sf9thiKM
         PIDPvp44k8mY7JLHcarbwV/zCAdAf0w/5tZGqE+P9o0FIQcOvTxTz+VV2ssL0MIWv9tn
         qnGg==
X-Gm-Message-State: AOAM531a11Wic58YKUMgySD9Q/RD9ZvuYB5p2yOtgomKPtpXaNP2Z7wX
        qmzmHtj6rYkubZ9e5MHob51sIA==
X-Google-Smtp-Source: ABdhPJxNyrDyuAxgQg9mFVUsrVEpIR4CvFWL4NlnVCb3aKothzTOUk0ykRA5Zw0BqpxhLm6Ne7+5/Q==
X-Received: by 2002:a1c:b306:: with SMTP id c6mr8209136wmf.37.1622118565397;
        Thu, 27 May 2021 05:29:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3db3:bb86:bbaa:56ab])
        by smtp.gmail.com with ESMTPSA id z3sm2917721wrq.42.2021.05.27.05.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:29:24 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        odin@uged.al, cgroups@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] sched/fair: keep load_avg and load_sum synced
Date:   Thu, 27 May 2021 14:29:15 +0200
Message-Id: <20210527122916.27683-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527122916.27683-1-vincent.guittot@linaro.org>
References: <20210527122916.27683-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

when removing a cfs_rq from the list we only check _sum value so we must
ensure that _avg and _sum stay synced so load_sum can't be null whereas
load_avg is not after propagating load in the cgroup hierarchy.

Use load_avg to compute load_sum similarly to what is done for util_sum
and runnable_sum.

Fixes: 0e2d2aaaae52 ("sched/fair: Rewrite PELT migration propagation")
Reported-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..2859545d95fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3509,7 +3509,8 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	se->avg.load_sum = runnable_sum;
 	se->avg.load_avg = load_avg;
 	add_positive(&cfs_rq->avg.load_avg, delta_avg);
-	add_positive(&cfs_rq->avg.load_sum, delta_sum);
+	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
+
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
-- 
2.17.1

