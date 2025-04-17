Return-Path: <cgroups+bounces-7620-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A9A92416
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA3D16A858
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974272561A2;
	Thu, 17 Apr 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDv+qvkc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEB1DE8A0;
	Thu, 17 Apr 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911211; cv=none; b=T6H4m8OGxOLNT7dRoEZj40AyqOyCHnHyFqQBzKV7HUhLxnlZIlDP+W3PuBfTchXenHuAiONF/kJHufl4kvR1U1RKXw4bnKWe+D7cRLeSPtcLZ70yHGVItdWMbFfqgXu8Musp04mo2BZWJ334SA8WmLZH6XqxGQSCdxk1RFPd/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911211; c=relaxed/simple;
	bh=z5y2ACRsRRWqWKBImnsY6fBXdHefgYjwoqoWXfflW6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M67Er392WICbrPHpAxi4Emtdmf/jIs6VcBu5hpRujJsYLQ8QvC1pFIUgELDHqQ7YyCn0rKWaOP71mB9cP23JFfJxaGBqLdVGc6fsacvnWe74iSgq47Lygjuoc10/1GqBX+XndDGopLSxG8EPB6h7+0LiNG9I4tf17AaqWt/zkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDv+qvkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE55C4CEE4;
	Thu, 17 Apr 2025 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744911210;
	bh=z5y2ACRsRRWqWKBImnsY6fBXdHefgYjwoqoWXfflW6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDv+qvkc3eDGVO31d1YKBtx7lP/vm+HHgWrxcNrSszFEvkuURckxBknoorTdkS75S
	 091I9PO/FLNB/OAbWQgvDtyAQQu5ZcO7mm1uGTTBfeediBlo8o4ttkdPQXVgqroIN2
	 qtsZydsRVvQCe6y30lYWJTr+nWpfpg9RF2LPmluobxiVsAAuVIYIqGP7NGAWpTUDwm
	 qfYaGm6ySr8MCLCIP2tOgfhUt+afeBxvZ0NeGGc+3OyFFwohzaiwQBG2Y9u45Om2Ef
	 fMj70dbev4Rlm6WHn89oZtI81B28E9qW3mrA8QxyAt3JQpvQ/sq9Vwex4t5AGjaQmy
	 3isFhhLPJfw1Q==
Date: Thu, 17 Apr 2025 07:33:29 -1000
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cgroup/cpuset-v1: Add missing support for
 cpuset_v2_mode
Message-ID: <aAE7abLJLQy_ooBA@slm.duckdns.org>
References: <20250416211752.945849-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416211752.945849-1-tjmercier@google.com>

On Wed, Apr 16, 2025 at 09:17:51PM +0000, T.J. Mercier wrote:
> Android has mounted the v1 cpuset controller using filesystem type
> "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
> behavior where the controller name is not added as a prefix for cgroupfs
> files. [2]
> 
> Later, a problem was discovered where cpu hotplug onlining did not
> affect the cpuset/cpus files, which Android carried an out-of-tree patch
> to address for a while. An attempt was made to upstream this patch, but
> the recommendation was to use the "cpuset_v2_mode" mount option
> instead. [3]
> 
> An effort was made to do so, but this fails with "cgroup: Unknown
> parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
> mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
> update the special cased cpuset_mount(), and only the cgroup (v1)
> filesystem type was updated.
> 
> Add parameter parsing to the cpuset filesystem type so that
> cpuset_v2_mode works like the cgroup filesystem type:
> 
> $ mkdir /dev/cpuset
> $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
> $ mount|grep cpuset
> none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_mode,release_agent=/sbin/cpuset_release_agent)
> 
> [1] https://cs.android.com/android/_/android/platform/system/core/+/b769c8d24fd7be96f8968aa4c80b669525b930d3
> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=2dac5d89a0f024a2d0cc46a80ba4ee13472f1681;l=192
> [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@redhat.com/T/
> 
> Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2 behavior in v1 cgroup")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> Acked-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.15-fixes.

Thanks.

-- 
tejun

