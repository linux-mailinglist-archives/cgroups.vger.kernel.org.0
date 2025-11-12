Return-Path: <cgroups+bounces-11878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B54C5424C
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 20:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E91034AF1D
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6634C80C;
	Wed, 12 Nov 2025 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AiXhA/IJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5755337B9D
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975791; cv=none; b=g2SGx4eDoT9LOTR4sg0E3GzzqG5AbC1pK8HVmgLkladrbn9Ii+yX+WGoADAjxBEsaAirXGXihZbczIIFd5kOh5Yo+/OmiT4bwh6jdSCKO5q49Os684HZ389Il37nLZvk9vp2saYuClngKE/0SVFONHnuzSXkHlXoRIKBcdui7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975791; c=relaxed/simple;
	bh=StySJd2HRBF/nsbSvPA1UpC//DtcjLkEErMiwN89jiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVoo1K6atDVhcCiib5sEQbS/AXyVYzs+FCsH76dUMA/Cc3S+0Ba60+2+Ko36nfvHHJO4zCTUvCVBINnqNwKJ7hhb7yX6IbljRN/mYEeM7tsigRS+vcJ3/e2msGNiBx41i28TXzwmmHlmZUIQDOK6kv8pAhz8ZJUMgx1n1SKnExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AiXhA/IJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b22b1d3e7fso3463585a.3
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975787; x=1763580587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+0KzZp8SwB3qOByrtp+OoMjU8q91P/BfZmx06JIMXk=;
        b=AiXhA/IJSywfiI1EHwNMspEXBtl1YDdO20crj/68rdzwATZzb7ig29UDTbFxvOOvAw
         Ea/cNfdGWPR33HrtHdvMS7F/7vtqLPG7xTLDW+l3Za9wHlhDZcpaCgv2i7kV7IBS5/Vz
         3DWMpzta2maCKyxgUPRw5VXPzxdFav/qwfGoeBNg4P8Z6BFvv+YbKIujmrvFA7SqURvb
         yh+DvPu7x5c17FZDT1jB+l3euuzE4MQoR9v1ussGnSSGp9X2nBiiaRROVVA+k/kI4Ruo
         usx/ZaWqH6tI7aU4la/DYpGuc3ZrZGYj2PhJ8//2qmJgh8myGQJPrs3gBdp9T5pmejsp
         mKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975787; x=1763580587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+0KzZp8SwB3qOByrtp+OoMjU8q91P/BfZmx06JIMXk=;
        b=KkRhVhle++jrT8jJn20FBfRALYYwlFUpvQJEPunWCDEE9NSK3VQ+rCePm2qihAOQMz
         7eYmLlrFfbR6pFLVrbcMkCK9v2Oyy/xnTTYI/XvYxH5TxAsHGChKvEIy6Kd29Yxj25rE
         +NNOYWUQVxFB1GNMWeYaTbCTXsGn9wuHwLC+O2+PPv4of3MgB5Rvy+Esccpq9wkHJYJd
         MsOGwgGx6NniikoqhNqWdJRz0UdCl3oRgYmCchZ59ieak+JMsuGHBKbD0qCpIvvkECRq
         UYyjcobHvJAuhILnxETsjrd14JoRVRlNa2di8YE/o+xj17/cTmtWEu8B/Q3Lhsh2ZnTc
         5jqw==
X-Forwarded-Encrypted: i=1; AJvYcCXOiSINtpU1LT+4j8HMhL2xopdVRyqLQdLpqbugSKN6PEjay3zBxcWsg3dPJnke+68CM/wkVVet@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZbL0M+gn8ZVCSJKiHQUuzyZnqSAuayzs+0c/WRnoayqY3eO9
	qaCSe1KOKwHLaRj7Ieu/67g94bcZ6O0yUVMtjt/VRcSxdxmSTpbgxKKazwxdWZj4Veg=
X-Gm-Gg: ASbGncuGJYDuQeeyzqsRD7AVZfcNxb86HKO/VCm/piQgfFCTW9hQscPgrfbDCjPJpnb
	ULh66UwD5RKnqB+ZtioU0z8YGEEHxXTLHOOL08ltXFV5u5gT/pNij73samq1y6gqdARYBGruS9W
	rIRpyBhIkQB4J4F+iSfELS9HkC6lwe1LMOQiihcb2pUgJ1VMvqlZC9Ojje+PzbqDvGXGqfn9UYo
	gFOTGujJy0+b6BJh5RtFzqhxlSPhcjBiIJNFsNb18W4Slz10RILVaOIUtb4mOscSQi/omN7byXI
	HrxszGy+vGR05NypSBmbB9P7d5oBJJ/GP71lKa8fFZ33EO7IH2hulX/SQsjmA1qaoAkGpFgXgzF
	cMmXkjX8loR5IJ+tzPTBEapfIHLDYN8LqkhmBF1YL9AMeRi/wR9uOlOpGGma4xiiiMNf/5Bywpy
	VjcGbk/B1ZKoDzAOFNLm+FCaUvoRAwXusRvn5r+ftKjs11/C4M4n58L3eRUGwZzmJA
X-Google-Smtp-Source: AGHT+IED/6odDPyQbULX4YBs7xZBD1FyA57cRMNb3Lw5e2EsWmuJNVD+txeZjw/L/EjeaGulzMWhyA==
X-Received: by 2002:a05:620a:f15:b0:892:8439:2efa with SMTP id af79cd13be357-8b29b77ab2bmr557638985a.23.1762975787508;
        Wed, 12 Nov 2025 11:29:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:29:47 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
Date: Wed, 12 Nov 2025 14:29:16 -0500
Message-ID: <20251112192936.2574429-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a code RFC for discussion related to

"Mempolicy is dead, long live memory policy!"
https://lpc.events/event/19/contributions/2143/

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
(version notes at end)

At LSF 2026, I plan to discuss:
- Why? (In short: shunting to DAX is a failed pattern for users)
- Other designs I considered (mempolicy, cpusets, zone_device)
- Why mempolicy.c and cpusets as-is are insufficient
- SPM types seeking this form of interface (Accelerator, Compression)
- Platform extensions that would be nice to see (SPM-only Bits)

Open Questions
- Single SPM nodemask, or multiple based on features?
- Apply SPM/SysRAM bit on-boot only or at-hotplug?
- Allocate extra "possible" NUMA nodes for flexbility?
- Should SPM Nodes be zone-restricted? (MOVABLE only?)
- How to handle things like reclaim and compaction on these nodes.


With this set, we aim to enable allocation of "special purpose memory"
with the page allocator (mm/page_alloc.c) without exposing the same
memory as "System RAM".  Unless a non-userland component, and does so
with the GFP_SPM_NODE flag, memory on these nodes cannot be allocated.

This isolation mechanism is a requirement for memory policies which
depend on certain sets of memory never being used outside special
interfaces (such as a specific mm/component or driver).

We present an example of using this mechanism within ZSWAP, as-if
a "compressed memory node" was present.  How to describe the features
of memory present on nodes is left up to comment here and at LPC '26.

Userspace-driven allocations are restricted by the sysram_nodes mask,
nothing in userspace can explicitly request memory from SPM nodes.

Instead, the intent is to create new components which understand memory
features and register those nodes with those components. This abstracts
the hardware complexity away from userland while also not requiring new
memory innovations to carry entirely new allocators.

The ZSwap example demonstrates this with the `mt_spm_nodemask`.  This
hack treats all spm nodes as-if they are compressed memory nodes, and
we bypass the software compression logic in zswap in favor of simply
copying memory directly to the allocated page.  In a real design

There are 4 major changes in this set:

1) Introducing mt_sysram_nodelist in mm/memory-tiers.c which denotes
   the set of nodes which are eligible for use as normal system ram

   Some existing users now pass mt_sysram_nodelist into the page
   allocator instead of NULL, but passing a NULL pointer in will simply
   have it replaced by mt_sysram_nodelist anyway.  Should a fully NULL
   pointer still make it to the page allocator, without GFP_SPM_NODE
   SPM node zones will simply be skipped.

   mt_sysram_nodelist is always guaranteed to contain the N_MEMORY nodes
   present during __init, but if empty the use of mt_sysram_nodes()
   will return a NULL to preserve current behavior.


2) The addition of `cpuset.mems.sysram` which restricts allocations to
   `mt_sysram_nodes` unless GFP_SPM_NODE is used.

   SPM Nodes are still allowed in cpuset.mems.allowed and effective.

   This is done to allow separate control over sysram and SPM node sets
   by cgroups while maintaining the existing hierarchical rules.

   current cpuset configuration
   cpuset.mems_allowed
    |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
    |->tasks.mems_allowed    < cpuset.mems_effective

   new cpuset configuration
   cpuset.mems_allowed
    |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
    |.sysram_nodes           < (mems_effective ∩ default_sys_nodemask)
    |->task.sysram_nodes     < cpuset.sysram_nodes

   This means mems_allowed still restricts all node usage in any given
   task context, which is the existing behavior.

3) Addition of MHP_SPM_NODE flag to instruct memory_hotplug.c that the
   capacity being added should mark the node as an SPM Node. 

   A node is either SysRAM or SPM - never both.  Attempting to add
   incompatible memory to a node results in hotplug failure.

   DAX and CXL are made aware of the bit and have `spm_node` bits added
   to their relevant subsystems.

4) Adding GFP_SPM_NODE - which allows page_alloc.c to request memory
   from the provided node or nodemask.  It changes the behavior of
   the cpuset mems_allowed and mt_node_allowed() checks.

v1->v2:
- naming improvements
    default_node -> sysram_node
    protected    -> spm (Specific Purpose Memory)
- add missing constify patch
- add patch to update callers of __cpuset_zone_allowed
- add additional logic to the mm sysram_nodes patch
- fix bot build issues (ifdef config builds)
- fix out-of-tree driver build issues (function renames)
- change compressed_nodelist to spm_nodelist
- add latch mechanism for sysram/spm nodes (Dan Williams)
  this drops some extra memory-hotplug logic which is nice
v1: https://lore.kernel.org/linux-mm/20251107224956.477056-1-gourry@gourry.net/

Gregory Price (11):
  mm: constify oom_control, scan_control, and alloc_context nodemask
  mm: change callers of __cpuset_zone_allowed to cpuset_zone_allowed
  gfp: Add GFP_SPM_NODE for Specific Purpose Memory (SPM) allocations
  memory-tiers: Introduce SysRAM and Specific Purpose Memory Nodes
  mm: restrict slub, oom, compaction, and page_alloc to sysram by
    default
  mm,cpusets: rename task->mems_allowed to task->sysram_nodes
  cpuset: introduce cpuset.mems.sysram
  mm/memory_hotplug: add MHP_SPM_NODE flag
  drivers/dax: add spm_node bit to dev_dax
  drivers/cxl: add spm_node bit to cxl region
  [HACK] mm/zswap: compressed ram integration example

 drivers/cxl/core/region.c       |  30 ++++++
 drivers/cxl/cxl.h               |   2 +
 drivers/dax/bus.c               |  39 ++++++++
 drivers/dax/bus.h               |   1 +
 drivers/dax/cxl.c               |   1 +
 drivers/dax/dax-private.h       |   1 +
 drivers/dax/kmem.c              |   2 +
 fs/proc/array.c                 |   2 +-
 include/linux/cpuset.h          |  62 +++++++------
 include/linux/gfp_types.h       |   5 +
 include/linux/memory-tiers.h    |  47 ++++++++++
 include/linux/memory_hotplug.h  |  10 ++
 include/linux/mempolicy.h       |   2 +-
 include/linux/mm.h              |   4 +-
 include/linux/mmzone.h          |   6 +-
 include/linux/oom.h             |   2 +-
 include/linux/sched.h           |   6 +-
 include/linux/swap.h            |   2 +-
 init/init_task.c                |   2 +-
 kernel/cgroup/cpuset-internal.h |   8 ++
 kernel/cgroup/cpuset-v1.c       |   7 ++
 kernel/cgroup/cpuset.c          | 158 ++++++++++++++++++++------------
 kernel/fork.c                   |   2 +-
 kernel/sched/fair.c             |   4 +-
 mm/compaction.c                 |  10 +-
 mm/hugetlb.c                    |   8 +-
 mm/internal.h                   |   2 +-
 mm/memcontrol.c                 |   3 +-
 mm/memory-tiers.c               |  66 ++++++++++++-
 mm/memory_hotplug.c             |   7 ++
 mm/mempolicy.c                  |  34 +++----
 mm/migrate.c                    |   4 +-
 mm/mmzone.c                     |   5 +-
 mm/oom_kill.c                   |  11 ++-
 mm/page_alloc.c                 |  57 +++++++-----
 mm/show_mem.c                   |  11 ++-
 mm/slub.c                       |  15 ++-
 mm/vmscan.c                     |   6 +-
 mm/zswap.c                      |  66 ++++++++++++-
 39 files changed, 532 insertions(+), 178 deletions(-)

-- 
2.51.1


