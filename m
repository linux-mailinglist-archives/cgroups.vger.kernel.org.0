Return-Path: <cgroups+bounces-1308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A0684648D
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 00:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C2A1F24929
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2449147F4D;
	Thu,  1 Feb 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEAFKojo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15B4120F;
	Thu,  1 Feb 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830670; cv=none; b=LnwxetgoCCxhNsTd7gXpGf+orevj9GvfhWinbVEgoWP8UCF6Lxk4fla/3mfSuuXna3AoLVLGLyRodLV8A1XXa7bnR2SGTehpuVxXcKLZBzgwBOGqC1j8T3DLT8wyGwU3H55lzZm5K/va++p+k8h/VzlknH/JOXb0QDaALzS9Ck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830670; c=relaxed/simple;
	bh=zeLTxssbzif5e1MXLU8fnbuHnEx1Yo+J1kOsZzbJ9VE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ubxV9q+WrzgQbZkyFeRmuVbsfcvNBZdNxnTbH0PIPHSF240ECePUPURHDe/7LT+nffg/Hdee1baCBI5bkozytVv054wZqbXlIZ+qJR00eiRI+MvN28e1qu7JiPDlpR6H4OEI6t3aCnwb6DoYR+/NEyaVWqXlvOCOCL24FIh4PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEAFKojo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EFDC433C7;
	Thu,  1 Feb 2024 23:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706830670;
	bh=zeLTxssbzif5e1MXLU8fnbuHnEx1Yo+J1kOsZzbJ9VE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YEAFKojozU8ytSUk0wufLfNEnhJ+R7VUFDwFHmdNwnVpGE91eIjqYXzr2jZHAQi5+
	 0ZbAoeY6GswLvDB3l9iJYYPXNXIJRS+z1UH9VtAILCjd0FsnXhyBKItDHPR2yo8yjk
	 pCLMMTyenMbx/baTOmMeLkQamgJZUaxVGqe9f/tzv0bh1fEX3p74lO65Kd1eyYF4g9
	 +iFNg5Nf2HzVLNZRcz742miMvf2GxNsiqC8SpAb7rvQ4PivX+fophqVB3FFSsGE97r
	 97DJWuQNH2PV/3kfblpOHUhd3PO/hCkOPuyl0oHXPV+sCEA3zCUyD7QJaqTlkAKQby
	 Um2Xl41Z+Ya9g==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:37:44 +0200
Message-Id: <CYU4Z2HB9QTM.27NW3GSTRPXCM@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-8-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-8-haitao.huang@linux.intel.com>

On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Each EPC cgroup will have an LRU structure to track reclaimable EPC pages=
.
> When a cgroup usage reaches its limit, the cgroup needs to reclaim pages
> from its LRU or LRUs of its descendants to make room for any new
> allocations.
>
> To prepare for reclamation per cgroup, expose the top level reclamation
> function, sgx_reclaim_pages(), in header file for reuse. Add a parameter
> to the function to pass in an LRU so cgroups can pass in different
> tracking LRUs later.  Add another parameter for passing in the number of
> pages to scan and make the function return the number of pages reclaimed
> as a cgroup reclaimer may need to track reclamation progress from its
> descendants, change number of pages to scan in subsequent calls.
>
> Create a wrapper for the global reclaimer, sgx_reclaim_pages_global(),
> to just call this function with the global LRU passed in. When
> per-cgroup LRU is added later, the wrapper will perform global
> reclamation from the root cgroup.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V8:
> - Use width of 80 characters in text paragraphs. (Jarkko)
>
> V7:
> - Reworked from patch 9 of V6, "x86/sgx: Restructure top-level EPC reclai=
m
> function". Do not split the top level function (Kai)
> - Dropped patches 7 and 8 of V6.
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 53 +++++++++++++++++++++++-----------
>  arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
>  2 files changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index a131aa985c95..4f5824c4751d 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -286,11 +286,13 @@ static void sgx_reclaimer_write(struct sgx_epc_page=
 *epc_page,
>  	mutex_unlock(&encl->lock);
>  }
> =20
> -/*
> - * Take a fixed number of pages from the head of the active page pool an=
d
> - * reclaim them to the enclave's private shmem files. Skip the pages, wh=
ich have
> - * been accessed since the last scan. Move those pages to the tail of ac=
tive
> - * page pool so that the pages get scanned in LRU like fashion.
> +/**
> + * sgx_reclaim_pages() - Reclaim a fixed number of pages from an LRU
> + *
> + * Take a fixed number of pages from the head of a given LRU and reclaim=
 them to
> + * the enclave's private shmem files. Skip the pages, which have been ac=
cessed
> + * since the last scan. Move those pages to the tail of the list so that=
 the
> + * pages get scanned in LRU like fashion.
>   *
>   * Batch process a chunk of pages (at the moment 16) in order to degrade=
 amount
>   * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degra=
de a bit
> @@ -298,8 +300,13 @@ static void sgx_reclaimer_write(struct sgx_epc_page =
*epc_page,
>   * + EWB) but not sufficiently. Reclaiming one page at a time would also=
 be
>   * problematic as it would increase the lock contention too much, which =
would
>   * halt forward progress.
> + *
> + * @lru:	The LRU from which pages are reclaimed.
> + * @nr_to_scan: Pointer to the target number of pages to scan, must be l=
ess than
> + *		SGX_NR_TO_SCAN.
> + * Return:	Number of pages reclaimed.
>   */
> -static void sgx_reclaim_pages(void)
> +unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned in=
t *nr_to_scan)
>  {
>  	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
> @@ -310,10 +317,10 @@ static void sgx_reclaim_pages(void)
>  	int ret;
>  	int i;
> =20
> -	spin_lock(&sgx_global_lru.lock);
> -	for (i =3D 0; i < SGX_NR_TO_SCAN; i++) {
> -		epc_page =3D list_first_entry_or_null(&sgx_global_lru.reclaimable,
> -						    struct sgx_epc_page, list);
> +	spin_lock(&lru->lock);
> +
> +	for (; *nr_to_scan > 0; --(*nr_to_scan)) {
> +		epc_page =3D list_first_entry_or_null(&lru->reclaimable, struct sgx_ep=
c_page, list);
>  		if (!epc_page)
>  			break;
> =20
> @@ -328,7 +335,8 @@ static void sgx_reclaim_pages(void)
>  			 */
>  			epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_global_lru.lock);
> +
> +	spin_unlock(&lru->lock);
> =20
>  	for (i =3D 0; i < cnt; i++) {
>  		epc_page =3D chunk[i];
> @@ -351,9 +359,9 @@ static void sgx_reclaim_pages(void)
>  		continue;
> =20
>  skip:
> -		spin_lock(&sgx_global_lru.lock);
> -		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
> -		spin_unlock(&sgx_global_lru.lock);
> +		spin_lock(&lru->lock);
> +		list_add_tail(&epc_page->list, &lru->reclaimable);
> +		spin_unlock(&lru->lock);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> =20
> @@ -366,6 +374,7 @@ static void sgx_reclaim_pages(void)
>  			sgx_reclaimer_block(epc_page);
>  	}
> =20
> +	ret =3D 0;
>  	for (i =3D 0; i < cnt; i++) {
>  		epc_page =3D chunk[i];
>  		if (!epc_page)
> @@ -378,7 +387,10 @@ static void sgx_reclaim_pages(void)
>  		epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> =20
>  		sgx_free_epc_page(epc_page);
> +		ret++;
>  	}
> +
> +	return (unsigned int)ret;
>  }
> =20
>  static bool sgx_should_reclaim(unsigned long watermark)
> @@ -387,6 +399,13 @@ static bool sgx_should_reclaim(unsigned long waterma=
rk)
>  	       !list_empty(&sgx_global_lru.reclaimable);
>  }
> =20
> +static void sgx_reclaim_pages_global(void)
> +{
> +	unsigned int nr_to_scan =3D SGX_NR_TO_SCAN;
> +
> +	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan);
> +}
> +
>  /*
>   * sgx_reclaim_direct() should be called (without enclave's mutex held)
>   * in locations where SGX memory resources might be low and might be
> @@ -395,7 +414,7 @@ static bool sgx_should_reclaim(unsigned long watermar=
k)
>  void sgx_reclaim_direct(void)
>  {
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_pages();
> +		sgx_reclaim_pages_global();
>  }
> =20
>  static int ksgxd(void *p)
> @@ -418,7 +437,7 @@ static int ksgxd(void *p)
>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
> =20
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> -			sgx_reclaim_pages();
> +			sgx_reclaim_pages_global();
> =20
>  		cond_resched();
>  	}
> @@ -604,7 +623,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
bool reclaim)
>  		 * Need to do a global reclamation if cgroup was not full but free
>  		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
>  		 */
> -		sgx_reclaim_pages();
> +		sgx_reclaim_pages_global();
>  		cond_resched();
>  	}
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 0e99e9ae3a67..2593c013d091 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -110,6 +110,7 @@ void sgx_reclaim_direct(void);
>  void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
>  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
> +unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned in=
t *nr_to_scan);
> =20
>  void sgx_ipi_cb(void *info);
> =20


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

