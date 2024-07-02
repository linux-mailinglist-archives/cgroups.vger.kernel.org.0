Return-Path: <cgroups+bounces-3491-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3093923B8B
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC6A28562D
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84E158A16;
	Tue,  2 Jul 2024 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvEjWGzS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B785C56;
	Tue,  2 Jul 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916516; cv=none; b=R1mMDc3EOrEvZpLTRgDgHLac6hSj+8d7P/Ukbs5q6tCQUzWBKHZKCeAOo3XB8Yz+cxKzWesOLo0i3hJO88UoyFEg/u5AENIn6bat2/imw1ynDOkAXU47Hjf+KsL7mWxMyAWXiELR1v6uwz5WCfmP+cXE+36Em5H78rHB0MMW9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916516; c=relaxed/simple;
	bh=PwVCJWNLKdS7OFxQ6pr4q5KnmpoFbEVa0L/2bGwEHGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YExjX1CMKZPl1soSd7ShzGRfoR8IULX1LevtJGCnkTulLedOWj7ZSPknt/w6zfJyWI/X9CNFKTXX0jy5wZbx8nMlqlSNgTXNUApK0tbpOMQ9FdCDGCdXoH16Xi1g6r6Q2/QEIWsvhRPYHF2QwcB86A/14NGK3Omm6pqRiz+1u6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvEjWGzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A920DC116B1;
	Tue,  2 Jul 2024 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719916515;
	bh=PwVCJWNLKdS7OFxQ6pr4q5KnmpoFbEVa0L/2bGwEHGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WvEjWGzS/5lH+NLwTbSUkCwF3MN44bZZg+IUc1t2g1+jqkPvCiJIXNkFT3oVybr/w
	 Tqrf9FI2c4m6OeXTTeH2ptQ/dDEcIZPI2EQXoze53OF2dO0H8SMvclyo9im3a7NuBI
	 SSB9WwkIzhjfCLvIPlKY3/V/U3KrdRpcyaHZmCvSsiZATB6UQWLEAMmmaaH/h6ifDV
	 ROt83lpNTKgT/YSfUEeAkGDPOEEW43iNdQq6YFuyCt4h0uC0fLC7nvO3qDYTttocBY
	 5ufh6bcJMIJIONgsUScXALOeKkFfumtWBh2dipBGo79jrmDAntjDkrEhHZFUooUNsi
	 s5qBofsbhAiEg==
Message-ID: <849e7b86-b971-47d7-8e31-7eee0918ea33@kernel.org>
Date: Tue, 2 Jul 2024 12:35:12 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
 <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org>
 <CAJD7tkaybPFoM697dtp0CiEJ2zmSYiH2+0yL+KG_LD=ZiscOJA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkaybPFoM697dtp0CiEJ2zmSYiH2+0yL+KG_LD=ZiscOJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/06/2024 00.15, Yosry Ahmed wrote:
> [..]
>>>> +    /* Obtained lock, record this cgrp as the ongoing flusher */
>>>> +    if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
>>>
>>> Can the above condition will ever be false?
>>>
>>
>> Yes, I think so, because I realized that cgroup_rstat_flush_locked() can
>> release/"yield" the lock.  Thus, other CPUs/threads have a chance to
>> call cgroup_rstat_flush, and try to become the "ongoing-flusher".
> 
> Right, there may actually be multiple ongoing flushers. I am now
> wondering if it would be better if we drop cgrp_rstat_ongoing_flusher
> completely, add a per-cgroup under_flush boolean/flag, and have the
> cgroup iterate its parents here to check if any of them is under_flush
> and wait for it instead.
> 
> Yes, we have to add parent iteration here, but I think it may be fine
> because the flush path is already expensive. This will allow us to
> detect if any ongoing flush is overlapping with us, not just the one
> that happened to update cgrp_rstat_ongoing_flusher first.
> 
> WDYT?

No, I don't think we should complicate the code to "support" multiple
ongoing flushers (there is no parallel execution of these). The lock
yielding cause the (I assume) unintended side-effect that multiple
ongoing flushers can exist.  We should work towards only having a single
ongoing flusher.

With the current kswapd rstat contention issue, yielding the lock in the
loop, creates the worst possible case of cache-line trashing, as these
kthreads run on 12 different NUMA nodes.

I'm working towards changing rstat lock to a mutex.  When doing so, we
should not yield the lock in the loop.  This will guarantee only having
a single ongoing flusher, and reduce cache-line trashing.

--Jesper

