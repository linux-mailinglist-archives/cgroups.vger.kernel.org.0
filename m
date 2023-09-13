Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C479ED38
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIMPgd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjIMPgW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:36:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2071ACE;
        Wed, 13 Sep 2023 08:36:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A5C433C8;
        Wed, 13 Sep 2023 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694619377;
        bh=jPkGjxr4rba/luvWG/LZeVxI4pDva6nFdt/vUf82FOo=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=X1WpkCXAlTDnkCy3Z7LzujlfdicVZuw40Gxod/WynA/ogZaUFIGZ2L4Pq7PZmlWv9
         zyzegSzmQelSI5Hq8pc5HhozWr9hPSGidkFcqogbbzV6zd/bCCtq6KT61uKR7Rt50J
         LML/WJq+8E1K524rf4q6dZvqzlIXAyIyDcGPsiU4cuPhGsgPyRs4qxgz6urFuMsKfZ
         jzZsQLEF8wZBM3gjSPPDJ4M7oaByt7zYTirGYDyXRqRORz0+15mv/p1WH37MVxARw+
         vr/r6z18kHCu2CLZaJN9yeopioV/UxbUAGMXj6KPc14OJxqlO2QsWU99v7+k6svjju
         RnVmh4h+Jo9+w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:36:12 +0300
Message-Id: <CVHWFKHRNNB2.1ST4QHR6RVH66@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 13/18] x86/sgx: Expose sgx_reclaim_pages() for use by
 EPC cgroup
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-14-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-14-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Adjust and expose the top-level reclaim function as
> sgx_reclaim_epc_pages() for use by the upcoming EPC cgroup, which will
> initiate reclaim to enforce the max limit.
>
> Make these adjustments to the function signature.
>
> 1) To take a parameter that specifies the number of pages to scan for
> reclaiming. Define a max value of 32, but scan 16 in the case for the
> global reclaimer (ksgxd). The EPC cgroup will use it to specify a
> desired number of pages to be reclaimed up to the max value of 32.
>
> 2) To take a flag to force reclaiming a page regardless of its age.  The
> EPC cgroup will use the flag to enforce its limits by draining the
> reclaimable lists before resorting to other measures, e.g. forcefully
> kill enclaves.
>
> 3) Return the number of reclaimed pages. The EPC cgroup will use the
> result to track reclaiming progress and escalate to a more forceful
> reclaiming mode, e.g., calling this function with the flag to ignore age
> of pages.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Combined the 3 patches that made the individual changes to the
> function signature.
> - Removed 'high' limit in commit message.
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 30 ++++++++++++++++++++----------
>  arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
>  2 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index c8900d62cfff..e1dde431a400 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -17,6 +17,10 @@
>  #include "driver.h"
>  #include "encl.h"
>  #include "encls.h"

newline here

> +/**

/*

> + * Maximum number of pages to scan for reclaiming.
> + */
> +#define SGX_NR_TO_SCAN_MAX	32
> =20
>  struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
>  static int sgx_nr_epc_sections;
> @@ -279,7 +283,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page =
*epc_page,
>  	mutex_unlock(&encl->lock);
>  }
> =20
> -/*
> +/**
> + * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
> + * @nr_to_scan:		 Number of EPC pages to scan for reclaim
> + * @ignore_age:		 Reclaim a page even if it is young
> + *
>   * Take a fixed number of pages from the head of the active page pool an=
d
>   * reclaim them to the enclave's private shmem files. Skip the pages, wh=
ich have
>   * been accessed since the last scan. Move those pages to the tail of ac=
tive
> @@ -292,15 +300,15 @@ static void sgx_reclaimer_write(struct sgx_epc_page=
 *epc_page,
>   * problematic as it would increase the lock contention too much, which =
would
>   * halt forward progress.
>   */
> -static void sgx_reclaim_pages(void)
> +size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
>  {
> -	struct sgx_backing backing[SGX_NR_TO_SCAN];
> +	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
>  	struct sgx_epc_page *epc_page, *tmp;
>  	struct sgx_encl_page *encl_page;
>  	pgoff_t page_index;
>  	LIST_HEAD(iso);
> -	int ret;
> -	int i;
> +	size_t ret;
> +	size_t i;

I don't mind having these in separate lines but you could also

	size_t ret, i;

> =20
>  	spin_lock(&sgx_global_lru.lock);
>  	for (i =3D 0; i < SGX_NR_TO_SCAN; i++) {
> @@ -326,13 +334,14 @@ static void sgx_reclaim_pages(void)
>  	spin_unlock(&sgx_global_lru.lock);
> =20
>  	if (list_empty(&iso))
> -		return;
> +		return 0;
> =20
>  	i =3D 0;
>  	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
>  		encl_page =3D epc_page->encl_page;
> =20
> -		if (!sgx_reclaimer_age(epc_page))
> +		if (i =3D=3D SGX_NR_TO_SCAN_MAX ||
> +		    (!ignore_age && !sgx_reclaimer_age(epc_page)))
>  			goto skip;
> =20
>  		page_index =3D PFN_DOWN(encl_page->desc - encl_page->encl->base);
> @@ -371,6 +380,7 @@ static void sgx_reclaim_pages(void)
> =20
>  		sgx_free_epc_page(epc_page);
>  	}

newline

> +	return i;
>  }
> =20
>  static bool sgx_should_reclaim(unsigned long watermark)
> @@ -387,7 +397,7 @@ static bool sgx_should_reclaim(unsigned long watermar=
k)
>  void sgx_reclaim_direct(void)
>  {
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_pages();
> +		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
>  }
> =20
>  static int ksgxd(void *p)
> @@ -410,7 +420,7 @@ static int ksgxd(void *p)
>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
> =20
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> -			sgx_reclaim_pages();
> +			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
> =20
>  		cond_resched();
>  	}
> @@ -582,7 +592,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
bool reclaim)
>  			break;
>  		}
> =20
> -		sgx_reclaim_pages();
> +		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
>  		cond_resched();
>  	}
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 3818be5a8bd3..aa4ec2c0ce96 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -177,6 +177,7 @@ void sgx_record_epc_page(struct sgx_epc_page *page, u=
nsigned long flags);
>  int sgx_drop_epc_page(struct sgx_epc_page *page);
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
>  bool sgx_epc_oom(struct sgx_epc_lru_lists *lrus);
> +size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age);
> =20
>  void sgx_ipi_cb(void *info);
> =20
> --=20
> 2.25.1

BR, Jarkko
