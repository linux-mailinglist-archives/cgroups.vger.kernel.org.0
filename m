Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2160781EA6
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjHTPZv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjHTPZr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:25:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7713C00
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:21:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so23957875e9.3
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544913; x=1693149713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUqk7FUCXaNGq1+LVkIB8ErOVi02xdB+eEVdpbHMXqY=;
        b=sNjs0cVk9RJbqqNQCkIsLz5NLY+roIQlisyg6c/kk1GcxcTT/QWfOCEd/Kb/ceP07i
         yPgZGj59yPt4ZhKMTU+qiEdbSiGFzG9sZQegnQXCap0oVi/bm0PSfjCIAUI1rNvEdZlm
         NVzsslyCSjGm0fcD823QoWLQ7+M99qs05V4u9vQCE/50oHICwrnbNK9nENcM4J2TON1X
         wzmB5DPWllZrMTRddGPnZGWH2XQFIwHqcdSXNWrFUxw5krZtabzWdFNIE2BoAklqixRS
         PeN2yDmqdrH1xBO876I3583MsQMbwp5x+Hqd1NgGoRcRHkX/kQENxeI93YqD1OX6Fiu+
         VZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544913; x=1693149713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUqk7FUCXaNGq1+LVkIB8ErOVi02xdB+eEVdpbHMXqY=;
        b=P7boOio/QHZ61GKThtgTYRnIu3s5pwfgJeyE5uP812opqGaD14tqfEjI/PoJW69mut
         m6n4Tz3vgYmbQeQkgul9jEaNqln4jkV2PrGLLKBL3GjqMEEgRcvpgPjExJkBiWreSiNe
         V2eP3ciwJ75PNFAJg6XPYeqxHAmIYxdwPKCVvQYKTicFg+4LDi8w24kz0j/cAHUFGgCM
         Vu3RgRpCtmTCfRhbxs5msHvhrJuINBdKo9Vc6/XroyuRQj3jHMVuWW2bBMvtt/at6aAv
         4t68YEV+js12e57q9pqAmqPohv+ulGM2J3XUs/sVf6T7b15omp6RFg4cZn2tFh7UM/eK
         qu/A==
X-Gm-Message-State: AOJu0Yx992WO3Dq0E2zlJNVDr2b633hsEBhJxrDqmKAv/XbA9CGUdYEw
        ixmVtkbvseVS+H1yVePD8OFcng==
X-Google-Smtp-Source: AGHT+IGztXkxKdTe5kOv2hHbo/CDOK1wm3CiFESMZx7N6VygH9Nlg0AVakmLwOE3b1m3emjutXizaw==
X-Received: by 2002:a05:600c:224c:b0:3fe:26bf:6601 with SMTP id a12-20020a05600c224c00b003fe26bf6601mr3630675wmm.11.1692544913553;
        Sun, 20 Aug 2023 08:21:53 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003fe3674bb39sm9762497wms.2.2023.08.20.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:21:53 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 4/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Sun, 20 Aug 2023 16:21:42 +0100
Message-Id: <20230820152144.517461-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152144.517461-1-qyousef@layalina.io>
References: <20230820152144.517461-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit c0f78fd5edcf29b2822ac165f9248a6c165e8554 upstream.

update_tasks_root_domain currently iterates over all tasks even if no
DEADLINE task is present on the cpuset/root domain for which bandwidth
accounting is being rebuilt. This has been reported to introduce 10+ ms
delays on suspend-resume operations.

Skip the costly iteration for cpusets that don't contain DEADLINE tasks.

Reported-by: Qais Yousef (Google) <qyousef@layalina.io>
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit c0f78fd5edcf29b2822ac165f9248a6c165e8554)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fa8684c790a9..6c69e715b05a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -937,6 +937,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.34.1

