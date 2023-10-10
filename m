Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0E7BF064
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 03:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379337AbjJJBiT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 21:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379327AbjJJBiS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 21:38:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85C9F;
        Mon,  9 Oct 2023 18:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696901896; x=1728437896;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=FpHY3EBsELI1bSMT8REqSo9p+ncT1ymS13I9y3jXpjg=;
  b=nymk4MSTFizdl8jlKvSRJRWtecvfZ1cPYOqUc6d1tJUKlzwS74ttEYIR
   KWKfipkoImxMXVNcW6tSwG8pAxymjRYN5+MmCJXsZmImDrGwtK404wowY
   2imrCdPDy+Zb3zbgpnAvlYe2oubebWw6oXB9Jip9qGN1l0supQKJkk0dt
   NcgN9IiCAMW8hQGrCvrGH3zaoxKRLHMhhyBboCPIhNHVJAXIFhHSJ4v1C
   KVp0uCqtb3CT684cnYsyVIAeusJ1O2uOlQKFlx3WMejKcb7moN+zmDXlI
   6Ctodjx6OT4+3b6eDWgD8RbzIJB01hXbG9LMzA+s/TlRnM6ds6NrhJtAp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374632120"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="374632120"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 18:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000476694"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1000476694"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 09 Oct 2023 18:38:13 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhang, Bo" <zhanb@microsoft.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <fc6aa778ddbde9536cafe48b847cf6c45b640ea4.camel@intel.com>
Date:   Mon, 09 Oct 2023 20:38:12 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ckr5yetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <fc6aa778ddbde9536cafe48b847cf6c45b640ea4.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 09 Oct 2023 20:18:00 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-10-09 at 20:04 -0500, Haitao Huang wrote:
>> On Mon, 09 Oct 2023 18:45:06 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> > On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> > > From: Sean Christopherson <sean.j.christopherson@intel.com>
>> > >
>> > > Introduce the OOM path for killing an enclave with a reclaimer that  
>> is
>> > > no
>> > > longer able to reclaim enough EPC pages. Find a victim enclave,  
>> which
>> > > will be an enclave with only "unreclaimable" EPC pages left in the
>> > > cgroup LRU lists. Once a victim is identified, mark the enclave as  
>> OOM
>> > > and zap the enclave's entire page range, and drain all mm  
>> references in
>> > > encl->mm_list. Block allocating any EPC pages in #PF handler, or
>> > > reloading any pages in all paths, or creating any new mappings.
>> > >
>> > > The OOM killing path may race with the reclaimers: in some cases,  
>> the
>> > > victim enclave is in the process of reclaiming the last EPC pages  
>> when
>> > > OOM happens, that is, all pages other than SECS and VA pages are in
>> > > RECLAIMING_IN_PROGRESS state. The reclaiming process requires  
>> access to
>> > > the enclave backing, VA pages as well as SECS. So the OOM killer  
>> does
>> > > not directly release those enclave resources, instead, it lets all
>> > > reclaiming in progress to finish, and relies (as currently done) on
>> > > kref_put on encl->refcount to trigger sgx_encl_release() to do the
>> > > final cleanup.
>> > >
>> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> > > Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> > > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> > > Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> > > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> > > Cc: Sean Christopherson <seanjc@google.com>
>> > > ---
>> > > V5:
>> > > - Rename SGX_ENCL_OOM to SGX_ENCL_NO_MEMORY
>> > >
>> > > V4:
>> > > - Updates for patch reordering and typo fixes.
>> > >
>> > > V3:
>> > > - Rebased to use the new VMA_ITERATOR to zap VMAs.
>> > > - Fixed the racing cases by blocking new page allocation/mapping and
>> > > reloading when enclave is marked for OOM. And do not release any  
>> enclave
>> > > resources other than draining mm_list entries, and let pages in
>> > > RECLAIMING_IN_PROGRESS to be reaped by reclaimers.
>> > > - Due to above changes, also removed the no-longer needed  
>> encl->lock in
>> > > the OOM path which was causing deadlocks reported by the lock  
>> prover.
>> > >
>> >
>> > [...]
>> >
>> > > +
>> > > +/**
>> > > + * sgx_epc_oom() - invoke EPC out-of-memory handling on target LRU
>> > > + * @lru:	LRU that is low
>> > > + *
>> > > + * Return:	%true if a victim was found and kicked.
>> > > + */
>> > > +bool sgx_epc_oom(struct sgx_epc_lru_lists *lru)
>> > > +{
>> > > +	struct sgx_epc_page *victim;
>> > > +
>> > > +	spin_lock(&lru->lock);
>> > > +	victim = sgx_oom_get_victim(lru);
>> > > +	spin_unlock(&lru->lock);
>> > > +
>> > > +	if (!victim)
>> > > +		return false;
>> > > +
>> > > +	if (victim->flags & SGX_EPC_OWNER_PAGE)
>> > > +		return sgx_oom_encl_page(victim->encl_page);
>> > > +
>> > > +	if (victim->flags & SGX_EPC_OWNER_ENCL)
>> > > +		return sgx_oom_encl(victim->encl);
>> >
>> > I hate to bring this up, at least at this stage, but I am wondering  
>> why
>> > we need
>> > to put VA and SECS pages to the unreclaimable list, but cannot keep an
>> > "enclave_list" instead?
>> >
>> > So by looking the patch (" x86/sgx: Limit process EPC usage with misc
>> > cgroup
>> > controller"), if I am not missing anything, the whole "unreclaimable"
>> > list is
>> > just used to find the victim enclave when OOM needs to be done.   
>> Thus, I
>> > don't
>> > see why "enclave_list" cannot be used to achieve this.
>> >
>> > The reason that I am asking is because it seems using "enclave_list"  
>> we
>> > can
>> > simplify the code.  At least the patches related to track VA/SECS  
>> pages,
>> > and the
>> > SGX_EPC_OWNER_PAGE/SGX_EPC_OWNER_ENCL thing can be eliminated
>> > completely.
>> > Using "enclave_list", I guess you just need to put the enclave to the
>> > current
>> > EPC cgroup when SECS page is allocated.
>> >
>> Later the hosting process could migrated/reassigned to another cgroup?
>> What to do when the new cgroup is OOM?
>>
>
> You addressed in the documentation, no?
>
> +Migration
> +---------
> +
> +Once an EPC page is charged to a cgroup (during allocation), it
> +remains charged to the original cgroup until the page is released
> +or reclaimed.  Migrating a process to a different cgroup doesn't
> +move the EPC charges that it incurred while in the previous cgroup
> +to its new cgroup.

Should we kill the enclave though because some VA pages may be in the new  
group?

Haitao
