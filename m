Return-Path: <cgroups+bounces-8198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DCAB7A77
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 02:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817C38C05B7
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 00:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8310E4;
	Thu, 15 May 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do/b79eZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6DCA6B
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268390; cv=none; b=nMmaJDvDFQYqJT6gWZ8xR2IKX0G9F7iC9XztChrFvIFwLmqUvHJOdXxXzBnUjqqYRXxudWlSJqDFJpqBcJHWyVP+APG+LH9r8lUSyyishwIZ+hAD42UahFAqB+gAl9X1N+7+5HvEpz7Sf6ydMDNrDTmTMBMopAd7N1w14h7bXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268390; c=relaxed/simple;
	bh=xKNVt5i2/wVm+Jo3orQEsr/OySYAUkTImk+z7F25Zmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlVABlml6EavvQYdRLeBdwVfZ6ixISBMNHexxxQ9nX2h48XbTrXMgH21lKHtmsYDrjLQTLEEMZw4WWOdAOWfhXRF8sEqRfL4vOdWikEStD0peN1vng6gXgVPRg0lxZGy1ZkGuqo+1bfEsc4toiSEtz6Uv9pmIOGcnq+gFzZluDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do/b79eZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b239763eeddso220932a12.1
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268387; x=1747873187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1EOE8idYaXbGxnU0HlT++CdzyhHMYwckfk3NFpsO0E=;
        b=Do/b79eZFMXsc6IpQQPzbNIOwmvQG+dpAzYHuTuag8JRpbRphxFx6NaFXXnfAlWenW
         QoZiUczS204b8WuximafImengghnB/YEWHmP4oFfWys8xnmmf5GKe7G72htohsZfaA5+
         4d3CFDfJRBx8qkkPseZpk6ildDE7UrjqyrLpBdt///70LQ7f16ixZnvWjP2/QsCorIdO
         4McsYUsI5J1GtDetyD1wyIWQxvOOWWhs5yrylyE5ZKSTxC5phYLRITywy3ZMVQ385ItZ
         ckrroC3OOgJmi+V8h3LpZthHqSAlNwbgnf+sO4KtguG5f5wwnSxGJbmJHHuc1x7MNd5J
         jA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268387; x=1747873187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1EOE8idYaXbGxnU0HlT++CdzyhHMYwckfk3NFpsO0E=;
        b=cmfvDM50Ng+RAuRPhlaRseAawoU3yJ0TmvJ2GciESkUsu2T9H8BV93Cz9Pmfss+bF7
         oRl9KqywcDutk7+gB9RzklQnLMAlVOwrBS6ktDUp7XcfMhpfBjz9crREO4J63rNg2CaN
         NYYuiDwojb4xUDqFg/t1oSzWNkaSDkInocTQ0LsdmBqTdOjMdjKYYgWXPS0I8KozginN
         qvUM9BEHF942tozf4KibKflUescqk/Y+c+FBDdtmY/L601fvWp4lzb/vqoevvsNH+sZ7
         nSvunbRepNVEUGAiN4Z3UDsv2QGNJUzw5XUhpRV8MoUOU3xJYs5LxYe5X4Ex7tU8Qmdz
         WJuA==
X-Forwarded-Encrypted: i=1; AJvYcCU0IHnGdhx7MisUpbKqdCeEFY/SeTOKl7ZekFtiTcUkWYG1knA6mh8ud5joaviYgOlsJYv2qFKs@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTJQS0deeQZDcSpso6TNNBAh2aCaFfTzBXahkQ6oExkC4NPQb
	wqZxtzg8YyiZ1uAdzdeQoI06I2IeTA72TCt9OuwViuTD1Jb6BRpDrB+uEg==
X-Gm-Gg: ASbGncuiX9p0xkHSfMHpA283M8DBH7X4JmtxLOetOqKU098bUoKQzHGYdSe+0SFA773
	GSYYxbyvhTxXUw/CS34egXteTmU4BkOU99oHd11OniuAmU6xQVtnNbo7oza3qM56KvNIJqvUzq2
	rnrZM0Xhyul8tlZOQ/if7rrKl6ru4Ywmsqy84pjMaJ6AaC4lgFqSVYkfE353JLIJAMPVl426Gps
	TigMPJzTvh30GXK025RNdLmA115DMCLMbG34JvJxrm3rVrfktHCaLSfBBoVkCbHpAuKokbLKzVB
	JrDk/WlsPCNKADmUo+zWxO+M7uHn7w0bfj4+Xw/rG5IcEZg1MJXiME35sz1b+GdxbS9ssScy29H
	z7owW15h2s1zDGAuS/KchJb4xqCL4pgKwj/JdrNw=
X-Google-Smtp-Source: AGHT+IHy4BmJZkU+ww5cm68P4sKiHSE8V6uuPVR3+nhJWFpeYzjOQTEnQntKVIitBwCFmOyerGRYlg==
X-Received: by 2002:a17:902:f605:b0:22e:61b2:5eb6 with SMTP id d9443c01a7336-231b5e818c3mr7841815ad.15.1747268387445;
        Wed, 14 May 2025 17:19:47 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm105939545ad.20.2025.05.14.17.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:19:46 -0700 (PDT)
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
Subject: [PATCH v6 0/6] cgroup: separate rstat trees
Date: Wed, 14 May 2025 17:19:31 -0700
Message-ID: <20250515001937.219505-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current design of rstat takes the approach that if one subsystem is
flushed, all other subsystems with pending updates should also be flushed.
A flush may be initiated by reading specific stats (like cpu.stat) and
other subsystems will be flushed alongside. The complexity of flushing some
subsystems has grown to the extent that the overhead of side flushes is
causing noticeable delays in reading the desired stats.

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
real    1m48.716s
user    0m0.968s
sys     1m47.271s

experiment:
real    1m2.455s
user    0m0.849s
sys     1m1.349s

test program perf
control:
31.73% mem_cgroup_css_rstat_flush
 5.43% __blkcg_rstat_flush
 0.06% cpu_stat_show

experiment:
4.28% mem_cgroup_css_rstat_flush
0.30% blkcg_print_stat
0.06% cpu_stat_show

It's worth noting that memcg uses heuristics to optimize flushing.
Depending on the state of updated stats at a given time, a memcg flush may
be considered unnecessary and skipped as a result. This opportunity to skip
a flush is bypassed when memcg is flushed as a consequence of sharing the
tree with another controller.

A second experiment was setup on the same host using a parent cgroup with
two child cgroups. In the two child cgroups, kernel builds were done in
parallel, each using "-j 20". The perf comparison is shown below.

test program elapsed time
control:
real    1m55.079s
user    0m1.147s
sys     1m53.153s

experiment:
real    1m0.840s
user    0m0.999s
sys     0m59.413s

test program perf
control:
34.52% mem_cgroup_css_rstat_flush
 4.24% __blkcg_rstat_flush
 0.07% cpu_stat_show

experiment:
2.06% mem_cgroup_css_rstat_flush
0.17% blkcg_print_stat
0.11% cpu_stat_show

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
real    5m12.240s
user    84m51.325s
sys     3m53.507s

control with constant readers of {memory,io,cpu,cgroup}.stat
real    5m13.485s
user    84m51.361s
sys     4m7.204s

experiment with no readers
real    5m12.123s
user    84m50.655s
sys     3m53.344s

experiment with constant readers of {memory,io,cpu,cgroup}.stat
real    5m13.936s
user    85m11.534s
sys     4m4.301s

changelog
v6:
	add patch for warning on invalid rstat and early init combination
	change impl of css_is_cgroup() and rename to css_is_self()
	change impl of ss_rstat_init() so there is only one per-cpu loop
	move "cgrp" pointer initialization to top of css_rstat_init()
	rename is_rstat_css() to css_uses_rstat()
	change comment "subsystem lock" to include "rstat" in blk-cgroup.c
	change comment "cgroup" to "css" in updated_list/push_children

v5:
	new patch for using css_is_cgroup() in more places
	new patch adding is_css_rstat() helper
	new patch documenting circumstances behind where css_rstat_init occurs
	check if css is cgroup early in css_rstat_flush()
	remove ss->css_rstat_flush check in flush loop
	fix css_rstat_flush where "pos" should be used instead of "css"
	change lockdep text in __css_rstat_lock/unlock()
	remove unnecessary base lock init in ss_rstat_init()
	guard against invalid css in css_rstat_updated/flush()
	guard against invalid css in css_rstat_init/exit()
	call css_rstat_updated/flush and css_rstat_init/exit unconditionally
	consolidate calls to css_rstat_exit() into one (aside from error cases)
	eliminate call to css_rstat_init() in cgroup_init() for ss->early_init
	move comment changes to matching commits where applicable
	fix comment with mention of stale function css_rstat_flush_locked()
	fix comment referring to "cgroup" where "css" should be used

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

JP Kobryn (6):
  cgroup: warn on rstat usage by early init subsystems
  cgroup: compare css to cgroup::self in helper for distingushing css
  cgroup: use separate rstat trees for each subsystem
  cgroup: use subsystem-specific rstat locks to avoid contention
  cgroup: helper for checking rstat participation of css
  cgroup: document the rstat per-cpu initialization

 block/blk-cgroup.c                            |   4 +-
 include/linux/cgroup-defs.h                   |  78 +++--
 include/linux/cgroup.h                        |  10 +-
 include/trace/events/cgroup.h                 |  12 +-
 kernel/cgroup/cgroup-internal.h               |   2 +-
 kernel/cgroup/cgroup.c                        |  47 ++-
 kernel/cgroup/rstat.c                         | 313 +++++++++++-------
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  18 +-
 8 files changed, 301 insertions(+), 183 deletions(-)

-- 
2.47.1


