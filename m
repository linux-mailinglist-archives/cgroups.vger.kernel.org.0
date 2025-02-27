Return-Path: <cgroups+bounces-6729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3EEA48AE6
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 22:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF11D3B6F38
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C1271818;
	Thu, 27 Feb 2025 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4kWLLjW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856A27180C
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693359; cv=none; b=pxmLdta5fZ34SqBO1YN0evIR9WcNU+XDjM2j4VN7qD3ZL7zyeJRtotyh4HDIUbc6AW2SooJ3tLEztMXgUIERhENL621JgXeeu7TOpp+wrVRV4YoSzwk/iSc5KgU50x65W6DTRma6BprQ5aGjtIYPV84qufYjGoC4Ch8OK/iqtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693359; c=relaxed/simple;
	bh=stfp27VjJDgDNOMxSUe1XCxFOJD/27sDFQ+AqafonFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGWQytcrSLs+MH34ljSRuv4C7MaFcNisOcc70PlzObgvlWkMKo3U70EU7ljFrb8Ycm03bhW8F8ehxjvztG99CnGhKqpBP6cjBPiyRmw/HH8pkM+dj98Nl15rgSya25ee2r/bOoupHKyeCvLtKEBBdQjkICwklDu6ROs8OKD+qgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4kWLLjW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349dc31bcso27323445ad.3
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 13:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693355; x=1741298155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XFfAgp/+4UL4ly3BmhcVa92nPM9QTii4Pvvc5uFPH7w=;
        b=L4kWLLjW5cJk3kb/FuC0TUJIszHkwbvC9gqnu62+PXTYKM3+4GAaOz2MTLXG7+0mKx
         07i4BIcy1AViaq1jAHxi1fHEW6Cg/Q4xyXSMm6/TB6asZhZ0CBy5dEX7o+WrhA+IVG/y
         sKuPjvUvEP4v6ntNowV9sWsuxnyO8IqkZjqbeCm90U6kphbIg4DaQRYGOU1Jt9GOm+Ca
         a1fQu58358CLeFK2Aw9tTO8PRowFtixJbSISYXZ+wihiajT8I1iPEFza8o/KuQZptHf7
         h8JYO7XIBbWL+z2+PLVIDUZokJqms+HynPhAEayiXkAbHGd42jNPvTPnVAjKbbnQ+wqw
         76/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693355; x=1741298155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFfAgp/+4UL4ly3BmhcVa92nPM9QTii4Pvvc5uFPH7w=;
        b=mq4Lpt6tHRJZKcI+D1INhuMGWXyew0LiL5K0JvrBqn89A/voMGw7wyW/RjXpsjddA4
         qTBhPTn1KZmO5okwtdsSu0YH6/G33e9Ppg8fPTXl0olnlA46WKivEcd022a2NUAmS1q+
         kvlqh6KVQHpkX1zoEHdudEGPWWCcejZW+2kUEWZU7Xx0NrfEgiw1zzb004tXErh68gT2
         s8yojQbTkdzkfX1/cg918OEABpH33f81Xq03HX6VoRmVvkP9GpkiA+sFL7mpjub2Rgqk
         1YirlNnLq0R4vYcZ2gtusQRQw1NjJRsVS07NnThdGVQ8GyrSzm0xId+RRFe/6xD1iZam
         mdIA==
X-Forwarded-Encrypted: i=1; AJvYcCUY+RoKvdgv0IFK+XgnmckzvcVv6ndtLBgcmt7PBL/wCp1A25fK/rbMg3ku7iz+oxWsFAlPf83b@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4QN+Cs6c4SkA4do5w9sDEZOgdj6zMBkIKkAWsq8bA2QW9Vy0
	FZeqEluWFqJvuQoH5w+4kamudxZvs4CniJ6lR3ScnxTXpDwbef47
X-Gm-Gg: ASbGncvKrd6xHhGJgkT4iGYA2kW1fd3P7ZurkjDzvm3xe1P9kCy+DRRiWg7Hc9qPNDq
	CT+WqVp8D1gYtkwMXJM94RCXeuv29bvbxeXZqWxFUiK87G8lsJGpgeUJqkYb6Fx8gLdHx9bhr4k
	WkD6mVPkAJQL7cwZjA/SS4Ceb+gFakPdmArEk/jhjO9vEBptj6mJ5h8pZK0LtB3RANOudA75A6G
	872SiEHZiyVJh+BhH3R1qZ+Zx5A/zwuUb+OgxmNcpPym8JrHOcr6YEuTIk4fNmcVT9sDxx+0ftB
	CTvQ+DbfikyMZMvK6KxtXrsJ9OEtC1GtjLY3y3bRPJqiS59AeRSMnw==
X-Google-Smtp-Source: AGHT+IH6B7scBvtcx+P0GquXZephxa+AthFtxLpIUQHxG+s/yVwzsrR990aIZxl+oUqUg2YUBiMRRg==
X-Received: by 2002:a05:6a00:3d13:b0:725:9f02:489a with SMTP id d2e1a72fcca58-734ac3f4e60mr1444541b3a.17.1740693355486;
        Thu, 27 Feb 2025 13:55:55 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:4d60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb65sm2301321b3a.149.2025.02.27.13.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:55:54 -0800 (PST)
From: inwardvessel <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/4 v2] cgroup: separate rstat trees
Date: Thu, 27 Feb 2025 13:55:39 -0800
Message-ID: <20250227215543.49928-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JP Kobryn <inwardvessel@gmail.com>

The current design of rstat takes the approach that if one subsystem is
to be flushed, all other subsystems with pending updates should also be
flushed. It seems that over time, the stat-keeping of some subsystems
has grown in size to the extent that they are noticeably slowing down
others. This has been most observable in situations where the memory
controller is enabled. One big area where the issue comes up is system
telemetry, where programs periodically sample cpu stats. It would be a
benefit for programs like this if the overhead of having to flush memory
stats (and others) could be eliminated. It would save cpu cycles for
existing cpu-based telemetry programs and improve scalability in terms
of sampling frequency and volume of hosts.

This series changes the approach of "flush all subsystems" to "flush
only the requested subsystem". The core design change is moving from a
single unified rstat tree of cgroups to having separate trees made up of
cgroup_subsys_state's. There will be one (per-cpu) tree for the base
stats (cgroup::self) and one for each enabled subsystem (if it
implements css_rstat_flush()). In order to do this, the rstat list
pointers were moved off of the cgroup and onto the css. In the
transition, these list pointer types were changed to
cgroup_subsys_state. This allows for rstat trees to now be made up of
css nodes, where a given tree will only contains css nodes associated
with a specific subsystem. The rstat api's were changed to accept a
reference to a cgroup_subsys_state instead of a cgroup. This allows for
callers to be specific about which stats are being updated/flushed.
Since separate trees will be in use, the locking scheme was adjusted.
The global locks were split up in such a way that there are separate
locks for the base stats (cgroup::self) and each subsystem (memory, io,
etc). This allows different subsystems (including base stats) to use
rstat in parallel with no contention.

Breaking up the unified tree into separate trees eliminates the overhead
and scalability issue explained in the first section, but comes at the
expense of using additional memory. In an effort to minimize this
overhead, a conditional allocation is performed. The cgroup_rstat_cpu
originally contained the rstat list pointers and the base stat entities.
This struct was renamed to cgroup_rstat_base_cpu and is only allocated
when the associated css is cgroup::self. A new compact struct was added
that only contains the rstat list pointers. When the css is associated
with an actual subsystem, this compact struct is allocated. With this
conditional allocation, the change in memory overhead on a per-cpu basis
before/after is shown below.

before:
sizeof(struct cgroup_rstat_cpu) =~ 176 bytes /* can vary based on config */

nr_cgroups * sizeof(struct cgroup_rstat_cpu)
nr_cgroups * 176 bytes

after:
sizeof(struct cgroup_rstat_cpu) == 16 bytes
sizeof(struct cgroup_rstat_base_cpu) =~ 176 bytes

nr_cgroups * (
	sizeof(struct cgroup_rstat_base_cpu) +
		sizeof(struct cgroup_rstat_cpu) * nr_rstat_controllers
	)

nr_cgroups * (176 + 16 * nr_rstat_controllers)

... where nr_rstat_controllers is the number of enabled cgroup
controllers that implement css_rstat_flush(). On a host where both
memory and io are enabled:

nr_cgroups * (176 + 16 * 2)
nr_cgroups * 208 bytes

With regard to validation, there is a measurable benefit when reading
stats with this series. A test program was made to loop 1M times while
reading all four of the files cgroup.stat, cpu.stat, io.stat,
memory.stat of a given parent cgroup each iteration. This test program
has been run in the experiments that follow.

The first experiment consisted of a parent cgroup with memory.swap.max=0
and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created
and within each child cgroup a process was spawned to frequently update
the memory cgroup stats by creating and then reading a file of size 1T
(encouraging reclaim). The test program was run alongside these 26 tasks
in parallel. The results showed a benefit in both time elapsed and perf
data of the test program.

time before:
real    0m44.612s
user    0m0.567s
sys     0m43.887s

perf before:
27.02% mem_cgroup_css_rstat_flush
 6.35% __blkcg_rstat_flush
 0.06% cgroup_base_stat_cputime_show

time after:
real    0m27.125s
user    0m0.544s
sys     0m26.491s

perf after:
6.03% mem_cgroup_css_rstat_flush
0.37% blkcg_print_stat
0.11% cgroup_base_stat_cputime_show

Another experiment was setup on the same host using a parent cgroup with
two child cgroups. The same swap and memory max were used as the
previous experiment. In the two child cgroups, kernel builds were done
in parallel, each using "-j 20". The perf comparison of the test program
was very similar to the values in the previous experiment. The time
comparison is shown below.

before:
real    1m2.077s
user    0m0.784s
sys     1m0.895s

after:
real    0m32.216s
user    0m0.709s
sys     0m31.256s

Note that the above two experiments were also done with a modified test
program that only reads the cpu.stat file and none of the other three
files previously mentioned. The results were similar to what was seen in
the v1 email for this series. See changelog for link to v1 if needed.

For the final experiment, perf events were recorded during a kernel
build with the same host and cgroup setup. The builds took place in the
child node. Control and experimental sides both showed similar in cycles
spent on cgroup_rstat_updated() and appeard insignificant compared among
the events recorded with the workload.

changelog
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
  cgroup: move cgroup_rstat from cgroup to cgroup_subsys_state
  cgroup: rstat lock indirection
  cgroup: separate rstat locks for subsystems
  cgroup: separate rstat list pointers from base stats

 block/blk-cgroup.c                            |   4 +-
 include/linux/cgroup-defs.h                   |  67 ++--
 include/linux/cgroup.h                        |   8 +-
 kernel/cgroup/cgroup-internal.h               |   4 +-
 kernel/cgroup/cgroup.c                        |  53 +--
 kernel/cgroup/rstat.c                         | 318 +++++++++++-------
 mm/memcontrol.c                               |   4 +-
 .../selftests/bpf/progs/btf_type_tag_percpu.c |   5 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |   8 +-
 9 files changed, 276 insertions(+), 195 deletions(-)

-- 
2.43.5


