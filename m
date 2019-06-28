Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E392595A5
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF1IGh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 04:06:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40596 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfF1IGh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 04:06:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so8035279wmj.5
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 01:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V5rt7wqLf2YkGXLjqqYHPcMhXEcwrF0Z+/UteTLRmvM=;
        b=S/2GZNR5AGQb//Er3zGWRmlWsx62dijaMsG0ji+04PCkeVxm5LuuYYnCF6O7ti07yi
         WFO5Op4tyXmU3NX1FL2QHCkmvIjncqh7XBj0k9TBdBuuVfqmu4HDrf3V3HgA9NNuViGo
         3GCajoo71tltfrqEoYvjpUkd1DIiGlVPD16rMWb1JQthz4nRgCCZkd3zUOZDLgnmMZxg
         Soo2xIzVrNXcOOaB3piBleQvjkB63+YxQkWl0n1GS6gkfNTUfksJDzWvIGjOFDn920u1
         mkGiXbA0Rj5aCfAVNolf7pcsLHFOo94UqPEvT9pdmbtdhpC/NmInosHRevpWuaMgo7E0
         JyJw==
X-Gm-Message-State: APjAAAWQcOXx7Z95ydDv0ldOcc7eA2zbDMua3b8Fu90jk4Vif5FbxuWm
        3abNioLFZSCqEYe0HRqY0YlxAg==
X-Google-Smtp-Source: APXvYqx5HZ/YUb4LkRfOYZ6h7XL9aS4w0S6Hw0hi+5DF+hwgheHb+o6VpyBFs6OFlujmhWkWP+XGhw==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr6053904wmh.126.1561709194665;
        Fri, 28 Jun 2019 01:06:34 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:33 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v8 0/8] sched/deadline: fix cpusets bandwidth accounting
Date:   Fri, 28 Jun 2019 10:06:10 +0200
Message-Id: <20190628080618.522-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

v8 of a series of patches, originally authored by Mathieu, with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

Apart from the usual rebase on top of cgroup/for-next, this version
brings in an important difference w.r.t. v7: cpuset_mutex conversion to
percpu_rwsem (as suggested by Peter) to deal with a performance
regression caused by the fact that grabbing the (v7) callback_lock raw
spinlock from sched_setscheduler() was in fact a bottleneck. The
conversion required some lock order changes and an rcu related mod.

So, this is (unfortunately) more than a small update. Hope it still
makes sense, though.

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v8

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966

Juri Lelli (6):
  cpuset: Rebuild root domain deadline accounting information
  sched/deadline: Fix bandwidth accounting at all levels after offline
    migration
  cgroup/cpuset: convert cpuset_mutex to percpu_rwsem
  cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()
  rcu/tree: Setschedule gp ktread to SCHED_FIFO outside of atomic region

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

