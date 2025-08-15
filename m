Return-Path: <cgroups+bounces-9203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3AB27953
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52871CC2713
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8420292B58;
	Fri, 15 Aug 2025 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNcUwka5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FD42AA1;
	Fri, 15 Aug 2025 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240192; cv=none; b=HV/QpMIazpKTG9ISQpV7vj/y9arqnQ8dxnlgvLw4IVTR/jC+bIkY/Hs3vpAL8UrcjfvZ1zmnbem3wuGogHdkLG0rDFrSB1zdiTWEhRL3zObziuf4itmqCPd/Q+Jvbpa8KXhFuV4ODRYenm2CfJ96RHfPhCMCgyOkQAXwnA0Mw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240192; c=relaxed/simple;
	bh=US5mNRFodQxM6js0+PIlarxhmEF/94ylWPwzlBlT8bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6CYf3mIAS5Ro7XG6/Vgr1xza429JFoaTlhHczp9IfyDNbx7GLY4ldkPVxPPG1NVDd3ke6v98mBVexj6rLYa3GH9zaiGOKkgp1JHBLGkUQJoXYcTTHZhlicBb9a/lhBsEaFRHpFcNeIudki8r4n6ZMdvm67ukv2ghl2fVb2IXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNcUwka5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0FDC4CEEB;
	Fri, 15 Aug 2025 06:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755240192;
	bh=US5mNRFodQxM6js0+PIlarxhmEF/94ylWPwzlBlT8bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNcUwka5bBTfI3KJITQ1x36BSIyPTwbwicw2aIitaFia/bwlpWIpoNTqpFFjZO5V7
	 Ri6lKpUl6Jm/9kuxbeGqTYbsepjA/r1/vco3O3BNN+/8igUuxpW2g7JZ88qGt7uuK2
	 e8datUMYmKbzrFQUTWv4T2XEM8IVcC3PD8JF4dp8=
Date: Fri, 15 Aug 2025 08:43:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
Message-ID: <2025081558-patriot-goes-4559@gregkh>
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
 <2025081526-skeptic-cough-7fda@gregkh>
 <5bdcd25c-3d4d-4541-99c7-5f6b0f3cb891@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdcd25c-3d4d-4541-99c7-5f6b0f3cb891@huaweicloud.com>

On Fri, Aug 15, 2025 at 02:22:54PM +0800, Chen Ridong wrote:
> 
> 
> On 2025/8/15 14:11, Greg KH wrote:
> > On Fri, Aug 15, 2025 at 01:34:29AM +0000, Chen Ridong wrote:
> >> From: Chen Ridong <chenridong@huawei.com>
> >>
> >> A use-after-free (UAF) vulnerability was identified in the PSI (Pressure
> >> Stall Information) monitoring mechanism:
> >>
> >> BUG: KASAN: slab-use-after-free in psi_trigger_poll+0x3c/0x140
> >> Read of size 8 at addr ffff3de3d50bd308 by task systemd/1
> >>
> >> psi_trigger_poll+0x3c/0x140
> >> cgroup_pressure_poll+0x70/0xa0
> >> cgroup_file_poll+0x8c/0x100
> >> kernfs_fop_poll+0x11c/0x1c0
> >> ep_item_poll.isra.0+0x188/0x2c0
> >>
> >> Allocated by task 1:
> >> cgroup_file_open+0x88/0x388
> >> kernfs_fop_open+0x73c/0xaf0
> >> do_dentry_open+0x5fc/0x1200
> >> vfs_open+0xa0/0x3f0
> >> do_open+0x7e8/0xd08
> >> path_openat+0x2fc/0x6b0
> >> do_filp_open+0x174/0x368
> >>
> >> Freed by task 8462:
> >> cgroup_file_release+0x130/0x1f8
> >> kernfs_drain_open_files+0x17c/0x440
> >> kernfs_drain+0x2dc/0x360
> >> kernfs_show+0x1b8/0x288
> >> cgroup_file_show+0x150/0x268
> >> cgroup_pressure_write+0x1dc/0x340
> >> cgroup_file_write+0x274/0x548
> >>
> >> Reproduction Steps:
> >> 1. Open test/cpu.pressure and establish epoll monitoring
> >> 2. Disable monitoring: echo 0 > test/cgroup.pressure
> >> 3. Re-enable monitoring: echo 1 > test/cgroup.pressure
> >>
> >> The race condition occurs because:
> >> 1. When cgroup.pressure is disabled (echo 0 > cgroup.pressure), it:
> >>    - Releases PSI triggers via cgroup_file_release()
> >>    - Frees of->priv through kernfs_drain_open_files()
> >> 2. While epoll still holds reference to the file and continues polling
> >> 3. Re-enabling (echo 1 > cgroup.pressure) accesses freed of->priv
> >>
> >> epolling			disable/enable cgroup.pressure
> >> fd=open(cpu.pressure)
> >> while(1)
> >> ...
> >> epoll_wait
> >> kernfs_fop_poll
> >> kernfs_get_active = true	echo 0 > cgroup.pressure
> >> ...				cgroup_file_show
> >> 				kernfs_show
> >> 				// inactive kn
> >> 				kernfs_drain_open_files
> >> 				cft->release(of);
> >> 				kfree(ctx);
> >> 				...
> >> kernfs_get_active = false
> >> 				echo 1 > cgroup.pressure
> >> 				kernfs_show
> >> 				kernfs_activate_one(kn);
> >> kernfs_fop_poll
> >> kernfs_get_active = true
> >> cgroup_file_poll
> >> psi_trigger_poll
> >> // UAF
> >> ...
> >> end: close(fd)
> >>
> >> Fix this by adding released flag check in kernfs_fop_poll(), which is
> >> treated as kn is inactive.
> >>
> >> Fixes: 34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface")
> >> Reported-by: Zhang Zhantian <zhangzhaotian@huawei.com>
> >> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >> ---
> >>  fs/kernfs/file.c       | 2 +-
> >>  kernel/cgroup/cgroup.c | 1 +
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> >> index a6c692cac616..d5d01f0b9392 100644
> >> --- a/fs/kernfs/file.c
> >> +++ b/fs/kernfs/file.c
> >> @@ -852,7 +852,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
> >>  	struct kernfs_node *kn = kernfs_dentry_node(filp->f_path.dentry);
> >>  	__poll_t ret;
> >>  
> >> -	if (!kernfs_get_active(kn))
> >> +	if (of->released || !kernfs_get_active(kn))
> > 
> > I can see why the cgroup change is needed, but why is this test for
> > released() an issue here?  This feels like two different changes/fixes
> > for different problems?  Why does testing for released matter at this
> > point in time?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Thank you for your feedback.
> 
> The cgroup changes can prevent the UAF (Use-After-Free) issue, but they will introduce a NULL
> pointer access problem.

Where will the null pointer access happen?  kernfs_fop_poll() isn't
caring about the released file, AND you need to properly lock things
when testing that value (hint, what if it changes right after you tested
it?)

> If the open file is properly drained(released), it can not safely invoke the poll callback again.
> Otherwise, it may still lead to either UAF or NULL pointer issues
> 
> Are you suggesting I should split this into two separate patches?

This feels like two separate issues for two different things.  The PSI
change didn't cause the kernfs change to be required right?

thanks,

greg k-h

