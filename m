Return-Path: <cgroups+bounces-1208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7AC8373BC
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39626B2392B
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AEF47784;
	Mon, 22 Jan 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/7FwTYx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B64654F;
	Mon, 22 Jan 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955385; cv=none; b=X8TDeJosAjmH+Hxji8N26sc/FpC5hjqCHhR3Q3dNH1Bp6f97rjffxloMnvCk6+dE0pON1nYXOLVyPJuSjH18TYzNeQUwDsY/jR1e8E6tmgpbw5VW4cNrfMv7H5zx5x2O/9rxgxAUVs18znlVU+N2l/LPp2TcqF4ordrtrO/+mTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955385; c=relaxed/simple;
	bh=adCe6b0ljr24ag+MOX3n9yqu0J/HQT+j4TxHLoauZ38=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=crQRM2IsBT6ec+nNax5CN8PCwABRpB4bn79MtFklaYXJIbexcetjNf1W51+wbJyeJ4SQMSnUM3vloN9d8zB0InDfA5rx9aMhwjETsdgsTac8SO0jMD6GQxBFRMgAwK7U62ZiodTpp1SZC2OyXKBwFfasQ6pSHL44gIEnBOtMhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/7FwTYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB237C433C7;
	Mon, 22 Jan 2024 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955384;
	bh=adCe6b0ljr24ag+MOX3n9yqu0J/HQT+j4TxHLoauZ38=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r/7FwTYx6WM/7TKatna1QXSVQ+HpEMSf/rQOtta246AyBfnfJBkwhDmmz68J8IVic
	 wYlPe1ATM42qeyE41UrdhwE4vOXcK6j4aq74ysgZBlCgmtlrfuS2AaS6FhEvdICerT
	 bKLw1m65dGzh+FaTA4+iKSVo27vc8sM2AQCX9QHKgQOk3H33vb0qiPYZxZrArMdh3k
	 FCvZaQsINnfkGZxOVFOvyMi/JMzb3Zen4B1DFnNb/N9upsADMF7oSmrgMdaYy2BZTi
	 Plpvwptz4O2uHrnhyGRCYsZJzhGaI4BGaQlO9SStgvaqQ9KU7/pJkyD1VxYLSf6GZL
	 iaJgZ8iO3yXFQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 22:29:39 +0200
Message-Id: <CYLIPLXW35L0.S9V1OGYVBDPD@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v7 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-9-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-9-haitao.huang@linux.intel.com>

On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Implement the reclamation flow for cgroup, encapsulated in the top-level
> function sgx_epc_cgroup_reclaim_pages(). It does a pre-order walk on its
> subtree, and make calls to sgx_reclaim_pages() at each node passing in
> the LRU of that node. It keeps track of total reclaimed pages, and pages
> left to attempt.  It stops the walk if desired number of pages are
> attempted.
>
> In some contexts, e.g. page fault handling, only asynchronous
> reclamation is allowed. Create a work-queue, corresponding work item and
> function definitions to support the asynchronous reclamation. Both
> synchronous and asynchronous flows invoke the same top level reclaim
> function, and will be triggered later by sgx_epc_cgroup_try_charge()
> when usage of the cgroup is at or near its limit.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 174 ++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |   5 +-
>  2 files changed, 177 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index 938695816a9e..71570c346d95 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -7,9 +7,173 @@
> =20
>  static struct sgx_epc_cgroup epc_cg_root;
> =20
> +static struct workqueue_struct *sgx_epc_cg_wq;
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
> +/*
> + * Get the lower bound of limits of a cgroup and its ancestors.  Used in
> + * sgx_epc_cgroup_reclaim_work_func() to determine if EPC usage of a cgr=
oup is over its limit
> + * or its ancestors' hence reclamation is needed.
> + */
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
> +
> +	return m / PAGE_SIZE;
> +}
> +
>  /**
> - * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC p=
age
> + * sgx_epc_cgroup_lru_empty() - check if a cgroup tree has no pages on i=
ts LRUs
> + * @root:	Root of the tree to check
>   *
> + * Return: %true if all cgroups under the specified root have empty LRU =
lists.
> + * Used to avoid livelocks due to a cgroup having a non-zero charge coun=
t but
> + * no pages on its LRUs, e.g. due to a dead enclave waiting to be releas=
ed or
> + * because all pages in the cgroup are unreclaimable.
> + */
> +bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
> +{
> +	struct cgroup_subsys_state *css_root;
> +	struct cgroup_subsys_state *pos;
> +	struct sgx_epc_cgroup *epc_cg;
> +	bool ret =3D true;
> +
> +	/*
> +	 * Caller ensure css_root ref acquired
> +	 */
> +	css_root =3D &root->css;
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
> +
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +/**
> + * sgx_epc_cgroup_reclaim_pages() - walk a cgroup tree and scan LRUs to =
reclaim pages
> + * @root:	Root of the tree to start walking
> + * Return:	Number of pages reclaimed.
> + */
> +unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
> +{
> +	/*
> +	 * Attempting to reclaim only a few pages will often fail and is ineffi=
cient, while
> +	 * reclaiming a huge number of pages can result in soft lockups due to =
holding various
> +	 * locks for an extended duration.
> +	 */
> +	unsigned int nr_to_scan =3D SGX_NR_TO_SCAN;
> +	struct cgroup_subsys_state *css_root;
> +	struct cgroup_subsys_state *pos;
> +	struct sgx_epc_cgroup *epc_cg;
> +	unsigned int cnt;
> +
> +	 /* Caller ensure css_root ref acquired */
> +	css_root =3D &root->css;
> +
> +	cnt =3D 0;
> +	rcu_read_lock();
> +	css_for_each_descendant_pre(pos, css_root) {
> +		if (!css_tryget(pos))
> +			break;
> +		rcu_read_unlock();
> +
> +		epc_cg =3D sgx_epc_cgroup_from_misc_cg(css_misc(pos));
> +		cnt +=3D sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan);
> +
> +		rcu_read_lock();
> +		css_put(pos);
> +		if (!nr_to_scan)
> +			break;
> +	}
> +
> +	rcu_read_unlock();
> +	return cnt;
> +}
> +
> +/*
> + * Scheduled by sgx_epc_cgroup_try_charge() to reclaim pages from the cg=
roup when the cgroup is
> + * at/near its maximum capacity
> + */
> +static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
> +{
> +	struct sgx_epc_cgroup *epc_cg;
> +	u64 cur, max;
> +
> +	epc_cg =3D container_of(work, struct sgx_epc_cgroup, reclaim_work);
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
> +		if (max > SGX_NR_TO_SCAN * 2)
> +			max -=3D (SGX_NR_TO_SCAN / 2);
> +
> +		cur =3D sgx_epc_cgroup_page_counter_read(epc_cg);
> +
> +		if (cur <=3D max || sgx_epc_cgroup_lru_empty(epc_cg->cg))
> +			break;
> +
> +		/* Keep reclaiming until above condition is met. */
> +		sgx_epc_cgroup_reclaim_pages(epc_cg->cg);
> +	}
> +}
> +
> +/**
> + * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC p=
age
>   * @epc_cg:	The EPC cgroup to be charged for the page.
>   * Return:
>   * * %0 - If successfully charged.
> @@ -43,6 +207,7 @@ static void sgx_epc_cgroup_free(struct misc_cg *cg)
>  	if (!epc_cg)
>  		return;
> =20
> +	cancel_work_sync(&epc_cg->reclaim_work);
>  	kfree(epc_cg);
>  }
> =20
> @@ -55,6 +220,8 @@ const struct misc_res_ops sgx_epc_cgroup_ops =3D {
> =20
>  static void sgx_epc_misc_init(struct misc_cg *cg, struct sgx_epc_cgroup =
*epc_cg)
>  {
> +	sgx_lru_init(&epc_cg->lru);
> +	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
>  	cg->res[MISC_CG_RES_SGX_EPC].priv =3D epc_cg;
>  	epc_cg->cg =3D cg;
>  }
> @@ -74,6 +241,11 @@ static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
> =20
>  void sgx_epc_cgroup_init(void)
>  {
> +	sgx_epc_cg_wq =3D alloc_workqueue("sgx_epc_cg_wq",
> +					WQ_UNBOUND | WQ_FREEZABLE,
> +					WQ_UNBOUND_MAX_ACTIVE);
> +	BUG_ON(!sgx_epc_cg_wq);
> +
>  	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_epc_cgroup_ops);
>  	sgx_epc_misc_init(misc_cg_root(), &epc_cg_root);
>  }
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.h
> index 971df34f27d8..9b77b51a2839 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -33,7 +33,9 @@ static inline void sgx_epc_cgroup_uncharge(struct sgx_e=
pc_cgroup *epc_cg) { }
>  static inline void sgx_epc_cgroup_init(void) { }
>  #else
>  struct sgx_epc_cgroup {
> -	struct misc_cg *cg;
> +	struct misc_cg			*cg;
> +	struct sgx_epc_lru_list		lru;
> +	struct work_struct		reclaim_work;

We don't align fields anywhere else so this is somewhat inconsistent.

>  };
> =20
>  static inline struct sgx_epc_cgroup *sgx_epc_cgroup_from_misc_cg(struct =
misc_cg *cg)
> @@ -66,6 +68,7 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup=
 *epc_cg)
> =20
>  int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg);
>  void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
> +bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
>  void sgx_epc_cgroup_init(void);
> =20
>  #endif


BR, Jarkko

