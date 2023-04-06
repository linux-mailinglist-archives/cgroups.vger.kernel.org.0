Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775E86D98E3
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbjDFOFE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbjDFOFE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 10:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EE07ED3
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680789864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3klBPS5f5pxKDuGhP3oupQdkk1kbCRTfG9zpyKuKHs=;
        b=b1rcFWQ29c/S8lSPMz5xdzMDCYeHfEYaeKPecS+9p1fLdcojvCz2t1yZYtMyZN9n9QFlLe
        gARXLMNHZNbdX+GRzMza9/Ye5zwv6jrgbIztG5KxxNye5nFvfk83Eg5ymjNKJN5u9cCPnN
        JL5apzx5VrmTYdFbPFg4goG69cM+P+M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-Q4M4DRTyM-eKVkYZSsV3yQ-1; Thu, 06 Apr 2023 10:04:20 -0400
X-MC-Unique: Q4M4DRTyM-eKVkYZSsV3yQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C1FB38601B0;
        Thu,  6 Apr 2023 14:04:20 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE66840C6EC4;
        Thu,  6 Apr 2023 14:04:19 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        gscrivan@redhat.com, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 4/4] cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for top_cpuset
Date:   Thu,  6 Apr 2023 10:04:04 -0400
Message-Id: <20230406140404.2718574-5-longman@redhat.com>
In-Reply-To: <20230406140404.2718574-1-longman@redhat.com>
References: <20230406140404.2718574-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
index a331e11e3d20..8fd90f7bdeb0 100644
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

