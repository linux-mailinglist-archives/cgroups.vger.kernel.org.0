Return-Path: <cgroups+bounces-12891-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76908CF130E
	for <lists+cgroups@lfdr.de>; Sun, 04 Jan 2026 19:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435BA3008E8A
	for <lists+cgroups@lfdr.de>; Sun,  4 Jan 2026 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CE285071;
	Sun,  4 Jan 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZDCFqu9L"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57911D130E;
	Sun,  4 Jan 2026 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551267; cv=none; b=KX2i79ZxilbuyhscmghtJjTGZQF6ltRfbif1Vuenj0JC1ac5DOMF49HSu6ZcpE1KATfqe+GlHVW6mrxYlenJfAZC85xggg5d+7eIm+SBtjGar3apqvKu89Dg6OAe5YXo0p8irV9b/KduzVNW0lse+3e4VckhqBolfI9s6kz+sU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551267; c=relaxed/simple;
	bh=ncBLtjyDgpOU9nUGlYr/lR60bzhWGn+9CqIvEOL0bQg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PCjIm8oBaigK9tAQq4UMWgD6fEAQww3jGD4GW41LPmWB/lTwNgNlXG2itImX5VmIg3lZWMGWw+2w43nWl+vd8ushYU8rf4x8Djvv4LeFYysrxNtjCLf0CShaPE4BCA+mwBXi3Vn9p5NoCQrZ7vU7alec0w4oAm2iffgfor81H94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZDCFqu9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE170C4CEF7;
	Sun,  4 Jan 2026 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767551266;
	bh=ncBLtjyDgpOU9nUGlYr/lR60bzhWGn+9CqIvEOL0bQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZDCFqu9LkYtIhO1nOFih2qPFuzrbgULNTICSEuJzXgTv0atk0QwQhewhTZBIhtbYq
	 OnDoQCNk+g8uOFfgdbhr72l1zUocTUsaDoS6VLSnSg/1623eFWM2W99/ikh1C8O+7X
	 M7+l3ArIO6KJeeM7Q/7qhB2IxduoGupzddf7bvq8=
Date: Sun, 4 Jan 2026 10:27:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
 longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tj@kernel.org, mkoutny@suse.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 axelrasmussen@google.com, chenridong@huaweicloud.com, yuanchu@google.com,
 weixugc@google.com, cgroups@vger.kernel.org, Akinobu Mita
 <akinobu.mita@gmail.com>
Subject: Re: [PATCH v4] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-Id: <20260104102745.cfd4f6bd661e8e817afcdba8@linux-foundation.org>
In-Reply-To: <20260104085439.4076810-1-bingjiao@google.com>
References: <20251223212032.665731-1-bingjiao@google.com>
	<20260104085439.4076810-1-bingjiao@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Jan 2026 08:54:05 +0000 Bing Jiao <bingjiao@google.com> wrote:

> Fix two bugs in demote_folio_list() and can_demote() due to incorrect
> demotion target checks in reclaim/demotion.

Thanks.

> Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> introduces the cpuset.mems_effective check and applies it to
> can_demote(). However:
> 
>   1. It does not apply this check in demote_folio_list(), which leads
>      to situations where pages are demoted to nodes that are
>      explicitly excluded from the task's cpuset.mems.
> 
>   2. It checks only the nodes in the immediate next demotion hierarchy
>      and does not check all allowed demotion targets in can_demote().
>      This can cause pages to never be demoted if the nodes in the next
>      demotion hierarchy are not set in mems_effective.
> 
> These bugs break resource isolation provided by cpuset.mems.
> This is visible from userspace because pages can either fail to be
> demoted entirely or are demoted to nodes that are not allowed
> in multi-tier memory systems.
> 
> To address these bugs, update cpuset_node_allowed() and
> mem_cgroup_node_allowed() to return effective_mems, allowing directly
> logic-and operation against demotion targets. Also update can_demote()
> and demote_folio_list() accordingly.
> 
> Bug 1 reproduction:
>   Assume a system with 4 nodes, where nodes 0-1 are top-tier and
>   nodes 2-3 are far-tier memory. All nodes have equal capacity.
> 
>   Test script:
>     echo 1 > /sys/kernel/mm/numa/demotion_enabled
>     mkdir /sys/fs/cgroup/test
>     echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>     echo "0-2" > /sys/fs/cgroup/test/cpuset.mems
>     echo $$ > /sys/fs/cgroup/test/cgroup.procs
>     swapoff -a
>     # Expectation: Should respect node 0-2 limit.
>     # Observation: Node 3 shows significant allocation (MemFree drops)
>     stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1
> 
> Bug 2 reproduction:
>   Assume a system with 6 nodes, where nodes 0-2 are top-tier,
>   node 3 is a far-tier node, and nodes 4-5 are the farthest-tier nodes.
>   All nodes have equal capacity.
> 
>   Test script:
>     echo 1 > /sys/kernel/mm/numa/demotion_enabled
>     mkdir /sys/fs/cgroup/test
>     echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>     echo "0-2,4-5" > /sys/fs/cgroup/test/cpuset.mems
>     echo $$ > /sys/fs/cgroup/test/cgroup.procs
>     swapoff -a
>     # Expectation: Pages are demoted to Nodes 4-5
>     # Observation: No pages are demoted before oom.
>     stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1,2
> 
> Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> Cc: <stable@vger.kernel.org>

We'll want to fix these things in 6.16.X and later, but you've prepared
this patch against "mm/vmscan: don't demote if there is not enough free
memory in the lower memory tier", which is presently under test/review
in mm.git's mm-unstable branch.

This seems to be incorrect ordering - this fix should go ahead of
Akinobu Mita's series "mm: fix oom-killer not being invoked when
demotion is enabled v2".

So can you please redo this patch against current mainline?  And please
also review the "mm: fix oom-killer not being invoked when demotion is
enabled" series to ensure that things will work together nicely when
that time comes.


