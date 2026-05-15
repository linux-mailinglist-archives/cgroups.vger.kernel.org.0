Return-Path: <cgroups+bounces-15979-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAv7GqQoB2ppsQIAu9opvQ
	(envelope-from <cgroups+bounces-15979-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 16:07:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23080551010
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 16:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DA5A3058E44
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AE47ECDD;
	Fri, 15 May 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1yx1trM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749C2DEA6B;
	Fri, 15 May 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853234; cv=none; b=Emm0QtJyao7D0sMO/LN7JWIojhOHYwlJLPsSRI8DVJ6RBihcEf75j+IW/HLDUvb4q1q26XUkHz67ewFDRamj9jExMS+PXk6qFtYfhMxBkChSq3a604H2BPIC+aGRr9fVE40riJpu9+y+CiIk54jKQQQ/i1RzIXjhz0VAPvajj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853234; c=relaxed/simple;
	bh=Y1gyeosz2qkHMid+rX2ftXz6wmVUtQk3hZVNk9+H5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCJmx+BWP4QOgVFq8b64jVrdWSnYonVSsX2t7CBdSps4MZN2XfYuNdr5pXVeSgQqBLiGwt42BQKJDto94UOJ/sbtUmpb2MuT8olrrTTG+7dhGmiA6vFn4XtYiXq3x/c0vUmHjDzV5787naX7lHmyV3/SCwnf8tzDy60DWvqXU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1yx1trM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BFFC2BCB0;
	Fri, 15 May 2026 13:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778853233;
	bh=Y1gyeosz2qkHMid+rX2ftXz6wmVUtQk3hZVNk9+H5Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1yx1trMAuX4uPgzq30KugkFgBWvGkQ00OTXt4fD7QZY9PIT7MWK279StfLyH0/ZK
	 wR0mCQGAASYvb7XRaKka7b3eG8xalsI55aG1urnDe8Xf2zeqgl1tKvsweZ6RBSz4du
	 Q3dLgvgGJpG//hSbnYPnx4RlJvQyFnt4udgMSCIdKH90bPm2vP3+wpECg63GzaGLE/
	 Ckf/8qWWNBeLmb5/xKUFUR/o+ko9JQJ1t42RauAVv7nFmWoC3C+QX/AZ5TCI9Y/omB
	 70ruKCdTp3nOv0v8ubEIYX1iGJeLH0F4V/f3kALZbYJe19fguIjBCczEgBZZxKDaAz
	 1ZHsw2Kh1vAlg==
Date: Fri, 15 May 2026 15:53:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mripard@kernel.org, echanude@redhat.com
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit
 memcg
Message-ID: <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
X-Rspamd-Queue-Id: 23080551010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15979-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> On embedded platforms a central process often allocates dma-buf
> memory on behalf of client applications. Without a way to
> attribute the charge to the requesting client's cgroup, the
> cost lands on the allocator, making per-cgroup memory limits
> ineffective for the actual consumers.
> 
> Add charge_pid_fd to struct dma_heap_allocation_data. When set to

Please be aware that pidfds come in two flavors:

thread-group pidfds and thread-specific pidfds. Make sure that your API
doesn't implicitly depend on this distinction not existing.


> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> the mem_accounting module parameter enabled, the buffer is charged
> to the allocator's own cgroup.
> 
> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> all accounting through a single MEMCG_DMABUF path.
> 
> Usage examples:
> 
>   1. Central allocator charging to a client at allocation time.
>      The allocator knows the client's PID (e.g., from binder's
>      sender_pid) and uses pidfd to attribute the charge:
> 
>        pid_t client_pid = txn->sender_pid;
>        int pidfd = pidfd_open(client_pid, 0);
> 
>        struct dma_heap_allocation_data alloc = {
>            .len             = buffer_size,
>            .fd_flags        = O_RDWR | O_CLOEXEC,
>            .charge_pid_fd   = pidfd,
>        };
>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>        close(pidfd);
>        /* alloc.fd is now charged to client's cgroup */
> 
>   2. Default allocation (no pidfd, mem_accounting=1).
>      When charge_pid_fd is not set and the mem_accounting module
>      parameter is enabled, the buffer is charged to the allocator's
>      own cgroup:
> 
>        struct dma_heap_allocation_data alloc = {
>            .len      = buffer_size,
>            .fd_flags = O_RDWR | O_CLOEXEC,
>        };
>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>        /* charged to current process's cgroup */
> 
> Current limitations:
> 
>  - Single-owner model: a dma-buf carries one memcg charge regardless of
>    how many processes share it. Means only the first owner (and exporter)
>    of the shared buffer bears the charge.
>  - Only memcg accounting supported. While this makes sense for system
>    heap buffers, other heaps (e.g., CMA heaps) will require selectively
>    charging also for the dmem controller.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
>  drivers/dma-buf/dma-buf.c               | 16 ++++---------
>  drivers/dma-buf/dma-heap.c              | 42 ++++++++++++++++++++++++++++++---
>  drivers/dma-buf/heaps/system_heap.c     |  2 --
>  include/uapi/linux/dma-heap.h           |  6 +++++
>  5 files changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 8bdbc2e866430..824d269531eb1 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1636,8 +1636,9 @@ The following nested keys are defined.
>  		structures.
>  
>  	  dmabuf (npn)
> -		Amount of memory used for exported DMA buffers allocated by the cgroup.
> -		Stays with the allocating cgroup regardless of how the buffer is shared.
> +		Amount of memory used for exported DMA buffers allocated by or on
> +		behalf of the cgroup. Stays with the allocating cgroup regardless
> +		of how the buffer is shared.
>  
>  	  workingset_refault_anon
>  		Number of refaults of previously evicted anonymous pages.
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index ce02377f48908..23fb758b78297 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
>  	 */
>  	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
>  
> -	mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
> -	mem_cgroup_put(dmabuf->memcg);
> +	if (dmabuf->memcg) {
> +		mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> +					  PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
> +		mem_cgroup_put(dmabuf->memcg);
> +	}
>  
>  	dmabuf->ops->release(dmabuf);
>  
> @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  		dmabuf->resv = resv;
>  	}
>  
> -	dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
> -	if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE,
> -				      GFP_KERNEL)) {
> -		ret = -ENOMEM;
> -		goto err_memcg;
> -	}
> -
>  	file->private_data = dmabuf;
>  	file->f_path.dentry->d_fsdata = dmabuf;
>  	dmabuf->file = file;
> @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  
>  	return dmabuf;
>  
> -err_memcg:
> -	mem_cgroup_put(dmabuf->memcg);
>  err_file:
>  	fput(file);
>  err_module:
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index ac5f8685a6494..ff6e259afcdc0 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -7,13 +7,17 @@
>   */
>  
>  #include <linux/cdev.h>
> +#include <linux/cgroup.h>
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-heap.h>
> +#include <linux/memcontrol.h>
> +#include <linux/sched/mm.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/list.h>
>  #include <linux/nospec.h>
> +#include <linux/pidfd.h>
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>  #include <linux/xarray.h>
> @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
>  		 "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
>  
>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> -				 u32 fd_flags,
> -				 u64 heap_flags)
> +				 u32 fd_flags, u64 heap_flags,
> +				 struct mem_cgroup *charge_to)
>  {
>  	struct dma_buf *dmabuf;
> +	unsigned int nr_pages;
> +	struct mem_cgroup *memcg = charge_to;
>  	int fd;
>  
>  	/*
> @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>  	if (IS_ERR(dmabuf))
>  		return PTR_ERR(dmabuf);
>  
> +	nr_pages = len / PAGE_SIZE;
> +
> +	if (memcg)
> +		css_get(&memcg->css);
> +	else if (mem_accounting)
> +		memcg = get_mem_cgroup_from_mm(current->mm);
> +
> +	if (memcg) {
> +		if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL)) {
> +			mem_cgroup_put(memcg);
> +			dma_buf_put(dmabuf);
> +			return -ENOMEM;
> +		}
> +		dmabuf->memcg = memcg;
> +	}
> +
>  	fd = dma_buf_fd(dmabuf, fd_flags);
>  	if (fd < 0) {
>  		dma_buf_put(dmabuf);
> @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>  {
>  	struct dma_heap_allocation_data *heap_allocation = data;
>  	struct dma_heap *heap = file->private_data;
> +	struct mem_cgroup *memcg = NULL;
> +	struct task_struct *task;
> +	unsigned int pidfd_flags;
>  	int fd;
>  
>  	if (heap_allocation->fd)
> @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>  	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
>  		return -EINVAL;
>  
> +	if (heap_allocation->charge_pid_fd) {
> +		task = pidfd_get_task(heap_allocation->charge_pid_fd, &pidfd_flags);

Will always get a thread-group leader pidfd and will fail if this is a
thread-specific pidfd. pidfd_open(1234, PIDFD_THREAD) can be used to
open a thread-specific pidfd.

> +		if (IS_ERR(task))
> +			return PTR_ERR(task);
> +
> +		memcg = get_mem_cgroup_from_mm(task->mm);
> +		put_task_struct(task);
> +	}
> +
>  	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
>  				   heap_allocation->fd_flags,
> -				   heap_allocation->heap_flags);
> +				   heap_allocation->heap_flags,
> +				   memcg);
> +	mem_cgroup_put(memcg);
>  	if (fd < 0)
>  		return fd;
>  
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 03c2b87cb1112..95d7688167b93 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigned long size,
>  		if (max_order < orders[i])
>  			continue;
>  		flags = order_flags[i];
> -		if (mem_accounting)
> -			flags |= __GFP_ACCOUNT;
>  		page = alloc_pages(flags, orders[i]);
>  		if (!page)
>  			continue;
> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
> index a4cf716a49fa6..e02b0f8cbc6a1 100644
> --- a/include/uapi/linux/dma-heap.h
> +++ b/include/uapi/linux/dma-heap.h
> @@ -29,6 +29,10 @@
>   *			handle to the allocated dma-buf
>   * @fd_flags:		file descriptor flags used when allocating
>   * @heap_flags:		flags passed to heap
> + * @charge_pid_fd:	optional pidfd of the process whose cgroup should be
> + *			charged for this allocation; 0 means charge the calling
> + *			process's cgroup
> + * @__padding:		reserved, must be zero
>   *
>   * Provided by userspace as an argument to the ioctl
>   */
> @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
>  	__u32 fd;
>  	__u32 fd_flags;
>  	__u64 heap_flags;
> +	__u32 charge_pid_fd;
> +	__u32 __padding;
>  };
>  
>  #define DMA_HEAP_IOC_MAGIC		'H'
> 
> -- 
> 2.53.0
> 

