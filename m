Return-Path: <cgroups+bounces-12546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5208CD2579
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 03:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C63FE300F1B4
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116252E7179;
	Sat, 20 Dec 2025 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FzkZzase"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F525332E
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766196283; cv=none; b=ZtahpDWyPE1s/d26l1GFdCc7e7UoxqZ/YdRK3EVOHFMq+QHpXL4L0gwkwN3hyqWYk2vXDbKP7zrwTaEG9czIo1AetDqdkwmYDpWQ2y3kqzbA0k1ABQkOqC3qWSEqBulouaWLRAVzhiynPemx89GLdrTkE8DfB0mILCWR3WsMhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766196283; c=relaxed/simple;
	bh=77XKr3xQRy463I7GXqauEKJQOviU5SRE9TfZarVll0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcIICz2uXd3bXmU4f839oaW1VjP0Au5kIplJqSlWduHIQ2SdlwYXujgNEsF0v8e2FyuVF6bZ0F/XLO+mL22BA3jzQ3ZvTOpR/2+FQZx0cK+sP4OLx4zFh2vcOh8R3W7Inbt8BlXFoJFfnuCQ8cbGu4v7wv7btH18NQvCyA5jxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FzkZzase; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 18:03:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766196268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4z3e0bMA9k9deirHaNPAvvnsA5OuUkwcK91JbFfwpc=;
	b=FzkZzaseKGxfs1admxWGs8Tw5MD2Zik2GFK+WRLk0SaeNE+Do4YVYZiSbSbS8d9l2TtmzY
	6t7FL/bp9ejebxXX/25JP/sPbM1T3OZOJHr2RJp25aSJ5H4ptlAA2IsynX88SUpke7JNDJ
	O2DIS42mMfMacM6Q25supFEbQMqlx10=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 23/28] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <jdhf6h7weedyentvyaqsr3n3v7dlj4n6k3mrryn2hkyhc255cl@kmexszfblh6s>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <6d643ea41dd89134eb3c7af96f5bfb3531da7aa7.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d643ea41dd89134eb3c7af96f5bfb3531da7aa7.1765956026.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:47PM +0800, Qi Zheng wrote:
> @@ -1232,14 +1221,20 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
>   * - folio frozen (refcount of 0)
>   *
>   * Return: The lruvec this folio is on with its lock held and interrupts
> - * disabled.
> + * disabled and rcu read lock held.
>   */
>  struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
>  {
> -	struct lruvec *lruvec = folio_lruvec(folio);
> +	struct lruvec *lruvec;
>  
> +	rcu_read_lock();
> +retry:
> +	lruvec = folio_lruvec(folio);
>  	spin_lock_irq(&lruvec->lru_lock);
> -	lruvec_memcg_debug(lruvec, folio);
> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> +		spin_unlock_irq(&lruvec->lru_lock);
> +		goto retry;
> +	}

So after this patch, all folio_lruvec_lock_irq() calls should be paired
with lruvec_unlock_irq() but lru_note_cost_refault() is calling
folio_lruvec_lock_irq() without the paired lruvec_unlock_irq(). It is
using lru_note_cost_unlock_irq() for unlocking lru lock and thus rcu
read unlock is missed.

Beside fixing this, I would suggest to add __acquire()/__release() tags
for both lru lock and rcu for all these functions.


