Return-Path: <cgroups+bounces-433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C76D7ED34D
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 21:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D631F27D04
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 20:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF543ABE;
	Wed, 15 Nov 2023 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoZtaZW2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1325381A5
	for <cgroups@vger.kernel.org>; Wed, 15 Nov 2023 20:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEEEC4160E;
	Wed, 15 Nov 2023 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700081338;
	bh=PJculjTWiL2GB3exzyUInoYkoRADOvSehHA7YLmK9QU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HoZtaZW2Nj0gACIllbuUieALzComiVjQK9O/TLxPbX6KK+VvX/Zoe6+qUDhyQdcpK
	 zSiEgGXP4NRKTWIAdAFFuieVlJkkNebZq3zFiUlEUtL2nT7a0LgEUSAyazgeNK4YK8
	 RnfNq/0BWN1om6SmTCM7xVSC4KWV2kDe9sIZ0swVMAjku6+UbVAgsce6lYQbcBXqxm
	 jiQP5TItttouyWlf8WqToNqx9QECMIGrpps5fN5tzhiy+fRwE+4QV5nE71/yghJBKh
	 DF4jCjluzWVsvW5ZcpLJ2CtlF1IAH8Ojz5vw2WWMLx6qo6pMslgvVallP/tSrf2xoO
	 TVZcp9A4nhSSg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 22:48:52 +0200
Message-Id: <CWZOJA026PNF.18C6WEF49D74E@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>, "Sean
 Christopherson" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-5-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-5-haitao.huang@linux.intel.com>

On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Implement support for cgroup control of SGX Enclave Page Cache (EPC)
> memory using the misc cgroup controller. EPC memory is independent
> from normal system memory, e.g. must be reserved at boot from RAM and
> cannot be converted between EPC and normal memory while the system is
> running. EPC is managed by the SGX subsystem and is not accounted by
> the memory controller.
>
> Much like normal system memory, EPC memory can be overcommitted via
> virtual memory techniques and pages can be swapped out of the EPC to
> their backing store (normal system memory, e.g. shmem).  The SGX EPC
> subsystem is analogous to the memory subsystem and the SGX EPC controller
> is in turn analogous to the memory controller; it implements limit and
> protection models for EPC memory.
>
> The misc controller provides a mechanism to set a hard limit of EPC
> usage via the "sgx_epc" resource in "misc.max". The total EPC memory
> available on the system is reported via the "sgx_epc" resource in
> "misc.capacity".
>
> This patch was modified from the previous version to only add basic EPC
> cgroup structure, accounting allocations for cgroup usage
> (charge/uncharge), setup misc cgroup callbacks, set total EPC capacity.
>
> For now, the EPC cgroup simply blocks additional EPC allocation in
> sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
> still tracked in the global active list, only reclaimed by the global
> reclaimer when the total free page count is lower than a threshold.
>
> Later patches will reorganize the tracking and reclamation code in the
> globale reclaimer and implement per-cgroup tracking and reclaiming.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V6:
> - Split the original large patch"Limit process EPC usage with misc
> cgroup controller"  and restructure it (Kai)
> ---
>  arch/x86/Kconfig                     |  13 ++++
>  arch/x86/kernel/cpu/sgx/Makefile     |   1 +
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 103 +++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  36 ++++++++++
>  arch/x86/kernel/cpu/sgx/main.c       |  28 ++++++++
>  arch/x86/kernel/cpu/sgx/sgx.h        |   3 +
>  6 files changed, 184 insertions(+)
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 66bfabae8814..e17c5dc3aea4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1921,6 +1921,19 @@ config X86_SGX
> =20
>  	  If unsure, say N.
> =20
> +config CGROUP_SGX_EPC
> +	bool "Miscellaneous Cgroup Controller for Enclave Page Cache (EPC) for =
Intel SGX"
> +	depends on X86_SGX && CGROUP_MISC
> +	help
> +	  Provides control over the EPC footprint of tasks in a cgroup via
> +	  the Miscellaneous cgroup controller.
> +
> +	  EPC is a subset of regular memory that is usable only by SGX
> +	  enclaves and is very limited in quantity, e.g. less than 1%
> +	  of total DRAM.
> +
> +	  Say N if unsure.
> +
>  config X86_USER_SHADOW_STACK
>  	bool "X86 userspace shadow stack"
>  	depends on AS_WRUSS
> diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/M=
akefile
> index 9c1656779b2a..12901a488da7 100644
> --- a/arch/x86/kernel/cpu/sgx/Makefile
> +++ b/arch/x86/kernel/cpu/sgx/Makefile
> @@ -4,3 +4,4 @@ obj-y +=3D \
>  	ioctl.o \
>  	main.o
>  obj-$(CONFIG_X86_SGX_KVM)	+=3D virt.o
> +obj-$(CONFIG_CGROUP_SGX_EPC)	       +=3D epc_cgroup.o
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> new file mode 100644
> index 000000000000..500627d0563f
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2022 Intel Corporation.
> +
> +#include <linux/atomic.h>
> +#include <linux/kernel.h>
> +#include "epc_cgroup.h"
> +
> +static inline struct sgx_epc_cgroup *sgx_epc_cgroup_from_misc_cg(struct =
misc_cg *cg)
> +{
> +	return (struct sgx_epc_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
> +}
> +
> +static inline bool sgx_epc_cgroup_disabled(void)
> +{
> +	return !cgroup_subsys_enabled(misc_cgrp_subsys);
> +}
> +
> +/**
> + * sgx_epc_cgroup_try_charge() - hierarchically try to charge a single E=
PC page
> + *
> + * Returns EPC cgroup or NULL on success, -errno on failure.

Should have a description explaining what "charging hierarchically" is
all about. This is too cryptic like this.

E.g. consider wahat non-hierarchically charging means. There must be
opposite end in order to have a meaning (for anything expressed with
a language).

> + */
> +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +	int ret;
> +
> +	if (sgx_epc_cgroup_disabled())
> +		return NULL;
> +
> +	epc_cg =3D sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
> +	ret =3D misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
> +
> +	if (!ret) {
> +		/* No epc_cg returned, release ref from get_current_misc_cg() */
> +		put_misc_cg(epc_cg->cg);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Ref released in sgx_epc_cgroup_uncharge() */
> +	return epc_cg;
> +}
> +
> +/**
> + * sgx_epc_cgroup_uncharge() - hierarchically uncharge EPC pages
> + * @epc_cg:	the charged epc cgroup
> + */
> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg)
> +{
> +	if (sgx_epc_cgroup_disabled())
> +		return;
> +
> +	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
> +
> +	/* Ref got from sgx_epc_cgroup_try_charge() */
> +	put_misc_cg(epc_cg->cg);
> +}
> +
> +static void sgx_epc_cgroup_free(struct misc_cg *cg)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg =3D sgx_epc_cgroup_from_misc_cg(cg);
> +	if (!epc_cg)
> +		return;
> +
> +	kfree(epc_cg);
> +}
> +
> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg);
> +
> +const struct misc_operations_struct sgx_epc_cgroup_ops =3D {
> +	.alloc =3D sgx_epc_cgroup_alloc,
> +	.free =3D sgx_epc_cgroup_free,
> +};
> +
> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg =3D kzalloc(sizeof(*epc_cg), GFP_KERNEL);
> +	if (!epc_cg)
> +		return -ENOMEM;
> +
> +	cg->res[MISC_CG_RES_SGX_EPC].misc_ops =3D &sgx_epc_cgroup_ops;
> +	cg->res[MISC_CG_RES_SGX_EPC].priv =3D epc_cg;
> +	epc_cg->cg =3D cg;
> +	return 0;
> +}
> +
> +static int __init sgx_epc_cgroup_init(void)
> +{
> +	struct misc_cg *cg;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SGX))
> +		return 0;
> +
> +	cg =3D misc_cg_root();
> +	BUG_ON(!cg);
> +
> +	return sgx_epc_cgroup_alloc(cg);
> +}
> +subsys_initcall(sgx_epc_cgroup_init);
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.h
> new file mode 100644
> index 000000000000..c3abfe82be15
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2022 Intel Corporation. */
> +#ifndef _INTEL_SGX_EPC_CGROUP_H_
> +#define _INTEL_SGX_EPC_CGROUP_H_
> +
> +#include <asm/sgx.h>
> +#include <linux/cgroup.h>
> +#include <linux/list.h>
> +#include <linux/misc_cgroup.h>
> +#include <linux/page_counter.h>
> +#include <linux/workqueue.h>
> +
> +#include "sgx.h"
> +
> +#ifndef CONFIG_CGROUP_SGX_EPC
> +#define MISC_CG_RES_SGX_EPC MISC_CG_RES_TYPES
> +struct sgx_epc_cgroup;
> +
> +static inline struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void)
> +{
> +	return NULL;
> +}
> +
> +static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg=
) { }
> +#else
> +struct sgx_epc_cgroup {
> +	struct misc_cg *cg;
> +};
> +
> +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(void);
> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
> +bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
> +
> +#endif
> +
> +#endif /* _INTEL_SGX_EPC_CGROUP_H_ */
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 166692f2d501..07606f391540 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -6,6 +6,7 @@
>  #include <linux/highmem.h>
>  #include <linux/kthread.h>
>  #include <linux/miscdevice.h>
> +#include <linux/misc_cgroup.h>
>  #include <linux/node.h>
>  #include <linux/pagemap.h>
>  #include <linux/ratelimit.h>
> @@ -17,6 +18,7 @@
>  #include "driver.h"
>  #include "encl.h"
>  #include "encls.h"
> +#include "epc_cgroup.h"
> =20
>  struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
>  static int sgx_nr_epc_sections;
> @@ -559,6 +561,11 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page =
*page)
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>  {
>  	struct sgx_epc_page *page;
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg =3D sgx_epc_cgroup_try_charge();
> +	if (IS_ERR(epc_cg))
> +		return ERR_CAST(epc_cg);
> =20
>  	for ( ; ; ) {
>  		page =3D __sgx_alloc_epc_page();
> @@ -580,10 +587,21 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner=
, bool reclaim)
>  			break;
>  		}
> =20
> +		/*
> +		 * Need to do a global reclamation if cgroup was not full but free
> +		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
> +		 */
>  		sgx_reclaim_pages();
>  		cond_resched();
>  	}
> =20
> +	if (!IS_ERR(page)) {
> +		WARN_ON_ONCE(page->epc_cg);
> +		page->epc_cg =3D epc_cg;
> +	} else {
> +		sgx_epc_cgroup_uncharge(epc_cg);
> +	}
> +
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>  		wake_up(&ksgxd_waitq);
> =20
> @@ -604,6 +622,11 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  	struct sgx_epc_section *section =3D &sgx_epc_sections[page->section];
>  	struct sgx_numa_node *node =3D section->node;
> =20
> +	if (page->epc_cg) {
> +		sgx_epc_cgroup_uncharge(page->epc_cg);
> +		page->epc_cg =3D NULL;
> +	}
> +
>  	spin_lock(&node->lock);
> =20
>  	page->owner =3D NULL;
> @@ -643,6 +666,7 @@ static bool __init sgx_setup_epc_section(u64 phys_add=
r, u64 size,
>  		section->pages[i].flags =3D 0;
>  		section->pages[i].owner =3D NULL;
>  		section->pages[i].poison =3D 0;
> +		section->pages[i].epc_cg =3D NULL;
>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>  	}
> =20
> @@ -787,6 +811,7 @@ static void __init arch_update_sysfs_visibility(int n=
id) {}
>  static bool __init sgx_page_cache_init(void)
>  {
>  	u32 eax, ebx, ecx, edx, type;
> +	u64 capacity =3D 0;
>  	u64 pa, size;
>  	int nid;
>  	int i;
> @@ -837,6 +862,7 @@ static bool __init sgx_page_cache_init(void)
> =20
>  		sgx_epc_sections[i].node =3D  &sgx_numa_nodes[nid];
>  		sgx_numa_nodes[nid].size +=3D size;
> +		capacity +=3D size;
> =20
>  		sgx_nr_epc_sections++;
>  	}
> @@ -846,6 +872,8 @@ static bool __init sgx_page_cache_init(void)
>  		return false;
>  	}
> =20
> +	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
> +
>  	return true;
>  }
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index d2dad21259a8..b1786774b8d2 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -29,12 +29,15 @@
>  /* Pages on free list */
>  #define SGX_EPC_PAGE_IS_FREE		BIT(1)
> =20
> +struct sgx_epc_cgroup;
> +
>  struct sgx_epc_page {
>  	unsigned int section;
>  	u16 flags;
>  	u16 poison;
>  	struct sgx_encl_page *owner;
>  	struct list_head list;
> +	struct sgx_epc_cgroup *epc_cg;
>  };
> =20
>  /*

BR, Jarkko

