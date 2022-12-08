Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5060A646C38
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 10:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLHJqz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 04:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLHJqe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 04:46:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481756E57B;
        Thu,  8 Dec 2022 01:46:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06FA5B82304;
        Thu,  8 Dec 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49650C433D6;
        Thu,  8 Dec 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670492790;
        bh=dpBeJVLLnt/wb7IR1Gd04VZ2UovV0cnf+pFYvVnTkNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaublSEi40KBKPk2OWsAjhjg4ekec+LxdJ+pqFwjmSC3bBAuRQA4IjFuEjWzjDCCK
         pjqQUIXjhphrgtZKoT+KSCgFIop8EKdQJqlZi4akY7Y2W/GhVX2EYu1iV/rWbuCFuK
         nqR9fMgIrVyn34c3R5sYkMe4Nb2Z/5YJTVmhrOUXuZqSR/XwpXx5JDO3G/LNKov2e9
         4SP9aFKp8l96zdcb5cYZdFQOBE0/IbLCss9So4ZsVt4EPTibKG8cmQzxNmgdXg549X
         d1N0HNr/yFzJgD8zVhSUByJoLHTaEu/iB2hzKMLy0TF3Pwd9jJ5b7GV+X8nCiSN9P6
         6ubn8NQOulBFQ==
Date:   Thu, 8 Dec 2022 09:46:26 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 12/18] x86/sgx: Expose sgx_reclaim_pages() for use by
 EPC cgroup
Message-ID: <Y5GyckFSARH9ANUt@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-13-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-13-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:48AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Expose the top-level reclaim function as sgx_reclaim_epc_pages() for use
> by the upcoming EPC cgroup, which will initiate reclaim to enforce
> changes to high/max limits.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 7 ++++---
>  arch/x86/kernel/cpu/sgx/sgx.h  | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 96399e2016a8..c947b4ae06f3 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -281,6 +281,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>  
>  /**
>   * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
> + * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
>   * @nr_to_scan:		 Number of EPC pages to scan for reclaim
>   * @ignore_age:		 Reclaim a page even if it is young
>   *
> @@ -385,7 +386,7 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
>  	return i;
>  }
>  
> -static int sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
> +int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age)
>  {
>  	int ret;
>  
> @@ -441,7 +442,7 @@ static int ksgxd(void *p)
>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
>  
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> -			sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
> +			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
>  	}
>  
>  	return 0;
> @@ -624,7 +625,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>  			break;
>  		}
>  
> -		sgx_reclaim_pages(SGX_NR_TO_SCAN, false);
> +		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
>  	}
>  
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index ec8d567cd975..ce859331ddf5 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -206,6 +206,7 @@ void sgx_reclaim_direct(void);
>  void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags);
>  int sgx_drop_epc_page(struct sgx_epc_page *page);
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
> +int sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age);
>  
>  void sgx_ipi_cb(void *info);
>  
> -- 
> 2.38.1
> 

Unless, there is a risk of name collision, I think this rename is
just adding unnecessary convolution to the patch set.

I would revert the rename part, and just export.

BR, Jarkko
