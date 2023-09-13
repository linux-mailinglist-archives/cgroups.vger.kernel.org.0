Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1FB79ED14
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjIMPdR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIMPdQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:33:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8927E3;
        Wed, 13 Sep 2023 08:33:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B0C433BC;
        Wed, 13 Sep 2023 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694619192;
        bh=wVm1k0TOJbmKVKWtuApWJmUkPsOLAVzqcEkW45pG0t8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=UHmcKKx5qUnYnb3/0P1QEmNeWfQB7o945kzpJpRvn/Z92HHaHAUML/t2cTbqRoidQ
         E2pLQDQJIagjk3Q0tdjmgeQArmROhqE4QgDVcP2tBGPi4Y7UI4xHsZ6ALXSG/28bvJ
         tktQcKyEvje4mTuClGdKF/gQsXLPD2rZKXwt9PHsITYO78CNA0AUnpwqQ73L7a6/eL
         O5RwXhxJgwOAnMPXULx9759yl+CSF5PLCblaAj0vx+J1o6oWDgsJRjgLTIyUKKxL3i
         Uh/3aaoXHCiYixp2HWNgAHdoGOC9O3+vHCxrNKtcQ+0V+koodiJ6WNknO4l+vMM1tO
         eWbZHrXoeDDYQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:33:07 +0300
Message-Id: <CVHWD79XTNDZ.11P43GDNRS5U0@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 11/18] x86/sgx: store unreclaimable pages in LRU
 lists
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-12-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-12-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> When an OOM event occurs, all pages associated with an enclave will need
> to be freed, including pages that are not currently tracked by the
> cgroup LRU lists.
>
> Add a new "unreclaimable" list to the sgx_epc_lru_lists struct and
> update the "sgx_record/drop_epc_pages()" functions for adding/removing
> VA and SECS pages to/from this "unreclaimable" list.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V4:
> - Updates for patch reordering.
> - Revised commit messages.
> - Revised comments for the list.
>
> V3:
> - Removed tracking virtual EPC pages in unreclaimable list as host
> kernel does not reclaim them. The EPC cgroups implemented later only
> blocks allocating for a guest if the limit is reached by returning
> -ENOMEM from sgx_alloc_epc_page() called by virt_epc, and does nothing
> else. Therefore, no need to track those in LRU lists.
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  | 2 ++
>  arch/x86/kernel/cpu/sgx/ioctl.c | 1 +
>  arch/x86/kernel/cpu/sgx/main.c  | 3 +++
>  arch/x86/kernel/cpu/sgx/sgx.h   | 8 +++++++-
>  4 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 91f83a5e543d..bf0ac3677ca8 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -748,6 +748,7 @@ void sgx_encl_release(struct kref *ref)
>  	xa_destroy(&encl->page_array);
> =20
>  	if (!encl->secs_child_cnt && encl->secs.epc_page) {
> +		sgx_drop_epc_page(encl->secs.epc_page);
>  		sgx_encl_free_epc_page(encl->secs.epc_page);
>  		encl->secs.epc_page =3D NULL;
>  	}
> @@ -756,6 +757,7 @@ void sgx_encl_release(struct kref *ref)
>  		va_page =3D list_first_entry(&encl->va_pages, struct sgx_va_page,
>  					   list);
>  		list_del(&va_page->list);
> +		sgx_drop_epc_page(va_page->epc_page);
>  		sgx_encl_free_epc_page(va_page->epc_page);
>  		kfree(va_page);
>  	}
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index 95ec20a6992f..8c23bb524674 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -48,6 +48,7 @@ void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_=
va_page *va_page)
>  	encl->page_cnt--;
> =20
>  	if (va_page) {
> +		sgx_drop_epc_page(va_page->epc_page);
>  		sgx_encl_free_epc_page(va_page->epc_page);
>  		list_del(&va_page->list);
>  		kfree(va_page);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index ed813288af44..f3a3ed894616 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -268,6 +268,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *=
epc_page,
>  			goto out;
> =20
>  		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
> +		sgx_drop_epc_page(encl->secs.epc_page);
>  		sgx_encl_free_epc_page(encl->secs.epc_page);
>  		encl->secs.epc_page =3D NULL;
> =20
> @@ -510,6 +511,8 @@ void sgx_record_epc_page(struct sgx_epc_page *page, u=
nsigned long flags)
>  	page->flags |=3D flags;
>  	if (sgx_epc_page_reclaimable(flags))
>  		list_add_tail(&page->list, &sgx_global_lru.reclaimable);
> +	else
> +		list_add_tail(&page->list, &sgx_global_lru.unreclaimable);
>  	spin_unlock(&sgx_global_lru.lock);
>  }
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index e06b4aadb6a1..e210af77f0cf 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -150,17 +150,23 @@ static inline void *sgx_get_epc_virt_addr(struct sg=
x_epc_page *page)
>  }
> =20
>  /*
> - * Tracks EPC pages reclaimable by the reclaimer (ksgxd).
> + * Contains EPC pages tracked by the reclaimer (ksgxd).
>   */
>  struct sgx_epc_lru_lists {
>  	spinlock_t lock;
>  	struct list_head reclaimable;
> +	/*
> +	 * Tracks SECS, VA pages,etc., pages only freeable after all its
> +	 * dependent reclaimables are freed.
> +	 */
> +	struct list_head unreclaimable;
>  };
> =20
>  static inline void sgx_lru_init(struct sgx_epc_lru_lists *lrus)
>  {
>  	spin_lock_init(&lrus->lock);
>  	INIT_LIST_HEAD(&lrus->reclaimable);
> +	INIT_LIST_HEAD(&lrus->unreclaimable);
>  }
> =20
>  struct sgx_epc_page *__sgx_alloc_epc_page(void);
> --=20
> 2.25.1

LGTM

BR, Jarkko
