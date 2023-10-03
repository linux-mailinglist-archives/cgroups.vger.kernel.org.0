Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD757B604B
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 07:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjJCFPl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 01:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjJCFPj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 01:15:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E891AC;
        Mon,  2 Oct 2023 22:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696310137; x=1727846137;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Rr+uJqQ6WvwEed9XFw79kvCJrNfE7s7bvcwE1Gslxuk=;
  b=XzTHR3xrDuleEgXp769rxT4pxwMoUiBhHHbKzJM9fWvrXX1bUWnX7Orb
   VpxTakIa/haCLvRyO1DyYTrLO0NxIWSbmcmFOoa9udiyNnbi2jh0EWhNd
   llgP5+pyrBbh5KZtrPmcnvSSiiA3oMToIvDRyLDF3SHwMVzJNccO8dMQ5
   PKjUdtGcBGlYsG+B46aFaH9C3jv6EPQ9CVju6NlnzMlXdTQO+82LVGGOD
   57RR239g+YgW2Wt/cqGRjxY9mHjRQu+2r+yrQWqXSz+2qdEHzx5dnjALP
   AYg3DzeDID6tqNu0p7NvoM71ZefBBuHI7OjNU0zjcpW7HMoDsTCfaxg4O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382707105"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="382707105"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 22:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700568187"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="700568187"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Oct 2023 22:15:34 -0700
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
Subject: Re: [PATCH v5 11/18] x86/sgx: store unreclaimable pages in LRU lists
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-12-haitao.huang@linux.intel.com>
 <e36175f3fcf80929d97dbdf8cc144d30888ed301.camel@intel.com>
Date:   Tue, 03 Oct 2023 00:15:32 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b73j62kwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <e36175f3fcf80929d97dbdf8cc144d30888ed301.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 28 Sep 2023 04:41:33 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>> @@ -746,6 +746,7 @@ void sgx_encl_release(struct kref *ref)
>>  	xa_destroy(&encl->page_array);
>>
>>  	if (!encl->secs_child_cnt && encl->secs.epc_page) {
>> +		sgx_drop_epc_page(encl->secs.epc_page);
>>  		sgx_encl_free_epc_page(encl->secs.epc_page);
>>  		encl->secs.epc_page = NULL;
>>  	}
>
> The "record" of SECS/VA pages should be done together with this.  I see  
> no
> reason why the "record" and "drop" are separated into different patches.

"record" of SECS/VA pages are done in this patch. Before nothing done in  
"record" for them because no tracking LRU lists for them. Now they are  
tracked.

Thanks
Haitao
