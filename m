Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527D3640D62
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 19:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiLBShK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 13:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiLBShE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 13:37:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9A3EDD47;
        Fri,  2 Dec 2022 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670006223; x=1701542223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZqDhaSj465j8Weu6K/8SPWCZ4E93AhshOKFXA95cDvk=;
  b=eCQsefgyEG0ZCMcPfJ9ZWAwd5o6pzLuygGaqGnXt1nUPSBLKBNkAJN/1
   4hIQsle/vNd+HT/UbKPSE+AZgYgyizphTuSZgtNOSUnEqHVVsVxGpPdB0
   uvNfleEPPifEgpiLIp2QDpBGvN5LcGyJkAvHuFVdIJHBLK6SxQV0LDd3H
   Ow0O4n7Px9WRszq5M/6uSnxMBaqUVwfTkU6SDVUdLGEQGotLfDZb0uJoi
   QgpDb5WG7un2j/gYJ0t5xidbADSnaAdAsTy9w75n+9djLdrOWZAa336Cl
   f8crkKsl01YzmwjH4KDPUAEdU0VxNcVf+fPO1c+Em5RvOxHEIy7yUra2W
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314724460"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314724460"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713717323"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713717323"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.251.1.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:37:01 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     zhiquan1.li@intel.com
Subject: [PATCH v2 00/18]  Add Cgroup support for SGX EPC memory
Date:   Fri,  2 Dec 2022 10:36:36 -0800
Message-Id: <20221202183655.3767674-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Utilize the Miscellaneous cgroup controller to regulate the distribution
of SGX EPC memory, which is a subset of system RAM that is used to provide
SGX-enabled applications with protected memory, and is otherwise inaccessible.

SGX EPC memory allocations are separate from normal RAM allocations,
and is managed solely by the SGX subsystem. The existing cgroup memory
controller cannot be used to limit or account for SGX EPC memory.

This patchset implements the support for sgx_epc memory within the 
misc cgroup controller, and then utilizes the misc cgroup controller
to provide support for setting the total system capacity, max limit
per cgroup, and events.

This work was originally authored by Sean Christopherson a few years ago,
and was modified to work with more recent kernels, and to utilize the
misc cgroup controller rather than a custom controller. It is currently
based on top of the MCA patches.

Here's the MCA patchset for reference.
https://lore.kernel.org/linux-sgx/2d52c8c4-8ed0-6df2-2911-da5b9fcc9ae4@intel.com/T/#t

The patchset adds support for multiple LRUs to track both reclaimable
EPC pages (i.e. pages the reclaimer knows about), as well as unreclaimable
EPC pages (i.e. pages which the reclaimer isn't aware of, such as va pages).
These pages are assigned to an LRU, as well as an enclave, so that an
enclave's full EPC usage can be tracked, and limited to a max value. During
OOM events, an enclave can be have its memory zapped, and all the EPC pages
not tracked by the reclaimer can be freed.

I appreciate your comments and feedback.

Changelog:

v2:
 * rename struct sgx_epc_lru to sgx_epc_lru_lists to be more clear
   that this struct contains 2 lists.
 * use inline functions rather than macros for sgx_epc_page_list*
   wrappers.
 * Remove flags macros and open code all flags.
 * Improve the commit message for RECLAIM_IN_PROGRESS patch to make
   it more clear what the patch does.
 * remove notifier_block from misc cgroup changes and use a set
   of ops for callbacks instead.
 * rename root_misc to misc_cg_root and parent_misc to misc_cg_parent
 * consolidate misc cgroup changes to 2 patches and remove most of
   the previous helper functions.

Kristen Carlson Accardi (7):
  x86/sgx: Add 'struct sgx_epc_lru_lists' to encapsulate lru list(s)
  x86/sgx: Use sgx_epc_lru_lists for existing active page list
  x86/sgx: Track epc pages on reclaimable or unreclaimable lists
  cgroup/misc: Add per resource callbacks for css events
  cgroup/misc: Prepare for SGX usage
  x86/sgx: Add support for misc cgroup controller
  Docs/x86/sgx: Add description for cgroup support

Sean Christopherson (11):
  x86/sgx: Call cond_resched() at the end of sgx_reclaim_pages()
  x86/sgx: Store struct sgx_encl when allocating new VA pages
  x86/sgx: Introduce RECLAIM_IN_PROGRESS flag for EPC pages
  x86/sgx: Use a list to track to-be-reclaimed pages during reclaim
  x86/sgx: Allow reclaiming up to 32 pages, but scan 16 by default
  x86/sgx: Return the number of EPC pages that were successfully
    reclaimed
  x86/sgx: Add option to ignore age of page during EPC reclaim
  x86/sgx: Prepare for multiple LRUs
  x86/sgx: Expose sgx_reclaim_pages() for use by EPC cgroup
  x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
  x86/sgx: Add EPC OOM path to forcefully reclaim EPC

 Documentation/x86/sgx.rst            |  77 ++++
 arch/x86/Kconfig                     |  13 +
 arch/x86/kernel/cpu/sgx/Makefile     |   1 +
 arch/x86/kernel/cpu/sgx/encl.c       |  90 ++++-
 arch/x86/kernel/cpu/sgx/encl.h       |   4 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 539 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  59 +++
 arch/x86/kernel/cpu/sgx/ioctl.c      |  14 +-
 arch/x86/kernel/cpu/sgx/main.c       | 412 ++++++++++++++++----
 arch/x86/kernel/cpu/sgx/sgx.h        | 122 +++++-
 arch/x86/kernel/cpu/sgx/virt.c       |  28 +-
 include/linux/misc_cgroup.h          |  35 ++
 kernel/cgroup/misc.c                 |  76 +++-
 13 files changed, 1341 insertions(+), 129 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h

-- 
2.38.1

