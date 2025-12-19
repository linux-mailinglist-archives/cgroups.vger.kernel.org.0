Return-Path: <cgroups+bounces-12536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3241CD233F
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 00:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965A630206A3
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5717284670;
	Fri, 19 Dec 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l+TWJuFR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F023C505
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187870; cv=none; b=utOIi0ys/EPvrYCSfh6G64tyFTz0c6DYnJIc3Cf5P898r7J+vrjyh4GfFKZW9SKtImroldpf2fsRAr/4Qysh9nEkzVxudfnf9qf4wYo+eXJ+v/SBIPhrtvN03ZQJYBzw6Y1XqOoz9H+gXIxO7PLA59YgCGedPwMJOwXL4govMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187870; c=relaxed/simple;
	bh=Ipky1YH5SXvSvx7na6+R8fuz29AtAs3QpUeynz0lQhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU8TtEHvViS7CxARnLpkdIqFZbg5FjThT/7yZCL+wOt9fVRhw5VR1H4LTJiYKCuiubJtqxjGQTsi3zN3AIFUmRUARwhfNMz0VeSmIRCy+iRPZx4wCj3HzA/9A/pfF/zA3MQORYi1VaTsVTvC7qUbyF/4OOUYkmoB6f3AldvaIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l+TWJuFR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 15:44:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766187851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCNM7CKQvW7IiJWIjYWIMSk4y/8kklTp5sAV5yymdxY=;
	b=l+TWJuFRGO7tbzkNJUMsZloXTqpansr0zSj8/bmjfFY+sDbfgD4v5O45o53OsXFM8IhqW0
	Xoddxj09mZb+pRi4/CNUW3BOI1JGweiasx0O5asfdb3ebGENJH+QaZgBJKf0G0iBLY3eQL
	erqHVHZVd58wzuk4zuQUYtqHdEVYwfA=
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
Subject: Re: [PATCH v2 12/28] mm: page_io: prevent memory cgroup release in
 page_io module
Message-ID: <2vypu4pg3mfhmwyhwmlzozhdnjw4xne62sxe5hpqdohm3s2bjz@sk53oaivblz4>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <30588f984137d557e4663ae8dcf398b8c408169b.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30588f984137d557e4663ae8dcf398b8c408169b.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:36PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in swap_writeout() and
> bio_associate_blkg_from_page().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

