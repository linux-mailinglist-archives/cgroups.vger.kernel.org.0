Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2936D2316
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjCaOxC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Mar 2023 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjCaOw4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Mar 2023 10:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B120DAB
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680274283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9i7sLun1jgv9svlyB9jcs4mFG0+IKoU4iPpMJ0u9ZQ=;
        b=LvrIXz6WGo4R2W2uI9IDoagN0uhNYZ+lsQGhOM1ptyhgMmSYRSzD/Qwq23rkkRRd27wkUn
        FgK3h8NE1D97TuTJ6TR6KdXJ/sJNHTHUnm5mSJbgEl/S1/Zm1oy+G16G4kXf5GaaE6KCAQ
        QSn11VCRyL9daNrOeW7ZR5jsSeVdQlg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-MV6FSdOcPKuZsRbCle0GAg-1; Fri, 31 Mar 2023 10:51:17 -0400
X-MC-Unique: MV6FSdOcPKuZsRbCle0GAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9FF8884ED0;
        Fri, 31 Mar 2023 14:51:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53611492B02;
        Fri, 31 Mar 2023 14:51:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for top_cpuset
Date:   Fri, 31 Mar 2023 10:50:44 -0400
Message-Id: <20230331145045.2251683-3-longman@redhat.com>
In-Reply-To: <20230331145045.2251683-1-longman@redhat.com>
References: <20230331145045.2251683-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f6d5614982d7..2367de611c42 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2530,7 +2530,8 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
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

