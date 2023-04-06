Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCA6D98E6
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbjDFOFH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbjDFOFG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 10:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D407ABA
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680789863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fJKC7eclbcJ2NK0QGFqPN+/Lc7oGs9ZGgHls+0SIsK4=;
        b=FUeQ22a60sO7ETEpK0buZtxddEettj8y1/Fgc8UOPatFxJLOwovnQv9yHhgcefTxfKHRPO
        TBXOMmVHJHFqTsI9eL0jBQ7uymhny6BNLYw/Hl8r+zU6G+0pIHNTOXfEMZe8tACeJrRF9n
        ChEgP6zvII1BNNCnv57/7gO3xf7hsr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-jOSNqcaKMZ-1csP7ClLnFg-1; Thu, 06 Apr 2023 10:04:19 -0400
X-MC-Unique: jOSNqcaKMZ-1csP7ClLnFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 342848996E2;
        Thu,  6 Apr 2023 14:04:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8311740BC799;
        Thu,  6 Apr 2023 14:04:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        gscrivan@redhat.com, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/4] cgroup/cpuset: Fix CLONE_INTO_CGROUP problem & other issues
Date:   Thu,  6 Apr 2023 10:04:00 -0400
Message-Id: <20230406140404.2718574-1-longman@redhat.com>
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

 v3:
  - Update patches 2 & 3 to put task_cs() call under rcu_read_lock().

 v2:
  - Drop v1 patch 3
  - Add a new patch to fix an issue in cpuset_cancel_attach() and
    another patch to add cpuset_can_fork() and cpuset_cacnel_fork()
    methods.

The first patch in this series fixes a problem in
cpuset_cancel_attach(). Patches 2 and 3 fixes the CLONE_INTO_CGROUP
problem in cpuset. The last one is a minor fix.

Waiman Long (4):
  cgroup/cpuset: Wake up cpuset_attach_wq tasks in
    cpuset_cancel_attach()
  cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
  cgroup/cpuset: Add cpuset_can_fork() and cpuset_cancel_fork() methods
  cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for
    top_cpuset

 kernel/cgroup/cpuset.c | 161 +++++++++++++++++++++++++++++++++--------
 1 file changed, 129 insertions(+), 32 deletions(-)

-- 
2.31.1

