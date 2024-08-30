Return-Path: <cgroups+bounces-4626-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A2966716
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C21F246C0
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223B1B5313;
	Fri, 30 Aug 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Upyr58HU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F3135417;
	Fri, 30 Aug 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036093; cv=none; b=VUri91y0kSXcQNmbXKrb0/8gAjQq2YlRGMWRKcFubMR1ebw2u5Obc6ElrkL7BokiBo2Rs7HFK9UaLPsBjQHxzlcERceyAM+5k+T0bep1fSLS4mT2wCcgHwRtMvBqbpSRXofntNz39QR/wTqhwtYefuTe/cqCQtU9n+d/ZkLZeko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036093; c=relaxed/simple;
	bh=AIo4R2GP2P0XUL7HDqEOPjKmWqQArvwibNr28SfrZHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgtIwwQnUrzwGVV8a3Rs7swT37uUF8w8wTzj5hwxN472x5XdOxstAMIpPV3RM/jFnhEENqBpxzBc5MSc+hMeTjx1hYkwDVpfRr1J3G2BE3VlGi2f6P2Xij4q6LdtHIUUL5FLoVRWS9fxMYONT8QFFVqXqAfeMOtBdFMu2upYbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Upyr58HU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036090; x=1756572090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AIo4R2GP2P0XUL7HDqEOPjKmWqQArvwibNr28SfrZHM=;
  b=Upyr58HUnkbKVQL72zFDsEACE0c1+FRLBB9TmwL5Ckj3R0MD4wqvBzJZ
   kKg5pntciPKmRvPQHQsmXtPd5EFjq/cp7xDlItNZaxykZbgpKKoBxjy4e
   97LIDKC4CwojJosyMRXwYFnzBUZyCPZxp/5LZOf83LAC6l2+wo87Tqkbc
   uWeYVm8my1hGQbGhAnow+QCcDfou4FJ3o4B8sWJBlWnL2yDxlcL89K854
   QFGrKLaf15Y84B/uYuGGdPP9388cbnUy+f6V/nNVK9qBJ9sE9W/N7OPIK
   8xxGU2HqjkF0sKhcT6kro5qShReMExJHWAvGYs4qe6VzOu3+AhftBrk9x
   Q==;
X-CSE-ConnectionGUID: XOMoBet/R/CDr/3gQv6T6g==
X-CSE-MsgGUID: Pkd6XB+PQUCxnI4O1gHLeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34299895"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34299895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:51 -0700
X-CSE-ConnectionGUID: xqkTEulFRuWAZRL2tZiEbA==
X-CSE-MsgGUID: NJUEnCsyQ4GjIxZXiyVi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440447"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:51 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
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
Subject: [PATCH v17 00/16]  Add Cgroup support for SGX EPC memory
Date: Fri, 30 Aug 2024 09:40:21 -0700
Message-ID: <20240830164038.39343-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
patches based on review comments since V2 [7-21], simplified the
implementation/design, added selftest scripts, fixed some stability issues
found from testing.
 
Thanks to all for the review/test/tags/feedback provided on the previous
versions. 
 
I appreciate your further reviewing/testing and providing tags if
appropriate.
 
---
V17:
- Remove unneeded EXPORT_SYMBOL_GPLs and @parent_cg in changes to misc.c (Kai)
- Use READ_ONCE()/WRITE_ONCE() for ops to be consistent with existing
  code in misc.c
- Fix W=1 warnings for '/**'.
- Rename sgx_cgroup_register() -> sgx_cgroup_init(), and move the
  sgx_cgroup_misc_init() call to it. Rename
  sgx_cgroup_{init,deinit}()->sgx_cgroup_wq_{init,deinit}() and make them
  only do wq related init and rollback. (Kai) 
- Move comments in sgx_can_reclaim_global() to patch "x86/sgx: Revise
  global reclamation for EPC cgroups"  (Kai)
- Remove inaccurate sentences in commit  "x86/sgx: Revise global
  reclamation for EPC cgroups" and move it right in front of patch
  "x86/sgx: Turn on per-cgroup EPC reclamation" (Kai)
- Fix error in initializing 'next' in sgx_cgroup_next_descendant_pre()
- Fix some grammar issue and capitalization in comments and change log.
  (Kai)

V16:
- Revised the per-cgroup reclamation basic flow
  sgx_cgroup_reclaim_pages(): add next_cg field in each cgroup to track
  the next descendant to scan, and create a synchronized iterator to more
  fairly scan all descendants if needed for reclamation. (Kai)
- Separate patches to abstract the uses of global LRU, sgx_cgroup_reclaim_direct(),
  sgx_cgroup_reclaim_global() implementaions. (Kai)
- MISC don't call the ops if capacity is zero. (Kai)
- Commit message improvements, clarified requirements for per-cgroup
  reclamation. (Kai)
- Fix bugs in handling failures during init.
- Only turn on callbacks and set capacity at the end of sgx_init()

V15:
- Disable SGX when sgx_cgroup_init() fails instead of using BUG_ON()
  (Jarkko)
- Reset capacity if sgx_cgroup_init() fails. (Kai)
- Style fixes (Jarkko, Kai)
- In misc.c, only invoke the ->free() callbacks for resource types whose
  ->alloc() callback  was called and returned success. (Ridong)

V14:
- modified sgx_cgroup_reclaim_pages() to return the next node. Caller can use it as the new
  starting node for next round of reclamation attempt if needed. This is to fix a corner case
where a super busy top level cgroup may block reclamation in lower level cgroups. (Kai)
- Move renaming of sgx_should_reclaim_global() to the patch 'x86/sgx: Add basic EPC reclamation
flow for cgroup'. (Kai)

v13:
- Only allocate workqueue for SGX cgroup when misc is enabled and BUG_ON() when allocation fails
- Add more tags
- Commit logs and style improvements (Kai)
- Test script improvements (Jarkko)
 
V12:
- Integrate test scripts to kselftests "run_tests" target. (Jarkko)
- Remove CGROUP_SGX_EPC kconfig, conditionally compile with CGROUP_MISC enabled. (Jarkko)
- Explain why taking 'struct misc_cg *cg' as parameter, but not 'struct misc_res *res' in the
  changelog for patch #2. (Kai)
- Remove "unlikely" in patch #2 (Kai)
  
V11:
- Update copyright years and use c style (Kai)
- Improve and simplify test scripts: remove cgroup-tools and bash dependency, drop cgroup v1.
  (Jarkko, Michal)
- Add more stub/wrapper functions to minimize #ifdefs in c file. (Kai)
- Revise commit message for patch #8 to clarify design rational (Kai)
- Print error instead of WARN for init failure. (Kai)
- Add check for need to queue an async reclamation before returning from
  sgx_cgroup_try_charge(), do so if needed.

V10:
- Use enum instead of boolean for the 'reclaim' parameters in
  sgx_alloc_epc_page(). (Dave, Jarkko)
- Pass mm struct instead of a boolean 'indirect'. (Dave, Jarkko)
- Add comments/macros to clarify the cgroup async reclaimer design. (Kai)
- Simplify sgx_reclaim_pages() signature, removing a pointer passed in.
  (Kai)
- Clarify design of sgx_cgroup_reclaim_pages(). (Kai)
	- Does not return a value for callers to check.
	- Its usage pattern is similar to that of sgx_reclaim_pages() now
- Add cond_resched() in the loop in the cgroup reclaimer to improve
  liveliness.
- Add logic for cgroup level reclamation in sgx_reclaim_direct()
- Restructure V9 patches 7-10 to make them flow better. (Kai)
- Disable cgroup if workqueue allocation failed during init. (Kai)
- Shorten names for EPC cgroup functions, structures and variables.
  (Jarkko)
- Separate out a helper for for addressing single iteration of the loop in
  sgx_cgroup_try_charge(). (Jarkko)
- More cleanup/clarifying/comments/style fixes. (Kai, Jarkko)  
 
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
[14]v9: https://lore.kernel.org/lkml/20240205210638.157741-1-haitao.huang@linux.intel.com/T/
[15]v10: https://lore.kernel.org/linux-sgx/20240328002229.30264-1-haitao.huang@linux.intel.com/T/#t
[16]v11: https://lore.kernel.org/lkml/20240410182558.41467-1-haitao.huang@linux.intel.com/
[17]v12: https://lore.kernel.org/lkml/20240416032011.58578-1-haitao.huang@linux.intel.com/
[18]v13: https://lore.kernel.org/lkml/20240430195108.5676-1-haitao.huang@linux.intel.com/ 
[19]v14: https://lore.kernel.org/linux-sgx/20240531222630.4634-1-haitao.huang@linux.intel.com/T/#t
[20]v15: https://lore.kernel.org/linux-sgx/20240617125321.36658-1-haitao.huang@linux.intel.com/T/#t
[21]v16: https://lore.kernel.org/lkml/20240821015404.6038-1-haitao.huang@linux.intel.com/T/#t

Haitao Huang (7):
  x86/sgx: Replace boolean parameters with enums
  x86/sgx: Encapsulate uses of the global LRU
  x86/sgx: Add basic EPC reclamation flow for cgroup
  x86/sgx: Charge mem_cgroup for per-cgroup reclamation
  x86/sgx: Implement direct reclamation for cgroups
  x86/sgx: Revise global reclamation for EPC cgroups
  selftests/sgx: Add scripts for EPC cgroup testing

Kristen Carlson Accardi (7):
  cgroup/misc: Add per resource callbacks for CSS events
  cgroup/misc: Expose APIs for SGX driver
  cgroup/misc: Add SGX EPC resource type
  x86/sgx: Implement basic EPC misc cgroup functionality
  x86/sgx: Abstract tracking reclaimable pages in LRU
  x86/sgx: Implement async reclamation for cgroup
  x86/sgx: Turn on per-cgroup EPC reclamation

Sean Christopherson (2):
  x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
  Docs/x86/sgx: Add description for cgroup support

 Documentation/arch/x86/sgx.rst                |  83 ++++
 arch/x86/kernel/cpu/sgx/Makefile              |   1 +
 arch/x86/kernel/cpu/sgx/encl.c                |  41 +-
 arch/x86/kernel/cpu/sgx/encl.h                |   7 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.c          | 441 ++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h          | 106 +++++
 arch/x86/kernel/cpu/sgx/ioctl.c               |  10 +-
 arch/x86/kernel/cpu/sgx/main.c                | 220 ++++++---
 arch/x86/kernel/cpu/sgx/sgx.h                 |  54 ++-
 arch/x86/kernel/cpu/sgx/virt.c                |   2 +-
 include/linux/misc_cgroup.h                   |  41 ++
 kernel/cgroup/misc.c                          | 112 ++++-
 tools/testing/selftests/sgx/Makefile          |   3 +-
 tools/testing/selftests/sgx/README            | 109 +++++
 tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
 tools/testing/selftests/sgx/config            |   4 +
 .../selftests/sgx/run_epc_cg_selftests.sh     | 294 ++++++++++++
 tools/testing/selftests/sgx/settings          |   2 +
 .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
 19 files changed, 1446 insertions(+), 111 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
 create mode 100644 tools/testing/selftests/sgx/README
 create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
 create mode 100644 tools/testing/selftests/sgx/config
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100644 tools/testing/selftests/sgx/settings
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh


base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
-- 
2.43.0


