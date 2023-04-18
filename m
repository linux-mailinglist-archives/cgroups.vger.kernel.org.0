Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FB6E6A13
	for <lists+cgroups@lfdr.de>; Tue, 18 Apr 2023 18:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjDRQpP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Apr 2023 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjDRQpF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Apr 2023 12:45:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4B1445C;
        Tue, 18 Apr 2023 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681836297; x=1713372297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dgJOKWutCD5cDBKT9pJpPU5kwpG0kpedHmUzoMJjFDA=;
  b=aa/2yUdHTjhLRhNbOT+JsAbfUjLHXXSsC8PHEspahGCsVZXMV/1GrgRC
   63my/flvWlWRpf1CrFfXgZH6ZWmpcD9qrAkpTNcJzku/HSTW8HZg68yoC
   1/k7QNR5nhVRDvnbxSz29PKKSeYSpSI7VknuOED2+YIDAaJP+QTc0seF5
   yCDEviTTCb0DzWxpvkLdwou98oVfgWOus9F4vr1a9lPWvl1oYn652U7Hl
   cogw7Sa+o5owlD82tEq/wTcmY7jwhQMpUa3txwAfwuMCI5KHh4sk+slCa
   kewPah7v9URmhSsVYWNl8b7gzHDL5TsIpiK+ReNqh/PtZQFKAv745KbL/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="324845871"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="324845871"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 09:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="691177166"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="691177166"
Received: from cbalasoi-mobl.ger.corp.intel.com (HELO himmelriiki) ([10.251.212.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 09:44:54 -0700
Date:   Tue, 18 Apr 2023 19:44:43 +0300
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
To:     Anand Krishnamoorthi <anakrish@microsoft.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Bo Zhang (ACC)" <zhanb@microsoft.com>,
        "zhiquan1.li@intel.com" <zhiquan1.li@intel.com>
Subject: Re: [EXTERNAL] [PATCH v2 00/18]  Add Cgroup support for SGX EPC
 memory
Message-ID: <ZD7Iutppjj+muH4p@himmelriiki>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <DM6PR21MB11778ABA54CD33A5822D5B24C4929@DM6PR21MB1177.namprd21.prod.outlook.com>
 <DM6PR21MB11772A6ED915825854B419D6C4989@DM6PR21MB1177.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR21MB11772A6ED915825854B419D6C4989@DM6PR21MB1177.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On Thu, Apr 13, 2023 at 06:49:53PM +0000, Anand Krishnamoorthi wrote:
> For Azure, SGX cgroup support feature is very useful.
> It is needed to enforce the EPC resource limitation of Kubernetes pods on SGX nodes.

I've been working on enabling the same use case with the difference that
I'm setting per container EPC limits (instead of pods). The Open Container
Initiative (OCI) runtime spec [1] defines how it's done and with the misc
controller implemented here "misc.max": "sgx_epc 42" setting for a container
is supported by runc out of the box.

In addition to being able to set limits per container/pod, the cgroup for
SGX EPC helps to build better telemetry/monitoring for EPC consumtion.

[1] https://github.com/opencontainers/runtime-spec/blob/main/config-linux.md#unified

> 
> Today, in Azure Kubernetes Service, each pod on SGX node claims a nominal EPC memory requirement. K8s will track the unclaimed EPC memories on SGX nodes to schedule pods.
> However, there's no enforcement on the node whether the pod uses more EPC memory than what it claims. If EPC is running out on the node, the kernel will do EPC paging, which will cause all pods suffering performance degradation.
> 
> Cgroup support for EPC will enforce EPC resource limitation on pod level, so that when a pod tries to use more EPC than what it claims, it will be EPC paged while other pods are not affected.
> 
> -Anand
> 
> From: Anand Krishnamoorthi <anakrish@microsoft.com>
> Sent: Monday, April 3, 2023 2:26 PM
> To: Kristen Carlson Accardi <kristen@linux.intel.com>; jarkko@kernel.org <jarkko@kernel.org>; dave.hansen@linux.intel.com <dave.hansen@linux.intel.com>; tj@kernel.org <tj@kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-sgx@vger.kernel.org <linux-sgx@vger.kernel.org>; cgroups@vger.kernel.org <cgroups@vger.kernel.org>; Bo Zhang (ACC) <zhanb@microsoft.com>
> Cc: zhiquan1.li@intel.com <zhiquan1.li@intel.com>
> Subject: Re: [EXTERNAL] [PATCH v2 00/18] Add Cgroup support for SGX EPC memory
> 
> Adding Bo Zhang to thread.
> 
> -Anand
> 
> 
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> Sent: Friday, December 2, 2022 10:36 AM
> To: jarkko@kernel.org <jarkko@kernel.org>; dave.hansen@linux.intel.com <dave.hansen@linux.intel.com>; tj@kernel.org <tj@kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-sgx@vger.kernel.org <linux-sgx@vger.kernel.org>; cgroups@vger.kernel.org <cgroups@vger.kernel.org>
> Cc: zhiquan1.li@intel.com <zhiquan1.li@intel.com>
> Subject: [EXTERNAL] [PATCH v2 00/18] Add Cgroup support for SGX EPC memory
> 
> Utilize the Miscellaneous cgroup controller to regulate the distribution
> of SGX EPC memory, which is a subset of system RAM that is used to provide
> SGX-enabled applications with protected memory, and is otherwise inaccessible.
> 
> SGX EPC memory allocations are separate from normal RAM allocations,
> and is managed solely by the SGX subsystem. The existing cgroup memory
> controller cannot be used to limit or account for SGX EPC memory.
> 
> This patchset implements the support for sgx_epc memory within the
> misc cgroup controller, and then utilizes the misc cgroup controller
> to provide support for setting the total system capacity, max limit
> per cgroup, and events.
> 
> This work was originally authored by Sean Christopherson a few years ago,
> and was modified to work with more recent kernels, and to utilize the
> misc cgroup controller rather than a custom controller. It is currently
> based on top of the MCA patches.
> 
> Here's the MCA patchset for reference.
> https://lore.kernel.org/linux-sgx/2d52c8c4-8ed0-6df2-2911-da5b9fcc9ae4@intel.com/T/#t
> 
> The patchset adds support for multiple LRUs to track both reclaimable
> EPC pages (i.e. pages the reclaimer knows about), as well as unreclaimable
> EPC pages (i.e. pages which the reclaimer isn't aware of, such as va pages).
> These pages are assigned to an LRU, as well as an enclave, so that an
> enclave's full EPC usage can be tracked, and limited to a max value. During
> OOM events, an enclave can be have its memory zapped, and all the EPC pages
> not tracked by the reclaimer can be freed.
> 
> I appreciate your comments and feedback.
> 
> Changelog:
> 
> v2:
>  * rename struct sgx_epc_lru to sgx_epc_lru_lists to be more clear
>    that this struct contains 2 lists.
>  * use inline functions rather than macros for sgx_epc_page_list*
>    wrappers.
>  * Remove flags macros and open code all flags.
>  * Improve the commit message for RECLAIM_IN_PROGRESS patch to make
>    it more clear what the patch does.
>  * remove notifier_block from misc cgroup changes and use a set
>    of ops for callbacks instead.
>  * rename root_misc to misc_cg_root and parent_misc to misc_cg_parent
>  * consolidate misc cgroup changes to 2 patches and remove most of
>    the previous helper functions.
> 
> Kristen Carlson Accardi (7):
>   x86/sgx: Add 'struct sgx_epc_lru_lists' to encapsulate lru list(s)
>   x86/sgx: Use sgx_epc_lru_lists for existing active page list
>   x86/sgx: Track epc pages on reclaimable or unreclaimable lists
>   cgroup/misc: Add per resource callbacks for css events
>   cgroup/misc: Prepare for SGX usage
>   x86/sgx: Add support for misc cgroup controller
>   Docs/x86/sgx: Add description for cgroup support
> 
> Sean Christopherson (11):
>   x86/sgx: Call cond_resched() at the end of sgx_reclaim_pages()
>   x86/sgx: Store struct sgx_encl when allocating new VA pages
>   x86/sgx: Introduce RECLAIM_IN_PROGRESS flag for EPC pages
>   x86/sgx: Use a list to track to-be-reclaimed pages during reclaim
>   x86/sgx: Allow reclaiming up to 32 pages, but scan 16 by default
>   x86/sgx: Return the number of EPC pages that were successfully
>     reclaimed
>   x86/sgx: Add option to ignore age of page during EPC reclaim
>   x86/sgx: Prepare for multiple LRUs
>   x86/sgx: Expose sgx_reclaim_pages() for use by EPC cgroup
>   x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
>   x86/sgx: Add EPC OOM path to forcefully reclaim EPC
> 
>  Documentation/x86/sgx.rst            |  77 ++++
>  arch/x86/Kconfig                     |  13 +
>  arch/x86/kernel/cpu/sgx/Makefile     |   1 +
>  arch/x86/kernel/cpu/sgx/encl.c       |  90 ++++-
>  arch/x86/kernel/cpu/sgx/encl.h       |   4 +-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 539 +++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  59 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c      |  14 +-
>  arch/x86/kernel/cpu/sgx/main.c       | 412 ++++++++++++++++----
>  arch/x86/kernel/cpu/sgx/sgx.h        | 122 +++++-
>  arch/x86/kernel/cpu/sgx/virt.c       |  28 +-
>  include/linux/misc_cgroup.h          |  35 ++
>  kernel/cgroup/misc.c                 |  76 +++-
>  13 files changed, 1341 insertions(+), 129 deletions(-)
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
> 
> --
> 2.38.1

-- 
Regards, Mikko
