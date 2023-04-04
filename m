Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659B46D69D1
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjDDRHt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjDDRHr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 13:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8B44B9
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680627989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kw9bOB+w9RaCMC/2ecbxmrC9gMAMXWH6G3Pa3TXU2lQ=;
        b=fJLzgCKT+ZOBBzfTlUv9IeiPY8lvCuhsS0ll2JLWtR9QERYuRhhH97zNDs+UznZ3khg8EB
        82DqVi+PA27YEQd66PIh6WMImF+9WeKqrKkvJ7VuTZ9NLY4ZeOQCuO81fwLa9sCHodcBcG
        8939uHiJUPUdRIUaM9uRfxID3pbWh7s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-5HyO8yuwOo-sQk7DTiQ7Nw-1; Tue, 04 Apr 2023 13:06:26 -0400
X-MC-Unique: 5HyO8yuwOo-sQk7DTiQ7Nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95CBF1C06ED5;
        Tue,  4 Apr 2023 17:06:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 231BCFD6E;
        Tue,  4 Apr 2023 17:06:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        gscrivan@redhat.com, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for top_cpuset
Date:   Tue,  4 Apr 2023 13:05:46 -0400
Message-Id: <20230404170546.2585050-5-longman@redhat.com>
In-Reply-To: <20230404170546.2585050-1-longman@redhat.com>
References: <20230404170546.2585050-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is found that attaching a task to the top_cpuset does not currently
ignore CPUs allocated to subpartitions in cpuset_attach_task(). So the
code is changed to fix that.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index db1fca5cba06..056ec7dbfa3c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2540,7 +2540,8 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	if (cs != &top_cpuset)
 		guarantee_online_cpus(task, cpus_attach);
 	else
-		cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
+		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
+			       cs->subparts_cpus);
 	/*
 	 * can_attach beforehand should guarantee that this doesn't
 	 * fail.  TODO: have a better way to handle failure here
-- 
2.31.1

