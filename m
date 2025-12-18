Return-Path: <cgroups+bounces-12510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8ACCC3BB
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E76304D236
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752A2222A1;
	Thu, 18 Dec 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="SXFK6SgV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3643A1E72
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066815; cv=none; b=U/4hp5sE2rQd1RvLIlRDikBcfEiqNbVxkOZiwX65pP9V9FxVAgU1yzv6IlEt8lb12BL1TpL761ULwd+LTX1lObSntJ0jPCvRPZMsMBuLiwt8xvYm+PuAY+WbUzHzleFPGlvT9AYnPPFJHxAOGvM7omiY/uvGDkUc9lzDahTEk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066815; c=relaxed/simple;
	bh=/rp2XK3YF6HyMaRXJUuw+7Ik4GDj4jVK7HmO8KQIZGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEZQcM1kVUOW3gKx/riBCOB3VPS4xSDkxlW0pXdk0Biym1VS+NEbXtOqCGQ6+zZDfjD2r+bVU6ltVrvsOtk7h3fxvfXp622FP77Jr9DCm8fhjwah/zeXvB6LgDxLN62KEVhflRK4Y0R0u62QdhZl/YLRqqziVe2N3UV3shcjF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=SXFK6SgV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2d7c38352so177109885a.0
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 06:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766066811; x=1766671611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sR30ixwBE7Y68ILuHxMSkeae6AHX5P9JPZmuAQuOZlI=;
        b=SXFK6SgVuAO/YTbAeobW+pH3NI/GnLR1QdJfKp4h1Cw0XWJtyDadEVuCTgPolzZzRV
         5X7bdXjlYqzSJamauu992M5Xr0HsalVb2QndlKXu+8i5uovcW2UcLZuJVKB+g5CXbITe
         K1Z4zP+plYvYreQVefdqgRsySCbNV9NzA3Z4YbsVYfX5qEAMeUwhnM2cvmFs9EN8aIpD
         Hh+A4/5Q065K5DgVg5wK4p9Pv29za34wdHhSEkztO60TDdlknqEn7ftERrfDmS8DHl+C
         hUKK3zdXRMkFEXdevZlEcs6Zrd9V/yl6gw2/bjB7ql1Skb58NZP3n71imLJpTlBd6J3o
         3B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766066811; x=1766671611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR30ixwBE7Y68ILuHxMSkeae6AHX5P9JPZmuAQuOZlI=;
        b=pEk0pvPA+2mcMVXeYJt5esJqSU04ND1Z2e8zySOsKylCc4czG38/+S0Vn8L2nujlUa
         q+Fm6smtFBw/EONkyutoE9YyWtK8oiV9kFELj0lzyZColpjljcxMYXeY5s0EAgK8xR3g
         aI4H8jTJmwXRkKs0JcCRe4nvrEIYzMxWTCicfpdN8M8UENxjObEzfkNp7qBxAGnNdsf6
         3ysU+yhUwDybHdweszGvCRPW0m6bATFmCZ6hFcmkTZ++HiJq5HXpZPfZh2Zp9P8Lz2qM
         yrXHTO9lXLwEuoGiIntym4J/gaA4cA7Ww/E+K/Bh/mW1CnJ7tQCcVhpJ1PfSZw7DGT2v
         lnmg==
X-Forwarded-Encrypted: i=1; AJvYcCVx+BsAMxUuNEvbMbPcxJ6JqJ6lmrUhH66NTdQzT+iQeckWNELCoADcmzploFau+BJ1hdbK93mG@vger.kernel.org
X-Gm-Message-State: AOJu0YyYH/8h8Mmxg5yPZiYHqRnLGMjjPsQef+xeOmzXC88OFPQWf6li
	hhKId5oc3Lq0ZJbhy563oA1ETQpE9dlky93OSFeCdMf6nR4rn7iLxOWHQF6TaabkyC8=
X-Gm-Gg: AY/fxX7RGT7ek7k6QC0uvn0O9OHHx3xdYz22idE10P+X8DdIyubczEfYHUzYpK+uhe9
	PbXFjTmxnOBsxo/yQh+ECQg2wWSykSGuIMHXLUB7WmMoOvPINxCB4K8seio6vAyvpK3iIIgYdU/
	EIHz5gZfwkvbqtZMMXOFmSlwa2woupFYOA5xTP9HbViH613MrasMoST6XNyJB2sJnmoF5nq1sXr
	kBpgEALkfH+BUPP3B7r2HqfZEe0qGCeErs9WjC9SBTfmltFlcw0HLcWva7iS70LLixzdWNrqpyy
	kYBEchElUwR+sTpQKULpka9XXDd2rdz/dRRc4AdUExddJqJE7glH/PF4SOD2lOnGXkkdQZ+7XWk
	hkhW6NfOCIRsp/SzM5g33PB4HIidhU/bUXYVaEcR73n+RecjxPG5tfmAEqQwpKNOSLXcpoj696z
	ATF9oVnWT+NQ==
X-Google-Smtp-Source: AGHT+IHGiY8Hg/MD1OdXod9gyMroAAQViBd9bZlpYzLebqdk9FpWA5fcGAjVIG5zyNvPrE0drHPDtQ==
X-Received: by 2002:a05:620a:400e:b0:8a3:90cb:9224 with SMTP id af79cd13be357-8bee670c438mr434656285a.2.1766066811117;
        Thu, 18 Dec 2025 06:06:51 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb5f2911sm168014685a.17.2025.12.18.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:06:49 -0800 (PST)
Date: Thu, 18 Dec 2025 09:06:45 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <aUQKdZsMclicBDYx@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:51PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Pagecache pages are charged at allocation time and hold a reference
> to the original memory cgroup until reclaimed. Depending on memory
> pressure, page sharing patterns between different cgroups and cgroup
> creation/destruction rates, many dying memory cgroups can be pinned
> by pagecache pages, reducing page reclaim efficiency and wasting
> memory. Converting LRU folios and most other raw memory cgroup pins
> to the object cgroup direction can fix this long-living problem.

This is already in the coverletter. Please describe here what the
patch itself does. IOW, now that everything is set up, switch
folio->memcg_data pointers to objcgs, update the accessors, and
execute reparenting on cgroup death.

> Finally, folio->memcg_data of LRU folios and kmem folios will always
> point to an object cgroup pointer. The folio->memcg_data of slab
> folios will point to an vector of object cgroups.

> @@ -223,22 +223,55 @@ static inline void __memcg_reparent_objcgs(struct mem_cgroup *src,
>  
>  static inline void reparent_locks(struct mem_cgroup *src, struct mem_cgroup *dst)
>  {
> +	int nid, nest = 0;
> +
>  	spin_lock_irq(&objcg_lock);
> +	for_each_node(nid) {
> +		spin_lock_nested(&mem_cgroup_lruvec(src,
> +				 NODE_DATA(nid))->lru_lock, nest++);
> +		spin_lock_nested(&mem_cgroup_lruvec(dst,
> +				 NODE_DATA(nid))->lru_lock, nest++);
> +	}
>  }

Looks okay to me. If this should turn out to be a scalability problem
in practice, we can make objcgs per-node, and then reparent lru/objcg
pairs on a per-node basis without nesting locks.

>  static inline void reparent_unlocks(struct mem_cgroup *src, struct mem_cgroup *dst)
>  {
> +	int nid;
> +
> +	for_each_node(nid) {
> +		spin_unlock(&mem_cgroup_lruvec(dst, NODE_DATA(nid))->lru_lock);
> +		spin_unlock(&mem_cgroup_lruvec(src, NODE_DATA(nid))->lru_lock);
> +	}
>  	spin_unlock_irq(&objcg_lock);
>  }
>  
> +static void memcg_reparent_lru_folios(struct mem_cgroup *src,
> +				      struct mem_cgroup *dst)
> +{
> +	if (lru_gen_enabled())
> +		lru_gen_reparent_memcg(src, dst);
> +	else
> +		lru_reparent_memcg(src, dst);
> +}
> +
>  static void memcg_reparent_objcgs(struct mem_cgroup *src)
>  {
>  	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
>  	struct mem_cgroup *dst = parent_mem_cgroup(src);
>  
> +retry:
> +	if (lru_gen_enabled())
> +		max_lru_gen_memcg(dst);
> +
>  	reparent_locks(src, dst);
> +	if (lru_gen_enabled() && !recheck_lru_gen_max_memcg(dst)) {
> +		reparent_unlocks(src, dst);
> +		cond_resched();
> +		goto retry;
> +	}
>  
>  	__memcg_reparent_objcgs(src, dst);
> +	memcg_reparent_lru_folios(src, dst);

Please inline memcg_reparent_lru_folios() here, to keep the lru vs
lrugen switching as "flat" as possible:

	if (lru_gen_enabled()) {
		if (!recheck_lru_gen_max_memcgs(parent)) {
			reparent_unlocks(memcg, parent);
			cond_resched();
			goto retry;
		}
		lru_gen_reparent_memcg(memcg, parent);
	} else {
		lru_reparent_memcg(memcg, parent);
	}

> @@ -989,6 +1022,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>  /**
>   * get_mem_cgroup_from_folio - Obtain a reference on a given folio's memcg.
>   * @folio: folio from which memcg should be extracted.
> + *
> + * The folio and objcg or memcg binding rules can refer to folio_memcg().

      See folio_memcg() for folio->objcg/memcg binding rules.

