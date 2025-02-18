Return-Path: <cgroups+bounces-6574-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA990A3912A
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687757A271E
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779515667D;
	Tue, 18 Feb 2025 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5n3dy5e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC801581E5
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848501; cv=none; b=ZiJNvc5GrSVuQrPhmPKyLdwZMCo27y1fCZ7fboQFZgnpIm+Wjq4Lys8tDuBmFQcEKuZuhAdisOQrYZkeZ4WcBDyjFQncgjUebwQeYyy/+Yv941xN88p9MhjLq94Y/s0grpl/wFoANkFqlV5z54W1TjD5eijKdYfR5b7h/5vsrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848501; c=relaxed/simple;
	bh=Hp9A/uBP8oEsHuMt9qRVNg625AE43lfL9tTYKJ/5kgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDD+Au9DSJeYUOp3xIj1sH5TllkQXuwE26KEtC4JmQMbDjHh+Zj37LacalA+SpLTnfK3S+5gqo+gItEBQnZQQTwvVOMVoVVGFYcsce9jFrfdU7Drxkdr8spkPxLUS/rt/HvptjulBuiuTRBFLk8DmEuKcvVuxqvxfzoXP1NbWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5n3dy5e; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso6246300a91.3
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848499; x=1740453299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=niGY7JHHPrDQ3SchyF27p3eckRjqT7SImnTCyp5rusw=;
        b=f5n3dy5e1G2WQacGHWdHhhLST63fiPkSIhlryxKVnpi7Sb79/pGFUZO5KPNNCpwU+0
         ojX+vMRac9K3e2qibFg0URXDBcUI546pdg3Q7DrhlfZduWBx6ogAapde3YDrs1Mk6FVK
         VEZ6O/Lo3vWdnxrD021Bq2IaFAngpNBYqOO0JsTcgfNAbwwrVTJlWnKjf5AjM+SXbpQ/
         ICHUQ5HAQtRtckWS6a12M+45uRDub1SFYmWyCV53CBe+Mk/nsacW/6z5qDq4SzwnSyPi
         Jcwy2fqr1iFNXJMmmvx/BTiOQGFwzOLxlZkp6O/YEpTcqjr8Gcc5xzm6ZyYxLPfBwheq
         KIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848499; x=1740453299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niGY7JHHPrDQ3SchyF27p3eckRjqT7SImnTCyp5rusw=;
        b=EI7aq72kbbsXaW+0T6Er/yDp3ZpDjJ06eFQ54xWJSsZwkcP67bV0phWvwpvwdRlbL+
         qWSPaw2cZ0DIoU3I9HQqrJtOop58Ucdj0EpZ3Ri82JHW4s4eS+hV1tR22UsDBj9BoVHh
         tOZxsWTUK3Gv4hgA6ETZV0gtoWD7iGMSM9K2RdUEPEtWd2wnVrpP3jDrUvope01CZtN2
         r3EQVpOBQmR774/ZsFafdUrPsjntwLjosRtGGa7bS5aVzc5ky4hnQ1HQPvH3k1YexFuO
         ZMaqit2RMT0Hu8kwzZPRO3zSbkw9MKA8cKAWZEJeYgXqMCtKUGfpvRLZUug9I7ICrGGQ
         LT7A==
X-Forwarded-Encrypted: i=1; AJvYcCUQupf/8xyA2lD/yu6WrYPZazJuNG4VGq8ge/Jf2g5zInDQf5iFcAVg8dLCwSKOaVoPXsprADU0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjdv3jtcaKGiXCroW2QlrPB3AT84Sj5rp2hi7GESyJHyAc7zAV
	d+F9gm660bI27Yvfh23seVhuZLwXZzhJrj+KztfnbEUXFKP46QQl
X-Gm-Gg: ASbGncsYHZg0K8+WeVRpIhx+0aQFjWylyMuTpD551ximMbEXVCTxcaVjRMwHFEScstM
	61k+AiNr6gONW4s0ogD9fG6GRhSnm5pzfaRDZZm/XyT8NDyhwkFepW9JE7qXJQhyiq9a7dyVIYN
	RD8DjexxUNAWGUpwP/euzxpzn4JV5XUAdsAwK7MYtn+qXIkII0z2L3bl32qFbMfuoisoN+301rM
	aZbRm9qSJQ2sVTJCtmBJkUnKS3bmxZEl4APLYdxDcJRklhYo+m9246xHGi4vpY+4k8QmhOvdDPs
	7WyTg0c37Bq9NRkG117+ospN+DrN8EFQe6vBdxtlDT9hAAxSyWwr
X-Google-Smtp-Source: AGHT+IHOg4uFeif1APZ6hzvBcrdqezal35fLdvW9tYGpuiBl4I4xUwI/W/+Jt+EBOTVH0DtbLbPTEA==
X-Received: by 2002:a05:6a00:3d55:b0:732:56cb:2f83 with SMTP id d2e1a72fcca58-732618c2987mr17513685b3a.15.1739848499389;
        Mon, 17 Feb 2025 19:14:59 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:14:58 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 00/11] cgroup: separate rstat trees
Date: Mon, 17 Feb 2025 19:14:37 -0800
Message-ID: <20250218031448.46951-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current design of rstat takes the approach that if one subsystem is to
be flushed, all other subsystem controllers with pending updates should
also be flushed. It seems that over time, the stat-keeping of some
subsystems has grown in size to the extent that they are noticeably slowing
down others. This has been most observable in situations where the memory
controller is enabled. One big area where the issue comes up is system
telemetry, where programs periodically sample cpu stats. It would be a
benefit for programs like this if the overhead of flushing memory stats
(and others) could be eliminated. It would save cpu cycles for existing
cpu-based telemetry programs and improve scalability in terms of increasing
sampling frequency and volume of hosts the program is running on - the cpu
cycles saved helps free up the budget for cycles to be spent on the desired
stats.

This series changes the approach of "flush all subsystems" to "flush only the
requested subsystem". The core design change is moving from a single unified
rstat tree to having separate trees: one for each enabled subsystem controller
(if it implements css_rstat_flush()), one for the base stats (cgroup::self)
subsystem state, and one dedicated to bpf-based cgroups (if enabled). A layer
of indirection was introduced to rstat. Where a cgroup reference was previously
used as a parameter, the updated/flush families of functions were changed to
instead accept a references to a new cgroup_rstat struct along with a new
interface containing ops that perform type-specific pointer offsets for
accessing common types. The ops allow rstat routines to work only with common
types while hiding away any unique types. Together, the new struct and
interface allows for extending the type of entity that can participate in
rstat. In this series, the cgroup_subsys_state and the cgroup_bpf are now
participants. For both of these structs, the cgroup_rstat struct was added as a
new field and ops were statically defined for both types in order to provide
access to related objects. To illustrate, the cgroup_subsys_state was given an
rstat_struct field and one of its ops was defined to get a pointer to the
rstat_struct of its parent.  Public api's were changed. In order for clients to
be specific about which stats are being updated or flushed, a reference to the
given cgroup_subsys_state is passed instead of the cgroup. For the bpf api's, a
cgroup is still passed as an argument since there is no subsystem state
associated with these custom cgroups. However, the names of the api calls were
changed and now have a "bpf_" prefix. Since separate trees are in use, the
locking scheme was adjusted to prevent any contention. Separate locks exist for
the three categories: base stats (cgroup::self), formal subsystem controllers
(memory, io, etc), and bpf-based cgroups. Where applicable, the functions for
lock management were adjusted to accept parameters instead of globals.

Breaking up the unified tree into separate trees eliminates the overhead
and scalability issue explained in the first section, but comes at the
expense of using additional memory. In an effort to minimize the additional
memory overhead, a conditional allocation is performed. The
cgroup_rstat_cpu originally contained the rstat list pointers and the base
stat entities. The struct was reduced to only contain the list pointers.
For the single case of where base stats are participating in rstat, a new
struct cgroup_rstat_base_cpu was created that contains the list pointers
and the base stat entities. The conditional allocation is done only when
the cgroup::self subsys_state is initialized. Since the list pointers exist
at the beginning of the cgroup_rstat_cpu and cgroup_rstat_base_cpu struct,
a union is used to access one type of pointer or the other depending on if
cgroup::self is detected; it is the one subsystem state where the subsystem
pointer is NULL. With this change, the total memory overhead on a per-cpu
basis is:

nr_cgroups * (
	sizeof(struct cgroup_rstat_base_cpu) +
	sizeof(struct cgroup_rstat_cpu) * nr_controllers
)

if bpf-based cgroups are enabled:

nr_cgroups * (
	sizeof(struct cgroup_rstat_base_cpu) +
	sizeof(struct cgroup_rstat_cpu) * (nr_controllers + 1)
)

... where nr_controllers is the number of enabled cgroup controllers
that implement css_rstat_flush().

With regard to validation, there is a measurable benefit when reading a
specific set of stats. Using the cpu stats as a basis for flushing, some
experiments were set up to measure the perf and time differences.

The first experiment consisted of a parent cgroup with memory.swap.max=0
and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created and
within each child cgroup a process was spawned to encourage the updating of
memory cgroup stats by creating and then reading a file of size 1T
(encouraging reclaim). These 26 tasks were run in parallel.  While this was
going on, a custom program was used to open cpu.stat file of the parent
cgroup, read the entire file 1M times, then close it. The perf report for
the task performing the reading showed that most of the cycles (42%) were
spent on the function mem_cgroup_css_rstat_flush() of the control side. It
also showed a smaller but significant number of cycles spent in
__blkcg_rstat_flush. The perf report for patched kernel differed in that no
cycles were spent in these functions. Instead most cycles were spent on
cgroup_base_stat_flush(). Aside from the perf reports, the amount of time
spent running the program performing the reading of cpu.stats showed a gain
when comparing the control to the experimental kernel.The time in kernel
mode was reduced.

before:
real    0m18.449s
user    0m0.209s
sys     0m18.165s

after:
real    0m6.080s
user    0m0.170s
sys     0m5.890s

Another experiment on the same host was setup using a parent cgroup with
two child cgroups. The same swap and memory max were used as the previous
experiment. In the two child cgroups, kernel builds were done in parallel,
each using "-j 20". The program from the previous experiment was used to
perform 1M reads of the parent cpu.stat file. The perf comparison showed
similar results as the previous experiment. For the control side, a
majority of cycles (42%) on mem_cgroup_css_rstat_flush() and significant
cycles in __blkcg_rstat_flush(). On the experimental side, most cycles were
spent on cgroup_base_stat_flush() and no cycles were spent flushing memory
or io. As for the time taken by the program reading cpu.stat, measurements
are shown below.

before:
real    0m17.223s
user    0m0.259s
sys     0m16.871s

after:
real    0m6.498s
user    0m0.237s
sys     0m6.220s

For the final experiment, perf events were recorded during a kernel build
with the same host and cgroup setup. The builds took place in the child
node.  Control and experimental sides both showed similar in cycles spent
on cgroup_rstat_updated() and appeard insignificant compared among the
events recorded with the workload.

JP Kobryn (11):
  cgroup: move rstat pointers into struct of their own
  cgroup: add level of indirection for cgroup_rstat struct
  cgroup: move cgroup_rstat from cgroup to cgroup_subsys_state
  cgroup: introduce cgroup_rstat_ops
  cgroup: separate rstat for bpf cgroups
  cgroup: rstat lock indirection
  cgroup: fetch cpu-specific lock in rstat cpu lock helpers
  cgroup: rstat cpu lock indirection
  cgroup: separate rstat locks for bpf cgroups
  cgroup: separate rstat locks for subsystems
  cgroup: separate rstat list pointers from base stats

 block/blk-cgroup.c                            |   4 +-
 include/linux/bpf-cgroup-defs.h               |   3 +
 include/linux/cgroup-defs.h                   |  98 +--
 include/linux/cgroup.h                        |  11 +-
 include/linux/cgroup_rstat.h                  |  97 +++
 kernel/bpf/cgroup.c                           |   6 +
 kernel/cgroup/cgroup-internal.h               |   9 +-
 kernel/cgroup/cgroup.c                        |  65 +-
 kernel/cgroup/rstat.c                         | 556 +++++++++++++-----
 mm/memcontrol.c                               |   4 +-
 .../selftests/bpf/progs/btf_type_tag_percpu.c |   5 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |   6 +-
 12 files changed, 594 insertions(+), 270 deletions(-)
 create mode 100644 include/linux/cgroup_rstat.h

-- 
2.43.5


