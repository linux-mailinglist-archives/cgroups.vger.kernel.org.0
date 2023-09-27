Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E820D7B0854
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjI0Pfa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjI0Pf3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 11:35:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB3192;
        Wed, 27 Sep 2023 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695828928; x=1727364928;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=8QSD0wD8cLSsvCvzs8DbCnWU+wjcfau6s4KUAC2usv4=;
  b=QYcSNotmDcpFnJxJ1ruEK3h78UVdOJJ7JmfyGkWDMROlB+hzP5+yNtsb
   RDWnC8iqA8OPN33tn6AeDpZ/gNWpDuOr22GF7Ec6dbnRluqxYOMIAUCb2
   ulnFqoVlzH3/4QiTvcQytXCf3PNAK9RxyFY5g66SmmmeHCDpT7zPY1aHk
   raw51FQHuKnpo4gOV7HY53ME6Kda+KqTYuSt0AkHLV6TL9T3eifmtDJRC
   nRJX6r/8pz/w1oH6naiC1CyRUleAqsTNXqX0Xtik2FlO7JIUQ2+2w/SGT
   WEddOdsHXtXnx0kqU3hMpc6TB0fJV91qndDY3rkmRYeMRUjODmZktCXgU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="445989627"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="445989627"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 08:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="742752632"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="742752632"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 27 Sep 2023 08:35:25 -0700
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
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-10-haitao.huang@linux.intel.com>
 <46fecb95ae2c4cd156ad7bda99522214fcfe5774.camel@intel.com>
Date:   Wed, 27 Sep 2023 10:35:24 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2bxr9aj7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <46fecb95ae2c4cd156ad7bda99522214fcfe5774.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Kai,

On Wed, 27 Sep 2023 06:14:20 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> In a later patch, when a cgroup has exceeded the max capacity for EPC
>> pages, it may need to identify and OOM kill a less active enclave to
>> make room for other enclaves within the same group. Such a victim
>> enclave would have no active pages other than the unreclaimable Version
>> Array (VA) and SECS pages.  Therefore, the cgroup needs examine its
>> unreclaimable page list, and finding an enclave given a SECS page or a
>> VA page. This will require a backpointer from a page to an enclave,
>> which is not available for VA pages.
>>
>> Because struct sgx_epc_page instances of VA pages are not owned by an
>> sgx_encl_page instance, mark their owner as sgx_encl: pass the struct
>> sgx_encl of the enclave allocating the VA page to sgx_alloc_epc_page(),
>> which will store this value in the owner field of the struct
>> sgx_epc_page.  In a later patch, VA pages will be placed in an
>> unreclaimable queue that can be examined by the cgroup to select the OOM
>> killed enclave.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>>
>
> [...]
>
>> @@ -562,7 +562,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, bool reclaim)
>>  	for ( ; ; ) {
>>  		page = __sgx_alloc_epc_page();
>>  		if (!IS_ERR(page)) {
>> -			page->owner = owner;
>> +			page->encl_page = owner;
>
> Looks using 'encl_page' is arbitrary.
>
> Also actually for virtual EPC page the owner is set to the 'sgx_vepc'  
> instance.
>
>>  			break;
>>  		}
>>
>> @@ -607,7 +607,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>>
>>  	spin_lock(&node->lock);
>>
>> -	page->owner = NULL;
>> +	page->encl_page = NULL;
>
> Ditto.
>
>>  	if (page->poison)
>>  		list_add(&page->list, &node->sgx_poison_page_list);
>>  	else
>> @@ -642,7 +642,7 @@ static bool __init sgx_setup_epc_section(u64  
>> phys_addr, u64 size,
>>  	for (i = 0; i < nr_pages; i++) {
>>  		section->pages[i].section = index;
>>  		section->pages[i].flags = 0;
>> -		section->pages[i].owner = NULL;
>> +		section->pages[i].encl_page = NULL;
>>  		section->pages[i].poison = 0;
>>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>>  	}
>> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h  
>> b/arch/x86/kernel/cpu/sgx/sgx.h
>> index 764cec23f4e5..5110dd433b80 100644
>> --- a/arch/x86/kernel/cpu/sgx/sgx.h
>> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
>> @@ -68,7 +68,12 @@ struct sgx_epc_page {
>>  	unsigned int section;
>>  	u16 flags;
>>  	u16 poison;
>> -	struct sgx_encl_page *owner;
>> +
>> +	/* Possible owner types */
>> +	union {
>> +		struct sgx_encl_page *encl_page;
>> +		struct sgx_encl *encl;
>> +	};
>
> Sadly for virtual EPC page the owner is set to the 'sgx_vepc' instance it
> belongs to.
>
> Given how sgx_{alloc|free}_epc_page() arbitrarily uses encl_page,  
> perhaps we
> should do below?
>
> 	union {
> 		struct sgx_encl_page *encl_page;
> 		struct sgx_encl *encl;
> 		struct sgx_vepc *vepc;
> 		void *owner;
> 	};
>
> And in sgx_{alloc|free}_epc_page() we can use 'owner' instead.
>

As I mentioned in cover letter and change log in 11/18, this series does  
not track virtual EPC.
We can add vepc field into the union in future if such tracking is needed.  
Don't think "void *owner" is needed though.

Thanks
Haitao
