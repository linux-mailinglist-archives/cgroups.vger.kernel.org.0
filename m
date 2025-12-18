Return-Path: <cgroups+bounces-12521-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8148CCDFE9
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA876304DEEC
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF529E113;
	Thu, 18 Dec 2025 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1oXmx3O"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCC1531C8;
	Thu, 18 Dec 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766101160; cv=none; b=uUYtgRWYQh4PVKEVca1xIcIKrccMTkVN4EnKWE3Spx9AA1M8k1k7wszF/qI5T+iso462F7Mn9dq1l7/IT6Vwr4kJbqg8959Uf0ZEupC69cY8k1mOQhZbcOmRwbPFx4Z82VyyYrMhsM+WEWpV4MJvLwMNvrHFTCne2XMykXJS5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766101160; c=relaxed/simple;
	bh=nqAIujc/v2jmX4j+0eop9dqmY6LCRXvmuao7GptxPXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf2aKqdC2qv478nNZvDo8KWEwX+YgSl+JWynusE031JbzeS4MAQrgqc/C3KQ6p48rtQdp1z503VV8BWm3FKH6QIdBcckuGbzYvecSB0ED0MgWRkMFyzV8GYfMZr1hfUSjIUtMe8Qu1aBVTOpuIZ52bvRndXp3pd8NqQ9DgZ8JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1oXmx3O; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 15:39:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766101151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6CkT2RsOi/M5LFRuOsJlToUIGbnJ3gyuSS5jGiR0BU=;
	b=X1oXmx3O15V+dVt0RbBo6pG1IMyg7ztn3Lv6fY3552mlFV2Qwan7UM9z149Md4RCfUnJUg
	9u4TdsdTByH/1nKtmbfNi5m4EvtF4/Om9a8TV8d+YTp/X+DN048WWFGmFPXEd9rSkoJU6/
	MpOBs9M2wjg9ZlbhDiIsCQv3vH1t5OE=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 04/28] mm: vmscan: prepare for the refactoring the
 move_folios_to_lru()
Message-ID: <ujk7ths3jerzngbbm34xmzpv63osdk6pgnsvpl2q3qbxo4sbpd@a7pxeekhknbs>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:28PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> After refactoring the move_folios_to_lru(), its caller no longer needs to
> hold the lruvec lock, the disabling IRQ is only for __count_vm_events()
> and __mod_node_page_state().
> 
> On the PREEMPT_RT kernel, the local_irq_disable() cannot be used. To
> avoid using local_irq_disable() and reduce the critical section of
> disabling IRQ, make all callers of move_folios_to_lru() use IRQ-safed
> count_vm_events() and mod_node_page_state().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

