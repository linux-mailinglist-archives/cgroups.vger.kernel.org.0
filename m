Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751C064100D
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiLBVgC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiLBVgB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:36:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC0EF8B0;
        Fri,  2 Dec 2022 13:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670016960; x=1701552960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jbDqvFAgp4MnB8B6YQ5sRiaoj/wEsc4ByhyQ4FcZagQ=;
  b=V57rmamKXdp95ydSpJ/UyI6ToOS3DFrg1O4Vwta/3Ev19FACW6+tdp4y
   bEbEq3wgrfzAzaeT3UgbbzNfDAdMhYGWy/BLNzOdn6dkIWiXF5Ob+fpFI
   99sJK7/QqgqaTp2CkXxoR33wbFeb1hsCMCfmW/XIX7KSWsaC8DKEPqU7k
   +ag0BpP9V52jpD3UvQbCqUvV046TWptD6PhpmkM3S3Pw7FZWVMFaQ2bqr
   L1LuVfNa9T+mnfO5QfIUQ5ZNMCiQHNv/Tn4SK6607lWtpOnQMaMkKIWlU
   LEkbadXKjA4z8/P3TO6Ydfz8ee3uv7Gri46cYOMh1RAn3bY3KWhACJ3zk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295744092"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295744092"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:36:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713767380"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713767380"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:35:58 -0800
Message-ID: <3a789b1c-4c70-158b-d764-daec141a5816@intel.com>
Date:   Fri, 2 Dec 2022 13:35:58 -0800
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221202183655.3767674-3-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> When allocating new Version Array (VA) pages, pass the struct sgx_encl
> of the enclave that is allocating the page. sgx_alloc_epc_page() will
> store this value in the encl_owner field of the struct sgx_epc_page. In
> a later patch, VA pages will be placed in an unreclaimable queue,
> and then when the cgroup max limit is reached and there are no more
> reclaimable pages and the enclave must be oom killed, all the
> VA pages associated with that enclave can be uncharged and freed.

What does this have to do with the 'encl' that is being passed, though?

In other words, why is this new sgx_epc_page-to-encl mapping needed for
VA pages now, but it wasn't before?
