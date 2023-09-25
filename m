Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF87ADDA5
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjIYRNQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjIYRNP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 13:13:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097610D;
        Mon, 25 Sep 2023 10:13:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57CBC433C9;
        Mon, 25 Sep 2023 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695661988;
        bh=A04TBKQ9EaZ8h6nIRrSl341lekUEgs14YQFeEcsK2sU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=YqRXCpobNGI2ZvFXzm7bANtIUOLyp9bNBrNuO9g/koJG5URsJq2taXA/PmoViqcU9
         kSSocwafEIGF8Xo2F/yaWq7uvk+UvsYmRWfBxJ/TcNF6dGTniPr7PGzKNP2oJys55d
         znZpQNf7KQRQK13M8RN/QwBA3C68USXYe+OvwwW+yDTCVnB5Rc9Mox0BmGjkGZnMtg
         FkDGeetsCD2psosUJxwl9Fyu2ZbOR2weZeHFk37DHE0IPfWnKbItE+xqc3NZe4bKiF
         44jnRbHDL1BdwhsSH2KzQ7MHa7j4vv6I37UHxa3sEff4PuSTzqe57dHT1dv/sM7sfq
         UIVvUvZ2Ruq/A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 20:13:02 +0300
Message-Id: <CVS609055DZI.1VYY4JB3YLOIZ@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v5 07/18] x86/sgx: Introduce RECLAIM_IN_PROGRESS state
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-8-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-8-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat Sep 23, 2023 at 6:06 AM EEST, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Add RECLAIM_IN_PROGRESS state to not rely on list_empty(&epc_page->list)
> to determine if an EPC page is selected as a reclaiming candidate.
>
> When a page is being reclaimed from the page pool (sgx_global_lru),
> there is an intermediate stage where a page may have been identified as
> a candidate for reclaiming, but has not yet been reclaimed.  Currently
> such pages are list_del_init()'d from the global LRU list, and stored in
> a an array on stack. To prevent another thread from dropping the same
> page in the middle of reclaiming, sgx_drop_epc_page() checks for
> list_empty(&epc_page->list).
>
> A later patch will replace the array on stack with a temporary list to
> store the candidate pages, so list_empty() should no longer be used for
> this purpose.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Fixed some typos.
> - Revised commit message.
>
> V3:
> - Extend the sgx_epc_page_state enum introduced earlier to replace the
> flag based approach.
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 21 ++++++++++-----------
>  arch/x86/kernel/cpu/sgx/sgx.h  | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index b26860399402..c1ae19a154d0 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -312,13 +312,15 @@ static void sgx_reclaim_pages(void)
>  		list_del_init(&epc_page->list);
>  		encl_page =3D epc_page->owner;
> =20
> -		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0)
> +		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0) {
> +			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
>  			chunk[cnt++] =3D epc_page;
> -		else
> +		} else {
>  			/* The owner is freeing the page. No need to add the
>  			 * page back to the list of reclaimable pages.
>  			 */
>  			sgx_epc_page_reset_state(epc_page);
> +		}
>  	}
>  	spin_unlock(&sgx_global_lru.lock);
> =20
> @@ -528,16 +530,13 @@ void sgx_record_epc_page(struct sgx_epc_page *page,=
 unsigned long flags)
>  int sgx_drop_epc_page(struct sgx_epc_page *page)
>  {
>  	spin_lock(&sgx_global_lru.lock);
> -	if (sgx_epc_page_reclaimable(page->flags)) {
> -		/* The page is being reclaimed. */
> -		if (list_empty(&page->list)) {
> -			spin_unlock(&sgx_global_lru.lock);
> -			return -EBUSY;
> -		}
> -
> -		list_del(&page->list);
> -		sgx_epc_page_reset_state(page);
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
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 2faeb40b345f..764cec23f4e5 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -40,6 +40,8 @@ enum sgx_epc_page_state {
> =20
>  	/* Page is in use and tracked in a reclaimable LRU list
>  	 * Becomes NOT_TRACKED after sgx_drop_epc()
> +	 * Becomes RECLAIM_IN_PROGRESS in sgx_reclaim_pages() when identified
> +	 * for reclaiming
>  	 */
>  	SGX_EPC_PAGE_RECLAIMABLE =3D 2,
> =20
> @@ -50,6 +52,14 @@ enum sgx_epc_page_state {
>  	 */
>  	SGX_EPC_PAGE_UNRECLAIMABLE =3D 3,
> =20
> +	/* Page is being prepared for reclamation, tracked in a temporary
> +	 * isolated list by the reclaimer.
> +	 * Changes in sgx_reclaim_pages() back to RECLAIMABLE if preparation
> +	 * fails for any reason.
> +	 * Becomes NOT_TRACKED if reclaimed successfully in sgx_reclaim_pages()
> +	 * and immediately sgx_free_epc() is called to make it FREE.
> +	 */
> +	SGX_EPC_PAGE_RECLAIM_IN_PROGRESS =3D 4,
>  };
> =20
>  #define SGX_EPC_PAGE_STATE_MASK GENMASK(2, 0)
> @@ -73,6 +83,12 @@ static inline void sgx_epc_page_set_state(struct sgx_e=
pc_page *page, unsigned lo
>  	page->flags |=3D (flags & SGX_EPC_PAGE_STATE_MASK);
>  }
> =20
> +static inline bool sgx_epc_page_reclaim_in_progress(unsigned long flags)
> +{
> +	return SGX_EPC_PAGE_RECLAIM_IN_PROGRESS =3D=3D (flags &
> +						    SGX_EPC_PAGE_STATE_MASK);
> +}

	return SGX_EPC_PAGE_RECLAIM_IN_PROGRESS =3D=3D (flags & SGX_EPC_PAGE_STATE=
_MASK);

> +
>  static inline bool sgx_epc_page_reclaimable(unsigned long flags)
>  {
>  	return SGX_EPC_PAGE_RECLAIMABLE =3D=3D (flags & SGX_EPC_PAGE_STATE_MASK=
);
> --=20
> 2.25.1


BR, Jarkko
