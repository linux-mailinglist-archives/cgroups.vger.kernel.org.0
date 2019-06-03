Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94633A8C
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFCV75 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 17:59:57 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37779 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfFCV75 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 17:59:57 -0400
Received: by mail-pf1-f169.google.com with SMTP id a23so11388729pff.4
        for <cgroups@vger.kernel.org>; Mon, 03 Jun 2019 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcbe5XK5tsFMWxSLs2tZ84hRD+cj/6YTqAC2Tmv3P6A=;
        b=hOCZMeOhk+mnIUArMWNnC4vOoecC/JJjH016s1tw4Q96mSLD+0XvEFZfhYCyOuiLe3
         3JPco6SQFbsgOo3tJVA/rGxuMMqV+PxWgHbtFyYjLLr4aJ45fWaaT3ONrFh3O59CMhRv
         1a7SdQk8hx4KAgvnXTXy4jWGFB5OfJ5r7LCWoltwNWxy5L9bf/dZJoxBT8mbb0BqQ+14
         aoRFh3Hi+L5+3to6drNMaTiQ5MWNn112T5jPH2jmcr2nTpfYazs2lHbfT0EgV4wDf9p7
         +ZAzMj5wXkBDVcVYUtZ37FLCh0uEdyTwkwGCZK2XRuhvUzzguAJo+j34T00y0fKG5UdN
         paFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcbe5XK5tsFMWxSLs2tZ84hRD+cj/6YTqAC2Tmv3P6A=;
        b=N5IrOhsQ9Y/6/I6oE5ZlzXU4suNRPudmw5b4VOvAbxT3pUpN0DHD9/g480OjS+QZcW
         petRZhtktJIBkXhKdQFqSt2tS+Ttn0JrikBh8fU7VrShTAz6mXeSEc3bS+YYEbPExF1z
         akg1vGeFj4qHvykK0VMBvWtgZso2MzhxHy8u+NYne6xYV9mcw+gqqxEk463gDCi5Bi9O
         zs2xxZ+lK1rCGhKxJ4XtwUpVmS9fgMuUHlfW6nkRkThRt0FzQE4mV1t+WeuUrOVEIQAS
         E3V+RYC0iY8S/VkbmsmWuCbzPc5ZLqH5M2VldqAr61AM8PpMt5BkRiecVkmjbk3z6Jdx
         XTdA==
X-Gm-Message-State: APjAAAVnUfG0n0ICiNLvuWUAo3qBSWyt2H6Kb/aijfTj6+HKMlfexlfe
        2oDt70YxoxWiezqGrMar0ZK03g==
X-Google-Smtp-Source: APXvYqz4Qw8yGDgRFudiuxfXs7P+jDtt3/2W1h5CX5aNY5aXM70fQ7T4ZIHJj3eYv41Qd3NLYGM9aQ==
X-Received: by 2002:a17:90a:7146:: with SMTP id g6mr32429865pjs.45.1559596101827;
        Mon, 03 Jun 2019 14:08:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id i12sm17107336pfd.33.2019.06.03.14.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:21 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 00/11] mm: fix page aging across multiple cgroups
Date:   Mon,  3 Jun 2019 17:07:35 -0400
Message-Id: <20190603210746.15800-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When applications are put into unconfigured cgroups for memory
accounting purposes, the cgrouping itself should not change the
behavior of the page reclaim code. We expect the VM to reclaim the
coldest pages in the system. But right now the VM can reclaim hot
pages in one cgroup while there is eligible cold cache in others.

This is because one part of the reclaim algorithm isn't truly cgroup
hierarchy aware: the inactive/active list balancing. That is the part
that is supposed to protect hot cache data from one-off streaming IO.

The recursive cgroup reclaim scheme will scan and rotate the physical
LRU lists of each eligible cgroup at the same rate in a round-robin
fashion, thereby establishing a relative order among the pages of all
those cgroups. However, the inactive/active balancing decisions are
made locally within each cgroup, so when a cgroup is running low on
cold pages, its hot pages will get reclaimed - even when sibling
cgroups have plenty of cold cache eligible in the same reclaim run.

For example:

   [root@ham ~]# head -n1 /proc/meminfo 
   MemTotal:        1016336 kB

   [root@ham ~]# ./reclaimtest2.sh 
   Establishing 50M active files in cgroup A...
   Hot pages cached: 12800/12800 workingset-a
   Linearly scanning through 18G of file data in cgroup B:
   real    0m4.269s
   user    0m0.051s
   sys     0m4.182s
   Hot pages cached: 134/12800 workingset-a

The streaming IO in B, which doesn't benefit from caching at all,
pushes out most of the workingset in A.

Solution

This series fixes the problem by elevating inactive/active balancing
decisions to the toplevel of the reclaim run. This is either a cgroup
that hit its limit, or straight-up global reclaim if there is physical
memory pressure. From there, it takes a recursive view of the cgroup
subtree to decide whether page deactivation is necessary.

In the test above, the VM will then recognize that cgroup B has plenty
of eligible cold cache, and that thet hot pages in A can be spared:

   [root@ham ~]# ./reclaimtest2.sh 
   Establishing 50M active files in cgroup A...
   Hot pages cached: 12800/12800 workingset-a
   Linearly scanning through 18G of file data in cgroup B:
   real    0m4.244s
   user    0m0.064s
   sys     0m4.177s
   Hot pages cached: 12800/12800 workingset-a

Implementation

Whether active pages can be deactivated or not is influenced by two
factors: the inactive list dropping below a minimum size relative to
the active list, and the occurence of refaults.

After some cleanups and preparations, this patch series first moves
refault detection to the reclaim root, then enforces the minimum
inactive size based on a recursive view of the cgroup tree's LRUs.

History

Note that this actually never worked correctly in Linux cgroups. In
the past it worked for global reclaim and leaf limit reclaim only (we
used to have two physical LRU linkages per page), but it never worked
for intermediate limit reclaim over multiple leaf cgroups.

We're noticing this now because 1) we're putting everything into
cgroups for accounting, not just the things we want to control and 2)
we're moving away from leaf limits that invoke reclaim on individual
cgroups, toward large tree reclaim, triggered by high-level limits or
physical memory pressure, that is influenced by local protections such
as memory.low and memory.min instead.

Requirements

These changes are based on the fast recursive memcg stats merged in
5.2-rc1. The patches are against v5.2-rc2-mmots-2019-05-29-20-56-12
plus the page cache fix in https://lkml.org/lkml/2019/5/24/813.

 include/linux/memcontrol.h |  37 +--
 include/linux/mmzone.h     |  30 +-
 include/linux/swap.h       |   2 +-
 mm/memcontrol.c            |   6 +-
 mm/page_alloc.c            |   2 +-
 mm/vmscan.c                | 667 ++++++++++++++++++++++---------------------
 mm/workingset.c            |  74 +++--
 7 files changed, 437 insertions(+), 381 deletions(-)


