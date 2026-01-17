Return-Path: <cgroups+bounces-13288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7CD3916D
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 00:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330C43016DC5
	for <lists+cgroups@lfdr.de>; Sat, 17 Jan 2026 23:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF312882B7;
	Sat, 17 Jan 2026 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mr59Wu82"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C027281E
	for <cgroups@vger.kernel.org>; Sat, 17 Jan 2026 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768690977; cv=none; b=u+dqcToBLaKspFA6Qdmx2fnwAk5x+ydocVjrO1R3fbQwMEEWNlMPntolRmFVMg4jFDUiaNtcL82w7Gix6t3E9v9tMO6f102FBLVQgAmizM+xa7IFEE8KWP4nPufGAi+2A3sZR+zhZ/9R1MfYRjK+BwCEMDLMHUgTWnh263FTUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768690977; c=relaxed/simple;
	bh=GjHIIkxwvCjwUONRjrE0MI/n/24VyCMoqjTbue5foCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQPLBK3ZQcRuqjULOsMi4oslNlzgIA6PcwQvr8qvgRtBdTXuZ2fyIRJUu60r7Un0Wi1lyqgk3TPn2jtyXHviarAUiczFikJaeOWq+LiabeBszmA+YHyzne3qP36HkgSOdpVYKyjAawCZjv7Fl6R9ysQhf42UCegsjUWqlwN7A64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mr59Wu82; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 15:02:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768690963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3Vg2S3dBZ9hH7KYqwxt53gMNelNXYK2M756w2nvXQ4=;
	b=mr59Wu82VCEZ0rUrZcXonzhIOebmpeLhzBIWOnYBI0VPNaZGkggXCcdzn1c/E34x5QA53s
	ufLGbtqbTahT+xYGs0teNh2SUcW+HzN0S+veazgzh6IuP+02MNHWAFduZ65syQQ6oq/+GL
	godi9luHMLEUoI2rD8ULq51tm5TitFw=
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
Subject: Re: [PATCH v3 19/30] mm: workingset: prevent lruvec release in
 workingset_refault()
Message-ID: <cfmtkmnrnyzj5hdivkfxbxakdymjxyjrdeebkctx5kthptw4hd@e4wzydxznsl3>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <cf64f5c0563a3fba9994d45bda5027f00afbed3f.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf64f5c0563a3fba9994d45bda5027f00afbed3f.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:46PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in workingset_refault().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

