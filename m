Return-Path: <cgroups+bounces-13459-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCRAFPCJeGmqqwEAu9opvQ
	(envelope-from <cgroups+bounces-13459-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:48:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95092072
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF5B3072DAE
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B42DC765;
	Tue, 27 Jan 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="be48htH7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652922E1EF8
	for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507013; cv=none; b=hCpreLFSLF2gIseXY4JFe5lzlKpNkS5V5MxsdZ547NAwwIAabSe7Cm3muM9JbmJJZaoMQSWPLD5KMskGr5QUnDtKXWduKmCZa5Ml/RmgCwP32fVI4I5Cq+jcrcb+WYC2NI1e325XUDDFYUxVavbanbpR1ykLrmP4QNWNmZ1O844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507013; c=relaxed/simple;
	bh=aPEE69+fQYyHXyhqbTFMx2QewPW1lY9T/brWmIi6cJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=juyfRYfgt2nmiq/ooTRMXXDrkx7Bc87mYbgqcCdg0wVWK2GBiuPq43SPfZkRpaPD/Wk0207m3u7MebWjqbJfAyPR98PGIso6DaG/DJNwwe7A49tenvIjPSCDxsIBtAhHISkIXm+JsjmuqLqWwS1RfHTleHx/hEFB+J3S8HOL334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=be48htH7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769506999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PoKU+Y425dJfiv74RFmNKLX9yNp7umKwqq5sbb5Qq14=;
	b=be48htH7QTc+UDw03iq9fTtuH0rIDTlUtWCkiHXQLDkIMCr2LrH38/bnd712FnniWBZRLw
	F8ReErwdb3eu2WMFghK1yeG1mUU9JUHIIEiDwBbbPi1yfgVQw7NIF0+z6L66TlRJUn8opn
	PqJu0Vx6OTJL8gqDazo7kt2kl9V/YPc=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
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
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [RFC PATCH bpf-next v5 00/12] mm: memcontrol: Add BPF hooks for memory controller
Date: Tue, 27 Jan 2026 17:42:37 +0800
Message-ID: <cover.1769506741.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13459-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,ubuntu:email,kylinos.cn:mid,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC95092072
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

Changelog:
v5:
Fix the issues acccording to the comments of bot+bof-ci.
v4:
Fix the issues acccording to the comments of bot+bof-ci.
According to the comments of JP Kobryn, move exit(0) from
real_test_memcg_ops_child_work to real_test_memcg_ops.
Fix the issues in the function bpf_memcg_ops_reg.
v3:
According to the comments of Michal Koutný and Chen Ridong, update hooks
to get_high_delay_ms, below_low, below_min, handle_cgroup_online and
handle_cgroup_offline.
According to the comments of Michal Koutný, add BPF_F_ALLOW_OVERRIDE
support to memcg_bpf_ops.
v2:
According to the comments of Tejun Heo, rebased on Roman Gushchin's BPF
OOM patch series [1] and added hierarchical delegation support.
According to the comments of Roman Gushchin and Michal Hocko, Designed
concrete use case scenarios and provided test results.

eBPF infrastructure provides rich visibility into system performance
metrics through various tracepoints and statistics.
This patch series introduces BPF struct_ops for the memory controller.
Then the eBPF program can help the system control the memory controller
based on system performance metrics, thereby improving the utilization
of system memory resources while ensuring memory limits are respected.

The following example illustrates how memcg eBPF can improve memory
utilization in some scenarios.
The example running on x86_64 QEMU (10 CPUs, 4GB RAM), using a
file in tmpfs on the host as a swap device to reduce I/O impact.
root@ubuntu:~# cat /proc/sys/vm/swappiness
60
This the high priority memcg.
root@ubuntu:~# mkdir /sys/fs/cgroup/high
This the low priority memcg.
root@ubuntu:~# mkdir /sys/fs/cgroup/low
root@ubuntu:~# free
               total        used        free      shared  buff/cache   available
Mem:         4007276      392320     3684940         908      101476     3614956
Swap:       10485756           0    10485756

First, The following test uses memory.low to reduce the likelihood of tasks in
high-priority memory cgroups being reclaimed.
root@ubuntu:~# echo $((3 * 1024 * 1024 * 1024)) > /sys/fs/cgroup/high/memory.low
root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep \
--vm-bytes $((3 * 1024 * 1024 * 1024)) \
--vm-method all --seed 2025 --metrics -t 60 \
& cgexec -g memory:high stress-ng --vm 4 --vm-keep \
--vm-bytes $((3 * 1024 * 1024 * 1024)) \
--vm-method all --seed 2025 --metrics -t 60
[1] 1176
stress-ng: info:  [1177] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1176] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1177] dispatching hogs: 4 vm
stress-ng: info:  [1176] dispatching hogs: 4 vm
stress-ng: metrc: [1177] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1177]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1177] vm             27047770     60.07    217.79      8.87    450289.91      119330.63        94.34        886936
stress-ng: info:  [1177] skipped: 0
stress-ng: info:  [1177] passed: 4: vm (4)
stress-ng: info:  [1177] failed: 0
stress-ng: info:  [1177] metrics untrustworthy: 0
stress-ng: info:  [1177] successful run completed in 1 min, 0.07 secs
stress-ng: metrc: [1176] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1176]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1176] vm               679754     60.12     11.82     72.78     11307.18        8034.42        35.18        469884
stress-ng: info:  [1176] skipped: 0
stress-ng: info:  [1176] passed: 4: vm (4)
stress-ng: info:  [1176] failed: 0
stress-ng: info:  [1176] metrics untrustworthy: 0
stress-ng: info:  [1176] successful run completed in 1 min, 0.13 secs
[1]+  Done                    cgexec -g memory:low stress-ng --vm 4 --vm-keep --vm-bytes $((3 * 1024 * 1024 * 1024)) --vm-method all --seed 2025 --metrics -t 60


The following test continues to use memory.low to reduce the likelihood
of tasks in high-priority memory cgroups (memcg) being reclaimed.
In this scenario, a Python script within the high-priority memcg simulates
a low-load task.
As a result, the Python script's performance is not affected by memory
reclamation (as it sleeps after allocating memory).
However, the performance of stress-ng is still impacted due to
the memory.low setting.

root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep \
--vm-bytes $((3 * 1024 * 1024 * 1024)) \
--vm-method all --seed 2025 --metrics -t 60 \
& cgexec -g memory:high python3 -c \
"import time; a = bytearray(3*1024*1024*1024); time.sleep(62)"
[1] 1196
stress-ng: info:  [1196] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1196] dispatching hogs: 4 vm
stress-ng: metrc: [1196] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1196]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1196] vm               886893     60.10     17.76     56.61     14756.92       11925.69        30.94        788676
stress-ng: info:  [1196] skipped: 0
stress-ng: info:  [1196] passed: 4: vm (4)
stress-ng: info:  [1196] failed: 0
stress-ng: info:  [1196] metrics untrustworthy: 0
stress-ng: info:  [1196] successful run completed in 1 min, 0.10 secs
[1]+  Done                    cgexec -g memory:low stress-ng --vm 4 --vm-keep --vm-bytes $((3 * 1024 * 1024 * 1024)) --vm-method all --seed 2025 --metrics -t 60
root@ubuntu:~# echo 0 > /sys/fs/cgroup/high/memory.low

Now, we switch to using the memcg eBPF program for memory priority control.
memcg is a test program added to samples/bpf in this patch series.
It loads memcg.bpf.c into the kernel.
memcg.bpf.c monitors PGFAULT events in the high-priority memory cgroup.
When the number of events triggered within one second exceeds a predefined
threshold, the eBPF hook for the memory cgroup activates its control for
one second.

The following command configures the high-priority memory cgroup to
return below_min during memory reclamation if the number of PGFAULT
events per second exceeds one.
root@ubuntu:~# ./memcg --low_path=/sys/fs/cgroup/low \
     --high_path=/sys/fs/cgroup/high \
     --threshold=1 --use_below_min
Successfully attached!

root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep \
--vm-bytes $((3 * 1024 * 1024 * 1024)) \
--vm-method all --seed 2025 --metrics -t 60 \
& cgexec -g memory:high stress-ng --vm 4 --vm-keep \
--vm-bytes $((3 * 1024 * 1024 * 1024)) \
--vm-method all --seed 2025 --metrics -t 60
[1] 1220
stress-ng: info:  [1220] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1221] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1220] dispatching hogs: 4 vm
stress-ng: info:  [1221] dispatching hogs: 4 vm
stress-ng: metrc: [1221] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1221]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1221] vm             24295240     60.08    221.36      7.64    404392.49      106095.60        95.29        886684
stress-ng: info:  [1221] skipped: 0
stress-ng: info:  [1221] passed: 4: vm (4)
stress-ng: info:  [1221] failed: 0
stress-ng: info:  [1221] metrics untrustworthy: 0
stress-ng: info:  [1221] successful run completed in 1 min, 0.11 secs
stress-ng: metrc: [1220] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1220]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1220] vm               685732     60.13     11.69     75.98     11403.88        7822.30        36.45        496496
stress-ng: info:  [1220] skipped: 0
stress-ng: info:  [1220] passed: 4: vm (4)
stress-ng: info:  [1220] failed: 0
stress-ng: info:  [1220] metrics untrustworthy: 0
stress-ng: info:  [1220] successful run completed in 1 min, 0.14 secs
[1]+  Done                    cgexec -g memory:low stress-ng --vm 4 --vm-keep --vm-bytes $((3 * 1024 * 1024 * 1024)) --vm-method all --seed 2025 --metrics -t 60

This test demonstrates that because the Python process within the
high-priority memory cgroup is sleeping after memory allocation, 
no page fault events occur.
As a result, the stress-ng process in the low-priority memory cgroup
achieves normal memory performance.
root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep \
--vm-bytes $((3 * 1024 * 1024 * 1024)) \
--vm-method all --seed 2025 --metrics -t 60 \
& cgexec -g memory:high python3 -c \
"import time; a = bytearray(3*1024*1024*1024); time.sleep(62)"
[1] 1238
stress-ng: info:  [1238] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1238] dispatching hogs: 4 vm
stress-ng: metrc: [1238] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1238]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1238] vm             33107485     60.08    205.41     13.19    551082.91      151448.44        90.97        886064
stress-ng: info:  [1238] skipped: 0
stress-ng: info:  [1238] passed: 4: vm (4)
stress-ng: info:  [1238] failed: 0
stress-ng: info:  [1238] metrics untrustworthy: 0
stress-ng: info:  [1238] successful run completed in 1 min, 0.09 secs

In this patch series, I've incorporated a portion of Roman's patch in
[1] to ensure the entire series can be compiled cleanly with bpf-next.
I made some modifications to bpf_struct_ops_link_create
in "bpf: Pass flags in bpf_link_create for struct_ops" and
"libbpf: Support passing user-defined flags for struct_ops" to allow
the flags parameter to be passed into the kernel.
With this change, patch "mm/bpf: Add BPF_F_ALLOW_OVERRIDE support for
memcg_bpf_ops" enables BPF_F_ALLOW_OVERRIDE support for memcg_bpf_ops.

Patch "mm: memcontrol: Add BPF struct_ops for memory controller"
introduces BPF struct_ops support to the memory controller, enabling
custom and dynamic control over memory pressure. This is achieved
through a new struct_ops type, `memcg_bpf_ops`.
The `memcg_bpf_ops` struct provides the following hooks:
- `get_high_delay_ms`: Returns a custom throttling delay in
  milliseconds for a cgroup that has breached its `memory.high`
  limit. This is the primary mechanism for BPF-driven throttling.
- `below_low`: Overrides the `memory.low` protection check. If this
  hook returns true, the cgroup is considered to be protected by its
  `memory.low` setting, regardless of its actual usage.
- `below_min`: Similar to `below_low`, this overrides the `memory.min`
  protection check.
- `handle_cgroup_online`/`offline`: Callbacks invoked when a cgroup
  with an attached program comes online or goes offline, allowing for
  state management.

Patch "samples/bpf: Add memcg priority control example" introduces
the programs memcg.c and memcg.bpf.c that were used in the previous
examples.

[1] https://lore.kernel.org/lkml/20251027231727.472628-1-roman.gushchin@linux.dev/

Hui Zhu (7):
  bpf: Pass flags in bpf_link_create for struct_ops
  libbpf: Support passing user-defined flags for struct_ops
  mm: memcontrol: Add BPF struct_ops for memory controller
  selftests/bpf: Add tests for memcg_bpf_ops
  mm/bpf: Add BPF_F_ALLOW_OVERRIDE support for memcg_bpf_ops
  selftests/bpf: Add test for memcg_bpf_ops hierarchies
  samples/bpf: Add memcg priority control example

Roman Gushchin (5):
  bpf: move bpf_struct_ops_link into bpf.h
  bpf: initial support for attaching struct ops to cgroups
  bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
  mm: define mem_cgroup_get_from_ino() outside of CONFIG_SHRINKER_DEBUG
  libbpf: introduce bpf_map__attach_struct_ops_opts()

 MAINTAINERS                                   |   4 +
 include/linux/bpf.h                           |   8 +
 include/linux/memcontrol.h                    | 113 +++-
 kernel/bpf/bpf_struct_ops.c                   |  22 +-
 kernel/bpf/verifier.c                         |   5 +
 mm/bpf_memcontrol.c                           | 281 +++++++-
 mm/memcontrol.c                               |  34 +-
 samples/bpf/.gitignore                        |   1 +
 samples/bpf/Makefile                          |   8 +-
 samples/bpf/memcg.bpf.c                       | 130 ++++
 samples/bpf/memcg.c                           | 345 ++++++++++
 tools/include/uapi/linux/bpf.h                |   2 +-
 tools/lib/bpf/bpf.c                           |   8 +
 tools/lib/bpf/libbpf.c                        |  19 +-
 tools/lib/bpf/libbpf.h                        |  14 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/memcg_ops.c      | 606 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/memcg_ops.c | 130 ++++
 18 files changed, 1704 insertions(+), 27 deletions(-)
 create mode 100644 samples/bpf/memcg.bpf.c
 create mode 100644 samples/bpf/memcg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops.c

-- 
2.43.0


