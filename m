Return-Path: <cgroups+bounces-17777-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xUJaA3goVmo50QAAu9opvQ
	(envelope-from <cgroups+bounces-17777-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:15:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D65754611
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:15:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17777-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17777-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=honor.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E39993004F29
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6AA3C0633;
	Tue, 14 Jul 2026 12:15:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AE3BFAE2;
	Tue, 14 Jul 2026 12:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031344; cv=none; b=N8aIhMAWD3/oFjz9BIIvFfswqhCEL85ZNFj0/DErnwCnay3hoMxInLLUkUu1XFNcDDuX+mNX8ClYZVp8iHfQXGTO+Yrgigs2vmu5KeaUyCWtX6VmD+iXvCz4GxPm9sJSR11IyeV79OX4kK9apcdz+EWC3ENsyS/lOJrQvb50HPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031344; c=relaxed/simple;
	bh=f6X73vT6jN5sHClUY/oGE694V8DJVGQ17AUdVqnsvHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l+Uqg3hTp1rhgmDcjzN7e78K7QdWsxLPu5ScKZiNDGLFphaGV3tlEv+l/ydBtTLagnWDl1lf5AmRoGgvR2pBjCGGaTqlzygtIfMG6l0XwZk81NCqorG1zuzfrUkHMZm+EE6fgUOROCvk+fLIndl9d2Rsa6q8Rj4Q0KaXZ8II/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Received: from TW005.hihonor.com (unknown [10.72.0.123])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gzytp13bjzYl7D0;
	Tue, 14 Jul 2026 20:15:30 +0800 (CST)
Received: from TA012-1.hihonor.com (10.77.199.132) by TW005.hihonor.com
 (10.72.0.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 20:15:29 +0800
Received: from localhost.localdomain (10.144.5.36) by TA012-1.hihonor.com
 (10.77.199.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Jul
 2026 20:15:19 +0800
From: Zicheng Wang <wangzicheng@honor.com>
To: <akpm@linux-foundation.org>, <yuanchu@google.com>
CC: <tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<corbet@lwn.net>, <kasong@tencent.com>, <qi.zheng@linux.dev>,
	<shakeel.butt@linux.dev>, <baohua@kernel.org>, <axelrasmussen@google.com>,
	<weixugc@google.com>, <david@kernel.org>, <ljs@kernel.org>,
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <roman.gushchin@linux.dev>,
	<muchun.song@linux.dev>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<willy@infradead.org>, <denghaojie@honor.com>, <baoquan.he@linux.dev>,
	<kaleshsingh@google.com>, <tjmercier@google.com>, <tao.wangtao@honor.com>,
	<zhangji1@honor.com>, <wangzhen5@honor.com>, Zicheng Wang
	<wangzicheng@honor.com>
Subject: [RFC v2 0/3] mm/mglru: proactive aging via memory.aging
Date: Tue, 14 Jul 2026 20:15:26 +0800
Message-ID: <20260714121529.2237261-1-wangzicheng@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TW004-1.hihonor.com (10.77.232.85) To TA012-1.hihonor.com
 (10.77.199.132)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[honor.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17777-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:yuanchu@google.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:willy@infradead.org,m:denghaojie@honor.com,m:baoquan.he@linux.dev,m:kaleshsingh@google.com,m:tjmercier@google.com,m:tao.wangtao@honor.com,m:zhangji1@honor.com,m:wangzhen5@honor.com,m:wangzicheng@honor.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98D65754611

MGLRU inverts the reclaim order when anonymous memory is faulted in
bulk: anonymous pages sit in the young generations while file pages
sit in the oldest two, so reclaim evicts hot file pages before cold
anonymous pages.  swappiness cannot correct it.  This series adds a
per-cgroup proactive-aging operation, memory.aging, with the
observability to drive it as a closed loop, so userspace can rebalance
a cgroup's generations before reclaim runs.

The problem
-----------

MGLRU places pages by access path, not hotness.  On the current tree
the entry rules in lru_gen_folio_seq() give:

  - faulted-in pages (anonymous pages; the fault path sets the active
    mark) land at the 2nd youngest generation (max_seq - 1);
  - file pages from read()/fadvise() land in the oldest two
    generations: non-workingset at min_seq, workingset at min_seq + 1.

Pictorially, for a full four-generation window::

       youngest                          oldest
       max_seq   max_seq-1   min_seq+1   min_seq
       -------------------------------------------
 anon    .          X           .           .     (faulted in)
 file    .          .           X           X     (read/fadvise)
                                            ^
                              reclaim scans from here -> evicts file first

Reclaim scans from min_seq, so file pages are evicted before the
anonymous pages two generations younger, a hot/cold inversion.

swappiness does not fix it: it only selects which type to scan, not
the ordering within a type, so reclaim can still evict hot pages.
swappiness=201 (SWAPPINESS_ANON_ONLY) just flips the inversion to the
other side: no value recovers a correct hot/cold order, because the
order comes from the access path, not access recency [1].  This is not
Android-specific; the same file over-reclaim is shown on servers and
worked around there by forcing an age iteration before reclaim.

Why userspace-driven
--------------------

The benefit is workload-dependent: file-cache-bound servers gain from
aging, anon-bound servers do not, so no kernel default is correct for
all.  The kernel also cannot know when to age: on Android the right
moment is the foreground-to-background transition, when the app's pages
are cold but their PTE accessed bits are still accurate from foreground
execution, a framework concept.  The kernel therefore provides the
mechanism; userspace runs the loop.

Design: observation and control
-------------------------------

The series gives userspace one control primitive and the observation to
use it.  All three pieces are per-cgroup and gated by CONFIG_LRU_GEN,
and together they form a closed loop:

  control   memory.aging          write nr_gens to advance max_seq without
                                  reclaim; the aging counterpart of
                                  memory.reclaim
  observe   nr_oldest_anon/file   pages in the oldest generation of each
                                  type: what the next reclaim can evict
            aging                 number of aging passes, paired with
                                  workingset_refault to spot over-aging

A policy reads nr_oldest_* to see whether anon is sheltered, ages with
memory.aging, then checks the aging counter and workingset_refault.
A typical flow ages to rebalance, then reclaims::

    echo 2 > /sys/fs/cgroup/foo/memory.aging
    echo "100M" > /sys/fs/cgroup/foo/memory.reclaim

Why cgroup v2
-------------

memory.reclaim already lives in cgroup v2, but it is broken when
anonymous pages are sheltered in the young generations: reclaim cannot
reach anon until aging advances it.  A useful memory.reclaim therefore
requires aging first.  Aging is not a new MGLRU detail leaked into
cgroup v2; it is the other half of the proactive-reclaim operation
cgroup v2 already exposes.  Putting it anywhere else (sysfs) cuts one
operation across two ABIs and two addressing models.

memory.aging is gated by CONFIG_LRU_GEN and exposes one primitive
(advancing the generation), not internal data structures; if MGLRU is
removed, the file goes with it.

Alternatives considered
-----------------------

1) sysfs (/sys/kernel/mm/lru_gen/) fights sysfs's one-value-per-file,
stateless model: the command is multi-argument and per-(memcg,node),
the read is parameterized per memcg, and css-id addressing is hostile
to cgroup paths.  It also splits aging from memory.reclaim.

2) in-kernel automatic aging is workload-dependent (memcached regresses)
and needs a trigger the kernel cannot know: the Android
foreground-to-background moment is a framework concept.  MGLRU had this
once: `should_run_aging' fired on a generation-balance heuristic::

    if (young * MIN_NR_GENS > total)
        return true;
    if (old * (MIN_NR_GENS + 2) < total)
        return true;


3) extending memory.reclaim to run the debugfs aging command
(`+ memcg_id node_id seq`) overloads a reclaim file with a non-reclaim
operation and pulls MGLRU's debugfs command syntax into a generic
cgroup v2 ABI. But Aging is reclaim's counterpart, not one of its modes.

Results
-------
N39 (Device-X1 8 GB/SM7750, Device-X2 12 GB/SM8750).  Production telemetry,
~300 users, 30K+ device-hours:
    keep-alive          +15.4% (8 GB) / +10.2% (12 GB)
    IME dismiss latency -47.2%
    launch/exit jank >50ms   eliminated
    one aging pass      342 us median, never on a UX thread

AN90 (a new shipping product, separate from N39):
    scroll jank >50 ms  -22%, severe jank -26%
    cold-launch stalls >= 3 s  eliminated
    workingset_refault (anon + file) and direct reclaim both down

Server (Intel i7-14700F, 20C/28T, 32 GB DDR5-5600, 1 TB NVMe,
Ubuntu 24.04; same root cause, aging triggered on the
reclaim path when anon in the oldest gen ratio < 10%):
    fio random-read     +31.8%
    ripgrep             +15.8%
    memcached           -1.2%   (anon-bound; expected no gain)

N39 and AN90 are different products.

Why RFC
-------

v1 [2] put the control in procfs/debugfs and was NAKed for the
cgroup-v2 venue.  This version keeps aging in cgroup v2, next to
memory.reclaim, and argues why above.  Discussed at LSF/MM 2026 [3].

[1] swappiness=0/201 hot/cold inversion, and why the straightforward
    fix is deferred:
    https://lore.kernel.org/linux-mm/7829b070df1b405dbc97dd6a028d8c8a@honor.com/
[2] v1: https://lore.kernel.org/linux-mm/20251128025315.3520689-1-wangzicheng@honor.com/
[3] LSF/MM 2026 slides:
    https://docs.google.com/presentation/d/1hUogz6InyLn13c8CjHuvEIzE4rT7saVRUV6xpWZoNfQ/

Changes since v1
----------------

- Dropped the debugfs -> procfs move; aging is now a cgroup v2 file.
- Added the AGING counter and nr_oldest_anon/file observability.
- Corrected the generation-placement description to the current tree
  (faults at the 2nd youngest, file in the oldest two).

Zicheng Wang (3):
  mm/lru_gen: add AGING counter and proactive aging helper
  mm: memcontrol: add memory.aging cgroup v2 file
  mm/lru_gen: expose oldest-generation page counts in memory.stat

 Documentation/admin-guide/cgroup-v2.rst       |  53 +++++++++++
 Documentation/admin-guide/mm/multigen_lru.rst |  13 +++
 include/linux/mmzone.h                        |   3 +
 mm/internal.h                                 |  19 +++++
 mm/memcontrol.c                               |  63 +++++++++++
 mm/vmscan.c                                   | 109 +++++++++++++++++++++
 mm/vmstat.c                                   |   3 +
 7 files changed, 263 insertions(+)

--
2.25.1


