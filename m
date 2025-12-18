Return-Path: <cgroups+bounces-12485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5184CCB0F2
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04281300BBB5
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354EC2E9730;
	Thu, 18 Dec 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh1ZAxfw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2E1E9B12;
	Thu, 18 Dec 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048652; cv=none; b=ugChJUkAxLf0rGqBGEuc4yA51izVht/P+hxhxZeYX11BOSMTu3W6hwbYdXAFeVAL+bU/u+e2cpSnroL61pXIpT5WD/PwX9uRCq2qvQ/wOgDgL9c/AN5jAGfQTYPj5IZzL0xT7qiUj3k5RlwSBImytwQkXfoGWkOIqjj+f4XjYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048652; c=relaxed/simple;
	bh=K7sTzImfm/ZlD+BwDyLC75278tg9lbuRtHhwrRkkXVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iisWe6PTXidmXbWzev+fmkmGd2L3KjLyJltEWin7Mma3CWV7ebcpUaMi2qyNr0svMaCRP9xvdQz8nejQ2JZ9RJTNjMLvxkYOcfgHZa0/EPIPw7535+TWG9nUbuYUqtnZ6d0pPHPlJZ3OdAkpnxISDxtifWvOGywa3tEPomwMZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh1ZAxfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB66C4CEFB;
	Thu, 18 Dec 2025 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766048650;
	bh=K7sTzImfm/ZlD+BwDyLC75278tg9lbuRtHhwrRkkXVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gh1ZAxfwbsO5kkKLAFARVWdAfKe/XY/yd5XTJu/i3WKX+vCgqYh99HDC0JLqwiryE
	 3SqpGL8wPV595zKDmSfDUKlAylJ1gYl3qIo9Q2cHiAYU/YaAlgERnnzV8r1ZYIJTHT
	 qkdTB8fmsnFJ5pSfb8qIHJcCiLsASoEsc9ko5Ep6HFZScBEa+X4g0huhx4bHsLCdiE
	 t/zpwKTewKWtI+ND88OhKI3ZqeW0IRc1ZGesJBB1lXj+TeDIBV6htkCmmBGa6hbNGY
	 yyIuJm24mTGl+PmGqAAhfYuiuw4cyxzl2IVTuf9ZmoTQOppob5abO3OKFcTB95aRIZ
	 pj7jntYOGr3TA==
Message-ID: <87e59cd3-a554-4911-aaca-21be2080e2c6@kernel.org>
Date: Thu, 18 Dec 2025 10:04:03 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/28] mm: vmscan: prepare for the refactoring the
 move_folios_to_lru()
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 08:27, Qi Zheng wrote:
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

The patch description is a bit confusing for me.

I assume you mean something like

"Once we refactor move_folios_to_lru(), its callers will no longer have 
to hold the lruvec lock; disabling IRQs is then only required for 
__count_vm_events() and __mod_node_page_state().

To prepare for that, let's $YOURDETAILSHERE"

-- 
Cheers

David

