Return-Path: <cgroups+bounces-6070-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56AA06549
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 20:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFE418847E3
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DD20127E;
	Wed,  8 Jan 2025 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oihp6WnK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB8201113;
	Wed,  8 Jan 2025 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364231; cv=none; b=TkbmuqU5liPljvhT+arp8EeFMQo6YohEdv4An7ld3FAGNvNJd6pAE2xkK4yih8/10N3e2weyrrQKFyxvdwWVQdiRQglP7/ZbdovsSI1Uz/+Z0zxvoMuqbLbl8uk2/R2lIfS8y2KnuX662cJOMoDCjZfN/oc4VmDIuSFcqYi8yco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364231; c=relaxed/simple;
	bh=v5jKHuMrXx4zBTAdalyQZw8NWZ42GBxQdXEZtMIamTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq9VzsUeIMvAlbt9thhtVw/98YoURW4hjEdPumtrzfF/ge8rkUyFllH8Jm2vhvhfFQv12OuwtjIFjYSnL3ri135QOCFeEL4P5B1/a8ep+viUBB/18kvGZsjvcfMvo6L2UUCuWSG7mmFzqa5eblwbZEputcCJYw+RwRRBR/0IPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oihp6WnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60AEC4CED3;
	Wed,  8 Jan 2025 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364230;
	bh=v5jKHuMrXx4zBTAdalyQZw8NWZ42GBxQdXEZtMIamTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oihp6WnKrJYUN7WuuzGUo+gNS2b3gUKLrLFihJH7huOdVAyVjPNpfSj7Zix0av+eL
	 3p661CtP3J6GfOkzbgZqXxeB/Qds6+Synd+nypNZMvc6LPjr+sYgHTFSqMG3YSDzNo
	 dND6rtCsKaS/KbSKUmjPhdtWg/LYw7xtiXtaL68lIjc+IpnipSSVPZN13lGKKJYqo8
	 7hFZ5iF/ZMpkbaEqbNX5MaAZtczCANujD1GpB1EOSFuYq6ffk9OWM9bNkGY7PZX9i1
	 I+xuQjSCK/QOfu6LKUu/et1LYyOc0D/XhLy6K5eyuJUUVf+a6UbgJUQ+7mopPah7gp
	 r4fO+idE+mFlw==
Date: Wed, 8 Jan 2025 09:23:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
Message-ID: <Z37Qxd79eLqzYpZU@slm.duckdns.org>
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106081904.721655-1-chenridong@huaweicloud.com>

On Mon, Jan 06, 2025 at 08:19:04AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A warning was found:
> 
> WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
> CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
> RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
> RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
> RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
> RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
> R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
> R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  kernfs_drain+0x15e/0x2f0
>  __kernfs_remove+0x165/0x300
>  kernfs_remove_by_name_ns+0x7b/0xc0
>  cgroup_rm_file+0x154/0x1c0
>  cgroup_addrm_files+0x1c2/0x1f0
>  css_clear_dir+0x77/0x110
>  kill_css+0x4c/0x1b0
>  cgroup_destroy_locked+0x194/0x380
>  cgroup_rmdir+0x2a/0x140
> 
> It can be explained by:
> rmdir 				echo 1 > cpuset.cpus
> 				kernfs_fop_write_iter // active=0
> cgroup_rm_file
> kernfs_remove_by_name_ns	kernfs_get_active // active=1
> __kernfs_remove					  // active=0x80000002
> kernfs_drain			cpuset_write_resmask
> wait_event
> //waiting (active == 0x80000001)
> 				kernfs_break_active_protection
> 				// active = 0x80000001
> // continue
> 				kernfs_unbreak_active_protection
> 				// active = 0x80000002
> ...
> kernfs_should_drain_open_files
> // warning occurs
> 				kernfs_put_active
> 
> This warning is caused by 'kernfs_break_active_protection' when it is
> writing to cpuset.cpus, and the cgroup is removed concurrently.
> 
> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, This change
> involves calling flush_work(), which can create a multiple processes
> circular locking dependency that involve cgroup_mutex, potentially leading
> to a deadlock. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset: break
> kernfs active protection in cpuset_write_resmask()") added
> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
> lead to this warning.
> 
> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
> processing synchronous"), the cpuset_write_resmask no longer needs to
> wait the hotplug to finish, which means that concurrent hotplug and cpuset
> operations are no longer possible. Therefore, the deadlock doesn't exist
> anymore and it does not have to 'break active protection' now. To fix this
> warning, just remove kernfs_break_active_protection operation in the
> 'cpuset_write_resmask'.
> 
> Fixes: 76bb5ab8f6e3 ("cpuset: break kernfs active protection in cpuset_write_resmask()")
> Reported-by: Ji Fa <jifa@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.13-fixes.

Thanks.

-- 
tejun

