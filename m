Return-Path: <cgroups+bounces-9220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2BDB2854D
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 19:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06407BBFF9
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128731770C;
	Fri, 15 Aug 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYYLqtn8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84B3176E1;
	Fri, 15 Aug 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279881; cv=none; b=AeQL8aIrbPL7wI/CBX3cm979pu/j+RxFjVSiAGv78+LrWeQPjI6jy6NDQUC1BnAjJMtSEQ8RWY0UsDffoqr6D3Aqors/i9YpMRJcaf0ErSBehrNvyxuZPo7ODa1eKzrUR2Ph8kzFCF/dhg8B6zFyiC4lzE2zJ6QskMDZmZ/pdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279881; c=relaxed/simple;
	bh=we/QScQ7I7+PlC5lGeWKArOIu6DFge1Eo5D2lzXYZlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdrbJdpqTSoHoq2S6KOkFbzOY5MPxQ0xGcWQ0sBdmj044TTeUS41IYC3K4MwygrvETrQZJLK57bDXm8zbCp90lYtou6rCaa1J9wC1FCoE9Te+HmrpBPQ2b/gDyXBpzlAW/CLcSwKplHDkBq4NGd8KCUX1JMRz3J1oRcDL4wna4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYYLqtn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51847C4CEEB;
	Fri, 15 Aug 2025 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755279880;
	bh=we/QScQ7I7+PlC5lGeWKArOIu6DFge1Eo5D2lzXYZlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYYLqtn8G2Yi1vhi9THC4I0jh+nOqh8cE+GqF8j5XFYhalvcFh8q5yQz2yhbSH0wO
	 pXhOqfr/vCwb1U6DUr8UG0jqxEMOCUASgfFssRzTZsV9g8BOXskcOOpqxMTWQin5Qr
	 D11d+p9Ur06LZqnwMyVFosrR/bgT0m+X5V8okzlFgRC/lWZSc1s3U5autdfEbGc3cC
	 SGu7I3t/3y3BNlKn4vd9DPWUND69lLKRs6+qGAC8M2cl+X77JwbbyzTyvkyrGXxET1
	 YlXD4GWf9k83PwqZRsDL4iXBMBScrEwc/3AgU1IshH4z28jaEi6hnF/KmaNTC7Du2l
	 j9JAFlRiJzMKg==
Date: Fri, 15 Aug 2025 07:44:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, hdanton@sina.com
Subject: Re: [PATCH v3] cgroup: cgroup: drain specific subsystems when
 mounting/destroying a root
Message-ID: <aJ9yBuDnUu2jIgYT@slm.duckdns.org>
References: <20250815070518.1255842-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815070518.1255842-1-chenridong@huaweicloud.com>

Hello, Chen.

On Fri, Aug 15, 2025 at 07:05:18AM +0000, Chen Ridong wrote:
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

Thanks for the analysis, so this is caused by css free path waiting for css
offline.

> Solution:
> Introduce ss_mask for cgroup_lock_and_drain_offline() to selectively drain
> specific subsystems rather than all subsystems.
> 
> There are two primary scenarios requiring offline draining:
> 1. Root Operations - Draining all subsystems in cgrp_dfl_root when mounting
>    or destroying a cgroup root
> 2. Draining specific cgroup when modifying cgroup.subtree_control or
>    cgroup.threads
> 
> For case 1 (Root Operations), it only need to drain the specific subsystem
> being mounted/destroyed, not all subsystems. The rationale for draining
> cgrp_dfl_root is explained in [2].
> 
> For case 2, it's enough to drain subsystems enabled in the cgroup. Since
> other subsystems cannot have descendants in this cgroup, adding ss_mask
> should not have a hurt.

Hmm... this seems a bit fragile. Would splitting cgroup_destroy_wq into two
separate workqueues - e.g. cgroup_offline_wq and cgroup_free_wq - work?

Thanks.

-- 
tejun

