Return-Path: <cgroups+bounces-1207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B028373B6
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C321F22F0D
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0904776B;
	Mon, 22 Jan 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjbtv0+r"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EF547762;
	Mon, 22 Jan 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955317; cv=none; b=chE+ER1P98Z6nhAZUxGK87pkIBWIpd1Dcw2YS7qMieuRTWFpupfulO18vgA2zEGAGDs00WY41bgW+1LE79aSXD3TtnCR00AgYQjMG7AgogdKjaT8QVicmzam9hLF0qX4+gHTDHOdaDJK4usy1WWK/lAxaGdGr1yHg4IArYu3ABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955317; c=relaxed/simple;
	bh=bIGL6tbUXqQ2uLj87tFgXirMYlFANeSqFPG14ELd9/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Vql5tddv27USA38QDY6mu6D1JFvOAYlQtX4ZdQbAdsfLtBBuVJHG8q9ssoTvaGG933aiGz11R54pNXa1+ibFp0MI2VZxcSUE5brpQl2gwlwCtIMhp/GIDt0cUh7MfdTo+Tin5mMCOMO0kgj/MvbICsk8vCJa+ALmwvrLVkLQvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjbtv0+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9625BC43394;
	Mon, 22 Jan 2024 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955317;
	bh=bIGL6tbUXqQ2uLj87tFgXirMYlFANeSqFPG14ELd9/U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hjbtv0+rRmyWkp3KaPcgmOyAdUvYw+so1NMTIFa+bzw+CqfnPutBNvyBuKMixdb8A
	 hkG+LWyCKf+/xNZ1y5TFp0aMLgZaI7V66qhjV0aapl2XiZ8CL5Ly7GcvOigDKyQc2a
	 +0AvP9aHdORLNy/zXNGKgULDAgxjdclbPIxeLe5mn1RO0Y6GjM4jwb9APHmjLjYKrW
	 xvpyZtgH0kIaIF9pSlj/UA3cH0EJCjeJ0WBHkC4Be7YlN0+Xqw400+mjvE1oyk5UFy
	 gxfORte81L9T7LptxXsAvNqoboobpKEAmLa3m1ylRCTnup034OlW4g4UHA1wNHU6YY
	 TUrO0D0SdHlnQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 22:28:31 +0200
Message-Id: <CYLIOR19J0SG.2A6LWMNXTERV9@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v7 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-8-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-8-haitao.huang@linux.intel.com>

On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
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
> V7:
> - Reworked from patch 9 of V6, "x86/sgx: Restructure top-level EPC reclai=
m
> function". Do not split the top level function (Kai)
> - Dropped patches 7 and 8 of V6.
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 62 +++++++++++++++++++++-------------
>  arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
>  2 files changed, 40 insertions(+), 23 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index cde750688e62..60cb3a7b3001 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -286,20 +286,24 @@ static void sgx_reclaimer_write(struct sgx_epc_page=
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
 them to the enclave's
> + * private shmem files. Skip the pages, which have been accessed since t=
he last scan. Move
> + * those pages to the tail of the list so that the pages get scanned in =
LRU like fashion.
> + *
> + * Batch process a chunk of pages (at the moment 16) in order to degrade=
 amount of IPI's and
> + * ETRACK's potentially required. sgx_encl_ewb() does degrade a bit amon=
g the HW threads with
> + * three stage EWB pipeline (EWB, ETRACK + EWB and IPI + EWB) but not su=
fficiently. Reclaiming
> + * one page at a time would also be problematic as it would increase the=
 lock contention too
> + * much, which would halt forward progress.
>   *

I'd prefer 80 character paragraphs unless you absolutely need to go
beyond that. For normal text paragraph there's zero need.


> - * Batch process a chunk of pages (at the moment 16) in order to degrade=
 amount
> - * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degra=
de a bit
> - * among the HW threads with three stage EWB pipeline (EWB, ETRACK + EWB=
 and IPI
> - * + EWB) but not sufficiently. Reclaiming one page at a time would also=
 be
> - * problematic as it would increase the lock contention too much, which =
would
> - * halt forward progress.
> + * @lru:	The LRU from which pages are reclaimed.
> + * @nr_to_scan: Pointer to the target number of pages to scan, must be l=
ess than SGX_NR_TO_SCAN.
> + * Return:	Number of pages reclaimed.
>   */
> -static void sgx_reclaim_pages(void)
> +unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned in=
t *nr_to_scan)
>  {
>  	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
> @@ -310,10 +314,10 @@ static void sgx_reclaim_pages(void)
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
> @@ -328,7 +332,8 @@ static void sgx_reclaim_pages(void)
>  			 */
>  			epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_global_lru.lock);
> +
> +	spin_unlock(&lru->lock);
> =20
>  	for (i =3D 0; i < cnt; i++) {
>  		epc_page =3D chunk[i];
> @@ -351,9 +356,9 @@ static void sgx_reclaim_pages(void)
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
> @@ -366,6 +371,7 @@ static void sgx_reclaim_pages(void)
>  			sgx_reclaimer_block(epc_page);
>  	}
> =20
> +	ret =3D 0;
>  	for (i =3D 0; i < cnt; i++) {
>  		epc_page =3D chunk[i];
>  		if (!epc_page)
> @@ -378,7 +384,10 @@ static void sgx_reclaim_pages(void)
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
> @@ -387,6 +396,13 @@ static bool sgx_should_reclaim(unsigned long waterma=
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
> @@ -395,7 +411,7 @@ static bool sgx_should_reclaim(unsigned long watermar=
k)
>  void sgx_reclaim_direct(void)
>  {
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_pages();
> +		sgx_reclaim_pages_global();
>  }
> =20
>  static int ksgxd(void *p)
> @@ -418,7 +434,7 @@ static int ksgxd(void *p)
>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
> =20
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> -			sgx_reclaim_pages();
> +			sgx_reclaim_pages_global();
> =20
>  		cond_resched();
>  	}
> @@ -605,7 +621,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
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

BR, Jarkko

