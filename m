Return-Path: <cgroups+bounces-8464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47292AD254E
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 20:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CEC1890F4D
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACDD21A443;
	Mon,  9 Jun 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz7KIscY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9C74C14;
	Mon,  9 Jun 2025 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492353; cv=none; b=dU0k0WZj0mxlqRHCgnogDkg5Dsf6uwRAe/33xIj68wpro/MYoNucIvWMySYJCL7fhpnJX+hF15onYgwtxs4qbNDDsdrcMFXnMPEIuQR4EkFXyWpiuFvYhluAfIEYJ9l0GgE86R29Z0DoI3yu728cNrRa8I5WDlAi5Wf0KJud4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492353; c=relaxed/simple;
	bh=6RQ6jbjvg8dHr6Ls6CSjBRueq9yvVGm8MRlRUyIDPMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy4au4fKnZTkBR0sTm0yuRFDW1M9FuNQ0S2h+JGQ63Unr2NPiHGZjrb7kZSqz0I0vEljuvNRge/Eu086FZRP9EzXGYIciUqKUx7Tp6JkbpJgtJxnVcSKvvRN2RmMHCER3bUXCYIFlJVA0ih8ajlijIfZolL1IKxEWOwOIp8Z9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz7KIscY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358F8C4CEEB;
	Mon,  9 Jun 2025 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749492352;
	bh=6RQ6jbjvg8dHr6Ls6CSjBRueq9yvVGm8MRlRUyIDPMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oz7KIscYiBzBq3Fscdr5H95rVV7+ARwjUObDyem48cqrT0uw9ce/OpOATe87OF6Y7
	 00DjBC/teHzn4dvItravGSsen++9BbcHy7FRm7ybMWElQWJuL9yi4pILlZBwWowkRd
	 e3+extvKJeKhPE+tXWjTMnNYJxV0u22CUBXmHFuikJ0y5A/9wTW6hI1RK7uEq5cuYD
	 WQd1Whm1ko2SVMxidi9kW7t6nksBwtgtqm48/hdCH68khRlKP+HA+gCuyRLEZG3dOu
	 g3SDON5ZPC6gC5ow+pwiucA6uC2OC3foiX4EHzFtI9T2mRuqRrE2Pai21eYB4/7zO2
	 UJ8FFLg+YxYvA==
Date: Mon, 9 Jun 2025 08:05:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	bagasdotme@gmail.com, llong@redhat.com
Subject: Re: [PATCH v3] Documentation: cgroup: add section explaining
 controller availability
Message-ID: <aEcif8PgY3GAbBWI@slm.duckdns.org>
References: <20250606041004.12753-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250606041004.12753-2-vishalc@linux.ibm.com>

On Fri, Jun 06, 2025 at 09:40:05AM +0530, Vishal Chourasia wrote:
> Add "Availability" section to Control Group v2 docs. It describes the
> meaning of a controller being available in a cgroup, complementing the
> existing "Enabling and Disabling" section.
> 
> This update improves the clarity of cgroup controller management by
> explicitly distinguishing between:
> 
> 1. Availability – when a controller is supported by the kernel and
>    listed in "cgroup.controllers", making its interface files accessible
>    in the cgroup's directory.
> 2. Enabling – when a controller is enabled via explicitly writing the
>    name of the controller to "cgroup.subtree_control" to control
>    distribution of resource across the cgroup's immediate children.
> 
> As an example, consider
> 
> /sys/fs/cgroup # cat cgroup.controllers
> cpuset cpu io memory hugetlb pids misc
> /sys/fs/cgroup # cat cgroup.subtree_control # No controllers enabled by default
> /sys/fs/cgroup # echo +cpu +memory > cgroup.subtree_control # enabling "cpu" and "memory"
> /sys/fs/cgroup # cat cgroup.subtree_control
> cpu memory                   # cpu and memory enabled in /sys/fs/cgroup
> /sys/fs/cgroup # mkdir foo_cgrp
> /sys/fs/cgroup # cd foo_cgrp/
> /sys/fs/cgroup/foo_cgrp # cat cgroup.controllers
> cpu memory                   # cpu and memory available in 'foo_cgrp'
> /sys/fs/cgroup/foo_cgrp # cat cgroup.subtree_control  # empty by default
> /sys/fs/cgroup/foo_cgrp # ls
> cgroup.controllers      cpu.max.burst           memory.numa_stat
> cgroup.events           cpu.pressure            memory.oom.group
> cgroup.freeze           cpu.stat                memory.peak
> cgroup.kill             cpu.stat.local          memory.pressure
> cgroup.max.depth        cpu.weight              memory.reclaim
> cgroup.max.descendants  cpu.weight.nice         memory.stat
> cgroup.pressure         io.pressure             memory.swap.current
> cgroup.procs            memory.current          memory.swap.events
> cgroup.stat             memory.events           memory.swap.high
> cgroup.subtree_control  memory.events.local     memory.swap.max
> cgroup.threads          memory.high             memory.swap.peak
> cgroup.type             memory.low              memory.zswap.current
> cpu.idle                memory.max              memory.zswap.max
> cpu.max                 memory.min              memory.zswap.writeback
> 
> In this example, "cpu" and "memory" are enabled in the root cgroup,
> making them available in "foo_cgrp". This exposes the corresponding
> interface files in "foo_cgrp/", allowing resource control of processes
> in that cgroup. However, these controllers are not yet enabled in
> "foo_cgrp" itself.
> 
> Once a controller is available in a cgroup it can be used to resource
> control processes of the cgroup.
> 
> Acked-by: Michal Koutný <mkoutny@suse.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Applied to cgroup/for-6.17.

Thanks.

-- 
tejun

