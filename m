Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED17E7ADD9F
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 19:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjIYRLt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjIYRLr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 13:11:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEF111C;
        Mon, 25 Sep 2023 10:11:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F4C433C7;
        Mon, 25 Sep 2023 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695661900;
        bh=RCX1EEHFm81FX6lrKwHXyYLIiwDk5dlgqyAHFbJfzy0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=GsDItSoNwO24c8QLrX/xdDC2nBV9Q+pJPSLC1Avqn+8Lx70SJg5kRJIQXrNplCiS3
         a+/OEOZJjOKHO0oU/UBfikKiZdDyz9buSXEI9/JvlZ30QIZJlW2/SQOLUpGSdrghG1
         jtJxvyD6j5QL1cbooLyv4xeezWnWfLr6cOQGcmoQEs+bzPJ1mXWg6FYDoeWN2i8zlz
         Oa1cjgX3zwqwOduHsXKZZ0vqM/9ojGbbh9xt7SUFEQ4Omx78gf+ljECcbHnrZqc8MI
         8HWjZntT27ZutpRTmZDGqp1aUqxDjw+M0UVwl+k54ZDKNatvEK9vahNP/R4LTY02g3
         1XCoQT4jDDYPw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 20:11:34 +0300
Message-Id: <CVS5Z4M3MWLU.O94T1T5I56QF@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-7-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-7-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat Sep 23, 2023 at 6:06 AM EEST, Haitao Huang wrote:
> Use the lower 3 bits in the flags field of sgx_epc_page struct to
> track EPC states in its life cycle and define an enum for possible
> states. More state(s) will be added later.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V4:
> - No changes other than required for patch reordering.
>
> V3:
> - This is new in V3 to replace the bit mask based approach (requested by =
Jarkko)
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  | 14 +++++++---
>  arch/x86/kernel/cpu/sgx/ioctl.c |  7 +++--
>  arch/x86/kernel/cpu/sgx/main.c  | 19 +++++++------
>  arch/x86/kernel/cpu/sgx/sgx.h   | 49 ++++++++++++++++++++++++++++++---
>  4 files changed, 71 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 97a53e34a8b4..f5afc8d65e22 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -244,8 +244,12 @@ static struct sgx_epc_page *sgx_encl_load_secs(struc=
t sgx_encl *encl)
>  {
>  	struct sgx_epc_page *epc_page =3D encl->secs.epc_page;
> =20
> -	if (!epc_page)
> +	if (!epc_page) {
>  		epc_page =3D sgx_encl_eldu(&encl->secs, NULL);
> +		if (!IS_ERR(epc_page))
> +			sgx_record_epc_page(epc_page,
> +					    SGX_EPC_PAGE_UNRECLAIMABLE);

Can be a single line probably (less than 100 characters).

> +	}
> =20
>  	return epc_page;
>  }
> @@ -272,7 +276,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(str=
uct sgx_encl *encl,
>  		return ERR_CAST(epc_page);
> =20
>  	encl->secs_child_cnt++;
> -	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
> =20
>  	return entry;
>  }
> @@ -398,7 +402,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_s=
truct *vma,
>  	encl_page->type =3D SGX_PAGE_TYPE_REG;
>  	encl->secs_child_cnt++;
> =20
> -	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
> =20
>  	phys_addr =3D sgx_get_epc_phys_addr(epc_page);
>  	/*
> @@ -1256,6 +1260,8 @@ struct sgx_epc_page *sgx_alloc_va_page(bool reclaim=
)
>  		sgx_encl_free_epc_page(epc_page);
>  		return ERR_PTR(-EFAULT);
>  	}
> +	sgx_record_epc_page(epc_page,
> +			    SGX_EPC_PAGE_UNRECLAIMABLE);

There is bunch of these apparently.

> =20
>  	return epc_page;
>  }
> @@ -1315,7 +1321,7 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *pa=
ge)
>  {
>  	int ret;
> =20
> -	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_STATE_MASK);
> =20
>  	ret =3D __eremove(sgx_get_epc_virt_addr(page));
>  	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index a75eb44022a3..9a32bf5a1070 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -113,6 +113,9 @@ static int sgx_encl_create(struct sgx_encl *encl, str=
uct sgx_secs *secs)
>  	encl->attributes =3D secs->attributes;
>  	encl->attributes_mask =3D SGX_ATTR_UNPRIV_MASK;
> =20
> +	sgx_record_epc_page(encl->secs.epc_page,
> +			    SGX_EPC_PAGE_UNRECLAIMABLE);
> +
>  	/* Set only after completion, as encl->lock has not been taken. */
>  	set_bit(SGX_ENCL_CREATED, &encl->flags);
> =20
> @@ -322,7 +325,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, u=
nsigned long src,
>  			goto err_out;
>  	}
> =20
> -	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
>  	mutex_unlock(&encl->lock);
>  	mmap_read_unlock(current->mm);
>  	return ret;
> @@ -976,7 +979,7 @@ static long sgx_enclave_modify_types(struct sgx_encl =
*encl,
> =20
>  			mutex_lock(&encl->lock);
> =20
> -			sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +			sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMABLE);
>  		}
> =20
>  		/* Change EPC type */
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index dec1d57cbff6..b26860399402 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -318,7 +318,7 @@ static void sgx_reclaim_pages(void)
>  			/* The owner is freeing the page. No need to add the
>  			 * page back to the list of reclaimable pages.
>  			 */
> -			epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +			sgx_epc_page_reset_state(epc_page);
>  	}
>  	spin_unlock(&sgx_global_lru.lock);
> =20
> @@ -344,6 +344,7 @@ static void sgx_reclaim_pages(void)
> =20
>  skip:
>  		spin_lock(&sgx_global_lru.lock);
> +		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
>  		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
>  		spin_unlock(&sgx_global_lru.lock);
> =20
> @@ -367,7 +368,7 @@ static void sgx_reclaim_pages(void)
>  		sgx_reclaimer_write(epc_page, &backing[i]);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> -		epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +		sgx_epc_page_reset_state(epc_page);
> =20
>  		sgx_free_epc_page(epc_page);
>  	}
> @@ -507,9 +508,9 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
>  {
>  	spin_lock(&sgx_global_lru.lock);
> -	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	WARN_ON_ONCE(sgx_epc_page_reclaimable(page->flags));
>  	page->flags |=3D flags;
> -	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
> +	if (sgx_epc_page_reclaimable(flags))
>  		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
>  	spin_unlock(&sgx_global_lru.lock);
>  }
> @@ -527,7 +528,7 @@ void sgx_record_epc_page(struct sgx_epc_page *page, u=
nsigned long flags)
>  int sgx_drop_epc_page(struct sgx_epc_page *page)
>  {
>  	spin_lock(&sgx_global_lru.lock);
> -	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
> +	if (sgx_epc_page_reclaimable(page->flags)) {
>  		/* The page is being reclaimed. */
>  		if (list_empty(&page->list)) {
>  			spin_unlock(&sgx_global_lru.lock);
> @@ -535,7 +536,7 @@ int sgx_drop_epc_page(struct sgx_epc_page *page)
>  		}
> =20
>  		list_del(&page->list);
> -		page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +		sgx_epc_page_reset_state(page);
>  	}
>  	spin_unlock(&sgx_global_lru.lock);
> =20
> @@ -607,6 +608,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  	struct sgx_epc_section *section =3D &sgx_epc_sections[page->section];
>  	struct sgx_numa_node *node =3D section->node;
> =20
> +	WARN_ON_ONCE(page->flags & (SGX_EPC_PAGE_STATE_MASK));
> +
>  	spin_lock(&node->lock);
> =20
>  	page->owner =3D NULL;
> @@ -614,7 +617,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  		list_add(&page->list, &node->sgx_poison_page_list);
>  	else
>  		list_add_tail(&page->list, &node->free_page_list);
> -	page->flags =3D SGX_EPC_PAGE_IS_FREE;
> +	page->flags =3D SGX_EPC_PAGE_FREE;
> =20
>  	spin_unlock(&node->lock);
>  	atomic_long_inc(&sgx_nr_free_pages);
> @@ -715,7 +718,7 @@ int arch_memory_failure(unsigned long pfn, int flags)
>  	 * If the page is on a free list, move it to the per-node
>  	 * poison page list.
>  	 */
> -	if (page->flags & SGX_EPC_PAGE_IS_FREE) {
> +	if (page->flags =3D=3D SGX_EPC_PAGE_FREE) {
>  		list_move(&page->list, &node->sgx_poison_page_list);
>  		goto out;
>  	}
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 113d930fd087..2faeb40b345f 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -23,11 +23,36 @@
>  #define SGX_NR_LOW_PAGES		32
>  #define SGX_NR_HIGH_PAGES		64
> =20
> -/* Pages, which are being tracked by the page reclaimer. */
> -#define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
> +enum sgx_epc_page_state {
> +	/* Not tracked by the reclaimer:
> +	 * Pages allocated for virtual EPC which are never tracked by the host
> +	 * reclaimer; pages just allocated from free list but not yet put in
> +	 * use; pages just reclaimed, but not yet returned to the free list.
> +	 * Becomes FREE after sgx_free_epc()
> +	 * Becomes RECLAIMABLE or UNRECLAIMABLE after sgx_record_epc()
> +	 */
> +	SGX_EPC_PAGE_NOT_TRACKED =3D 0,
> +
> +	/* Page is in the free list, ready for allocation
> +	 * Becomes NOT_TRACKED after sgx_alloc_epc_page()
> +	 */
> +	SGX_EPC_PAGE_FREE =3D 1,
> +
> +	/* Page is in use and tracked in a reclaimable LRU list
> +	 * Becomes NOT_TRACKED after sgx_drop_epc()
> +	 */
> +	SGX_EPC_PAGE_RECLAIMABLE =3D 2,
> +
> +	/* Page is in use but tracked in an unreclaimable LRU list. These are
> +	 * only reclaimable when the whole enclave is OOM killed or the enclave
> +	 * is released, e.g., VA, SECS pages
> +	 * Becomes NOT_TRACKED after sgx_drop_epc()
> +	 */
> +	SGX_EPC_PAGE_UNRECLAIMABLE =3D 3,
> =20
> -/* Pages on free list */
> -#define SGX_EPC_PAGE_IS_FREE		BIT(1)
> +};
> +
> +#define SGX_EPC_PAGE_STATE_MASK GENMASK(2, 0)
> =20
>  struct sgx_epc_page {
>  	unsigned int section;
> @@ -37,6 +62,22 @@ struct sgx_epc_page {
>  	struct list_head list;
>  };
> =20
> +static inline void sgx_epc_page_reset_state(struct sgx_epc_page *page)
> +{
> +	page->flags &=3D ~SGX_EPC_PAGE_STATE_MASK;
> +}
> +
> +static inline void sgx_epc_page_set_state(struct sgx_epc_page *page, uns=
igned long flags)
> +{
> +	page->flags &=3D ~SGX_EPC_PAGE_STATE_MASK;
> +	page->flags |=3D (flags & SGX_EPC_PAGE_STATE_MASK);
> +}
> +
> +static inline bool sgx_epc_page_reclaimable(unsigned long flags)
> +{
> +	return SGX_EPC_PAGE_RECLAIMABLE =3D=3D (flags & SGX_EPC_PAGE_STATE_MASK=
);
> +}
> +
>  /*
>   * Contains the tracking data for NUMA nodes having EPC pages. Most impo=
rtantly,
>   * the free page list local to the node is stored here.
> --=20
> 2.25.1

BR, Jarkko
