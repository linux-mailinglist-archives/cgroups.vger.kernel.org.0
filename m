Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C655E7BA8
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIWNUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIWNUh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 09:20:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E3AA4F2;
        Fri, 23 Sep 2022 06:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04C03CE1FB0;
        Fri, 23 Sep 2022 13:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FB4C433C1;
        Fri, 23 Sep 2022 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663939232;
        bh=m4s+ej4u+QgeEBi8DIicKwr72CdU2CLBWzQKqu6vTOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAdQxdtOfPEbrimwRWe/Axk+8c9SVxUTqdQsyEbKt31vj9nH26Zavq9Mc5h5yRbd6
         291RhwDEBQI41nlFTmBtVgVCHgzdewQPaDfRDJTE+460ZDVpK5fr4UXhzKrf6SfHwb
         ssYSiHb5HpAW18JeD/5+im3tmLN5fso7zdt7skJJhCFdMF/+MIbvRRH5nndB8t8INa
         IQfHw3uyl1Geib2tZBNWTKI9ARQWLndTawFVHLqk1xF3giVfWbTFyN8oZPLPRY/v07
         KNNg/5ZyZxmT+tWzyq4nYJBufxIS+0Wuo9wK+l+kANMjPQJ6bs8wHlpVpy/zVoSOtg
         wPUX+yd6FCKoQ==
Date:   Fri, 23 Sep 2022 16:20:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC PATCH 04/20] x86/sgx: Add 'struct sgx_epc_lru' to
 encapsulate lru list(s)
Message-ID: <Yy2ynLZ2KX6bOcHr@kernel.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-5-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922171057.1236139-5-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 22, 2022 at 10:10:41AM -0700, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Wrap the existing reclaimable list and its spinlock in a struct to
> minimize the code changes needed to handle multiple LRUs as well as
> reclaimable and non-reclaimable lists, both of which will be introduced
> and used by SGX EPC cgroups.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

The commit message could explicitly state the added data type.

The data type is not LRU: together with the LIFO list, i.e.
a queue, the code implements LRU alike policy.

I would name the data type as sgx_epc_queue because it is a 
less confusing name.

> ---
>  arch/x86/kernel/cpu/sgx/main.c | 37 +++++++++++++++++-----------------
>  arch/x86/kernel/cpu/sgx/sgx.h  | 11 ++++++++++
>  2 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 4cdeb915dc86..af68dc1c677b 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -26,10 +26,9 @@ static DEFINE_XARRAY(sgx_epc_address_space);
>  
>  /*
>   * These variables are part of the state of the reclaimer, and must be accessed
> - * with sgx_reclaimer_lock acquired.
> + * with sgx_global_lru.lock acquired.
>   */
> -static LIST_HEAD(sgx_active_page_list);
> -static DEFINE_SPINLOCK(sgx_reclaimer_lock);
> +static struct sgx_epc_lru sgx_global_lru;
>  
>  static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
>  
> @@ -298,12 +297,12 @@ static void sgx_reclaim_pages(void)
>  	int ret;
>  	int i;
>  
> -	spin_lock(&sgx_reclaimer_lock);
> +	spin_lock(&sgx_global_lru.lock);
>  	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
> -		if (list_empty(&sgx_active_page_list))
> +		if (list_empty(&sgx_global_lru.reclaimable))
>  			break;
>  
> -		epc_page = list_first_entry(&sgx_active_page_list,
> +		epc_page = list_first_entry(&sgx_global_lru.reclaimable,
>  					    struct sgx_epc_page, list);
>  		list_del_init(&epc_page->list);
>  		encl_page = epc_page->owner;
> @@ -316,7 +315,7 @@ static void sgx_reclaim_pages(void)
>  			 */
>  			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_reclaimer_lock);
> +	spin_unlock(&sgx_global_lru.lock);
>  
>  	for (i = 0; i < cnt; i++) {
>  		epc_page = chunk[i];
> @@ -339,9 +338,9 @@ static void sgx_reclaim_pages(void)
>  		continue;
>  
>  skip:
> -		spin_lock(&sgx_reclaimer_lock);
> -		list_add_tail(&epc_page->list, &sgx_active_page_list);
> -		spin_unlock(&sgx_reclaimer_lock);
> +		spin_lock(&sgx_global_lru.lock);
> +		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
> +		spin_unlock(&sgx_global_lru.lock);
>  
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
>  
> @@ -374,7 +373,7 @@ static void sgx_reclaim_pages(void)
>  static bool sgx_should_reclaim(unsigned long watermark)
>  {
>  	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
> -	       !list_empty(&sgx_active_page_list);
> +	       !list_empty(&sgx_global_lru.reclaimable);
>  }
>  
>  /*
> @@ -427,6 +426,8 @@ static bool __init sgx_page_reclaimer_init(void)
>  
>  	ksgxd_tsk = tsk;
>  
> +	sgx_lru_init(&sgx_global_lru);
> +
>  	return true;
>  }
>  
> @@ -502,10 +503,10 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>   */
>  void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
>  {
> -	spin_lock(&sgx_reclaimer_lock);
> +	spin_lock(&sgx_global_lru.lock);
>  	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
> -	list_add_tail(&page->list, &sgx_active_page_list);
> -	spin_unlock(&sgx_reclaimer_lock);
> +	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
> +	spin_unlock(&sgx_global_lru.lock);
>  }
>  
>  /**
> @@ -520,18 +521,18 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
>   */
>  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
>  {
> -	spin_lock(&sgx_reclaimer_lock);
> +	spin_lock(&sgx_global_lru.lock);
>  	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
>  		/* The page is being reclaimed. */
>  		if (list_empty(&page->list)) {
> -			spin_unlock(&sgx_reclaimer_lock);
> +			spin_unlock(&sgx_global_lru.lock);
>  			return -EBUSY;
>  		}
>  
>  		list_del(&page->list);
>  		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_reclaimer_lock);
> +	spin_unlock(&sgx_global_lru.lock);
>  
>  	return 0;
>  }
> @@ -564,7 +565,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>  			break;
>  		}
>  
> -		if (list_empty(&sgx_active_page_list))
> +		if (list_empty(&sgx_global_lru.reclaimable))
>  			return ERR_PTR(-ENOMEM);
>  
>  		if (!reclaim) {
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index 5a7e858a8f98..7b208ee8eb45 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -83,6 +83,17 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
>  	return section->virt_addr + index * PAGE_SIZE;
>  }
>  
> +struct sgx_epc_lru {
> +	spinlock_t lock;
> +	struct list_head reclaimable;

s/reclaimable/list/

> +};
> +
> +static inline void sgx_lru_init(struct sgx_epc_lru *lru)
> +{
> +	spin_lock_init(&lru->lock);
> +	INIT_LIST_HEAD(&lru->reclaimable);
> +}
> +
>  struct sgx_epc_page *__sgx_alloc_epc_page(void);
>  void sgx_free_epc_page(struct sgx_epc_page *page);
>  
> -- 
> 2.37.3
> 

Please also add these:

/*
 * Must be called with queue->lock acquired.
 */
static inline struct sgx_epc_page *__sgx_epc_queue_push(struct sgx_epc_queue *queue,
                                                        struct sgx_page *page)
{
        list_add_tail(&page->list, &queue->list);
}

/*
 * Must be called with queue->lock acquired.
 */
static inline struct sgx_epc_page *__sgx_epc_queue_pop(struct sgx_epc_queue *queue)
{
        struct sgx_epc_page *page;

        if (list_empty(&queue->list)
                return NULL;

	page = list_first_entry(&queue->list, struct sgx_epc_page, list);
  	list_del_init(&page->list);

        return page;
}

And use them in existing sites. It ensures coherent behavior. You should be
able to replace all uses with either, or combination of them (list_move).

BR, Jarkko
