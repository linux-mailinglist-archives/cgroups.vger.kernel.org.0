Return-Path: <cgroups+bounces-1307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F384646F
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 00:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BEF2815F9
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 23:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509F47F42;
	Thu,  1 Feb 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjXmjDph"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA747F47;
	Thu,  1 Feb 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830152; cv=none; b=L13B1jCIPf8Ld/RECIMrBzSsPQ+v3foqCnKzL41D182XylnjzLX+HpqcWTMXDuboKpDiuxulNJh9vSoaFR6rs+Ay9EX3b6kN4l9f70iFRsDbvdVA6XwSuyCk479GSpA71tzd/o1fO0bUGOMEuyNI3D67eIxEMD7TFKFOBtFrYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830152; c=relaxed/simple;
	bh=V0z0j1fmQzYkqQhKlARVjGNz5b6cBH2HYGJViqrZcYg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nYK17LzsI1zSiJTmFyDWmx5OgIESTFhAIP2Uizbkva6jKhCIeZP4+h6LdZZwe5jG1g1RFutbmZCSq7bjiitvhPgSEnq5kXJ15lyFSYPRv/wXTQ4vOckf3bII19PQGLcXBBpVPWztknfLSO7zcIUWt5w7/5Ru8rJB7NLmumJ8LuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjXmjDph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3136AC433C7;
	Thu,  1 Feb 2024 23:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706830152;
	bh=V0z0j1fmQzYkqQhKlARVjGNz5b6cBH2HYGJViqrZcYg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TjXmjDph+ub5KQg376WPXwl0z7D/aTeVKpUy8aByzio+QaeO9e1Ta08lX/SVMU+kc
	 sm2DwPNx8bPnXjwf8tIXIrM8wp1W4YOy5VVHU3ivDg1Pz1SZC+NwVuYJZNFZIE1cTP
	 gAu7mFlwuJxwkWDJ4sITF5yUa2pdPAUVy0PdjDAkrFq7O1Yzh4WHDF20fxCUcMqeJe
	 yM2buHFEYpL6tyDuJkJuW8N4m2tzvPezVAUIS3itnUkO5tw23eAJit9nNM+SsM5yVA
	 pS7mKWrZbadiXxIkvkV693W4wwIKIV7MoX4/JrF4hNuYDd7Y7cDK5jnuxT7FtQaTk2
	 gIbL0LiI+of+w==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:29:06 +0200
Message-Id: <CYU4SGK6D2BZ.3TSKS97D4OXEV@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 06/15] x86/sgx: Abstract tracking reclaimable pages
 in LRU
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-7-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-7-haitao.huang@linux.intel.com>

On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> The functions, sgx_{mark,unmark}_page_reclaimable(), manage the tracking
> of reclaimable EPC pages: sgx_mark_page_reclaimable() adds a newly
> allocated page into the global LRU list while
> sgx_unmark_page_reclaimable() does the opposite. Abstract the hard coded
> global LRU references in these functions to make them reusable when
> pages are tracked in per-cgroup LRUs.
>
> Create a helper, sgx_lru_list(), that returns the LRU that tracks a given
> EPC page. It simply returns the global LRU now, and will later return
> the LRU of the cgroup within which the EPC page was allocated. Replace
> the hard coded global LRU with a call to this helper.
>
> Next patches will first get the cgroup reclamation flow ready while
> keeping pages tracked in the global LRU and reclaimed by ksgxd before we
> make the switch in the end for sgx_lru_list() to return per-cgroup
> LRU.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 912959c7ecc9..a131aa985c95 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -32,6 +32,11 @@ static DEFINE_XARRAY(sgx_epc_address_space);
>   */
>  static struct sgx_epc_lru_list sgx_global_lru;
> =20
> +static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page =
*epc_page)
> +{
> +	return &sgx_global_lru;
> +}
> +
>  static atomic_long_t sgx_nr_free_pages =3D ATOMIC_LONG_INIT(0);
> =20
>  /* Nodes with one or more EPC sections. */
> @@ -500,25 +505,24 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  }
> =20
>  /**
> - * sgx_mark_page_reclaimable() - Mark a page as reclaimable
> + * sgx_mark_page_reclaimable() - Mark a page as reclaimable and track it=
 in a LRU.
>   * @page:	EPC page
> - *
> - * Mark a page as reclaimable and add it to the active page list. Pages
> - * are automatically removed from the active list when freed.
>   */
>  void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
>  {
> -	spin_lock(&sgx_global_lru.lock);
> +	struct sgx_epc_lru_list *lru =3D sgx_lru_list(page);
> +
> +	spin_lock(&lru->lock);
>  	page->flags |=3D SGX_EPC_PAGE_RECLAIMER_TRACKED;
> -	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
> -	spin_unlock(&sgx_global_lru.lock);
> +	list_add_tail(&page->list, &lru->reclaimable);
> +	spin_unlock(&lru->lock);
>  }
> =20
>  /**
> - * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
> + * sgx_unmark_page_reclaimable() - Remove a page from its tracking LRU
>   * @page:	EPC page
>   *
> - * Clear the reclaimable flag and remove the page from the active page l=
ist.
> + * Clear the reclaimable flag if set and remove the page from its LRU.
>   *
>   * Return:
>   *   0 on success,
> @@ -526,18 +530,20 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page =
*page)
>   */
>  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
>  {
> -	spin_lock(&sgx_global_lru.lock);
> +	struct sgx_epc_lru_list *lru =3D sgx_lru_list(page);
> +
> +	spin_lock(&lru->lock);
>  	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
>  		/* The page is being reclaimed. */
>  		if (list_empty(&page->list)) {
> -			spin_unlock(&sgx_global_lru.lock);
> +			spin_unlock(&lru->lock);
>  			return -EBUSY;
>  		}
> =20
>  		list_del(&page->list);
>  		page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_global_lru.lock);
> +	spin_unlock(&lru->lock);
> =20
>  	return 0;
>  }

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

