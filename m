Return-Path: <cgroups+bounces-17326-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tjcvKUlePmq6EgkAu9opvQ
	(envelope-from <cgroups+bounces-17326-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 13:11:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415056CC4CF
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 13:11:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17326-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17326-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9077300F5EC
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824403EDAAE;
	Fri, 26 Jun 2026 11:11:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CA379EE8;
	Fri, 26 Jun 2026 11:11:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472263; cv=none; b=ql/7LkpDHfyl0RwKeX/0F63fUXw4YnSpIZIxD3yX2j6XoQbaB0ytA/JeZ+jGqqSUvZAy3KM8UKKSt1MRtp/q3P40Zfl0KKY7WSv6WV1wbYDKwV8jUu2jJWLeH8TwxDGq3zRbyup4Xg2tKl+433GmEjXCBSZT/gyN0obGJeUc98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472263; c=relaxed/simple;
	bh=2+zYfTXbCgVSTKENUe8jXkEn98MUdcnb9jsFe9QWo7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJNnTTN9lGd/2tDze/m8AWLG6EmIXYxaZ1xkb8RlxSSh2wjDX3eNtgy/lBbO87okt3KC3NAyxkLMehQFVg5u0TD1odqURapBkoaJKHqylC5gQ+SjETxZfEZLA9t1IIPRzfRaxcNrqzByRBhP8r2T4e57xwa9JwOSbHWublnfj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 35D6858416A;
	Fri, 26 Jun 2026 10:23:35 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8971A3EBB0;
	Fri, 26 Jun 2026 10:23:20 +0000 (UTC)
Message-ID: <c7ed65c7-c5a4-4a20-b230-3a94c001dc38@ghiti.fr>
Date: Fri, 26 Jun 2026 12:23:19 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] per-memcg-per-node kmem accounting
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Barry Song
 <baohua@kernel.org>, Ben Segall <bsegall@google.com>,
 cgroups@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Kairui Song <kasong@tencent.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Liam R. Howlett" <liam@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Yuanchu Xie <yuanchu@google.com>
References: <20260626101356.1599643-1-alex@ghiti.fr>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20260626101356.1599643-1-alex@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Cause: dmFkZTEhdky9hIIMuJGkZ6D0E9bX4u5uN/gwmQdlGtrbAyh4LCB2rKhQLzgWjQW6XDIzKtlmgQujkmwjKg4JaMFj/54OARnVMmRFzAgR2uefgK5+JIwqaEpAd20Q/110HVA/xHloJOGUF+yUFdWLgSEYkKSUMRElM4q6fsR5yVd6yI2Lx+J1iY8OVGWEjK0sVBJ+XCHArRTx9YNoXT1P7asoZ0r+8wbTO9wHmiFe4zBNUKx2QWIPwH8cQOuWaj6mxCydB/Go8hT5mH8/uyCCWZrMQkjKPWGjQ8BY7yOWrAOZA8VNrnnjRCcU3e6x9iSM487IObFPo+nH5ogswY/mfxFFcnMsLGkP+zbLbM2lske3CE7e0LxF7hK3vdSbaMmhIgpaNgn9ZlQcFDmIs5E1MHqccZl/F2MdaDJyw3wyX3nW580MB7BZxMWzR5UDsr545uiwxytoyIXqhFdbAlmFSPA19N74HQ4VvwMUqhABGTwBIR5gY8J57gNIbSR3dPNZsGZ1T5Vp2lUbeK/8EnQrZa7SCJF2Q5FFJgBd/zFyTxYiD3pW/zyHMd3tpuEUCOKqOJdfGWWMveynQBQ/c29FpfLV/Uuo+uACVChnKSnxLT+6y9AZFxjeF1fx8lc28hv2sKK3xtD+0zgyS0N0UdpJ7sm2xHJZZurDalpogVoK8S+SKa7LmA
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org];
	TAGGED_FROM(0.00)[bounces-17326-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:axelrasmussen@google.com,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ghiti.fr:mid,ghiti.fr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 415056CC4CF

Sorry for the noise, too many emails at once, I'll add some delay.

Sorry again,

Alex

On 6/26/26 12:09, Alexandre Ghiti wrote:
> This is version 2 of per-memcg-per-node kmem accounting.
>
> As asked by Joshua, I ran some microbenchmarks to check the impact of
> this fine grain accounting.
>
> TL;DR: There is a substantial impact (up to +337% on small percpu allocations)
> on a benchmark that loops over small percpu allocations. On the other hand,
> on a userspace program that creates a bpf percpu map, this cost is not visible.
>
> I followed Joshua's advice and now this version batches the memcg accounting:
> it improves the performance +337% vs +417% (v1) on 176 cores single node
> machine and +153% vs 206% (v1) on 80 cores 2 nodes machine.
>
> We can see that the overhead of this version scales linearly with the number of
> cpus (the number of nodes being small). This overhead comes mainly from
> vmalloc_to_page() so I have another variant (b) that decreases the impact even
> more (+131% vs +337% on 176 cores and +86% vs +153% on 80 cores) but I'm not
> sure the added complexity is needed so I did not send this version, let me know
> what you think.
>
> Performance
> ===========
>
> All benchmarks run in a memcg with __GFP_ACCOUNT.
>
> 1) BPF percpu map create/destroy, full series vs baseline kernel (two
>     boots, 176-CPU AMD EPYC, 1 NUMA node): the per-node accounting is lost
>     in the BPF syscall overhead, the delta is within noise (us/op):
>
>       size (B):    64     256    1024   4096   8192
>       delta:     -5.5%  -5.1%  -1.8%  -5.1%  -4.1%
>
> 2) In-kernel microbench that isolates the accounting cost: a tight
>     __alloc_percpu_gfp()/free_percpu() loop, __GFP_ACCOUNT on vs off on the
>     same boot (ACCT COST = on - off). The dominant cost on a many-CPU box
>     is discovering each backing page's real node (vmalloc_to_page() per
>     possible CPU). ACCT COST by value size:
>
>     176-CPU EPYC, 1 node
>       size (B):              64       256      1024     4096     8192
>        baseline (upstream)  +5.3%    +5.4%    +0.1%    -1.8%    -0.5%
>        v1 credit (per-page) +417.3%  +182.5%  +68.5%   +21.4%   +16.1%
>     a) per-node accounting  +337.8%  +141.8%  +36.1%   +11.9%   +6.8%
>     b) per-page nid cache   +131.3%  +53.7%   +10.5%   +0.9%    +2.0%
>     c) single-node fast     +12.6%   +12.1%   +3.5%    +6.6%    +0.7%
>
>     80-CPU Xeon Gold 6138, 2 nodes (fast path inactive)
>       size (B):              64       256      1024     4096     8192
>        baseline (upstream)  +1.2%    -3.8%    +12.4%   +1.2%    +0.5%   (noise)
>        v1 credit (per-page) +206.1%  +134.0%  +44.5%   +11.6%   +11.5%
>     a) per-node accounting  +153.2%  +64.7%   +19.4%   +4.2%    +5.9%
>     b) per-page nid cache   +86.5%   +45.5%   +14.7%   +1.8%    +1.6%
>
>     (a) this patchset without fast path for single node
>     (b) is an alternative version, not in this series, that caches each backing
>         page's node in the chunk so the walk is paid once per page instead of
>         once per allocation
>     (c) this patchset with fast path for single node
>
> Changes in v2
> =============
>
> - objcg lifetime: Shakeel's patch 1 now guarantees the lifetime of every
>    per-node objcg
> - dropped patch 5 and 6 since Shakeel's patch 2 replaces them
> - fixed the number of precharged pages (the v1 formula under-precharged)
> - per-node batching (Joshua's suggestion): accumulate the per-node bytes
>    first, then issue one account_kmem()/uncharge() per touched node =>
>    O(nodes) memcg ops instead of O(num_possible_cpus)
> - single-node fast path: skip the per-cpu node walk on single node machines
> - obj_exts metadata is now accounted per-node (walk its vmalloc pages)
>    rather than charged whole to one memcg (Shakeel's main v1 objection).
> - renamed obj_cgroup_get_nid() -> obj_cgroup_nid() (returns a borrowed RCU
>    pointer, no ref taken).
> - zswap: fixed the missing locking around the per-node objcg lookup (now
>    done under RCU + obj_cgroup_tryget()).
>
> This series pursues the work initiated by Joshua [1]. We need kernel
> memory to be accounted on a per-node basis in order to be able to know
> the memcg <-> physical memory association.
>
> This series takes advantage of the recently introduced per-node
> obj_cgroup and makes those obj_cgroup tied to their NUMA node.
>
> The bulk of the series is percpu per-node accounting: percpu
> "precharges" the memcg before we know the actual location of the pages
> it uses, so charging and accounting had to be split. All other kmem
> users (slab, __memcg_kmem_charge_page) are now handled directly by
> Shakeel's per-node obj_cgroup infrastructure this series sits on, so
> only percpu and zswap need explicit per-node work here (zswap support
> is limited because Joshua is working on it in parallel [3]).
>
> Thanks Joshua and Shakeel for the early feedback!
>
> [1] https://lore.kernel.org/linux-mm/20260404033844.1892595-1-joshua.hahnjy@gmail.com/
> [2] https://lore.kernel.org/linux-mm/56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com/
> [3] https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/
>
> Functional Testing
> ==================
>
> - Tested with a percpu kmem self-test in an 8-node VM (2 nodes with CPUs,
>    6 memory-only). For each allocation it checks that every node is charged
>    and later uncharged the same number of bytes -- including a CPU-less node
>    that ends up holding the obj_exts metadata -- and that nothing is left
>    charged after teardown. All checks pass. (The self-test module is not
>    part of this series.)
>
> Alexandre Ghiti (7):
>    mm: percpu: fix obj_exts metadata charge size
>    mm: percpu: Split memcg charging and kmem accounting
>    mm: memcontrol: track MEMCG_KMEM per NUMA node
>    mm: percpu: per-node kmem accounting
>    mm: percpu: per-node kmem accounting for obj_exts metadata
>    mm: percpu: skip the per-cpu node walk on single-node systems
>    mm: zswap: per-node kmem accounting for zswap/zsmalloc
>
> Shakeel Butt (2):
>    memcg: convert task->objcg to a per-node objcgs array
>    memcg: charge kmem pages and slab objects against per-node objcg
>
>   include/linux/memcontrol.h |  23 ++-
>   include/linux/mmzone.h     |   1 +
>   include/linux/sched.h      |   7 +-
>   include/linux/zsmalloc.h   |   2 +
>   mm/memcontrol.c            | 286 ++++++++++++++++++++++++++-----------
>   mm/percpu-internal.h       |   2 +-
>   mm/percpu.c                | 108 +++++++++++++-
>   mm/vmstat.c                |   1 +
>   mm/zsmalloc.c              |  11 ++
>   mm/zswap.c                 |  19 ++-
>   10 files changed, 361 insertions(+), 99 deletions(-)
>

