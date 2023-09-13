Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150E79ED0A
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjIMPby (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIMPbx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:31:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A89CE;
        Wed, 13 Sep 2023 08:31:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3937C433C8;
        Wed, 13 Sep 2023 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694619109;
        bh=EhqItz+H2MsjFJz+/18Og8YWkFsd0T+r6eF7rONaPsA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Lry9K9RseL4bki8X0L8Y8PgMZ0xUYqultkRbXCfCIN6VuPdY4g096ZE0VypQP4NUv
         zhNKUx+di9rKrPRc27mKWtas+aKBvdgAE9lAVFOeo0RnTdllahUh9Pj9IgxEoPYVLH
         QofZq94vJd82GNFPs9pN0pbsqtIrIV5ESskFRY4ZWFEnC4m1RBOUdW24zl8CmAseyZ
         yA2kAosgB8Xi9Sd5BFdjjV6GpHCYuGuGm/l8nnOkIU/8MYU2Y9ePnqskj4N80EHY5y
         Fg4fhJyx0lTR7OVjboq4aBbzZlZKRmEgEU955o4MYSm+5IHK3h7ssC+Yef9OhR63kQ
         /rm5aqLLZfN9w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:31:43 +0300
Message-Id: <CVHWC4XXK3DH.MKY8N7CE2JE6@suppilovahvero>
Subject: Re: [PATCH v4 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
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
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-10-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-10-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> In a later patch, when a cgroup has exceeded the max capacity for EPC
> pages, it may need to identify and OOM kill a less active enclave to
> make room for other enclaves within the same group. Such a victim
> enclave would have no active pages other than the unreclaimable Version
> Array (VA) and SECS pages.  Therefore, the cgroup needs examine its
> unreclaimable page list, and finding an enclave given a SECS page or a
> VA page. This will require a backpointer from a page to an enclave,
> which is not available for VA pages.
>
> Because struct sgx_epc_page instances of VA pages are not owned by an
> sgx_encl_page instance, mark their owner as sgx_encl: pass the struct
> sgx_encl of the enclave allocating the VA page to sgx_alloc_epc_page(),
> which will store this value in the owner field of the struct
> sgx_epc_page.  In a later patch, VA pages will be placed in an
> unreclaimable queue that can be examined by the cgroup to select the OOM
> killed enclave.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Changes needed for patch reordering
> - Revised commit messages (Jarkko)
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  |  5 +++--
>  arch/x86/kernel/cpu/sgx/encl.h  |  2 +-
>  arch/x86/kernel/cpu/sgx/ioctl.c |  2 +-
>  arch/x86/kernel/cpu/sgx/main.c  | 20 ++++++++++----------
>  arch/x86/kernel/cpu/sgx/sgx.h   |  5 ++++-
>  5 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index d11d4111aa98..1aee0ad00e66 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -1238,6 +1238,7 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, un=
signed long addr)
> =20
>  /**
>   * sgx_alloc_va_page() - Allocate a Version Array (VA) page
> + * @encl:    The enclave that this page is allocated to.

Maybe would more clear:

* @encl:	The new owner of the page

>   * @reclaim: Reclaim EPC pages directly if none available. Enclave
>   *           mutex should not be held if this is set.
>   *
> @@ -1247,12 +1248,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, =
unsigned long addr)
>   *   a VA page,
>   *   -errno otherwise
>   */
> -struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
> +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool recla=
im)
>  {
>  	struct sgx_epc_page *epc_page;
>  	int ret;
> =20
> -	epc_page =3D sgx_alloc_epc_page(NULL, reclaim);
> +	epc_page =3D sgx_alloc_epc_page(encl, reclaim);
>  	if (IS_ERR(epc_page))
>  		return ERR_CAST(epc_page);
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/enc=
l.h
> index f94ff14c9486..831d63f80f5a 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -116,7 +116,7 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_=
encl *encl,
>  					  unsigned long offset,
>  					  u64 secinfo_flags);
>  void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
> -struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
> +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool recla=
im);
>  unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
>  void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
>  bool sgx_va_page_full(struct sgx_va_page *va_page);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index c28f074d5d71..3ab8c050e665 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl=
, bool reclaim)
>  		if (!va_page)
>  			return ERR_PTR(-ENOMEM);
> =20
> -		va_page->epc_page =3D sgx_alloc_va_page(reclaim);
> +		va_page->epc_page =3D sgx_alloc_va_page(encl, reclaim);
>  		if (IS_ERR(va_page->epc_page)) {
>  			err =3D ERR_CAST(va_page->epc_page);
>  			kfree(va_page);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index fba06dc5abfe..ed813288af44 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -107,7 +107,7 @@ static unsigned long __sgx_sanitize_pages(struct list=
_head *dirty_page_list)
> =20
>  static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
>  {
> -	struct sgx_encl_page *page =3D epc_page->owner;
> +	struct sgx_encl_page *page =3D epc_page->encl_page;
>  	struct sgx_encl *encl =3D page->encl;
>  	struct sgx_encl_mm *encl_mm;
>  	bool ret =3D true;
> @@ -139,7 +139,7 @@ static bool sgx_reclaimer_age(struct sgx_epc_page *ep=
c_page)
> =20
>  static void sgx_reclaimer_block(struct sgx_epc_page *epc_page)
>  {
> -	struct sgx_encl_page *page =3D epc_page->owner;
> +	struct sgx_encl_page *page =3D epc_page->encl_page;
>  	unsigned long addr =3D page->desc & PAGE_MASK;
>  	struct sgx_encl *encl =3D page->encl;
>  	int ret;
> @@ -196,7 +196,7 @@ void sgx_ipi_cb(void *info)
>  static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
>  			 struct sgx_backing *backing)
>  {
> -	struct sgx_encl_page *encl_page =3D epc_page->owner;
> +	struct sgx_encl_page *encl_page =3D epc_page->encl_page;
>  	struct sgx_encl *encl =3D encl_page->encl;
>  	struct sgx_va_page *va_page;
>  	unsigned int va_offset;
> @@ -249,7 +249,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_pag=
e,
>  static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>  				struct sgx_backing *backing)
>  {
> -	struct sgx_encl_page *encl_page =3D epc_page->owner;
> +	struct sgx_encl_page *encl_page =3D epc_page->encl_page;
>  	struct sgx_encl *encl =3D encl_page->encl;
>  	struct sgx_backing secs_backing;
>  	int ret;
> @@ -309,7 +309,7 @@ static void sgx_reclaim_pages(void)
>  			break;
> =20
>  		list_del_init(&epc_page->list);
> -		encl_page =3D epc_page->owner;
> +		encl_page =3D epc_page->encl_page;
> =20
>  		if (kref_get_unless_zero(&encl_page->encl->refcount) !=3D 0) {
>  			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
> @@ -329,7 +329,7 @@ static void sgx_reclaim_pages(void)
> =20
>  	i =3D 0;
>  	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
> -		encl_page =3D epc_page->owner;
> +		encl_page =3D epc_page->encl_page;
> =20
>  		if (!sgx_reclaimer_age(epc_page))
>  			goto skip;
> @@ -362,7 +362,7 @@ static void sgx_reclaim_pages(void)
> =20
>  	i =3D 0;
>  	list_for_each_entry_safe(epc_page, tmp, &iso, list) {
> -		encl_page =3D epc_page->owner;
> +		encl_page =3D epc_page->encl_page;
>  		sgx_reclaimer_write(epc_page, &backing[i++]);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> @@ -562,7 +562,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
bool reclaim)
>  	for ( ; ; ) {
>  		page =3D __sgx_alloc_epc_page();
>  		if (!IS_ERR(page)) {
> -			page->owner =3D owner;
> +			page->encl_page =3D owner;
>  			break;
>  		}
> =20
> @@ -607,7 +607,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
> =20
>  	spin_lock(&node->lock);
> =20
> -	page->owner =3D NULL;
> +	page->encl_page =3D NULL;
>  	if (page->poison)
>  		list_add(&page->list, &node->sgx_poison_page_list);
>  	else
> @@ -642,7 +642,7 @@ static bool __init sgx_setup_epc_section(u64 phys_add=
r, u64 size,
>  	for (i =3D 0; i < nr_pages; i++) {
>  		section->pages[i].section =3D index;
>  		section->pages[i].flags =3D 0;
> -		section->pages[i].owner =3D NULL;
> +		section->pages[i].encl_page =3D NULL;
>  		section->pages[i].poison =3D 0;
>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>  	}
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 764cec23f4e5..c75ddc7168fa 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -68,7 +68,10 @@ struct sgx_epc_page {
>  	unsigned int section;
>  	u16 flags;
>  	u16 poison;
> -	struct sgx_encl_page *owner;

	/* possible owner types */
> +	union {
> +		struct sgx_encl_page *encl_page;
> +		struct sgx_encl *encl;
> +	};
>  	struct list_head list;
>  };
> =20
> --=20
> 2.25.1

BR, Jarkko
