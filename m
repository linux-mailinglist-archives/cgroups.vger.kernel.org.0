Return-Path: <cgroups+bounces-12524-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 658B2CCE158
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 01:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F9F8304B95F
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31EF1A704B;
	Fri, 19 Dec 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="naB8jumT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D8134AB
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766104798; cv=none; b=W4VSQu4h81gEmvm9OfYGoyyYAatKp1e6CykX/A8V7SPhRoDbhLMPoTgG7/+k2hwn/gDn/bz74qS1wpgZZCIbYh+dpcLdNL4Uhzf0ZKQhSUeN3x5VzmBVr2pYQbwym7Xi1YnVy1W+gkABKzAf04aFRQA4vRLimORxTanHFzPQGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766104798; c=relaxed/simple;
	bh=zfQq7jVXXKhLNVCK7LtqscHtLVTL8DbyTjHc9EJ9GPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUjwIQKW1e4DzbJ1CgzfQMwi7SL7hd6BhKbLz7wGtsZy8fqX/53MqtdKbP0Cho0Er6cmM8cC6opJzZsUjNGfcpBFoMGo/yvrLIAWTMrH1cPX56+Mfimn6OvMX5Xc+Ty9DVu/L0enxa3wC2+ns/9wQSk96BNhh3ZY+R1fqEHhFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=naB8jumT; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 16:39:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766104789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DX8UZ9nAjSqZr1ylGrCQ7YdlWA+s06UqA90SNHMJ9o4=;
	b=naB8jumT44LZK8RrrvHQrofXxVtFDl6w0O38ksVxFmDDkt3uWkYR5RnXqq0O8aw+O6Po2a
	1KLukNm6ce93Yv0Imv09yBb6tljuVv+ORKra++jbAEfcpRek6Kc9BdW4HzHzTmEPaaGqj9
	NuApjAjaedRV17OClIdlSz7/dYgz2+c=
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
Subject: Re: [PATCH v2 07/28] mm: memcontrol: return root object cgroup for
 root memory cgroup
Message-ID: <rpr65jo6oa6aismuhkhimj5ne3gquvo7rpok5qnd5jif5iqbya@uar7qwaox7fc>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <3e454b151f3926dbd67d5df6dc2b129edd927101.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e454b151f3926dbd67d5df6dc2b129edd927101.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:31PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Memory cgroup functions such as get_mem_cgroup_from_folio() and
> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
> even for the root memory cgroup. In contrast, the situation for
> object cgroups has been different.
> 
> Previously, the root object cgroup couldn't be returned because
> it didn't exist. Now that a valid root object cgroup exists, for
> the sake of consistency, it's necessary to align the behavior of
> object-cgroup-related operations with that of memory cgroup APIs.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

