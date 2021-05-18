Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C934C387943
	for <lists+cgroups@lfdr.de>; Tue, 18 May 2021 14:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349400AbhERM4S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 May 2021 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349381AbhERM4Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 May 2021 08:56:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D6C061756
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 05:54:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y9so11416206ljn.6
        for <cgroups@vger.kernel.org>; Tue, 18 May 2021 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2m3StdkgN8j9sX0OOQRA/hs3X95klSzDGXdeM8HTJY=;
        b=vtTYi9jfJ+11Q8gjuzRabIbIUKKJyqDw2pUtj9GyYq0ftsy8WpejQqwF/PaksTkvyc
         E67MK7KCFtAD9K0Vzv1M8Bxsab4LMuvS1BFcFPicbl5vVl3wbbg36Rvy4C+mDBjmJWnU
         i1RHd6XsD+eheHVLbo1owEAmQdFFLNNmdDC/E3b4o9TVqEUdUGNmZBciHKjvhzGYXx2U
         AIsi+38lT8vu7gcHLdsPM8FJgXs+ZwIwAZFzksPlw5AudK7uFdgkTsCL23j3PHM4mR4r
         xVgDiSS6Vw4y+5jBPhFcNKOUwUSB3g6F23BHUHqi8eSvL4iStYz5xcleD5fjYA5zces/
         KggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2m3StdkgN8j9sX0OOQRA/hs3X95klSzDGXdeM8HTJY=;
        b=DYxSfm0C9wwZnKZuuvtpHprDZtNdAhrGJAkT8RL/9mvuGQAtYWa0tZrCUZTtKLYhDR
         ISAkr6OXuRZWFfoQjLS81oXPBi4YtNi9qKJkuA6oyd8vsK65mdgdRUKqgy/1MHdhdA+V
         IAjuGWJxUPBTGWOgXE3UNP97lI2dcvD2Y+unJojE4eF03Kh++Y4zgsmsfF4zHKYmHKwM
         qYWpTplsnQ5EVFLgTXhSd17hBPVXRaYknEiVFiuebKj/PzP8x8fusqMD3SPNuUjltPgA
         beqin5L+RVlUd85QYRx2iIDnscdt18qKsfwVBNarIdJK6E6Oqw0BEjgVUoZhNIvkPvly
         q2XA==
X-Gm-Message-State: AOAM531fAy2PiroXuQw6VozcZmmThSOVkLbKVGj57YXmqztyrjzId1F2
        VLJM8Rldq0iVZbyVbHIWw+oiHA==
X-Google-Smtp-Source: ABdhPJwLowVg+qfPEP4m4gwcjwf2Q+qfSPQ4MZHPbdrFt8a6uEUt7DfWGWjaXSLKdG33muGkuGRptQ==
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr3761996ljj.457.1621342496269;
        Tue, 18 May 2021 05:54:56 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id v14sm2265898lfb.201.2021.05.18.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:54:55 -0700 (PDT)
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
Subject: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
Date:   Tue, 18 May 2021 14:52:00 +0200
Message-Id: <20210518125202.78658-2-odin@uged.al>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518125202.78658-1-odin@uged.al>
References: <20210518125202.78658-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Make sure cfs_rq does not contribute to task group load avg when
checking if it is decayed. Due to how the pelt tracking works,
the divider can result in a situation where:

cfs_rq->avg.load_sum = 0
cfs_rq->avg.load_avg = 4
cfs_rq->avg.tg_load_avg_contrib = 4

If pelt tracking in this case does not cross a period, there is no
"change" in load_sum, and therefore load_avg is not recalculated, and
keeps its value.

If this cfs_rq is then removed from the leaf list, it results in a
situation where the load is never removed from the tg. If that happen,
the fiarness is permanently skewed.

Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24a90b0..ceda53c2a87a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8004,6 +8004,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_sum)
 		return false;
 
+	if (cfs_rq->tg_load_avg_contrib)
+		return false;
+
 	return true;
 }
 
-- 
2.31.1

