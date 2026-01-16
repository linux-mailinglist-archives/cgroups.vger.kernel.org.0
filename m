Return-Path: <cgroups+bounces-13274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3ED2E9F3
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 10:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1078030940C4
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A533EB00;
	Fri, 16 Jan 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y3YrR11v"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441313385BF
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554992; cv=none; b=GQ8YfsoC5Ca1czbUOevioLVBFeu2HG+LAezQo2GZGeWgPB9SpPDtdOpTlyJhHqcjvYxs1q2G21Qm9Mcxk4Den5zrbZlxIp6DCCt6Q1mfaE9Eru1yoWhnjUJnKSXIFPtvKoYZHwW4+NQFRpQofiWFzQr4p5cITmBbZj+jRlbMXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554992; c=relaxed/simple;
	bh=tyVnyFdw8GFDm8mYaetzSzCtVF509qPA89uxagrCNpg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FqNgv7O56HbQdKXYx/ysMPO46YVmbSdvOmt64nG2Z/fnUTIfwyLRrrxfuNEMJF4WdepdBaOyS4lGuH8IHVeoPqj/4+2MoLhGBZGg7pV/JiwBnXQyA5pmZ6otLWdCTOa0QklSdI2uikiNp3DlHJnVm/Q2tpM4xTlJycL9d8W3HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y3YrR11v; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768554988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRwIZX0eq636l25pXbeUZgFScnTLhuS/E1INCedyBdQ=;
	b=Y3YrR11vlRLyyN8aX4FMxfR6XpZJN0u+0pACJMy8KXfCAbF+fMnATJBFlWsW5/yYC66+le
	sK5Y10w067jdW3fmjGACqdp110vNAsgFE7KZ4sDW5pim22kEuZLZjBB8ljPM4A8YhSPXAh
	5oLQoorRJ4IA4N4z3kIeF5s620d0IRk=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 17/30] mm: thp: prevent memory cgroup release in
 folio_split_queue_lock{_irqsave}()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <061b1110696ba51e454ad0f7549603ec92cdb5ea.1768389889.git.zhengqi.arch@bytedance.com>
Date: Fri, 16 Jan 2026 17:15:36 +0800
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
Message-Id: <394C2721-72AF-44AE-9953-C7C6DCFC8038@linux.dev>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <061b1110696ba51e454ad0f7549603ec92cdb5ea.1768389889.git.zhengqi.arch@bytedance.com>
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
> the release of the memory cgroup in folio_split_queue_lock{_irqsave}().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>



