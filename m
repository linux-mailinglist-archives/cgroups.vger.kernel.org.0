Return-Path: <cgroups+bounces-9333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D077B321AB
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AC51BA4188
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E22231832;
	Fri, 22 Aug 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvVtEAdh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BF16D9C2;
	Fri, 22 Aug 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884808; cv=none; b=PcX9ws3Akxf6jdrOhbBPERvazpt3yrVjWqNaALz3Y/MGrJtvfBNd0FFGSqGmFuA0p9Y3u5Yf7Fjxzq+ffPUK+LiaJdjnMbC4neo2dsklRgAMVyCS0GusXLuynr4YPAE2cPDoc4POQO18qAyukn4phL+HfoQApmCCdsLWGZErBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884808; c=relaxed/simple;
	bh=KvZRy2P3nHB0m6zkSQwvKF6o/deGdYpSsXtGKxpO0Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzaqaHB7AFfhKXzmdn57UxRr29UDRu2TBHMkIwVKQC9jiIcLN9xuEhR4cY2yrp7qnmfkoMIpYS1aOf1QUyYykABJKefPNCtjbBIfKdgJYcfmZE0YfWHKdpTZOdOePufbG6fFWWj6xDJILIVcl3OgPK9OwY1Mj5vGBhD9SO8oOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvVtEAdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C84C4CEED;
	Fri, 22 Aug 2025 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755884806;
	bh=KvZRy2P3nHB0m6zkSQwvKF6o/deGdYpSsXtGKxpO0Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvVtEAdhXp4vgWEhDSztXH3fEzuVpr8fTNyUWSto5K2OvEkFSFE+GVETv0rz9KKfP
	 o2mebAzvacRZkk/qK2AQXCuxSeOkI12sNESMhrsk6Flz7URoRnFMF309oGsZZgsm9+
	 PK/klG1jV60NT0ydmHSYTUD1gqW6RWcKAgHj+KYx7Gipe2rTJreGPxaNyTZcKwOFS+
	 vvkcH/yFHlGkfD3QZb6lTJIQnOfOUOI8EUAWq2ZeWCp9kuMmye3lQ1rYaw1AH+FCwF
	 e/PlazL8cEefUhBse3ADU5KNT5pOvd8iBKDh4iPgT2zrjkh/43XX0GeHwjoWL2Ekx8
	 tBRmy7nRdKSOw==
Date: Fri, 22 Aug 2025 07:46:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: gregkh@linuxfoundation.org, hannes@cmpxchg.org, mkoutny@suse.com,
	peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 1/2] kernfs: Fix UAF in polling when open file is
 released
Message-ID: <aKitBb4VNmeaObi8@slm.duckdns.org>
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

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

