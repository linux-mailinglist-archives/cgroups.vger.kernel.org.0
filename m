Return-Path: <cgroups+bounces-16594-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m1v0Jg/UH2onqgAAu9opvQ
	(envelope-from <cgroups+bounces-16594-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 09:13:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090076350AF
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 09:13:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=Mw5NUwP+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16594-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16594-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D301932044A8
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 07:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3D3911BC;
	Wed,  3 Jun 2026 07:02:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD3396D1B
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 07:02:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470136; cv=none; b=eEmctbBI5CnYMoWgv2msS5zMtJOzGDlEFz0AVEinlff38vdftOM7f959oQ8xkgZUNeYHzrBrM5rLpqh7+Jd/GC2ApdD8gjkmUHsrl+cf6LsKc9s/AKythlu9B8AZcph8qUlcRKHa0/jxQRbYXiiMMqFMBSvCZJExo2AJ/7GQEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470136; c=relaxed/simple;
	bh=//hE9Fq13BG8LMkg9LZutEH9KkPSkAh3baK/10eKZNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfiQrsfVByJ1ydWYNPc6OZqGVod5Bgq3MM47jMAQW+NtA+8tRh8N9dU1K/A/fiVKSkmrav9I+zdUDf6GIQ/YuKCyinpmspHdYcwKC56cVgnvV/z+FvoDtTd5hSYkr45l9UAaIsPr7XsdEk3ekDA9zTNZ5BO/+9r8sD/2yEuPKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mw5NUwP+; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so124103685e9.2
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780470133; x=1781074933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=as8GUoU4kWbY2J9d2zC/fdPvz19fGbLVGasT3ISIBEc=;
        b=Mw5NUwP+6K0ahyfzMvZj7v96CD4tTTcjO7pnqqR8ocBbheHQ4rGZFqIezhtI3mlEf5
         XaCHBuCNW7DEhnLSqnRjJsO6JoAPN/0v29kfbN1ucygxqz0/PAZUiWeWaGTRLH1dypkW
         dZxelOO3HnZoxGCxfVdeplXIzzKwNq2QCzBjFl9Qmc0qWYwzFO6DBbXpTw305AnwVWTg
         QsxnXhtKWgR0FweGMR2NIvCvjQC/2LYNdJXHP+Ym434YrFKf0LTOrmBnJ5869h/U1nF0
         CAoXfx0ExvgNLTac0YFJ842Pb65CfZx+9icd5x/s74T6SIv9HmG0jG69x5Jr6pejiWOp
         5XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470133; x=1781074933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as8GUoU4kWbY2J9d2zC/fdPvz19fGbLVGasT3ISIBEc=;
        b=sIw7CGiRlZSI56zuWVYsQQ/KTMZKzO9SWoR4JbPeNMEnDO2wBsJVOViILiGzuzwCWO
         d31tzkYAahLKEGcxNJaN9TpD814hYqJOKIol6LtK7QkyacVkxLzMYmarmSXDcbADaxsc
         PhArNAnVPZiJAW0dVkH17gw1TRStzK1HxFKwdsb7wXV+wOaAcnwvTUC2/5GMsoduxn0Q
         IbEPkKDKSgzmFa7ETr3W6VQ4aNdW9F2ulTPCXo2JvQIceNlBUzOixTuDD+jwuJMZLTFX
         EDHQGPRxHLXpMR/h/Tg1ljyaa6pEIwx6mqWaGYdTpYVyb2L70x7jSSGqui6BpUR7SBja
         y73Q==
X-Forwarded-Encrypted: i=1; AFNElJ80mgLNIxsqH2SzX5YeJHfz5ThBwhG4v48KuMWjld47XK8Krthq94vWG88RKsz5zW0J7aNmmz9Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgc8uXhH40FxB1UjUIgE+Uv0nPsyWOQQMQdVMTzEHG/ROAquXA
	VnxBjI6/BDuCj7to7a1bpMuXv3NZOjhrcjLbNgn6BBXdOnbYNbWpcIg8hg1KrfHS/xQ=
X-Gm-Gg: Acq92OE1j5ZjXssDs5KKg1W7WZPEJMl98s+9O54ZtHnID0hBCFx4DZuDyNACydakcJk
	EHJrPlqosm+JwcNEVUHVSErBEvy6KoYZaHe/YeUAF4Bch2vGyUm/KCJbvgfTHhoqLEx4DYQmLcs
	tkp/3tthSUfT879/h7kEqfg7EhQH+9CuGvGYjuKsNazyDGhckCBq34EgcC0kROLSmr//T4RdVZn
	cFd5VjWYtrqKZAv+OeQaH8kMwGASfqhsI6wTb2Omc4FBjhe7tsj6OxJAswG7ipgMvZ6G7F/3b3A
	96BTggHWThnboVao/oD5xEWbUGQZziFnRbWKqkLFiOwIdKQVxhjdsLz5G9iebk4xgwH52NvSr3f
	o99lco6CjVvnefuoEjxGsswzhm8CKQadv3u6YET3UAM40EsC/aEnW15sz4bBr1Ggh0MplGOvjLT
	D2GYTKsVkReacS4OuSlhrVqTsyeDA7vFkd0bAqaa1tvirxAw==
X-Received: by 2002:a05:600c:83c8:b0:490:47e0:e13f with SMTP id 5b1f17b1804b1-490b5d1cf3emr36644555e9.3.1780470132845;
        Wed, 03 Jun 2026 00:02:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([149.107.71.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7c6b966sm16631885e9.2.2026.06.03.00.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:02:12 -0700 (PDT)
Date: Wed, 3 Jun 2026 08:02:09 +0100
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ah_RcTU8SpQG7hab@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-0CyZurn5D1ezY@parvat>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16594-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:balbirs@nvidia.com,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmus
 villemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:from_mime,gourry.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 090076350AF

On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> On Tue, Jun 02, 2026 at 09:57:48AM +0100, Gregory Price wrote:
> > On Tue, Jun 02, 2026 at 12:16:50PM +1000, Balbir Singh wrote:
> > > 
> > > I was think we wouldn't need explicit flags and that allocations would
> > > happen from user space using __GFP_THISNODE to the node or via a nodemask
> > > based on nodes of interest. Is there a reason to add this flag, a system
> > > might have more than one source of N_MEMORY_PRIVATE?
> > > 
> > 
> > There's a few things to unpack here.  I discussed this many times on
> > list and at LSF, but to reiterate.
> > 
> > 1) __GFP_THISNODE is insufficient to enforce isolation and otherwise
> >    not particularly useful.  Additionally, from userland, it's not
> >    something you can actually set.
> 
> I was thinking mbind()/mempolicy() is how we get to it. It already
> accepts a nodemask.
>

First let me say:  I want to enable mbind access to these nodes.

But let me caveat:  I think that needs more time to develop, and
in the meantime, we can enable the /dev/xxx pattern somewhat trivially.

First let me address a few things about mbind/mempolicy and how it
interacts with page_alloc.c, I gave this overview at LSF but I don't
remember if I posted it in any of my follow ups.


1) Fallback lists are filtered by nodemask, the nodemask does not replace
   the fallback list.

Here is how the page allocator fallback lists and nodemasks interact:

   Fallbacks A:  A B 
   Fallbacks B:  B A
   Fallbacks C:  C A B   (Private)
   Fallbacks D:  D B A   (Private)

Lets say you pass:

   alloc_pages_node(C, ..., nodemask(A,C,D))

So we get

  Fallback(C,A,B) & nodemask(A,C,D) -> iterate(C,A)

If we wanted to change this behavior, realistically we'd be looking for
a way to add specific nodes to certain fallback lists - rather than
modify the nodemask interaction in some way.

I think this is out of scope for the first iteration - so supporting
anything other than mbind() from the start is just pointless.

The only feasible mempolicy you can apply is single-node bind, so
realistically you can only support mbind.


2) full mempolicy support doesn't really make sense

   task mempolicy PROBABLY should never really touch private nodes,
   while VMA policy certainly can.  Assuming we're able to support
   multi-private-node masks, none of the non-bind mempolicies even
   make sense for most private nodes (interleave? weighted interleave?)

   I haven't worked through all the implications of a task policy having
   a private node attached, but the longer I think about it, the less it
   makes sense to just support this outright.


3) Introducing mbind support is not just a simple nodemask on a VMA,
   It also implies migration, cgroup/cpuset, and UAPI interactions.

   a) migration:
      
      mbind/mempolicy can and will engage migration when it is called
      with certain flags.  Migration has subtle LRU interactions, but
      the patch set I have at least allows this to work.

   b) cgroup/cpuset:
   
      cpuset.mems rebinding will cause private nodes to be quietly
      rebound to non-private nodes within a nodemask.

   c) between A and B - we really want MPOL_F_STATIC to be required
      for mbind to be applied to private node so that it is never
      forcefully remapped.

      That's a UAPI semantic change specific for private nodes we
      should really take time to consider.


4) File VMA interactions don't entirely make sense with mbind

   In theory you might want:

   fd = open("somefile", ...);
   mem = mmap(fd, ...);
   mbind(mem, ..., private_node);
   for page in mem:
      mem[page_off] /* fault file into private memory */

   In reality: This does not work the way you want.

   I went digging and we need a few mild extensions to allow
   migration on mbind to work for pagecache pages, and the fault
   path does not necessarily respect the vma mempolicy always.

   You also start getting into the question of "what happens when
   the node is out of memory and you don't have reclaim support?".
   The OOM implications jump out at you pretty aggressively.

   Moreover other tasks can force the page cache pages to be moved
   as well.  So the programming model here just kind of sucks.

   Works great for anon memory though :]

For all these reasons, I think the be mbind/mempolicy support with
private nodes needs to be brought in with follow up work - not
introduced as part of the baseline set.

> > 
> >    for node in possible_nodes:
> >        alloc_pages_node(private_node, __GFP_THISNODE)
> > 
> >    In fact it's the opposite semantic of what we want.
> >    THISNODE says: "Do not fallback back to OTHER nodes".
> > 
> 
> That's why we need to control the fallback nodes carefully for
> N_MEMORY_PRIVATE
>

My point is that __GFP_THISNODE is not actually useful.

If we go by nodemask, submitting a single-node nodemask is the
equivalent of an empty fallback list.

If we gate access to a private node by __GFP_THISNODE... this is the
same as just providing a single-node nodelist (putting aside the OOM
implications for a moment).

And it doesn't even buy you any new filtering ability against existing
nodemask iterators that may already utilize __GFP_THISNODE.  i.e.

   for node in online_nodes:
       alloc_pages_node(node, __GFP_THISNODE, ...)
       /* Alloc per-node resources */

   This pattern is undesirable, but completely valid.

So overloading/requiring __GFP_THISNODE is just not useful.

I will follow up soon with a new version that limits the private node
interface to just nodemask and fallback list controls.

I need to test a few more things related to removing normal nodes from
private node fallbacks before I feel comfortable shipping without
__GFP_PRIVATE.

> >    The semantic we want is "Do not allow allocations from private
> >    nodes UNLESS we specifically request" (__GFP_PRIVATE).
> > 
> >    __GFP_THISNODE does not actually buy you anything here, AND it's
> >    worse, in the scenario where a private node makes its way into the
> >    preferred slot (via possible_nodes or some other nodemask), the
> >    allocator cannot fall back to a node it can access.
> > 
> >    __GFP_THISNODE cannot be overloaded to do anything useful here.
> 
> Let me clarify, I meant to say, let's use a nodemask for allocation
> and __GFP_THISNODE gets us to the node we desire, if that is the only
> node. My earlier comment might not have been clear.
>

My point was that __GFP_THISNODE is pointless and reduces to providing a
single node nodemask anyway.

The contention over __GFP_PRIVATE is a bit ideological - do we want:

  1) A hard guarantee that allocations to a private node are controlled
     (__GFP_PRIVATE implies the caller knows what it's doing)

  or

  2) A soft guarantee (fallback list isolation only), and needing to
     deal with undesired behavior that's "not technically a bug"
     associated with existing users of global nodemasks (possible,
     online, etc).

I am arguing for #1 - the community has argued for #2 and "fixing
existing nodemask users".  I think we can ship #2 and pivot to #1 if we
find fixing existing users is infeasible or too much of a maintenance
burden.

> 
> Why not use mbind() API's? Do we want to gate allocation/privileges
> via a /dev?
>

We want to eventually enable it, but we really need to treat these
extensions as a separate step from the base so that the UAPI
implications are given proper scrutiny.

In the short term, /dev/xxx and driver-local/service-local control
of a node is still very useful.

For example, for my compressed memory work, I have found that if
implemented as a swap backend - the kernel can manage the node without
any UAPI implications at all :].

A driver managing memory on a private node could do the same.

~Gregory

