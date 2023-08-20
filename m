Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C37781EA2
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjHTPZs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjHTPZp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:25:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9843AA7
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:21:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fee7b7689dso8546345e9.0
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544911; x=1693149711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy6sCJLNuc3jH8uH7wQ4wwiTwUaAG3ufvYgTJlzJMXY=;
        b=sh6ZPyRqXR9Cgl9kNLAJeZIU3Atyf8mIKlI6KuOiX3LLMMQ9qdM4Ap4W5pl2Q2RFJV
         szXa6z5c2LLoQgjH38/9lO+GZDR+cQ9Nov4QNzPLwbTDffuhbHKUgSvBLZ76yoxW+Rmd
         qPISR53JMgl4zka960zCMB4/W4+kyqYB5pCn29x3fHjRhFoxFlkFphs2jyTkTAAOc4bY
         bhJEdlOTcK1jQoBLkhpQviAbQ4hy5f2dxl5nhIIolIgKrRbFpBBn3vOZUc7fBUccstjI
         9oNKqMYcCB5UeY4GPE9x18G51QcN7dtNpLmumeFphb5I4pc5u2SJyFCK0v4MeIKbD91S
         4QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544911; x=1693149711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy6sCJLNuc3jH8uH7wQ4wwiTwUaAG3ufvYgTJlzJMXY=;
        b=FcoNusIX8sIyVQdVfmEi0ROFVH8bwSDSPLV0Z9uFzkKPrmFORXzY01SDEX4ITHMCLf
         xuCeVIk4vR60n6ZKPe277myYtYXUKuwi/0aeQXXS5nDJETPr1F4Ow1Sbzn2V9E1H3vdl
         5xYktc6uD+Z/inhXU7oWL/nNqE4/LllZM3bM2IlQuaNf2Kqt3ElodUlIlFv7BP4I72ct
         ZKw82FiuE7ShfMhAfSBF/TK3V80XM7lK/hab9pOLgWyRbZe3XNHUNypJCfsZglxmK8hy
         IBPh281JE3+ifo6zj78MFw3dDwjH9TaobTWdxwxLcjncoFk4skrFUCqs4DiCAZh3eNft
         luQw==
X-Gm-Message-State: AOJu0Ywhbh6FJ2JCgNyiNXRkAmE4vz/3ntIkSconVlfYnYNezF1zApqj
        wWfEuPFJ+rdtHAKfNeTK4QDevyuIQdzu1lMLYc8=
X-Google-Smtp-Source: AGHT+IH4OWwf9GHpV+tje8zc0gJyX33F+nflC3SR1eebkrZnarAVHU9PGBW4jIx7t2BNuQPRzmdmLg==
X-Received: by 2002:a05:600c:210b:b0:3fe:ef5b:bb6 with SMTP id u11-20020a05600c210b00b003feef5b0bb6mr936798wml.35.1692544910831;
        Sun, 20 Aug 2023 08:21:50 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003fe3674bb39sm9762497wms.2.2023.08.20.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:21:50 -0700 (PDT)
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
Date:   Sun, 20 Aug 2023 16:21:39 +0100
Message-Id: <20230820152144.517461-2-qyousef@layalina.io>
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
index b476591168dc..96b56226a304 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -912,7 +912,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
-static void update_tasks_root_domain(struct cpuset *cs)
+static void dl_update_tasks_root_domain(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -925,7 +925,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void rebuild_root_domains(void)
+static void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
@@ -953,7 +953,7 @@ static void rebuild_root_domains(void)
 
 		rcu_read_unlock();
 
-		update_tasks_root_domain(cs);
+		dl_update_tasks_root_domain(cs);
 
 		rcu_read_lock();
 		css_put(&cs->css);
@@ -967,7 +967,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	rebuild_root_domains();
+	dl_rebuild_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }
 
-- 
2.34.1

