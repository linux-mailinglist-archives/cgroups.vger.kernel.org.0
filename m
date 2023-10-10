Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858867C01F6
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjJJQt6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjJJQt5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 12:49:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5C99;
        Tue, 10 Oct 2023 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696956594; x=1728492594;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=HzWgG30Hk6ZxaaC2F7EqKo3OACzpOdg8RcC6CY5/PVE=;
  b=Z3OgZYPmueg58LGNO3Gt2MiGubA1R4jrFauEYFU2ryq358S3OImQwTdq
   DWFjhJFcT8BpiW2ekNy7/Zo+yLffjfJ+xJQBFQq4V3MY72u1zmHITW4KL
   Mz8n+uXmMNq0ksD0DmyI8gXgvuMmRRH5ijssWKbffy1P8QZ+g42cTXY0i
   71Z1Rn1647CwQylyU9tJ+nXeKklZI1Jfm6O/ME4T2bZOBZt6sJ3Svr4kP
   W1vhXiGdc5u08082Z59Uqf5TYD0h+/43e4dl8DXjqjjGh8ph3eJwEZ6BS
   T/aiFSlb+jYV3JDilUU8jIYWbEdq/3UXeCJ2uAj49/VYnVgBIODzQuNie
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415473402"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="415473402"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000775184"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1000775184"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 10 Oct 2023 09:49:51 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
 <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
Date:   Tue, 10 Oct 2023 11:49:49 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
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

On Mon, 09 Oct 2023 20:34:29 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Tue, 2023-10-10 at 00:50 +0000, Huang, Kai wrote:
>> On Mon, 2023-10-09 at 17:23 -0700, Sean Christopherson wrote:
>> > On Mon, Oct 09, 2023, Kai Huang wrote:
>> > > On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> > > > +/**
>> > > > + * sgx_epc_oom() - invoke EPC out-of-memory handling on target  
>> LRU
>> > > > + * @lru:	LRU that is low
>> > > > + *
>> > > > + * Return:	%true if a victim was found and kicked.
>> > > > + */
>> > > > +bool sgx_epc_oom(struct sgx_epc_lru_lists *lru)
>> > > > +{
>> > > > +	struct sgx_epc_page *victim;
>> > > > +
>> > > > +	spin_lock(&lru->lock);
>> > > > +	victim = sgx_oom_get_victim(lru);
>> > > > +	spin_unlock(&lru->lock);
>> > > > +
>> > > > +	if (!victim)
>> > > > +		return false;
>> > > > +
>> > > > +	if (victim->flags & SGX_EPC_OWNER_PAGE)
>> > > > +		return sgx_oom_encl_page(victim->encl_page);
>> > > > +
>> > > > +	if (victim->flags & SGX_EPC_OWNER_ENCL)
>> > > > +		return sgx_oom_encl(victim->encl);
>> > >
>> > > I hate to bring this up, at least at this stage, but I am wondering  
>> why we need
>> > > to put VA and SECS pages to the unreclaimable list, but cannot keep  
>> an
>> > > "enclave_list" instead?
>> >
>> > The motivation for tracking EPC pages instead of enclaves was so that  
>> the EPC
>> > OOM-killer could "kill" VMs as well as host-owned enclaves. >
>>
>> Ah this seems a fair argument. :-)
>>
>> > The virtual EPC code
>> > didn't actually kill the VM process, it instead just freed all of the  
>> EPC pages
>> > and abused the SGX architecture to effectively make the guest  
>> recreate all its
>> > enclaves (IIRC, QEMU does the same thing to "support" live migration).
>>
>> It returns SIGBUS.  SGX VM live migration also requires enough EPC  
>> being able to
>> be allocated on the destination machine to work AFAICT.
>>
>> >
>> > Looks like y'all punted on that with:
>> >
>> >   The EPC pages allocated for KVM guests by the virtual EPC driver  
>> are not
>> >   reclaimable by the host kernel [5]. Therefore they are not tracked  
>> by any
>> >   LRU lists for reclaiming purposes in this implementation, but they  
>> are
>> >   charged toward the cgroup of the user processs (e.g., QEMU)  
>> launching the
>> >   guest.  And when the cgroup EPC usage reaches its limit, the  
>> virtual EPC
>> >   driver will stop allocating more EPC for the VM, and return SIGBUS  
>> to the
>> >   user process which would abort the VM launch.
>> >
>> > which IMO is a hack, unless returning SIGBUS is actually enforced  
>> somehow. >
>>
>> "enforced" do you mean?
>>
>> Currently the sgx_vepc_fault() returns VM_FAULT_SIGBUS when it cannot  
>> allocate
>> EPC page.  And when this happens, KVM returns KVM_PFN_ERR_FAULT in  
>> hva_to_pfn(),
>> which eventually results in KVM returning -EFAULT to userspace in  
>> vcpu_run().
>> And Qemu then kills the VM with some nonsense message:
>>
>>         error: kvm run failed Bad address
>>         <dump guest registers nonsense>
>>
>> > Relying
>> > on userspace to be kind enough to kill its VMs kinda defeats the  
>> purpose of cgroup
>> > enforcement.  E.g. if the hard limit for a EPC cgroup is lowered,  
>> userspace running
>> > encalves in a VM could continue on and refuse to give up its EPC, and  
>> thus run above
>> > its limit in perpetuity.
>>
>> >
>> > I can see userspace wanting to explicitly terminate the VM instead of  
>> "silently"
>> > the VM's enclaves, but that seems like it should be a knob in the  
>> virtual EPC
>> > code.
>
> I guess I slightly misunderstood your words.
>
> You mean we want to kill VM when the limit is set to be lower than  
> virtual EPC
> size.
>
> This patch adds SGX_ENCL_NO_MEMORY.  I guess we can use it for virtual  
> EPC too?
>

That flag is set for enclaves, do you mean we set similar flag in vepc  
struct?

> In the sgx_vepc_fault(), we check this flag at early time and return  
> SIGBUS if
> it is set.
>
> But this also requires keeping virtual EPC pages in some list, and  
> handles them
> in sgx_epc_oom() too.
>
> And for virtual EPC pages, I guess the "young" logic can be applied thus
> probably it's better to keep the actual virtual EPC pages to a  
> (separate?) list
> instead of keeping the virtual EPC instance.
>
> 	struct sgx_epc_lru {
> 		struct list_head reclaimable;
> 		struct sgx_encl *enclaves;
> 		struct list_head vepc_pages;
> 	}
>
> Or still tracking VA/SECS and virtual EPC pages in a single  
> unrecliamable list?
>

One LRU should be OK as we only need relative order in which they are  
loaded?
If an VA page is in front of vEPC, we just kill host side enclave first  
before disrupting VMs in the same group.
As the group is not in a good situation anyway so kernel just pick  
something reasonable to force kill.

Also after rereading the sentences "The virtual EPC code didn't actually  
kill the VM process, it instead just freed all of the  EPC pages and  
abused the SGX architecture to effectively make the guest  recreate all  
its enclaves..."

Maybe by "kill" vm, Sean means EREMOVE the vepc pages in the unreclaimable  
LRU, which effectively make enclaves in guest receiving "EPC lost" error  
and those enclaves are forced to be reloaded (all reasonable user space  
impl should already handle that). Not sure about free *all* of EPC pages  
though. we should just EREMOVE enough to bring down the usage. And disable  
new allocation in sgx_vepc_fault as kai outlined above. It also means user  
space needs to inject/pass the SIGBUS to guest (I'm not really familiar  
with this part, or maybe it's already there?). @sean is that what you  
mean? Sorry I've been slow on understanding this.

If this is the case, some may still think it's too disruptive to guest  
because the guest did not have a chance to paging out less active enclave  
pages. But it's user's limit to set so it is justifiable as long as we  
document this behavior.

Thanks to both of you for great insights.

Haitao


