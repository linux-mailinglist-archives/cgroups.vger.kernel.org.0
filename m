Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D850E64109D
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiLBWdU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLBWdT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:33:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F8B0DE9;
        Fri,  2 Dec 2022 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670020398; x=1701556398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z33WS50j4W0opGm2OStcoAuSsuunBLrFJHCbFEGkMfw=;
  b=bGc3IeV4H5nia8dxobHJrpxen+aM6Ic+45LZbOKaXdE/XYrJuykDsIoD
   oya191YWuz11BFEmf11i3Dv/BasBLs0/Ac4k4hGEqie9kGXXuCWnHPpLt
   KGbEbdpDrKCdJVkGSHX2fFuRXfzVud0Z5z98OMcOunFY7UnkGoHm3jKvO
   Wcg4Hi1tHdYQ45MAgyNgvAkBS8gNVLgNvYawzCPZUdmZOKQQ9CGScy/vl
   hpQs741xYD/ia86MbayoqTmNTGCHqorNIJIatuL3gLqY+yvjRtPA+I+av
   gqRk+hiLO5Swlv5OhptcN1e7/j64EMQBKhMeZHBMUNCs4maW6hF+/IjLs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="343028980"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="343028980"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:33:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="890313692"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="890313692"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:33:15 -0800
Message-ID: <0646275c-0ab9-2fad-8db1-7098656d6e1d@intel.com>
Date:   Fri, 2 Dec 2022 14:33:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 07/18] x86/sgx: Use a list to track to-be-reclaimed
 pages during reclaim
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-8-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221202183655.3767674-8-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Change sgx_reclaim_pages() to use a list rather than an array for
> storing the epc_pages which will be reclaimed. This change is needed
> to transition to the LRU implementation for EPC cgroup support.
> 
> This change requires keeping track of whether newly recorded
> EPC pages are pages for VA Arrays, or for Enclave data. In addition,
> helper functions are added to move pages from one list to another and
> enforce a consistent queue like behavior for the LRU lists.

More changelog nit: Please use imperative voice, not passive voice.
Move from:

	In addition, helper functions are added

to:

	In addition, add helper functions

> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 4683da9ef4f1..9ee306ac2a8e 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -252,7 +252,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
>  		epc_page = sgx_encl_eldu(&encl->secs, NULL);
>  		if (IS_ERR(epc_page))
>  			return ERR_CAST(epc_page);
> -		sgx_record_epc_page(epc_page, 0);
> +		sgx_record_epc_page(epc_page, SGX_EPC_PAGE_ENCLAVE);
>  	}

This is one of those patches where the first hunk seems like it is
entirely disconnected from what the changelog made me expect I would see.

I don't see sgx_reclaim_pages(), or lists or arrays.

If you need to pass additional data down into a function, then do *that*
in a separate patch.

I'm glad it eventually got fixed up, but I don't really ever like to see
bare integers that don't have obvious meaning:

	sgx_record_epc_page(epc_page, 0);

Even if you had:

#define SGX_EPC_PAGE_RECLAIMER_UNTRACKED 0

	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_UNTRACKED);

makes a *LOT* of sense compared to other callers that do

	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);

>  	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
> @@ -260,7 +260,8 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
>  		return ERR_CAST(epc_page);
>  
>  	encl->secs_child_cnt++;
> -	sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	sgx_record_epc_page(entry->epc_page,
> +			    (SGX_EPC_PAGE_ENCLAVE | SGX_EPC_PAGE_RECLAIMER_TRACKED));
>  
>  	return entry;
>  }
> @@ -1221,7 +1222,7 @@ struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
>  		sgx_encl_free_epc_page(epc_page);
>  		return ERR_PTR(-EFAULT);
>  	}
> -	sgx_record_epc_page(epc_page, 0);
> +	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_VERSION_ARRAY);
>  
>  	return epc_page;
>  }
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index aca80a3f38a1..c3a9bffbc37e 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -114,7 +114,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	encl->attributes = secs->attributes;
>  	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>  
> -	sgx_record_epc_page(encl->secs.epc_page, 0);
> +	sgx_record_epc_page(encl->secs.epc_page, SGX_EPC_PAGE_ENCLAVE);
>  
>  	/* Set only after completion, as encl->lock has not been taken. */
>  	set_bit(SGX_ENCL_CREATED, &encl->flags);
> @@ -325,7 +325,8 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
>  			goto err_out;
>  	}
>  
> -	sgx_record_epc_page(encl_page->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	sgx_record_epc_page(encl_page->epc_page,
> +			    (SGX_EPC_PAGE_ENCLAVE | SGX_EPC_PAGE_RECLAIMER_TRACKED));
>  	mutex_unlock(&encl->lock);
>  	mmap_read_unlock(current->mm);
>  	return ret;
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index bad72498b0a7..83aaf5cea7b9 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -288,37 +288,43 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>   */
>  static void __sgx_reclaim_pages(void)
>  {
> -	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
> +	struct sgx_epc_page *epc_page, *tmp;
>  	struct sgx_encl_page *encl_page;
> -	struct sgx_epc_page *epc_page;
>  	pgoff_t page_index;
> -	int cnt = 0;
> +	LIST_HEAD(iso);
>  	int ret;
>  	int i;
>  
>  	spin_lock(&sgx_global_lru.lock);
>  	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
> -		epc_page = sgx_epc_pop_reclaimable(&sgx_global_lru);
> +		epc_page = sgx_epc_peek_reclaimable(&sgx_global_lru);
>  		if (!epc_page)
>  			break;
>  
>  		encl_page = epc_page->encl_owner;
>  
> +		if (WARN_ON_ONCE(!(epc_page->flags & SGX_EPC_PAGE_ENCLAVE)))
> +			continue;
> +
>  		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
>  			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
> -			chunk[cnt++] = epc_page;
> +			list_move_tail(&epc_page->list, &iso);
>  		} else {
> -			/* The owner is freeing the page. No need to add the
> -			 * page back to the list of reclaimable pages.
> +			/* The owner is freeing the page, remove it from the
> +			 * LRU list
>  			 */
>  			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +			list_del_init(&epc_page->list);
>  		}
>  	}
>  	spin_unlock(&sgx_global_lru.lock);
>  
> -	for (i = 0; i < cnt; i++) {
> -		epc_page = chunk[i];
> +	if (list_empty(&iso))
> +		return;
> +
> +	i = 0;
> +	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>  		encl_page = epc_page->encl_owner;
>  
>  		if (!sgx_reclaimer_age(epc_page))
> @@ -333,6 +339,7 @@ static void __sgx_reclaim_pages(void)
>  			goto skip;
>  		}
>  
> +		i++;
>  		encl_page->desc |= SGX_ENCL_PAGE_BEING_RECLAIMED;
>  		mutex_unlock(&encl_page->encl->lock);
>  		continue;
> @@ -340,31 +347,25 @@ static void __sgx_reclaim_pages(void)
>  skip:
>  		spin_lock(&sgx_global_lru.lock);
>  		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
> -		sgx_epc_push_reclaimable(&sgx_global_lru, epc_page);
> +		sgx_epc_move_reclaimable(&sgx_global_lru, epc_page);
>  		spin_unlock(&sgx_global_lru.lock);
>  
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> -
> -		chunk[i] = NULL;
>  	}
>  
> -	for (i = 0; i < cnt; i++) {
> -		epc_page = chunk[i];
> -		if (epc_page)
> -			sgx_reclaimer_block(epc_page);
> -	}
> -
> -	for (i = 0; i < cnt; i++) {
> -		epc_page = chunk[i];
> -		if (!epc_page)
> -			continue;
> -
> +	list_for_each_entry(epc_page, &iso, list)
> +		sgx_reclaimer_block(epc_page);
> + 
> +	i = 0;
> +	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>  		encl_page = epc_page->encl_owner;
> -		sgx_reclaimer_write(epc_page, &backing[i]);
> +		sgx_reclaimer_write(epc_page, &backing[i++]);
>  
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
>  		epc_page->flags &= ~(SGX_EPC_PAGE_RECLAIMER_TRACKED |
> -				     SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
> +				     SGX_EPC_PAGE_RECLAIM_IN_PROGRESS |
> +				     SGX_EPC_PAGE_ENCLAVE |
> +				     SGX_EPC_PAGE_VERSION_ARRAY);
>  
>  		sgx_free_epc_page(epc_page);
>  	}
> @@ -505,6 +506,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  /**
>   * sgx_record_epc_page() - Add a page to the LRU tracking
>   * @page:	EPC page
> + * @flags:	Reclaim flags for the page.
>   *
>   * Mark a page with the specified flags and add it to the appropriate
>   * (un)reclaimable list.
> @@ -535,18 +537,19 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
>  int sgx_drop_epc_page(struct sgx_epc_page *page)
>  {
>  	spin_lock(&sgx_global_lru.lock);
> -	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
> -		/* The page is being reclaimed. */
> -		if (page->flags & SGX_EPC_PAGE_RECLAIM_IN_PROGRESS) {
> -			spin_unlock(&sgx_global_lru.lock);
> -			return -EBUSY;
> -		}
> -
> -		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +	if ((page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) &&
> +	    (page->flags & SGX_EPC_PAGE_RECLAIM_IN_PROGRESS)) {
> +		spin_unlock(&sgx_global_lru.lock);
> +		return -EBUSY;
>  	}
>  	list_del(&page->list);
>  	spin_unlock(&sgx_global_lru.lock);
>  
> +	page->flags &= ~(SGX_EPC_PAGE_RECLAIMER_TRACKED |
> +			 SGX_EPC_PAGE_RECLAIM_IN_PROGRESS |
> +			 SGX_EPC_PAGE_ENCLAVE |
> +			 SGX_EPC_PAGE_VERSION_ARRAY);
> +
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index 37d66bc6ca27..ec8d567cd975 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -32,6 +32,8 @@
>  #define SGX_EPC_PAGE_KVM_GUEST		BIT(2)
>  /* page flag to indicate reclaim is in progress */
>  #define SGX_EPC_PAGE_RECLAIM_IN_PROGRESS BIT(3)
> +#define SGX_EPC_PAGE_ENCLAVE		BIT(4)
> +#define SGX_EPC_PAGE_VERSION_ARRAY	BIT(5)

Could you please spend some time to clearly document what each bit means?

> +static inline void __sgx_epc_page_list_move(struct list_head *list, struct sgx_epc_page *page)
> +{
> +	list_move_tail(&page->list, list);
> +}

I'm not sure I get the point of a helper like this.  Why not just have
the caller call list_move() directly?

>  /*
>   * Must be called with queue lock acquired
>   */
> @@ -157,6 +167,38 @@ static inline void sgx_epc_push_unreclaimable(struct sgx_epc_lru_lists *lrus,
>  	__sgx_epc_page_list_push(&(lrus)->unreclaimable, page);
>  }
>  
> +/*
> + * Must be called with queue lock acquired
> + */
> +static inline struct sgx_epc_page * __sgx_epc_page_list_peek(struct list_head *list)
> +{
> +	struct sgx_epc_page *epc_page;
> +
> +	if (list_empty(list))
> +		return NULL;
> +
> +	epc_page = list_first_entry(list, struct sgx_epc_page, list);
> +	return epc_page;
> +}

list_first_entry_or_null() perhaps?

> +static inline struct sgx_epc_page *
> +sgx_epc_peek_reclaimable(struct sgx_epc_lru_lists *lrus)
> +{
> +	return __sgx_epc_page_list_peek(&(lrus)->reclaimable);
> +}
> +
> +static inline void sgx_epc_move_reclaimable(struct sgx_epc_lru_lists *lru,
> +					    struct sgx_epc_page *page)
> +{
> +	__sgx_epc_page_list_move(&(lru)->reclaimable, page);
> +}
> +
> +static inline struct sgx_epc_page *
> +sgx_epc_peek_unreclaimable(struct sgx_epc_lru_lists *lrus)
> +{
> +	return __sgx_epc_page_list_peek(&(lrus)->unreclaimable);
> +}

In general, I'm not becoming more fond of these helpers as the series
goes along.  My worry is that they're an abstraction where we don't
*really* need one.  I don't seem them growing much functionality as the
series goes along.

I'll reserve judgement until the end though.

