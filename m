Return-Path: <cgroups+bounces-1305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1649846466
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 00:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D091F25AD9
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 23:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA747A7E;
	Thu,  1 Feb 2024 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+nyPtYL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C082947F47;
	Thu,  1 Feb 2024 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830028; cv=none; b=lowroCqabCoxQoYh2e0zVvYFcLajsJ9rrM/ZtxWCDPFvFRL43GYFBiwQD3RD/6ahADkMibpmnDkcJEBM+sY/AXBDlsnQWcFOAVsGWUzR/tQZaR6VBDfrNm5kCNFQcoizR1jWq1uF+z8MMFXiNc/ao0cYKO5omA0aZnfGP1oOHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830028; c=relaxed/simple;
	bh=z7piPk1ToKxIm9zqYRND9YErwZrmDs7sbQpZFRJOgqg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tslXhoDGnCQHfc+f4pD5WMszXJ2KJ0uuDlTkcOL2aEbizliKTBXqO+g5FKNmP9ZQ+3Wjtt3OnLOz+9BGiVV3nxxo9pQaOx/4NrPnpIh20h4tUrR0oYx0j5xgHqOvWP46w/JIL8qAGoYDQsFYEggduel7WDt8E353pZVYduJSfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+nyPtYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ABBC433F1;
	Thu,  1 Feb 2024 23:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706830028;
	bh=z7piPk1ToKxIm9zqYRND9YErwZrmDs7sbQpZFRJOgqg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=H+nyPtYL1BXbgAO1KRM4O4PWo/Q7qIrRb9WKCKxdeabmg0n67TwTGVzJDREzXAv2R
	 P2Bl9e/eOZDDPvU7EiRFwCH3v/ZoTmd97yTLE9y8PWkyQNeNa/sMKxG8Wssed4CTZ1
	 6o4Q9c+eB09rTpy1smA79Q+g/CRWVHj0q6UiSQQnOHMfZ53ywGpLn6bDUYpVY9WECj
	 A2TndlCvdjcngFaUc7geOHHUlHlY2YOkYU4qq/5UaysOLwCGP2F+XLkvGRXBPVs8tx
	 B8PYDyODyMIhcInsI8UZpl0Sr3k2a3uawMmFzHxPK4V7SNv8I+PWipTRuyseWE+/QP
	 hnWD5c5PYZSiA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:27:02 +0200
Message-Id: <CYU4QVGJ3X1M.1HNZIHEPIMC5N@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-5-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-5-haitao.huang@linux.intel.com>

On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> SGX Enclave Page Cache (EPC) memory allocations are separate from normal
> RAM allocations, and are managed solely by the SGX subsystem. The
> existing cgroup memory controller cannot be used to limit or account for
> SGX EPC memory, which is a desirable feature in some environments.  For
> example, in a Kubernates environment, a user can request certain EPC
> quota for a pod but the orchestrator can not enforce the quota to limit
> runtime EPC usage of the pod without an EPC cgroup controller.
>
> Utilize the misc controller [admin-guide/cgroup-v2.rst, 5-9. Misc] to
> limit and track EPC allocations per cgroup. Earlier patches have added
> the "sgx_epc" resource type in the misc cgroup subsystem. Add basic
> support in SGX driver as the "sgx_epc" resource provider:
>
> - Set "capacity" of EPC by calling misc_cg_set_capacity()
> - Update EPC usage counter, "current", by calling charge and uncharge
> APIs for EPC allocation and deallocation, respectively.
> - Setup sgx_epc resource type specific callbacks, which perform
> initialization and cleanup during cgroup allocation and deallocation,
> respectively.
>
> With these changes, the misc cgroup controller enables user to set a hard
> limit for EPC usage in the "misc.max" interface file. It reports current
> usage in "misc.current", the total EPC memory available in
> "misc.capacity", and the number of times EPC usage reached the max limit
> in "misc.events".
>
> For now, the EPC cgroup simply blocks additional EPC allocation in
> sgx_alloc_epc_page() when the limit is reached. Reclaimable pages are
> still tracked in the global active list, only reclaimed by the global
> reclaimer when the total free page count is lower than a threshold.
>
> Later patches will reorganize the tracking and reclamation code in the
> global reclaimer and implement per-cgroup tracking and reclaiming.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V8:
> - Remove null checks for epc_cg in try_charge()/uncharge(). (Jarkko)
> - Remove extra space, '_INTEL'. (Jarkko)
>
> V7:
> - Use a static for root cgroup (Kai)
> - Wrap epc_cg field in sgx_epc_page struct with #ifdef (Kai)
> - Correct check for charge API return (Kai)
> - Start initialization in SGX device driver init (Kai)
> - Remove unneeded BUG_ON (Kai)
> - Split  sgx_get_current_epc_cg() out of sgx_epc_cg_try_charge() (Kai)
>
> V6:
> - Split the original large patch"Limit process EPC usage with misc
> cgroup controller"  and restructure it (Kai)
> ---
>  arch/x86/Kconfig                     | 13 +++++
>  arch/x86/kernel/cpu/sgx/Makefile     |  1 +
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 73 ++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h | 73 ++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/main.c       | 52 +++++++++++++++++++-
>  arch/x86/kernel/cpu/sgx/sgx.h        |  5 ++
>  include/linux/misc_cgroup.h          |  2 +
>  7 files changed, 217 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..10c3d1d099b2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1947,6 +1947,19 @@ config X86_SGX
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
> index 000000000000..eac8548164de
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2022 Intel Corporation.
> +
> +#include <linux/atomic.h>
> +#include <linux/kernel.h>
> +#include "epc_cgroup.h"
> +
> +static struct sgx_epc_cgroup epc_cg_root;
> +
> +/**
> + * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC p=
age
> + *
> + * @epc_cg:	The EPC cgroup to be charged for the page.
> + * Return:
> + * * %0 - If successfully charged.
> + * * -errno - for failures.
> + */
> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
> +{
> +	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
> +}
> +
> +/**
> + * sgx_epc_cgroup_uncharge() - uncharge a cgroup for an EPC page
> + * @epc_cg:	The charged epc cgroup
> + */
> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg)
> +{
> +	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
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
> +const struct misc_res_ops sgx_epc_cgroup_ops =3D {
> +	.alloc =3D sgx_epc_cgroup_alloc,
> +	.free =3D sgx_epc_cgroup_free,
> +};
> +
> +static void sgx_epc_misc_init(struct misc_cg *cg, struct sgx_epc_cgroup =
*epc_cg)
> +{
> +	cg->res[MISC_CG_RES_SGX_EPC].priv =3D epc_cg;
> +	epc_cg->cg =3D cg;
> +}
> +
> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg =3D kzalloc(sizeof(*epc_cg), GFP_KERNEL);
> +	if (!epc_cg)
> +		return -ENOMEM;
> +
> +	sgx_epc_misc_init(cg, epc_cg);
> +
> +	return 0;
> +}
> +
> +void sgx_epc_cgroup_init(void)
> +{
> +	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_epc_cgroup_ops);
> +	sgx_epc_misc_init(misc_cg_root(), &epc_cg_root);
> +}
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.h
> new file mode 100644
> index 000000000000..6b664b4c321f
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2022 Intel Corporation. */
> +#ifndef _SGX_EPC_CGROUP_H_
> +#define _SGX_EPC_CGROUP_H_
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
> +static inline struct sgx_epc_cgroup *sgx_get_current_epc_cg(void)
> +{
> +	return NULL;
> +}
> +
> +static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg) { }
> +
> +static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_c=
g)
> +{
> +	return 0;
> +}
> +
> +static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg=
) { }
> +
> +static inline void sgx_epc_cgroup_init(void) { }
> +#else
> +struct sgx_epc_cgroup {
> +	struct misc_cg *cg;
> +};
> +
> +static inline struct sgx_epc_cgroup *sgx_epc_cgroup_from_misc_cg(struct =
misc_cg *cg)
> +{
> +	return (struct sgx_epc_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
> +}
> +
> +/**
> + * sgx_get_current_epc_cg() - get the EPC cgroup of current process.
> + *
> + * Returned cgroup has its ref count increased by 1. Caller must call
> + * sgx_put_epc_cg() to return the reference.
> + *
> + * Return: EPC cgroup to which the current task belongs to.
> + */
> +static inline struct sgx_epc_cgroup *sgx_get_current_epc_cg(void)
> +{
> +	return sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
> +}
> +
> +/**
> + * sgx_put_epc_cg() - Put the EPC cgroup and reduce its ref count.
> + * @epc_cg - EPC cgroup to put.
> + */
> +static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg)
> +{
> +	if (epc_cg)
> +		put_misc_cg(epc_cg->cg);
> +}
> +
> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg);
> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
> +void sgx_epc_cgroup_init(void);
> +
> +#endif
> +
> +#endif /* _SGX_EPC_CGROUP_H_ */
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 166692f2d501..c32f18b70c73 100644
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
> @@ -558,7 +560,16 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page =
*page)
>   */
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>  {
> +	struct sgx_epc_cgroup *epc_cg;
>  	struct sgx_epc_page *page;
> +	int ret;
> +
> +	epc_cg =3D sgx_get_current_epc_cg();
> +	ret =3D sgx_epc_cgroup_try_charge(epc_cg);
> +	if (ret) {
> +		sgx_put_epc_cg(epc_cg);
> +		return ERR_PTR(ret);
> +	}
> =20
>  	for ( ; ; ) {
>  		page =3D __sgx_alloc_epc_page();
> @@ -567,8 +578,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner,=
 bool reclaim)
>  			break;
>  		}
> =20
> -		if (list_empty(&sgx_active_page_list))
> -			return ERR_PTR(-ENOMEM);
> +		if (list_empty(&sgx_active_page_list)) {
> +			page =3D ERR_PTR(-ENOMEM);
> +			break;
> +		}
> =20
>  		if (!reclaim) {
>  			page =3D ERR_PTR(-EBUSY);
> @@ -580,10 +593,25 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner=
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
> +#ifdef CONFIG_CGROUP_SGX_EPC
> +	if (!IS_ERR(page)) {
> +		WARN_ON_ONCE(page->epc_cg);
> +		/* sgx_put_epc_cg() in sgx_free_epc_page() */
> +		page->epc_cg =3D epc_cg;
> +	} else {
> +		sgx_epc_cgroup_uncharge(epc_cg);
> +		sgx_put_epc_cg(epc_cg);
> +	}
> +#endif
> +
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>  		wake_up(&ksgxd_waitq);
> =20
> @@ -604,6 +632,14 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  	struct sgx_epc_section *section =3D &sgx_epc_sections[page->section];
>  	struct sgx_numa_node *node =3D section->node;
> =20
> +#ifdef CONFIG_CGROUP_SGX_EPC
> +	if (page->epc_cg) {
> +		sgx_epc_cgroup_uncharge(page->epc_cg);
> +		sgx_put_epc_cg(page->epc_cg);
> +		page->epc_cg =3D NULL;
> +	}
> +#endif
> +
>  	spin_lock(&node->lock);
> =20
>  	page->owner =3D NULL;
> @@ -643,6 +679,11 @@ static bool __init sgx_setup_epc_section(u64 phys_ad=
dr, u64 size,
>  		section->pages[i].flags =3D 0;
>  		section->pages[i].owner =3D NULL;
>  		section->pages[i].poison =3D 0;
> +
> +#ifdef CONFIG_CGROUP_SGX_EPC
> +		section->pages[i].epc_cg =3D NULL;
> +#endif
> +
>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>  	}
> =20
> @@ -787,6 +828,7 @@ static void __init arch_update_sysfs_visibility(int n=
id) {}
>  static bool __init sgx_page_cache_init(void)
>  {
>  	u32 eax, ebx, ecx, edx, type;
> +	u64 capacity =3D 0;
>  	u64 pa, size;
>  	int nid;
>  	int i;
> @@ -837,6 +879,7 @@ static bool __init sgx_page_cache_init(void)
> =20
>  		sgx_epc_sections[i].node =3D  &sgx_numa_nodes[nid];
>  		sgx_numa_nodes[nid].size +=3D size;
> +		capacity +=3D size;
> =20
>  		sgx_nr_epc_sections++;
>  	}
> @@ -846,6 +889,8 @@ static bool __init sgx_page_cache_init(void)
>  		return false;
>  	}
> =20
> +	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
> +
>  	return true;
>  }
> =20
> @@ -942,6 +987,9 @@ static int __init sgx_init(void)
>  	if (sgx_vepc_init() && ret)
>  		goto err_provision;
> =20
> +	/* Setup cgroup if either the native or vepc driver is active */
> +	sgx_epc_cgroup_init();
> +
>  	return 0;
> =20
>  err_provision:
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index d2dad21259a8..a898d86dead0 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -29,12 +29,17 @@
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
> +#ifdef CONFIG_CGROUP_SGX_EPC
> +	struct sgx_epc_cgroup *epc_cg;
> +#endif
>  };
> =20
>  /*
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index 2f6cc3a0ad23..1a16efdfcd3d 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -46,11 +46,13 @@ struct misc_res_ops {
>   * @max: Maximum limit on the resource.
>   * @usage: Current usage of the resource.
>   * @events: Number of times, the resource limit exceeded.
> + * @priv: resource specific data.
>   */
>  struct misc_res {
>  	u64 max;
>  	atomic64_t usage;
>  	atomic64_t events;
> +	void *priv;
>  };
> =20
>  /**


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

