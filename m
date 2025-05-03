Return-Path: <cgroups+bounces-7996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F316BAA7DAB
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 02:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DDD1B6657C
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 00:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3845123CB;
	Sat,  3 May 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COmIyjFk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F5380
	for <cgroups@vger.kernel.org>; Sat,  3 May 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746231158; cv=none; b=dbJuMb9PTFPEvhfCYO5e3doW9oY4Ukj2MRWWwfjj04J7DXEcAd1yno2xozw1PQX9liSAgRqGEv9nSYAKXv0UNoSclPcL4EvhNgIs088JEnpQ90adyCr8bCQtSK1MpHXoixn7r7OemiUElV++6u30cMJ4Ow2kcZDaam6CMtrvxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746231158; c=relaxed/simple;
	bh=zfYX4eEAg0Bi9YsCbBOlSLGw710b6HkspPGfmTBmoeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0pxkBO9hIPbwWx/8yiLpSSxHP6pJywBwGpxF3Tkot9xPS4BgQB8eE+7hl7E6Up2Xt+BzzueEz4Oo0AesKrynElNWJ+Msl3g8rCJzBm8TfwY4F4lYDokuWXvMaOBDVALTI2I1KD8/wA8IuqtbHP7YJiyVorkjLhtomJuMMQHSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COmIyjFk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fd89d036so32348525ad.1
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746231155; x=1746835955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMQPikejRrIEBctpdAfUA6CI6t3vi46iXnaulKRN6bs=;
        b=COmIyjFkN9vgECNZspOOJ/D3Sj4hkOazn/sqAhAttr2za3eEmf0Pj6+lUHfqHWTtpj
         BYS98YI4uUAZZZSXQOOFGnJHLEXTC/01ExWuR/AmxNW5j4Lpnlrcn2V27H4CDmxZ4wl4
         yob/5MTmhcncRTA2AMdyIM5u+achCAB9JhuqUlKAQr0HsFw1lvmLuXnznK52ZyJxRyE+
         3AQqbaIWH7//Qsl/qgZ4XL7wKbZkEjabOyp8EZqLkFtLIGbJYW4R0kPz0TaajjUboxBI
         vvT8ogPimetu3KxY7OB2D42mV3cOaczrltw+s3uDvGeRWfeP+Zo+jjqeem0vlGcaIOOl
         wPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746231155; x=1746835955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMQPikejRrIEBctpdAfUA6CI6t3vi46iXnaulKRN6bs=;
        b=g0xRB2MRrxyZZXyCK5GSwcC3luqht/5/EQ6UD6v1PmYvgWpxK3vkeYOlfLdWtbz4MI
         0Nd0Z1bSBwnm5odkmJ9LiHEDb8Wps3WhNVYoIC32Z+T2bQsxWpBS4kMGQDRkKSY/e5yt
         JCLmxfhNWdlEm5dKIG0ktJRg8LngSVQfHiso6+QmWLu/aoqgeqK/+vBpjqePj15NHDkb
         ndgfJF0nyvqMf390iZnYmSQmX1WDSnGs/08sc0cLgSe2VxdUmY590HhFK6A5nCfnpum+
         W7HyhWp3q08p/wflvi0Pw2ZpWlvCLsajo2DR7LTcWYW1lbnKus9CztpwFg8/4MTD/PZ9
         Y/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVvBCH9F1Oo2eaBylr6qyw4/h6kTkF9SoTY7hPY7GMqewGssqovq3CywR4QFNdJbxNS6FITXM9U@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9e9QIVte+V0eooEsp3q84txmLKWzFgRqdyRNzq9ordPPn+pI
	f6pK3bkWz+XTXiZZnoWbccchUhGXm/53sjMDEwy2nE9fjVje87IE
X-Gm-Gg: ASbGncsF3yL43sEcAFpivQSkGEp79hWbRjlr5meeMHcOiTovkJKPOxXTKmRHi3+0/Dh
	7pBBwQc3LVWB00yXJTEzCOnA4csSZ6heKq7KgFqdx59FJ9/DonbCEa+dk+25mQ34z4GYZz7joY7
	MHkKSMTsmp+kp7gYY6G5ZUuRwSaVCtXBRRvKiaFShWbqTxCBV+fqUHINe3EBcQx9/6n4cDv93Tx
	+/pHq+4SS9+KM7qgWVnPXQVekHUQlVBG5vHTSdptQsOCAp07TqKZVIGZTuXwnlzUukRKawUsqdm
	779LILgqRqnRMmWr9kOsRfibo6zH6Ua/L1uc8x95uQLBRo31d9CvK2VJOgUCU8Lo4tCP
X-Google-Smtp-Source: AGHT+IGlq6J9afu3u3FiSYd5nD6EGQN1bLKOUri8vnXOKMlgQQ76DNZb9jq2bJuBKOv2a2NheXWtrA==
X-Received: by 2002:a17:902:c404:b0:224:c47:cb7 with SMTP id d9443c01a7336-22e10225959mr81666325ad.0.1746231155450;
        Fri, 02 May 2025 17:12:35 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::5:6a01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f9csm13718635ad.178.2025.05.02.17.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 17:12:34 -0700 (PDT)
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
Subject: [PATCH v5 0/5] cgroup: separate rstat trees
Date: Fri,  2 May 2025 17:12:17 -0700
Message-ID: <20250503001222.146355-1-inwardvessel@gmail.com>
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
real    1m29.929s
user    0m0.933s
sys     1m28.525s

experiment:
real    1m3.604s
user    0m0.828s
sys     1m2.497s

test program perf
control:
29.47% mem_cgroup_css_rstat_flush
 5.09% __blkcg_rstat_flush
 0.07% cpu_stat_show

experiment:
6.89% mem_cgroup_css_rstat_flush
0.31% blkcg_print_stat
0.07% cpu_stat_show

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
real    1m59.647s
user    0m1.263s
sys     1m57.511s

experiment:
real    1m0.328s
user    0m1.077s
sys     0m58.834s

test program perf
control:
35.69% mem_cgroup_css_rstat_flush
4.49% __blkcg_rstat_flush
0.07% cpu_stat_show
0.05% cgroup_base_stat_cputime_show

experiment:
2.04% mem_cgroup_css_rstat_flush
0.18% blkcg_print_stat
0.09% cpu_stat_show
0.09% cgroup_base_stat_cputime_show

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
real    5m11.548s
user    84m45.072s
sys     3m52.069s

control with constant readers of {memory,io,cpu,cgroup}.stat
real    5m13.619s
user    85m1.847s
sys     4m5.379s

experiment with no readers
real    5m12.557s
user    84m54.966s
sys     3m53.383s

experiment with constant readers of {memory,io,cpu,cgroup}.stat
real    5m12.548s
user    84m56.313s
sys     3m54.955s

changelog
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

JP Kobryn (5):
  cgroup: use helper for distingushing css in callbacks
  cgroup: use separate rstat trees for each subsystem
  cgroup: use subsystem-specific rstat locks to avoid contention
  cgroup: helper for checking rstat participation of css
  cgroup: document the rstat per-cpu initialization

 block/blk-cgroup.c                            |   2 +-
 include/linux/cgroup-defs.h                   |  78 +++--
 include/trace/events/cgroup.h                 |  12 +-
 kernel/cgroup/cgroup-internal.h               |   2 +-
 kernel/cgroup/cgroup.c                        |  41 +--
 kernel/cgroup/rstat.c                         | 310 +++++++++++-------
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  18 +-
 7 files changed, 289 insertions(+), 174 deletions(-)

-- 
2.47.1


