Return-Path: <cgroups+bounces-12554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759DBCD35FB
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 20:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E453007EF6
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E22F5A34;
	Sat, 20 Dec 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HG8uF931"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7A2C21DF;
	Sat, 20 Dec 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258446; cv=none; b=TSxJvTmAyiwbo0onBpt1mvenHOGeqSSjZTAlIMyxoZiif5vT5T3+fuSM0qBlh2j1006F0gZSSk0WeXUjoH7+x0wIyh0c3U5ysINLzlR5bZELZ6eksy6hhM49+ZNruihXjekHTqivAbaBdsdiPELt+JN7VPmn/OgxWp97dh2R3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258446; c=relaxed/simple;
	bh=kKhMT8Mje8TVBJP8X15PI4OV/2bCI5xsEnfBkKi5YAk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WVQmESILOjArXICVZmufGJDJ8064ym/ZYxEcnbmGebRbIiGZ8u1a+iUAZFHC5PXGsPaBu94p1+iF69sDre8iiT8e69nEg8+2ifIQi9XoLugBQyhP8kKCNxdNnYLuUblgZqoXIKxj1bL6o1UMd3o0n1cvFAfPmdTUzdbHr4Kn084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HG8uF931; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5CEC4CEF5;
	Sat, 20 Dec 2025 19:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766258445;
	bh=kKhMT8Mje8TVBJP8X15PI4OV/2bCI5xsEnfBkKi5YAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HG8uF931r6uX5DDIN5X1v3f5o18hAWfxLQDvcpUMMZ+9KnJTkWSPkupSB7XXufZK8
	 /PwUEV8huMAKinw0AmteSO9d6pqfecvHhqDRDNrWCBl2atbs9KQZ3WCFhubs159V1F
	 jpYqJXAZ5IvRodv++3xFsYZWZQOvNSwReWNB/Xtc=
Date: Sat, 20 Dec 2025 11:20:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, gourry@gourry.net, Waiman Long <longman@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 =?ISO-8859-1?Q?"Michal_Koutn=FD"?= <mkoutny@suse.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: respect mems_effective in
 demote_folio_list()
Message-Id: <20251220112044.ee858d2160f819e181598ce1@linux-foundation.org>
In-Reply-To: <20251220061022.2726028-1-bingjiao@google.com>
References: <20251220061022.2726028-1-bingjiao@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Dec 2025 06:10:21 +0000 Bing Jiao <bingjiao@google.com> wrote:

> Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> introduces the cpuset.mems_effective check and applies it to
> can_demote().

So we'll want

	Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")

in the changelog.

> However, it does not apply this check in
> demote_folio_list(), which leads to situations where pages are demoted
> to nodes that are explicitly excluded from the task's cpuset.mems.
> 
> To address the issue that demotion targets do not respect
> cpuset.mem_effective in demote_folio_list(), implement a new function
> get_demotion_targets(), which returns a preferred demotion target
> and all allowed (fallback) nodes against mems_effective,
> and update demote_folio_list() and can_demote() accordingly to
> use get_demotion_targets().

7d709f49babc fist appeared in 6.16, so we must decide whether to
backport this fix into -stable kernels, via a Cc:
<stable@vger.kernel.org>.

To make this decision it's best to have a clear understanding of the
userspace visible impact of the bug.  Putting pages into improper nodes
is undesirable, but how much does it affect real-world workloads? 
Please include in the changelog some words about this to help others
understand why we should backport the fix.

> Furthermore, update some supporting functions:
>   - Add a parameter for next_demotion_node() to return a copy of
>     node_demotion[]->preferred, allowing get_demotion_targets()
>     to select the next-best node for demotion.
>   - Change the parameters for cpuset_node_allowed() and
>     mem_cgroup_node_allowed() from nid to nodemask * to allow
>     for direct logic-and operations with mems_effective.

If we do decide to backport the fix into earlier kernels then it's best
to keep the patch as small and as simple as possible.  So non-bugfix
changes such as these are best made via a second followup patch which
can be merged via the normal -rc staging process.


