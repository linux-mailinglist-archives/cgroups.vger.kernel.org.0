Return-Path: <cgroups+bounces-9201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB5B278E1
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 08:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310B35E444D
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 06:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152026E140;
	Fri, 15 Aug 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbUCyNDp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9225522B;
	Fri, 15 Aug 2025 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238308; cv=none; b=TtFTOmzPER8gZ6fare6C+l85XNEFdjUMioUQKSMHAtOtH+1lIGu5ebXs6nfWcEK2QdqcSllvym2HPMvyy0igX6PGHT2SWtbwi1h3KxEcxPX1KsW8PJIm97MHREp7KSy2RqhAL9e9jEfjlho+dwfoJZxTqoeLNH9wGSW7U75/Woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238308; c=relaxed/simple;
	bh=i8+3u/XfWuewCmAXGYicw7iVwQlPc2yBpJ4wclvrywU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/5hS0GzIcfMLOd2oS5ZZhjZ+VbhqeezCqqwhx0cKUbfdzoBk2ZempUCvxfnccsSihk0Yk5tv4urt8lqAhry1AC4jDunD492KilVSeUUw3ufgsRodxXICC5vDOQuIE7g+VPW6hZhPpkdkdHt2uWM6jcXHJLsULYsWykYbcTEpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbUCyNDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9A6C4CEEB;
	Fri, 15 Aug 2025 06:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755238308;
	bh=i8+3u/XfWuewCmAXGYicw7iVwQlPc2yBpJ4wclvrywU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbUCyNDpdtR8AQkrqGCsB4JXD2lmolYNg1YWXThj7C9cYbWMsP7UXfJT8+5NqzU0L
	 Qws2jp9ANbdbiPbyGvJ/qTUJNpEh7Ze9qa/GvNdnfrAMjT3ujFJoi++fa+mvo3qTR3
	 YyVb1mxuOg30JPOubXn6mr6zIPW8/DcDvYyD0JHc=
Date: Fri, 15 Aug 2025 08:11:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
Message-ID: <2025081526-skeptic-cough-7fda@gregkh>
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815013429.1255241-1-chenridong@huaweicloud.com>

On Fri, Aug 15, 2025 at 01:34:29AM +0000, Chen Ridong wrote:
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
> Fix this by adding released flag check in kernfs_fop_poll(), which is
> treated as kn is inactive.
> 
> Fixes: 34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface")
> Reported-by: Zhang Zhantian <zhangzhaotian@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  fs/kernfs/file.c       | 2 +-
>  kernel/cgroup/cgroup.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index a6c692cac616..d5d01f0b9392 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -852,7 +852,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
>  	struct kernfs_node *kn = kernfs_dentry_node(filp->f_path.dentry);
>  	__poll_t ret;
>  
> -	if (!kernfs_get_active(kn))
> +	if (of->released || !kernfs_get_active(kn))

I can see why the cgroup change is needed, but why is this test for
released() an issue here?  This feels like two different changes/fixes
for different problems?  Why does testing for released matter at this
point in time?

thanks,

greg k-h

