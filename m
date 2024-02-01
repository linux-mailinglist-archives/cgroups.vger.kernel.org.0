Return-Path: <cgroups+bounces-1306-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD484646D
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 00:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B587E1C23F97
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 23:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CAB47F4A;
	Thu,  1 Feb 2024 23:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0jG1s2h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0B47F45;
	Thu,  1 Feb 2024 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830119; cv=none; b=pwe08G1KB2CjcL+EQE0Oo8nJsPzC2/UDlBUMsPQOTt7W5DxLTew2qJCnUes9u8UNOWJVoiUXa9JGz8tr7bqx0+aJ6SoT5U7qUJtTA1LdxkjhCSD1/5OA+P1MkJtCHNgL7z7g41AKXeW4BL9k+dMmDWmSl0kDzri4E+zaiI8YWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830119; c=relaxed/simple;
	bh=vwVSBjMVGrB3T8i81OBsdcOGsrxP1w/yplr+RskeJjA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TdGbxRHjB1YNhH6xpFJ8fMSOwsqDu6H2HdFZE3aWBLTX0u1WkYLRMx+BIKkVVmqmb8orCCBRzBO7SccrVt3FhJQoud696cMk4fa/BWCC8MiL7PDgndmLeLCzQnKRVc1pNky5iEiW9HG/pewAZZ+q8jemwBr+TTtN/CbFOJtyfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0jG1s2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61816C433C7;
	Thu,  1 Feb 2024 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706830118;
	bh=vwVSBjMVGrB3T8i81OBsdcOGsrxP1w/yplr+RskeJjA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=o0jG1s2hTncjFmR/SiqVsD9S+SPA4PmQsRd92nL2QMyTRu5Moyo5Ico5M/Bui/Yf3
	 TaWq3OTo5xlySloLUKHHMidNaEY2DI4rrh+dUDNQy/APZZaq+ZWWDbGz8v4u9Gvq6R
	 Wnda99xeU1kW3qCS1PJnJMEIQldZ8/5DYHbUv/6G53l5zT7m1TLxTx7mi4gNn5hwCs
	 rgd0U7lo75K9+yECcEWo9z6VmJOUTUCynsnmEFFHGckYUYzYGE1yJB3w3j/JF9L+Az
	 EDMxnb+8SziMbmRFLIjoSoPGWx6R4ocd16GYXv2myFIVXo9fxd1kqd4fxFiGJVCD96
	 kzKHnT5cdPUgw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:28:32 +0200
Message-Id: <CYU4S0Y9SVZ2.2G9RM5Y3K28XI@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 05/15] x86/sgx: Add sgx_epc_lru_list to encapsulate
 LRU list
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-6-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-6-haitao.huang@linux.intel.com>

On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Introduce a data structure to wrap the existing reclaimable list and its
> spinlock. Each cgroup later will have one instance of this structure to
> track EPC pages allocated for processes associated with the same cgroup.
> Just like the global SGX reclaimer (ksgxd), an EPC cgroup reclaims pages
> from the reclaimable list in this structure when its usage reaches near
> its limit.
>
> Use this structure to encapsulate the LRU list and its lock used by the
> global reclaimer.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

I'd put author as last sob but that said I'm not sure if there is rigid
rule to do so. Thus not saying must here.

> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V6:
> - removed introduction to unreclaimables in commit message.
>
> V4:
> - Removed unneeded comments for the spinlock and the non-reclaimables.
> (Kai, Jarkko)
> - Revised the commit to add introduction comments for unreclaimables and
> multiple LRU lists.(Kai)
> - Reordered the patches: delay all changes for unreclaimables to
> later, and this one becomes the first change in the SGX subsystem.
>
> V3:
> - Removed the helper functions and revised commit messages.
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 39 +++++++++++++++++-----------------
>  arch/x86/kernel/cpu/sgx/sgx.h  | 15 +++++++++++++
>  2 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index c32f18b70c73..912959c7ecc9 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -28,10 +28,9 @@ static DEFINE_XARRAY(sgx_epc_address_space);
> =20
>  /*
>   * These variables are part of the state of the reclaimer, and must be a=
ccessed
> - * with sgx_reclaimer_lock acquired.
> + * with sgx_global_lru.lock acquired.
>   */
> -static LIST_HEAD(sgx_active_page_list);
> -static DEFINE_SPINLOCK(sgx_reclaimer_lock);
> +static struct sgx_epc_lru_list sgx_global_lru;
> =20
>  static atomic_long_t sgx_nr_free_pages =3D ATOMIC_LONG_INIT(0);
> =20
> @@ -306,13 +305,13 @@ static void sgx_reclaim_pages(void)
>  	int ret;
>  	int i;
> =20
> -	spin_lock(&sgx_reclaimer_lock);
> +	spin_lock(&sgx_global_lru.lock);
>  	for (i =3D 0; i < SGX_NR_TO_SCAN; i++) {
> -		if (list_empty(&sgx_active_page_list))
> +		epc_page =3D list_first_entry_or_null(&sgx_global_lru.reclaimable,
> +						    struct sgx_epc_page, list);
> +		if (!epc_page)
>  			break;
> =20
> -		epc_page =3D list_first_entry(&sgx_active_page_list,
> -					    struct sgx_epc_page, list);
>  		list_del_init(&epc_page->list);
>  		encl_page =3D epc_page->owner;
> =20
> @@ -324,7 +323,7 @@ static void sgx_reclaim_pages(void)
>  			 */
>  			epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_reclaimer_lock);
> +	spin_unlock(&sgx_global_lru.lock);
> =20
>  	for (i =3D 0; i < cnt; i++) {
>  		epc_page =3D chunk[i];
> @@ -347,9 +346,9 @@ static void sgx_reclaim_pages(void)
>  		continue;
> =20
>  skip:
> -		spin_lock(&sgx_reclaimer_lock);
> -		list_add_tail(&epc_page->list, &sgx_active_page_list);
> -		spin_unlock(&sgx_reclaimer_lock);
> +		spin_lock(&sgx_global_lru.lock);
> +		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
> +		spin_unlock(&sgx_global_lru.lock);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> =20
> @@ -380,7 +379,7 @@ static void sgx_reclaim_pages(void)
>  static bool sgx_should_reclaim(unsigned long watermark)
>  {
>  	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
> -	       !list_empty(&sgx_active_page_list);
> +	       !list_empty(&sgx_global_lru.reclaimable);
>  }
> =20
>  /*
> @@ -432,6 +431,8 @@ static bool __init sgx_page_reclaimer_init(void)
> =20
>  	ksgxd_tsk =3D tsk;
> =20
> +	sgx_lru_init(&sgx_global_lru);
> +
>  	return true;
>  }
> =20
> @@ -507,10 +508,10 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>   */
>  void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
>  {
> -	spin_lock(&sgx_reclaimer_lock);
> +	spin_lock(&sgx_global_lru.lock);
>  	page->flags |=3D SGX_EPC_PAGE_RECLAIMER_TRACKED;
> -	list_add_tail(&page->list, &sgx_active_page_list);
> -	spin_unlock(&sgx_reclaimer_lock);
> +	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
> +	spin_unlock(&sgx_global_lru.lock);
>  }
> =20
>  /**
> @@ -525,18 +526,18 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page =
*page)
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
> =20
>  		list_del(&page->list);
>  		page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_reclaimer_lock);
> +	spin_unlock(&sgx_global_lru.lock);
> =20
>  	return 0;
>  }
> @@ -578,7 +579,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
bool reclaim)
>  			break;
>  		}
> =20
> -		if (list_empty(&sgx_active_page_list)) {
> +		if (list_empty(&sgx_global_lru.reclaimable)) {
>  			page =3D ERR_PTR(-ENOMEM);
>  			break;
>  		}
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index a898d86dead0..0e99e9ae3a67 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -88,6 +88,21 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_e=
pc_page *page)
>  	return section->virt_addr + index * PAGE_SIZE;
>  }
> =20
> +/*
> + * Contains EPC pages tracked by the global reclaimer (ksgxd) or an EPC
> + * cgroup.
> + */
> +struct sgx_epc_lru_list {
> +	spinlock_t lock;
> +	struct list_head reclaimable;
> +};
> +
> +static inline void sgx_lru_init(struct sgx_epc_lru_list *lru)
> +{
> +	spin_lock_init(&lru->lock);
> +	INIT_LIST_HEAD(&lru->reclaimable);
> +}
> +
>  struct sgx_epc_page *__sgx_alloc_epc_page(void);
>  void sgx_free_epc_page(struct sgx_epc_page *page);
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

