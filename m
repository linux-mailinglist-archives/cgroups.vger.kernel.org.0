Return-Path: <cgroups+bounces-13275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB52D2EAD8
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 10:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6B1300E795
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500512E1758;
	Fri, 16 Jan 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tjdo9qjv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F7345CAF
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555167; cv=none; b=C2G8Hrq63zCNdPDlJQyPKxiCow7eCK8vcoKN7LNmJV6wOc/L9CRosvLZS/Lp8qgmGly8D+M/asssg9skiGxtMVKb/Jdsyp/cPeUmDUBav1r33XfgnDoIs/RAfuRFdU2NXtIIcxBYGNxBggq5Z9gLOOupD+p8foctvjqgIJTZwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555167; c=relaxed/simple;
	bh=r4fBhFb0tGH/vamI7QiLXeUGMpSfIJE7JupsViH8vjI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=opfn84fq9+Vlr2Gr94N8Kv9KC5CSENRfCU6kfR1fiRAjed5TJTT88msANXgfWu26tBzrZjZYXEbm7g7/CSA3S8o4o8C/6Jg0EsNr2szODIinLS31yofvF6ZYrL35AFCPzsgslxagdsIN9twXXcVwNz3zLT3yIOUgQqlIR1cghyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tjdo9qjv; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768555153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXuUSWKmDb91gc+pCaKfgPo7v9igVSa8mgzQJr7mqZ0=;
	b=Tjdo9qjv4nbnRggvBlfTo4iCjKhhyopfmT6r+E9ka6pIQLEFxcX+5m+rQOgPZ3AW+K7Zyt
	dyBNG2c+9l1V7U2sbthxgjh/qwT5EzyvLD7xzJCoPSGpdWEGN5VVVJqjCa2lM8GOoIGn71
	YyJHqRRHnKsz68I0TKilPJf08I/jcQw=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 18/30] mm: zswap: prevent memory cgroup release in
 zswap_compress()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <592f65bbe05587c01a2718443a70e639cc611f3d.1768389889.git.zhengqi.arch@bytedance.com>
Date: Fri, 16 Jan 2026 17:18:16 +0800
Cc: hannes@cmpxchg.org,
 hughd@google.com,
 mhocko@suse.com,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 david@kernel.org,
 lorenzo.stoakes@oracle.com,
 ziy@nvidia.com,
 harry.yoo@oracle.com,
 yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com,
 axelrasmussen@google.com,
 yuanchu@google.com,
 weixugc@google.com,
 chenridong@huaweicloud.com,
 mkoutny@suse.com,
 akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com,
 lance.yang@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Content-Transfer-Encoding: 7bit
Message-Id: <0924D73A-5DE4-464D-B606-B0187C72EB96@linux.dev>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <592f65bbe05587c01a2718443a70e639cc611f3d.1768389889.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 14, 2026, at 19:32, Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding memory
> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> lock or acquire a reference to the memory cgroup returned by
> folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard against
> the release of the memory cgroup in zswap_compress().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Muchun Song <muchun.song@linux.dev>



