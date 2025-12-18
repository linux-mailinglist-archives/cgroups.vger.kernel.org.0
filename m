Return-Path: <cgroups+bounces-12488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA13CCB2EA
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03FF630198E8
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6110330B09;
	Thu, 18 Dec 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+/deaOu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6C33031A
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050281; cv=none; b=HnPVaJzkUT8r4T012zxuzvNahFbGwM9vfNUqdcvPXLLQs8C+be2b47lVnU7qCxP9ab2YdO2Vd4H7+PKHp4Y7mLiJB+xQHxVm1tn+Dr5qRpAmX4WyQIHfS8KZEnFZnWsubuGYxyNtVfgUaj+qMNa5Pr8uUJp3xiU88OdgLCs4mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050281; c=relaxed/simple;
	bh=4HaRnivfFwE2XEnanQcRxWs3h2kw1W+0/U9uvONt6PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgU2+qGyCI3QgKsVFiuUxIHv57owKOkLbSl6I9PRYqVmpKK3JWXa4vMP4xuylqFAW6wKG8CqREcM6cRdVe4rLLqgj2Sm2YeZ1nnEr3DlNR0b/qN06SN31mW/UOWcDjrqiAgabWgqih6jGyUTlw97XpRv7DZc6TORXgg4zk+korg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+/deaOu; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d9592ea-988c-4c97-b059-a58afb05b3f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766050276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mEjU8wX83Cg3o+9Hcgc6XPzGswLeHLk0tmhTdtZzxA=;
	b=w+/deaOukBWJ4ZgZ3I1WlhHxaGiV/8cdmYNowXHEEUM+0aRZQcIlLFeoPi5rQoMl+cjSJo
	m9T+bhiZ1Q8ktwvjUNQ3J9w0OH/psy86bJ93ChPyG30NihzHHvBY9JO3496dt85GKI/p1v
	m+C9Zwyx5GyP3/toJ6v/5zimaZ/y0j0=
Date: Thu, 18 Dec 2025 17:31:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 04/28] mm: vmscan: prepare for the refactoring the
 move_folios_to_lru()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
 <87e59cd3-a554-4911-aaca-21be2080e2c6@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <87e59cd3-a554-4911-aaca-21be2080e2c6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 5:04 PM, David Hildenbrand (Red Hat) wrote:
> On 12/17/25 08:27, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> After refactoring the move_folios_to_lru(), its caller no longer needs to
>> hold the lruvec lock, the disabling IRQ is only for __count_vm_events()
>> and __mod_node_page_state().
>>
>> On the PREEMPT_RT kernel, the local_irq_disable() cannot be used. To
>> avoid using local_irq_disable() and reduce the critical section of
>> disabling IRQ, make all callers of move_folios_to_lru() use IRQ-safed
>> count_vm_events() and mod_node_page_state().
> 
> The patch description is a bit confusing for me.
> 
> I assume you mean something like
> 
> "Once we refactor move_folios_to_lru(), its callers will no longer have 
> to hold the lruvec lock; disabling IRQs is then only required for 
> __count_vm_events() and __mod_node_page_state().
> 
> To prepare for that, let's $YOURDETAILSHERE"

It is indeed clearer, will do in the next version.

> 


