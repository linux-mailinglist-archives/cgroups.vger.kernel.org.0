Return-Path: <cgroups+bounces-434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C70B7ED38F
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 21:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7332281010
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 20:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310C1FCF;
	Wed, 15 Nov 2023 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUAzOOxI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353539FC0
	for <cgroups@vger.kernel.org>; Wed, 15 Nov 2023 20:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305E7C4E779;
	Wed, 15 Nov 2023 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700081600;
	bh=5SyGbnc/3QrHrfdukn5FK/7O7SeZI2Im+g7ZkCC4toI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MUAzOOxI59if2eEeWiRYHzaEU2MSB606aFU/nOKkh08A9xZFJ5ZlpV2FOc85nNeGO
	 kCiaEKyGEfeHEVyBP9F3FqbTsmrV3uqiunBuDn631cnoTs8XeTm4DBcKVYVwkUqtsL
	 XD/xqN9i9JDuvzvq6PwzUcRav+pHejbDigflIZQ51XiNWt7Oex785ztIBklO2SDjVF
	 B23OfTZLu1VkVg9X/Jpbziu0tWrBi+Gy7aZBzZa5JhAKg/U6KhZm6V2CpBxpmEbW1U
	 83THK9k/Hb6uWr3QWZThoRFfcCy5BArGDxbyXylkhH3/a2Y2X80CpEmHsSbyRS+MHE
	 VSAsUd9hsh/lA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 22:53:14 +0200
Message-Id: <CWZOMMET6NDV.UVZQZ5VPS3NP@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>, "Sean
 Christopherson" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 07/12] x86/sgx: Introduce EPC page states
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-8-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-8-haitao.huang@linux.intel.com>

On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
> Use the lower 2 bits in the flags field of sgx_epc_page struct to track
> EPC states and define an enum for possible states for EPC pages tracked
> for reclamation.
>
> Add the RECLAIM_IN_PROGRESS state to explicitly indicate a page that is
> identified as a candidate for reclaiming, but has not yet been
> reclaimed, instead of relying on list_empty(&epc_page->list). A later
> patch will replace the array on stack with a temporary list to store the
> candidate pages, so list_empty() should no longer be used for this
> purpose.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V6:
> - Drop UNRECLAIMABLE and use only 2 bits for states (Kai)
> - Combine the patch for RECLAIM_IN_PROGRESS
> - Style fixes (Jarkko and Kai)
> ---
>  arch/x86/kernel/cpu/sgx/encl.c |  2 +-
>  arch/x86/kernel/cpu/sgx/main.c | 33 +++++++++---------
>  arch/x86/kernel/cpu/sgx/sgx.h  | 62 +++++++++++++++++++++++++++++++---
>  3 files changed, 76 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 279148e72459..17dc108d3ff7 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -1315,7 +1315,7 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *pa=
ge)
>  {
>  	int ret;
> =20
> -	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_STATE_MASK);
> =20
>  	ret =3D __eremove(sgx_get_epc_virt_addr(page));
>  	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index d347acd717fd..e27ac73d8843 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -315,13 +315,14 @@ static void sgx_reclaim_pages(void)
>  		list_del_init(&epc_page->list);
>  		encl_page =3D epc_page->owner;
> =20
> -		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0)
> +		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0) {
> +			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
>  			chunk[cnt++] =3D epc_page;
> -		else
> +		} else
>  			/* The owner is freeing the page. No need to add the
>  			 * page back to the list of reclaimable pages.
>  			 */
> -			epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +			sgx_epc_page_reset_state(epc_page);
>  	}
>  	spin_unlock(&sgx_global_lru.lock);
> =20
> @@ -347,6 +348,7 @@ static void sgx_reclaim_pages(void)
> =20
>  skip:
>  		spin_lock(&sgx_global_lru.lock);
> +		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
>  		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
>  		spin_unlock(&sgx_global_lru.lock);
> =20
> @@ -370,7 +372,7 @@ static void sgx_reclaim_pages(void)
>  		sgx_reclaimer_write(epc_page, &backing[i]);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> -		epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +		sgx_epc_page_reset_state(epc_page);
> =20
>  		sgx_free_epc_page(epc_page);
>  	}
> @@ -509,7 +511,8 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
>  {
>  	spin_lock(&sgx_global_lru.lock);
> -	page->flags |=3D SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +	WARN_ON_ONCE(sgx_epc_page_reclaimable(page->flags));
> +	page->flags |=3D SGX_EPC_PAGE_RECLAIMABLE;
>  	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
>  	spin_unlock(&sgx_global_lru.lock);
>  }
> @@ -527,16 +530,13 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page =
*page)
>  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
>  {
>  	spin_lock(&sgx_global_lru.lock);
> -	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
> -		/* The page is being reclaimed. */
> -		if (list_empty(&page->list)) {
> -			spin_unlock(&sgx_global_lru.lock);
> -			return -EBUSY;
> -		}
> -
> -		list_del(&page->list);
> -		page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +	if (sgx_epc_page_reclaim_in_progress(page->flags)) {
> +		spin_unlock(&sgx_global_lru.lock);
> +		return -EBUSY;
>  	}
> +
> +	list_del(&page->list);
> +	sgx_epc_page_reset_state(page);
>  	spin_unlock(&sgx_global_lru.lock);
> =20
>  	return 0;
> @@ -623,6 +623,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  	struct sgx_epc_section *section =3D &sgx_epc_sections[page->section];
>  	struct sgx_numa_node *node =3D section->node;
> =20
> +	WARN_ON_ONCE(page->flags & (SGX_EPC_PAGE_STATE_MASK));
>  	if (page->epc_cg) {
>  		sgx_epc_cgroup_uncharge(page->epc_cg);
>  		page->epc_cg =3D NULL;
> @@ -635,7 +636,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  		list_add(&page->list, &node->sgx_poison_page_list);
>  	else
>  		list_add_tail(&page->list, &node->free_page_list);
> -	page->flags =3D SGX_EPC_PAGE_IS_FREE;
> +	page->flags =3D SGX_EPC_PAGE_FREE;
> =20
>  	spin_unlock(&node->lock);
>  	atomic_long_inc(&sgx_nr_free_pages);
> @@ -737,7 +738,7 @@ int arch_memory_failure(unsigned long pfn, int flags)
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
> index 0fbe6a2a159b..dd7ab65b5b27 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -23,11 +23,44 @@
>  #define SGX_NR_LOW_PAGES		32
>  #define SGX_NR_HIGH_PAGES		64
> =20
> -/* Pages, which are being tracked by the page reclaimer. */
> -#define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
> +enum sgx_epc_page_state {
> +	/*
> +	 * Allocated but not tracked by the reclaimer.
> +	 *
> +	 * Pages allocated for virtual EPC which are never tracked by the host
> +	 * reclaimer; pages just allocated from free list but not yet put in
> +	 * use; pages just reclaimed, but not yet returned to the free list.
> +	 * Becomes FREE after sgx_free_epc().
> +	 * Becomes RECLAIMABLE after sgx_mark_page_reclaimable().
> +	 */
> +	SGX_EPC_PAGE_NOT_TRACKED =3D 0,
> +
> +	/*
> +	 * Page is in the free list, ready for allocation.
> +	 *
> +	 * Becomes NOT_TRACKED after sgx_alloc_epc_page().
> +	 */
> +	SGX_EPC_PAGE_FREE =3D 1,
> +
> +	/*
> +	 * Page is in use and tracked in a reclaimable LRU list.
> +	 *
> +	 * Becomes NOT_TRACKED after sgx_unmark_page_reclaimable().
> +	 * Becomes RECLAIM_IN_PROGRESS in sgx_reclaim_pages() when identified
> +	 * for reclaiming.
> +	 */
> +	SGX_EPC_PAGE_RECLAIMABLE =3D 2,
> +
> +	/*
> +	 * Page is in the middle of reclamation.
> +	 *
> +	 * Back to RECLAIMABLE if reclamation fails for any reason.
> +	 * Becomes NOT_TRACKED if reclaimed successfully.
> +	 */
> +	SGX_EPC_PAGE_RECLAIM_IN_PROGRESS =3D 3,
> +};
> =20
> -/* Pages on free list */
> -#define SGX_EPC_PAGE_IS_FREE		BIT(1)
> +#define SGX_EPC_PAGE_STATE_MASK GENMASK(1, 0)
> =20
>  struct sgx_epc_cgroup;
> =20
> @@ -40,6 +73,27 @@ struct sgx_epc_page {
>  	struct sgx_epc_cgroup *epc_cg;
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
> +static inline bool sgx_epc_page_reclaim_in_progress(unsigned long flags)
> +{
> +	return SGX_EPC_PAGE_RECLAIM_IN_PROGRESS =3D=3D (flags & SGX_EPC_PAGE_ST=
ATE_MASK);
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

Looks pretty good to me. I'll hold ack's a bit until everything looks as
a whole good, but I agree with the general idea in this patch.

BR, Jarkko

