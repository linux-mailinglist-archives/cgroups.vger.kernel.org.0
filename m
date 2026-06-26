Return-Path: <cgroups+bounces-17316-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OyhJHmVTPmr5DgkAu9opvQ
	(envelope-from <cgroups+bounces-17316-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:24:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B86CC0FB
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:24:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17316-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17316-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 088B33009826
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA03ED5D3;
	Fri, 26 Jun 2026 10:24:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D103EDAB6;
	Fri, 26 Jun 2026 10:24:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469462; cv=none; b=Kq5yBnJpfVvmzLUoBHpRZvaBYTrGNb6k9lzD8khI+b10c+tqTEyXdJyusbWpMVlAyMoA7/A1RSlcgRqIeyn8TqbAp+mh5CjDM4kDAA+/wcYl2+D8JMbxgF8v5UsTj2EpVPhQnhBGckD5Oe/sIZgLqOxUubpeA2EkkLYdBlsgr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469462; c=relaxed/simple;
	bh=tVzFlRha4dFksiyF8EG/VwE6CNt6QOwM8UsvZo2iTdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1cD/QIZTZxuiztO+inxq0lcSbk7m5Yvi+rJHAIXi4UQPbpaYolNxpGq9Pi6OvHavr3cIZ03iW6IhsEGG2iET4IlFAAKQQjEXZIRr6UeotGjFrha99/IzM5KIv3AlncYkzDpr6PG8nTNMQzOncO+6KRLm/JB4QohJ6BEwCoIKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Received: by mail.gandi.net (Postfix) with ESMTPSA id F10933EC32;
	Fri, 26 Jun 2026 10:24:05 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: alexandre@ghiti.fr,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Ben Segall <bsegall@google.com>,
	cgroups@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Hildenbrand <david@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kairui Song <kasong@tencent.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [RESEND PATCH v2 0/9] per-memcg-per-node kmem accounting 
Date: Fri, 26 Jun 2026 12:20:49 +0200
Message-ID: <20260626102358.1603618-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFhzY+biii5o3KhBLXaB+yyOv/umMcrPwchRIx4RYTC8ZjuYqysyo8r9nn3JKFmuG5Uk19BkC2D6n8TEC2Mcfy0nWPMVo8nc30IfS2BQHP3oO0XNvewSEjWxb+V+qXMeRrtEKaGMMN9KJMmBImmJx8NHyydw95ZZXxvE37YDgEJZry67dNdgLYaBvPH0mkgJ2HJEix+LUBCmDT45jCR4G82gG4ltLEJD97Z4sTDy7iebPKO3MVGE3lGNo3HwfpWa7pKcvGkNgi9U3x0cVIkCM2Z80V7XQ2XQIbDr+VMH4CwqiT0IbbxGuhT+dlPaPB7avStLr1QMtlPw4YJ5pYQFUwuQTrjyic8RRkpI+HOrJR8UzmJBvLDzvyOTIp1XhAtXJPnou/rxmuzLCAhwpAVltubXwTG0Ddbt+S7/GMg+nC84VtSyU8vJt2okiaHa+RJkDntCIJnrFhrNSB2nj7wjxcaNvVayVgWUvhgTzhHA8Mj3kk5EPtB436pgNAAKIZ8wDZOpoPudHxN5HPh0HX6VzaAILadEft/ZNX0Xrl2eGk9eW2R+jqKebzaW/I6HVplP17GNzD6jQqzR/l3L+Z4HxrYzNfRB5VcpTxDYlySe3pQo+yky0quIy54NBq9uQP7bmricCdorkEiWtOkBnx1Y7cjDeg4qPDhBSGV1QOGln8GTQ
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ghiti.fr];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:axelrasmussen@google.com,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,m:alex@ghiti.fr,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17316-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org,ghiti.fr];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:mid,ghiti.fr:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 684B86CC0FB

This is version 2 of per-memcg-per-node kmem accounting.

As asked by Joshua, I ran some microbenchmarks to check the impact of
this fine grain accounting.

TL;DR: There is a substantial impact (up to +337% on small percpu allocations)
on a benchmark that loops over small percpu allocations. On the other hand,
on a userspace program that creates a bpf percpu map, this cost is not visible.

I followed Joshua's advice and now this version batches the memcg accounting:
it improves the performance +337% vs +417% (v1) on 176 cores single node
machine and +153% vs 206% (v1) on 80 cores 2 nodes machine.

We can see that the overhead of this version scales linearly with the number of
cpus (the number of nodes being small). This overhead comes mainly from
vmalloc_to_page() so I have another variant (b) that decreases the impact even
more (+131% vs +337% on 176 cores and +86% vs +153% on 80 cores) but I'm not
sure the added complexity is needed so I did not send this version, let me know
what you think.

Performance
===========

All benchmarks run in a memcg with __GFP_ACCOUNT.

1) BPF percpu map create/destroy, full series vs baseline kernel (two
   boots, 176-CPU AMD EPYC, 1 NUMA node): the per-node accounting is lost
   in the BPF syscall overhead, the delta is within noise (us/op):

     size (B):    64     256    1024   4096   8192
     delta:     -5.5%  -5.1%  -1.8%  -5.1%  -4.1%

2) In-kernel microbench that isolates the accounting cost: a tight
   __alloc_percpu_gfp()/free_percpu() loop, __GFP_ACCOUNT on vs off on the
   same boot (ACCT COST = on - off). The dominant cost on a many-CPU box
   is discovering each backing page's real node (vmalloc_to_page() per
   possible CPU). ACCT COST by value size:

   176-CPU EPYC, 1 node
     size (B):              64       256      1024     4096     8192
      baseline (upstream)  +5.3%    +5.4%    +0.1%    -1.8%    -0.5%
      v1 credit (per-page) +417.3%  +182.5%  +68.5%   +21.4%   +16.1%
   a) per-node accounting  +337.8%  +141.8%  +36.1%   +11.9%   +6.8%
   b) per-page nid cache   +131.3%  +53.7%   +10.5%   +0.9%    +2.0%
   c) single-node fast     +12.6%   +12.1%   +3.5%    +6.6%    +0.7%

   80-CPU Xeon Gold 6138, 2 nodes (fast path inactive)
     size (B):              64       256      1024     4096     8192
      baseline (upstream)  +1.2%    -3.8%    +12.4%   +1.2%    +0.5%   (noise)
      v1 credit (per-page) +206.1%  +134.0%  +44.5%   +11.6%   +11.5%
   a) per-node accounting  +153.2%  +64.7%   +19.4%   +4.2%    +5.9%
   b) per-page nid cache   +86.5%   +45.5%   +14.7%   +1.8%    +1.6%

   (a) this patchset without fast path for single node
   (b) is an alternative version, not in this series, that caches each backing
       page's node in the chunk so the walk is paid once per page instead of
       once per allocation
   (c) this patchset with fast path for single node

Changes in v2
=============

- objcg lifetime: Shakeel's patch 1 now guarantees the lifetime of every
  per-node objcg
- dropped patch 5 and 6 since Shakeel's patch 2 replaces them
- fixed the number of precharged pages (the v1 formula under-precharged)
- per-node batching (Joshua's suggestion): accumulate the per-node bytes
  first, then issue one account_kmem()/uncharge() per touched node =>
  O(nodes) memcg ops instead of O(num_possible_cpus)
- single-node fast path: skip the per-cpu node walk on single node machines
- obj_exts metadata is now accounted per-node (walk its vmalloc pages)
  rather than charged whole to one memcg (Shakeel's main v1 objection).
- renamed obj_cgroup_get_nid() -> obj_cgroup_nid() (returns a borrowed RCU
  pointer, no ref taken).
- zswap: fixed the missing locking around the per-node objcg lookup (now
  done under RCU + obj_cgroup_tryget()).

This series pursues the work initiated by Joshua [1]. We need kernel
memory to be accounted on a per-node basis in order to be able to know
the memcg <-> physical memory association.

This series takes advantage of the recently introduced per-node
obj_cgroup and makes those obj_cgroup tied to their NUMA node.

The bulk of the series is percpu per-node accounting: percpu
"precharges" the memcg before we know the actual location of the pages
it uses, so charging and accounting had to be split. All other kmem
users (slab, __memcg_kmem_charge_page) are now handled directly by
Shakeel's per-node obj_cgroup infrastructure this series sits on, so
only percpu and zswap need explicit per-node work here (zswap support
is limited because Joshua is working on it in parallel [3]).

Thanks Joshua and Shakeel for the early feedback!

[1] https://lore.kernel.org/linux-mm/20260404033844.1892595-1-joshua.hahnjy@gmail.com/
[2] https://lore.kernel.org/linux-mm/56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com/
[3] https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/

Functional Testing
==================

- Tested with a percpu kmem self-test in an 8-node VM (2 nodes with CPUs,
  6 memory-only). For each allocation it checks that every node is charged
  and later uncharged the same number of bytes -- including a CPU-less node
  that ends up holding the obj_exts metadata -- and that nothing is left
  charged after teardown. All checks pass. (The self-test module is not
  part of this series.)

Alexandre Ghiti (7):
  mm: percpu: fix obj_exts metadata charge size
  mm: percpu: Split memcg charging and kmem accounting
  mm: memcontrol: track MEMCG_KMEM per NUMA node
  mm: percpu: per-node kmem accounting
  mm: percpu: per-node kmem accounting for obj_exts metadata
  mm: percpu: skip the per-cpu node walk on single-node systems
  mm: zswap: per-node kmem accounting for zswap/zsmalloc

Shakeel Butt (2):
  memcg: convert task->objcg to a per-node objcgs array
  memcg: charge kmem pages and slab objects against per-node objcg

 include/linux/memcontrol.h |  23 ++-
 include/linux/mmzone.h     |   1 +
 include/linux/sched.h      |   7 +-
 include/linux/zsmalloc.h   |   2 +
 mm/memcontrol.c            | 286 ++++++++++++++++++++++++++-----------
 mm/percpu-internal.h       |   2 +-
 mm/percpu.c                | 108 +++++++++++++-
 mm/vmstat.c                |   1 +
 mm/zsmalloc.c              |  11 ++
 mm/zswap.c                 |  19 ++-
 10 files changed, 361 insertions(+), 99 deletions(-)

-- 
2.54.0


