Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C6756308
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGQMpu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGQMpt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 08:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6282FDA;
        Mon, 17 Jul 2023 05:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1C96104B;
        Mon, 17 Jul 2023 12:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC90C433C8;
        Mon, 17 Jul 2023 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689597941;
        bh=gO1fpIF4DrAPNB+QftjUHUJdhOei+AxWsZlYNQnSN+E=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=tMsP/BQ24EY3ad0FkSEF2GXd7wj/sMcuwrJdufSy1jZNXzcdRqx7rGNvPMwYUezXm
         zuPMvxT97kn3WQMolnkDvbWiywN5xoSsdCOZQ2Yv5hIHiGv4uyrVW8W9zrtpswA+rk
         zumJ26mCSHg1oa0pyZKDDTkTk8Wh5ExfiF6CQA/bb7VzFZ/2tzquH81WNw5hiaS7Lw
         YGttfb3x0HJEoqB0FQUMfUqy/aAzRG/zbgolX8CzyNFgp3eWEfikQbIxR55YrCsudK
         yRShGGCil31NE7bWJNz0M7meW7BDYJVaLWDGqT2S9To1jLrCUcJs6iRyzpwTJNOI6F
         K74NG/tTBoZPg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 12:45:36 +0000
Message-Id: <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        <zhiquan1.li@intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-4-haitao.huang@linux.intel.com>
In-Reply-To: <20230712230202.47929-4-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Introduce a data structure to wrap the existing reclaimable list
> and its spinlock in a struct to minimize the code changes needed
> to handle multiple LRUs as well as reclaimable and non-reclaimable
> lists. The new structure will be used in a following set of patches to
> implement SGX EPC cgroups.
>
> The changes to the structure needed for unreclaimable lists will be
> added in later patches.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
>
> V3:
> Removed the helper functions and revised commit messages
> ---
>  arch/x86/kernel/cpu/sgx/sgx.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index f6e3c5810eef..77fceba73a25 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -92,6 +92,23 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_e=
pc_page *page)
>  	return section->virt_addr + index * PAGE_SIZE;
>  }
> =20
> +/*
> + * This data structure wraps a list of reclaimable EPC pages, and a list=
 of
> + * non-reclaimable EPC pages and is used to implement a LRU policy durin=
g
> + * reclamation.
> + */
> +struct sgx_epc_lru_lists {
> +	/* Must acquire this lock to access */
> +	spinlock_t lock;

Isn't this self-explanatory, why the inline comment?

> +	struct list_head reclaimable;
> +};
> +
> +static inline void sgx_lru_init(struct sgx_epc_lru_lists *lrus)
> +{
> +	spin_lock_init(&lrus->lock);
> +	INIT_LIST_HEAD(&lrus->reclaimable);
> +}
> +
>  struct sgx_epc_page *__sgx_alloc_epc_page(void);
>  void sgx_free_epc_page(struct sgx_epc_page *page);
> =20
> --=20
> 2.25.1


BR, Jarkko
