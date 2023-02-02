Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762A6873B9
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 04:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBBDTN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 22:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjBBDTL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 22:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A0D2940F
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 19:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675307904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rONQLTKynqTykPVaxa5ORG7HhLk0Eh/0pOKFH75qGhM=;
        b=c/rpdk7qTDLKhvQ/SpH/uceHr3yTsAwqxjm5mXz1hgGLy6nDZagbBiIW2K85mPT6iFIu63
        fzAnMRDqa++43VfF2bhFA7kgfeyfM1meE/8+F5ep4dTzkyjRsYXUKCi900yfYAd28VGwDz
        jBcsUlslFtDv7ohawtSBQPXTJRQyOqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-E-EZ9wamNOaSDinigCFdrg-1; Wed, 01 Feb 2023 22:18:21 -0500
X-MC-Unique: E-EZ9wamNOaSDinigCFdrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B0C41869B6F;
        Thu,  2 Feb 2023 03:18:20 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39C712026D4B;
        Thu,  2 Feb 2023 03:18:20 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] cgroup/cpuset: Skip task update if hotplug doesn't affect current cpuset
Date:   Wed,  1 Feb 2023 22:17:48 -0500
Message-Id: <20230202031749.118146-2-longman@redhat.com>
In-Reply-To: <20230202031749.118146-1-longman@redhat.com>
References: <20230202031749.118146-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If a hotplug event doesn't affect the current cpuset, there is no point
to call hotplug_update_tasks() or hotplug_update_tasks_legacy(). So
just skip it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 205dc9edcaa9..cbf749fc05d9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3506,6 +3506,8 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 update_tasks:
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
 	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
+	if (!cpus_updated && !mems_updated)
+		goto unlock;	/* Hotplug doesn't affect this cpuset */
 
 	if (mems_updated)
 		check_insane_mems_config(&new_mems);
@@ -3517,6 +3519,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
+unlock:
 	percpu_up_write(&cpuset_rwsem);
 }
 
-- 
2.31.1

