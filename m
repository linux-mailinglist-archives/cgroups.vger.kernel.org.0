Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5F62AF6B
	for <lists+cgroups@lfdr.de>; Wed, 16 Nov 2022 00:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKOX2A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Nov 2022 18:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKOX1l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Nov 2022 18:27:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5027930;
        Tue, 15 Nov 2022 15:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99E486178B;
        Tue, 15 Nov 2022 23:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCEC433D6;
        Tue, 15 Nov 2022 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668554859;
        bh=w0ksqa3sKu6KJhhOKvS+AupK4IwA9FEjgKk5vq3U3tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ln62TKu1ZIyIpWsRg++DjRXNcsharCAUz2MPbVXfne17UYIAMd2VsEWpiBXA9JSk6
         DwkYJsdm7o/Mpkhs/qIORc2l2K8aCASLvO8Y3vj0GKj/u43/vBAMF6djiZyHlpMj6t
         uzEBNxpRawrlEQgHqbgXHNGqNa5TGNpPK9e4ebB1UJ2BGI/GfGIRsclEPsHXuaiioE
         W3tUFa2HYqeyi5MiO5A5aia8qN4s6YQRsX+F4vKT6b79+nFA1pkeZzh9uiXgs6P/hD
         jKQAws2PBDXK69U7h1GliXPXCwYI6Jt6u7uyIx5RllGmKm1rmLiHYrj4sPhtNewKja
         ojhWpBNjcu4cg==
Date:   Wed, 16 Nov 2022 01:27:35 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 01/26] x86/sgx: Call cond_resched() at the end of
 sgx_reclaim_pages()
Message-ID: <Y3QgZ+ZKAfJ92U5L@kernel.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-2-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-2-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:06AM -0800, Kristen Carlson Accardi wrote:
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
> +
>  static bool sgx_should_reclaim(unsigned long watermark)
>  {
>  	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
> @@ -378,12 +384,14 @@ static bool sgx_should_reclaim(unsigned long watermark)
>  /*
>   * sgx_reclaim_direct() should be called (without enclave's mutex held)
>   * in locations where SGX memory resources might be low and might be
> - * needed in order to make forward progress.
> + * needed in order to make forward progress. This call to
> + * __sgx_reclaim_pages() avoids the cond_resched() in sgx_reclaim_pages()
> + * to improve performance.
>   */
>  void sgx_reclaim_direct(void)
>  {
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_pages();
> +		__sgx_reclaim_pages();

Is it a big deal to have "extra" cond_resched?

>  }
>  
>  static int ksgxd(void *p)
> @@ -410,8 +418,6 @@ static int ksgxd(void *p)
>  
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
>  			sgx_reclaim_pages();
> -
> -		cond_resched();
>  	}
>  
>  	return 0;
> @@ -582,7 +588,6 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>  		}
>  
>  		sgx_reclaim_pages();
> -		cond_resched();
>  	}
>  
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -- 
> 2.37.3
> 

BR, Jarkko
