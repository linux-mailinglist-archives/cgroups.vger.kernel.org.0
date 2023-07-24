Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A875FA3E
	for <lists+cgroups@lfdr.de>; Mon, 24 Jul 2023 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGXOzn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGXOzm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 10:55:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B627C10C0;
        Mon, 24 Jul 2023 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690210540; x=1721746540;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=0nQmreZIIFL5rEUPYPNOo7mftuofidoQGo9palwNguw=;
  b=Pb9+CNagUg5PRfUxXh8qCaZXRgU/7qe0oG2ZZzQ/4ho3mPLPO0ICuP1/
   00ouNESRfd2QaQJxfwjXTV/6HA2/ley2CVb7jEFfB4vkTOh6EU6cSax9P
   cZ0QFCGWZiWVyDoPX9liuS3Cv0JoOwFlNXPL8tw+0y6FLbPevLP1/OC23
   o4PaCpFImeNkULTymvDcVouCn49vbcjFegCU8sTzd031rRMAPwEu2nTRO
   1XYrZ/2kmxqlWhN5LafhukewA6rpYkmOiI7wId6OZNvLDGs4BJH38ST4g
   eL6dUtAebx1G6aEuklNkhrN/dBgXGIp9h7eG1zGIgacN0AC6WZN4Ulcfy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398369098"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398369098"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899520928"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899520928"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 24 Jul 2023 07:55:38 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-4-haitao.huang@linux.intel.com>
 <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
 <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4f5496d2e0ea8edba430e7de7304bdd840616146.camel@intel.com>
Date:   Mon, 24 Jul 2023 09:55:37 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18lc2zw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <4f5496d2e0ea8edba430e7de7304bdd840616146.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Kai
On Mon, 24 Jul 2023 05:04:48 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-07-17 at 08:23 -0500, Haitao Huang wrote:
>> On Mon, 17 Jul 2023 07:45:36 -0500, Jarkko Sakkinen <jarkko@kernel.org>
>> wrote:
>>
>> > On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
>> > > From: Kristen Carlson Accardi <kristen@linux.intel.com>
>> > >
>> > > Introduce a data structure to wrap the existing reclaimable list
>> > > and its spinlock in a struct to minimize the code changes needed
>> > > to handle multiple LRUs as well as reclaimable and non-reclaimable
>> > > lists. The new structure will be used in a following set of patches  
>> to
>> > > implement SGX EPC cgroups.
>
> Although briefly mentioned in the first patch, it would be better to put  
> more
> background about the "reclaimable" and "non-reclaimable" thing here,  
> focusing on
> _why_ we need multiple LRUs (presumably you mean two lists: reclaimable  
> and non-
> reclaimable).
>
Sure I can add a little more background to introduce the  
reclaimable/unreclaimable concept. But why we need multiple LRUs would be  
self-evident in later patches, not sure I will add details here.

>> > >
>> > > The changes to the structure needed for unreclaimable lists will be
>> > > added in later patches.
>> > >
>> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> > > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> > > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> > > Cc: Sean Christopherson <seanjc@google.com>
>> > >
>> > > V3:
>> > > Removed the helper functions and revised commit messages
>
> Please put change history into:
>
> ---
>   change history
> ---
>
> So it can be stripped away when applying the patch.
>
Will do that.

>> > > ---
>> > >  arch/x86/kernel/cpu/sgx/sgx.h | 17 +++++++++++++++++
>> > >  1 file changed, 17 insertions(+)
>> > >
>> > > diff --git a/arch/x86/kernel/cpu/sgx/sgx.h
>> > > b/arch/x86/kernel/cpu/sgx/sgx.h
>> > > index f6e3c5810eef..77fceba73a25 100644
>> > > --- a/arch/x86/kernel/cpu/sgx/sgx.h
>> > > +++ b/arch/x86/kernel/cpu/sgx/sgx.h
>> > > @@ -92,6 +92,23 @@ static inline void *sgx_get_epc_virt_addr(struct
>> > > sgx_epc_page *page)
>> > >  	return section->virt_addr + index * PAGE_SIZE;
>> > >  }
>> > >
>> > > +/*
>> > > + * This data structure wraps a list of reclaimable EPC pages, and a
>> > > list of
>> > > + * non-reclaimable EPC pages and is used to implement a LRU policy
>> > > during
>> > > + * reclamation.
>> > > + */
>
> I'd prefer to not mention the "non-reclaimable" thing in this patch, but  
> defer
> to the one actually introduces the "non-reclaimable" list.  Actually, I  
> don't
> think we even need this comment, given you have this in the structure:
>
> 	struct list_head reclaimable;
>

Agreed.

> Which already explains the "reclaimable" list.  I suppose the  
> non-reclaimable
> list would be named similarly thus need no comment either.
>
> Also, I am wondering why you need to split this out as a separate  
> patch.  It
> basically does nothing.  To me you should just merge this to the next  
> patch,

I think Kristen splitted the original patch based on Dave's comments:

https://lore.kernel.org/all/e71d76b2-4368-4627-abd4-2163e6786a20@intel.com/

> which actually does what you claimed in the changelog:
>
> 	Introduce a data structure to wrap the existing reclaimable list and 
> 	its spinlock ...
>
> Then this can be an infrastructure change patch, which doesn't bring any
> functional change, to support the non-reclaimable list.
>
>
>> > > +struct sgx_epc_lru_lists {
>> > > +	/* Must acquire this lock to access */
>> > > +	spinlock_t lock;
>> >
>> > Isn't this self-explanatory, why the inline comment?
>>
>> I got a warning from the checkpatch script complaining this lock needs
>> comments.
>
> I suspected this, so I applied this patch, removed the comment,  
> generated a new
> patch, and run checkpatch.pl for it.  It didn't report any warning/error  
> in my
> testing.
>
> Are you sure you got a warning?

I did a reran and it's actually a "CHECK" I got:

$ ./scripts/checkpatch.pl --strict  
0001-x86-sgx-Add-struct-sgx_epc_lru_lists-to-encapsulate-.patch
CHECK: spinlock_t definition without comment
#41: FILE: arch/x86/kernel/cpu/sgx/sgx.h:101:
+       spinlock_t lock;

total: 0 errors, 0 warnings, 1 checks, 22 lines checked

Thanks
Haitao
