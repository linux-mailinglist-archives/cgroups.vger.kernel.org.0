Return-Path: <cgroups+bounces-7179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D310A69BE2
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE88188C985
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499121A43C;
	Wed, 19 Mar 2025 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVdIgdwo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C0214A7A
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422629; cv=none; b=NvVcWD7+T0k08RXf1MokQx1bi+LX1jkZ/PHpCx8cHNxVBhwitOQnwV4F88YIY57SFwQlYaGlwfUssZrM9uSVje7XdHSh/AHQkr70v7LLa/JYWely2pzToufYWqUE/+0mFaF1Z1lLNdwd5PxxHrpHtvgCPhMN3sUVnAGmRXdZPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422629; c=relaxed/simple;
	bh=BtpLaPpYU+IBzBZlJ6Q7/OlUmNWpWbsQ+7aQ9ZzMKok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHovfyiOQJ2/t2/e4Pos6ztUiLA9uxpwT2vw19M6f9pXpDM9HsIkvG1r78zezHzJtvAwBs3eMD9eNsDs5+B5gA6OQomy8ZFHyCGvJJZKzQSJm0YORePHR2SveH6YZWr2hnmYc2YnEoN+Ptfz+7wW+q0QZBGI8ErvVnv6AmXjLPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVdIgdwo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fb0f619dso1094635ad.1
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422627; x=1743027427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m09yt2A2os49rhFZLeuucmU+hSklZW9p02skFAjq9sg=;
        b=ZVdIgdwowz3UlgdyK9WXd7koUMYoCeJ8SLiB/ErXgp4fjVGjmiEoNAoAPa/rUi9COc
         xXcCBbusCwLyvGLNbRrlC2mHSR3HpqMUpdRDcR1hFCTcXjxRTzrnDinbCapHNSuFdDKp
         qK2Fm5IQpA5i7gSzttRrXEOA5xl2ErQijgD0A022/DyKWTajq0y117QcQGzdZqEHRllH
         AZyYP6Zh6dfGTj4+OL0PkA4kScYJ6iz3EP//wc9WKtnnACNwwS8rqc4YSxZW63WlTU+q
         kz8rZH+nfdAeOkWwoRSyfVz5dl5tqpOoBDQmmlQjcSx6Oxu7nzsEfMaV/Ro1FM9iW1sy
         8ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422627; x=1743027427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m09yt2A2os49rhFZLeuucmU+hSklZW9p02skFAjq9sg=;
        b=sVhcCPXNSvX0LCQek4NymduyJJQnc/FUbhI4aGczUl+MJY1Mojp0JL67GQBmsbH+ob
         xuEtxes2dcqNsB7q2tgoDRpEig4YxAFCMUTgn8uG9CrqLhOpOszSW8BA2y/PiYttVF4I
         vZfFkAnLwyWkQKjUDzf8Oxtb6BlGLEG6bneWaV/rnF8sJhQcEZHfHqkwi/Y5J6Doy3ak
         ml5WDtV1fzZiS9QjKAjFD7AxkyiHC7FabTu/56rClUmQmHvI0kjd8y5r6tq6ytVJW8LD
         FF1jK0kVq8wliNqxSUYY35qBUQcq/mINkftJJwCRREgqZvOkCIvV00B2Md/WQi9OMKuM
         mctg==
X-Forwarded-Encrypted: i=1; AJvYcCXgoW2I4ljpiOEa4sTBvm5JVTfmRAiQX2S1D0AWXVRpr7+xFdIi51Jus6RqRfmRV3BtJwn1ijtW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9V3+ER2hCmGI8z59ZnrueoWLLzEwG0XR+LpeUjwjq0VtRsNSd
	3OGXa6Hflt0KLmqXdxzPeDkxV3sQhkt7cTU3aFssvOsWPgF+uCGEQJuZvg==
X-Gm-Gg: ASbGncslppTdMkbvEmEe4X9rKUDFDZwZjUOzpYo+mIylzI/P1TOgdQCJPwNWIalOMxY
	6AXz1c1QKJPBVkps5mSkGDZvO/WABSXyvQgAq3Jx5jjfzJDWZ19aF44uUFc3uP7b3MEVMZhAvRq
	eugUxlpch+YDfkUbblhVmzeLbUJI+N/yByGz3Ba5Ji4alzwCoEMn8bYbWWsHTlBqA9kzLLKzmji
	PA3BOEzPx1Yugj8hJ2HfWst2TqOWrr2sBjnN9qxoBiUQsjT9iYxIXctZ2JH3IKUSBb9zSpb8/dA
	3UU96ALlquCPvY/VwV+iEYj4i9ovPmUENQsTNNYlECZzKRTyyRWYZqkcGrqKlwnCVGsI13/g
X-Google-Smtp-Source: AGHT+IF6+Y8wbTSWiiFtGiLxE++uWqPigzI26xF/gkBhpRPozJisZj7BIH6u4GA2Kt/WVSMY1rnKig==
X-Received: by 2002:a05:6a00:2e99:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-7376d6fae4emr6196553b3a.23.1742422627036;
        Wed, 19 Mar 2025 15:17:07 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:39d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116af372sm12253977b3a.160.2025.03.19.15.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:17:06 -0700 (PDT)
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
Subject: [PATCH 0/4 v2] cgroup: separate rstat trees
Date: Wed, 19 Mar 2025 15:16:30 -0700
Message-ID: <20250319221634.71128-1-inwardvessel@gmail.com>
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


