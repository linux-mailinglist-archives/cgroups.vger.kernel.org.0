Return-Path: <cgroups+bounces-5669-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF89D6B89
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 22:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553D2B21DD3
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE819D088;
	Sat, 23 Nov 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jwP+eSFq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A272309A9
	for <cgroups@vger.kernel.org>; Sat, 23 Nov 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732396491; cv=none; b=kxwiffyJKR5AFFrL9FE3f358/0Wj78KwDzZgJG6eIiMVsT8Qs58zYITd2JkSyQH+HaAm0ggWaSce/hdfzdp1XrHb4AvaJsXK4c8RrZs4YXkZn2G2TDD91BxUEjhCs+wK+DEasFMop3un9saVNWzECuC91erAd5SqY9Nb9SnLVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732396491; c=relaxed/simple;
	bh=sXo79Kjpd9kYw3+H3Qc8uYh7G0vKv14M4R4EYwZ8MtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifr6Iw2VVYubwBFZ32uRvFtBSYOLf7NkzrayGgyhJi2ryrMgOKGx0SK07AnJ18sV2G5G/YZIJGuWVLw0l+Bc54jKHUQZIBg5lXm1vQcKnZa0b3gJ8I/gwh47ULDHF/Kqzsp6LWypSK2Cnpat8exh3cq0ifDRUy/LhPZb+RdnUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jwP+eSFq; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 13:14:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732396486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/5pPJyT3fsLdVu0JPf1v9z8ZI+Cm/OsIvTfB5/40Lc=;
	b=jwP+eSFqul9j4mmk23hgc0/Bok6RfuUVwSjiOvGWh6eP1iQG4rN3pDMambhlk9tRjlmTNd
	XgivcX9YrlwNyuD6zibB/hKFfTw1PrpbrnkU2yE1UFzwxYq7SpB6/LyJ1OVCI5TcJghz2A
	LVKqpUtZ9SwgQnYG0Dn39xmXJlDk2zU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <bqza4gctbajm5coj7cazivcd7chpigc7h6cqd4pnp2ql2hggvp@5xlflsvtkdff>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
 <CAJD7tkYAch4TpO0JSpjmg6k3VVw-0x_acf2P2JBveaD3mXPxgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYAch4TpO0JSpjmg6k3VVw-0x_acf2P2JBveaD3mXPxgA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 22, 2024 at 10:46:53PM -0800, Yosry Ahmed wrote:
> On Fri, Nov 22, 2024 at 10:10 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > We are starting to deploy mmap_lock tracepoint monitoring across our
> > fleet and the early results showed that these tracepoints are consuming
> > significant amount of CPUs in kernfs_path_from_node when enabled.
> >
> > It seems like the kernel is trying to resolved the cgroup path in the
> 
> s/resolved/resolve
> 
> > fast path of the locking code path when the tracepoints are enabled. In
> > addition for some application their metrics are regressing when
> > monitoring is enabled.
> >
> > The cgroup path resolution can be slow and should not be done in the
> > fast path. Most userspace tools, like bpftrace, provides functionality
> > to get the cgroup path from cgroup id, so let's just trace the cgroup
> > id and the users can use better tools to get the path in the slow path.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  include/linux/memcontrol.h       | 18 ++++++++++++
> >  include/trace/events/mmap_lock.h | 32 ++++++++++----------
> >  mm/mmap_lock.c                   | 50 ++------------------------------
> >  3 files changed, 36 insertions(+), 64 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 5502aa8e138e..d82f08cd70cd 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1046,6 +1046,19 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
> >
> >  void split_page_memcg(struct page *head, int old_order, int new_order);
> >
> > +static inline u64 memcg_id_from_mm(struct mm_struct *mm)
> 
> The usage of memcg_id here and throughout the patch is a bit confusing
> because we have a member called 'id' in struct mem_cgroup, but this
> isn't it. This is the cgroup_id of the memcg. I admit it's hard to
> distinguish them during naming, but when I first saw the function I
> thought it was returning memcg->id.
> 
> Maybe just cgroup_id_from_mm()? In cgroup v2, the cgroup id is the
> same regardless of the controller anyway, in cgroup v1, it's kinda
> natural that we return the cgroup id of the memcg.
> 
> I don't feel strongly, but I prefer that we use clearer naming, and
> either way a comment may help clarify things.
> 

Ack, I will change to cgroup_id_from_mm() but I will keep memcg_id in
the tracepoints.

> > +{
> > +       struct mem_cgroup *memcg;
> > +       u64 id = 0;
> > +
> > +       rcu_read_lock();
> > +       memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> > +       if (likely(memcg))
> > +               id = cgroup_id(memcg->css.cgroup);
> 
> We return 0 if the memcg is NULL here, shouldn't we return the cgroup
> id of the root memcg instead? This is more consistent with
> get_mem_cgroup_from_mm(), and makes sure we always return the id of a
> valid cgroup.

Good point and I need to add a mem_cgroup_disabled() check as well. Will
do in v2.

