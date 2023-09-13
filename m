Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53079ED05
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjIMPbL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjIMPa7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:30:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9732134;
        Wed, 13 Sep 2023 08:30:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B5CC433C8;
        Wed, 13 Sep 2023 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694619017;
        bh=lKT1zCMPEo4WR6takfNQBJuex3ue1YKnaoqmS2NcXV4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=SIZlypX6riIxigq0tGcN+L3buHFetTGzAsko/rwijlw+UQaEeIFUv1TDUyh34cOJg
         J2u61GpDM8H1dTC6YM3GRCQ+1KmZBkXU4MX3ItdkvzXTlNhptk/6UJ6A/9RT838m38
         NbONnCFWbdO9wexOvpM8DcSIYvo91pgl19Wmqjp+wQEPTvdEUbRnHmfuUM3kfMGkhd
         F7qqCQ+spbLf3mPVjB04U5nHDLlnphQHTA32xV/TsA8BXR1aiVbCzSD9Esq0s89E9b
         SIysmnzsrXvS1tdRHbxQuTqrYQcb0cXSfkIKRBOILRrt8M4beSDJJ7K0I/wOpunXkf
         TfEDv80rQgxiw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:30:11 +0300
Message-Id: <CVHWAYNF4W0Y.12Y1RIQ3M41CL@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 08/18] x86/sgx: Use a list to track to-be-reclaimed
 pages
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-9-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-9-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
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
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang<haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Changes needed for patch reordering
> - Revised commit message
>
> V3:
> - Removed list wrappers
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 40 +++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index c1ae19a154d0..fba06dc5abfe 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -293,12 +293,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page=
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
> @@ -314,18 +313,22 @@ static void sgx_reclaim_pages(void)
> =20
>  		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0) {
>  			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
> -			chunk[cnt++] =3D epc_page;
> +			list_move_tail(&epc_page->list, &iso);
>  		} else {
> -			/* The owner is freeing the page. No need to add the
> -			 * page back to the list of reclaimable pages.
> +			/* The owner is freeing the page, remove it from the
> +			 * LRU list
>  			 */
>  			sgx_epc_page_reset_state(epc_page);
> +			list_del_init(&epc_page->list);
>  		}
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
> @@ -340,6 +343,7 @@ static void sgx_reclaim_pages(void)
>  			goto skip;
>  		}
> =20
> +		i++;
>  		encl_page->desc |=3D SGX_ENCL_PAGE_BEING_RECLAIMED;
>  		mutex_unlock(&encl_page->encl->lock);
>  		continue;
> @@ -347,27 +351,19 @@ static void sgx_reclaim_pages(void)
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
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
>  		sgx_epc_page_reset_state(epc_page);
> --=20
> 2.25.1

LGTM

BR, Jarkko
