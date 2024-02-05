Return-Path: <cgroups+bounces-1351-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0C84A852
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986381C2836D
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60E1419A8;
	Mon,  5 Feb 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E46GVl05"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BC13AA5F;
	Mon,  5 Feb 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167202; cv=none; b=ObZTOF6Fw++ORkkIkW0ERwArCg4MNN2jVOyH1YyI3ICOLneTKB0nE0djkxPxau798WANC5Fv79tkG3xMr4VZ0aRgx5l3W+ycuwea0utYK1Px3s/WROgLDHl0Ahvd703Cz2493Y5NcrO8jB2PguVqUX5rYvZx70duI/tBhVFsjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167202; c=relaxed/simple;
	bh=p1bFo0xK89nQjqnH1rMOHQBbmKLLaiZTbWK9KYNNUE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kYqC4RFg+D5sZzHV2hkBdgoKh6WgeegJ7fuWFBbHg1iTcvVcWjrDd/m6QkJjv94GQFpT1lWpG9GYD4V6ujuEPgnltgGdOdw6mUoDPfwpqjWvMx6wmfPZniDKB0pHl8JPUPfAAxyU2u84ZfIh2Ksk75BKX+A5DpqJU+ZJJXBaI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E46GVl05; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167201; x=1738703201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p1bFo0xK89nQjqnH1rMOHQBbmKLLaiZTbWK9KYNNUE0=;
  b=E46GVl05Ctc5IUtpoVj23OLO7c2cK0A30IjTLOFBfbVL/JnEK49Kyz57
   98dSy7zO56DhSleG+lGE/05/JnOTQXRbRYWjpXAnsjcgJxie1v27Ecqkl
   ceYUlcNQPIiHmBcbsyd1596xiIOOeB0l5rhG3Y1wvv50alCLsZqGzm+GZ
   FlhqQlbNdyMoSqSpZEcB6wZe1/E8NigvGZ86Uwqi/nxqrCaYUxFHfjaAz
   VJgcEFgNwhGEMyVgTiFgyr0EDX5aJhY4hnqBLHYAM8oXA2xxgqwuUT6O8
   EwtI3tAhcNzKUv7zyjjvlBQMUc2R8v3mHURTPUGdv9/IiRvs3Bn23f3TC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960352"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960352"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245602"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:38 -0800
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v9 00/15] Add Cgroup support for SGX EPC memory
Date: Mon,  5 Feb 2024 13:06:23 -0800
Message-Id: <20240205210638.157741-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SGX Enclave Page Cache (EPC) memory allocations are separate from normal
RAM allocations, and are managed solely by the SGX subsystem. The existing
cgroup memory controller cannot be used to limit or account for SGX EPC
memory, which is a desirable feature in some environments, e.g., support
for pod level control in a Kubernates cluster on a VM or bare-metal host
[1,2].
 
This patchset implements the support for sgx_epc memory within the misc
cgroup controller. A user can use the misc cgroup controller to set and
enforce a max limit on total EPC usage per cgroup. The implementation
reports current usage and events of reaching the limit per cgroup as well
as the total system capacity.
 
Much like normal system memory, EPC memory can be overcommitted via virtual
memory techniques and pages can be swapped out of the EPC to their backing
store, which are normal system memory allocated via shmem and accounted by
the memory controller. Similar to per-cgroup reclamation done by the memory
controller, the EPC misc controller needs to implement a per-cgroup EPC
reclaiming process: when the EPC usage of a cgroup reaches its hard limit
('sgx_epc' entry in the 'misc.max' file), the cgroup starts swapping out
some EPC pages within the same cgroup to make room for new allocations.

For that, this implementation tracks reclaimable EPC pages in a separate
LRU list in each cgroup, and below are more details and justification of
this design. 

Track EPC pages in per-cgroup LRUs (from Dave)
----------------------------------------------

tl;dr: A cgroup hitting its limit should be as similar as possible to the
system running out of EPC memory. The only two choices to implement that
are nasty changes the existing LRU scanning algorithm, or to add new LRUs.
The result: Add a new LRU for each cgroup and scans those instead. Replace
the existing global cgroup with the root cgroup's LRU (only when this new
support is compiled in, obviously).

The existing EPC memory management aims to be a miniature version of the
core VM where EPC memory can be overcommitted and reclaimed. EPC
allocations can wait for reclaim. The alternative to waiting would have
been to send a signal and let the enclave die.
 
This series attempts to implement that same logic for cgroups, for the same
reasons: it's preferable to wait for memory to become available and let
reclaim happen than to do things that are fatal to enclaves.
 
There is currently a global reclaimable page SGX LRU list. That list (and
the existing scanning algorithm) is essentially useless for doing reclaim
when a cgroup hits its limit because the cgroup's pages are scattered
around that LRU. It is unspeakably inefficient to scan a linked list with
millions of entries for what could be dozens of pages from a cgroup that
needs reclaim.
 
Even if unspeakably slow reclaim was accepted, the existing scanning
algorithm only picks a few pages off the head of the global LRU. It would
either need to hold the list locks for unreasonable amounts of time, or be
taught to scan the list in pieces, which has its own challenges.
 
Unreclaimable Enclave Pages
---------------------------

There are a variety of page types for enclaves, each serving different
purposes [5]. Although the SGX architecture supports swapping for all
types, some special pages, e.g., Version Array(VA) and Secure Enclave
Control Structure (SECS)[5], holds meta data of reclaimed pages and
enclaves. That makes reclamation of such pages more intricate to manage.
The SGX driver global reclaimer currently does not swap out VA pages. It
only swaps the SECS page of an enclave when all other associated pages have
been swapped out. The cgroup reclaimer follows the same approach and does
not track those in per-cgroup LRUs and considers them as unreclaimable
pages. The allocation of these pages is counted towards the usage of a
specific cgroup and is subject to the cgroup's set EPC limits.

Earlier versions of this series implemented forced enclave-killing to
reclaim VA and SECS pages. That was designed to enforce the 'max' limit,
particularly in scenarios where a user or administrator reduces this limit
post-launch of enclaves. However, subsequent discussions [3, 4] indicated
that such preemptive enforcement is not necessary for the misc-controllers.
Therefore, reclaiming SECS/VA pages by force-killing enclaves were removed,
and the limit is only enforced at the time of new EPC allocation request.
When a cgroup hits its limit but nothing left in the LRUs of the subtree,
i.e., nothing to reclaim in the cgroup, any new attempt to allocate EPC
within that cgroup will result in an 'ENOMEM'.

Unreclaimable Guest VM EPC Pages
--------------------------------

The EPC pages allocated for guest VMs by the virtual EPC driver are not
reclaimable by the host kernel [6]. Therefore an EPC cgroup also treats
those as unreclaimable and returns ENOMEM when its limit is hit and nothing
reclaimable left within the cgroup. The virtual EPC driver translates the
ENOMEM error resulted from an EPC allocation request into a SIGBUS to the
user process exactly the same way handling host running out of physical
EPC.
 
This work was originally authored by Sean Christopherson a few years ago,
and previously modified by Kristen C. Accardi to utilize the misc cgroup
controller rather than a custom controller. I have been updating the
patches based on review comments since V2 [7-13], simplified the
implementation/design, added selftest scripts, fixed some stability issues
found from testing.

Thanks to all for the review/test/tags/feedback provided on the previous
versions. 

I appreciate your further reviewing/testing and providing tags if
appropriate.

---
V9:
- Add comments for static variables outside functions. (Jarkko)
- Remove unnecessary ifs. (Tim)
- Add more Reviewed-By: tags from Jarkko and TJ.

V8:
- Style fixes. (Jarkko)
- Abstract _misc_res_free/alloc() (Jarkko)
- Remove unneeded NULL checks. (Jarkko)

V7:
- Split the large patch for the final EPC implementation, #10 in V6, into
  smaller ones. (Dave, Kai)
- Scan and reclaim one cgroup at a time, don't split sgx_reclaim_pages()
  into two functions (Kai)
- Removed patches to introduce the EPC page states, list for storing
  candidate pages for reclamation. (not needed due to above changes)
- Make ops one per resource type and store them in array (Michal)
- Rename the ops struct to misc_res_ops, and enforce the constraints of
  required callback functions (Jarkko)
- Initialize epc cgroup in sgx driver init function. (Kai)
- Moved addition of priv field to patch 4 where it was used first. (Jarkko)
- Split sgx_get_current_epc_cg() out of sgx_epc_cg_try_charge() (Kai)
- Use a static for root cgroup (Kai)
 
[1]https://lore.kernel.org/all/DM6PR21MB11772A6ED915825854B419D6C4989@DM6PR21MB1177.namprd21.prod.outlook.com/
[2]https://lore.kernel.org/all/ZD7Iutppjj+muH4p@himmelriiki/
[3]https://lore.kernel.org/lkml/7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com/
[4]https://lore.kernel.org/lkml/yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3/
[5]Documentation/arch/x86/sgx.rst, Section"Enclave Page Types"
[6]Documentation/arch/x86/sgx.rst, Section "Virtual EPC"
[7]v2: https://lore.kernel.org/all/20221202183655.3767674-1-kristen@linux.intel.com/
[8]v3: https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@linux.intel.com/
[9]v4: https://lore.kernel.org/all/20230913040635.28815-1-haitao.huang@linux.intel.com/
[10]v5: https://lore.kernel.org/all/20230923030657.16148-1-haitao.huang@linux.intel.com/
[11]v6: https://lore.kernel.org/linux-sgx/20231030182013.40086-1-haitao.huang@linux.intel.com/
[12]v7: https://lore.kernel.org/linux-sgx/20240122172048.11953-1-haitao.huang@linux.intel.com/T/#t
[13]v8: https://lore.kernel.org/linux-sgx/20240130020938.10025-1-haitao.huang@linux.intel.com/T/#t

Haitao Huang (2):
  x86/sgx: Charge mem_cgroup for per-cgroup reclamation
  selftests/sgx: Add scripts for EPC cgroup testing

Kristen Carlson Accardi (10):
  cgroup/misc: Add per resource callbacks for CSS events
  cgroup/misc: Export APIs for SGX driver
  cgroup/misc: Add SGX EPC resource type
  x86/sgx: Implement basic EPC misc cgroup functionality
  x86/sgx: Abstract tracking reclaimable pages in LRU
  x86/sgx: Implement EPC reclamation flows for cgroup
  x86/sgx: Add EPC reclamation in cgroup try_charge()
  x86/sgx: Abstract check for global reclaimable pages
  x86/sgx: Expose sgx_epc_cgroup_reclaim_pages() for global reclaimer
  x86/sgx: Turn on per-cgroup EPC reclamation

Sean Christopherson (3):
  x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
  x86/sgx: Expose sgx_reclaim_pages() for cgroup
  Docs/x86/sgx: Add description for cgroup support

 Documentation/arch/x86/sgx.rst                |  83 ++++++
 arch/x86/Kconfig                              |  13 +
 arch/x86/kernel/cpu/sgx/Makefile              |   1 +
 arch/x86/kernel/cpu/sgx/encl.c                |  38 ++-
 arch/x86/kernel/cpu/sgx/encl.h                |   3 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.c          | 276 ++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h          |  83 ++++++
 arch/x86/kernel/cpu/sgx/main.c                | 180 +++++++++---
 arch/x86/kernel/cpu/sgx/sgx.h                 |  22 ++
 include/linux/misc_cgroup.h                   |  41 +++
 kernel/cgroup/misc.c                          | 109 +++++--
 .../selftests/sgx/run_epc_cg_selftests.sh     | 246 ++++++++++++++++
 .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
 13 files changed, 1019 insertions(+), 89 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh


base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
-- 
2.25.1


