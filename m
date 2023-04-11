Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D46DDC40
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDKNhH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDKNhG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 09:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC61BC
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681220182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0AGalK6TkETefuR8vqn2ZgXGP9Ke/hGkmxhOP0sbpu8=;
        b=GCaV4vKC7lpUtrB+yF7L2tJ9iJ4YXq71L06EhqtFwXbJrqXMiEyYd+SOEw0s3KdpuvP8IX
        nade9prE8hWDc/Bf/XOA5rLqtE07ieQ9kYHG8Hrl6ZCt9xP5ut6kPRQaMqyzld0/BdxHhY
        FbgHCI0hf1GS/v2r6nXaP6NlnO8zKG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-CV3BEFLoNY-TGqZlnAEKpA-1; Tue, 11 Apr 2023 09:36:18 -0400
X-MC-Unique: CV3BEFLoNY-TGqZlnAEKpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31588018AC;
        Tue, 11 Apr 2023 13:36:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E92F47CE1;
        Tue, 11 Apr 2023 13:36:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/5] cgroup/cpuset: Fix CLONE_INTO_CGROUP problem & other issues
Date:   Tue, 11 Apr 2023 09:35:56 -0400
Message-Id: <20230411133601.2969636-1-longman@redhat.com>
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

 v4:
  - Add missing rcu_read_lock/unlock to cpuset_cancel_fork() in patch 3.
  - Add patch 5 to reduce performance impact for the
    non-CLONE_INTO_CGROUP case.

 v3:
  - Update patches 2 & 3 to put task_cs() call under rcu_read_lock().

 v2:
  - Drop v1 patch 3
  - Add a new patch to fix an issue in cpuset_cancel_attach() and
    another patch to add cpuset_can_fork() and cpuset_cacnel_fork()
    methods.

The first patch in this series fixes a problem in
cpuset_cancel_attach(). Patches 2 and 3 fixes the CLONE_INTO_CGROUP
problem in cpuset. Patch 4 is a minor fix. The last patch is a
performance optimization patch for the non-CLONE_INTO_CGROUP case.

Waiman Long (5):
  cgroup/cpuset: Wake up cpuset_attach_wq tasks in
    cpuset_cancel_attach()
  cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
  cgroup/cpuset: Add cpuset_can_fork() and cpuset_cancel_fork() methods
  cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for
    top_cpuset
  cgroup/cpuset: Optimize out unneeded
    cpuset_can_fork/cpuset_cancel_fork calls

 include/linux/cgroup-defs.h |   6 ++
 kernel/cgroup/cgroup.c      |  23 +++--
 kernel/cgroup/cpuset.c      | 167 +++++++++++++++++++++++++++++-------
 3 files changed, 159 insertions(+), 37 deletions(-)

-- 
2.31.1

