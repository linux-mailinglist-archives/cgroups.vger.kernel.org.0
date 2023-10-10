Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6A7BF009
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 03:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379294AbjJJBGh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 21:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379287AbjJJBGg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 21:06:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C1B6;
        Mon,  9 Oct 2023 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696899995; x=1728435995;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=PqBlrOXO0p/wIuRBtWIVZsgDBBqiJLuccAEqIg6kqmo=;
  b=nhFGhzvsuiApytIYafo6cnOWcqJeAPJnq66LsekqCoZO3J4Tz79VC3bX
   xxuX9s4NO7JJA6t0sT+OnRmbqpThcSODQRKWt2DyuBWWPXt+FdESHtWSs
   GCWxoFvAH9oaZ2wKxMGs+d4aPfxhZ517tnxlN6fPEyq1yY6utmBP2sUVJ
   iYk5m3Jr6Sotv+Gjt5srEhYHtP69Rln194kW+dCUVPaA2mqZXY4wW4Gnv
   Y1JgZ8Dvl/owXgUpyysTh8msIa2ZPKGbLGEtALxLilrram8uj5v07yLXe
   Y2OzeyAveZDvYjKt/1tI7UyApfPKEu1Y0EpDaJT/gDnn9hbIU6DmOoGMP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="388155765"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="388155765"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 18:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="703121231"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="703121231"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 09 Oct 2023 18:04:58 -0700
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
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
Date:   Mon, 09 Oct 2023 20:04:54 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 09 Oct 2023 18:45:06 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> Introduce the OOM path for killing an enclave with a reclaimer that is  
>> no
>> longer able to reclaim enough EPC pages. Find a victim enclave, which
>> will be an enclave with only "unreclaimable" EPC pages left in the
>> cgroup LRU lists. Once a victim is identified, mark the enclave as OOM
>> and zap the enclave's entire page range, and drain all mm references in
>> encl->mm_list. Block allocating any EPC pages in #PF handler, or
>> reloading any pages in all paths, or creating any new mappings.
>>
>> The OOM killing path may race with the reclaimers: in some cases, the
>> victim enclave is in the process of reclaiming the last EPC pages when
>> OOM happens, that is, all pages other than SECS and VA pages are in
>> RECLAIMING_IN_PROGRESS state. The reclaiming process requires access to
>> the enclave backing, VA pages as well as SECS. So the OOM killer does
>> not directly release those enclave resources, instead, it lets all
>> reclaiming in progress to finish, and relies (as currently done) on
>> kref_put on encl->refcount to trigger sgx_encl_release() to do the
>> final cleanup.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> ---
>> V5:
>> - Rename SGX_ENCL_OOM to SGX_ENCL_NO_MEMORY
>>
>> V4:
>> - Updates for patch reordering and typo fixes.
>>
>> V3:
>> - Rebased to use the new VMA_ITERATOR to zap VMAs.
>> - Fixed the racing cases by blocking new page allocation/mapping and
>> reloading when enclave is marked for OOM. And do not release any enclave
>> resources other than draining mm_list entries, and let pages in
>> RECLAIMING_IN_PROGRESS to be reaped by reclaimers.
>> - Due to above changes, also removed the no-longer needed encl->lock in
>> the OOM path which was causing deadlocks reported by the lock prover.
>>
>
> [...]
>
>> +
>> +/**
>> + * sgx_epc_oom() - invoke EPC out-of-memory handling on target LRU
>> + * @lru:	LRU that is low
>> + *
>> + * Return:	%true if a victim was found and kicked.
>> + */
>> +bool sgx_epc_oom(struct sgx_epc_lru_lists *lru)
>> +{
>> +	struct sgx_epc_page *victim;
>> +
>> +	spin_lock(&lru->lock);
>> +	victim = sgx_oom_get_victim(lru);
>> +	spin_unlock(&lru->lock);
>> +
>> +	if (!victim)
>> +		return false;
>> +
>> +	if (victim->flags & SGX_EPC_OWNER_PAGE)
>> +		return sgx_oom_encl_page(victim->encl_page);
>> +
>> +	if (victim->flags & SGX_EPC_OWNER_ENCL)
>> +		return sgx_oom_encl(victim->encl);
>
> I hate to bring this up, at least at this stage, but I am wondering why  
> we need
> to put VA and SECS pages to the unreclaimable list, but cannot keep an
> "enclave_list" instead?
>
> So by looking the patch (" x86/sgx: Limit process EPC usage with misc  
> cgroup
> controller"), if I am not missing anything, the whole "unreclaimable"  
> list is
> just used to find the victim enclave when OOM needs to be done.  Thus, I  
> don't
> see why "enclave_list" cannot be used to achieve this.
>
> The reason that I am asking is because it seems using "enclave_list" we  
> can
> simplify the code.  At least the patches related to track VA/SECS pages,  
> and the
> SGX_EPC_OWNER_PAGE/SGX_EPC_OWNER_ENCL thing can be eliminated  
> completely.  
> Using "enclave_list", I guess you just need to put the enclave to the  
> current
> EPC cgroup when SECS page is allocated.
>
Later the hosting process could migrated/reassigned to another cgroup?
What to do when the new cgroup is OOM?

Thanks
Haitao
