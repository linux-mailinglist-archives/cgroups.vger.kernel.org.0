Return-Path: <cgroups+bounces-1209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8278373C5
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D390BB23AA9
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2970210FB;
	Mon, 22 Jan 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u23pRNB9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFF2CA8;
	Mon, 22 Jan 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955460; cv=none; b=IxoswBIQucV5g8hpk+3owGi5yXxikU+lFsM2VBD52cj+A5R4RjpIOU6QBru8L1RpffzBZCo7BhOsGNafQaPyKpDXS+MYnfqyrhMHPQ2VeF1c5fumVp3ZWA5sldU0f5Tq4L8CY0Z9rx1DmkY7SOhR5J4r/fsqOY9Z7RQaKq3AR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955460; c=relaxed/simple;
	bh=CEVmHe/aeVTJHj0p1EqnRkbEQGdvc9m+xVdBHthbO8o=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RSRbCMP9Y7pWAaufSpHbPtWzJyXY/hVCjJK6J13SphFCX6FImEJFUfphnXCeBAGQIR/5uCdtpUgIPsv/MC5JUiM3WF61nv3L8yqeqa+wVKgt2vgyQxg2eMoOKOGhY+lFd/ttCTVlz2T1sFv6v1ZGv07LksGLq+Ky+/D0rrAG1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u23pRNB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACF3C433C7;
	Mon, 22 Jan 2024 20:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955460;
	bh=CEVmHe/aeVTJHj0p1EqnRkbEQGdvc9m+xVdBHthbO8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u23pRNB9svuEJZyuZKwRleLD6Gpzr4BZw74mhcUT4fDWbw1GD0qXs5ZgUYlBzThPA
	 3Q3BEggBx8GBX+q/9Kq1xrTuaz5kODvXfjjJ6h2f/81dYWqaHB2Mch5HZyeBerxKq2
	 tuGGdslG2AW8V8BvdnLttxuDGPPlajdvFfKHGp5UnNbDIL81sGU9nNvRcjNZNct8ky
	 6ThdwTjZ1b6s2Ha/9qOP9c/n0S+iUKqwZrXWhhm2tCThz6iUqXZ86df1wdXnUyv2Nd
	 /3M/cGJ/s6h4K7fRfPlLqKvrcrvVeSWJ7tdvo/NMw9OcAx6SQdOACNWrpw5Qfh+Ise
	 Evw0VF2ElAZdQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 22:30:54 +0200
Message-Id: <CYLIQKQ7OLJ2.2FEBPRSQN6P1N@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v7 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-10-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-10-haitao.huang@linux.intel.com>

On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
> Enclave Page Cache(EPC) memory can be swapped out to regular system
> memory, and the consumed memory should be charged to a proper
> mem_cgroup. Currently the selection of mem_cgroup to charge is done in
> sgx_encl_get_mem_cgroup(). But it only considers two contexts in which
> the swapping can be done: normal tasks and the ksgxd kthread.
> With the new EPC cgroup implementation, the swapping can also happen in
> EPC cgroup work-queue threads. In those cases, it improperly selects the
> root mem_cgroup to charge for the RAM usage.
>
> Change sgx_encl_get_mem_cgroup() to handle non-task contexts only and
> return the mem_cgroup of an mm_struct associated with the enclave. The
> return is used to charge for EPC backing pages in all kthread cases.
>
> Pass a flag into the top level reclamation function,
> sgx_reclaim_pages(), to explicitly indicate whether it is called from a
> background kthread. Internally, if the flag is true, switch the active
> mem_cgroup to the one returned from sgx_encl_get_mem_cgroup(), prior to
> any backing page allocation, in order to ensure that shmem page
> allocations are charged to the enclave's cgroup.
>
> Removed current_is_ksgxd() as it is no longer needed.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c       | 43 ++++++++++++++--------------
>  arch/x86/kernel/cpu/sgx/encl.h       |  3 +-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c |  7 +++--
>  arch/x86/kernel/cpu/sgx/main.c       | 27 ++++++++---------
>  arch/x86/kernel/cpu/sgx/sgx.h        |  3 +-
>  5 files changed, 40 insertions(+), 43 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 279148e72459..75178cc7a6d2 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -993,9 +993,7 @@ static int __sgx_encl_get_backing(struct sgx_encl *en=
cl, unsigned long page_inde
>  }
> =20
>  /*
> - * When called from ksgxd, returns the mem_cgroup of a struct mm stored
> - * in the enclave's mm_list. When not called from ksgxd, just returns
> - * the mem_cgroup of the current task.
> + * Returns the mem_cgroup of a struct mm stored in the enclave's mm_list=
.
>   */
>  static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
>  {
> @@ -1003,14 +1001,6 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(=
struct sgx_encl *encl)
>  	struct sgx_encl_mm *encl_mm;
>  	int idx;
> =20
> -	/*
> -	 * If called from normal task context, return the mem_cgroup
> -	 * of the current task's mm. The remainder of the handling is for
> -	 * ksgxd.
> -	 */
> -	if (!current_is_ksgxd())
> -		return get_mem_cgroup_from_mm(current->mm);
> -
>  	/*
>  	 * Search the enclave's mm_list to find an mm associated with
>  	 * this enclave to charge the allocation to.
> @@ -1047,29 +1037,38 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup=
(struct sgx_encl *encl)
>   * @encl:	an enclave pointer
>   * @page_index:	enclave page index
>   * @backing:	data for accessing backing storage for the page
> + * @indirect:	in ksgxd or EPC cgroup work queue context
> + *
> + * Create a backing page for loading data back into an EPC page with ELD=
U. This function takes
> + * a reference on a new backing page which must be dropped with a corres=
ponding call to
> + * sgx_encl_put_backing().
>   *
> - * When called from ksgxd, sets the active memcg from one of the
> - * mms in the enclave's mm_list prior to any backing page allocation,
> - * in order to ensure that shmem page allocations are charged to the
> - * enclave.  Create a backing page for loading data back into an EPC pag=
e with
> - * ELDU.  This function takes a reference on a new backing page which
> - * must be dropped with a corresponding call to sgx_encl_put_backing().
> + * When @indirect is true, sets the active memcg from one of the mms in =
the enclave's mm_list
> + * prior to any backing page allocation, in order to ensure that shmem p=
age allocations are
> + * charged to the enclave.

Same complaint abouve unnecessarily long text paragraph. These are just
impractical.

>   *
>   * Return:
>   *   0 on success,
>   *   -errno otherwise.
>   */
>  int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_ind=
ex,
> -			   struct sgx_backing *backing)
> +			   struct sgx_backing *backing, bool indirect)
>  {
> -	struct mem_cgroup *encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
> -	struct mem_cgroup *memcg =3D set_active_memcg(encl_memcg);
> +	struct mem_cgroup *encl_memcg;
> +	struct mem_cgroup *memcg;
>  	int ret;
> =20
> +	if (indirect) {
> +		encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
> +		memcg =3D set_active_memcg(encl_memcg);
> +	}
> +
>  	ret =3D __sgx_encl_get_backing(encl, page_index, backing);
> =20
> -	set_active_memcg(memcg);
> -	mem_cgroup_put(encl_memcg);
> +	if (indirect) {
> +		set_active_memcg(memcg);
> +		mem_cgroup_put(encl_memcg);
> +	}
> =20
>  	return ret;
>  }
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/enc=
l.h
> index f94ff14c9486..549cd2e8d98b 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -103,12 +103,11 @@ static inline int sgx_encl_find(struct mm_struct *m=
m, unsigned long addr,
>  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  		     unsigned long end, unsigned long vm_flags);
> =20
> -bool current_is_ksgxd(void);
>  void sgx_encl_release(struct kref *ref);
>  int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
>  const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
>  int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_ind=
ex,
> -			   struct sgx_backing *backing);
> +			   struct sgx_backing *backing, bool indirect);
>  void sgx_encl_put_backing(struct sgx_backing *backing);
>  int sgx_encl_test_and_clear_young(struct mm_struct *mm,
>  				  struct sgx_encl_page *page);
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index 71570c346d95..44265f62b2a4 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -85,9 +85,10 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
>  /**
>   * sgx_epc_cgroup_reclaim_pages() - walk a cgroup tree and scan LRUs to =
reclaim pages
>   * @root:	Root of the tree to start walking
> + * @indirect:   In ksgxd or EPC cgroup work queue context.
>   * Return:	Number of pages reclaimed.
>   */
> -unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
> +static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, b=
ool indirect)
>  {
>  	/*
>  	 * Attempting to reclaim only a few pages will often fail and is ineffi=
cient, while
> @@ -111,7 +112,7 @@ unsigned int sgx_epc_cgroup_reclaim_pages(struct misc=
_cg *root)
>  		rcu_read_unlock();
> =20
>  		epc_cg =3D sgx_epc_cgroup_from_misc_cg(css_misc(pos));
> -		cnt +=3D sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan);
> +		cnt +=3D sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan, indirect);
> =20
>  		rcu_read_lock();
>  		css_put(pos);
> @@ -168,7 +169,7 @@ static void sgx_epc_cgroup_reclaim_work_func(struct w=
ork_struct *work)
>  			break;
> =20
>  		/* Keep reclaiming until above condition is met. */
> -		sgx_epc_cgroup_reclaim_pages(epc_cg->cg);
> +		sgx_epc_cgroup_reclaim_pages(epc_cg->cg, true);
>  	}
>  }
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 60cb3a7b3001..14314f25880d 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -254,7 +254,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_pag=
e,
>  }
> =20
>  static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
> -				struct sgx_backing *backing)
> +				struct sgx_backing *backing, bool indirect)
>  {
>  	struct sgx_encl_page *encl_page =3D epc_page->owner;
>  	struct sgx_encl *encl =3D encl_page->encl;
> @@ -270,7 +270,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *=
epc_page,
> =20
>  	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flag=
s)) {
>  		ret =3D sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
> -					   &secs_backing);
> +					   &secs_backing, indirect);
>  		if (ret)
>  			goto out;
> =20
> @@ -301,9 +301,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page =
*epc_page,
>   *
>   * @lru:	The LRU from which pages are reclaimed.
>   * @nr_to_scan: Pointer to the target number of pages to scan, must be l=
ess than SGX_NR_TO_SCAN.
> + * @indirect:	In ksgxd or EPC cgroup work queue contexts.
>   * Return:	Number of pages reclaimed.
>   */
> -unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned in=
t *nr_to_scan)
> +unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned in=
t *nr_to_scan,
> +			       bool indirect)
>  {
>  	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
> @@ -345,7 +347,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_lis=
t *lru, unsigned int *nr_to
>  		page_index =3D PFN_DOWN(encl_page->desc - encl_page->encl->base);
> =20
>  		mutex_lock(&encl_page->encl->lock);
> -		ret =3D sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i=
]);
> +		ret =3D sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i=
], indirect);
>  		if (ret) {
>  			mutex_unlock(&encl_page->encl->lock);
>  			goto skip;
> @@ -378,7 +380,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_lis=
t *lru, unsigned int *nr_to
>  			continue;
> =20
>  		encl_page =3D epc_page->owner;
> -		sgx_reclaimer_write(epc_page, &backing[i]);
> +		sgx_reclaimer_write(epc_page, &backing[i], indirect);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
>  		epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> @@ -396,11 +398,11 @@ static bool sgx_should_reclaim(unsigned long waterm=
ark)
>  	       !list_empty(&sgx_global_lru.reclaimable);
>  }
> =20
> -static void sgx_reclaim_pages_global(void)
> +static void sgx_reclaim_pages_global(bool indirect)
>  {
>  	unsigned int nr_to_scan =3D SGX_NR_TO_SCAN;
> =20
> -	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan);
> +	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan, indirect);
>  }
> =20
>  /*
> @@ -411,7 +413,7 @@ static void sgx_reclaim_pages_global(void)
>  void sgx_reclaim_direct(void)
>  {
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_pages_global();
> +		sgx_reclaim_pages_global(false);
>  }
> =20
>  static int ksgxd(void *p)
> @@ -434,7 +436,7 @@ static int ksgxd(void *p)
>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
> =20
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> -			sgx_reclaim_pages_global();
> +			sgx_reclaim_pages_global(true);
> =20
>  		cond_resched();
>  	}
> @@ -457,11 +459,6 @@ static bool __init sgx_page_reclaimer_init(void)
>  	return true;
>  }
> =20
> -bool current_is_ksgxd(void)
> -{
> -	return current =3D=3D ksgxd_tsk;
> -}
> -
>  static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
>  {
>  	struct sgx_numa_node *node =3D &sgx_numa_nodes[nid];
> @@ -621,7 +618,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
bool reclaim)
>  		 * Need to do a global reclamation if cgroup was not full but free
>  		 * physical pages run out, causing __sgx_alloc_epc_page() to fail.
>  		 */
> -		sgx_reclaim_pages_global();
> +		sgx_reclaim_pages_global(false);
>  		cond_resched();
>  	}
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 2593c013d091..cfe906054d85 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -110,7 +110,8 @@ void sgx_reclaim_direct(void);
>  void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
>  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
> -unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned in=
t *nr_to_scan);
> +unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned in=
t *nr_to_scan,
> +			       bool indirect);
> =20
>  void sgx_ipi_cb(void *info);
> =20


BR, Jarkko

