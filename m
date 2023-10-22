Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932A7D254C
	for <lists+cgroups@lfdr.de>; Sun, 22 Oct 2023 20:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJVS0c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 Oct 2023 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVS0b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 Oct 2023 14:26:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEEF9B;
        Sun, 22 Oct 2023 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697999189; x=1729535189;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=eTsWqBWafCdXTNGag5ZT8TNA45C1EOwV8XDQKPm082Y=;
  b=X+OxnZ4fblnY3bGt7s8tbgKGq7pqltyj4R5DrOy/oUi86WBjnpzQabWA
   q3yqQf4KryctCV9qhUwpUAyFdlUXnvYwXQLokBu8qFx3b5mUeMsckY8W3
   dOMiPdMLGZoZfG/zntE3Cq+Jp0jSInQH9iIYwfsiPI5RY1/iPG7FGxjB1
   /uuMOTuzWK7J6n29awaS0U+SHZnAmlQVb9E5rCI3pKtRL80AxUy5D85wZ
   5FccUfOuZKw8GYjYlL0WYZZiqewqoFQpy+98ZFenDCIxDQI76ahRSCr8b
   qV3l5GrzntWdL/Bjf9OSUGC/KM7GecNS5Fsj/pJH2W+Bd/U3sdRmOst36
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="385605817"
X-IronPort-AV: E=Sophos;i="6.03,243,1694761200"; 
   d="scan'208";a="385605817"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 11:26:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="792900835"
X-IronPort-AV: E=Sophos;i="6.03,243,1694761200"; 
   d="scan'208";a="792900835"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.93.48.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Oct 2023 11:26:21 -0700
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
Subject: Re: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-17-haitao.huang@linux.intel.com>
 <0005a998dab64c182c22abc436cbcd36de4240a1.camel@intel.com>
Date:   Sun, 22 Oct 2023 13:26:19 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2c8at5ggwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <0005a998dab64c182c22abc436cbcd36de4240a1.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 09 Oct 2023 19:26:01 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> @@ -332,6 +336,7 @@ void sgx_isolate_epc_pages(struct sgx_epc_lru_lists  
>> *lru, size_t nr_to_scan,
>>   * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
>>   * @nr_to_scan:		 Number of EPC pages to scan for reclaim
>>   * @ignore_age:		 Reclaim a page even if it is young
>> + * @epc_cg:		 EPC cgroup from which to reclaim
>>   *
>>   * Take a fixed number of pages from the head of the active page pool  
>> and
>>   * reclaim them to the enclave's private shmem files. Skip the pages,  
>> which have
>> @@ -345,7 +350,8 @@ void sgx_isolate_epc_pages(struct sgx_epc_lru_lists  
>> *lru, size_t nr_to_scan,
>>   * problematic as it would increase the lock contention too much,  
>> which would
>>   * halt forward progress.
>>   */
>> -size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
>> +size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age,
>> +			     struct sgx_epc_cgroup *epc_cg)
>>  {
>>  	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
>>  	struct sgx_epc_page *epc_page, *tmp;
>> @@ -355,7 +361,15 @@ size_t sgx_reclaim_epc_pages(size_t nr_to_scan,  
>> bool ignore_age)
>>  	LIST_HEAD(iso);
>>  	size_t ret, i;
>>
>> -	sgx_isolate_epc_pages(&sgx_global_lru, nr_to_scan, &iso);
>> +	/*
>> +	 * If a specific cgroup is not being targeted, take from the global
>> +	 * list first, even when cgroups are enabled.  If there are
>> +	 * pages on the global LRU then they should get reclaimed asap.
>> +	 */

This is probably some obsolete comments I should have removed. When cgroup  
is enabled, reclaimables will be always in a cgroup, the root by default.  
(!epc_cg) condition is harmless but not needed because the global list  
will be empty if cgroup is enabled.

>> +	if (!IS_ENABLED(CONFIG_CGROUP_SGX_EPC) || !epc_cg)
>> +		sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
>> +
>> +	sgx_epc_cgroup_isolate_pages(epc_cg, &nr_to_scan, &iso);
>

So it should have been:

+	if (!IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
+	else
+		sgx_epc_cgroup_isolate_pages(epc_cg, &nr_to_scan, &iso);

Or just encapsulate the difference in  sgx_epc_cgroup_isolate_pages

> (I wish such code can be somehow moved to the earlier patches, so that  
> we can
> get early idea that how sgx_reclaim_epc_pages() is supposed to be used.)
>

I'll will try to restructure and split this patch. Now that we are not  
going to deal with unreclaimable, it'd be simpler and also easier to  
restructure.

> So here when we are not targeting a specific EPC cgroup, we always  
> reclaim from
> the global list first, ...
>
> [...]
>
>>
>>  	if (list_empty(&iso))
>>  		return 0;
>> @@ -423,7 +437,7 @@ static bool sgx_should_reclaim(unsigned long  
>> watermark)
>>  void sgx_reclaim_direct(void)
>>  {
>>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>> -		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
>> +		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
>
> ... and we always try to reclaim the global list first when directly  
> reclaim is
> desired, even the enclave is within some EPC cgroup.  ...
>
>>  }
>>
>>  static int ksgxd(void *p)
>> @@ -446,7 +460,7 @@ static int ksgxd(void *p)
>>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
>>
>>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
>> -			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
>> +			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
>
> ... and in ksgxd() as well, which I guess is somehow acceptable.  ...
>
>>
>>  		cond_resched();
>>  	}
>> @@ -600,6 +614,11 @@ int sgx_drop_epc_page(struct sgx_epc_page *page)
>>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>>  {
>>  	struct sgx_epc_page *page;
>> +	struct sgx_epc_cgroup *epc_cg;
>> +
>> +	epc_cg = sgx_epc_cgroup_try_charge(reclaim);
>> +	if (IS_ERR(epc_cg))
>> +		return ERR_CAST(epc_cg);

I think I need add comments to clarify after this point is the global  
reclaimer only to keep the global free page water mark satisfied. So all  
reclaiming is from the root if cgroup is enabled, otherwise from the  
global LRU (no change from current implementation).

>>
>>  	for ( ; ; ) {
>>  		page = __sgx_alloc_epc_page();
>> @@ -608,8 +627,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, bool reclaim)
>>  			break;
>>  		}
>>
>> -		if (!sgx_can_reclaim())
>> -			return ERR_PTR(-ENOMEM);
>> +		if (!sgx_can_reclaim()) {
>> +			page = ERR_PTR(-ENOMEM);
>> +			break;
>> +		}
>>
>>  		if (!reclaim) {
>>  			page = ERR_PTR(-EBUSY);
>> @@ -621,10 +642,17 @@ struct sgx_epc_page *sgx_alloc_epc_page(void  
>> *owner, bool reclaim)
>>  			break;
>>  		}
>>
>> -		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
>> +		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
>
> ... and when an EPC page is allocated, no matter whether the EPC page  
> belongs to
> any cgroup or not.
>
> When we are allocating EPC page for one enclave, if that enclave belongs  
> to some
> cgroup, is it more reasonable to reclaim EPC pages from it's own group  
> (and the
> children under it)?
>
> You already got the current EPC cgroup at the beginning of  
> sgx_alloc_epc_page()
> when you want to charge the EPC allocation.
>
>>  		cond_resched();
>>  	}
>>

I hope the above comments make it clear that all these calls on  
sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL) are to reclaim from the  
global list if cgroup is not enabled, or from the root if cgroup is  
enabled.

Thanks
Haitao
