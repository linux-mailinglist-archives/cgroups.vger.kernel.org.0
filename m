Return-Path: <cgroups+bounces-435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D457ED509
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 21:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5751F263C4
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E343AC8;
	Wed, 15 Nov 2023 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXjkHzBV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6243ABE
	for <cgroups@vger.kernel.org>; Wed, 15 Nov 2023 20:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D51C433D9;
	Wed, 15 Nov 2023 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700081986;
	bh=cGbVOGrDBir77EpazpzYMNtu/vjZuZ+xwCpP4c+mNjE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QXjkHzBV8aNvcErUZuxqfo4cSdxhQuEdcFH5/2XSvlrDdsF+O+tCXCUz3CrkVJz7L
	 0D8AJz1jc5BQlWGPEJdjpXZSorMzOUWX8ycfttw3ZlCNvew0NplH11NgmQe3eJ8vD7
	 Ec7kPiIY5O6vULChUallAi9zqmFsFdD8AZLkKtfJaIy3V4LsCT4OKDGzxtZt7DWDrE
	 9QiHb/sERKYQdu/+vbJR0VOgwjLnsWxwCuzge75XSP7+G1syNuXfSU3pDsHLAi7iiM
	 iPXksBS69hosBqHcsR4ecPZfrRJ1TAuRfknQFRm52VuJNH+6v8IoP4RuQEXftelxkQ
	 GCDLTL0WHU/Jg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 22:59:40 +0200
Message-Id: <CWZORJV320UP.1NJD0AI5M6QZT@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>, "Sean
 Christopherson" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 08/12] x86/sgx: Use a list to track to-be-reclaimed
 pages
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-9-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-9-haitao.huang@linux.intel.com>

On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Change sgx_reclaim_pages() to use a list rather than an array for
> storing the epc_pages which will be reclaimed. This change is needed
> to transition to the LRU implementation for EPC cgroup support.
>
> When the EPC cgroup is implemented, the reclaiming process will do a
> pre-order tree walk for the subtree starting from the limit-violating
> cgroup.  When each node is visited, candidate pages are selected from
> its "reclaimable" LRU list and moved into this temporary list. Passing a
> list from node to node for temporary storage in this walk is more
> straightforward than using an array.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang<haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang<haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V6:
> - Remove extra list_del_init and style fix (Kai)
>
> V4:
> - Changes needed for patch reordering
> - Revised commit message
>
> V3:
> - Removed list wrappers
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 35 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index e27ac73d8843..33bcba313d40 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -296,12 +296,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page=
 *epc_page,
>   */
>  static void sgx_reclaim_pages(void)
>  {
> -	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
> +	struct sgx_epc_page *epc_page, *tmp;
>  	struct sgx_encl_page *encl_page;
> -	struct sgx_epc_page *epc_page;
>  	pgoff_t page_index;
> -	int cnt =3D 0;
> +	LIST_HEAD(iso);
>  	int ret;
>  	int i;
> =20
> @@ -317,7 +316,7 @@ static void sgx_reclaim_pages(void)
> =20
>  		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0) {
>  			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
> -			chunk[cnt++] =3D epc_page;
> +			list_move_tail(&epc_page->list, &iso);
>  		} else
>  			/* The owner is freeing the page. No need to add the
>  			 * page back to the list of reclaimable pages.
> @@ -326,8 +325,11 @@ static void sgx_reclaim_pages(void)
>  	}
>  	spin_unlock(&sgx_global_lru.lock);
> =20
> -	for (i =3D 0; i < cnt; i++) {
> -		epc_page =3D chunk[i];
> +	if (list_empty(&iso))
> +		return;
> +
> +	i =3D 0;
> +	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>  		encl_page =3D epc_page->owner;
> =20
>  		if (!sgx_reclaimer_age(epc_page))
> @@ -342,6 +344,7 @@ static void sgx_reclaim_pages(void)
>  			goto skip;
>  		}
> =20
> +		i++;
>  		encl_page->desc |=3D SGX_ENCL_PAGE_BEING_RECLAIMED;
>  		mutex_unlock(&encl_page->encl->lock);
>  		continue;
> @@ -349,27 +352,19 @@ static void sgx_reclaim_pages(void)
>  skip:
>  		spin_lock(&sgx_global_lru.lock);
>  		sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIMABLE);
> -		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
> +		list_move_tail(&epc_page->list, &sgx_global_lru.reclaimable);
>  		spin_unlock(&sgx_global_lru.lock);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> -
> -		chunk[i] =3D NULL;
> -	}
> -
> -	for (i =3D 0; i < cnt; i++) {
> -		epc_page =3D chunk[i];
> -		if (epc_page)
> -			sgx_reclaimer_block(epc_page);
>  	}
> =20
> -	for (i =3D 0; i < cnt; i++) {
> -		epc_page =3D chunk[i];
> -		if (!epc_page)
> -			continue;
> +	list_for_each_entry(epc_page, &iso, list)
> +		sgx_reclaimer_block(epc_page);
> =20
> +	i =3D 0;
> +	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>  		encl_page =3D epc_page->owner;
> -		sgx_reclaimer_write(epc_page, &backing[i]);
> +		sgx_reclaimer_write(epc_page, &backing[i++]);

Couldn't you alternatively "&backing[--i]" and not reset i to zero
before the loop?

> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
>  		sgx_epc_page_reset_state(epc_page);

BR, Jarkko

