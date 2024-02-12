Return-Path: <cgroups+bounces-1425-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09008851E14
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 20:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B3C1C21B81
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3F47793;
	Mon, 12 Feb 2024 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMkGTztB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20A4655D;
	Mon, 12 Feb 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767174; cv=none; b=Fi4gOFc1NX3qsGlCvY7Y3fBzBKMbqzcO1ikMz5zcEOiuMfAAoehBucE6VpkOE5sn+8ZBCBamdAro4MglV+FVGbDC0XufsuYaCXw5ctdXux1x+Q2AWH1AWOKks2ht9M6T+MQgFTBF0WxkhNfLNx+jynrfPePKINSMW+bUr8/2Hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767174; c=relaxed/simple;
	bh=wmrRIIWxu65O5N6AI7t+rUM+StBiZ94nY72lvTwW/mg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J4pJWkA5eIDTn0RSDs+8+eJ2nlO4DnLYzCtrxAeSakap54KTzRC0y4eCOv7EdGbrw2GLEyZ79sZ7ftfH3iz1WpX9oUgVPGCxFatRAv95zTmF80gCZd+OqbBxS+wv1CgKY5KvvXd8IzDX6goTgwsyaiUsPyhggB7J6Vu10bWPUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMkGTztB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C1CC433C7;
	Mon, 12 Feb 2024 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707767173;
	bh=wmrRIIWxu65O5N6AI7t+rUM+StBiZ94nY72lvTwW/mg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nMkGTztBtlCouzJvZf4+2ptVWM/SQCVioG/p024lZ1nkvwgg8KzUDujxlKzjMtyYj
	 5hD/9Jlm8qSuknr2XCfdyhhFX4Fnam4eCWkfSZX10hlJb9NJKfhat4TtFE0c6MIUuU
	 siTQkFf+Z130A6UET+P4umXEJLwPyWCrU6DA8t67SzTiYN2MQj9w839/TsZ6+2Ejk9
	 /XOO0EQBz6FKgYLJHctJOSsrKB76q28jAfmFML88Z72K0dpWB1QOm0AVEYE8kRwZpU
	 lQDnwqizeTnZ2y1/BJo9uMhLl3ixjKvOyi+iOT8BTP/AmDfRawZslcNnj5LBtftcLr
	 U5VvJS62Cxrhw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 21:46:06 +0200
Message-Id: <CZ3CXPOLZEI8.C6AJ9W0W07A9@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.16.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-10-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-10-haitao.huang@linux.intel.com>

On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
> Enclave Page Cache(EPC) memory can be swapped out to regular system

"Enclave Page Cache (EPC)"
                   ~

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
> V9:
> - Reduce number of if statements. (Tim)
>
> V8:
> - Limit text paragraphs to 80 characters wide. (Jarkko)
> ---
>  arch/x86/kernel/cpu/sgx/encl.c       | 38 +++++++++++++---------------
>  arch/x86/kernel/cpu/sgx/encl.h       |  3 +--
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c |  7 ++---
>  arch/x86/kernel/cpu/sgx/main.c       | 27 +++++++++-----------
>  arch/x86/kernel/cpu/sgx/sgx.h        |  3 ++-
>  5 files changed, 36 insertions(+), 42 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 279148e72459..4e5948362060 100644
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
> @@ -1047,27 +1037,33 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup=
(struct sgx_encl *encl)
>   * @encl:	an enclave pointer
>   * @page_index:	enclave page index
>   * @backing:	data for accessing backing storage for the page
> + * @indirect:	in ksgxd or EPC cgroup work queue context
> + *
> + * Create a backing page for loading data back into an EPC page with ELD=
U. This
> + * function takes a reference on a new backing page which must be droppe=
d with a
> + * corresponding call to sgx_encl_put_backing().
>   *
> - * When called from ksgxd, sets the active memcg from one of the
> - * mms in the enclave's mm_list prior to any backing page allocation,
> - * in order to ensure that shmem page allocations are charged to the
> - * enclave.  Create a backing page for loading data back into an EPC pag=
e with
> - * ELDU.  This function takes a reference on a new backing page which
> - * must be dropped with a corresponding call to sgx_encl_put_backing().
> + * When @indirect is true, sets the active memcg from one of the mms in =
the
> + * enclave's mm_list prior to any backing page allocation, in order to e=
nsure
> + * that shmem page allocations are charged to the enclave.
>   *
>   * Return:
>   *   0 on success,
>   *   -errno otherwise.
>   */
>  int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_ind=
ex,
> -			   struct sgx_backing *backing)
> +			   struct sgx_backing *backing, bool indirect)

Boolean parameters should be avoided when possible because they confuse
in the call sites.

>  {
> -	struct mem_cgroup *encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
> -	struct mem_cgroup *memcg =3D set_active_memcg(encl_memcg);
> +	struct mem_cgroup *encl_memcg;
> +	struct mem_cgroup *memcg;
>  	int ret;
> =20
> -	ret =3D __sgx_encl_get_backing(encl, page_index, backing);
> +	if (!indirect)
> +		return  __sgx_encl_get_backing(encl, page_index, backing);

If a call is either in heead or tail of the code block, then
obviously better option is to make __sgx_encl_get_backing()
as non-static sgx_encl_get_backing() and call it in those
call sites that would call this with "false".

I.e. you need a new patch where this preparation is done.

> =20
> +	encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
> +	memcg =3D set_active_memcg(encl_memcg);
> +	ret =3D __sgx_encl_get_backing(encl, page_index, backing);
>  	set_active_memcg(memcg);
>  	mem_cgroup_put(encl_memcg);
> =20
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
> index 16b6d9f909eb..d399fda2b55e 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -93,9 +93,10 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
>  /**
>   * sgx_epc_cgroup_reclaim_pages() - walk a cgroup tree and scan LRUs to =
reclaim pages
>   * @root:	Root of the tree to start walking from.
> + * @indirect:   In ksgxd or EPC cgroup work queue context.
>   * Return:	Number of pages reclaimed.
>   */
> -unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root)
> +static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, b=
ool indirect)
>  {
>  	/*
>  	 * Attempting to reclaim only a few pages will often fail and is
> @@ -119,7 +120,7 @@ unsigned int sgx_epc_cgroup_reclaim_pages(struct misc=
_cg *root)
>  		rcu_read_unlock();
> =20
>  		epc_cg =3D sgx_epc_cgroup_from_misc_cg(css_misc(pos));
> -		cnt +=3D sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan);
> +		cnt +=3D sgx_reclaim_pages(&epc_cg->lru, &nr_to_scan, indirect);
> =20
>  		rcu_read_lock();
>  		css_put(pos);
> @@ -176,7 +177,7 @@ static void sgx_epc_cgroup_reclaim_work_func(struct w=
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
> index 4f5824c4751d..51904f191b97 100644
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
> @@ -304,9 +304,11 @@ static void sgx_reclaimer_write(struct sgx_epc_page =
*epc_page,
>   * @lru:	The LRU from which pages are reclaimed.
>   * @nr_to_scan: Pointer to the target number of pages to scan, must be l=
ess than
>   *		SGX_NR_TO_SCAN.
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
> @@ -348,7 +350,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_lis=
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
> @@ -381,7 +383,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_lis=
t *lru, unsigned int *nr_to
>  			continue;
> =20
>  		encl_page =3D epc_page->owner;
> -		sgx_reclaimer_write(epc_page, &backing[i]);
> +		sgx_reclaimer_write(epc_page, &backing[i], indirect);
> =20
>  		kref_put(&encl_page->encl->refcount, sgx_encl_release);
>  		epc_page->flags &=3D ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> @@ -399,11 +401,11 @@ static bool sgx_should_reclaim(unsigned long waterm=
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
> @@ -414,7 +416,7 @@ static void sgx_reclaim_pages_global(void)
>  void sgx_reclaim_direct(void)
>  {
>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> -		sgx_reclaim_pages_global();
> +		sgx_reclaim_pages_global(false);
>  }
> =20
>  static int ksgxd(void *p)
> @@ -437,7 +439,7 @@ static int ksgxd(void *p)
>  				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
> =20
>  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> -			sgx_reclaim_pages_global();
> +			sgx_reclaim_pages_global(true);
> =20
>  		cond_resched();
>  	}
> @@ -460,11 +462,6 @@ static bool __init sgx_page_reclaimer_init(void)
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
> @@ -623,7 +620,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
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

Br, Jarkko

