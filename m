Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976B96E702
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfGSOA1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 10:00:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40509 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfGSOA1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 10:00:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so29155130wmj.5
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2019 07:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fURSZsES8/FFy7omO0nwJ/wZ8WE0Q3uyMY9LgzNs6zc=;
        b=B9rltYcBLvDhn/GUzTUpHKmAP6WqdqNLOEy/SNZmDtH7UZi5pxnNxBIlL/KKHAUD0K
         m/+W9WW5i4oOqm6o2DKwwMKLdS1W4tqSWS9upwxVIbpXwbt1mgy3zovBXuk8wlgBd+aU
         Q94ghwiKmIqq8CIK2vbK7tPYwrqJxqGh+0eMxp5B2qgJCw4uDsQJp16u741ccuxX2d3O
         qyS/aU3CzNPGBaVw442HK/TRQU8E5XHgIjSBhB6A+5gfcfNGbYX0ilicSJAFj1t1C8k4
         uZQYYm0HxzV0Utp79NfmTKToPecBXRG43snZLQKVkEPkv4lnxzDi2KVQi7+6Vs35+Qr9
         DURg==
X-Gm-Message-State: APjAAAVEz7hc+tOnnouaPbYIc7EKnCgKcNhAiWX2jFExxu3QHI8NTGte
        CcgG2puRQFa6v4J7cRyAo61rCg==
X-Google-Smtp-Source: APXvYqyOvyKtmyz3QqXAkcudV0OvMUh00yVu9Qw9TWNYCzZ68HjF2KA6TDNewngTQqrc6ARv24zNCw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr47784756wmb.39.1563544825550;
        Fri, 19 Jul 2019 07:00:25 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:24 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v9 0/8] sched/deadline: fix cpusets bandwidth accounting
Date:   Fri, 19 Jul 2019 15:59:52 +0200
Message-Id: <20190719140000.31694-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

v9 of a series of patches, originally authored by Mathieu, with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

Apart from the usual rebase on top of cgroup/for-next, this version

 - make cpuset_{can,cancel}_attach grab cpuset_rwsem for write (5/8 - Peter)
 - moves v8 8/8 to 7/8 for bisectability (Peter)
 - adds comment in changelog regarding normalize_rt_tasks() (8/8 - Peter)

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v9

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966

Juri Lelli (6):
  cpuset: Rebuild root domain deadline accounting information
  sched/deadline: Fix bandwidth accounting at all levels after offline
    migration
  cgroup/cpuset: convert cpuset_mutex to percpu_rwsem
  cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
  rcu/tree: Setschedule gp ktread to SCHED_FIFO outside of atomic region
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()

Mathieu Poirier (2):
  sched/topology: Adding function partition_sched_domains_locked()
  sched/core: Streamlining calls to task_rq_unlock()

 include/linux/cgroup.h         |   1 +
 include/linux/cpuset.h         |  13 ++-
 include/linux/sched.h          |   5 +
 include/linux/sched/deadline.h |   8 ++
 include/linux/sched/topology.h |  10 ++
 kernel/cgroup/cgroup.c         |   2 +-
 kernel/cgroup/cpuset.c         | 163 +++++++++++++++++++++++++--------
 kernel/rcu/tree.c              |   6 +-
 kernel/sched/core.c            |  57 ++++++++----
 kernel/sched/deadline.c        |  63 +++++++++++++
 kernel/sched/sched.h           |   3 -
 kernel/sched/topology.c        |  30 +++++-
 12 files changed, 290 insertions(+), 71 deletions(-)

-- 
2.17.2

