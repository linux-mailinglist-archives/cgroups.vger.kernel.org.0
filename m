Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5E59165D
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiHLUkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiHLUkD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 16:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A1C9B516F
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660336801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4KXlLuvPMlmAiB57wJLNoz/8ss1kELM0mUamUap4RRE=;
        b=dIjoqVJmqAxtOOUHwU8SOtjeVgN3tfd6n6EnueOOzzHqwGulWgB/IwarOPPj55cR6ODHay
        OCKXm0QiuFIIusulUmx5gj2cZrHmslooVbDjgrTXgtbFodZQgJaiEg4bFelWvKlgT95rt/
        dbNb8WbQ4inQme3Q8lFaQ68fJC+EGqo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-OCJOeQOLPDyX1YvobL4xxQ-1; Fri, 12 Aug 2022 16:39:58 -0400
X-MC-Unique: OCJOeQOLPDyX1YvobL4xxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4F95380407F;
        Fri, 12 Aug 2022 20:39:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62416C15BA6;
        Fri, 12 Aug 2022 20:39:56 +0000 (UTC)
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
Subject: [PATCH v3 0/3] sched, cgroup/cpuset: Keep user set cpus affinity
Date:   Fri, 12 Aug 2022 16:39:26 -0400
Message-Id: <20220812203929.364341-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

 include/linux/sched.h  |  2 +
 kernel/cgroup/cpuset.c | 28 ++++++++++++-
 kernel/sched/core.c    | 89 ++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h   |  1 -
 4 files changed, 97 insertions(+), 23 deletions(-)

-- 
2.31.1

