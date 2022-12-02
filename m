Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295D26410BE
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiLBWhM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiLBWhM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:37:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF20B0DFC;
        Fri,  2 Dec 2022 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670020631; x=1701556631;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fDwnio0U3LHuhov+sUpgA5OaZfMyZJrWLLg1iX6CVrY=;
  b=DCaujLzmEmaes1iDYCqZKoknKhAaNQHNF7DsUv8LTAdbvBfmdJ1KJFXU
   5pKwxoiGeHwWTECxG6RDh4PF9VlWL8MKriJpE2BdmSeExmQHekPrvlC06
   YyPxxVGMs/FK6XT4op1I8zjmfYCdYj+mmP4RM48K0z4wC2XQLhihR63/w
   M9VeQEWQqH5Z4ZoNKWunxZp5EOevANx7QaSdyqJ+BVgLY0ERlyoZXavBd
   vFF7F6P7iNUUx8w9A6Zs0w5ZiShiMyo0/ZJSHQQXXc7nW9LohEHUbmB5q
   Iva1VY+KHM9TmrCWUiN4m2ijvLZYYSROFVMzlYczcJIU46fljm9VDZIx6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="402339708"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="402339708"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:37:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713785122"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713785122"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:37:10 -0800
Message-ID: <47799f29-8856-8c87-240b-0667f74a3be8@intel.com>
Date:   Fri, 2 Dec 2022 14:37:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 01/18] x86/sgx: Call cond_resched() at the end of
 sgx_reclaim_pages()
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-2-kristen@linux.intel.com>
 <37de083d-a63b-b2ff-d00a-e890a1ba5eea@intel.com>
 <da690a45a36038399c63ddac8f0efed9872ec13e.camel@linux.intel.com>
 <746adf31-e70c-e32d-a35d-72d352af613b@intel.com>
 <307b43aa5908c489913110287044e611f574db0a.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <307b43aa5908c489913110287044e611f574db0a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 14:17, Kristen Carlson Accardi wrote:
> On Fri, 2022-12-02 at 13:45 -0800, Dave Hansen wrote:
>> On 12/2/22 13:37, Kristen Carlson Accardi wrote:
>>>>> +static void sgx_reclaim_pages(void)
>>>>> +{
>>>>> +       __sgx_reclaim_pages();
>>>>> +       cond_resched();
>>>>> +}
>>>> Why bother with the wrapper?  Can't we just put cond_resched() in
>>>> the
>>>> existing sgx_reclaim_pages()?
>>> Because sgx_reclaim_direct() needs to call sgx_reclaim_pages()
>>> but not do the cond_resched(). It was this or add a boolean or
>>> something to let caller's opt out of the resched.
>>
>> Is there a reason sgx_reclaim_direct() *can't* or shouldn't call
>> cond_resched()?
> 
> Yes, it is due to performance concerns. It is explained most succinctly
> by Reinette here:
> 
> https://lore.kernel.org/linux-sgx/a4eb5ab0-bf83-17a4-8bc0-a90aaf438a8e@intel.com/

I think I'd much rather have 3 cond_resched()s in the code that
effectively self-document than one __something() in there that's a bit
of a mystery.

Everyone knows what cond_resched() means.
