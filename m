Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96A87B60EF
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjJCGpX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 02:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGpX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 02:45:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F9EAD;
        Mon,  2 Oct 2023 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696315520; x=1727851520;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Em/FrrctLJh6Y71ZEU3Iwy2aMxZLwNO0KD4a2A0zeiA=;
  b=E+gY6P/U8hNxpiWJ7IA642pS4MxfH/W9KYyntGkUqlOHBMc4yWhArkW2
   a+1UDPGHtFFKkYgRxB6ssKv5rIMAQHfOzpyOl08ewDNSW3f1tSDNE201s
   06B3DplPeqACFV9XWy60YKQvbngzmjj8e+VaaLsxnirYd2qozVR9AYEQI
   l2n0hc6x7V5j5kk+XjeNOeW48HWUUR2MibaXuVzKrEiJZTvLCr0s2QCGA
   b4Imibkbchjm1dnGJirbG8/lpEtFnAANd5AB5L0X1lAjqD4XOzzSdPT2j
   d6wez/y3BYhQ/+HPIwy4tgAUH1QCs/EQNat400qMPxlTV4PyQX08D7spj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="469079236"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="469079236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754300404"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="754300404"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Oct 2023 23:45:17 -0700
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
 <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
Date:   Tue, 03 Oct 2023 01:45:15 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b77pp0wwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 27 Sep 2023 06:35:57 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> In a later patch, when a cgroup has exceeded the max capacity for EPC
>> pages, it may need to identify and OOM kill a less active enclave to
>> make room for other enclaves within the same group. Such a victim
>> enclave would have no active pages other than the unreclaimable Version
>> Array (VA) and SECS pages.
>
> What does "no active pages" mean?
>

EPC pages in use.

> A "less active enclave" doesn't necessarily mean it has "no active  
> pages"?
>

I'll rephrase the above sentences

>
>> Therefore, the cgroup needs examine its
> 			^
> 			needs to
>
>> unreclaimable page list, and finding an enclave given a SECS page or a
> 				^
> 				find
>
>> VA page. This will require a backpointer from a page to an enclave,
>> which is not available for VA pages.
>>
>> Because struct sgx_epc_page instances of VA pages are not owned by an
>> sgx_encl_page instance, mark their owner as sgx_encl: pass the struct
>> sgx_encl of the enclave allocating the VA page to sgx_alloc_epc_page(),
>> which will store this value in the owner field of the struct
>> sgx_epc_page.
>
> IMHO this paragraph is hard to understand and can be more concise:
>
> One VA page can be shared by multiple enclave pages thus cannot be  
> associated
> with any 'struct sgx_encl_page' instance.  Set the owner of VA page to  
> the
> enclave instead.
>
>

Agreed

>> In a later patch, VA pages will be placed in an
>> unreclaimable queue that can be examined by the cgroup to select the OOM
>> killed enclave.
>
> The code to "place the VA page to unreclaimable queue" has been done in  
> earlier
> patch ("x86/sgx: Introduce EPC page states").  Just the unreclaimable  
> list isn't
> introduced yet.  I think you should just introduce it first then you can  
> get rid
> of those "in a later patch" staff.
>

I hope I was able to clarify to you in other threads that VA pages are not  
placed in any queue/list until [PATCH v5 11/18] x86/sgx: store  
unreclaimable pages in LRU lists.

This patch is the first one to implement tracking for unreclaimable pages.  
I'll add that as a transition hint.

> And nit: please use "unreclaimable list" consistently (not queue).
>

Yes will do

>
> Btw, probably a dumb question:
>
> Theoretically if you only need to find a victim enclave you don't need  
> to put VA
> pages to the unreclaimable list, because those VA pages will be freed  
> anyway
> when enclave is killed.  So keeping VA pages in the list is for  
> accounting all
> the pages that the cgroup is having?

Yes basically tracking them in cgroups as they are allocated.

VAs and SECS may also come and go as swapping/unswapping happens. But if a  
cgroup is OOM, and all reclaimables are gone (swapped out), it'd have to  
reclaim VAs/SECs in the same cgroup starting from the front of the LRU  
list. To reclaim a VA/SECS, it identifies the enclave from the owner of  
the VA/SECS page and kills it, as killing enclave is the only way to  
reclaim VA/SECS pages.
