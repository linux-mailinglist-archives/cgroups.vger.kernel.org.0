Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594CF6CD9BA
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjC2M5L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 08:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2M5K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 08:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6ACCA
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680094583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9wz52Em0oDIrgIoF+9rhsFOYzetLxtv432sbjV9gOo=;
        b=Ns2R2OLWTs3HMHv2jcd78K9hSapl5vU1nvEvjikL9EVtLtNCzrWX0DzkXrChfsFCUh/JaL
        WYnGzbAzgnShVPAzn35UL1yXso0WU5SGKR+7bXUoFGU6zDw3b321aUNP2Yba2id0jXsAO0
        Juq8yO/6KkGOosG1u00ypW0DvQzXQr4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-78eJAhZaO36rVSHaqBukAQ-1; Wed, 29 Mar 2023 08:56:22 -0400
X-MC-Unique: 78eJAhZaO36rVSHaqBukAQ-1
Received: by mail-qt1-f198.google.com with SMTP id v10-20020a05622a130a00b003e4ee70e001so4207395qtk.6
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9wz52Em0oDIrgIoF+9rhsFOYzetLxtv432sbjV9gOo=;
        b=eKGRTKSXazLpDR+VLKHVbGOtw68FDd5WiKwftLhJ5q6HpVojHfs6wCxEu4MBIUkFT3
         jYBb5l7YuNT43PK4B83RQZX1O+jNNno0pgZxKqpDpJfaiEmVmWXyz7tSgHe/s05dvzsn
         fFxOqe3A9hP4gq1GdXPSXNcY9RglKtX8A3o1SHaDUntKpBaUmRAhn7ZihzUfL72S/8v1
         xwOtSjIyab/dlfEHvd8bz/Y1o2TaJM8+gUhR7/SzWOJ+xICV6Ykuf/WT8zU4aMMACJ+v
         1LVioDfd/8K9ndMGMMkVyOw2IG76W8vp0+MnPDzSLy9DIlzUK26lVU97CTNbZkcTxyfP
         ViAg==
X-Gm-Message-State: AAQBX9eGPlDQFk/Qq1VMTL8et3oQotF+ZDMpFmAli+ByMmW4ZSHV39Z2
        A6+HAb5WI+iYjzyfXweVzEt9x+7jp+mSb0ipr7lQLantvC48WeGb9KJ087F3FxhdDa+JREOCY2T
        mcJ/DK5zT7/Q3ZrVizw==
X-Received: by 2002:a05:6214:194b:b0:5df:450b:8002 with SMTP id q11-20020a056214194b00b005df450b8002mr11421708qvk.31.1680094581752;
        Wed, 29 Mar 2023 05:56:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJWxjZFfrIJ1NR+0tUNmNjUrqSBO0Yw9J9827pJlUSGWLz746ASiUpxNrUDaVT2GO9Emgsiw==
X-Received: by 2002:a05:6214:194b:b0:5df:450b:8002 with SMTP id q11-20020a056214194b00b005df450b8002mr11421668qvk.31.1680094581447;
        Wed, 29 Mar 2023 05:56:21 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b007436d0e9408sm13527134qke.127.2023.03.29.05.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:56:21 -0700 (PDT)
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
Subject: [PATCH 1/6] cgroup/cpuset: Rename functions dealing with DEADLINE accounting
Date:   Wed, 29 Mar 2023 14:55:53 +0200
Message-Id: <20230329125558.255239-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
---
 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 636f1c682ac0..501913bc2805 100644
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
2.39.2

