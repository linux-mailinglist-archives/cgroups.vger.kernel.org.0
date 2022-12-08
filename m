Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB4647307
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiLHPbC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 10:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiLHPaT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 10:30:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D9177214;
        Thu,  8 Dec 2022 07:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFCF3B8243F;
        Thu,  8 Dec 2022 15:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153CFC433D6;
        Thu,  8 Dec 2022 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670513415;
        bh=MelMEVFD640a+Eraf0URPWnvaMDa0Z6oybjpXa5D5hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnVQZOJ62CX0VOaw1PmcOWmOm6h1WUzKfs7ZdYqK8aLvSoxfI4Jrtq8pfmDee8Hzi
         0Q/JUMD3tmTUR2o1q+oZ6Hf6okuKoSxfhfi5G6BT1Aeuc+VriI3e2OQiPDIZoizxb7
         vmNgrxQbhlx0eiGj6ntm6SNXU+HoGZM5g63+673r6J+Wey6jlBWnd3HV7eYk0bezrS
         Ant79PyU7hTD3pArNOac4+OdT1cnZlChjYu0lTUqfrxgh7woFKxBxzhtHxIicPw+rQ
         wrxQn77s2306xmO0v9hZ5jO5qvg+2IOjhF7Ve4hh6nt6QLnV0gCfE4E0yH/T4wQ3nQ
         a5GN6FemD+TAg==
Date:   Thu, 8 Dec 2022 15:30:11 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 17/18] x86/sgx: Add support for misc cgroup controller
Message-ID: <Y5IDA3J/6pF0sNIP@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-18-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-18-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Perhaps "x86/sgx: Limit process EPC usage with misc cgroup controller"?

Or something more to the point than "add support".

On Fri, Dec 02, 2022 at 10:36:53AM -0800, Kristen Carlson Accardi wrote:
  
>  /**
> - * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
> + * __sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
>   * @nr_to_scan:		 Number of EPC pages to scan for reclaim
>   * @ignore_age:		 Reclaim a page even if it is young
> + * @epc_cg:		 EPC cgroup from which to reclaim
>   *
>   * Take a fixed number of pages from the head of the active page pool and
>   * reclaim them to the enclave's private shmem files. Skip the pages, which have
> @@ -336,7 +350,8 @@ void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, int *nr_to_scan,
>   * problematic as it would increase the lock contention too much, which would
>   * halt forward progress.
>   */
> -static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
> +static int __sgx_reclaim_epc_pages(int nr_to_scan, bool ignore_age,
> +			  struct sgx_epc_cgroup *epc_cg)
>  {
>  	struct sgx_backing backing[SGX_MAX_NR_TO_RECLAIM];
>  	struct sgx_epc_page *epc_page, *tmp;
> @@ -347,7 +362,15 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
>  	int i = 0;
>  	int ret;
>  
> -	sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
> +        /*
> +         * If a specific cgroup is not being targetted, take from the global
> +         * list first, even when cgroups are enabled.  If there are
> +         * pages on the global LRU then they should get reclaimed asap.
> +         */
> +        if (!IS_ENABLED(CONFIG_CGROUP_SGX_EPC) || !epc_cg)
> +                sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
> +
> +	sgx_epc_cgroup_isolate_pages(epc_cg, &nr_to_scan, &iso);
>  
>  	if (list_empty(&iso))
>  		return 0;
> @@ -397,25 +420,33 @@ static int __sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
>  				     SGX_EPC_PAGE_ENCLAVE |
>  				     SGX_EPC_PAGE_VERSION_ARRAY);
>  
> +		if (epc_page->epc_cg) {
> +			sgx_epc_cgroup_uncharge(epc_page->epc_cg);
> +			epc_page->epc_cg = NULL;
> +		}
> +
>  		sgx_free_epc_page(epc_page);
>  	}
>  	return i;
>  }

I would consider changes to sgx_reclaim_epc_pages() as a separate patch,
perhaps squashing with the patch that does the export. And generally
separate from this patch all internal arch/x86/kernel/cpu/sgx changes,
and leave only cgroup bindings.

BR, Jarkko
