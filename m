Return-Path: <cgroups+bounces-9328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9ECB310CA
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C33B58A9
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E222E2F17;
	Fri, 22 Aug 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znHAXYrz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FF20F07C;
	Fri, 22 Aug 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848868; cv=none; b=C5zNmB5MiZr4uj4CborRz2pf+fZvXea4l9a59myCzCrlAaavQPW+nFn+pJ//+qecqkDbpuItzZwHJDQMkX2l563WDEgJ7ILx266NEfTfwGWskxB6WkPBLM+N4RlrCWqEBEISYQu/l8+sWU/4DsHeV2/IdzkGEECPG3gto1tQynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848868; c=relaxed/simple;
	bh=JQRHNGXGE15h4CtDTzFuXvblcg2Pxw5IsIJuTR/ck6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7SVrwDmhAT2Nok5Eo2CU/HYZXKy112tRefJCdblqhl09wXXksx3xM/id9aGPNcwtPB8tYs619NJKWNcdjUUjBljRCCr1L4zx7xyeV4NqQyeaiV+ssFhNmKvXM1i+ZjDfOE2/pHB3XadJqu6jKKnPTlmYwD0cQ/sYI9LWzlrs7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znHAXYrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DC9C4CEF1;
	Fri, 22 Aug 2025 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755848867;
	bh=JQRHNGXGE15h4CtDTzFuXvblcg2Pxw5IsIJuTR/ck6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=znHAXYrzAONXlCfcB8ExcujOjtfOxaqp4EhZufXclpnRMmhrBwYcVrj5O3R3pxAG/
	 9xe0wPUUIs/0FQwfh6ztt+d1aY78M6r4bmgkoJ0ogZUSpI6kYZF0fdwb8OxxU1E3Rn
	 7YMPHn3skh5FChAwMKyBzGhryS315Vzj9K0HUhv0=
Date: Fri, 22 Aug 2025 09:47:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 1/2] kernfs: Fix UAF in polling when open file is
 released
Message-ID: <2025082233-rekindle-juggle-5c0a@gregkh>
References: <20250822070715.1565236-1-chenridong@huaweicloud.com>
 <20250822070715.1565236-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822070715.1565236-2-chenridong@huaweicloud.com>

On Fri, Aug 22, 2025 at 07:07:14AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A use-after-free (UAF) vulnerability was identified in the PSI (Pressure
> Stall Information) monitoring mechanism:
> 
> BUG: KASAN: slab-use-after-free in psi_trigger_poll+0x3c/0x140
> Read of size 8 at addr ffff3de3d50bd308 by task systemd/1
> 
> psi_trigger_poll+0x3c/0x140
> cgroup_pressure_poll+0x70/0xa0
> cgroup_file_poll+0x8c/0x100
> kernfs_fop_poll+0x11c/0x1c0
> ep_item_poll.isra.0+0x188/0x2c0
> 
> Allocated by task 1:
> cgroup_file_open+0x88/0x388
> kernfs_fop_open+0x73c/0xaf0
> do_dentry_open+0x5fc/0x1200
> vfs_open+0xa0/0x3f0
> do_open+0x7e8/0xd08
> path_openat+0x2fc/0x6b0
> do_filp_open+0x174/0x368
> 
> Freed by task 8462:
> cgroup_file_release+0x130/0x1f8
> kernfs_drain_open_files+0x17c/0x440
> kernfs_drain+0x2dc/0x360
> kernfs_show+0x1b8/0x288
> cgroup_file_show+0x150/0x268
> cgroup_pressure_write+0x1dc/0x340
> cgroup_file_write+0x274/0x548
> 
> Reproduction Steps:
> 1. Open test/cpu.pressure and establish epoll monitoring
> 2. Disable monitoring: echo 0 > test/cgroup.pressure
> 3. Re-enable monitoring: echo 1 > test/cgroup.pressure
> 
> The race condition occurs because:
> 1. When cgroup.pressure is disabled (echo 0 > cgroup.pressure), it:
>    - Releases PSI triggers via cgroup_file_release()
>    - Frees of->priv through kernfs_drain_open_files()
> 2. While epoll still holds reference to the file and continues polling
> 3. Re-enabling (echo 1 > cgroup.pressure) accesses freed of->priv
> 
> epolling			disable/enable cgroup.pressure
> fd=open(cpu.pressure)
> while(1)
> ...
> epoll_wait
> kernfs_fop_poll
> kernfs_get_active = true	echo 0 > cgroup.pressure
> ...				cgroup_file_show
> 				kernfs_show
> 				// inactive kn
> 				kernfs_drain_open_files
> 				cft->release(of);
> 				kfree(ctx);
> 				...
> kernfs_get_active = false
> 				echo 1 > cgroup.pressure
> 				kernfs_show
> 				kernfs_activate_one(kn);
> kernfs_fop_poll
> kernfs_get_active = true
> cgroup_file_poll
> psi_trigger_poll
> // UAF
> ...
> end: close(fd)
> 
> To address this issue, introduce kernfs_get_active_of() for kernfs open
> files to obtain active references. This function will fail if the open file
> has been released. Replace kernfs_get_active() with kernfs_get_active_of()
> to prevent further operations on released file descriptors.
> 
> Fixes: 34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface")
> Reported-by: Zhang Zhaotian <zhangzhaotian@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  fs/kernfs/file.c | 58 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index a6c692cac616..9adf36e6364b 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -70,6 +70,24 @@ static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
>  					 !list_empty(&of->list));
>  }
>  
> +/* Get active reference to kernfs node for an open file */
> +static struct kernfs_open_file *kernfs_get_active_of(struct kernfs_open_file *of)
> +{
> +	/* Skip if file was already released */
> +	if (unlikely(of->released))
> +		return NULL;
> +
> +	if (!kernfs_get_active(of->kn))
> +		return NULL;
> +
> +	return of;
> +}
> +
> +static void kernfs_put_active_of(struct kernfs_open_file *of)
> +{
> +	return kernfs_put_active(of->kn);
> +}
> +
>  /**
>   * kernfs_deref_open_node_locked - Get kernfs_open_node corresponding to @kn
>   *
> @@ -139,7 +157,7 @@ static void kernfs_seq_stop_active(struct seq_file *sf, void *v)
>  
>  	if (ops->seq_stop)
>  		ops->seq_stop(sf, v);
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  }
>  
>  static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
> @@ -152,7 +170,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
>  	 * the ops aren't called concurrently for the same open file.
>  	 */
>  	mutex_lock(&of->mutex);
> -	if (!kernfs_get_active(of->kn))
> +	if (!kernfs_get_active_of(of))
>  		return ERR_PTR(-ENODEV);
>  
>  	ops = kernfs_ops(of->kn);
> @@ -238,7 +256,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	 * the ops aren't called concurrently for the same open file.
>  	 */
>  	mutex_lock(&of->mutex);
> -	if (!kernfs_get_active(of->kn)) {
> +	if (!kernfs_get_active_of(of)) {
>  		len = -ENODEV;
>  		mutex_unlock(&of->mutex);
>  		goto out_free;
> @@ -252,7 +270,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	else
>  		len = -EINVAL;
>  
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  	mutex_unlock(&of->mutex);
>  
>  	if (len < 0)
> @@ -323,7 +341,7 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	 * the ops aren't called concurrently for the same open file.
>  	 */
>  	mutex_lock(&of->mutex);
> -	if (!kernfs_get_active(of->kn)) {
> +	if (!kernfs_get_active_of(of)) {
>  		mutex_unlock(&of->mutex);
>  		len = -ENODEV;
>  		goto out_free;
> @@ -335,7 +353,7 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	else
>  		len = -EINVAL;
>  
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  	mutex_unlock(&of->mutex);
>  
>  	if (len > 0)
> @@ -357,13 +375,13 @@ static void kernfs_vma_open(struct vm_area_struct *vma)
>  	if (!of->vm_ops)
>  		return;
>  
> -	if (!kernfs_get_active(of->kn))
> +	if (!kernfs_get_active_of(of))
>  		return;
>  
>  	if (of->vm_ops->open)
>  		of->vm_ops->open(vma);
>  
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  }
>  
>  static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
> @@ -375,14 +393,14 @@ static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
>  	if (!of->vm_ops)
>  		return VM_FAULT_SIGBUS;
>  
> -	if (!kernfs_get_active(of->kn))
> +	if (!kernfs_get_active_of(of))
>  		return VM_FAULT_SIGBUS;
>  
>  	ret = VM_FAULT_SIGBUS;
>  	if (of->vm_ops->fault)
>  		ret = of->vm_ops->fault(vmf);
>  
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  	return ret;
>  }
>  
> @@ -395,7 +413,7 @@ static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
>  	if (!of->vm_ops)
>  		return VM_FAULT_SIGBUS;
>  
> -	if (!kernfs_get_active(of->kn))
> +	if (!kernfs_get_active_of(of))
>  		return VM_FAULT_SIGBUS;
>  
>  	ret = 0;
> @@ -404,7 +422,7 @@ static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
>  	else
>  		file_update_time(file);
>  
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  	return ret;
>  }
>  
> @@ -418,14 +436,14 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
>  	if (!of->vm_ops)
>  		return -EINVAL;
>  
> -	if (!kernfs_get_active(of->kn))
> +	if (!kernfs_get_active_of(of))
>  		return -EINVAL;
>  
>  	ret = -EINVAL;
>  	if (of->vm_ops->access)
>  		ret = of->vm_ops->access(vma, addr, buf, len, write);
>  
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  	return ret;
>  }
>  
> @@ -455,7 +473,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  	mutex_lock(&of->mutex);
>  
>  	rc = -ENODEV;
> -	if (!kernfs_get_active(of->kn))
> +	if (!kernfs_get_active_of(of))
>  		goto out_unlock;
>  
>  	ops = kernfs_ops(of->kn);
> @@ -490,7 +508,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  	}
>  	vma->vm_ops = &kernfs_vm_ops;
>  out_put:
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  out_unlock:
>  	mutex_unlock(&of->mutex);
>  
> @@ -852,7 +870,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
>  	struct kernfs_node *kn = kernfs_dentry_node(filp->f_path.dentry);
>  	__poll_t ret;
>  
> -	if (!kernfs_get_active(kn))
> +	if (!kernfs_get_active_of(of))
>  		return DEFAULT_POLLMASK|EPOLLERR|EPOLLPRI;
>  
>  	if (kn->attr.ops->poll)
> @@ -860,7 +878,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
>  	else
>  		ret = kernfs_generic_poll(of, wait);
>  
> -	kernfs_put_active(kn);
> +	kernfs_put_active_of(of);
>  	return ret;
>  }
>  
> @@ -875,7 +893,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
>  	 * the ops aren't called concurrently for the same open file.
>  	 */
>  	mutex_lock(&of->mutex);
> -	if (!kernfs_get_active(of->kn)) {
> +	if (!kernfs_get_active_of(of)) {
>  		mutex_unlock(&of->mutex);
>  		return -ENODEV;
>  	}
> @@ -886,7 +904,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
>  	else
>  		ret = generic_file_llseek(file, offset, whence);
>  
> -	kernfs_put_active(of->kn);
> +	kernfs_put_active_of(of);
>  	mutex_unlock(&of->mutex);
>  	return ret;
>  }
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

