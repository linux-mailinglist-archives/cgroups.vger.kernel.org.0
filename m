Return-Path: <cgroups+bounces-12538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDBCCD2493
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 01:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1C0302C4E0
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26E2405E1;
	Sat, 20 Dec 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bVJ4Wr3M"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A023EA82
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766192333; cv=none; b=aqElWhJ5co0C9ujmS+4+g3lvigEA0h37J9tq16xWUoueRDoQy2WBI89KfbSfdWtuOOpzDAwn8AptjUPtPtUqSRV86dqzYP78wMjn05tnoKI3Gtv444GTIgedKMH720FsfBn0KciaebSDaKgxESGKAltergjf8e2f9icK5t1IBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766192333; c=relaxed/simple;
	bh=4H62w/d2mnSA/q8isVhF9VTe4gG3fN/VHi4blZhAu8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqg7iNai6CekS0hNL2STVJ9DF5+LXVqcFDvUq5DRolIyZJ4GLMEEmpWQFYdGUL5RXcnOMdRPjSKrygfzHXsmKDWdBlxvd2Lp5Bn1tehkh1FDZtkwB9piJWO81u5hxBKWUamg80yXU6rOQeoWbx09mK/2eSBhNRhOsTC4dNMU1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bVJ4Wr3M; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 16:58:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766192317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BmHwGQf18ijS41p6mfFhQcrUixQzLRzSixBXG5dU4lU=;
	b=bVJ4Wr3MVaABvgDeKaqo7NNNZVp+khl0wXKX4pY8nlxEGr6vGK/1LEusvywoYSKQy0ehl0
	R46y804hOIrqjM+O8KupKBQg9jeFPxKUBeV81S2u6cN4mEtP9sW88I+TQN3VoWW6K1aemG
	obUOK/Xybecz3aHbDAH7h5y7qvaxW5M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 14/28] mm: mglru: prevent memory cgroup release in
 mglru
Message-ID: <id7sx5zsl6a7v7aoy2p4r6puxkvtlib6jlqv3rnt7pegbucbhx@5plupkfwo6en>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <ab60b720d6aef1069038bc4c52d371fb57eaa6e8.1765956025.git.zhengqi.arch@bytedance.com>
 <aUMsQPjBtYtVWjwf@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUMsQPjBtYtVWjwf@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 05:18:40PM -0500, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:38PM +0800, Qi Zheng wrote:
> > @@ -4242,6 +4244,13 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
> >  		}
> >  	}
> >  
> > +	rcu_read_lock();
> > +	memcg = folio_memcg(folio);
> > +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > +	max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
> > +	gen = lru_gen_from_seq(max_seq);
> > +	mm_state = get_mm_state(lruvec);
> > +
> >  	arch_enter_lazy_mmu_mode();
> >  
> >  	pte -= (addr - start) / PAGE_SIZE;
> > @@ -4282,6 +4291,8 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
> >  	if (mm_state && suitable_to_scan(i, young))
> >  		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
> >  
> > +	rcu_read_unlock();
> > +
> >  	return true;
> 
> This seems a bit long to be holding the rcu lock. Maybe do a get and a
> put instead?

This function is called under ptl lock, so at least for non-RT kernels,
the preemption is disabled across the function. Anyways no strong
opinion either way.

