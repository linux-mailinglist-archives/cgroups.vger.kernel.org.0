Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F8615749
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 03:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKBCEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 22:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKBCEl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 22:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C15FDD
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667354621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gev6P7R24DpRq36R8wXz2kmWLBFI3J+84j/AqTpnyIw=;
        b=MMgpzDsEu7IISUbhnfHtQ9SBuF/cRzwGanUp6m2TEWuJ+XPWlY9Z0rRsmFXl4mZgBRUivA
        fAb/DJvqkqq9Eai6Xheaf/jY0CPytmLW7VBPCmUjGH0vs4KHTVP/pL/QBkZMRCBWux777b
        AbCm2rOoUPJKLeiErRIasf8FJ9DDnAI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-PUlDozg_PpWi8AsieEGxzQ-1; Tue, 01 Nov 2022 22:03:39 -0400
X-MC-Unique: PUlDozg_PpWi8AsieEGxzQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-13c2cedb93bso8105990fac.4
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 19:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gev6P7R24DpRq36R8wXz2kmWLBFI3J+84j/AqTpnyIw=;
        b=bu3XzgNbzLOKg7wCRX5UishsOSl2+9NYqDQpy4IlQnG8ZYb97GH5WQdEBp/cj6ly1e
         qq6qAaaJ1UcWgTAicmauDh25vM6GC5zHzHlRvp5O4ob8KIl9WgsLCLRqzEn+Th60W8Lr
         gujrOFnRBVFt9+1FRlYYHMmqQfhjTzGbV5GWBrJsdP/IPOmMfPhSwmTJ/FS/r0c3EsWK
         PqPvx6ozmGAwuSY9s3zeGtTBfzXRaSHLC9t1czRtIbvm4IjUEoHF3cBsQRdluCz/77X2
         Hvk7si+rfTdN8lmZoXb1hFziJw8OO3gI3KSJ3Ow6bCdES4mUyCuJRdWs2sX+o3kCalDo
         VfMQ==
X-Gm-Message-State: ACrzQf3P/bhfXg6/OEYvtfkb8PGNJ54zjORZ6aiUhtRehb0T0odvRzWq
        3BnXI3ady89CuULRNtpQv3QYnJyuKa+FjS8UF2grOorO6S4G/U2bnTXd1pVCD5bZ42b6Xk7wjyO
        Ew7OlT1hmSozDfGMV6A==
X-Received: by 2002:a05:6830:3704:b0:660:fe76:3cb7 with SMTP id bl4-20020a056830370400b00660fe763cb7mr10900881otb.21.1667354618881;
        Tue, 01 Nov 2022 19:03:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7DG+li/A7VpDvIKqUuzfPg7gI21EhhlFF8vXWlawemkea0Kk/ubRWrfCId3EkcApts7tUZ1g==
X-Received: by 2002:a05:6830:3704:b0:660:fe76:3cb7 with SMTP id bl4-20020a056830370400b00660fe763cb7mr10900864otb.21.1667354618638;
        Tue, 01 Nov 2022 19:03:38 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:1099:7cb2:3a49:6197:5307])
        by smtp.gmail.com with ESMTPSA id h15-20020a9d6f8f000000b00665919f7823sm4526624otq.8.2022.11.01.19.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:03:38 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
Date:   Tue,  1 Nov 2022 23:02:40 -0300
Message-Id: <20221102020243.522358-1-leobras@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Patch #1 expands housekeepíng_any_cpu() so we can find housekeeping cpus
closer (NUMA) to any desired CPU, instead of only the current CPU.

### Performance argument that motivated the change:
There could be an argument of why would that be needed, since the current
CPU is probably acessing the current cacheline, and so having a CPU closer
to the current one is always the best choice since the cache invalidation
will take less time. OTOH, there could be cases like this which uses
perCPU variables, and we can have up to 3 different CPUs touching the
cacheline:

C1 - Isolated CPU: The perCPU data 'belongs' to this one
C2 - Scheduling CPU: Schedule some work to be done elsewhere, current cpu
C3 - Housekeeping CPU: This one will do the work

Most of the times the cacheline is touched, it should be by C1. Some times
a C2 will schedule work to run on C3, since C1 is isolated.

If C1 and C2 are in different NUMA nodes, we could have C3 either in
C2 NUMA node (housekeeping_any_cpu()) or in C1 NUMA node 
(housekeeping_any_cpu_from(C1). 

If C3 is in C2 NUMA node, there will be a faster invalidation when C3
tries to get cacheline exclusivity, and then a slower invalidation when
this happens in C1, when it's working in its data.

If C3 is in C1 NUMA node, there will be a slower invalidation when C3
tries to get cacheline exclusivity, and then a faster invalidation when
this happens in C1.

The thing is: it should be better to wait less when doing kernel work
on an isolated CPU, even at the cost of some housekeeping CPU waiting
a few more cycles.
###

Patch #2 changes the locking strategy of memcg_stock_pcp->stock_lock from
local_lock to spinlocks, so it can be later used to do remote percpu
cache draining on patch #3. Most performance concerns should be pointed
in the commit log.

Patch #3 implements the remote per-CPU cache drain, making use of both 
patches #2 and #3. Performance-wise, in non-isolated scenarios, it should
introduce an extra function call and a single test to check if the CPU is
isolated. 

On scenarios with isolation enabled on boot, it will also introduce an
extra test to check in the cpumask if the CPU is isolated. If it is,
there will also be an extra read of the cpumask to look for a
housekeeping CPU.

Please, provide any feedback on that!
Thanks a lot for reading!

Leonardo Bras (3):
  sched/isolation: Add housekeepíng_any_cpu_from()
  mm/memcontrol: Change stock_lock type from local_lock_t to spinlock_t
  mm/memcontrol: Add drain_remote_stock(), avoid drain_stock on isolated
    cpus

 include/linux/sched/isolation.h | 11 +++--
 kernel/sched/isolation.c        |  8 ++--
 mm/memcontrol.c                 | 83 ++++++++++++++++++++++-----------
 3 files changed, 69 insertions(+), 33 deletions(-)

-- 
2.38.1

