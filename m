Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F3641031
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiLBVsg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiLBVsf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:48:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BDEC089;
        Fri,  2 Dec 2022 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017714; x=1701553714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EDfBXWfAHYVtwU57hMCKCO16uMM3c78FeY5S9PDvlJ4=;
  b=nBHCTjZNwGgHAkuxZ7mFZGwruzY4bIZl2iBPjmSh77HsBpNSaoJPIV0u
   6D6U4Z8Sftjq7a1BySK7s9PfoPIEv7uzcQLLRyzUWel7s+rX1vJSG2fQE
   GqiYY1Ltrag1onaq1uZc2nuwhpQFOzcClnyDOAPEDyXegpq0U7LHmcPrc
   HmGUpijWhlcCmFZUD5bT1kdexPsBsnKJ6DGztXv/kyMrD2g6r2LLlzvuM
   Du32wsJssbjV/y7Z+IQasE9irR5RyvR+M9+Jh03KzNCDM6uP3YT1VmdrU
   ZyItSACFsJSaw4ZQMPsRnhrFh64/l3cUYQs/FbJZEd9GU076BfSC5bVsj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="303663264"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="303663264"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:48:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="638885159"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="638885159"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:48:33 -0800
Message-ID: <2015ae96-5459-1f82-596b-f46af08ef766@intel.com>
Date:   Fri, 2 Dec 2022 13:48:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 02/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-3-kristen@linux.intel.com>
 <3a789b1c-4c70-158b-d764-daec141a5816@intel.com>
 <abfc00a2ab1d97f8081c696f78e2d0ced23902b4.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <abfc00a2ab1d97f8081c696f78e2d0ced23902b4.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 13:40, Kristen Carlson Accardi wrote:
> On Fri, 2022-12-02 at 13:35 -0800, Dave Hansen wrote:
>> On 12/2/22 10:36, Kristen Carlson Accardi wrote:
>>> When allocating new Version Array (VA) pages, pass the struct
>>> sgx_encl
>>> of the enclave that is allocating the page. sgx_alloc_epc_page()
>>> will
>>> store this value in the encl_owner field of the struct
>>> sgx_epc_page. In
>>> a later patch, VA pages will be placed in an unreclaimable queue,
>>> and then when the cgroup max limit is reached and there are no more
>>> reclaimable pages and the enclave must be oom killed, all the
>>> VA pages associated with that enclave can be uncharged and freed.
>> What does this have to do with the 'encl' that is being passed,
>> though?
>>
>> In other words, why is this new sgx_epc_page-to-encl mapping needed
>> for
>> VA pages now, but it wasn't before?
> When we OOM kill an enclave, we want to get rid of all the associated
> VA pages too. Prior to this patch, there wasn't a way to easily get the
> VA pages associated with an enclave.

Given an enclave, we have encl->va_pages to look up all the VA pages.
Also, this patch's code allows you to go from a va page to an enclave.
That seems like it's going the other direction from what an OOM-kill
would need to do.
