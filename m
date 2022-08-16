Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D29595EC8
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 17:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiHPPLm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiHPPLk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 11:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78072697
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660662698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jEYRKj1nlSqtCrHOWIArTdrELJ6+dwpREnZJE+d8OE8=;
        b=NlhGKQg5Fnfz2cejt3KVKddjp9zO/GJ3dOkfIY9H+biFvjT6LRyU/x7L3rzD0aUQsxQwgV
        3PwFjJqaPPRwI6hg7qBu5j8BK+lp4s99H1BR9NCYRmMa87pSISXqjAtDZVTkeFdFOeRNR+
        HHIDldqEF2KXr0TTTBVuCQpZtefUF84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-d357ltXUNxGd5u3M3tPu0g-1; Tue, 16 Aug 2022 11:11:34 -0400
X-MC-Unique: d357ltXUNxGd5u3M3tPu0g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE868811E87;
        Tue, 16 Aug 2022 15:11:32 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC25403340;
        Tue, 16 Aug 2022 15:11:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/3] sched, cgroup/cpuset: Keep user set cpus affinity
Date:   Tue, 16 Aug 2022 11:11:16 -0400
Message-Id: <20220816151119.29534-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

v4:
 - Update patch 1 to make sched_setaffinity() the only function to
   update user_cpus_ptr to make the logic simpler and
   easier to understand. restrict_cpus_allowed_ptr() and
   relax_compatible_cpus_allowed_ptr() will just use it if present.

v3:
 - Attach a new patch 2 to introduce a copy_user_cpus_mask() to copy
   out user masks with lock protection & use it in patch 3.

v2:
 - Rework the v1 patch by extending the semantics of user_cpus_ptr to
   store user set cpus affinity and keeping to it as much as possible.

The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity")
which uses it narrowly to allow keeping cpus affinity intact with
asymmetric cpu setup.

This patchset extends user_cpus_ptr to store user set cpus affinity via
sched_setaffinity() API. With that information avaiable, it will enable
cpuset to keep cpus afinity as close to what the user wants as possible
within the cpu list constraint of the current cpuset. Otherwise some
change to the cpuset hierarchy may reset the cpumask of the tasks in
the affected cpusets to the default cpuset value even if those tasks
have cpus affinity explicitly set by the users before.

It also means that once sched_setaffinity() is called, user_cpus_ptr
will remain allocated until the task exits.

Waiman Long (3):
  sched: Use user_cpus_ptr for saving user provided cpumask in
    sched_setaffinity()
  sched: Provide copy_user_cpus_mask() to copy out user mask
  cgroup/cpuset: Keep user set cpus affinity

 include/linux/sched.h  |   1 +
 kernel/cgroup/cpuset.c |  28 +++++++++-
 kernel/sched/core.c    | 119 ++++++++++++++++++++++++-----------------
 kernel/sched/sched.h   |   1 -
 4 files changed, 98 insertions(+), 51 deletions(-)

-- 
2.31.1

