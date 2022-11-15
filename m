Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2DF62AF6E
	for <lists+cgroups@lfdr.de>; Wed, 16 Nov 2022 00:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKOXbc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Nov 2022 18:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOXbb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Nov 2022 18:31:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0246549;
        Tue, 15 Nov 2022 15:31:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19FA7B81B89;
        Tue, 15 Nov 2022 23:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6249CC433D6;
        Tue, 15 Nov 2022 23:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668555087;
        bh=8hSFEfFc2rYU4y6JuixLrusmaPXNA/CwMC1ARhw96BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfOwB5CIlVBTg9sQigXECI7n5KcI25kdUheWvyHi3D+zD/JtR4AWcDs9wOiI3i0h0
         mRsn94x4zEw+zPMGdkFP7j14q2qdPFTG6YvCcpWzx/bxVppZSKQXFpWSYcUY5mv2NX
         f7JAnkh1R+bXV49JJFqZs5Yceyi5SMdlUonuhAKIGpQw1cVjpOVq9i+q76Y0Q5LoKy
         E6d8XXL4sdmn0VmrLFWEXUzmY1YPoVMY/1LOfHEhFeIW6fSmhGN9UkOS0D2Sky9f+E
         WoJI4qZEYsxvYyXfoAv6QEjarVN+yzGb6pnUQtSdfvwni244ssVexsxi3AIPsUtVhO
         2tjkH3YJgGMdg==
Date:   Wed, 16 Nov 2022 01:31:24 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 02/26] x86/sgx: Store struct sgx_encl when allocating new
 va pages
Message-ID: <Y3QhTDq/lu1X1/g5@kernel.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-3-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-3-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:07AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> When allocating new va pages, pass the struct sgx_encl of the enclave

"Version Array (VA) pages"

> that is allocating the page. sgx_alloc_epc_page() will store this
> value in the encl_owner field of the struct sgx_epc_page. In a later
> patch, version array pages will be placed in an unreclaimable queue,

"VA pages"

> and then when the cgroup max limit is reached and there are no more
> reclaimable pages and the enclave must be oom killed, all the
> va pages associated with that enclave can be uncharged and freed.

"VA pages"

> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  | 5 +++--
>  arch/x86/kernel/cpu/sgx/encl.h  | 2 +-
>  arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
>  arch/x86/kernel/cpu/sgx/sgx.h   | 2 ++
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index f40d64206ded..4eaf9d21e71b 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -1193,6 +1193,7 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
>  
>  /**
>   * sgx_alloc_va_page() - Allocate a Version Array (VA) page
> + * @encl:    The enclave that this page is allocated to.
>   * @reclaim: Reclaim EPC pages directly if none available. Enclave
>   *           mutex should not be held if this is set.
>   *
> @@ -1202,12 +1203,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
>   *   a VA page,
>   *   -errno otherwise
>   */
> -struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
> +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
>  {
>  	struct sgx_epc_page *epc_page;
>  	int ret;
>  
> -	epc_page = sgx_alloc_epc_page(NULL, reclaim);
> +	epc_page = sgx_alloc_epc_page(encl, reclaim);
>  	if (IS_ERR(epc_page))
>  		return ERR_CAST(epc_page);
>  
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index f94ff14c9486..831d63f80f5a 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -116,7 +116,7 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
>  					  unsigned long offset,
>  					  u64 secinfo_flags);
>  void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
> -struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
> +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim);
>  unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
>  void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
>  bool sgx_va_page_full(struct sgx_va_page *va_page);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index ebe79d60619f..9a1bb3c3211a 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
>  		if (!va_page)
>  			return ERR_PTR(-ENOMEM);
>  
> -		va_page->epc_page = sgx_alloc_va_page(reclaim);
> +		va_page->epc_page = sgx_alloc_va_page(encl, reclaim);
>  		if (IS_ERR(va_page->epc_page)) {
>  			err = ERR_CAST(va_page->epc_page);
>  			kfree(va_page);
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index d16a8baa28d4..efb10eacd3aa 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -39,6 +39,8 @@ struct sgx_epc_page {
>  		struct sgx_encl_page *encl_owner;
>  		/* Use when SGX_EPC_PAGE_KVM_GUEST set in ->flags: */
>  		void __user *vepc_vaddr;
> +

Spurious newline.

> +		struct sgx_encl *encl;
>  	};
>  	struct list_head list;
>  };
> -- 
> 2.37.3
> 

BR, Jarkko
