Return-Path: <cgroups+bounces-120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E97DBFA9
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DFD1C20AEA
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5220119BB0;
	Mon, 30 Oct 2023 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pg487iIp"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326019BAD
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B8EED;
	Mon, 30 Oct 2023 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690029; x=1730226029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AEQMsn7V1pZDjP5p6/D9jve46YyOOCLObeovwu5yHLE=;
  b=Pg487iIpMgRZGvFFk3Ux7U0plokhVF0oMQEIb6a6rUQQJ0rWHeURIcmZ
   4362ezoGVj31tmA5acj3nh4dlYPD1Z9OKoxZMq8D2gMke1P8O40a7wgCw
   zooXdR1I0nGeZ1ZpeYWytLrGcDxMJ7/IntkbSLaQWMpRqTyvC3O0wrrBQ
   C25ywTooxXMtokUbP6Ao3WzJaIu+cGFmfVbnQ9IBeVkfQ89fDHNpeyiTk
   E+plE4zbBKKIRN+lcXJlUKX76dO+bCketk9yyIKat7QmCEtTnKx/kTOIK
   QN79wPy+vFk6oZbWRPeR/gN+EebuQxhJizN7QPwrLx9EP9PkBqnSzH2q8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479513"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479513"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529492"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529492"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 11:20:27 -0700
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
	sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH v6 00/12] Add Cgroup support for SGX EPC memory
Date: Mon, 30 Oct 2023 11:20:01 -0700
Message-Id: <20231030182013.40086-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SGX Enclave Page Cache (EPC) memory allocations are separate from normal RAM allocations, and
are managed solely by the SGX subsystem. The existing cgroup memory controller cannot be used
to limit or account for SGX EPC memory, which is a desirable feature in some environments,
e.g., support for pod level control in a Kubernates cluster on a VM or baremetal host [1,2].
 
This patchset implements the support for sgx_epc memory within the misc cgroup controller. The
user can use the misc cgroup controller to set and enforce a max limit on total EPC usage per
cgroup. The implementation reports current usage and events of reaching the limit per cgroup as
well as the total system capacity.
 
With the EPC misc controller enabled, every EPC page allocation is accounted for a cgroup's
usage, reflected in the 'sgx_epc' entry in the 'misc.current' interface file of the cgroup.
Much like normal system memory, EPC memory can be overcommitted via virtual memory techniques
and pages can be swapped out of the EPC to their backing store (normal system memory allocated
via shmem, accounted by the memory controller). When the EPC usage of a cgroup reaches its hard
limit ('sgx_epc' entry in the 'misc.max' file), the cgroup starts a reclamation process to swap
out some EPC pages within the same cgroup and its descendant to their backing store. Although
the SGX architecture supports swapping for all pages, to avoid extra complexities, this
implementation does not support swapping for certain page types, e.g.  Version Array(VA) pages,
and treat them as unreclaimable pages.  When the limit is reached but nothing left in the
cgroup for reclamation, i.e., only unreclaimable pages left, any new EPC allocation in the
cgroup will result in an ENOMEM error.

The EPC pages allocated for guest VMs by the virtual EPC driver are not reclaimable by the host
kernel [5]. Therefore they are also treated as unreclaimable from cgroup's point of view.  And
the virtual EPC driver translates an ENOMEM error resulted from an EPC allocation request into
a SIGBUS to the user process.

This work was originally authored by Sean Christopherson a few years ago, and previously
modified by Kristen C. Accardi to utilize the misc cgroup controller rather than a custom
controller. I have been updating the patches based on review comments since V2 [3, 4, 10],
simplified the implementation/design and fixed some stability issues found from testing.
 
The patches are organized as following: 
- Patches 1-3 are prerequisite misc cgroup changes for adding new APIs, structs, resource
  types.
- Patch 4 implements basic misc controller for EPC without reclamation.
- Patches 5-9 prepare for per-cgroup reclamation.
    * Separate out the existing infrastructure of tracking reclaimable pages
      from the global reclaimer(ksgxd) to a newly created LRU list struct.
    * Separate out reusable top-level functions for reclamation.
- Patch 10 adds support for per-cgroup reclamation.
- Patch 11 adds documentation for the EPC cgroup.
- Patch 12 adds test scripts.

I appreciate your review and providing tags if appropriate.

---
V6:
- Dropped OOM killing path, only implement non-preemptive enforcement of max limit (Dave, Michal)
- Simplified reclamation flow by taking out sgx_epc_reclaim_control, forced reclamation by
  ignoring 'age".
- Restructured patches: split misc API + resource types patch and the big EPC cgroup patch
  (Kai, Michal)
- Dropped some Tested-by/Reviewed-by tags due to significant changes
- Added more selftests

v5:
- Replace the manual test script with a selftest script.
- Restore the "From" tag for some patches to Sean (Kai)
- Style fixes (Jarkko)

v4:
- Collected "Tested-by" from Mikko. I kept it for now as no functional changes in v4.
- Rebased on to v6.6_rc1 and reordered patches as described above.
- Separated out the bug fixes [7,8,9]. This series depend on those patches. (Dave, Jarkko)
- Added comments in commit message to give more preview what's to come next. (Jarkko)
- Fixed some documentation error, gap, style (Mikko, Randy)
- Fixed some comments, typo, style in code (Mikko, Kai)
- Patch format and background for reclaimable vs unreclaimable (Kai, Jarkko)
- Fixed typo (Pavel)
- Exclude the previous fixes/enhancements for self-tests. Patch 18 now depends on series [6]
- Use the same to list for cover and all patches. (Solo)
 
v3:
 
- Added EPC states to replace flags in sgx_epc_page struct. (Jarkko)
- Unrolled wrappers for cond_resched, list (Dave)
- Separate patches for adding reclaimable and unreclaimable lists. (Dave)
- Other improvements on patch flow, commit messages, styles. (Dave, Jarkko)
- Simplified the cgroup tree walking with plain
  css_for_each_descendant_pre.
- Fixed race conditions and crashes.
- OOM killer to wait for the victim enclave pages being reclaimed.
- Unblock the user by handling misc_max_write callback asynchronously.
- Rebased onto 6.4 and no longer base this series on the MCA patchset.
- Fix an overflow in misc_try_charge.
- Fix a NULL pointer in SGX PF handler.
- Updated and included the SGX selftest patches previously reviewed. Those
  patches fix issues triggered in high EPC pressure required for cgroup
  testing.
- Added test scripts to help setup and test SGX EPC cgroups.
 
[1]https://lore.kernel.org/all/DM6PR21MB11772A6ED915825854B419D6C4989@DM6PR21MB1177.namprd21.prod.outlook.com/
[2]https://lore.kernel.org/all/ZD7Iutppjj+muH4p@himmelriiki/
[3]https://lore.kernel.org/all/20221202183655.3767674-1-kristen@linux.intel.com/
[4]https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@linux.intel.com/
[5]Documentation/arch/x86/sgx.rst, Section "Virtual EPC"
[6]https://lore.kernel.org/linux-sgx/20220905020411.17290-1-jarkko@kernel.org/
[7]https://lore.kernel.org/linux-sgx/ZLcXmvDKheCRYOjG@slm.duckdns.org/
[8]https://lore.kernel.org/linux-sgx/20230721120231.13916-1-haitao.huang@linux.intel.com/
[9]https://lore.kernel.org/linux-sgx/20230728051024.33063-1-haitao.huang@linux.intel.com/
[10]https://lore.kernel.org/all/20230923030657.16148-1-haitao.huang@linux.intel.com/

Haitao Huang (2):
  x86/sgx: Introduce EPC page states
  selftests/sgx: Add scripts for EPC cgroup testing

Kristen Carlson Accardi (5):
  cgroup/misc: Add per resource callbacks for CSS events
  cgroup/misc: Export APIs for SGX driver
  cgroup/misc: Add SGX EPC resource type
  x86/sgx: Implement basic EPC misc cgroup functionality
  x86/sgx: Implement EPC reclamation for cgroup

Sean Christopherson (5):
  x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
  x86/sgx: Use sgx_epc_lru_list for existing active page list
  x86/sgx: Use a list to track to-be-reclaimed pages
  x86/sgx: Restructure top-level EPC reclaim function
  Docs/x86/sgx: Add description for cgroup support

 Documentation/arch/x86/sgx.rst                |  74 ++++
 arch/x86/Kconfig                              |  13 +
 arch/x86/kernel/cpu/sgx/Makefile              |   1 +
 arch/x86/kernel/cpu/sgx/encl.c                |   2 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.c          | 319 ++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h          |  49 +++
 arch/x86/kernel/cpu/sgx/main.c                | 245 +++++++++-----
 arch/x86/kernel/cpu/sgx/sgx.h                 |  88 ++++-
 include/linux/misc_cgroup.h                   |  42 +++
 kernel/cgroup/misc.c                          |  52 ++-
 .../selftests/sgx/run_epc_cg_selftests.sh     | 196 +++++++++++
 .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
 12 files changed, 996 insertions(+), 98 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
 create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
 create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh

-- 
2.25.1


