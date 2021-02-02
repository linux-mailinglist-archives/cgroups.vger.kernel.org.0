Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937AF30CA78
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhBBSuF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 13:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbhBBSsc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 13:48:32 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4114DC0613ED
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 10:47:52 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a1so10365778qvd.13
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRGv31t5oIgSMdD5HuT0hX8f1ohrW2aTZf+6aUN4HlY=;
        b=S4Sk4WOq0qqgckH/82ebDu33VM/7hVX534DYaPgrG6/Myx34h8dabJwOJetTSnIe3L
         OSJGc8m9Sj7EQRFPSlOkILnQpxMhplWh3winKWHzICWTzCsNDSbj7VZZt0sT8P0o2Uos
         KNBrt5mJFPLzidD4x80yZ/JP+Go2nbxyyMxjTbWMM3dp3wvf0R+Cpq4+EUTuyxwVssM+
         lt68u6vKUpO96sioBifhybUsb5OofpzoH402x6koOFOdw3ZNmNvV5fjwinzsSbi1cUDk
         iMZ6ZnCe9ga140oAAtH6HEXfo0jsIp4jl7qhDJRVWw4hSkbR82SOry+BF+pEGYXh+LPT
         c9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRGv31t5oIgSMdD5HuT0hX8f1ohrW2aTZf+6aUN4HlY=;
        b=No8jdb4Y/z8gRAATbABI6bTKdKinhXFFeMrogl50IQV04Qt1O0Kd9I2w351ZfHA5xC
         7/IHd53QSBaYiWUHKcYOySxXSi4v1KKSAo6vtd42kvMNsHK3s1iarvrbM8jiDhsTRiwx
         fkcg+crLnq17ysyWlrjyw8ILnt+cRR46Ih3uyVPjAv+738j/M2c3GXpmFHWQfwRBs6Be
         L24ep9WUXJLRrXeZU2X66tEgAYx8n759rdOptgGia6nH2KXDqWptnMRuf0fNra2lqf40
         I5HgOcESnQHljRrOFmjuO+uHB3g7qbo1Bqz8Y9gY04zhZqnFPPQv7g0MMMu02tCOxkSy
         ejSQ==
X-Gm-Message-State: AOAM531Js4R3abHuWeOy2CAzD/eov11dINgwUqum4M17OOY6ORUa3QHD
        7RM5SaPDPBwYL8trfxFPPmvogA==
X-Google-Smtp-Source: ABdhPJwdzFmer39rWKh6F+cNpMXL7TqfcB6o13grTzCGvUy+YSnRpsADzH3nWfmZUsi+HhX9JEk+Dw==
X-Received: by 2002:a0c:fe47:: with SMTP id u7mr22040673qvs.4.1612291671468;
        Tue, 02 Feb 2021 10:47:51 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u6sm4944633qke.114.2021.02.02.10.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:47:50 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/7]: mm: memcontrol: switch to rstat
Date:   Tue,  2 Feb 2021 13:47:39 -0500
Message-Id: <20210202184746.119084-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This series converts memcg stats tracking to the streamlined rstat
infrastructure provided by the cgroup core code. rstat is already used
by the CPU controller and the IO controller. This change is motivated
by recent accuracy problems in memcg's custom stats code, as well as
the benefits of sharing common infra with other controllers.

The current memcg implementation does batched tree aggregation on the
write side: local stat changes are cached in per-cpu counters, which
are then propagated upward in batches when a threshold (32 pages) is
exceeded. This is cheap, but the error introduced by the lazy upward
propagation adds up: 32 pages times CPUs times cgroups in the subtree.
We've had complaints from service owners that the stats do not
reliably track and react to allocation behavior as expected, sometimes
swallowing the results of entire test applications.

The original memcg stat implementation used to do tree aggregation
exclusively on the read side: local stats would only ever be tracked
in per-cpu counters, and a memory.stat read would iterate the entire
subtree and sum those counters up. This didn't keep up with the times:

- Cgroup trees are much bigger now. We switched to lazily-freed
  cgroups, where deleted groups would hang around until their
  remaining page cache has been reclaimed. This can result in large
  subtrees that are expensive to walk, while most of the groups are
  idle and their statistics don't change much anymore.

- Automated monitoring increased. With the proliferation of userspace
  oom killing, proactive reclaim, and higher-resolution logging of
  workload trends in general, top-level stat files are polled at least
  once a second in many deployments.

- The lifetime of cgroups got shorter. Where most cgroup setups in the
  past would have a few large policy-oriented cgroups for everything
  running on the system, newer cgroup deployments tend to create one
  group per application - which gets deleted again as the processes
  exit. An aggregation scheme that doesn't retain child data inside
  the parents loses event history of the subtree.

Rstat addresses all three of those concerns through intelligent,
persistent read-side aggregation. As statistics change at the local
level, rstat tracks - on a per-cpu basis - only those parts of a
subtree that have changes pending and require aggregation. The actual
aggregation occurs on the colder read side - which can now skip over
(potentially large) numbers of recently idle cgroups.

---

A kernel build test confirms that the cost is comparable. Two kernels
are built simultaneously in a nested tree with several idle siblings:

root - kernelbuild - one - two - three - four - build-a (defconfig, make -j16)
                                             `- build-b (defconfig, make -j16)
                                             `- idle-1
                                             `- ...
                                             `- idle-9

During the builds, kernelbuild/memory.stat is read once a second.

A perf diff shows that the changes in cycle distribution is
minimal. Top 10 kernel symbols:

     0.09%     +0.08%  [kernel.kallsyms]                       [k] __mod_memcg_lruvec_state
     0.00%     +0.06%  [kernel.kallsyms]                       [k] cgroup_rstat_updated
     0.08%     -0.05%  [kernel.kallsyms]                       [k] __mod_memcg_state.part.0
     0.16%     -0.04%  [kernel.kallsyms]                       [k] release_pages
     0.00%     +0.03%  [kernel.kallsyms]                       [k] __count_memcg_events
     0.01%     +0.03%  [kernel.kallsyms]                       [k] mem_cgroup_charge_statistics.constprop.0
     0.10%     -0.02%  [kernel.kallsyms]                       [k] get_mem_cgroup_from_mm
     0.05%     -0.02%  [kernel.kallsyms]                       [k] mem_cgroup_update_lru_size
     0.57%     +0.01%  [kernel.kallsyms]                       [k] asm_exc_page_fault


---

And of course, the on-demand aggregated stats are now fully accurate
again:

$ grep -e nr_inactive_file /proc/vmstat | awk '{print($1,$2*4096)}'; \
  grep -e inactive_file /sys/fs/cgroup/memory.stat

vanilla:                              patched:
nr_inactive_file 1574105088           nr_inactive_file 1027801088
   inactive_file 1577410560              inactive_file 1027801088

---

 block/blk-cgroup.c         |  14 +-
 include/linux/memcontrol.h | 119 ++++++----------
 kernel/cgroup/cgroup.c     |  34 +++--
 kernel/cgroup/rstat.c      |  62 +++++----
 mm/memcontrol.c            | 320 +++++++++++++++++++++----------------------
 5 files changed, 266 insertions(+), 283 deletions(-)

Based on v5.11-rc5-mm1.


