Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E610E62AF7A
	for <lists+cgroups@lfdr.de>; Wed, 16 Nov 2022 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKOXfn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Nov 2022 18:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKOXfk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Nov 2022 18:35:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122F26566;
        Tue, 15 Nov 2022 15:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E33617E5;
        Tue, 15 Nov 2022 23:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A439C433D6;
        Tue, 15 Nov 2022 23:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668555338;
        bh=BeXcJcfxfltBNVeK9BvieESWunY4ZA4BfeuU/Gm3ojA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDINeV5tTLhVFKYxq3PvKs9BwcrtER7d8bFHl+pvu9SwfN7eP93QDnARs97cMkp3/
         KjBO9f9sW8fNozBNBUJ97r4AMNFrm1K4IwU2vrOq8sengNbNLzmGZfvYQn9gwD8fKE
         n7oJiueDCrKGDPnBVa0NOtjZGEXAgiAukV3QOCDYIV0z/fWXukQ8wYhpI/5T77gdCi
         V51M5CCe/1pXawsZNm9957TDBkPlV3W81kg3wgT3Xj+0pz2+8MtATqC+ZP0wdONeIX
         qTu+UqcFAn60ccIOERNsMmq1NwSlLsExqehC3Z3PfTtS5HIWdQYNqxZVb3uHCSFIla
         g38gFA8FHWLlA==
Date:   Wed, 16 Nov 2022 01:35:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 03/26] x86/sgx: Add 'struct sgx_epc_lru' to encapsulate
 lru list(s)
Message-ID: <Y3QiRlwmg2YZmqLQ@kernel.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-4-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-4-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:08AM -0800, Kristen Carlson Accardi wrote:
> Introduce a data structure to wrap the existing reclaimable list
> and its spinlock in a struct to minimize the code changes needed
> to handle multiple LRUs as well as reclaimable and non-reclaimable
> lists, both of which will be introduced and used by SGX EPC cgroups.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/sgx.h | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index efb10eacd3aa..aac7d4feb0fa 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -91,6 +91,51 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
>  	return section->virt_addr + index * PAGE_SIZE;
>  }
>  
> +struct sgx_epc_lru {

It's not an LRU. It's a data structure containing two LRU's.

Please rename and add a descriptive comment.

> +	spinlock_t lock;
> +	struct list_head reclaimable;
> +	struct list_head unreclaimable;
> +};
> +
> +static inline void sgx_lru_init(struct sgx_epc_lru *lru)
> +{
> +	spin_lock_init(&lru->lock);
> +	INIT_LIST_HEAD(&lru->reclaimable);
> +	INIT_LIST_HEAD(&lru->unreclaimable);
> +}
> +
> +/*
> + * Must be called with queue lock acquired
> + */
> +static inline void __sgx_epc_page_list_push(struct list_head *list, struct sgx_epc_page *page)
> +{
> +	list_add_tail(&page->list, list);
> +}
> +
> +/*
> + * Must be called with queue lock acquired
> + */
> +static inline struct sgx_epc_page * __sgx_epc_page_list_pop(struct list_head *list)
> +{
> +	struct sgx_epc_page *epc_page;
> +
> +	if (list_empty(list))
> +		return NULL;
> +
> +	epc_page = list_first_entry(list, struct sgx_epc_page, list);
> +	list_del_init(&epc_page->list);
> +	return epc_page;
> +}
> +
> +#define sgx_epc_pop_reclaimable(lru) \
> +	__sgx_epc_page_list_pop(&(lru)->reclaimable)
> +#define sgx_epc_push_reclaimable(lru, page) \
> +	__sgx_epc_page_list_push(&(lru)->reclaimable, page)
> +#define sgx_epc_pop_unreclaimable(lru) \
> +	__sgx_epc_page_list_pop(&(lru)->unreclaimable)
> +#define sgx_epc_push_unreclaimable(lru, page) \
> +	__sgx_epc_page_list_push(&(lru)->unreclaimable, page)

Is there any reason not to declare these as inline functions?

> +
>  struct sgx_epc_page *__sgx_alloc_epc_page(void);
>  void sgx_free_epc_page(struct sgx_epc_page *page);
>  
> -- 
> 2.37.3
> 

BR, Jarkko
