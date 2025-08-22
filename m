Return-Path: <cgroups+bounces-9332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49FB321A8
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 19:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B996A00232
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B44927F732;
	Fri, 22 Aug 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGUs2K5G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B47918991E;
	Fri, 22 Aug 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884732; cv=none; b=n5JnBfzEli7vQqJTpdzauH/SFwCDWBAOkaRWXLR0c+j63tdFlJT9zv3vnawRPVMLZF1yvuA14wZUY1DnzbNNfuUQuxsVsdkPEDtGO+iAUowLSp+m47ALixEGvwtBzZgGeYobMzILcfw/2q7BZ9sg8Nutms7VaxdQm4C205gGte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884732; c=relaxed/simple;
	bh=2eHYpYgnRCw8iV3BbmM3JNNYiUhxphMW7B6RjWxwnM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJAB01QMHCJzsghtj9WOSx/hJ2hzAz9/zDbVWH4+wdXFm9w6Bm7Wp+V9JJXjSm13Rtk8lZpN511rRuPm/AQoZzpMoxqPktKdYCAiTslKNiYjE83nXl3HAl5zvqHqCpQK6bkgLCQVaAs8NnBknIAsZ+JmX6JC9oUd0bcYT0zsNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGUs2K5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0983BC4CEED;
	Fri, 22 Aug 2025 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755884732;
	bh=2eHYpYgnRCw8iV3BbmM3JNNYiUhxphMW7B6RjWxwnM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGUs2K5G/YF0rNqGKqHleGBu93TFnOQOrs3gbV/WpwfTj3+teaAUJRxEwdofjl8h2
	 hRvKStNS9kJamqBPoxorZbtBe0AQaOJWoY+id4t/+ckxZ9cuboGTCXPLILB5G++8HL
	 w2weXPjHLNAOc9y3kDVYdkqQG/exbv2rGfN9nF5Pzx1HXMzYlMwajE5PaElG0MYtwf
	 NwOwKXqhVN4tQ02jttflUDcNri0InaG0C5+D6gOGMKJj3KmPwVbJwnkXDYRUghsmNQ
	 NPck804esG0W79ZvJW1IHApDVOAVRzVp1vj9wlCfpc/r4ZkeIQ8HkadTQCMF1NNOKT
	 hqk3eNqhFxfxA==
Date: Fri, 22 Aug 2025 07:45:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, hdanton@sina.com,
	gaoyingjie@uniontech.com
Subject: Re: [PATCH v6] cgroup: split cgroup_destroy_wq into 3 workqueues
Message-ID: <aKisu29TdvbeEPdY@slm.duckdns.org>
References: <aKNeF68tmjLKB6dK@slm.duckdns.org>
 <20250819010724.1338654-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819010724.1338654-1-chenridong@huaweicloud.com>

On Tue, Aug 19, 2025 at 01:07:24AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A hung task can occur during [1] LTP cgroup testing when repeatedly
> mounting/unmounting perf_event and net_prio controllers with
> systemd.unified_cgroup_hierarchy=1. The hang manifests in
> cgroup_lock_and_drain_offline() during root destruction.
> 
> Related case:
> cgroup_fj_function_perf_event cgroup_fj_function.sh perf_event
> cgroup_fj_function_net_prio cgroup_fj_function.sh net_prio
> 
> Call Trace:
> 	cgroup_lock_and_drain_offline+0x14c/0x1e8
> 	cgroup_destroy_root+0x3c/0x2c0
> 	css_free_rwork_fn+0x248/0x338
> 	process_one_work+0x16c/0x3b8
> 	worker_thread+0x22c/0x3b0
> 	kthread+0xec/0x100
> 	ret_from_fork+0x10/0x20
> 
> Root Cause:
> 
> CPU0                            CPU1
> mount perf_event                umount net_prio
> cgroup1_get_tree                cgroup_kill_sb
> rebind_subsystems               // root destruction enqueues
> 				// cgroup_destroy_wq
> // kill all perf_event css
>                                 // one perf_event css A is dying
>                                 // css A offline enqueues cgroup_destroy_wq
>                                 // root destruction will be executed first
>                                 css_free_rwork_fn
>                                 cgroup_destroy_root
>                                 cgroup_lock_and_drain_offline
>                                 // some perf descendants are dying
>                                 // cgroup_destroy_wq max_active = 1
>                                 // waiting for css A to die
> 
> Problem scenario:
> 1. CPU0 mounts perf_event (rebind_subsystems)
> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
> 3. A dying perf_event CSS gets queued for offline after root destruction
> 4. Root destruction waits for offline completion, but offline work is
>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
> 
> Solution:
> Split cgroup_destroy_wq into three dedicated workqueues:
> cgroup_offline_wq – Handles CSS offline operations
> cgroup_release_wq – Manages resource release
> cgroup_free_wq – Performs final memory deallocation
> 
> This separation eliminates blocking in the CSS free path while waiting for
> offline operations to complete.
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/runtest/controllers
> Fixes: 334c3679ec4b ("cgroup: reimplement rebind_subsystems() using cgroup_apply_control() and friends")
> Reported-by: Gao Yingjie <gaoyingjie@uniontech.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Suggested-by: Teju Heo <tj@kernel.org>

Applied to cgroup/for-6.17-fixes. Sorry about the delay. I missed the
thread.

Thanks.

-- 
tejun

