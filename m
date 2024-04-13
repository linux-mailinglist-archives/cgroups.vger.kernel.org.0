Return-Path: <cgroups+bounces-2470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA88A3B56
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67623B216CF
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D411CA80;
	Sat, 13 Apr 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXWtLP11"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48418633;
	Sat, 13 Apr 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990923; cv=none; b=avyoxOHLSipoSS3vUz/ZLOAh/BiD9mZvsZr3OXIgt6PvQVCUXudblfo9S1e+GLDLSGfQyhmXoAbe3bVWv4l2zTCq+gt00dLNBUXxmT5CFlI6doLUy6eyuymxRaJYdfiVNRwwamoVmBC8/mUOPEufRBRhH5LCBenv7VkXT7LEOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990923; c=relaxed/simple;
	bh=8p7Q6NkdDEDJPGfS0Oe6z2PjmqzZQLw7pZe2B+ktKbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrzOGL/MhmdRibvjbgaM7UK0iRX0NfoHJwkCdOEH1kTBiqqQZW9/WDxngB/X/GI7gsGMt0qKAKrqbdF5Lk5mmKTkr1yZYDFtUyiivY5l6d3k7nM/3LupDiYYZE1ZoZFsmI616dbEC5hxBptXacKVW3Q4T9sSVlRrdlNeybEcTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXWtLP11; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712990921; x=1744526921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8p7Q6NkdDEDJPGfS0Oe6z2PjmqzZQLw7pZe2B+ktKbk=;
  b=EXWtLP11F8K4cCtHX6FHC46bbk4P5HuWwLt6KTKUomvA9Xx8D6iHuXXs
   n127v7j/FuDxoSqCBr7MRtPo/E+vmZa5P15hZsM+5sq5g5iHADhHK9F1+
   MtHgSOQn9kJ2mzahjZ7NMRVKaSVT3dozyEXkMyXEQv9yoY9d5nyPaWLTl
   MguQ5S9FqQ7MnSVlPPKnYT/JgtOR9ERscXg76z8nn0mw7QPGt8ONbdRPk
   FpUDwXl4iy4IDiBsHN7c1VMrE7fE+c/nSXVsSFBsgh33w1PryUiZryAzB
   CB06LiezNQlqlSIXq/duTN1jZgqh4aF3PSXk/i9hy6hw8K9vm+jM0HODI
   A==;
X-CSE-ConnectionGUID: nKJpcguZR3+88nu5SFiNQg==
X-CSE-MsgGUID: EZRxC+G2QKaA99T8LlpzjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8294047"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="8294047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 23:48:41 -0700
X-CSE-ConnectionGUID: GT+anLpJS4e5NjJnU888Hw==
X-CSE-MsgGUID: pNa2vxXFT1aGB3S8asOI5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="21860102"
Received: from dgorle-mobl2.ger.corp.intel.com (HELO himmelriiki) ([10.252.42.208])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 23:48:34 -0700
Date: Sat, 13 Apr 2024 09:48:25 +0300
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: jarkko@kernel.org, dave.hansen@linux.intel.com, kai.huang@intel.com,
	tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	sohil.mehta@intel.com, tim.c.chen@linux.intel.com,
	zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
	zhanb@microsoft.com, anakrish@microsoft.com, yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: Re: [PATCH v11 00/14] Add Cgroup support for SGX EPC memory
Message-ID: <ZhoquVLeqFs9zEpQ@himmelriiki>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410182558.41467-1-haitao.huang@linux.intel.com>

On Wed, Apr 10, 2024 at 11:25:44AM -0700, Haitao Huang wrote:
> SGX Enclave Page Cache (EPC) memory allocations are separate from normal
> RAM allocations, and are managed solely by the SGX subsystem. The existing
> cgroup memory controller cannot be used to limit or account for SGX EPC
> memory, which is a desirable feature in some environments, e.g., support
> for pod level control in a Kubernates cluster on a VM or bare-metal host
> [1,2].
>  
> This patchset implements the support for sgx_epc memory within the misc
> cgroup controller. A user can use the misc cgroup controller to set and
> enforce a max limit on total EPC usage per cgroup. The implementation
> reports current usage and events of reaching the limit per cgroup as well
> as the total system capacity.
>  
> Much like normal system memory, EPC memory can be overcommitted via virtual
> memory techniques and pages can be swapped out of the EPC to their backing
> store, which are normal system memory allocated via shmem and accounted by
> the memory controller. Similar to per-cgroup reclamation done by the memory
> controller, the EPC misc controller needs to implement a per-cgroup EPC
> reclaiming process: when the EPC usage of a cgroup reaches its hard limit
> ('sgx_epc' entry in the 'misc.max' file), the cgroup starts swapping out
> some EPC pages within the same cgroup to make room for new allocations.
>  
> For that, this implementation tracks reclaimable EPC pages in a separate
> LRU list in each cgroup, and below are more details and justification of
> this design. 
>  
> Track EPC pages in per-cgroup LRUs (from Dave)
> ----------------------------------------------
>  
> tl;dr: A cgroup hitting its limit should be as similar as possible to the
> system running out of EPC memory. The only two choices to implement that
> are nasty changes the existing LRU scanning algorithm, or to add new LRUs.
> The result: Add a new LRU for each cgroup and scans those instead. Replace
> the existing global cgroup with the root cgroup's LRU (only when this new
> support is compiled in, obviously).
>  
> The existing EPC memory management aims to be a miniature version of the
> core VM where EPC memory can be overcommitted and reclaimed. EPC
> allocations can wait for reclaim. The alternative to waiting would have
> been to send a signal and let the enclave die.
>  
> This series attempts to implement that same logic for cgroups, for the same
> reasons: it's preferable to wait for memory to become available and let
> reclaim happen than to do things that are fatal to enclaves.
>  
> There is currently a global reclaimable page SGX LRU list. That list (and
> the existing scanning algorithm) is essentially useless for doing reclaim
> when a cgroup hits its limit because the cgroup's pages are scattered
> around that LRU. It is unspeakably inefficient to scan a linked list with
> millions of entries for what could be dozens of pages from a cgroup that
> needs reclaim.
>  
> Even if unspeakably slow reclaim was accepted, the existing scanning
> algorithm only picks a few pages off the head of the global LRU. It would
> either need to hold the list locks for unreasonable amounts of time, or be
> taught to scan the list in pieces, which has its own challenges.
>  
> Unreclaimable Enclave Pages
> ---------------------------
>  
> There are a variety of page types for enclaves, each serving different
> purposes [5]. Although the SGX architecture supports swapping for all
> types, some special pages, e.g., Version Array(VA) and Secure Enclave
> Control Structure (SECS)[5], holds meta data of reclaimed pages and
> enclaves. That makes reclamation of such pages more intricate to manage.
> The SGX driver global reclaimer currently does not swap out VA pages. It
> only swaps the SECS page of an enclave when all other associated pages have
> been swapped out. The cgroup reclaimer follows the same approach and does
> not track those in per-cgroup LRUs and considers them as unreclaimable
> pages. The allocation of these pages is counted towards the usage of a
> specific cgroup and is subject to the cgroup's set EPC limits.
>  
> Earlier versions of this series implemented forced enclave-killing to
> reclaim VA and SECS pages. That was designed to enforce the 'max' limit,
> particularly in scenarios where a user or administrator reduces this limit
> post-launch of enclaves. However, subsequent discussions [3, 4] indicated
> that such preemptive enforcement is not necessary for the misc-controllers.
> Therefore, reclaiming SECS/VA pages by force-killing enclaves were removed,
> and the limit is only enforced at the time of new EPC allocation request.
> When a cgroup hits its limit but nothing left in the LRUs of the subtree,
> i.e., nothing to reclaim in the cgroup, any new attempt to allocate EPC
> within that cgroup will result in an 'ENOMEM'.
>  
> Unreclaimable Guest VM EPC Pages
> --------------------------------
>  
> The EPC pages allocated for guest VMs by the virtual EPC driver are not
> reclaimable by the host kernel [6]. Therefore an EPC cgroup also treats
> those as unreclaimable and returns ENOMEM when its limit is hit and nothing
> reclaimable left within the cgroup. The virtual EPC driver translates the
> ENOMEM error resulted from an EPC allocation request into a SIGBUS to the
> user process exactly the same way handling host running out of physical
> EPC.
>  
> This work was originally authored by Sean Christopherson a few years ago,
> and previously modified by Kristen C. Accardi to utilize the misc cgroup
> controller rather than a custom controller. I have been updating the
> patches based on review comments since V2 [7-15], simplified the
> implementation/design, added selftest scripts, fixed some stability issues
> found from testing.
>  
> Thanks to all for the review/test/tags/feedback provided on the previous
> versions. 
>  
> I appreciate your further reviewing/testing and providing tags if
> appropriate.

I've continued to use/test this series in one of its main target
environments: running "misc.max spc_epc" limited containers in a
Kubernetes cluster. Everything is working as expected when using
a test suite built for that env (similar tests what Haitao has here)
running Gramine-SGX "stress" containers.

Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>

>  
> ---
> V11:
> - Update copyright years and use c style (Kai)
> - Improve and simplify test scripts: remove cgroup-tools and bash dependency, drop cgroup v1.
>   (Jarkko, Michal)
> - Add more stub/wrapper functions to minimize #ifdefs in c file. (Kai)
> - Revise commit message for patch #8 to clarify design rational (Kai)
> - Print error instead of WARN for init failure. (Kai)
> - Add check for need to queue an async reclamation before returning from
>   sgx_cgroup_try_charge(), do so if needed.
> 
> V10:
> - Use enum instead of boolean for the 'reclaim' parameters in
>   sgx_alloc_epc_page(). (Dave, Jarkko)
> - Pass mm struct instead of a boolean 'indirect'. (Dave, Jarkko)
> - Add comments/macros to clarify the cgroup async reclaimer design. (Kai)
> - Simplify sgx_reclaim_pages() signature, removing a pointer passed in.
>   (Kai)
> - Clarify design of sgx_cgroup_reclaim_pages(). (Kai)
> 	- Does not return a value for callers to check.
> 	- Its usage pattern is similar to that of sgx_reclaim_pages() now
> - Add cond_resched() in the loop in the cgroup reclaimer to improve
>   liveliness.
> - Add logic for cgroup level reclamation in sgx_reclaim_direct()
> - Restructure V9 patches 7-10 to make them flow better. (Kai)
> - Disable cgroup if workqueue allocation failed during init. (Kai)
> - Shorten names for EPC cgroup functions, structures and variables.
>   (Jarkko)
> - Separate out a helper for for addressing single iteration of the loop in
>   sgx_cgroup_try_charge(). (Jarkko)
> - More cleanup/clarifying/comments/style fixes. (Kai, Jarkko)  
>  
> V9:
> - Add comments for static variables outside functions. (Jarkko)
> - Remove unnecessary ifs. (Tim)
> - Add more Reviewed-By: tags from Jarkko and TJ.
>  
> V8:
> - Style fixes. (Jarkko)
> - Abstract _misc_res_free/alloc() (Jarkko)
> - Remove unneeded NULL checks. (Jarkko)
>  
> V7:
> - Split the large patch for the final EPC implementation, #10 in V6, into
>   smaller ones. (Dave, Kai)
> - Scan and reclaim one cgroup at a time, don't split sgx_reclaim_pages()
>   into two functions (Kai)
> - Removed patches to introduce the EPC page states, list for storing
>   candidate pages for reclamation. (not needed due to above changes)
> - Make ops one per resource type and store them in array (Michal)
> - Rename the ops struct to misc_res_ops, and enforce the constraints of
>   required callback functions (Jarkko)
> - Initialize epc cgroup in sgx driver init function. (Kai)
> - Moved addition of priv field to patch 4 where it was used first. (Jarkko)
> - Split sgx_get_current_epc_cg() out of sgx_epc_cg_try_charge() (Kai)
> - Use a static for root cgroup (Kai)
>  
> [1]https://lore.kernel.org/all/DM6PR21MB11772A6ED915825854B419D6C4989@DM6PR21MB1177.namprd21.prod.outlook.com/
> [2]https://lore.kernel.org/all/ZD7Iutppjj+muH4p@himmelriiki/
> [3]https://lore.kernel.org/lkml/7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com/
> [4]https://lore.kernel.org/lkml/yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3/
> [5]Documentation/arch/x86/sgx.rst, Section"Enclave Page Types"
> [6]Documentation/arch/x86/sgx.rst, Section "Virtual EPC"
> [7]v2: https://lore.kernel.org/all/20221202183655.3767674-1-kristen@linux.intel.com/
> [8]v3: https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@linux.intel.com/
> [9]v4: https://lore.kernel.org/all/20230913040635.28815-1-haitao.huang@linux.intel.com/
> [10]v5: https://lore.kernel.org/all/20230923030657.16148-1-haitao.huang@linux.intel.com/
> [11]v6: https://lore.kernel.org/linux-sgx/20231030182013.40086-1-haitao.huang@linux.intel.com/
> [12]v7: https://lore.kernel.org/linux-sgx/20240122172048.11953-1-haitao.huang@linux.intel.com/T/#t
> [13]v8: https://lore.kernel.org/linux-sgx/20240130020938.10025-1-haitao.huang@linux.intel.com/T/#t
> [14]v9: https://lore.kernel.org/lkml/20240205210638.157741-1-haitao.huang@linux.intel.com/T/
> [15]v10: https://lore.kernel.org/linux-sgx/20240328002229.30264-1-haitao.huang@linux.intel.com/T/#t
> 
> Haitao Huang (3):
>   x86/sgx: Replace boolean parameters with enums
>   x86/sgx: Charge mem_cgroup for per-cgroup reclamation
>   selftests/sgx: Add scripts for EPC cgroup testing
> 
> Kristen Carlson Accardi (9):
>   cgroup/misc: Add per resource callbacks for CSS events
>   cgroup/misc: Export APIs for SGX driver
>   cgroup/misc: Add SGX EPC resource type
>   x86/sgx: Implement basic EPC misc cgroup functionality
>   x86/sgx: Abstract tracking reclaimable pages in LRU
>   x86/sgx: Add basic EPC reclamation flow for cgroup
>   x86/sgx: Implement async reclamation for cgroup
>   x86/sgx: Abstract check for global reclaimable pages
>   x86/sgx: Turn on per-cgroup EPC reclamation
> 
> Sean Christopherson (2):
>   x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
>   Docs/x86/sgx: Add description for cgroup support
> 
>  Documentation/arch/x86/sgx.rst                |  83 +++++
>  arch/x86/Kconfig                              |  13 +
>  arch/x86/kernel/cpu/sgx/Makefile              |   1 +
>  arch/x86/kernel/cpu/sgx/encl.c                |  41 +--
>  arch/x86/kernel/cpu/sgx/encl.h                |   7 +-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c          | 312 ++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h          | 101 ++++++
>  arch/x86/kernel/cpu/sgx/ioctl.c               |  10 +-
>  arch/x86/kernel/cpu/sgx/main.c                | 205 +++++++++---
>  arch/x86/kernel/cpu/sgx/sgx.h                 |  50 ++-
>  arch/x86/kernel/cpu/sgx/virt.c                |   2 +-
>  include/linux/misc_cgroup.h                   |  41 +++
>  kernel/cgroup/misc.c                          | 109 ++++--
>  tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
>  .../selftests/sgx/run_epc_cg_selftests.sh     | 275 +++++++++++++++
>  .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
>  16 files changed, 1172 insertions(+), 105 deletions(-)
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>  create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
>  create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>  create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh
> 
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095
> -- 
> 2.25.1
> 

