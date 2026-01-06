Return-Path: <cgroups+bounces-12937-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7ECFAF36
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 21:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E7430B40D7
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BDF34AAE0;
	Tue,  6 Jan 2026 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ag1bDF4X"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850534A76D;
	Tue,  6 Jan 2026 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728217; cv=none; b=gqdaBrZSoNn4KieK28pPNK10U7adHkDXFSqWMDNFfULb6T3szw7NZxWVq7wsixr7ALvowIrb/d1J1OeL++GlROc8jT/x73Hg8xN7Vv35x7BYdp1V/0IH1D/UietIqcuP1n+Zzuadtg+15wcrwOlu9QGXft6D7rJvJQA77VmqUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728217; c=relaxed/simple;
	bh=aX5ErCx74e37nAMgsGg4wnwmylSVnqj+pGJPEHPS6Vw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X1SG+Kgq3lAzicKkOcdEQNZPyFifv4fe1sW+WqiNASavJPnExvyjo/jU4glyCrMDAJlg0hdGCY0Haldjbyd4q3iiSfwbzIuIgnoVb3VnQaf6Ro5BaJ2SuWqhPA3DUDVNlAVJ5rIIft+siYZStcyjKq5b2ry0hjm+fukomRKX9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ag1bDF4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164C8C116C6;
	Tue,  6 Jan 2026 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767728216;
	bh=aX5ErCx74e37nAMgsGg4wnwmylSVnqj+pGJPEHPS6Vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ag1bDF4Xddc+QOPO1lE2eYtZg53Kw95IbRIng9dnbEd262GkFTAPEgxDrWUD9r/bq
	 FPz2e7CnWXV9/e4OiWlPTLRlsNhV8OQBVKqVj9+FQzvAngP8oQ4SeNKJL/TfRSz8Sr
	 tCvdTuIeY5KmZtKus8eRUWkM/moqtyZT40d9hUME=
Date: Tue, 6 Jan 2026 11:36:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
 longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tj@kernel.org, mkoutny@suse.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 axelrasmussen@google.com, chenridong@huaweicloud.com, yuanchu@google.com,
 weixugc@google.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-Id: <20260106113655.52d71d43595aca9296cb02a1@linux-foundation.org>
In-Reply-To: <20260106075703.1420072-1-bingjiao@google.com>
References: <20260105050203.328095-1-bingjiao@google.com>
	<20260106075703.1420072-1-bingjiao@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 07:56:54 +0000 Bing Jiao <bingjiao@google.com> wrote:

> Fix two bugs in demote_folio_list() and can_demote() due to incorrect
> demotion target checks in reclaim/demotion.
> 
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

Thanks.

I'm not confident in my attempts to resolve Akinobu Mita's "mm/vmscan:
don't demote if there is not enough free memory in the lower memory
tier" against this.  In can_demote().  So I'll drop Akinobu's series,
sorry.

Akinobu, can you please redo that series against tomorrow's linux-next?
it looks like it needs a resend anyway to try to create some reviewer
input.

