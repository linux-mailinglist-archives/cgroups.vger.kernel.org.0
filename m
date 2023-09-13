Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898D179EC45
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbjIMPPD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIMPPC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:15:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36F9B9;
        Wed, 13 Sep 2023 08:14:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F150C433C8;
        Wed, 13 Sep 2023 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694618098;
        bh=pTDyhJheOM8oYQVYb1i1BIBEi3yfnH8npT9elILsRLY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=g093mv9lfjO4WQvBEULhz5Xir/rbQI5GsaLZ5Hd06mJYTIKwr+vQlL++8NmOWkjuE
         /X8hPGuVvi1bmkifiM5TzMxK28IuB3lNMcGy+IFuvEViTQksoMOihDr1UxiVlAuzBD
         9gk24fkNBPbI6WlpRU6CgiBwCPH1I56AuJb7/abXXVZSwjZDDmHjeRk59Fh+wpNlMm
         V9M+iEpdwE25xXCWPo3gi8+58nPNix8XofnEw/AE8Nw5j5LHDd7GXO9ruubJEwdr/4
         LX7s0Fy843CAjE8gQ9jRP+tAeJ6cOapnO0tjyvs5DvwPE018UlmgZ95eRIUmO81Q2l
         3+/JuTgdFVAcw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:14:53 +0300
Message-Id: <CVHVZ8OIRYXE.2AJR5ZD0HBLHQ@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 05/18] x86/sgx: Store reclaimable EPC pages in
 sgx_epc_lru_lists
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-6-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-6-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Replace sgx_mark_page_reclaimable() and sgx_unmark_page_reclaimable()
> with sgx_record_epc_page() and sgx_drop_epc_page(). The
> sgx_record_epc_page() function adds the epc_page to the "reclaimable"
> list in the sgx_epc_lru_lists struct, while sgx_drop_epc_page() removes
> the page from the LRU list.
>
> For now, this change serves as a straightforward replacement of the two
> functions for pages tracked by the reclaimer. When the unreclaimable
> list is added to track VA and SECS pages for cgroups, these functions
> will be updated to add/remove them from the unreclaimable lists.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Code update needed for patch reordering
> - Revised commit message.
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  |  8 +++++---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 10 ++++++----
>  arch/x86/kernel/cpu/sgx/main.c  | 22 ++++++++++++----------
>  arch/x86/kernel/cpu/sgx/sgx.h   |  4 ++--
>  4 files changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 279148e72459..f84ee2eeb058 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -272,7 +272,8 @@ static struct sgx_encl_page *__sgx_encl_load_page(str=
uct sgx_encl *encl,
>  		return ERR_CAST(epc_page);
> =20
>  	encl->secs_child_cnt++;
> -	sgx_mark_page_reclaimable(entry->epc_page);
> +	sgx_record_epc_page(epc_page,
> +			    SGX_EPC_PAGE_RECLAIMER_TRACKED);

	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);

... even less than 80 characters (100 is the max these days)

> =20
>  	return entry;
>  }
> @@ -398,7 +399,8 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_s=
truct *vma,
>  	encl_page->type =3D SGX_PAGE_TYPE_REG;
>  	encl->secs_child_cnt++;
> =20
> -	sgx_mark_page_reclaimable(encl_page->epc_page);
> +	sgx_record_epc_page(epc_page,
> +			    SGX_EPC_PAGE_RECLAIMER_TRACKED);

Ditto.

> =20
>  	phys_addr =3D sgx_get_epc_phys_addr(epc_page);
>  	/*
> @@ -714,7 +716,7 @@ void sgx_encl_release(struct kref *ref)
>  			 * The page and its radix tree entry cannot be freed
>  			 * if the page is being held by the reclaimer.
>  			 */
> -			if (sgx_unmark_page_reclaimable(entry->epc_page))
> +			if (sgx_drop_epc_page(entry->epc_page))
>  				continue;
> =20
>  			sgx_encl_free_epc_page(entry->epc_page);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index 5d390df21440..0d79dec408af 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -322,7 +322,8 @@ static int sgx_encl_add_page(struct sgx_encl *encl, u=
nsigned long src,
>  			goto err_out;
>  	}
> =20
> -	sgx_mark_page_reclaimable(encl_page->epc_page);
> +	sgx_record_epc_page(epc_pag
> +			    SGX_EPC_PAGE_RECLAIMER_TRACKED);

Ditto.

>  	mutex_unlock(&encl->lock);
>  	mmap_read_unlock(current->mm);
>  	return ret;
> @@ -961,7 +962,7 @@ static long sgx_enclave_modify_types(struct sgx_encl =
*encl,
>  			 * Prevent page from being reclaimed while mutex
>  			 * is released.
>  			 */
> -			if (sgx_unmark_page_reclaimable(entry->epc_page)) {
> +			if (sgx_drop_epc_page(entry->epc_page)) {
>  				ret =3D -EAGAIN;
>  				goto out_entry_changed;
>  			}
> @@ -976,7 +977,8 @@ static long sgx_enclave_modify_types(struct sgx_encl =
*encl,
> =20
>  			mutex_lock(&encl->lock);
> =20
> -			sgx_mark_page_reclaimable(entry->epc_page);
> +			sgx_record_epc_page(entry->epc_page,
> +					    SGX_EPC_PAGE_RECLAIMER_TRACKED);

Ditto.

>  		}
> =20
>  		/* Change EPC type */
> @@ -1133,7 +1135,7 @@ static long sgx_encl_remove_pages(struct sgx_encl *=
encl,
>  			goto out_unlock;
>  		}
> =20
> -		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
> +		if (sgx_drop_epc_page(entry->epc_page)) {
>  			ret =3D -EBUSY;
>  			goto out_unlock;
>  		}
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index afce51d6e94a..dec1d57cbff6 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -268,7 +268,6 @@ static void sgx_reclaimer_write(struct sgx_epc_page *=
epc_page,
>  			goto out;
> =20
>  		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
> -
>  		sgx_encl_free_epc_page(encl->secs.epc_page);
>  		encl->secs.epc_page =3D NULL;
> =20
> @@ -498,31 +497,34 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  }
> =20
>  /**
> - * sgx_mark_page_reclaimable() - Mark a page as reclaimable
> + * sgx_record_epc_page() - Add a page to the appropriate LRU list
>   * @page:	EPC page
> + * @flags:	The type of page that is being recorded
>   *
> - * Mark a page as reclaimable and add it to the active page list. Pages
> - * are automatically removed from the active list when freed.
> + * Mark a page with the specified flags and add it to the appropriate
> + * list.
>   */
> -void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
> +void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
>  {
>  	spin_lock(&sgx_global_lru.lock);
> -	page->flags |=3D SGX_EPC_PAGE_RECLAIMER_TRACKED;
> -	list_add_tail(&page->list, &sgx_global_lru.reclaimable);
> +	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	page->flags |=3D flags;
> +	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
> +		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
>  	spin_unlock(&sgx_global_lru.lock);
>  }
> =20
>  /**
> - * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
> + * sgx_drop_epc_page() - Remove a page from a LRU list
>   * @page:	EPC page
>   *
> - * Clear the reclaimable flag and remove the page from the active page l=
ist.
> + * Clear the reclaimable flag if set and remove the page from its LRU.
>   *
>   * Return:
>   *   0 on success,
>   *   -EBUSY if the page is in the process of being reclaimed
>   */
> -int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
> +int sgx_drop_epc_page(struct sgx_epc_page *page)
>  {
>  	spin_lock(&sgx_global_lru.lock);
>  	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 018414b2abe8..113d930fd087 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -101,8 +101,8 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void);
>  void sgx_free_epc_page(struct sgx_epc_page *page);
> =20
>  void sgx_reclaim_direct(void);
> -void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
> -int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
> +void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)=
;
> +int sgx_drop_epc_page(struct sgx_epc_page *page);
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
> =20
>  void sgx_ipi_cb(void *info);
> --=20
> 2.25.1

BR, Jarkko
