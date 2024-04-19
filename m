Return-Path: <cgroups+bounces-2614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321C8AACA4
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DA61C215B8
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3E7BB19;
	Fri, 19 Apr 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNIPxI5H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4434745EF;
	Fri, 19 Apr 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521816; cv=none; b=PTQbxDatjWDJnmFsXDXcwBAE51EwuPyUbaHjru51lP60NPJ/ANR8K85buPaaeqG1/PEaXN24rdgrK94oAg0YOIoGw6c+RsWUgfkx78NyHAq9qjXNnCRdcZaNGgl7h7ogN4bJVwqTHSgqaZlifM74TfQgIsewAsaQFaG9LKkkBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521816; c=relaxed/simple;
	bh=aC+QA5rjhgsuTqn2kdyip+wg1YmdpSU1U1t0y/JyVB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBEx+dtWFV8eTC2KaPcn+c36V/AZx7bQ2D9qhqkX5TMxEPRhevYPfZSQ1Chs2B/VD8qrbQLpf51NiJvHwCA8qeTxTNPNpM+0su3ow4F5i4WOkZFWJuss/9eUwAiQDZYfU4bi9z8rkV7qqxYKOAbl/SlGxQPGURg2kO/z/6g5zdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNIPxI5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E1AC072AA;
	Fri, 19 Apr 2024 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521816;
	bh=aC+QA5rjhgsuTqn2kdyip+wg1YmdpSU1U1t0y/JyVB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tNIPxI5HOVILSTXuczGUDtJGoDhmBpJGSxMEqBFvHNc2zXK33PEiKk4HM+8mTjKo/
	 bu1QPvghvyq31zosBe16/stXNcEqYWg5NdaCyQQ+0r0jpOYs1k0v8NDfk93oso4wyk
	 3jIMkkHrA7DgSmPunJ14oE0XNCHPHd0btuepG1tf77WZG83xIcjHaeL1Gzdw/tFMp1
	 Dau3NJVvA9W6sTlorR3yNNq/IyMUo29+AmiNyDXYRERCMv0FSe56YLuG2ErpFVxtuG
	 o8+arByas5NQ5ha1eVk7zFPlQHUct8n2jtqpmfHIuwRBE2lZiVWcAn6bP2VSZQrscQ
	 qR9DgG4w1BvVg==
Message-ID: <33295077-e969-427a-badb-3e29698f5cfb@kernel.org>
Date: Fri, 19 Apr 2024 12:16:52 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org,
 Wei Xu <weixugc@google.com>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
 <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
 <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18/04/2024 23.00, Yosry Ahmed wrote:
> On Thu, Apr 18, 2024 at 4:00 AM Jesper Dangaard Brouer<hawk@kernel.org>  wrote:
>> On 18/04/2024 04.21, Yosry Ahmed wrote:
>>> On Tue, Apr 16, 2024 at 10:51 AM Jesper Dangaard Brouer<hawk@kernel.org>  wrote:
>>>> This patch aims to reduce userspace-triggered pressure on the global
>>>> cgroup_rstat_lock by introducing a mechanism to limit how often reading
>>>> stat files causes cgroup rstat flushing.
>>>>
[...]

> Taking a step back, I think this series is trying to address two
> issues in one go: interrupt handling latency and lock contention.

Yes, patch 2 and 3 are essentially independent and address two different 
aspects.

> While both are related because reducing flushing reduces irq
> disablement, I think it would be better if we can fix that issue
> separately with a more fundamental solution (e.g. using a mutex or
> dropping the lock at each CPU boundary).
> 
> After that, we can more clearly evaluate the lock contention problem
> with data purely about flushing latency, without taking into
> consideration the irq handling problem.
> 
> Does this make sense to you?

Yes, make sense.

So, you are suggesting we start with the mutex change? (patch 2)
(which still needs some adjustments/tuning)

This make sense to me, as there are likely many solutions to reducing
the pressure on the lock.

With the tracepoint patch in-place, I/we can measure the pressure on the
lock, and I plan to do this across our CF fleet.  Then we can slowly
work on improving lock contention and evaluate this on our fleets.

--Jesper
p.s.
Setting expectations:
  - Going on vacation today, so will resume work after 29th April.

