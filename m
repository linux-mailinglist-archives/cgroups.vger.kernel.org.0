Return-Path: <cgroups+bounces-7484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC64DA868C4
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CA3176A50
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413329DB61;
	Fri, 11 Apr 2025 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PabUZ/Gq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F629DB7D
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409491; cv=none; b=k4936jQ3XVXXe2qNsa5dEJdOTbcKq6FqZFtDeRYB6EQ/ZKQYoJAJ46ixHgoV4mjl2AoHT1YqZpQWL5LWj92cGRXUuTsSHLHB+BonvJxTEo9ijkcCR8ttt0yjI11Jd4b8otQKLpeOlNHTEgTncdd+UP6N32LeMlEe+BlSI8wRKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409491; c=relaxed/simple;
	bh=GlezClxNwXyj2fPcX6R1YyL1XIC4zzmJ81uk2n4Ilcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SM1Xcz6b91bXdr3q2NWJ3odTEYJ7D1iKzh5eNATOOLOssTRFQ+qE/cPhcu+OcbcQL4dRaUrGOXxYCo7JcBlePKsVUXKS//yNVUtq6OqhBCQJQlL8pn/dxChKnXWRBkgDIvvTYWhYYQ6p+cS7idXT0zKFLKj6sExf1dRemI58xy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PabUZ/Gq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c542ffec37so256049885a.2
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744409487; x=1745014287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygQenzmy7vFwk5boapeCjqVTpe3DiUuwewThEnjFTNM=;
        b=PabUZ/Gq6DiaBUQo2m8j05yskTlFPLrxZYeZGWPwvhUg7Y+kDIhOuWNLa/2VPtPke7
         B+4lBvqggbyRbLcMMJtHpAG8nLY15mbMd2p0CxpIQLXORP1HheooQS+5L4Z9nDj2Sv5v
         CrZseqL0jjZnly8ExzP8TG7Mc1yYPHZrA29/FiVz6TkEXAZRRt8biDx9QeFBg99LTf17
         4iAgJE0D3eL8fVj67Tdzjt+h58Ck82i04HlWQ5u2fT1zoCGnD0LbslbKnU9qjL3Glgk8
         AiyEQP+IQ9on0UzVoPQOpphlpUwi7DZ09LA39EOecI+30OcfyX+9fbUur78tDCu0ZgsB
         PFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744409487; x=1745014287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygQenzmy7vFwk5boapeCjqVTpe3DiUuwewThEnjFTNM=;
        b=LJ+v7Q19j62/ojIxeoeaBq/I9QpCW9YgDF/K9xXJsfBL431zWG5PRYPoIAgjDYcVYj
         QGiQc6/0XlSx8JSA4VzkNYQJWDxl/IDu9HJYjS2YWSB9r2LySiAdJr535xycqOwQsKfA
         Rki2tCTEncw06fkGS/eL50Vr0tle26Pz0V161nXSHgyOvY7hxR37vVdLypoQoHBlc73x
         on5IOfa+k4fUdR74m3a8Um0Drpx76+W9k6kMCD2FGooXT/GgkBtoundyhBodwNN3luIU
         fiiTRIJXkbx5N1wQrpKdE4idtAjae7BJZvEiHk77ux/rvnvTkyxSKq1CI4HZ/siIdHb/
         VRew==
X-Gm-Message-State: AOJu0YxW1KXA6NqV2z8EG5uFE8aLThIPx/225UAqAzuNaWCf8nXTvuZp
	0qmWTdmdyWu2TdUd4Rg9YBzRjkleGsvAmJlb5XJ7g0gOenrzarQDjOY/LOVxcbGBROO+xcrqlP6
	r
X-Gm-Gg: ASbGncsN1o8LUAgouo28P9fx7lvi5s4FAAK9uotZBCDi5vr/lwGShlrK5hMLyhy7cWl
	QdI77+dzcnT9oa6iRgLEMsF3kdNdApkTCgspHRq8apkrh7ZcK8gm0mS9jRvYCrh9mz5ySdOAe8Y
	I6eY3nutUk51MItK8h5Fx6jT/RGu3WdkqHE9pHojHu0EkgTRKWjn23laQ8b3anglsevaVX3gvEg
	g3dCwfhO7XvM5HqIPRDVT7VeqLMqvfG163jSOnuzvQek5xqZZDEBnMd99SBk920UCvdrE3kb/MP
	PtTHeAixOHZtdePy6qEiMxDgVzaKTfCjXol2GmJ8dd5OpvQ4AK1cYrskf+UZuwl/2hfz+MJCerG
	Pa9XGUZ5LMZ0oeaPoslcWjnOyK1/M
X-Google-Smtp-Source: AGHT+IHm8RTwqdUMGspYk3vZa4bWawqbVsR2wvJkHVtXx6TyU3yOSLpqAK8+Kr0uixC4x+9o+51Mmw==
X-Received: by 2002:a05:620a:25c9:b0:7c7:93ae:fe56 with SMTP id af79cd13be357-7c7af20bb2cmr686331485a.51.1744409487226;
        Fri, 11 Apr 2025 15:11:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8943afcsm321264485a.16.2025.04.11.15.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:11:26 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>,
	Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Date: Fri, 11 Apr 2025 18:11:05 -0400
Message-ID: <20250411221111.493193-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unmapped page cache pages can be demoted to low-tier memory, but
they can presently only be promoted in two conditions:
    1) The page is fully swapped out and re-faulted
    2) The page becomes mapped (and exposed to NUMA hint faults)

This RFC proposes promoting unmapped page cache pages by using
folio_mark_accessed as a hotness hint for unmapped pages.

We show in a microbenchmark that this mechanism can increase
performance up to 23.5% compared to leaving page cache on the
low tier - when that page cache becomes excessively hot.

When disabled (NUMA tiering off), overhead in folio_mark_accessed
was limited to <1% in a worst case scenario (all work is file_read()).

Patches 1-2
	allow NULL as valid input to migration prep interfaces
	for vmf/vma - which is not present in unmapped folios.
Patch 3
	adds NUMA_HINT_PAGE_CACHE to vmstat
Patch 4
	Implement migrate_misplaced_folio_batch
Patch 5
	add the promotion mechanism, along with a sysfs
	extension which defaults the behavior to off.
	/sys/kernel/mm/numa/pagecache_promotion_enabled
Patch 6
	add MGLRU implementation by Donet Tom

v4 Notes
===
- Add MGLRU implementation
- dropped ifdef change patch after build testing
- Worst-case scenario analysis (thrashing)
- FIO Test analysis

Test Environment
================
    1.5-3.7GHz CPU, ~4000 BogoMIPS, 
    1TB Machine with 768GB DRAM and 256GB CXL

FIO Test:
=========
We evaluated this with FIO with the page-cache pre-loaded

Step 1: Load 128GB file into page cache with a mempolicy
        (dram, cxl, and cxl to promote)
Step 2: Run FIO with 4 reading jobs
        Config does not invalidate pagecache between runs
Step 3: Repeat with a 900GB file that spills into CXL and
        creates thrashing to show its impact.

Configuration:
[global]
bs=1M
size=128G  # 900G
time_based=1
numjobs=4
rw=randread,randwrite
filename=test.data
direct=0
invalidate=0 # Do not drop the cache between runs
[test1]
ioengine=psync
iodepth=64
runtime=240s # Also did 480s, didn't show much difference

On promotion runs, vmstat reported the entire file is promoted
	numa_pages_migrated 33554772   (128.01GB)

DRAM (128GB):
  lat (usec)   : 50=98.34%, 100=1.61%, 250=0.05%, 500=0.01%
  cpu          : usr=1.42%, sys=98.35%, ctx=213, majf=0, minf=264
  bw=83.5GiB/s (89.7GB/s)

Remote (128GB)
  lat (usec)   : 100=91.78%, 250=8.22%, 500=0.01%
  cpu          : usr=0.66%, sys=99.13%, ctx=449, majf=0, minf=263
  bw=41.4GiB/s (44.4GB/s)

Promo (128GB)
  lat (usec)   : 50=88.02%, 100=10.65%, 250=1.05%, 500=0.20%, 750=0.06%
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=1.44%, sys=97.72%, ctx=1679, majf=0, minf=265
  bw=79.2GiB/s (85.0GB/s)

900GB Hot - No Promotion (~150GB spills to remote node via demotion)
  lat (usec)   : 50=69.26%, 100=13.79%, 250=16.95%, 500=0.01%
  bw=64.5GiB/s (69.3GB/s)

900GB Hot - Promotion (Causes thrashing between demotion/promotion)
  lat (usec)   : 50=47.79%, 100=29.59%, 250=21.16%, 500=1.24%, 750=0.04%
  lat (usec)   : 1000=0.03%
  lat (msec)   : 2=0.15%, 4=0.01%
  bw=47.6GiB/s (51.1GB/s)

900GB Hot - No remote memory (Fault-in/page-out of read-only data)
  lat (usec)   : 50=39.73%, 100=31.34%, 250=4.71%, 500=0.01%, 750=0.01%
  lat (usec)   : 1000=1.78%
  lat (msec)   : 2=21.63%, 4=0.81%, 10=0.01%, 20=0.01%
  bw=10.2GiB/s (10.9GB/s)

Obviously some portion of the overhead comes from migration, but the
results here are pretty dramatic.  We can regain nearly all of the
performance in a degenerate scenario (demoted page cache becomes hot)
by turning on promotion - even temporarily.

In the scenario where the entire workload is hot, turning on promotion
causes thrashing, and we hurt performance.

So this feature is useful in one of two scenarios:
1) Headroom on DRAM is available and we opportunistically move page
   cache to the higher tier as it's accessed, or
2) A lower performance node becomes un-evenly pressured.
   It doesn't help us if the higher node is pressured.

For example, it would be nice for a userland daemon to detect DRAM-tier
memory becomes available, and to flip the bit to migrate any hotter page
cache up a level until DRAM becomes pressured again. Cold pagecache
stays put and new allocations still occur on the fast tier.


Worst Case Scenario Test (Micro-benchmark)
==========================================

Goal:
   Generate promotions and demonstrate upper-bound on performance
   overhead and gain/loss.

System Settings:
   CXL Memory in ZONE_MOVABLE (no fallback alloc, demotion-only use)
   echo 2 > /proc/sys/kernel/numa_balancing
   echo 1 > /sys/kernel/mm/numa/pagecache_promotion_enabled
   echo 1 > /sys/kernel/mm/numa/demotion_enabled
   
Test process:
   In each test, we do a linear read of a 128GB file into a buffer
   in a loop.  To allocate the pagecache into CXL, we use mbind prior
   to the CXL test runs and read the file.  We omit the overhead of
   allocating the buffer and initializing the memory into CXL from the
   test runs.

   1) file allocated in DRAM with mechanisms off
   2) file allocated in DRAM with balancing on but promotion off
   3) file allocated in DRAM with balancing and promotion on
      (promotion check is negative because all pages are top tier)
   4) file allocated in CXL with mechanisms off
   5) file allocated in CXL with mechanisms on

Each test was run with 50 read cycles and averaged (where relevant)
to account for system noise.  This number of cycles gives the promotion
mechanism time to promote the vast majority of memory (usually <1MB
remaining in worst case).

Tests 2 and 3 test the upper bound on overhead of the new checks when
there are no pages to migrate but work is dominated by file_read().

|     1     |    2     |     3       |    4     |      5         |
| DRAM Base | Promo On | TopTier Chk | CXL Base | Post-Promotion |
|  7.5804   |  7.7586  |   7.9726    |   9.75   |    7.8941      |

Baseline DRAM vs Baseline CXL shows a ~28% overhead just allowing the
file to remain on CXL, while after promotion, we see the performance
trend back towards the overhead of the TopTier check time - a total
overhead reduction of ~84% (or ~5% overhead down from ~23.5%).

During promotion, we do see overhead which eventually tapers off over
time.  Here is a sample of the first 10 cycles during which promotion
is the most aggressive, which shows overhead drops off dramatically
as the majority of memory is migrated to the top tier.

12.79, 12.52, 12.33, 12.03, 11.81, 11.58, 11.36, 11.1, 8, 7.96

After promotion, turning the mechanism off via sysfs increased the
overall performance back to the DRAM baseline. The slight (~1%)
increase between post-migration performance and the baseline mechanism
overhead check appears to be general variance as similar times were
observed during the baseline checks on subsequent runs.

The mechanism itself represents a ~2.5% overhead in a worst case
scenario (all work is file_read(), all pages are in DRAM, all pages are
hot - which is highly unrealistic). This is inclusive of any overhead 

Development History and Notes
=======================================
During development, we explored the following proposals:

1) directly promoting within folio_mark_accessed (FMA)
   Originally suggested by Johannes Weiner
   https://lore.kernel.org/all/20240803094715.23900-1-gourry@gourry.net/

   This caused deadlocks due to the fact that the PTL was held
   in a variety of cases - but in particular during task exit.
   It also is incredibly inflexible and causes promotion-on-fault.
   It was discussed that a deferral mechanism was preferred.


2) promoting in filemap.c locations (callers of FMA)
   Originally proposed by Feng Tang and Ying Huang
   https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/patch/?id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329

   First, we saw this as less problematic than directly hooking FMA,
   but we realized this has the potential to miss data in a variety of
   locations: swap.c, memory.c, gup.c, ksm.c, paddr.c - etc.

   Second, we discovered that the lock state of pages is very subtle,
   and that these locations in filemap.c can be called in an atomic
   context.  Prototypes lead to a variety of stalls and lockups.


3) a new LRU - originally proposed by Keith Busch
   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/patch/?id=6616afe9a722f6ebedbb27ade3848cf07b9a3af7

   There are two issues with this approach: PG_promotable and reclaim.

   First - PG_promotable has generally be discouraged.

   Second - Attach this mechanism to an LRU is both backwards and
   counter-intutive.  A promotable list is better served by a MOST
   recently used list, and since LRUs are generally only shrank when
   exposed to pressure it would require implementing a new promotion
   list shrinker that runs separate from the existing reclaim logic.


4) Adding a separate kthread - suggested by many

   This is - to an extent - a more general version of the LRU proposal.
   We still have to track the folios - which likely requires the
   addition of a page flag.  Additionally, this method would actually
   contend pretty heavily with LRU behavior - i.e. we'd want to
   throttle addition to the promotion candidate list in some scenarios.


5) Doing it in task work

   This seemed to be the most realistic after considering the above.

   We observe the following:
    - FMA is an ideal hook for this and isolation is safe here
    - the new promotion_candidate function is an ideal hook for new
      filter logic (throttling, fairness, etc).
    - isolated folios are either promoted or putback on task resume,
      there are no additional concurrency mechanics to worry about
    - The mechanic can be made optional via a sysfs hook to avoid
      overhead in degenerate scenarios (thrashing).


Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Keith Busch <kbusch@meta.com>
Suggested-by: Feng Tang <feng.tang@intel.com>
Tested-by: Neha Gholkar <nehagholkar@meta.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Co-developed-by: Donet Tom <donettom@linux.ibm.com>

Donet Tom (1):
  mm/swap.c: Enable promotion of unmapped MGLRU page cache pages

Gregory Price (5):
  migrate: Allow migrate_misplaced_folio_prepare() to accept a NULL VMA.
  memory: allow non-fault migration in numa_migrate_check path
  vmstat: add page-cache numa hints
  migrate: implement migrate_misplaced_folio_batch
  migrate,sysfs: add pagecache promotion

 .../ABI/testing/sysfs-kernel-mm-numa          | 20 +++++
 include/linux/memory-tiers.h                  |  2 +
 include/linux/migrate.h                       | 11 +++
 include/linux/sched.h                         |  4 +
 include/linux/sched/sysctl.h                  |  1 +
 include/linux/vm_event_item.h                 |  8 ++
 init/init_task.c                              |  2 +
 kernel/sched/fair.c                           | 24 ++++-
 mm/memcontrol.c                               |  1 +
 mm/memory-tiers.c                             | 27 ++++++
 mm/memory.c                                   | 30 ++++---
 mm/mempolicy.c                                | 25 ++++--
 mm/migrate.c                                  | 88 ++++++++++++++++++-
 mm/swap.c                                     | 15 +++-
 mm/vmstat.c                                   |  2 +
 15 files changed, 236 insertions(+), 24 deletions(-)

-- 
2.49.0


