Return-Path: <cgroups+bounces-15472-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OtWLCeD6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15472-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:37:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACFE4574FF
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B2A3033A96
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A93451D5;
	Thu, 23 Apr 2026 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL1M0qFO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1686242D70
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976490; cv=none; b=TrAlzUQ9OFTLREiPKBq4yZ0AQhTr4H5Pn2CitW9gjP1UlcYHaoPmJ6dx4ei46DGZJgzomdGarXrC0WoGr0t8OWe250aYBF7Lwx3vbp2S8ouM693+mZ67mirhbMfFkYjBXqqutDrxsD8tDbw6fDx26RhtYntp1JSTSTd+oFbxIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976490; c=relaxed/simple;
	bh=gX+2oK/anCq0jYeJN45llKOVoZMP3+17pKKPYr7qrvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CSZPQJ+FpH3G/O4NEI9gPirJZgAb8CvTlISOGEI3tXOs53104dtdjVP6wZDf2yFDqt70mRe4S3UFV6YlX5IurZMOIW/th9y8H0m7QHwaQW60mDsVph+6yZN8RYBWRG41HEOMD5DqCkcwImbaTX5CvdKm5tocp3UTsMLu592+IHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL1M0qFO; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcdd1b492eso3027511a34.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976487; x=1777581287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXK3Al982u4BKXd+kiLvJEIaSgsC+HHG+R3gKRNBiS4=;
        b=RL1M0qFOtZitYSCIl3BNQknbMCRFmHTjcPPg4FlZt8qPZwRT2Y5xS0EUbkfmaQJWnQ
         Lg8XEsoyx3xcRJzxBlMuuvBsC2XQ0P1u5D025LGWaFVM+Ttj/ciRvo47x40e9fX6u2CR
         oN14KQzTqlOAVLOUob0QVRR5jcJz+txY9ytS371LJAHL3WCUzEyWOVYqiOP+Xpr1BON5
         Pv2MTMFIVe4GptZn77rhkN/V+RIY/r/yAHWOdMpo3nWNnG3BdjQah+rBGr3AobWHDZgR
         zh9gFjTiK6ey4GLlDXXlpjggoGwTok2LNL24rl0joTL624OC09tZIH5XaqJRzv6MqZ9h
         U/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976487; x=1777581287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXK3Al982u4BKXd+kiLvJEIaSgsC+HHG+R3gKRNBiS4=;
        b=TNTYh0diqrjA6rMHrxGINAqAaJDKEouBq3BCMt9fSGD1RfLMsczJjN1kJE+tBcSXrW
         WfL9kDOjT/Cd8nmR5De1//6x5nJJgezvvjine2x0f+nMVLHkmKVBMj3Nihvh1kWjXZc+
         Z+AQnoAGBHYz/EV/NGq/u+Pt2l29qsd9KKkFPB2hRFlZc9sxuIjVAH/4pPCPSjfrr2HG
         h0GDhjZ3tLxSOUwGRZbfbadcTBtCwJK/0/yUdEcHhkl7GdTxXEkQdEQyVfRila9KVkwa
         5JcK7o948svwySfnZbGyo7xwFbsnqniMHXtFs3MZukSF/iqaQXLfiTbCdgPt8638Wz+g
         d4GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DymYp+zPJ4gzDk8Dx7wSs/LIYE99GkzKtOkNWaWq8P5CxkP2YbAoWvczNLl0hb49BjUdoBgS9@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEt+pua4O6pAAhz/RSBA+PIrgpfgixAW4UwASLDaHmQ76AW6e
	W+qIEKKGyjkcDt4x4zWD6lvOeJqbtJRVHBtNnxSVA+auLKlweTI1ewOd
X-Gm-Gg: AeBDiestxdK70RWu7nAL51aRFf/zqjMcAdlpG21PonSIb1U0GoTEaHHw5RFoFh2g2r9
	EH7ORgOBGQhc3WIIkk0FzoovNUFT9yjzPFc2eHnDkWCXI41l4ulSLNKtCWAaFXK3PM/73XIv3cw
	4XAFIkdSZ7cCI0UIx6Gri8nZDu57EREAs6uaZBfVOSSfPOjf2QcoWKspJw3tbkr0X4XQfwUO3DZ
	VVbkEQ1ZfpfTJzLtLxbqeA+qGXdfHVsNXYmZd0QRfJ2OF+rMQu3U/xJFVSqL5FYgcocNItw6uMv
	YwBeok4LcDB3RktmvjmHTRO2oE3c5+TmkmNQ6nti4SwyBkZN6k+cHm4J4tM2LSHiJV2aaD0mvwK
	XSeXsj2bSB75G+ygJr54bVmhhSZeJX2Mcn6y6NHa42k3ttbhFjABmtdBzsalkFYxowu7ZbLNyKi
	60dn93FWPr7ETxtGiCL1iGQ9TOVRnoI/Q6
X-Received: by 2002:a9d:4542:0:b0:7dc:9908:6cba with SMTP id 46e09a7af769-7dc990882f5mr10393540a34.6.1776976486682;
        Thu, 23 Apr 2026 13:34:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de543a2d7asm911651a34.12.2026.04.23.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:46 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Michal Koutny" <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	David Rientjes <rientjes@google.com>,
	Yiannis Nikolakopoulos <yiannis@zptcorp.com>,
	"Rao, Bharata Bhasker" <bharata@amd.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 0/9 v2] mm/memcontrol: Make memory cgroup limits tier-aware
Date: Thu, 23 Apr 2026 13:34:34 -0700
Message-ID: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15472-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,tencent.com,oracle.com,google.com,huaweicloud.com,gmail.com,redhat.com,lge.com,cs.cmu.edu,zptcorp.com,amd.com,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ACFE4574FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

INTRODUCTION
============
Memory cgroups provide an interface that allow multiple works on a host to
co-exist via weak and strong memory isolation guarantees. This works, because
for the most part, all memory has equal utility. Isolating a cgroup’s memory
footprint restricts how much it can hurt other workloads competing for memory,
or protects it from other cgroups looking for more memory.

However, on systems with tiered memory (e.g. CXL), memory utility is no longer
homogeneous; toptier and lowtier memory provide different performance
characteristics and have different scarcity, meaning memory footprint no longer
serves as an accurate representation of a cgroup’s consumption of the system’s
limited resources. As an extreme example, a cgroup with 10G of toptier
(e.g. DRAM) memory and a cgroup with 10G of lowtier (e.g. CXL) memory both
appear to be consuming the same amount of system resources from memcg’s
perspective, despite the performance asymmetry between the two workloads.

Therefore on tiered systems, memory isolation cannot currently happen, as
workloads that are well-behaved within their memcg limits may still hurt the
performance of other well-behaving workloads by hogging more than its
“fair share” of toptier memory.

Introduce tier-aware memcg limits, which establish independent toptier limits
that scale with the memory limits and the ratio of toptier:total memory
available on the system.

INTERFACE
=========
This series introduces only one adjustable knob to userspace; a new cgroup mount
option “memory_tiered_limits” which toggles whether the cgroup mount will scale
toptier limits. It also introduces 4 new read-only sysfs entries per-cgroup:
memory.toptier_{min, low, high, max}.

The new toptier memory limits are scaled according to the amount of toptier
memory and total memory available on the system as such:

memory.toptier_high = (toptier_mem / total_mem) * memory.high

For instance, on a host with 100GB memory, with 75G toptier and 25G CXL, the
“toptier ratio” would be 75 / 100 = 0.75. A cgroup with the following memcg
limits {min: 8G, low: 12G, high: 20G, max: 24G} might see toptier limits scaled
at {min: 6G, low: 9G, high: 15G, max: 18G}.

USE CASES
=========
There are workloads that benefit from tiered memory limits, and those that do
not. Explicitly, hosts containing multiple workloads with the goal of maximizing
host-level throughput may see a regression because fairness is not free; it comes
at the cost of underutilized toptier memory, overhead to manage memory
migrations, and host-level memory hotness inversion.

On the other hand, fairness can prove to be a valuable resource for a number of
configurations, especially with workloads that want to raise the lower bound on
performance, rather than optimize for raw throughput:
- VM hosting services that must provide the maximal performance guarantee 
  (i.e. supremum) for any workload present on a host.
- Database workloads that want to minimize the maximum latency (i.e. infimum)
  for queries hosted on the host.
- Hosts running memory-isolated sharded workloads that blocks progress until the
  last shard terminates.
- Any workload that wants to minimize variance, as a means to gather measurable
  gains in performance over time.

TESTING
=======
To demonstrate the fairness and minimum performance guarantee increases, I
performed some performance tests across three data access patterns. All tests
were done on a 1T host with 750G DRAM and 250G CXL, spawning 4 220G workloads
{memory.high == memory.max == 220G}. 3 of those workloads are “memory hogs”,
who get to run on the host and pre-allocate all of their memory. The last
workload is the “victim”, who only gets to run once the other 3 workloads have
already allocated their memory. Once the victim allocates its memory as well,
we begin measuring read times for the following setups:
1. random memory access in the 220G anon region
2. hot / cold memory access, where the hot region (100G) gets 90% of the reads,
and the cold region (120G) gets 10% of the reads

First, let’s look at what the results look like with NUMAB=2:

Per-cgroup throughput (Mops/s):
Cgroup     Baseline   Tier-Aware
------     --------   ----------
hog          21.457       17.733
hog          22.773       16.329
hog          22.630       16.549
victim       12.315       16.950

DRAM / CXL distribution (GB):
Cgroup          Baseline              Tier-Aware
------          --------              ----------
hog      220.0 DRAM / 0.0 CXL    181.6 DRAM / 38.4 CXL
hog      220.0 DRAM / 0.0 CXL    181.6 DRAM / 38.4 CXL
hog      220.0 DRAM / 0.0 CXL    181.6 DRAM / 38.4 CXL
victim   69.3 DRAM  / 150.7 CXL  186.7 DRAM / 33.3 CXL

Experiment 2 (hot / cold access)

Per-cgroup throughput (Mops/s):
Cgroup     Baseline   Tier-Aware
------     --------   ----------
wl0          24.280       17.815
wl1          23.929       15.019
wl2          23.645       15.605
wl3          11.624       15.998

DRAM / CXL distribution (GB):
Cgroup          Baseline               Tier-Aware
------          --------               ----------
wl0      220.0 DRAM / 0.0 CXL    181.6 DRAM / 38.4 CXL
wl1      220.0 DRAM / 0.0 CXL    181.6 DRAM / 38.4 CXL
wl2      220.0 DRAM / 0.0 CXL    181.6 DRAM / 38.4 CXL
wl3      70.4 DRAM  / 149.6 CXL  186.7 DRAM / 33.3 CXL

With NUMAB=0, the pattern remains the same, but overall, throughput seems
increased, and variance seems decreased.
I believe there is a negative interaction here between NUMA balancing’s
host-level hotness tracking, and the tier-aware memcg limit’s push to make
memcg-aware migration decisions (see open questions below).

The results above demonstrate the desired effect of fairly distributing CXL
usage across the workloads regardless of when they were launched, and minimizing
performance variance.

OPEN QUESTIONS (for mailing list & for LSFMMBPF)
================================================
1. Should memory.toptier_max be enforced? And if so, what should it look like?
   In my testing, I have found that enforcing memory.toptier_max in the same way
   as memory.max leads to significant throttling, as each allocation above the
   toptier limit causes a loop of allocate on toptier --> scan toptier LRU for
   victim --> demote victim page --> allocate on toptier...
   Thus, in my test above, I ran with the last patch (memory.toptier_max
   enforcement) disabled. Are there use-cases for enforcing memory.toptier_max?
   For this RFC, I’ve included it for review, but I feel that it makes sense to
   drop toptier enforcement.
2. This version of the code does its best to generalize the memcg stock system
   as much as possible, but still only makes a distinction between toptier /
   lowtier. Does it make sense to support 3+ tiers? Are there currently real
   systems / hardware out there that desires to enforce fairness at that scale?
2-1. Should swap be considered its own tier?
3. Should users be able to tune anything? Currently, the only choice is for
   users to enable the limits or not. Options for userspace tuning include:
   setting cgroup-wide toptier limits; system-wide toptier:lowtier ratios;
   cgroup-level toptier:lowtier ratios.
4. Tiered memcg limits interfere with existing promotion mechanisms like NUMA
   balancing (NUMAB2), that promote memory on a systemwide basis, ignoring
   process and memcg contexts. What kinds of promotion mechanisms should be used
   to work in memcg-aware contexts?

DEPENDENCIES
============
This work is built upon my recent RFC [1] to move stocks from the memcg level to
the page_counter level, to make the toptier charging path cheaper. In addition,
this patch is limited to working on LRU folios; kmem memory and memory that is
otherwise not charged on an lruvec-basis (i.e. has both physical node & memcg
information; aka enum memcg_stat_item) is not accounted for. There are landed &
ongoing efforts to introduce per-lruvec accounting for these as well:
- vmalloc (from Johannes): mm-stable [2]
- zswap / zswapped / zswap_incompressible [3]
- percpu: in progress [4]

CHANGELOG V1 --> V2
===================
- The toptier:total ratio calculation has been simplified to ignore cpusets and
  now exist as a system-wide ratio. This came from the realization that having
  cgroups that opt-in and opt-out of CXL co-existing on the system leads to a
  question on how the limits should be enforced, and whether such a configuration
  is even desirable.
- The simplification above means struct page_counter can be per-memcg, not
  mem_cgroup_per_node.
- Independent memcg stock management for toptier
- Included min / max enforcement (for max, see questions above)
- Exported toptier limits as read-only sysfs files
- Turned the build config into a mount option, as suggested by Michal Hocko

Thank you for reading this long cover letter. Have a great day everyone!

[1] https://lore.kernel.org/all/20260410210742.550489-1-joshua.hahnjy@gmail.com/
[2] https://lore.kernel.org/all/20260220191035.3703800-1-hannes@cmpxchg.org/
[3] https://lore.kernel.org/all/20260226192936.3190275-1-joshua.hahnjy@gmail.com/
[4] https://lore.kernel.org/all/20260404033844.1892595-1-joshua.hahnjy@gmail.com/


Joshua Hahn (9):
  cgroup: Introduce memory_tiered_limits cgroup mount option
  mm/memory-tiers: Introduce toptier utility functions
  mm/memcontrol: Refactor page_counter charging in try_charge_memcg
  mm/memcontrol: charge/uncharge toptier memory to mem_cgroup
  mm/memcontrol: Set toptier limits proportional to memory limits
  mm/vmscan, memcontrol: Add nodemask to try_to_free_mem_cgroup_pages
  mm/memcontrol: Make memory.low and memory.min tier-aware
  mm/memcontrol: Make memory.high tier-aware
  mm/memcontrol: Make memory.max tier-aware

 include/linux/cgroup-defs.h  |   5 +
 include/linux/memcontrol.h   |  35 ++++
 include/linux/memory-tiers.h |  17 ++
 include/linux/swap.h         |   3 +-
 kernel/cgroup/cgroup.c       |  12 ++
 mm/memcontrol-v1.c           |   6 +-
 mm/memcontrol.c              | 306 +++++++++++++++++++++++++++++++++++++----
 mm/memory-tiers.c            |  46 +++++-
 mm/vmscan.c                  |  11 +-
 9 files changed, 402 insertions(+), 39 deletions(-)

-- 
2.52.0


