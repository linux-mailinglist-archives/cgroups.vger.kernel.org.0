Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6047B7BF068
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379337AbjJJBmv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379334AbjJJBmu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 21:42:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF091;
        Mon,  9 Oct 2023 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696902169; x=1728438169;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=AlHkwm9zEXCrDr1o3Gq7oWu7SSn9X4lm0zxGjkR3glU=;
  b=CIkPWDc/0a0HhMGQA0T3kfZ6++idRIZ8xhl+tV69DSC1GJXOTFzJZipZ
   2o3jOcReH8Tp8gI283yf/3PABA9f32FS/gtqKfduj9vfhNWxrn1pBkMIe
   YNu7vcGEAoTwiAoOasJU0pyCj+ZPjm8Lzxs9h/CYw7DF+qxa1EMeCjYE/
   Mc7h3FCpyk/6ZPlndEUK5upf5eJ8myzDtDT4X/KyJCfI1vLUoVIkSGHtp
   G5o0TSbbzrN/cjgzd06HjtpF4U8QKanr/SCSABqXlVFRnLr2YL8l3m0pP
   VJReB4cGr4aen3y+s7tF6oZaHaUJl/+W4yHKs/9RPW30KjITundDFvN4o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374632931"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="374632931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 18:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000477573"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1000477573"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 09 Oct 2023 18:42:46 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Kai Huang" <kai.huang@intel.com>,
        "Sean Christopherson" <seanjc@google.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhiquan1 Li" <zhiquan1.li@intel.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Bo Zhang" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
Date:   Mon, 09 Oct 2023 20:42:45 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cksdjamwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ZSSZaFrxvCvR1SOy@google.com>
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

Hi Sean

On Mon, 09 Oct 2023 19:23:04 -0500, Sean Christopherson  
<seanjc@google.com> wrote:

> On Mon, Oct 09, 2023, Kai Huang wrote:
>> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> > +/**
>> > + * sgx_epc_oom() - invoke EPC out-of-memory handling on target LRU
>> > + * @lru:	LRU that is low
>> > + *
>> > + * Return:	%true if a victim was found and kicked.
>> > + */
>> > +bool sgx_epc_oom(struct sgx_epc_lru_lists *lru)
>> > +{
>> > +	struct sgx_epc_page *victim;
>> > +
>> > +	spin_lock(&lru->lock);
>> > +	victim = sgx_oom_get_victim(lru);
>> > +	spin_unlock(&lru->lock);
>> > +
>> > +	if (!victim)
>> > +		return false;
>> > +
>> > +	if (victim->flags & SGX_EPC_OWNER_PAGE)
>> > +		return sgx_oom_encl_page(victim->encl_page);
>> > +
>> > +	if (victim->flags & SGX_EPC_OWNER_ENCL)
>> > +		return sgx_oom_encl(victim->encl);
>>
>> I hate to bring this up, at least at this stage, but I am wondering why  
>> we need
>> to put VA and SECS pages to the unreclaimable list, but cannot keep an
>> "enclave_list" instead?
>
> The motivation for tracking EPC pages instead of enclaves was so that  
> the EPC
> OOM-killer could "kill" VMs as well as host-owned enclaves.  The virtual  
> EPC code
> didn't actually kill the VM process, it instead just freed all of the  
> EPC pages
> and abused the SGX architecture to effectively make the guest recreate  
> all its
> enclaves (IIRC, QEMU does the same thing to "support" live migration).
>
> Looks like y'all punted on that with:
>
>   The EPC pages allocated for KVM guests by the virtual EPC driver are  
> not
>   reclaimable by the host kernel [5]. Therefore they are not tracked by  
> any
>   LRU lists for reclaiming purposes in this implementation, but they are
>   charged toward the cgroup of the user processs (e.g., QEMU) launching  
> the
>   guest.  And when the cgroup EPC usage reaches its limit, the virtual  
> EPC
>   driver will stop allocating more EPC for the VM, and return SIGBUS to  
> the
>   user process which would abort the VM launch.
>
> which IMO is a hack, unless returning SIGBUS is actually enforced  
> somehow.  Relying
> on userspace to be kind enough to kill its VMs kinda defeats the purpose  
> of cgroup
> enforcement.  E.g. if the hard limit for a EPC cgroup is lowered,  
> userspace running
> encalves in a VM could continue on and refuse to give up its EPC, and  
> thus run above
> its limit in perpetuity.
>
Cgroup would refuse to allocate more when limit is reached so VMs can not  
run above limit.

IIRC VMs only support static EPC size right now, reaching limit at launch  
means the EPC size given in command line for QEMU is not appropriate. So  
VM should not launch, hence the current behavior.

[all EPC pages in guest are allocated on page fault caused by the  
sensitization process in guest kernel during init, which is part of the VM  
Launch process. So SIGNBUS will turn into failed VM launch.]

Once it is launched, guest kernel would have 'total capacity' given by the  
static value from QEMU option. And it would start paging when it is used  
up, never would ask for more from host.

For future with dynamic EPC for running guests, QEMU could handle  
allocation failure and pass SIGBUS to the running guest kernel.  Is that  
correct understanding?


> I can see userspace wanting to explicitly terminate the VM instead of  
> "silently"
> the VM's enclaves, but that seems like it should be a knob in the  
> virtual EPC
> code.

If my understanding above is correct and understanding your statement  
above correctly, then don't see we really need separate knob for vEPC  
code. Reaching a cgroup limit by a running guest (assuming dynamic  
allocation implemented) should not translate automatically killing the VM.  
Instead, it's user space job to work with guest to handle allocation  
failure. Guest could page and kill enclaves.

Haitao
