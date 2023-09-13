Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B5079E410
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbjIMJq0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIMJq0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 05:46:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC9199E;
        Wed, 13 Sep 2023 02:46:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5994AC433C8;
        Wed, 13 Sep 2023 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694598381;
        bh=TAuV6GLlzFJQ0bcVvBb3QY5ZH6PaZoo0XdL+52Pgtuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/13rqsUiPDMmHD9VWDHTbqsJaNpGA11cTKPDjP4oG/c+WCkr0vbuhN1l9hXFj+vP
         9OAImUb5s4eaqcw3AonTOX1njYNZYagpu86/pIj/JEt94V3DRiHIyJLErMis5fQQgJ
         pQipWwYFU6tr5jzYHDLocr4llbHftb8tVxbC3xEj4+FsedSnmkGsDgddD51vK37D5s
         vGA3avJUK445jHoei9o3ernFZ8PpRNeNlooULEgghfQ2t5p+SyWjTMM36wmGEG/DG4
         XIAR2eMET9cODcaTuPt/9RgYjk+TENyCkLu6syLQQS86WMo5NeJ7GZQhxopjzRBCZw
         Ls6lYmHxdJA1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 12:46:16 +0300
Message-Id: <CVHOZMZHDPIE.225HW6UH95GX9@suppilovahvero>
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
Subject: Re: [PATCH v4 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate
 LRU lists
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-4-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-4-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Introduce a data structure to wrap the existing reclaimable list and its
> spinlock. Each cgroup later will have one instance of this structure to
> track EPC pages allocated for processes associated with the same cgroup.
> Just like the global SGX reclaimer (ksgxd), an EPC cgroup reclaims pages
> from the reclaimable list in this structure when its usage reaches near
> its limit.
>
> Currently, ksgxd does not track the VA, SECS pages. They are considered
> as 'unreclaimable' pages that are only deallocated when their respective
> owning enclaves are destroyed and all associated resources released.
>
> When an EPC cgroup can not reclaim any more reclaimable EPC pages to
> reduce its usage below its limit, the cgroup must also reclaim those
> unreclaimables by killing their owning enclaves. The VA and SECS pages
> later are also tracked in an 'unreclaimable' list added to this structure
> to support this OOM killing of enclaves.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Removed unneeded comments for the spinlock and the non-reclaimables.
> (Kai, Jarkko)
> - Revised the commit to add introduction comments for unreclaimables and
> multiple LRU lists.(Kai)
> - Reordered the patches: delay all changes for unreclaimables to
> later, and this one becomes the first change in the SGX subsystem.
>
> V3:
> - Removed the helper functions and revised commit messages.
> ---
>  arch/x86/kernel/cpu/sgx/sgx.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index d2dad21259a8..018414b2abe8 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -83,6 +83,20 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_e=
pc_page *page)
>  	return section->virt_addr + index * PAGE_SIZE;
>  }
> =20
> +/*
> + * Tracks EPC pages reclaimable by the reclaimer (ksgxd).
> + */
> +struct sgx_epc_lru_lists {
> +	spinlock_t lock;
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
>

Looks good but not yet time for ack'ing.

BR, Jarkko
