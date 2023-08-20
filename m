Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B3781E84
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjHTPZB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjHTPZA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:25:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4744AA
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:24:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so23759325e9.3
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692545067; x=1693149867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zB+mFIKo852qISnzn01NoAUuwgxvjRQA9PODsz4aec=;
        b=lrK//1MkGR+N6RxNCFUirpzXoCWA+P1gsLdONyg7BYhpoeyhVYTVFD6Aj4c5+2WLsK
         5RNXY7igw+Q1Eas6lOLe/mgcU8W7vp0le6G9DZn8h6xpAvV7TC/EacCEv/tRLIriajSq
         uDV5nITISjgZZCOxkYOn1m3VQ5riEQCmBdz+4LoKYy2H73kkEuV6HicYvL6Sjcdbip7G
         pGulw1AnFruuseFJCo+CRmdzftXnm/SScKvCrWHJUoAf0H1oouWrJrGvqXyeCXTjE/Vg
         uD7dtPu9QQHWc0PJRaFipBNIJfQetOgd9p6FrliiezWUwOqME167eJnqHWRh0r9BtrNJ
         bYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692545067; x=1693149867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zB+mFIKo852qISnzn01NoAUuwgxvjRQA9PODsz4aec=;
        b=ItPN8/7e9h8FB37iJmzoyCA2Gh30cOUg4tIw79B4SZ9ZayG9cSYEoF+qzm6HcaunvL
         vqQJ9XzVHfdFO6xgm9au0rNCIOx0CEAl7uL2e5QQzdw2NciVhp2seMvWbQeHtBWWPF58
         PBhz2wK2qbqnM7hkMYsnWrzLFjg0q/MGbbIu0k2JGGAmcC4NDSJOpBFEAzqgrUel0K5d
         QXbOumpiKAg4vvRAPqPZOBFoA/K9a8TXN4BW2/0+2SaP0+P8oVrAPYR+vY/C6B+B8+gE
         0uKv/rKlaiuXJ+ubPo2kWrSyDisxpt8EB4/yJ2pFcn8DxjbVUGvhb8zC/P92bWhs0p/u
         xuOA==
X-Gm-Message-State: AOJu0YxfY22E+lSIFdVRNcrdia/ciD7fPul5RnNmf6AOjGn2Y2Os8yiT
        YuyoFYxbWRTOJT2oCh9oO44ngg==
X-Google-Smtp-Source: AGHT+IHXfGjm6SCRltEn2ml1bASWIOTO7ZQvYRd0iFBxbDqF0rVqCH/mQbdFM9ukDmMgYKcDssI4FQ==
X-Received: by 2002:a7b:c3d0:0:b0:3f9:c0f2:e1a4 with SMTP id t16-20020a7bc3d0000000b003f9c0f2e1a4mr3152114wmj.34.1692545067069;
        Sun, 20 Aug 2023 08:24:27 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d4fcb000000b003141e629cb6sm9419257wrw.101.2023.08.20.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:24:26 -0700 (PDT)
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
Subject: [PATCH 1/6] cgroup/cpuset: Rename functions dealing with DEADLINE accounting
Date:   Sun, 20 Aug 2023 16:24:12 +0100
Message-Id: <20230820152417.518806-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152417.518806-1-qyousef@layalina.io>
References: <20230820152417.518806-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit ad3a557daf6915296a43ef97a3e9c48e076c9dd8 upstream.

rebuild_root_domains() and update_tasks_root_domain() have neutral
names, but actually deal with DEADLINE bandwidth accounting.

Rename them to use 'dl_' prefix so that intent is more clear.

No functional change.

Suggested-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit ad3a557daf6915296a43ef97a3e9c48e076c9dd8)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e276db722845..888602c54209 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1066,7 +1066,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
-static void update_tasks_root_domain(struct cpuset *cs)
+static void dl_update_tasks_root_domain(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -1079,7 +1079,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void rebuild_root_domains(void)
+static void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
@@ -1107,7 +1107,7 @@ static void rebuild_root_domains(void)
 
 		rcu_read_unlock();
 
-		update_tasks_root_domain(cs);
+		dl_update_tasks_root_domain(cs);
 
 		rcu_read_lock();
 		css_put(&cs->css);
@@ -1121,7 +1121,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	rebuild_root_domains();
+	dl_rebuild_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }
 
-- 
2.34.1

