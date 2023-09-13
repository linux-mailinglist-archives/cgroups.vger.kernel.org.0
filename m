Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95079ED9B
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjIMPsl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIMPsl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:48:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2D1C1;
        Wed, 13 Sep 2023 08:48:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0BAC433C7;
        Wed, 13 Sep 2023 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694620116;
        bh=KS6XvetQdTJTSeReb2FUympaLkn0D94njfBOI8wXPMQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=t6nl/AtCzoOjT0V6YsBN23z8SyPHmjB2gZXdnk6jkLrNrGa8c3c4q+eTh9N40Kf7v
         s9m3QK1fX/cKq//ZcBpyEUvRCYggb7ChYRFZhfpeu/rSzhDw1oFVCbj9drT6R89UMd
         1FVcDf2D6EHcK7z7lJ1sn7YcXeEkzn/CCqjEheVD4Zrk0xQawUZ0nZGVZoK4kxlCtL
         P3CaD1PHX5i/e/NNO1ROsHYZxprQfkfm7x9pfPM9rfugmHBTn34BYmP30ZyiEwRzKe
         66ZaUkIK2snmec9RdjQT0l/F41BQwzkC5LZcg3dCNdoIXB2PrwggZ/XmtShV1uZYkR
         BaBgRRZOboWhQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:48:31 +0300
Message-Id: <CVHWOZS4OGWP.1ZFY0YLJHPHXO@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-17-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-17-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
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
> This patch was modified from its original version to use the misc cgroup
> controller instead of a custom controller.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
> V4:
> - Fix a white space issue in Kconfig (Randy).
> - Update comments for LRU list as it can be owned by a cgroup.
> - Fix comments for sgx_reclaim_epc_pages() and use IS_ENABLED consistentl=
y (Mikko)
>
> V3:
>
> 1) Use the same maximum number of reclaiming candidate pages to be
> processed, SGX_NR_TO_SCAN_MAX, for each reclaiming iteration in both
> cgroup worker function and ksgxd. This fixes an overflow in the
> backing store buffer with the same fixed size allocated on stack in
> sgx_reclaim_epc_pages().
>
> 2) Initialize max for root EPC cgroup. Otherwise, all
> misc_cg_try_charge() calls would fail as it checks for all limits of
> ancestors all the way to the root node.
>
> 3) Start reclaiming whenever misc_cg_try_charge fails. Removed all
> re-checks for limits and current usage. For all purposes and intent,
> when misc_try_charge() fails, reclaiming is needed. This also corrects
> an error of not reclaiming when the child limit is larger than one of
> its ancestors.
>
> 4) Handle failure on charging to the root EPC cgroup. Failure on charging
> to root means we are at or above capacity, so start reclaiming or return
> OOM error.
>
> 5) Removed the custom cgroup tree walking iterator with epoch tracking
> logic. Replaced it with just the plain css_for_each_descendant_pre
> iterator. The custom iterator implemented a rather complex epoch scheme
> I believe was intended to prevent extra reclaiming from multiple worker
> threads doing the same walk but it turned out not matter much as each
> thread would only reclaim when usage is above limit. Using the plain
> css_for_each_descendant_pre iterator simplified code a bit.
>
> 6) Do not reclaim synchronously in misc_max_write callback which would
> block the user. Instead queue an async work item to run the reclaiming
> loop.
>
> 7) Other minor refactoring:
> - Remove unused params in epc_cgroup APIs
> - centralize uncharge into sgx_free_epc_page()
> ---
>  arch/x86/Kconfig                     |  13 +
>  arch/x86/kernel/cpu/sgx/Makefile     |   1 +
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 406 +++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  59 ++++
>  arch/x86/kernel/cpu/sgx/main.c       |  67 ++++-
>  arch/x86/kernel/cpu/sgx/sgx.h        |  17 +-
>  6 files changed, 547 insertions(+), 16 deletions(-)
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 982b777eadc7..55fcf182d4a3 100644
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
> index 000000000000..7b86eb074abe
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2022 Intel Corporation.
> +
> +#include <linux/atomic.h>
> +#include <linux/kernel.h>
> +#include <linux/ratelimit.h>
> +#include <linux/sched/signal.h>
> +#include <linux/slab.h>
> +#include <linux/threads.h>
> +
> +#include "epc_cgroup.h"
> +
> +#define SGX_EPC_RECLAIM_MIN_PAGES		16UL
> +#define SGX_EPC_RECLAIM_IGNORE_AGE_THRESHOLD	5
> +#define SGX_EPC_RECLAIM_OOM_THRESHOLD		5
> +
> +static struct workqueue_struct *sgx_epc_cg_wq;
> +static bool sgx_epc_cgroup_oom(struct sgx_epc_cgroup *root);
> +
> +struct sgx_epc_reclaim_control {
> +	struct sgx_epc_cgroup *epc_cg;
> +	int nr_fails;
> +	bool ignore_age;
> +};
> +
> +static inline u64 sgx_epc_cgroup_page_counter_read(struct sgx_epc_cgroup=
 *epc_cg)
> +{
> +	return atomic64_read(&epc_cg->cg->res[MISC_CG_RES_SGX_EPC].usage) / PAG=
E_SIZE;
> +}
> +
> +static inline u64 sgx_epc_cgroup_max_pages(struct sgx_epc_cgroup *epc_cg=
)
> +{
> +	return READ_ONCE(epc_cg->cg->res[MISC_CG_RES_SGX_EPC].max) / PAGE_SIZE;
> +}
> +

/*
 * A brief explanation of the calculation below.
 */
> +static inline u64 sgx_epc_cgroup_max_pages_to_root(struct sgx_epc_cgroup=
 *epc_cg)
> +{
> +	struct misc_cg *i =3D epc_cg->cg;
> +	u64 m =3D U64_MAX;
> +
> +	while (i) {
> +		m =3D min(m, READ_ONCE(i->res[MISC_CG_RES_SGX_EPC].max));
> +		i =3D misc_cg_parent(i);
> +	}

I'd add an empty line here.

> +	return m / PAGE_SIZE;
> +}
> +
> +static inline struct sgx_epc_cgroup *sgx_epc_cgroup_from_misc_cg(struct =
misc_cg *cg)
> +{
> +	if (cg)
> +		return (struct sgx_epc_cgroup *)(cg->res[MISC_CG_RES_SGX_EPC].priv);
> +
> +	return NULL;
> +}
> +
> +static inline bool sgx_epc_cgroup_disabled(void)
> +{
> +	return !cgroup_subsys_enabled(misc_cgrp_subsys);
> +}
> +
> +/**
> + * sgx_epc_cgroup_lru_empty - check if a cgroup tree has no pages on its=
 lrus

Does not have "()":

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> + * @root:	root of the tree to check
> + *
> + * Return: %true if all cgroups under the specified root have empty LRU =
lists.
> + * Used to avoid livelocks due to a cgroup having a non-zero charge coun=
t but
> + * no pages on its LRUs, e.g. due to a dead enclave waiting to be releas=
ed or
> + * because all pages in the cgroup are unreclaimable.
> + */
> +bool sgx_epc_cgroup_lru_empty(struct sgx_epc_cgroup *root)
> +{
> +	struct cgroup_subsys_state *css_root =3D NULL;
> +	struct cgroup_subsys_state *pos =3D NULL;
> +	struct sgx_epc_cgroup *epc_cg =3D NULL;
> +	bool ret =3D true;
> +
> +	/*
> +	 * Caller ensure css_root ref acquired
> +	 */
> +	css_root =3D root ? &root->cg->css : &(misc_cg_root()->css);
> +
> +	rcu_read_lock();
> +	css_for_each_descendant_pre(pos, css_root) {
> +		if (!css_tryget(pos))
> +			break;
> +
> +		rcu_read_unlock();
> +
> +		epc_cg =3D sgx_epc_cgroup_from_misc_cg(css_misc(pos));
> +
> +		spin_lock(&epc_cg->lru.lock);
> +		ret =3D list_empty(&epc_cg->lru.reclaimable);
> +		spin_unlock(&epc_cg->lru.lock);
> +
> +		rcu_read_lock();
> +		css_put(pos);
> +		if (!ret)
> +			break;
> +	}
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +/**
> + * sgx_epc_cgroup_isolate_pages - walk a cgroup tree and separate pages

Ditto.

> + * @root:	root of the tree to start walking
> + * @nr_to_scan: The number of pages that need to be isolated
> + * @dst:	Destination list to hold the isolated pages

Not correctly aligned.

> + *
> + * Walk the cgroup tree and isolate the pages in the hierarchy
> + * for reclaiming.
> + */
> +void sgx_epc_cgroup_isolate_pages(struct sgx_epc_cgroup *root,
> +				  size_t *nr_to_scan, struct list_head *dst)
> +{
> +	struct cgroup_subsys_state *css_root =3D NULL;

Spurious initialization to NULL.

> +	struct cgroup_subsys_state *pos =3D NULL;

Ditto.

> +	struct sgx_epc_cgroup *epc_cg =3D NULL;

Ditto.

> +
> +	if (!*nr_to_scan)
> +		return;
> +
> +	 /* Caller ensure css_root ref acquired */
> +	css_root =3D root ? &root->cg->css : &(misc_cg_root()->css);
> +
> +	rcu_read_lock();
> +	css_for_each_descendant_pre(pos, css_root) {
> +		if (!css_tryget(pos))
> +			break;
> +		rcu_read_unlock();
> +
> +		epc_cg =3D sgx_epc_cgroup_from_misc_cg(css_misc(pos));
> +		sgx_isolate_epc_pages(&epc_cg->lru, nr_to_scan, dst);
> +
> +		rcu_read_lock();
> +		css_put(pos);
> +		if (!*nr_to_scan)
> +			break;
> +	}

I'd add an empty line here.

> +	rcu_read_unlock();
> +}
> +
> +static int sgx_epc_cgroup_reclaim_pages(unsigned long nr_pages,
> +					struct sgx_epc_reclaim_control *rc)
> +{
> +	/*
> +	 * Ensure sgx_reclaim_pages is called with a minimum and maximum
> +	 * number of pages.  Attempting to reclaim only a few pages will
> +	 * often fail and is inefficient, while reclaiming a huge number
> +	 * of pages can result in soft lockups due to holding various
> +	 * locks for an extended duration.
> +	 */
> +	nr_pages =3D max(nr_pages, SGX_EPC_RECLAIM_MIN_PAGES);
> +	nr_pages =3D min(nr_pages, SGX_NR_TO_SCAN_MAX);
> +
> +	return sgx_reclaim_epc_pages(nr_pages, rc->ignore_age, rc->epc_cg);
> +}
> +
> +static int sgx_epc_cgroup_reclaim_failed(struct sgx_epc_reclaim_control =
*rc)
> +{
> +	if (sgx_epc_cgroup_lru_empty(rc->epc_cg))
> +		return -ENOMEM;
> +
> +	++rc->nr_fails;
> +	if (rc->nr_fails > SGX_EPC_RECLAIM_IGNORE_AGE_THRESHOLD)
> +		rc->ignore_age =3D true;
> +
> +	return 0;
> +}
> +
> +static inline
> +void sgx_epc_reclaim_control_init(struct sgx_epc_reclaim_control *rc,
> +				  struct sgx_epc_cgroup *epc_cg)
> +{
> +	rc->epc_cg =3D epc_cg;
> +	rc->nr_fails =3D 0;
> +	rc->ignore_age =3D false;
> +}
> +
> +/*
> + * Scheduled by sgx_epc_cgroup_try_charge() to reclaim pages from the
> + * cgroup when the cgroup is at/near its maximum capacity
> + */
> +static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
> +{
> +	struct sgx_epc_reclaim_control rc;
> +	struct sgx_epc_cgroup *epc_cg;
> +	u64 cur, max;
> +
> +	epc_cg =3D container_of(work, struct sgx_epc_cgroup, reclaim_work);
> +
> +	sgx_epc_reclaim_control_init(&rc, epc_cg);
> +
> +	for (;;) {
> +		max =3D sgx_epc_cgroup_max_pages_to_root(epc_cg);
> +
> +		/*
> +		 * Adjust the limit down by one page, the goal is to free up
> +		 * pages for fault allocations, not to simply obey the limit.
> +		 * Conditionally decrementing max also means the cur vs. max
> +		 * check will correctly handle the case where both are zero.
> +		 */
> +		if (max)
> +			max--;
> +
> +		/*
> +		 * Unless the limit is extremely low, in which case forcing
> +		 * reclaim will likely cause thrashing, force the cgroup to
> +		 * reclaim at least once if it's operating *near* its maximum
> +		 * limit by adjusting @max down by half the min reclaim size.
> +		 * This work func is scheduled by sgx_epc_cgroup_try_charge
> +		 * when it cannot directly reclaim due to being in an atomic
> +		 * context, e.g. EPC allocation in a fault handler.  Waiting
> +		 * to reclaim until the cgroup is actually at its limit is less
> +		 * performant as it means the faulting task is effectively
> +		 * blocked until a worker makes its way through the global work
> +		 * queue.
> +		 */
> +		if (max > SGX_NR_TO_SCAN_MAX)
> +			max -=3D (SGX_EPC_RECLAIM_MIN_PAGES / 2);
> +
> +		max =3D min(max, sgx_epc_total_pages);
> +		cur =3D sgx_epc_cgroup_page_counter_read(epc_cg);
> +		if (cur <=3D max)
> +			break;
> +		/* Nothing reclaimable */
> +		if (sgx_epc_cgroup_lru_empty(epc_cg)) {
> +			if (!sgx_epc_cgroup_oom(epc_cg))
> +				break;
> +
> +			continue;
> +		}
> +
> +		if (!sgx_epc_cgroup_reclaim_pages(cur - max, &rc)) {
> +			if (sgx_epc_cgroup_reclaim_failed(&rc))
> +				break;
> +		}
> +	}
> +}
> +
> +static int __sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg,
> +				       bool reclaim)
> +{
> +	struct sgx_epc_reclaim_control rc;
> +	unsigned int nr_empty =3D 0;
> +
> +	sgx_epc_reclaim_control_init(&rc, epc_cg);
> +
> +	for (;;) {
> +		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
> +					PAGE_SIZE))
> +			break;
> +
> +		if (sgx_epc_cgroup_lru_empty(epc_cg))
> +			return -ENOMEM;
> +
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +
> +		if (!reclaim) {
> +			queue_work(sgx_epc_cg_wq, &rc.epc_cg->reclaim_work);
> +			return -EBUSY;
> +		}
> +
> +		if (!sgx_epc_cgroup_reclaim_pages(1, &rc)) {
> +			if (sgx_epc_cgroup_reclaim_failed(&rc)) {
> +				if (++nr_empty > SGX_EPC_RECLAIM_OOM_THRESHOLD)
> +					return -ENOMEM;
> +				schedule();
> +			}
> +		}
> +	}
> +	if (epc_cg->cg !=3D misc_cg_root())
> +		css_get(&epc_cg->cg->css);
> +
> +	return 0;
> +}
> +
> +/**
> + * sgx_epc_cgroup_try_charge - hierarchically try to charge a single EPC=
 page

"()"

> + * @mm:			the mm_struct of the process to charge
> + * @reclaim:		whether or not synchronous reclaim is allowed
> + *
> + * Returns EPC cgroup or NULL on success, -errno on failure.
> + */
> +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(bool reclaim)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +	int ret;
> +
> +	if (sgx_epc_cgroup_disabled())
> +		return NULL;
> +
> +	epc_cg =3D sgx_epc_cgroup_from_misc_cg(get_current_misc_cg());
> +	ret =3D __sgx_epc_cgroup_try_charge(epc_cg, reclaim);
> +	put_misc_cg(epc_cg->cg);
> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return epc_cg;
> +}
> +
> +/**
> + * sgx_epc_cgroup_uncharge - hierarchically uncharge EPC pages

"()"

> + * @epc_cg:	the charged epc cgroup
> + */
> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg)
> +{
> +	if (sgx_epc_cgroup_disabled())
> +		return;
> +
> +	misc_cg_uncharge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
> +
> +	if (epc_cg->cg !=3D misc_cg_root())
> +		put_misc_cg(epc_cg->cg);
> +}
> +
> +static bool sgx_epc_cgroup_oom(struct sgx_epc_cgroup *root)
> +{
> +	struct cgroup_subsys_state *css_root =3D NULL;
> +	struct cgroup_subsys_state *pos =3D NULL;
> +	struct sgx_epc_cgroup *epc_cg =3D NULL;

Please check also these initializations through.

> +	bool oom =3D false;
> +
> +	 /* Caller ensure css_root ref acquired */
> +	css_root =3D root ? &root->cg->css : &(misc_cg_root()->css);
> +
> +	rcu_read_lock();
> +	css_for_each_descendant_pre(pos, css_root) {
> +		/* skip dead ones */
> +		if (!css_tryget(pos))
> +			continue;
> +
> +		rcu_read_unlock();
> +
> +		epc_cg =3D sgx_epc_cgroup_from_misc_cg(css_misc(pos));
> +		oom =3D sgx_epc_oom(&epc_cg->lru);
> +
> +		rcu_read_lock();
> +		css_put(pos);
> +		if (oom)
> +			break;
> +	}
> +	rcu_read_unlock();
> +	return oom;
> +}
> +
> +static void sgx_epc_cgroup_free(struct misc_cg *cg)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg =3D sgx_epc_cgroup_from_misc_cg(cg);
> +	cancel_work_sync(&epc_cg->reclaim_work);
> +	kfree(epc_cg);
> +}
> +
> +static void sgx_epc_cgroup_max_write(struct misc_cg *cg)
> +{
> +	struct sgx_epc_reclaim_control rc;
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg =3D sgx_epc_cgroup_from_misc_cg(cg);
> +
> +	sgx_epc_reclaim_control_init(&rc, epc_cg);
> +	/* Let the reclaimer to do the work so user is not blocked */
> +	queue_work(sgx_epc_cg_wq, &rc.epc_cg->reclaim_work);
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
> +	sgx_lru_init(&epc_cg->lru);
> +	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
> +	cg->res[MISC_CG_RES_SGX_EPC].misc_cg_alloc =3D sgx_epc_cgroup_alloc;
> +	cg->res[MISC_CG_RES_SGX_EPC].misc_cg_free =3D sgx_epc_cgroup_free;
> +	cg->res[MISC_CG_RES_SGX_EPC].misc_cg_max_write =3D sgx_epc_cgroup_max_w=
rite;
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
> +	sgx_epc_cg_wq =3D alloc_workqueue("sgx_epc_cg_wq",
> +					WQ_UNBOUND | WQ_FREEZABLE,
> +					WQ_UNBOUND_MAX_ACTIVE);
> +	BUG_ON(!sgx_epc_cg_wq);
> +
> +	cg =3D misc_cg_root();
> +	BUG_ON(!cg);
> +	WRITE_ONCE(cg->res[MISC_CG_RES_SGX_EPC].max, U64_MAX);
> +	atomic64_set(&cg->res[MISC_CG_RES_SGX_EPC].usage, 0UL);
> +	return sgx_epc_cgroup_alloc(cg);
> +}
> +subsys_initcall(sgx_epc_cgroup_init);
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.h
> new file mode 100644
> index 000000000000..dfc902f4d96f
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -0,0 +1,59 @@
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
> +static inline struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(bool recl=
aim)
> +{
> +	return NULL;
> +}
> +
> +static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg=
) { }
> +
> +static inline void sgx_epc_cgroup_isolate_pages(struct sgx_epc_cgroup *r=
oot,
> +						size_t *nr_to_scan,
> +						struct list_head *dst) { }
> +
> +static inline struct sgx_epc_lru_lists *epc_cg_lru(struct sgx_epc_cgroup=
 *epc_cg)
> +{
> +	return NULL;
> +}
> +
> +static bool sgx_epc_cgroup_lru_empty(struct sgx_epc_cgroup *root)
> +{
> +	return true;
> +}
> +#else
> +struct sgx_epc_cgroup {
> +	struct misc_cg *cg;
> +	struct sgx_epc_lru_lists	lru;
> +	struct work_struct	reclaim_work;
> +};
> +
> +struct sgx_epc_cgroup *sgx_epc_cgroup_try_charge(bool reclaim);
> +void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
> +bool sgx_epc_cgroup_lru_empty(struct sgx_epc_cgroup *root);
> +void sgx_epc_cgroup_isolate_pages(struct sgx_epc_cgroup *root,
> +				  size_t *nr_to_scan, struct list_head *dst);
> +static inline struct sgx_epc_lru_lists *epc_cg_lru(struct sgx_epc_cgroup=
 *epc_cg)
> +{
> +	if (epc_cg)
> +		return &epc_cg->lru;
> +	return NULL;
> +}
> +#endif
> +
> +#endif /* _INTEL_SGX_EPC_CGROUP_H_ */
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 3d396fe5ec09..20de17f4f576 100644
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
> @@ -17,11 +18,9 @@
>  #include "driver.h"
>  #include "encl.h"
>  #include "encls.h"
> -/**
> - * Maximum number of pages to scan for reclaiming.
> - */
> -#define SGX_NR_TO_SCAN_MAX	32
> +#include "epc_cgroup.h"
> =20
> +u64 sgx_epc_total_pages;
>  struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
>  static int sgx_nr_epc_sections;
>  static struct task_struct *ksgxd_tsk;
> @@ -36,11 +35,17 @@ static struct sgx_epc_lru_lists sgx_global_lru;
> =20
>  static inline struct sgx_epc_lru_lists *sgx_lru_lists(struct sgx_epc_pag=
e *epc_page)
>  {
> +	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
> +		return epc_cg_lru(epc_page->epc_cg);
> +
>  	return &sgx_global_lru;
>  }
> =20
>  static inline bool sgx_can_reclaim(void)
>  {
> +	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
> +		return !sgx_epc_cgroup_lru_empty(NULL);
> +
>  	return !list_empty(&sgx_global_lru.reclaimable);
>  }
> =20
> @@ -299,14 +304,14 @@ static void sgx_reclaimer_write(struct sgx_epc_page=
 *epc_page,
>   * @nr_to_scan:	Number of pages to scan for reclaim
>   * @dst:	Destination list to hold the isolated pages
>   */
> -void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, size_t nr_to_s=
can,
> +void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, size_t *nr_to_=
scan,
>  			   struct list_head *dst)
>  {
>  	struct sgx_encl_page *encl_page;
>  	struct sgx_epc_page *epc_page;
> =20
>  	spin_lock(&lru->lock);
> -	for (; nr_to_scan > 0; --nr_to_scan) {
> +	for (; *nr_to_scan > 0; --(*nr_to_scan)) {
>  		epc_page =3D list_first_entry_or_null(&lru->reclaimable, struct sgx_ep=
c_page, list);
>  		if (!epc_page)
>  			break;
> @@ -331,6 +336,7 @@ void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *=
lru, size_t nr_to_scan,
>   * sgx_reclaim_epc_pages() - Reclaim EPC pages from the consumers
>   * @nr_to_scan:		 Number of EPC pages to scan for reclaim
>   * @ignore_age:		 Reclaim a page even if it is young
> + * @epc_cg:		 EPC cgroup from which to reclaim
>   *
>   * Take a fixed number of pages from the head of the active page pool an=
d
>   * reclaim them to the enclave's private shmem files. Skip the pages, wh=
ich have
> @@ -344,7 +350,8 @@ void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *=
lru, size_t nr_to_scan,
>   * problematic as it would increase the lock contention too much, which =
would
>   * halt forward progress.
>   */
> -size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age)
> +size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age,
> +			     struct sgx_epc_cgroup *epc_cg)
>  {
>  	struct sgx_backing backing[SGX_NR_TO_SCAN_MAX];
>  	struct sgx_epc_page *epc_page, *tmp;
> @@ -355,7 +362,15 @@ size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool=
 ignore_age)
>  	size_t ret;
>  	size_t i;
> =20
> -	sgx_isolate_epc_pages(&sgx_global_lru, nr_to_scan, &iso);
> +	/*
> +	 * If a specific cgroup is not being targeted, take from the global
> +	 * list first, even when cgroups are enabled.  If there are
> +	 * pages on the global LRU then they should get reclaimed asap.
> +	 */
> +	if (!IS_ENABLED(CONFIG_CGROUP_SGX_EPC) || !epc_cg)
> +		sgx_isolate_epc_pages(&sgx_global_lru, &nr_to_scan, &iso);
> +
> +	sgx_epc_cgroup_isolate_pages(epc_cg, &nr_to_scan, &iso);
> =20
>  	if (list_empty(&iso))
>  		return 0;
> @@ -422,7 +437,7 @@ static bool sgx_should_reclaim(unsigned long watermar=
k)
>  void sgx_reclaim_direct(void)
>  {
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
> +		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
>  }
> =20
>  static int ksgxd(void *p)
> @@ -445,7 +460,7 @@ static int ksgxd(void *p)
>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
> =20
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> -			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
> +			sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
> =20
>  		cond_resched();
>  	}
> @@ -599,6 +614,11 @@ int sgx_drop_epc_page(struct sgx_epc_page *page)
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>  {
>  	struct sgx_epc_page *page;
> +	struct sgx_epc_cgroup *epc_cg;
> +
> +	epc_cg =3D sgx_epc_cgroup_try_charge(reclaim);
> +	if (IS_ERR(epc_cg))
> +		return ERR_CAST(epc_cg);
> =20
>  	for ( ; ; ) {
>  		page =3D __sgx_alloc_epc_page();
> @@ -607,8 +627,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner,=
 bool reclaim)
>  			break;
>  		}
> =20
> -		if (!sgx_can_reclaim())
> -			return ERR_PTR(-ENOMEM);
> +		if (!sgx_can_reclaim()) {
> +			page =3D ERR_PTR(-ENOMEM);
> +			break;
> +		}
> =20
>  		if (!reclaim) {
>  			page =3D ERR_PTR(-EBUSY);
> @@ -620,10 +642,17 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner=
, bool reclaim)
>  			break;
>  		}
> =20
> -		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false);
> +		sgx_reclaim_epc_pages(SGX_NR_TO_SCAN, false, NULL);
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
> @@ -646,6 +675,11 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
> =20
>  	WARN_ON_ONCE(page->flags & (SGX_EPC_PAGE_STATE_MASK));
> =20
> +	if (page->epc_cg) {
> +		sgx_epc_cgroup_uncharge(page->epc_cg);
> +		page->epc_cg =3D NULL;
> +	}
> +
>  	spin_lock(&node->lock);
> =20
>  	page->encl_page =3D NULL;
> @@ -656,6 +690,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  	page->flags =3D SGX_EPC_PAGE_FREE;
> =20
>  	spin_unlock(&node->lock);
> +
>  	atomic_long_inc(&sgx_nr_free_pages);
>  }
> =20
> @@ -825,6 +860,7 @@ static bool __init sgx_setup_epc_section(u64 phys_add=
r, u64 size,
>  		section->pages[i].flags =3D 0;
>  		section->pages[i].encl_page =3D NULL;
>  		section->pages[i].poison =3D 0;
> +		section->pages[i].epc_cg =3D NULL;
>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>  	}
> =20
> @@ -969,6 +1005,7 @@ static void __init arch_update_sysfs_visibility(int =
nid) {}
>  static bool __init sgx_page_cache_init(void)
>  {
>  	u32 eax, ebx, ecx, edx, type;
> +	u64 capacity =3D 0;
>  	u64 pa, size;
>  	int nid;
>  	int i;
> @@ -1019,6 +1056,7 @@ static bool __init sgx_page_cache_init(void)
> =20
>  		sgx_epc_sections[i].node =3D  &sgx_numa_nodes[nid];
>  		sgx_numa_nodes[nid].size +=3D size;
> +		capacity +=3D size;
> =20
>  		sgx_nr_epc_sections++;
>  	}
> @@ -1028,6 +1066,9 @@ static bool __init sgx_page_cache_init(void)
>  		return false;
>  	}
> =20
> +	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
> +	sgx_epc_total_pages =3D capacity >> PAGE_SHIFT;
> +
>  	return true;
>  }
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 7e21192b87a8..bf746d2af96d 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -19,6 +19,11 @@
> =20
>  #define SGX_MAX_EPC_SECTIONS		8
>  #define SGX_EEXTEND_BLOCK_SIZE		256
> +
> +/*
> + * Maximum number of pages to scan for reclaiming.
> + */
> +#define SGX_NR_TO_SCAN_MAX		32UL
>  #define SGX_NR_TO_SCAN			16
>  #define SGX_NR_LOW_PAGES		32
>  #define SGX_NR_HIGH_PAGES		64
> @@ -70,6 +75,8 @@ enum sgx_epc_page_state {
>  /* flag for pages owned by a sgx_encl struct */
>  #define SGX_EPC_OWNER_ENCL		BIT(4)
> =20
> +struct sgx_epc_cgroup;
> +
>  struct sgx_epc_page {
>  	unsigned int section;
>  	u16 flags;
> @@ -79,6 +86,7 @@ struct sgx_epc_page {
>  		struct sgx_encl *encl;
>  	};
>  	struct list_head list;
> +	struct sgx_epc_cgroup *epc_cg;
>  };
> =20
>  static inline void sgx_epc_page_reset_state(struct sgx_epc_page *page)
> @@ -127,6 +135,7 @@ struct sgx_epc_section {
>  	struct sgx_numa_node *node;
>  };
> =20
> +extern u64 sgx_epc_total_pages;
>  extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
> =20
>  static inline unsigned long sgx_get_epc_phys_addr(struct sgx_epc_page *p=
age)
> @@ -150,7 +159,8 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_=
epc_page *page)
>  }
> =20
>  /*
> - * Contains EPC pages tracked by the reclaimer (ksgxd).
> + * Contains EPC pages tracked by the global reclaimer (ksgxd) or an EPC
> + * cgroup.
>   */
>  struct sgx_epc_lru_lists {
>  	spinlock_t lock;
> @@ -177,8 +187,9 @@ void sgx_record_epc_page(struct sgx_epc_page *page, u=
nsigned long flags);
>  int sgx_drop_epc_page(struct sgx_epc_page *page);
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
>  bool sgx_epc_oom(struct sgx_epc_lru_lists *lrus);
> -size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age);
> -void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lrus, size_t nr_to_=
scan,
> +size_t sgx_reclaim_epc_pages(size_t nr_to_scan, bool ignore_age,
> +			     struct sgx_epc_cgroup *epc_cg);
> +void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lrus, size_t *nr_to=
_scan,
>  			   struct list_head *dst);
> =20
>  void sgx_ipi_cb(void *info);
> --=20
> 2.25.1

BR, Jarkko
