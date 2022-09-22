Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83965E6E90
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIVVj6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 17:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiIVVjy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 17:39:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D229114033;
        Thu, 22 Sep 2022 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663882793; x=1695418793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LziEyfJawc4QSz0lLnm/mVQqdAi9KJUUSw7+yO6FQ2U=;
  b=gPEQfjxow2GpepwrV6myffF8g/dR0a5Tiq0MfkOjd9MFkC4qXLOEyVlN
   /FjXq//T+lmEElCfuY/4Moz5RWmq/NNu3DSPuu0k2m8cp6t8MOZSoBkVK
   hMorp2rznH5d8/EuNuMl9NdTwh4H6ivlZtT2VNk1wd5lEWnrt7vOgxQG8
   EqQx8OEzBDAA7zx1MFf3zLCXIOiBNDN0Z+eIsPo/i/tESidgGT8OrQiMI
   WbeiNWNSCW1jPtRZ0l/Zqk9xZr6NCQH9q+StD6cDZEXE9IYK2dPKghHJd
   AGUkZmWeEzdKncr6V1ETBzvwPCJPuZWDdWxy33ypfIMV7CF+DSr5pRU66
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287549742"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287549742"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:39:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762373094"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO [10.209.58.200]) ([10.209.58.200])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:39:52 -0700
Message-ID: <f2236b51-400a-b300-e818-297e45cc7b49@intel.com>
Date:   Thu, 22 Sep 2022 14:39:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 03/20] x86/sgx: Track owning enclave in VA EPC pages
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Sean Christopherson <seanjc@google.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-4-kristen@linux.intel.com>
 <1adb03c8-1274-3898-0677-03015a1f5a5d@intel.com>
 <f031ac1bd6b16509f1d714cd65e6b017f054940c.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <f031ac1bd6b16509f1d714cd65e6b017f054940c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/22/22 13:04, Kristen Carlson Accardi wrote:
>> BTW, is there a flag or any other way to tell to what kind of object
>> ->owner points?
> The owner will only be an sgx_encl type if it is a va page, so to tell
> what kind of object owner is, you look at the epc page flags - like
> this:
>         if (epc_page->flags & SGX_EPC_PAGE_ENCLAVE)
>                 encl = ((struct sgx_encl_page *)epc_page->owner)->encl;
>         else if (epc_page->flags & SGX_EPC_PAGE_VERSION_ARRAY)
>                 encl = epc_page->owner;
> ...

I don't know how much refactoring it would take, but it would be nice if
that was a bit more obvious.  Basically, can we get the code that checks
for or sets SGX_EPC_PAGE_VERSION_ARRAY close to the code that assigns or
reads ->owner?
