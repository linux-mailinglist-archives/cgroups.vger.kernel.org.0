Return-Path: <cgroups+bounces-1309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8EF84648F
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 00:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D01F24A59
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FA405FC;
	Thu,  1 Feb 2024 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6fNFu55"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24247F42;
	Thu,  1 Feb 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830754; cv=none; b=FHnpw7Bqbck5e+Vwq2cBQU8fwKqPgckzAmFxUMVJfxCRuCmAbJT2fpgLw3i4e9gkxLscp1S3BMHxlHcqraYPrvFMnNILWg37NVNEptjVJSANNOzrxQp1AhYh/cnEKzox8iL1EyTdKFh3oeQ1dK7hhzKedWpgd5IozhBCRB9NVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830754; c=relaxed/simple;
	bh=bb0KwJvGJwrGIPmX8iroMUnhxXDz0KbhRrZZ5W2MKQo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KUJl6jKdFz+ECrXpTxDrWVH8mBICbACM+qwwpMYAQZIHovTaN4gGHXyh1sQnd13i7UQssMSeNMJxBw21ee6p1QQmnF2bwBzaZD0640TZi3FBeq+der1dGFqFfbjFne+K4GnyRKlNwa0D+qqtmhy+yXZbLDZ61hXaCEDvFfvj2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6fNFu55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB3FC433F1;
	Thu,  1 Feb 2024 23:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706830753;
	bh=bb0KwJvGJwrGIPmX8iroMUnhxXDz0KbhRrZZ5W2MKQo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Q6fNFu55GlNq+JG53VoHB0wmSFQv2mvsWCk/f830jCDPdjytFuc4448pkaIrSTBW0
	 K204b8aZ4LQDIybHPyyBoJk/I4egL+DeSssUPtWr2AM6d5fUnvd53r6guTKJm+F/Op
	 KCof5w2+An/UvRroZCXoMs7iD9Aflm2y747G5txbnGRWDuu984fgbpqkccFWYGXqqq
	 VfJQdypMRs1NQg157ad7Z06LxTyxTvhu237B+Oj4v6ZN3u+b5cuaZ/Q+UdHdQfhhDS
	 AsPzr8c/cquwrLQP13G69cTjZpdYi2A5J6JBNrlqV8W4y9tEdt6OQDL26wCzQr2VHN
	 7wanjqko7Qsyw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:39:07 +0200
Message-Id: <CYU504RLY7QU.QZY9LWC076NX@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v8 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-9-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-9-haitao.huang@linux.intel.com>

On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
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
> V8:
> - Remove alignment for substructure variables. (Jarkko)
>
> V7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 174 ++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |   3 +
>  2 files changed, 176 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index eac8548164de..8858a0850f8a 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -7,9 +7,173 @@
> =20
>  static struct sgx_epc_cgroup epc_cg_root;
> =20
> +static struct workqueue_struct *sgx_epc_cg_wq;

I'd document this with a comment.

Missed this for "epc_eg_root", which should have the same treatment.

Just brief 1-2 line thing, no need for prose here. Something to remind
what it is later on.

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
oup is
> + * over its limit or its ancestors' hence reclamation is needed.
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
> +	 * Attempting to reclaim only a few pages will often fail and is
> +	 * inefficient, while reclaiming a huge number of pages can result in
> +	 * soft lockups due to holding various locks for an extended duration.
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
roup
> + * when the cgroup is at/near its maximum capacity
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
> @@ -37,6 +201,7 @@ static void sgx_epc_cgroup_free(struct misc_cg *cg)
>  	if (!epc_cg)
>  		return;
> =20
> +	cancel_work_sync(&epc_cg->reclaim_work);
>  	kfree(epc_cg);
>  }
> =20
> @@ -49,6 +214,8 @@ const struct misc_res_ops sgx_epc_cgroup_ops =3D {
> =20
>  static void sgx_epc_misc_init(struct misc_cg *cg, struct sgx_epc_cgroup =
*epc_cg)
>  {
> +	sgx_lru_init(&epc_cg->lru);
> +	INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
>  	cg->res[MISC_CG_RES_SGX_EPC].priv =3D epc_cg;
>  	epc_cg->cg =3D cg;
>  }
> @@ -68,6 +235,11 @@ static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
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
> index 6b664b4c321f..e3c6a08f0ee8 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -34,6 +34,8 @@ static inline void sgx_epc_cgroup_init(void) { }
>  #else
>  struct sgx_epc_cgroup {
>  	struct misc_cg *cg;
> +	struct sgx_epc_lru_list lru;
> +	struct work_struct reclaim_work;
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

