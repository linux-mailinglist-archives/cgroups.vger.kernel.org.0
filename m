Return-Path: <cgroups+bounces-7340-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9BA7B559
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432643B8739
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7A944E;
	Fri,  4 Apr 2025 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Wjj2nN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B372E62DA
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729064; cv=none; b=VsyUdMBzeQit8Y/oNlo4M70z1zjUF8NDT3uU3TWO6mF2tbyL14Tdk6fvX5WUQxJlVUgsOJNY6QBRF0dUYXLmbgfb0EVtmnNJBOX4z4Z7DIqKfzqBkuhYro9IqN0CQkGlTMZ1swbHI5JNg9urvxBAEThfZwTuWIMOfy5AZ51g6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729064; c=relaxed/simple;
	bh=O/C2/3m3DnCzaPEZjxqru8CVs/FgUg1XWM2h5OxwiuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHONh9cGd5jIMXsYNVAxuDby0YDDNCdKlHMbRZQ+aOiX9SgFZu5SGRsT5iO3EuSYrdIKwOs1opzcmGDePUzsD78d/m3KtQnj7tMvgaigXYskmAAxURf3YbD2OXphhrGtpsNnsO7HbNDlTSnuUGsmavnXw4XKorVUh2K8YraETW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Wjj2nN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de12bso21983995ad.2
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743729062; x=1744333862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewl/x4Zt26kQeJ50ssNokb9M5hP8pj7uoufInmgAhqY=;
        b=J2Wjj2nNNWHlx5nk6NtKUkO/eo4zEE04WH7wSkKRwI/CRggx5tIpvmz0i4J41he2p5
         HazwVMpY1fybgbTVtWiekqPfHq8dKv47LmsUzUMdou8xtyUe6cMhnwdHgZH8SF5cqzNl
         X9xX2M13aa58nBnfqNNzrYc/oVqsZfMhIk6Ae8sR2A0mF+lz/1rmN8RSCp9yVQsv49fi
         7STD/xO7EIULkC8ABTI/q/1GVqDzxyfO/TPTI1AsdAlBU8d9Q3iyU5vPayKnyn4WAIPK
         tvMe68/T5WpLGhHq+YGJTKUbjxOHpchSjJc2VtL05mk0OI1gt5WNSLQK6pnFKYI4yjx2
         UgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743729062; x=1744333862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ewl/x4Zt26kQeJ50ssNokb9M5hP8pj7uoufInmgAhqY=;
        b=IjmPY24q8Z0196Ner1sSD/70XSUDVXGS6PKbaihpuMXKLBZqOszn2AmhUOyT84b/mq
         rdEhKwhe/RChh+pq/FMep/QMsAGTuJlHzltnB3LLZT0kDyTeJ0K+Uxvw41ZMMerPsq5H
         XKj2SZr44ZnU0vtEDcU6ipQSlQEnaml3PoRIXcXJfgw1/PCm7dOL781r8Cjrh+YPLy3l
         ELA6Dyb9FmhnP28rOnVffiDKSKPDbR+1xHaleMt8I+zup4S77857zJRx3/e3IYEO8rwN
         nYP3JRHPmXjKrlOiviHmnAqEBnUZIf+THZSMJydKcGiAT/qRYyg60/YCjglPclIrBLZK
         m17A==
X-Forwarded-Encrypted: i=1; AJvYcCXEFy0mLGOwEv77mF41YWiLoUexBu87IIGbpx7QoEKwDIGurAiTOxKZtG3JDLU1vHQ8+Ygvnae1@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsWJ0Cw3WZpa0LgOckWG/9a9tJAMHEiOltxIb11r1SyPctXde
	0Wn4cgpk38yn8FllmGq6FCtkrWO123qpy/z2fhinRtTb5Je3FBjs
X-Gm-Gg: ASbGncslNOf8cCG+gN3DHET63OKj34BXGkBz6RmvzLb1A8Uomp1lN9KAMmLMazsGUAs
	f95kf6Bb0O6OmBjn/9HOi25ADSY5EVaNSZFP97z1rfvCxYctxTWKdBbqK2hQeCULxG1LDah3tp9
	mboi2UZBu4XuRmhi/Y6/M8tREfTDrRJ+ttTA7j4WLShBGJEJSMovk0cFqkmI5zO9u/QLHQYmUH2
	IS4ffA8hBIMJp6xF7RbNDOhLKM3bfuzFZwrbhcaX8BrehBS43xoMB9hSzAgX3DMr1+NO6+8vpju
	dvd+HTFbAK8jYD/s9slM/YcL4AKZGelSdgxdffZ6/YuCXMwaPZ+PfiPgrHi56owZkINac9V0
X-Google-Smtp-Source: AGHT+IGJGjJTFXlhYdVoZZw5ePtKECQtO2lm8eoSS8/qHKd6wtOVKwcq/4BLkFIsuWi85Roiom82fQ==
X-Received: by 2002:a17:902:e5cf:b0:223:517a:d2e2 with SMTP id d9443c01a7336-22a8a0b4149mr17192995ad.53.1743729061680;
        Thu, 03 Apr 2025 18:11:01 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:9b28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9a0sm21268675ad.39.2025.04.03.18.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 18:11:01 -0700 (PDT)
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
Subject: [PATCH v4 0/5] cgroup: separate rstat trees
Date: Thu,  3 Apr 2025 18:10:45 -0700
Message-ID: <20250404011050.121777-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
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
is causing noticeable delays in reading the desired stats.

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
each enabled subsystem that implements css_rstat_flush plus one tree
dedicated to the base stats. In order to do this, the rstat list pointers
were moved off of the cgroup and onto the css. In the transition, these
pointer types were changed to cgroup_subsys_state. Finally the API for
updated/flush was changed to accept a reference to a css instead of a
cgroup. This allows for a specific subsystem to be associated with a given
update or flush. The result is that rstat trees will now be made up of css
nodes, and a given tree will only contain nodes associated with a specific
subsystem.

Since separate trees will now be in use, the locking scheme was adjusted.
The global locks were split up in such a way that there are separate locks
for the base stats and also for each subsystem (memory, io, etc). This
allows different subsystems (and base stats) to use rstat in parallel with
no contention.

Breaking up the unified tree into separate trees eliminates the overhead
and scalability issues explained in the first section, but comes at the
cost of additional memory. Originally, each cgroup contained an instance of
the cgroup_rstat_cpu. The design change of moving to css-based trees calls
for each css having the rstat per-cpu objects instead. Moving these objects
to every css is where this overhead is created. In an effort to minimize
this, the cgroup_rstat_cpu struct was split into two separate structs. One
is the cgroup_rstat_base_cpu struct which only contains the per-cpu base
stat objects used in rstat. The other is the css_rstat_cpu struct which
contains the minimum amount of pointers needed for a css to participate in
rstat. Since only the cgroup::self css is associated with the base stats,
an instance of the cgroup_rstat_base_cpu struct is placed on the cgroup.
Meanwhile an instance of the css_rstat_cpu is placed on the
cgroup_subsys_state. This allows for all css's to participate in rstat
while avoiding the unnecessary inclusion of the base stats. The base stat
objects will only exist once per-cgroup regardless of however many
subsystems are enabled. With this division of rstat list pointers and base
stats, the change in memory overhead on a per-cpu basis before/after is
shown below.

memory overhead before:
	nr_cgroups * sizeof(struct cgroup_rstat_cpu)
where
	sizeof(struct cgroup_rstat_cpu) = 144 bytes /* config-dependent */
resulting in
	nr_cgroups * 144 bytes

memory overhead after:
	nr_cgroups * (
		sizeof(struct cgroup_rstat_base_cpu) +
			sizeof(struct css_rstat_cpu) * (1 + nr_rstat_controllers)
		)
where
	sizeof(struct cgroup_rstat_base_cpu) = 128 bytes
	sizeof(struct css_rstat_cpu) = 16 bytes
	the constant "1" accounts for the cgroup::self css
	nr_rstat_controllers = number of controllers defining css_rstat_flush
when both memory and io are enabled
	nr_rstat_controllers = 2
resulting in
	nr_cgroups * (128 + 16 * (1 + 2))
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
real    1m0.956s
user    0m0.569s
sys     1m0.195s

experiment:
real    0m37.660s
user    0m0.463s
sys     0m37.078s

test program perf
control:
24.62% mem_cgroup_css_rstat_flush
 4.97% __blkcg_rstat_flush
 0.09% cpu_stat_show
 0.05% cgroup_base_stat_cputime_show

experiment:
2.68% mem_cgroup_css_rstat_flush
0.04% blkcg_print_stat
0.07% cpu_stat_show
0.06% cgroup_base_stat_cputime_show

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
real    1m27.620s
user    0m0.779s
sys     1m26.258s

experiment:
real    0m45.805s
user    0m0.723s
sys     0m44.757s

test program perf
control:
30.84% mem_cgroup_css_rstat_flush
 6.75% __blkcg_rstat_flush
 0.08% cpu_stat_show
 0.04% cgroup_base_stat_cputime_show

experiment:
1.55% mem_cgroup_css_rstat_flush
0.15% blkcg_print_stat
0.10% cpu_stat_show
0.09% cgroup_base_stat_cputime_show
0.00% __blkcg_rstat_flush

The final experiment differs from the previous two in that it measures
performance from the stat updater perspective. A kernel build was run in a
child node with -j 20 on the same host and cgroup setup. A baseline was
established by having the build run while no stats were read. The builds
were then repeated while stats were constantly being read. In all cases,
perf appeared similar in cycles spent on cgroup_rstat_updated()
(insignificant compared to the other recorded events). As for the elapsed
build times, the results of the different scenarios are shown below,
showing no significant drawbacks of the split tree approach.

control with no readers
real    3m21.003s
user    55m52.133s
sys     2m40.728s

control with constant readers of {memory,io,cpu,cgroup}.stat
real    3m26.164s
user    56m49.474s
sys     2m56.389s

experiment with no readers
real    3m22.740s
user    56m18.972s
sys     2m45.041s

experiment with constant readers of {memory,io,cpu,cgroup}.stat
real    3m26.971s
user    57m11.540s
sys     2m49.735s

changelog
v4:
	drop bpf api patch
	drop cgroup_rstat_cpu split and union patch,
		replace with patch for moving base stats into new struct
	new patch for renaming rstat api's from cgroup_* to css_*
	new patch for adding css_is_cgroup() helper
	rename ss->lock and ss->cpu_lock to ss->rstat_ss_lock and
		ss->rstat_ss_cpu_lock respectively
	rename root_self_stat_cpu to root_base_rstat_cpu
	rename cgroup_rstat_push_children to css_rstat_push_children
	format comments for consistency in wings and capitalization
	update comments in bpf selftests

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


