Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F6586DF1
	for <lists+cgroups@lfdr.de>; Mon,  1 Aug 2022 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiHAPlx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Aug 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiHAPlx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Aug 2022 11:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85FE728725
        for <cgroups@vger.kernel.org>; Mon,  1 Aug 2022 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659368511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6aGAsmftLF/0dvg9tasEyfV88rlFwnKcqNhuGDzyxe4=;
        b=H9alO73+1jg9xAuRK+5yRhXxiLEA3apU9186ezlO0fcJ+gy4X++oasUHfyxA5xffjyWdHM
        jGRHcDRdplC+yNUT5zwxDsaQI9HBqtElBfy7giMzrSwRKV1NEdDojVYSsCjuMApCflbkCJ
        VlbTzxtGetv/R0vyBdz8q8aKVGtESPQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-xB1oEN01MyuRFgU_OYbiIQ-1; Mon, 01 Aug 2022 11:41:48 -0400
X-MC-Unique: xB1oEN01MyuRFgU_OYbiIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8890805B9A;
        Mon,  1 Aug 2022 15:41:47 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24F7492C3B;
        Mon,  1 Aug 2022 15:41:46 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] sched, cgroup/cpuset: Keep user set cpus affinity
Date:   Mon,  1 Aug 2022 11:41:22 -0400
Message-Id: <20220801154124.2011987-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

v2:
 - Rework the v1 patch by extending the semantics of user_cpus_ptr to
   store user set cpus affinity and keeping to it as much as possible.

The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity")
which uses it narrowly to allow keeping cpus affinity intact with
asymmetric cpu setup.

This patchset extends user_cpus_ptr to store user set cpus affinity
via sched_setaffinity() API. With that information avaiable, it will
enable cpuset to keep cpus afinity as close to what the user wants as
possible within the cpu list constraint of the current cpuset.

Waiman Long (2):
  sched: Use user_cpus_ptr for saving user provided cpumask in
    sched_setaffinity()
  cgroup/cpuset: Keep user set cpus affinity

 include/linux/sched.h  |  1 +
 kernel/cgroup/cpuset.c | 24 ++++++++++++--
 kernel/sched/core.c    | 71 ++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h   |  1 -
 4 files changed, 74 insertions(+), 23 deletions(-)

-- 
2.31.1

