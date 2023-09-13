Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742279EBE4
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbjIMPBG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbjIMPBE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:01:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B2E3;
        Wed, 13 Sep 2023 08:01:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED32C433C8;
        Wed, 13 Sep 2023 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694617260;
        bh=HSdEtrygzqfkzkBkJZg8xVNxTnlq6f0NK4eV4pRksxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ll37QBssXbUE+/gqNfjCW21z6o4T/ILJpIF/+0yFJ1FdlmP4avuZsJ51DiMg4IWjf
         cZozJPQXEMV/0cGTn2pqze66C3QLiUPr6XWtNzjtzQWABjZHvAqmL2pA6OI37WQj6F
         fYCu2lo9yNyNG8RopMh9qkLEGwkr6+LNXgP84mj0DTR3UHVOp3713qYbkKnby9zWTR
         WtCMs7yqD+klI4HazpC91VAr/evuX+A3oSI2p9ZNS10ysXySp0ubYR1hBzYKaD0tZY
         N2PoSnetyh39vONDdSXUma9wmVJ7j/56QAeYUWPuE6VzlUZI3PNSRhUB8WFUynTPWA
         5DEkQUcS+d1ng==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:00:54 +0300
Message-Id: <CVHVOJEJZEZ1.25VFM2W8FTU8R@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 04/18] x86/sgx: Use sgx_epc_lru_lists for existing
 active page list
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-5-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-5-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> All EPC pages of enclaves including VA and SECS will be tracked in

s/VA/Version Array (VA)/
s/SECS/SGX Enclave Control Structure (SECS)/

Just a nitpick, because it is always good to remind what these acronyms
are (there are so many of them in this world).

> sgx_epc_lru_lists structs, one per cgroup. For now just replace the
> existing sgx_active_page_list in the reclaimer and its spinlock with a
> global sgx_epc_lru_lists struct. VA and SECS pages are still not tracked
> at this point but they will be tracked after an unreclaimable LRU list
> is added to the sgx_epc_lru_lists struct.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - No change, only reordered the patch.
>
> V3:
> - Remove usage of list wrapper
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 39 +++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 166692f2d501..afce51d6e94a 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -26,10 +26,9 @@ static DEFINE_XARRAY(sgx_epc_address_space);
> =20
>  /*
>   * These variables are part of the state of the reclaimer, and must be a=
ccessed
> - * with sgx_reclaimer_lock acquired.
> + * with sgx_global_lru.lock acquired.
>   */
> -static LIST_HEAD(sgx_active_page_list);
> -static DEFINE_SPINLOCK(sgx_reclaimer_lock);
> +static struct sgx_epc_lru_lists sgx_global_lru;
> =20
>  static atomic_long_t sgx_nr_free_pages =3D ATOMIC_LONG_INIT(0);
> =20
> @@ -304,13 +303,13 @@ static void sgx_reclaim_pages(void)
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
> @@ -322,7 +321,7 @@ static void sgx_reclaim_pages(void)
>  			 */
>  			epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>  	}
> -	spin_unlock(&sgx_reclaimer_lock);
> +	spin_unlock(&sgx_global_lru.lock);
> =20
>  	for (i =3D 0; i < cnt; i++) {
>  		epc_page =3D chunk[i];
> @@ -345,9 +344,9 @@ static void sgx_reclaim_pages(void)
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
> @@ -378,7 +377,7 @@ static void sgx_reclaim_pages(void)
>  static bool sgx_should_reclaim(unsigned long watermark)
>  {
>  	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
> -	       !list_empty(&sgx_active_page_list);
> +	       !list_empty(&sgx_global_lru.reclaimable);
>  }
> =20
>  /*
> @@ -430,6 +429,8 @@ static bool __init sgx_page_reclaimer_init(void)
> =20
>  	ksgxd_tsk =3D tsk;
> =20
> +	sgx_lru_init(&sgx_global_lru);
> +
>  	return true;
>  }
> =20
> @@ -505,10 +506,10 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
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
> @@ -523,18 +524,18 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page =
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
> @@ -567,7 +568,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
bool reclaim)
>  			break;
>  		}
> =20
> -		if (list_empty(&sgx_active_page_list))
> +		if (list_empty(&sgx_global_lru.reclaimable))
>  			return ERR_PTR(-ENOMEM);
> =20
>  		if (!reclaim) {
> --=20
> 2.25.1

Other than that looks good to me (including the commit description).

BR, Jarkko
