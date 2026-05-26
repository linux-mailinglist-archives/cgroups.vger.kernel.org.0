Return-Path: <cgroups+bounces-16265-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMdyKaYDFWroSAcAu9opvQ
	(envelope-from <cgroups+bounces-16265-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:21:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618845CFD07
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC5DE3025C71
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592332F7F1C;
	Tue, 26 May 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gss87dME"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5B2F7EF4
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762065; cv=none; b=cYE+53oYOEla1ZMxjaar6SH0z5YOegozfDFNw/jVDOc7sCkE0/ocRhgYUN0UreKV0Y0gqXnMIhKAJWvb2iJhqPlaPhr4DlSsjvwCHxdaO597pR3gQ0GFV2SBU2eGl0p5543cKvurC9sv8gUplSjSwibSvu7BafVxmTCHqPNpt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762065; c=relaxed/simple;
	bh=jxbQtPWiD8z/y6LHkqpQkX0TRjaK0QSUUdmqZoB2NmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clGi25dHmkntcNuY/A2bmt2YJp+D9MsKqz8fJQgL5qb3hRX7rMtmgPA9iNkdcgdCHsnBzKkcwvDVN6FdiAKWRRUZo0DbAJFJfocJCOtFeh4cmPt2jSKxlkdZfjppw3YCbT8bpaHNv3eJxoXaQiLqeLgXSxkhnYjGCz38+iIYnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gss87dME; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779762050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2rloST2NCoHCAq7gdsKaACZnbUBTPUBoStCUJlsOePI=;
	b=gss87dME3r8jjT2NmdHBT7jfigAVBF4kCG7FspYLp8vTMVRS8+5TnDzNyk7b365uND/0vS
	WRGOjL2XLMPWF6XcUv44GosqUYMazfpkFxFcT/YDjMrm1GIY5NWF1eO6oRopZSWllMvh9n
	pTVapLf9seyuEmTLGAMAhxqy+1D8hwU=
From: Hui Zhu <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	KP Singh <kpsingh@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	Hao Luo <haoluo@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org,
	baohua@kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: [RFC PATCH bpf-next v7 00/11] mm: BPF struct_ops for dynamic memory protection and async reclaim
Date: Tue, 26 May 2026 10:20:00 +0800
Message-ID: <cover.1779760876.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16265-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,patchew.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 618845CFD07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hui Zhu <zhuhui@kylinos.cn>

Overview:
This series introduces BPF struct_ops support for the memory controller,
enabling userspace BPF programs to implement custom, dynamic memory
management policies per cgroup. The feature allows BPF programs to hook
into the core reclaim and charge paths without requiring kernel
modifications, providing a flexible alternative to static knobs such as
memory.low and memory.min.
 
The series enables two complementary use cases.
 
Dynamic memory protection: static memory protection thresholds
(memory.low, memory.min) are poor fits for workloads whose actual memory
activity varies over time. A high-priority cgroup holding a large working
set but temporarily idle will still suppress reclaim on its siblings,
wasting available memory. A BPF-driven approach can observe real workload
activity -- page faults, charge/uncharge events -- and activate or
withdraw protection dynamically. The test results at the end of this
letter quantify the difference: in a scenario where the high-priority
cgroup is idle, the BPF-controlled low-priority cgroup achieves roughly
37x higher throughput than with static memory.low.
 
Asynchronous proactive reclaim: the memcg_charged and memcg_uncharged
hooks, combined with the BPF workqueue mechanism and the new
bpf_try_to_free_mem_cgroup_pages() kfunc, enable BPF programs to perform
proactive background reclaim without blocking the charge path. The
pattern works as follows: the memcg_charged callback tracks accumulated
memory usage; when usage crosses a configurable threshold, it enqueues an
asynchronous work item via bpf_wq_start() and returns immediately without
throttling the charging task. The workqueue callback then invokes
bpf_try_to_free_mem_cgroup_pages() to reclaim pages from the target
cgroup; if usage remains elevated after reclaim, the callback re-enqueues
itself to continue. This allows a BPF program to keep a cgroup's
footprint below its hard limit (memory.max) entirely in the background,
avoiding the OOM killer or direct-reclaim stalls that would otherwise
occur. The selftest for this feature (patch 10/11) validates the
mechanism concretely: a workload that writes and mmaps a 64 MB file inside
a 32 MB cgroup reliably triggers memory.events "max" events without BPF;
with the async reclaim program attached, the "max" counter does not
increase at all across the same workload.
 
In this patch series, I've incorporated a portion of Roman's patch in
[1] to ensure the entire series can be compiled cleanly with bpf-next.
 
Patch Breakdown:
Patches 1-4 are from Roman Gushchin's series [1], included here to
provide the necessary BPF infrastructure for attaching struct_ops to
cgroups.
 
Patches 5-11 are the new work in this series:
 
  05/11  bpf: Pass flags in bpf_link_create for struct_ops
         Stores attr->link_create.flags in struct bpf_struct_ops_link
         and extends the validation to allow BPF_F_ALLOW_OVERRIDE.
         Also updates the UAPI comment to reflect that cgroup-bpf attach
         flags now apply to BPF_LINK_CREATE in addition to
         BPF_PROG_ATTACH.
 
  06/11  mm: memcontrol: Add BPF struct_ops for memory controller
         The core feature patch. Introduces the memcg_bpf_ops struct_ops
         type with the following hooks:
 
         - memcg_charged(memcg, batch): called on the synchronous charge
           path. Returns a throttling delay in milliseconds; used as a
           lower bound for __mem_cgroup_handle_over_high(), effective
           even when memory.high is not breached.
 
         - memcg_uncharged(memcg, batch): called on uncharge, allowing
           BPF programs to track memory releases.
 
         - below_low(memcg, elow, usage): overrides the memory.low
           protection check. Returns true to treat the cgroup as
           protected regardless of the elow >= usage comparison.
 
         - below_min(memcg, emin, usage): same as below_low but for
           memory.min protection.
 
         - handle_cgroup_online/offline(memcg): lifecycle callbacks for
           per-cgroup state management in BPF programs.
 
         BPF_F_ALLOW_OVERRIDE is supported: when a program is registered
         with this flag, descendant cgroups may attach their own
         memcg_bpf_ops to override the inherited policy. Registration
         propagates ops down through the subtree via mem_cgroup_iter;
         unregistration restores each descendant to the ops its
         registering ancestor's parent held, correctly preserving
         override chains.
 
  07/11  mm/bpf: Add bpf_try_to_free_mem_cgroup_pages kfunc
         Exposes try_to_free_mem_cgroup_pages() to BPF programs as a
         KF_SLEEPABLE kfunc. A swappiness parameter controls the
         override value passed to the core reclaim path
         (effective only when MEMCG_RECLAIM_PROACTIVE is set in
         reclaim_options).
 
  08/11  selftests/bpf: Add tests for memcg_bpf_ops
         Adds prog_tests/memcg_ops.c covering three scenarios:
         memcg_charged-only throttling, below_low + memcg_charged
         interaction, and below_min + memcg_charged interaction. A
         tracepoint on memcg:count_memcg_events (PGFAULT) is used to
         detect memory pressure and trigger hooks accordingly.
 
  09/11  selftests/bpf: Add test for memcg_bpf_ops hierarchies
         Validates BPF_F_ALLOW_OVERRIDE attachment semantics across a
         three-level cgroup hierarchy: attach with ALLOW_OVERRIDE at the
         root, override at the middle level without the flag, then assert
         that attaching to the leaf correctly fails with -EBUSY.
 
  10/11  selftests/bpf: Add selftest for memcg async reclaim via BPF
         Demonstrates and validates asynchronous memory reclaim: a BPF
         program uses the memcg_charged/memcg_uncharged hooks to track
         accumulated usage and, when a threshold is exceeded, enqueues a
         bpf_wq_start() workqueue item that calls
         bpf_try_to_free_mem_cgroup_pages() without blocking the charge
         path. The test asserts that with the BPF program active,
         memory.events "max" events do not increase under a workload
         that would otherwise exceed the hard limit.
 
  11/11  samples/bpf: Add memcg priority control and async reclaim example
         Adds a complete sample (samples/bpf/memcg.bpf.c + memcg.c)
         demonstrating both features. The BPF side monitors PGFAULT
         events on a high-priority cgroup; when the per-second fault
         count crosses a configurable threshold, it activates below_low
         or below_min protection for the high-priority cgroup and/or
         applies a charge delay to the low-priority cgroup. Six
         struct_ops variants are exported so userspace can attach only
         the hooks needed. Async reclaim is optionally combined with
         priority throttling via a shared low-cgroup ops map.
 
Test Environment:
The following examples run on x86_64 QEMU (10 CPUs, 2 GB RAM), using
a tmpfs-backed file on the host as a swap device to reduce I/O impact.
Two cgroups are created -- high (high-priority) and low (low-priority)
-- and each test runs two concurrent stress-ng workloads, one per
cgroup, each requesting 3 GB of memory.
 
  # mkdir /sys/fs/cgroup/high /sys/fs/cgroup/low
  # free -h
                 total   used    free  shared  buff/cache  available
  Mem:           1.9Gi  317Mi  1.6Gi   1.0Mi       144Mi      1.6Gi
  Swap:          4.0Gi     0B  4.0Gi
 
Baseline: no memory priority policy:
Both cgroups run without any reclaim protection. Results are roughly
equal, as expected:
 
  cgroup    bogo ops/s
  high           4,979
  low            4,927
 
Test 1: memory.low protection:
Setting memory.low on the high-priority cgroup protects it from
reclaim, at the cost of pushing reclaim pressure onto the low-priority
cgroup:
 
  # echo $((3 * 1024 * 1024 * 1024)) > /sys/fs/cgroup/high/memory.low
 
  cgroup    bogo ops/s
  high         450,290
  low           11,307
 
The high-priority cgroup benefits significantly, but memory.low relies
on static usage thresholds and cannot adapt to actual workload
behavior.
 
Test 2: memory.low with an idle high-priority task:
Here the high-priority cgroup runs a Python script that allocates 3 GB
and then sleeps, simulating a low-activity but memory-holding workload.
Because the process is idle, it generates no page faults and does not
actively use its memory. Yet memory.low still protects it, continuing
to suppress the low-priority cgroup's performance:
 
  cgroup    bogo ops/s
  low           14,757
 
The low-priority cgroup remains significantly throttled despite the
high-priority cgroup being effectively idle -- a clear limitation of
static memory.low control.
 
Test 3: memcg eBPF -- dynamic priority control:
memcg is a sample program introduced in this patch series
(samples/bpf/memcg.c + memcg.bpf.c). It loads a BPF program that
monitors PGFAULT events in the high-priority cgroup. When the
per-second fault count exceeds a configured threshold, the hook
activates below_min protection for one second; otherwise the cgroup
receives no special treatment.
 
  # ./memcg --low_path=/sys/fs/cgroup/low  \
            --high_path=/sys/fs/cgroup/high \
            --threshold=1 --use_below_min
  Successfully attached!
 
3a. Both cgroups under active memory pressure:
 
When both cgroups run stress-ng, the high-priority cgroup generates
frequent page faults and the BPF hook activates protection, matching
the behavior of memory.low:
 
  cgroup    bogo ops/s
  high         404,392
  low           11,404
 
3b. High-priority cgroup is idle (Python + sleep):
 
Because the sleeping Python process generates no page faults, the BPF
hook never activates, and the low-priority cgroup is free to reclaim
memory normally:
 
  cgroup    bogo ops/s
  low          551,083
 
This is a ~37x improvement over the equivalent memory.low scenario
(Test 2), demonstrating that eBPF-driven dynamic control can
accurately reflect actual workload activity and avoid unnecessary
protection of idle high-priority tasks.
 
Summary:
  Scenario                          low-cgroup bogo ops/s
  Baseline (no policy)                           ~4,927
  memory.low, both active                       ~11,307
  memory.low, high idle                         ~14,757
  memcg eBPF, both active                       ~11,404
  memcg eBPF, high idle                        ~551,083
 
References:
[1] https://patchew.org/linux/20260127024421.494929-1-roman.gushchin@linux.dev/

Changelog:
v7:
Change base commits of "mm: BPF OOM" to v3.
Some fixes according to the comments of bpf-ci.
Rename get_high_delay_ms hook to memcg_charged; add memcg_uncharged
hook for tracking uncharge events.
Update below_low and below_min hooks to receive elow/emin and usage
as explicit arguments.
Add bpf_try_to_free_mem_cgroup_pages kfunc to expose cgroup reclaim
to BPF programs.
Add selftest for BPF-driven asynchronous page reclaim.
Extend samples/bpf/memcg to support async reclaim in addition to
priority throttling.
v6:
Based on the bot+bof-ci comments, fixed the following issues.
Added fast-path check with unlikely() before SRCU lock acquisition to
optimize the no-BPF case in BPF_MEMCG_CALL.
Add missing newline in pr_warn message to bpf_memcontrol_init.
Added comprehensive child process exit status checking with WIFEXITED()
and WEXITSTATUS(), and added zombie process prevention in
real_test_memcg_ops.
Changed malloc() to calloc() for BSS data allocation in all test
functions and samples main function.
Change srcu_read_lock(&memcg_bpf_srcu) to
lockdep_assert_held(&cgroup_mutex) in function memcontrol_bpf_online
and memcontrol_bpf_offline.
v5:
Based on the bot+bof-ci comments, fixed the following issues.
Fixed issues in memcg_ops.c and memcg.bpf.c by moving variable
declaration to the beginning of need_threshold() function.
The 'u64 current_ts' variable must be declared before any
executable statements
Improved input validation in samples/bpf/memcg.c by adding a new
parse_u64() helper function. This function properly handles errors
from strtoull() and provides better error messages when parsing
threshold and over_high_ms command-line arguments.
Move check for prog->sleepable after validating member offsets in
mm/bpf_memcontrol.c bpf_memcg_ops_check_member.
Fixed sscanf return value checking in prog_tests/memcg_ops.c.
Changed the condition from 'sscanf() < 0' to 'sscanf() != 1' because
sscanf returns the number of successfully matched items, not a negative
value on error. This makes the test more reliable when reading timing
data from temporary files.
v4:
Fix the issues according to the comments from bot+bof-ci.
According to JP Kobryn's comments, move exit(0) from
real_test_memcg_ops_child_work to real_test_memcg_ops.
Fix issues in the bpf_memcg_ops_reg function.
v3:
According to the comments from Michal Koutný and Chen Ridong, update hooks
to get_high_delay_ms, below_low, below_min, handle_cgroup_online, and
handle_cgroup_offline.
According to Michal Koutný's comments, add BPF_F_ALLOW_OVERRIDE
support to memcg_bpf_ops.
v2:
According to Tejun Heo's comments, rebased on Roman Gushchin's BPF
OOM patch series [1] and added hierarchical delegation support.
According to the comments from Roman Gushchin and Michal Hocko, designed
concrete use case scenarios and provided test results.

Hui Zhu (7):
  bpf: Pass flags in bpf_link_create for struct_ops
  mm: memcontrol: Add BPF struct_ops for memory controller
  mm/bpf: Add bpf_try_to_free_mem_cgroup_pages kfunc
  selftests/bpf: Add tests for memcg_bpf_ops
  selftests/bpf: Add test for memcg_bpf_ops hierarchies
  selftests/bpf: Add selftest for memcg async reclaim via BPF
  samples/bpf: Add memcg priority control and async reclaim example

Roman Gushchin (4):
  bpf: move bpf_struct_ops_link into bpf.h
  bpf: allow attaching struct_ops to cgroups
  libbpf: fix return value on memory allocation failure
  libbpf: introduce bpf_map__attach_struct_ops_opts()

 MAINTAINERS                                   |   6 +
 include/linux/bpf-cgroup-defs.h               |   3 +
 include/linux/bpf-cgroup.h                    |  16 +
 include/linux/bpf.h                           |  10 +
 include/linux/memcontrol.h                    | 250 ++++++-
 include/uapi/linux/bpf.h                      |   5 +-
 kernel/bpf/bpf_struct_ops.c                   |  67 +-
 kernel/bpf/cgroup.c                           |  46 ++
 mm/bpf_memcontrol.c                           | 355 +++++++++-
 mm/memcontrol.c                               |  43 +-
 samples/bpf/.gitignore                        |   1 +
 samples/bpf/Makefile                          |   8 +-
 samples/bpf/memcg.bpf.c                       | 380 +++++++++++
 samples/bpf/memcg.c                           | 411 ++++++++++++
 tools/include/uapi/linux/bpf.h                |   3 +-
 tools/lib/bpf/libbpf.c                        |  22 +-
 tools/lib/bpf/libbpf.h                        |  14 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/cgroup_helpers.c  |  41 ++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +
 .../bpf/prog_tests/memcg_async_reclaim.c      | 333 +++++++++
 .../selftests/bpf/prog_tests/memcg_ops.c      | 634 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_async_reclaim.c | 203 ++++++
 tools/testing/selftests/bpf/progs/memcg_ops.c | 132 ++++
 24 files changed, 2952 insertions(+), 34 deletions(-)
 create mode 100644 samples/bpf/memcg.bpf.c
 create mode 100644 samples/bpf/memcg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_async_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops.c

-- 
2.43.0


