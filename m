Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F1C7B8328
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjJDPEc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjJDPEc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 11:04:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6EAB;
        Wed,  4 Oct 2023 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696431868; x=1727967868;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=w9qXX0lG9UXEFzEMBctWIq+Z4xPyn1NTnkqFrPnO+p4=;
  b=AhhpM3WijSQYYWfuOSKZ7WwDQQQomuBUBKRsYrzF0jXL2seZV9F0BvDp
   pdlltvqI2OvUcuvTMgvP8EWmSA7uscVTYq/4L6S0Ig873UatBIwdGVm97
   Td0veGBunO69Sh0w2meKDXMVu21BELsTEF3ZwMq6w+5PK1whbJSFJ3Fub
   bA2TrVin9OqZzGhRyYJXIvTr3/Ng2vnWV2bYczRN5Zk/SBPHmq/WB3zq0
   7MXcayEf3IewpQV/55Wos4gIEhhYNh3GTRC8P2K8ZjqssT5swmgdcY1su
   eUir0omIV53374a67W87Gcpvvvtpvy0aQd6RaJaorMR8m2Nc+QhhWLcZ3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363464222"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="363464222"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="754965012"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="754965012"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Oct 2023 08:03:52 -0700
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
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-10-haitao.huang@linux.intel.com>
 <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
 <op.2b77pp0wwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <0953e4fac90921ff53570e2e6ebd2689fc1cd8fa.camel@intel.com>
Date:   Wed, 04 Oct 2023 10:03:51 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2capgplewjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <0953e4fac90921ff53570e2e6ebd2689fc1cd8fa.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 03 Oct 2023 15:07:42 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Tue, 2023-10-03 at 01:45 -0500, Haitao Huang wrote:
>> >
>> > Btw, probably a dumb question:
>> >
>> > Theoretically if you only need to find a victim enclave you don't need 
>> > to put VA
>> > pages to the unreclaimable list, because those VA pages will be freed 
>> > anyway
>> > when enclave is killed.  So keeping VA pages in the list is for>  
>> accounting all
>> > the pages that the cgroup is having?
>>
>> Yes basically tracking them in cgroups as they are allocated.
>>
>> VAs and SECS may also come and go as swapping/unswapping happens. But  
>> if acgroup is OOM, and all reclaimables are gone (swapped out), it'd  
>> have toreclaim VAs/SECs in the same cgroup starting from the front of  
>> the LRUlist. To reclaim a VA/SECS, it identifies the enclave from the  
>> owner ofthe VA/SECS page and kills it, as killing enclave is the only  
>> way toreclaim VA/SECS pages.
>
> To kill enclave you just need to track SECS in  the unreclaimable list.  
> Only when you want to account the total EPC pages via some list you  
> _probably_
> need to track VA as well.  But I am not quite sure about this either.

There is a case where even SECS is paged out for an enclave with all  
reclaimables out. So cgroup needs to track each page used by an enclave  
and kill enclave when cgroup needs to lower usage by evicting an VA or  
SECS page.
There were some discussion on paging out VAs without killing enclaves but  
it'd be complicated and not implemented yet.

BTW, I need clarify tracking pages which is done by LRUs vs usage  
accounting which is done by charge/uncharge to misc. To me tracking is for  
reclaiming not accounting. Also vEPCs not tracked at all but they are  
accounted for.

Haitao
