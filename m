Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303847BA9FD
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjJETXy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjJETXx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 15:23:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2D98;
        Thu,  5 Oct 2023 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696533832; x=1728069832;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=u1S0DXXpS1RSMwy7Zw2lAhn+BzDfe+4Ay+Z5+dril2c=;
  b=M2QtOdYF1OpgjIp4t7NZ5TXhOVk8f6EZEScO4kzMHYhoWfaOSxjcAOuD
   wtyuK9mfKROrw79dsbj3SC3eZ0dOVc+374brxmLZqzJKCaZJZGlMXYqoI
   Idf99hwBNzeUI51abZfo85LWX0Vl1v3ITlH9yH/6dUZXXwt3wvtwqVN/j
   YR4rI7L4Pm5F3R24t7FpOScMsrENiSCHejBYCZ64Vi9cYFOqfseIFSuig
   4KCiIZAjlKZz35UQn0XUYuFTEtJ1I7dLb8VnwmBUUeaJMYKUL1RVvFLFZ
   yy8TvOXodVtVlZljjYsv+zgAtvsz22Yw4Z+ZaE4osPogBfHjs1uKYBG0/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2198307"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2198307"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895570087"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895570087"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Oct 2023 12:21:48 -0700
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
Subject: Re: [PATCH v5 13/18] x86/sgx: Expose sgx_reclaim_pages() for use by
 EPC cgroup
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-14-haitao.huang@linux.intel.com>
 <a03cf29a5ff35b9467470a0cd38e4096820eab8d.camel@intel.com>
Date:   Thu, 05 Oct 2023 14:23:15 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ccv41dwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <a03cf29a5ff35b9467470a0cd38e4096820eab8d.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 05 Oct 2023 07:24:12 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> Adjust and expose the top-level reclaim function as
>> sgx_reclaim_epc_pages() for use by the upcoming EPC cgroup, which will
>> initiate reclaim to enforce the max limit.
>>
>> Make these adjustments to the function signature.
>>
>> 1) To take a parameter that specifies the number of pages to scan for
>> reclaiming. Define a max value of 32, but scan 16 in the case for the
>> global reclaimer (ksgxd). The EPC cgroup will use it to specify a
>> desired number of pages to be reclaimed up to the max value of 32.
>>
>> 2) To take a flag to force reclaiming a page regardless of its age.  The
>> EPC cgroup will use the flag to enforce its limits by draining the
>> reclaimable lists before resorting to other measures, e.g. forcefully
>> kill enclaves.
>>
>> 3) Return the number of reclaimed pages. The EPC cgroup will use the
>> result to track reclaiming progress and escalate to a more forceful
>> reclaiming mode, e.g., calling this function with the flag to ignore age
>> of pages.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> ---
>> V4:
>> - Combined the 3 patches that made the individual changes to the
>> function signature.
>> - Removed 'high' limit in commit message.
>> ---
>>  arch/x86/kernel/cpu/sgx/main.c | 31 +++++++++++++++++++++----------
>>  arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
>>  2 files changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c  
>> b/arch/x86/kernel/cpu/sgx/main.c
>> index 3b875ab4dcd0..4e1a3e038db5 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -18,6 +18,11 @@
>>  #include "encl.h"
>>  #include "encls.h"
>>
>> +/*
>> + * Maximum number of pages to scan for reclaiming.
>> + */
>> +#define SGX_NR_TO_SCAN_MAX	32
>> +
>>  struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
>>  static int sgx_nr_epc_sections;
>>  static struct task_struct *ksgxd_tsk;
>> @@ -279,7 +284,11 @@ static void sgx_reclaimer_write(struct  
>> sgx_epc_page *epc_page,
>>  	mutex_unlock(&encl->lock);
>>  }
>>
>> -/*
>> +/**
>> + * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
>> + * @nr_to_scan:		 Number of EPC pages to scan for reclaim
>> + * @ignore_age:		 Reclaim a page even if it is young
>> + *
>>   * Take a fixed number of pages from the head of the active page pool  
>> and
>>   * reclaim them to the enclave's private shmem files. Skip the pages,  
>> which have
>>   * been accessed since the last scan. Move those pages to the tail of  
>> active
>> @@ -292,15 +301,14 @@ static void sgx_reclaimer_write(struct  
>> sgx_epc_page *epc_page,
>>   * problematic as it would increase the lock contention too much,  
>> which would
>>   * halt forward progress.
>>   */
>> -static void sgx_reclaim_pages(void)
>> +size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
>
> 'size_t' looks odd.  Any reason to use it?
>
> Given you only scan 32 at maximum, seems 'int' is good enough?
>

Initially was int.
Jarkko was suggesting ssize_t. I changed to size_t as this function will  
never return negative.

>>  {
>> -	struct sgx_backing backing[SGX_NR_TO_SCAN];
>> +	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
>>  	struct sgx_epc_page *epc_page, *tmp;
>>  	struct sgx_encl_page *encl_page;
>>  	pgoff_t page_index;
>>  	LIST_HEAD(iso);
>> -	int ret;
>> -	int i;
>> +	size_t ret, i;
>>
>>  	spin_lock(&sgx_global_lru.lock);
>>  	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
>
This should be nr_to_scan
It was missed during some rebase and reordering operations.

> The function comment says
>
> 	* @nr_to_scan:		 Number of EPC pages to scan for reclaim
>
> But I don't see it is even used, if my eye isn't deceiving me?
> 	
>> @@ -326,13 +334,14 @@ static void sgx_reclaim_pages(void)
>>  	spin_unlock(&sgx_global_lru.lock);
>>
>>  	if (list_empty(&iso))
>> -		return;
>> +		return 0;
>>
>>  	i = 0;
>>  	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>>  		encl_page = epc_page->encl_page;
>>
>> -		if (!sgx_reclaimer_age(epc_page))
>> +		if (i == SGX_NR_TO_SCAN_MAX ||
>
> i == nr_to_scan?
>
Not needed if above for statement fixed for nr_to_scan.
Anything above MAX will be skipped and put back to LRU.

> And should we have a
>
> 	if (nr_to_scan < SGX_NR_TO_SCAN_MAX)
> 		return 0;
>
> at the very beginning of this function?
>

  In final version caller to make sure not call with nr_to_scan not larger  
than SGX_NR_TO_SCAN_MAX

>> +		    (!ignore_age && !sgx_reclaimer_age(epc_page)))
>>  			goto skip;
>>
>>  		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
>> @@ -371,6 +380,8 @@ static void sgx_reclaim_pages(void)
>>
>>  		sgx_free_epc_page(epc_page);
>>  	}
>> +
>> +	return i;
>>  }
>>
>
> I found this function a little bit odd, given the mixing of 'nr_to_scan',
> SGX_NR_TO_SCAN and SGX_NR_TO_SCAN_MAX.
>
> From the changelog:
>
> 	1) To take a parameter that specifies the number of pages to scan for
> 	reclaiming. Define a max value of 32, but scan 16 in the case for the
> 	global reclaimer (ksgxd).
>
> It appears we want to make this function to scan @nr_to_scan for cgroup,  
> but
> still want to scan a fixed value for ksgxd, which is SGX_NR_TO_SCAN.  And
> @nr_to_scan can be larger than SGX_NR_TO_SCAN but smaller than
> SGX_NR_TO_SCAN_MAX.
>
> Putting behind the mystery of why above is needed, to achieve it, is it  
> more
> clear if we do below?
>
> int __sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age)
> {
> 	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
> 	...
>
> 	if (nr_to_scan > SGX_NR_TO_SCAN_MAX)
> 		return 0;

We could set nr_to_scan to MAX but since this is code internal to driver,  
maybe just make sure callers don't call with bigger numbers.

>
> 	for (i = 0; i < nr_to_scan; i++) {
> 		...
> 	}
>

yes

> 	return reclaimed;
> }
>
> /* This is for ksgxd() */
> int sgx_reclaim_epc_page(void)
> {
> 	return __sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
> }

Some maintainers may prefer no wrapping.

Thanks
Haitao
