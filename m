Return-Path: <cgroups+bounces-2824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA78BE501
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0302F28977D
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EF15ECE5;
	Tue,  7 May 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4/5Kf26"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28415EFA2
	for <cgroups@vger.kernel.org>; Tue,  7 May 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090371; cv=none; b=nK1JUM1yb2uOXInF3VYLYPF5A3gtl4fHDKiZsCbMXO+s7gd86mBlwqPBGoZH2OS0IeD4VItRYCn5zchkJEGNCSSGUBd+4dIrFC9F7cpzuhGdHWO0SLbAtc08SiORKvNW2LYff8eAJyAxtgqnOgrlU0Wyp1VWIFg3je3l2176pVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090371; c=relaxed/simple;
	bh=H+0Ypsw0j6unIQYeRMtbsRKdx9TEn+kSRDNj91ZjtV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFjJl+eh65oNjU8n/GVX4N/xZNQ5vsMqNmi1L9kh8nO+n6WZLflauHgaIqq8BCPT2wRNHZygUVQivgDvG1SYCfuvHLQqZquD4jqniyZF3qSiqf6GxyPerSTAop1E/Zk46LhbadsjuV7Jb3n1gF57KNG8MpU2iwoCNix7WdDoYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4/5Kf26; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 06:59:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715090365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5mTNRe4LMZAhS4pUCYAVz2ek9U2ALsnFQIig+p2+qg=;
	b=w4/5Kf26tT3UzHWq+DJj0YASUMNXid3U6M0LUF9SBZrWflJ55cZCRHCoWEHBN0Qz6Ct9At
	KGvidyYUNrvpt0c62rXi60jUGHfXEMJjSuPJ8Hm0kOB5fYaJngokaybEzcsqeA23Q37sEg
	lXMueCQqzHk8AyLgwkGV2eOPM3nqZ0Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next] mm: memcg: make
 alloc_mem_cgroup_per_node_info() return bool
Message-ID: <2bvwvb2w2z7hpoagdeus6gpuwmx26xber7tgkp7rxrq4uuttzm@bnl4x2rve3zu>
References: <20240507132324.1158510-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507132324.1158510-1-xiujianfeng@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 07, 2024 at 01:23:24PM +0000, Xiu Jianfeng wrote:
> alloc_mem_cgroup_per_node_info() returns int that doesn't map to any
> errno error code. The only existing caller doesn't really need an error
> code so change the the function to return bool (true on success) because
> this is slightly less confusing and more consistent with the other code.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

