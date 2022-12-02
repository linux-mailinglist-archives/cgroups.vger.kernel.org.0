Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255D964100B
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiLBVd1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiLBVdZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:33:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD27EF88F;
        Fri,  2 Dec 2022 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670016805; x=1701552805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HPqLdDybmZPcnhCw3eM3MCT0TLoOmh7Opn14IuT92aU=;
  b=ETWSnJPTOjljH/AP/Vth+YIoHhxED1thu4gVbM2nn7N7la9689YyWcM9
   vRfzWBjCUfw37XAS5VpArVHCbXOFms+E/yuSpId2dWCVdKq7tiO8HhdVs
   +sgn/2VwGUBCZsnfYmtLMttgEw2+pxRa3n39YY9NunWUUq2Es3+K8TDmH
   0vSNgLa7BeMMpIPW5/74896/HYVZf3lrNJ0cgvcKYXz6NzM4j82eO9Py6
   0XNz73KVc7UVmYMiQfl73LBvCeqMkBMIjS+yKuIUPJ2U8L3cI3aM11F4H
   JoNiLj2wnbxnaIPT3ff0zKO6R6hJ1iTJ32e1DirZVBZd8Mz8//yqpnbJD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="316075535"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="316075535"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:33:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="974059125"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="974059125"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:33:23 -0800
Message-ID: <37de083d-a63b-b2ff-d00a-e890a1ba5eea@intel.com>
Date:   Fri, 2 Dec 2022 13:33:22 -0800
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221202183655.3767674-2-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> In order to avoid repetition of cond_resched() in ksgxd() and
> sgx_alloc_epc_page(), move the invocation of post-reclaim cond_resched()
> inside sgx_reclaim_pages(). Except in the case of sgx_reclaim_direct(),
> sgx_reclaim_pages() is always called in a loop and is always followed
> by a call to cond_resched().  This will hold true for the EPC cgroup
> as well, which adds even more calls to sgx_reclaim_pages() and thus
> cond_resched(). Calls to sgx_reclaim_direct() may be performance
> sensitive. Allow sgx_reclaim_direct() to avoid the cond_resched()
> call by moving the original sgx_reclaim_pages() call to
> __sgx_reclaim_pages() and then have sgx_reclaim_pages() become a
> wrapper around that call with a cond_resched().
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 160c8dbee0ab..ffce6fc70a1f 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -287,7 +287,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>   * problematic as it would increase the lock contention too much, which would
>   * halt forward progress.
>   */
> -static void sgx_reclaim_pages(void)
> +static void __sgx_reclaim_pages(void)
>  {
>  	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
> @@ -369,6 +369,12 @@ static void sgx_reclaim_pages(void)
>  	}
>  }
>  
> +static void sgx_reclaim_pages(void)
> +{
> +	__sgx_reclaim_pages();
> +	cond_resched();
> +}

Why bother with the wrapper?  Can't we just put cond_resched() in the
existing sgx_reclaim_pages()?
