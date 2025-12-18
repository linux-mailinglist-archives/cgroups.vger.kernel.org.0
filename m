Return-Path: <cgroups+bounces-12518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2376CCDFC8
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBEDD3093DA1
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB553101C7;
	Thu, 18 Dec 2025 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o0KKnWqM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1501313521
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100708; cv=none; b=M2gPzjky3Mwbp9WEp9NoobYvUz2GDthD1htXUvN5MiZgqxoQINwotvIpobAWb3c0mwh0FsYOBRaXD2UNB9qhty8K1WkdpzECkVNMUDFIr78+QcahEeWFciiSJ/SWbYGLKM8Nilca1XpSb2YKm2QwA+RBOfGraNKIG/cO8DW0t/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100708; c=relaxed/simple;
	bh=gtQL7afMiqb3UXInG9juhNgvMHbncXuxLBSGnPJf2aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq3qCpqVDHiBm+UjdQqM86ELNk1ZUqCnvmhLon2v85ittSyTKcZgHgiskRAUKQImcwWKO+SYrJnwyKENi1yPgWePbHSX35Km7q8K5ZX2i1qzhb0FhxXX8POb1RAE9JCjeJmghdmYWPCJqLv/V5hZ0FcPQvjWVIp3AnDGPKXUpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o0KKnWqM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 15:31:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766100696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VKav4O69WKEhvec63CJZ4iBv1RZ7WNrH0T3Nzbeb4Q=;
	b=o0KKnWqM/yRIom/QzfkZRdzGFf/2sloCtNG9jPrrdVJCsfvcTvmpaPU6XyKV9YQKkscGhV
	4jidqPwyvlRYrdhJ0F1OXUQYSEAZCS6UKsAYFwUS6CF1GiG9jvaBQfJHxI62Kd8BCghgXI
	eULWG7FJJNf7hkv6dGB3pPe4uRpCd+I=
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
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH v2 01/28] mm: memcontrol: remove dead code of checking
 parent memory cgroup
Message-ID: <qazzssy5v5qpyg3xdamruibcpcd3cry3yywicxvaeq66hejcn3@snvaivqo52sw>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <f96258f164779363fa894d3b278254e352e39088.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96258f164779363fa894d3b278254e352e39088.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:25PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Since the no-hierarchy mode has been deprecated after the commit:
> 
>   commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode").
> 
> As a result, parent_mem_cgroup() will not return NULL except when passing
> the root memcg, and the root memcg cannot be offline. Hence, it's safe to
> remove the check on the returned value of parent_mem_cgroup(). Remove the
> corresponding dead code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

