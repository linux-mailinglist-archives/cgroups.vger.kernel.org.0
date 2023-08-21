Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2D78357D
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 00:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjHUWU3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHUWU2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 18:20:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D31132
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 15:20:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso36876115e9.0
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692656421; x=1693261221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGGulz8Xs9VGIJsh2Gg1EO/IDYOGhZjqwi+HXfBv8GA=;
        b=FBr8hsVZUyCDzPHYEf5mMiSSLRqgKLX1EYON2WMn/vRtRI2B2klIQgNYSR+hQeZ5WO
         VEkAesn4ov+TvdOjlA/l7SOLVbEUtSruWRJkEYWZQrR+vv3QmmhphbP4HUylTTUyVoHo
         ikpAdF+Gx82kToB7LJp03Mej1idR2XpVaVLnC34kLerw2JI1rO9xsOp0QowJC84pKUPQ
         pDYZu8GU5e8lnZ3/i0tVP77t4lEFIQp84qYA3tfWjGmZneWYh1EWjWyzOeXkuyngUw3/
         5M6Qm0vKWhHb5jrMREYMcSqZjEXI5puMwoRPk9OxIbl0XTPmBXEbW1XHc+88JFf0QXB0
         /vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656421; x=1693261221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGGulz8Xs9VGIJsh2Gg1EO/IDYOGhZjqwi+HXfBv8GA=;
        b=K7GmyJJv9vMc0mnXpoEgztPKn2JVAq1hVPhbTZWB94jljcGSyE0xxQKkH8YlUPdKpY
         3yIlXdFvlDr+OHM1NHoc0jIpDMKdHxnj6nz69hKibJXeq2gLi5L/CGCwYRm+9lNYqXER
         mNJ1vmiwonmIYI4k4/RErvnccK04EWAe4W9RRCmsR1GtCMqQGfVj60J6g4Piti/4lvPg
         ttseChHMz9OAtrIQAZ4IRW2JJFtiTP3HLHLVsJYnQr6EC/9j7i5jdEQTa/oaU9IXqdRx
         iW3iO6EyiaB1G7upI9bAKkIUx2D953XGq+SaUHNTaGcZ08Pz/cIIttSQdYlkt0nKd7BB
         ci2g==
X-Gm-Message-State: AOJu0Yx6gsfqFPhdN5qPlU/zXAF2SH8m+LgYJD4ARDi6ZZgcvVIxLP4F
        VZGtJeHoCIhROYOq2OEt7S6Qkg==
X-Google-Smtp-Source: AGHT+IHpf1bgg9D4wRey2I8bxhP8ECfcpt/gVPFSFZ2pM8DF9wttV9D+MospCMe2HTqqga+l1No1Ag==
X-Received: by 2002:a1c:7508:0:b0:3fe:dd91:b5b6 with SMTP id o8-20020a1c7508000000b003fedd91b5b6mr6085684wmc.25.1692656421239;
        Mon, 21 Aug 2023 15:20:21 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fe61c33df5sm17751154wmb.3.2023.08.21.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:20:20 -0700 (PDT)
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
Date:   Mon, 21 Aug 2023 23:19:51 +0100
Message-Id: <20230821221956.698117-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821221956.698117-1-qyousef@layalina.io>
References: <20230821221956.698117-1-qyousef@layalina.io>
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
index e4ca2dd2b764..428ab46291e2 100644
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

