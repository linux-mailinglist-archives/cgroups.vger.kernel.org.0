Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921307A239A
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjIOQ3O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjIOQ2n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 12:28:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA46199;
        Fri, 15 Sep 2023 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694795318; x=1726331318;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=cj9l7n2Bmb5XcYMcAhASPfEHm9/0gmYiOFma5VsXwGU=;
  b=MzFaLDBa+DuoIw3OwezMGLM0QNB+PCgUYfIHVyv5pH+iGEiTqMn/lGqi
   nmWDOWhMiRQtu3dOzyuuI2L9pHm1FpkAdd7Li/XG3ws0FYZciGeOmpb4p
   IT3TfIvujsF1XvIt4OaZP9n0qhIuiILFbhmB/jTbGt63+2eD2eK3U00SA
   isllENiclTUZcGsnBSsUB4+ZSPKwpnworVDmB7cWwLc7c2JXpN7KaPLnH
   N7Gcv1edFhFyArbsnp8tF6e543DRQ7DrM86evj17R58y+XTYsGR/54+wq
   tjgqsMkHNOoXqBRrNB4D8NYIernupCDUJPW65sOXnBbWg9uYMnLzqgEri
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="358708133"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="358708133"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810585199"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="810585199"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Sep 2023 09:28:33 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v4 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate
 LRU lists
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-4-haitao.huang@linux.intel.com>
 <851f9b3043732c17cd8f86a77ccee0b7c6caa22f.camel@intel.com>
Date:   Fri, 15 Sep 2023 11:28:28 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2bbmpqncwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <851f9b3043732c17cd8f86a77ccee0b7c6caa22f.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 14 Sep 2023 05:31:30 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> Some non-technical staff:
>
> On Tue, 2023-09-12 at 21:06 -0700, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> The patch was from Kristen, but ...
>
>>
>> Introduce a data structure to wrap the existing reclaimable list and its
>> spinlock. Each cgroup later will have one instance of this structure to
>> track EPC pages allocated for processes associated with the same cgroup.
>> Just like the global SGX reclaimer (ksgxd), an EPC cgroup reclaims pages
>> from the reclaimable list in this structure when its usage reaches near
>> its limit.
>>
>> Currently, ksgxd does not track the VA, SECS pages. They are considered
>> as 'unreclaimable' pages that are only deallocated when their respective
>> owning enclaves are destroyed and all associated resources released.
>>
>> When an EPC cgroup can not reclaim any more reclaimable EPC pages to
>> reduce its usage below its limit, the cgroup must also reclaim those
>> unreclaimables by killing their owning enclaves. The VA and SECS pages
>> later are also tracked in an 'unreclaimable' list added to this  
>> structure
>> to support this OOM killing of enclaves.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> ... it was firstly signed by Sean and then Kristen, which doesn't sound  
> right.
>
> If the patch was from Kristen, then either Sean's SoB should come after
> Kristen's (which means Sean took Kristen's patch and signed it), or you  
> need to
> have a Co-developed-by tag for Sean right before his SoB (which  
> indicates Sean
> participated in the development of the patch but likely he wasn't the  
> main
> developer).
>
> But I _guess_ the patch was just from Sean.
>
 From what I see:
In v1 kristen included a "From" tsg for Sean. In v2 she split the original  
patch into two and added some wrappers/ At that time, she removed the  
"From" tag for both patches but kept the SOB and CC.

@Kristen, could you confirm?

I only removed the wrappers from v2 based on Dave's comments.
So if confirmed by Kristen, should we add "From" tag for Sean?

I'll double check the other patches.
Thanks
Haitao
