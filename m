Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB377FA35
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjHQPFE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352724AbjHQPEm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 11:04:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B5271B;
        Thu, 17 Aug 2023 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692284676; x=1723820676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ojerZXhAzLWQx9WjZ/l42PtQhGJkDMLqPRYuQies1SQ=;
  b=fdPE5Z6ezuqv40WWb/Y1+orUmFa7dlIxCVptS6b8ji8t2+lNRnsEB9Uy
   B8b5NnKqiO3Ga0zZ8FNmv9QhrBC0YWSzEvQMpePqg1+m9blEGKaQ6JFUy
   OThkVrtPKxOLw5VC0IdY0P815SUF1M9JWF9p6ZDSpU5NqfbZH6gUGJpiQ
   s6OnCTaqNW9tUfodfVVme6xBi0Rg0UZZGyomYIQcvhz60rvF3IJhM1TbN
   5JaLLdyH9X5zTIY8KsgfoYFVMafUmrOr0JX+ynsjB5pmqF/228J6gAX6K
   NaKNg5jQB0jhS7IUSRjcQHqztJLevyL9z6TL9AvJi5mm+rUZ7a3etFj/N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353146687"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="353146687"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737757738"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="737757738"
Received: from kaeanliu-mobl.amr.corp.intel.com (HELO himmelriiki) ([10.252.52.225])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:04:30 -0700
Date:   Thu, 17 Aug 2023 18:04:21 +0300
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, kai.huang@intel.com,
        reinette.chatre@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com
Subject: Re: [PATCH v3 00/28]  Add Cgroup support for SGX EPC memory
Message-ID: <ZN429coVzNVtNVqC@himmelriiki>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 12, 2023 at 04:01:34PM -0700, Haitao Huang wrote:
> SGX EPC memory allocations are separate from normal RAM allocations, and is
> managed solely by the SGX subsystem. The existing cgroup memory controller
> cannot be used to limit or account for SGX EPC memory, which is a desirable
> feature in some environments, e.g., support for pod level control in a
> Kubernates cluster on a VM or baremetal host [1,2] in those environments.
> 
> This patchset implements the support for sgx_epc memory within the misc
> cgroup controller. The user can use the misc cgroup controller to set and
> enforce a max limit on total EPC usage per cgroup. The implementation
> reports current usage and events of reaching the limit per cgroup as well
> as the total system capacity.
> 
> This work was originally authored by Sean Christopherson a few years ago,
> and previously modified by Kristen C. Accardi to work with more recent
> kernels, and to utilize the misc cgroup controller rather than a custom
> controller. Now I updated the patches based on review comments on the V2
> series[3], simplified a few aspects of the implementation/design and fixed
> some stability issues found from testing, while keeping the same user space
> facing interfaces.
> 
> The patchset adds support for multiple LRUs to track both reclaimable EPC
> pages (i.e. pages the reclaimer knows about), as well as unreclaimable EPC
> pages (i.e.  pages which the reclaimer isn't aware of, such as VA pages).
> These pages are assigned to an LRU, as well as an enclave, so that an
> enclave's full EPC usage can be tracked, and limited to a max value. During
> OOM events, an enclave can be have its memory zapped, and all the EPC pages
> not tracked by the reclaimer can be freed.
> 
> I appreciate your comments and feedback.

I've been stressing this patch set in my Kubernetes cluster with a few
simultaneous replicas with two Gramine containers (one with EDMM and another
one without) in each and per container misc.max limits set.

I've not observed any issues and everything seems to be as expected: per
container EPC usage is capped to misc.max and its memory.limit triggers OOM
for the reclaimed EPC.

Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>

> 
> Summary of changes from v2: (more details in commit logs)
> 
> * Added EPC states to replace flags in sgx_epc_page struct. (Jarkko)
> * Unrolled wrappers for cond_resched, list (Dave)
> * Separate patches for adding reclaimable and unreclaimable lists. (Dave)
> * Other improvments on patch flow, commit messages, styles. (Dave, Jarkko)
> * Simplified the cgroup tree walking with plain
>   css_for_each_descendant_pre.
> * Fixed race conditions and crashes.
> * OOM killer to wait for the victim enclave pages being reclaimed.
> * Unblock the user by handling misc_max_write callback asynchronously.
> * Rebased onto 6.4 and no longer base this series on the MCA patchset.
> * Fix an overflow in misc_try_charge.
> * Fix a NULL pointer in SGX PF handler.
> * Updated and included the SGX selftest patches previously reviewed. Those
>   patches fix issues triggered in high EPC pressure required for cgroup
>   testing.
> * Added test scripts to help setup and test SGX EPC cgroups.
> 
> [1]https://lore.kernel.org/all/DM6PR21MB11772A6ED915825854B419D6C4989@DM6PR21MB1177.namprd21.prod.outlook.com/
> [2]https://lore.kernel.org/all/ZD7Iutppjj+muH4p@himmelriiki/
> [3]https://lore.kernel.org/all/20221202183655.3767674-1-kristen@linux.intel.com/
> [4]Documentation/arch/x86/sgx.rst, Section "Virtual EPC"
> 
> Haitao Huang (6):
>   x86/sgx: Store struct sgx_encl when allocating new VA pages
>   x86/sgx: Introduce EPC page states
>   x86/sgx: fix a NULL pointer
>   cgroup/misc: Fix an overflow
>   selftests/sgx: Retry the ioctl()'s returned with EAGAIN
>   selftests/sgx: Add scripts for epc cgroup testing
> 
> Jarkko Sakkinen (3):
>   selftests/sgx: Move ENCL_HEAP_SIZE_DEFAULT to main.c
>   selftests/sgx: Use encl->encl_size in sigstruct.c
>   selftests/sgx: Include the dynamic heap size to the ELRANGE
>     calculation
> 
> Kristen Carlson Accardi (9):
>   x86/sgx: Add 'struct sgx_epc_lru_lists' to encapsulate lru list(s)
>   x86/sgx: Use sgx_epc_lru_lists for existing active page list
>   x86/sgx: Store reclaimable epc pages in sgx_epc_lru_lists
>   x86/sgx: store unreclaimable EPC pages in sgx_epc_lru_lists
>   x86/sgx: Use a list to track to-be-reclaimed pages
>   cgroup/misc: Add per resource callbacks for CSS events
>   cgroup/misc: Add SGX EPC resource type and export APIs for SGX driver
>   x86/sgx: Limit process EPC usage with misc cgroup controller
>   Docs/x86/sgx: Add description for cgroup support
> 
> Sean Christopherson (9):
>   x86/sgx: Add EPC page flags to identify owner type
>   x86/sgx: Introduce RECLAIM_IN_PROGRESS state
>   x86/sgx: Allow reclaiming up to 32 pages, but scan 16 by default
>   x85/sgx: Return the number of EPC pages that were successfully
>     reclaimed
>   x86/sgx: Add option to ignore age of page during EPC reclaim
>   x86/sgx: Prepare for multiple LRUs
>   x86/sgx: Expose sgx_reclaim_pages() for use by EPC cgroup
>   x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
>   x86/sgx: Add EPC OOM path to forcefully reclaim EPC
> 
> Vijay Dhanraj (1):
>   selftests/sgx: Add SGX selftest augment_via_eaccept_long
> 
>  Documentation/arch/x86/sgx.rst                |  77 ++++
>  arch/x86/Kconfig                              |  13 +
>  arch/x86/kernel/cpu/sgx/Makefile              |   1 +
>  arch/x86/kernel/cpu/sgx/driver.c              |  27 +-
>  arch/x86/kernel/cpu/sgx/encl.c                |  95 +++-
>  arch/x86/kernel/cpu/sgx/encl.h                |   4 +-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c          | 406 ++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h          |  60 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c               |  25 +-
>  arch/x86/kernel/cpu/sgx/main.c                | 406 ++++++++++++++----
>  arch/x86/kernel/cpu/sgx/sgx.h                 | 113 ++++-
>  include/linux/misc_cgroup.h                   |  34 ++
>  kernel/cgroup/misc.c                          |  63 ++-
>  tools/testing/selftests/sgx/load.c            |   8 +-
>  tools/testing/selftests/sgx/main.c            | 177 +++++++-
>  tools/testing/selftests/sgx/main.h            |   6 +-
>  .../selftests/sgx/run_tests_in_misc_cg.sh     |  68 +++
>  tools/testing/selftests/sgx/setup_epc_cg.sh   |  29 ++
>  tools/testing/selftests/sgx/sigstruct.c       |   8 +-
>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
>  20 files changed, 1446 insertions(+), 187 deletions(-)
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>  create mode 100755 tools/testing/selftests/sgx/run_tests_in_misc_cg.sh
>  create mode 100755 tools/testing/selftests/sgx/setup_epc_cg.sh
>  create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh
> 
> -- 
> 2.25.1
> 

-- Regards, Mikko
