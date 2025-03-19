Return-Path: <cgroups+bounces-7185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE6A69BF4
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAEE16A2D5
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012C721B9FE;
	Wed, 19 Mar 2025 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffM0O9rH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279781BD9C7
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422919; cv=none; b=p2bGDkipMFEDBbA2oZB1U+hnjE6HvqfIEYIyS7tEB1370fCk0MMxh7BhszklgMjFCUynWB72rNL6yzg2GAAJIL4rZk5qfSkSuLxqqxOW62aKTWgp2ZRs7zZNVeJDrVapyzEi5JiNOJNVC9Wi1hQ8NtuahmCGwa7u0Mrm/5i15yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422919; c=relaxed/simple;
	bh=BtpLaPpYU+IBzBZlJ6Q7/OlUmNWpWbsQ+7aQ9ZzMKok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDWOOQwsHHHr7tKOal8lGYTtRZ+KLnY+DcP6YUCoklmuUfR4JfOcNtXY+VOtYV07kXE6j+U9E9CbMS4CRO++VMXIFXG9IGfjqq9KDZN+wPJcyTjav31YZpIEgBX3JrzRXO4N5MLtkvMv9jsCZ6R3v7yVbky/5LLVAYH++O0AGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffM0O9rH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22622ddcc35so1366245ad.2
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422917; x=1743027717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m09yt2A2os49rhFZLeuucmU+hSklZW9p02skFAjq9sg=;
        b=ffM0O9rHPTWkKIn0Vh5fuZWucCdicrO7vWw+3RBUxJOcZFPKQU1RQqx3t3bk9BlS2y
         B7rcbRxq0KsiNingw8b+xwvrTEgibZt6bdZyOog/c0evUafNLRxqTtbMLTgnjJdIa2Bf
         9L30PvM2SLzu/8Ny6pKGUB8yhYmf0RDN/21U0nOlPb1vnNwelZKUQCIa0ftq2ksOr7JF
         o0nCVBH7tprjluz5QY6ixKmDeH9vryW2zCVDlcuTYkahBf1N3mbDOnDLWES9ibRwl96W
         0NuwOcuZo0013bcO9vbYB8yCz1duvP00KwY1b+Z6mcnLlSze5V2/t4X45CIB3MDYemr9
         cA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422917; x=1743027717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m09yt2A2os49rhFZLeuucmU+hSklZW9p02skFAjq9sg=;
        b=CpQVLxhC13VOLDrgJWR4a+1FVqFAux1sYx2w64GuZM+/h+bvsiFHb9GjMK8ytyQziV
         8CXkuMOL6IYeK6h1rBtb9eta7aIMOGW33IjNH8351DHaSWsnvydPQGxDxboBT7zuknla
         tIrXQGKiJ9seJpAvJDrM7a9zoZcbKwAnXZB42oIS+06yaNDB6UfzGgPiPRtW/IaIN8WJ
         S2HMeom7LV+RjHDMzOM/11EQis+XLqjj6/tnJ/zOni6lJdphSDzS6T1HGIeY1EEjToA/
         hz/Oy6vaJrMCH4G9MmN2rht+/3eeHIWscCo3qkIcTnWMB7C6hXEHKvnxnAKlNGu3tjGa
         WtLw==
X-Forwarded-Encrypted: i=1; AJvYcCVkIX7DerCH9cOPoeAprayqMulQJnDD81DHlRmmx6dyCAN4QwUiK3jLl5xPBLh0GVgo9tBjfNcs@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnKptuDTfKAWULtkUJw6yuAmBQNWgVMC/wm3yjT4sMzvn0tBj
	pHw+Y1myCyR3NhbEPdUqrGckWZ1yYr64CGg3QEmYrGlhOmYawv/1
X-Gm-Gg: ASbGnctkXHn9oWLUsyiKIbv2i36v+HDjzLtD7FIyK8Kak45MgcyfSHtEVQl3yyLIeGQ
	xb8K6rtY2jCek9u84GwZbAW04+WnTmLI9rUUF+8UjVn9m9I4LMD9W8c7oWQPw/iT0N/hjcHAVFG
	EU28Or+7z8nJL02kah0G1ZHYpu2RL7gtibGn6cB4zhO7fM2mpBmjtHntuuBXV/pkeZPGeR4dRL0
	ruv7wGs/3s0OrO7uKE5z64ZDY2eUDavV/B3zskkJdEeXakxFEr3uz9SwiuQm9vIpXoxWo9i4+So
	o+55yjWk92iDCokZ468BV7Bl0yNSc9ljPH2f0VmBdyL7Ipy1x6c7lr5UMBK4//Tb8war2tqe
X-Google-Smtp-Source: AGHT+IFV0gAaTnUhyC/DjKjd1Fcf0Xg/rzgrZJ6zfyMOONr9to76ZgO0RuCxMk74GGPy2NKT4wkEHA==
X-Received: by 2002:a05:6a20:c906:b0:1f5:8b9b:ab54 with SMTP id adf61e73a8af0-1fbebc8563dmr7873865637.23.1742422917333;
        Wed, 19 Mar 2025 15:21:57 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:39d5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9dd388sm11467484a12.20.2025.03.19.15.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:21:56 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/4 v3] cgroup: separate rstat trees
Date: Wed, 19 Mar 2025 15:21:46 -0700
Message-ID: <20250319222150.71813-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current design of rstat takes the approach that if one subsystem is to
be flushed, all other subsystems with pending updates should also be
flushed. A flush may be initiated by reading specific stats (like cpu.stat)
and other subsystems will be flushed alongside. The complexity of flushing
some subsystems has grown to the extent that the overhead of side flushes
is unnecessarily delaying the fetching of desired stats.

One big area where the issue comes up is system telemetry, where programs
periodically sample cpu stats while the memory controller is enabled. It
would be a benefit for programs sampling cpu.stat if the overhead of having
to flush memory (and also io) stats was eliminated. It would save cpu
cycles for existing stat reader programs and improve scalability in terms
of sampling frequency and host volume.

This series changes the approach of "flush all subsystems" to "flush only
the requested subsystem". The core design change is moving from a unified
model where rstat trees are shared by subsystems to having separate trees
for each subsystem. On a per-cpu basis, there will be separate trees for
each enabled subsystem if it implements css_rstat_flush and one tree for
the base stats. In order to do this, the rstat list pointers were moved off
of the cgroup and onto the css. In the transition, these pointer types were
changed to cgroup_subsys_state. Finally the API for updated/flush was
changed to accept a reference to a css instead of a cgroup. This allows for
a specific subsystem to be associated with a given update or flush. The
result is that rstat trees will now be made up of css nodes, and a given
tree will only contain nodes associated with a specific subsystem.

Since separate trees will now be in use, the locking scheme was adjusted.
The global locks were split up in such a way that there are separate locks
for the base stats (cgroup::self) and also for each subsystem (memory, io,
etc). This allows different subsystems (and base stats) to use rstat in
parallel with no contention.

Breaking up the unified tree into separate trees eliminates the overhead
and scalability issue explained in the first section, but comes at the
expense of additional memory. In an effort to minimize this overhead, new
rstat structs are introduced and a conditional allocation is performed.
The cgroup_rstat_cpu which originally contained the rstat list pointers and
the base stat entities was renamed cgroup_rstat_base_cpu. It is only
allocated when the associated css is cgroup::self. As for non-self css's, a
new compact struct was added that only contains the rstat list pointers.
During initialization, when the given css is associated with an actual
subsystem (not cgroup::self), this compact struct is allocated. With this
conditional allocation, the change in memory overhead on a per-cpu basis
before/after is shown below.

memory overhead before:
sizeof(struct cgroup_rstat_cpu) =~ 144 bytes /* can vary based on config */

nr_cgroups * sizeof(struct cgroup_rstat_cpu)
nr_cgroups * 144 bytes

memory overhead after:
sizeof(struct cgroup_rstat_cpu) == 16 bytes
sizeof(struct cgroup_rstat_base_cpu) =~ 144 bytes

nr_cgroups * (
	sizeof(struct cgroup_rstat_base_cpu) +
		sizeof(struct cgroup_rstat_cpu) * nr_rstat_controllers
	)

nr_cgroups * (144 + 16 * nr_rstat_controllers)

... where nr_rstat_controllers is the number of enabled cgroup controllers
that implement css_rstat_flush(). On a host where both memory and io are
enabled:

nr_cgroups * (144 + 16 * 2)
nr_cgroups * 176 bytes

This leaves us with an increase in memory overhead of:
	32 bytes per cgroup per cpu

Validation was performed by reading some *.stat files of a target parent
cgroup while the system was under different workloads. A test program was
made to loop 1M times, reading the files cgroup.stat, cpu.stat, io.stat,
memory.stat of the parent cgroup each iteration. Using a non-patched kernel
as control and this series as experimental, the findings show perf gains
when reading stats with this series.

The first experiment consisted of a parent cgroup with memory.swap.max=0
and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created and
within each child cgroup a process was spawned to frequently update the
memory cgroup stats by creating and then reading a file of size 1T
(encouraging reclaim). The test program was run alongside these 26 tasks in
parallel. The results showed time and perf gains for the reader test
program.

test program elapsed time
control:
real    1m13.663s
user    0m0.948s
sys     1m12.356s

experiment:
real    0m42.498s
user    0m0.764s
sys     0m41.546s

test program perf
control:
31.75% mem_cgroup_css_rstat_flush
 5.49% __blkcg_rstat_flush
 0.10% cpu_stat_show
 0.05% cgroup_base_stat_cputime_show

experiment:
8.60% mem_cgroup_css_rstat_flush
0.15% blkcg_print_stat
0.12% cgroup_base_stat_cputime_show

It's worth noting that memcg uses heuristics to optimize flushing.
Depending on the state of updated stats at a given time, a memcg flush may
be considered unnecessary and skipped as a result. This opportunity to skip
a flush is bypassed when memcg is flushed as a consequence of sharing the
tree with another controller.

A second experiment was setup on the same host using a parent cgroup with
two child cgroups. The same swap and memory max were used as in the
previous experiment. In the two child cgroups, kernel builds were done in
parallel, each using "-j 20". The perf comparison is shown below.

test program elapsed time
control:
real    1m22.809s
user    0m1.142s
sys     1m21.138s

experiment:
real    0m42.504s
user    0m1.000s
sys     0m41.220s

test program perf
control:
37.16% mem_cgroup_css_rstat_flush
 3.68% __blkcg_rstat_flush
 0.09% cpu_stat_show
 0.06% cgroup_base_stat_cputime_show

experiment:
2.02% mem_cgroup_css_rstat_flush
0.20% blkcg_print_stat
0.14% cpu_stat_show
0.08% cgroup_base_stat_cputime_show

The final experiment differs from the previous two in that it measures
performance from the stat updater perspective. A kernel build was run in a
child node with -j 20 on the same host and cgroup setup. A baseline was
established by having the build run while no stats were read. The builds
were then repeated while stats were constantly being read. In all cases,
perf appeared similar in cycles spent on cgroup_rstat_updated()
(insignificant compared to the other recorded events). As for the elapsed
build times, the results of the different scenarios are shown below,
indicating no significant drawbacks of the split tree approach.

control with no readers
real    5m12.307s
user    84m52.037s
sys     3m54.000s

control with constant readers of {memory,io,cpu,cgroup}.stat
real    5m13.209s
user    84m47.949s
sys     4m9.260s

experiment with no readers
real    5m11.961s
user    84m41.750s
sys     3m54.058s

experiment with constant readers of {memory,io,cpu,cgroup}.stat
real    5m12.626s
user    85m0.323s
sys     3m56.167s

changelog
v3:
	new bpf kfunc api for updated/flush
	rename cgroup_rstat_{updated,flush} and related to "css_rstat_*"
	check for ss->css_rstat_flush existence where applicable
	rename locks for base stats
	move subsystem locks to cgroup_subsys struct
	change cgroup_rstat_boot() to ss_rstat_init(ss) and init locks within
	change lock helpers to accept css and perform lock selection within
	fix comments that had outdated lock names
	add open css_is_cgroup() helper
	rename rstatc to rstatbc to reflect base stats in use
	rename cgroup_dfl_root_rstat_cpu to root_self_rstat_cpu
	add comments in early init code to explain deferred allocation
	misc formatting fixes

v2:
	drop the patch creating a new cgroup_rstat struct and related code
	drop bpf-specific patches. instead just use cgroup::self in bpf progs
	drop the cpu lock patches. instead select cpu lock in updated_list func
	relocate the cgroup_rstat_init() call to inside css_create()
	relocate the cgroup_rstat_exit() cleanup from apply_control_enable()
		to css_free_rwork_fn()
v1:
	https://lore.kernel.org/all/20250218031448.46951-1-inwardvessel@gmail.com/

JP Kobryn (4):
  cgroup: separate rstat api for bpf programs
  cgroup: use separate rstat trees for each subsystem
  cgroup: use subsystem-specific rstat locks to avoid contention
  cgroup: split up cgroup_rstat_cpu into base stat and non base stat
    versions

 block/blk-cgroup.c                            |   6 +-
 include/linux/cgroup-defs.h                   |  80 ++--
 include/linux/cgroup.h                        |  16 +-
 include/trace/events/cgroup.h                 |  10 +-
 kernel/cgroup/cgroup-internal.h               |   6 +-
 kernel/cgroup/cgroup.c                        |  69 +--
 kernel/cgroup/rstat.c                         | 412 +++++++++++-------
 mm/memcontrol.c                               |   4 +-
 .../selftests/bpf/progs/btf_type_tag_percpu.c |   5 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |   8 +-
 10 files changed, 363 insertions(+), 253 deletions(-)

-- 
2.47.1


