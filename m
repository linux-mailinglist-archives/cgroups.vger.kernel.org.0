Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021FC6FA1C4
	for <lists+cgroups@lfdr.de>; Mon,  8 May 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjEHIA0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 May 2023 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjEHIAT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 May 2023 04:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F2C1FAA3
        for <cgroups@vger.kernel.org>; Mon,  8 May 2023 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683532752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4t/kJeD17nHukQXGvqRCuhxwkkI5NIpMbimQv44aaLo=;
        b=GX3v75jYcLWXA9cwzdGOites9XVSTCbrb4yhXl4gOiMVvqiMmxyvexMPhlyABBaKievM0f
        C0vizDlnOnBUEwA+2Q4HiYelZoXIQuH6fygxWS7uqFLa3QMxqIqkcXqoWS2Cm9FcPYfJaV
        khPhKRaQ3hRk1N9qqnQYhcyNnilAqPc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-gEhsK7L0PZyy83nLSPYDMw-1; Mon, 08 May 2023 03:59:10 -0400
X-MC-Unique: gEhsK7L0PZyy83nLSPYDMw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f422dc5fafso7061655e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 May 2023 00:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532749; x=1686124749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t/kJeD17nHukQXGvqRCuhxwkkI5NIpMbimQv44aaLo=;
        b=jnjLrsA3Ag9kTOlkfij04jjoBtvAIMyGgxQBGeh9XqLEtchhbC+GzrBPX+YsQbuH22
         p8t2oeisoKPJOYAjrV4th6PjMrSn0scJFqHMFpURW0AIX17agd4pJVPzqO2cB2AYsRz7
         Tzkh/jdL/XCmNJuYxMWjyKLsCvxSEkITrL9tlxEg5yEX03lDb6tpjcG5cnwjjyjUeHQx
         zYowUCg4dQR59NIjsjBX0LGKd3orfdUsdqzzqsKwvxxog63kAOFYSHCMxLYJBvk4e2eR
         0Tkv+bJJIwCU9hBTVZaLQBicedxQsftC9NZJ4LkArqGtMD9iqmBD4zJBVJXIcJgEyAgM
         uP+Q==
X-Gm-Message-State: AC+VfDyoeRILrSrU+tCR5FGn4DP0uBoDul5hR9hGfUVN4d8LtPkiupeO
        luSROdztrA8ZXIgwYDSBjepnsKXrnIYBx0/abi9srYn01RIMhl4R6EF8OxZHLXjYUVwBMfFLJxk
        cCWxYWSm7tmGNi50GGQ==
X-Received: by 2002:a7b:c4c3:0:b0:3f2:549b:3ef2 with SMTP id g3-20020a7bc4c3000000b003f2549b3ef2mr5798080wmk.17.1683532749518;
        Mon, 08 May 2023 00:59:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7a0wSkAYmhpx0Tj6YFB2sKdJ9hOcOGUBo8PnQ894eHMgjHm6i9tYu0H72J+M/oCPHigcScfg==
X-Received: by 2002:a7b:c4c3:0:b0:3f2:549b:3ef2 with SMTP id g3-20020a7bc4c3000000b003f2549b3ef2mr5798052wmk.17.1683532749209;
        Mon, 08 May 2023 00:59:09 -0700 (PDT)
Received: from localhost.localdomain.com ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm250423wmj.23.2023.05.08.00.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:59:08 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v3 1/6] cgroup/cpuset: Rename functions dealing with DEADLINE accounting
Date:   Mon,  8 May 2023 09:58:49 +0200
Message-Id: <20230508075854.17215-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508075854.17215-1-juri.lelli@redhat.com>
References: <20230508075854.17215-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

rebuild_root_domains() and update_tasks_root_domain() have neutral
names, but actually deal with DEADLINE bandwidth accounting.

Rename them to use 'dl_' prefix so that intent is more clear.

No functional change.

Suggested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
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
2.40.1

