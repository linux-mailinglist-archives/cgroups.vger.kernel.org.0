Return-Path: <cgroups+bounces-13273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A22D2E947
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 10:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C4D300E781
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01B31D739;
	Fri, 16 Jan 2026 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cevXBDWB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598E31D36B
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554873; cv=none; b=lUrT6hXcPSNjd/rDQNFgLMykKcK0dhyqv2rWkAbdWyNi20PStFCH8T7Bb9DVDKfRa/rsEZzlLL+GUvv0cb5pSxCzNmVMCFGXLRNSBRdjOa7qL1Pjxp+gtkxHWAh6PodWe/BEYlCidrLt2iezsAIyTz4/B7rcgDg7DZGNx8+aEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554873; c=relaxed/simple;
	bh=y4hOuvyJeRvqSmDKLMZFhyVt1NZIvHJLp249HXeBrF8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=svWZJ5Ia+1SbTCfZrnwE/q58Zvk0WWrzttJsjW098WDH48AU6mXbAKV5C6PxujUCuk5NGUYm9QxBRdFvucsbI1zhRHlAJQ6eIDeYdv4Bz389unIKqXG34qf1f3F723ZqxuA6GcQpcSrmu0ZkadtymtzrOJ1oJbrEpZrLbi4KId8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cevXBDWB; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768554869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF0itXi5419rm4LJFbIRbe8CXIn7csZfmAPobL5TwmE=;
	b=cevXBDWBGZtwpQX0uRsWsByXI/bV7/Hpg+kCW8fnJaWNApAiMl5KVCDEN/W2ndn4UcIalz
	Lp1xm3CLvjZ4uzDR8knkxBZ3gV3lNJ9ZopjWMjoSc68YF2DD21DQ/Swxq4ls2SJXko6vSL
	LcCPbyGRYSRIq8IE5ekzxZ4d6oQp3Os=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 04/30] mm: vmscan: prepare for the refactoring the
 move_folios_to_lru()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <65187d0371e692e52f14ed7b80cf95e8f15d7a7d.1768389889.git.zhengqi.arch@bytedance.com>
Date: Fri, 16 Jan 2026 17:14:10 +0800
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
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Chen Ridong <chenridong@huawei.com>
Content-Transfer-Encoding: 7bit
Message-Id: <897EC629-8E32-436A-B829-AB7D1A291C61@linux.dev>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <65187d0371e692e52f14ed7b80cf95e8f15d7a7d.1768389889.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 14, 2026, at 19:26, Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Once we refactor move_folios_to_lru(), its callers will no longer have to
> hold the lruvec lock; For shrink_inactive_list(), shrink_active_list() and
> evict_folios(), IRQ disabling is only needed for __count_vm_events() and
> __mod_node_page_state().
> 
> To avoid using local_irq_disable() on the PREEMPT_RT kernel, let's make
> all callers of move_folios_to_lru() use IRQ-safed count_vm_events() and
> mod_node_page_state().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Muchun Song <muchun.song@linux.dev>


