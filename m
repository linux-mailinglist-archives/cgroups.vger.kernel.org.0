Return-Path: <cgroups+bounces-13286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A3D390B8
	for <lists+cgroups@lfdr.de>; Sat, 17 Jan 2026 21:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3083830124F3
	for <lists+cgroups@lfdr.de>; Sat, 17 Jan 2026 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49362DB790;
	Sat, 17 Jan 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vsbwAn2H"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F322777FD
	for <cgroups@vger.kernel.org>; Sat, 17 Jan 2026 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768680090; cv=none; b=kz7PjousNyDwBxjop/CiVyty2Qs8Q1VetNa/AhDYSmDAXWK8yAPk1aZVtHAuukRAOVmpd2NY+uqZYKT85hpFFj1adkGVsusfWZzVg2zANm70AzNanxfPMDX/MPNVuvJIlXBK0gveBCHxLP2lfGjR8KN6bl8GkPC5Iqwkoq51rAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768680090; c=relaxed/simple;
	bh=EAjux8rRbssi29gsC0KCyrFMwWek1g4UtzmO3HLP53g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7YpT6pMCa3uGzC+2dio0jB/qyM/czcf3QKt5/25J8xcg287seeTrNNeun/Su7cEWRp8NuWxQosRwSIAbUWmQdPj1ihLWeRz2qV4+puJCY8BmQpIAflpcX78gIoRkAXYrqxELkcHEcj1pLbV0SGvH+0ZUIB5W3p3d3yHtqRWxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vsbwAn2H; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 12:00:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768680076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIAI/J9JoA2qY4ACb7rrwn9F73GTYkqP3ib203Y7byA=;
	b=vsbwAn2HQlzPeCXjqaokL9JkWcH/xiCkLxNZ1alZhQCmlz4tjWL/KWTs3HJ8QsthQfxfqi
	hUwgufHW90+0X6BOHcdwQtT6dhn60CskRdD96pYoLW0rnAnhEZSFbrObP5Q/uJRPgAjAUf
	g9U+qMJL7QPMLp8Stxz6US+qt+pp5OE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 08/30] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <hu7mfsqyeuh2txp6vt5dvfsdrl37jeualew6slefyfqslg36nn@hysym264wfof>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <c5c8eba771ab90d03f4c024c2384b8342ec41452.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c8eba771ab90d03f4c024c2384b8342ec41452.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:35PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in get_mem_cgroup_from_folio().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.

This patch is adding a retry loop as css_tryget() on folio_memcg() can
fail because after reparenting functionality the folio no longer holds
down the memcg. Please clarify this reasoning in the commit.

With that:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


