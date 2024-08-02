Return-Path: <cgroups+bounces-4071-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ACB945D5A
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2024 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E623228181F
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2024 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFFB1E212B;
	Fri,  2 Aug 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG3YdIlH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01A1DB430;
	Fri,  2 Aug 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598996; cv=none; b=oD+HWTbp3elSilylI5RQFOuor1Gg2MOAI0oqPhwUH2C2ReNrfCRhfwyNmOEaUUAIdqu4AN4D4wgQ8itaa3fO7tKlbq3Z0ESE18qhn4RlUvSaKBN9JTRwuzR75X22+hWecW5Ohso8geSk27jXlJYFRx28iw/TARGTY9didxS1nRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598996; c=relaxed/simple;
	bh=WC8O4GJENSSswcFTCoObnQZlBeKC7T4XO63/D9YHEt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgmVbYlePsi0UPGB/Q6GlWUFzp9Kz3AeRg6Pos154ZPWaM2KzhEuCYmctOxrauHtXnWUwYaiH1/2X4JIV103csCCLYNmJ5XFuU6QP7cVgtBQNirgZOwJsZvGfTGxSW2faNGSEXufdgs5/gEmmhenq2Frv7rhE0USQ8v7WDk7jNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG3YdIlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB5EC32782;
	Fri,  2 Aug 2024 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722598995;
	bh=WC8O4GJENSSswcFTCoObnQZlBeKC7T4XO63/D9YHEt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JG3YdIlH3nAcFY7HrlMXy0Q2/YCo1T+FPoBQU6dqPwmOaOS0jCTWrwAO/ifAnb1SZ
	 NjBq799toE5scjJhxUPZ8MvXnrqtGAkRuxyrIx19LPkOrnsK50wgweSYoWFXiPCD1F
	 9qNPcxyqhcPt5OiMgyixcTOrqjvWhh6qSlTUJ1A2EqA9GoCLcArvaKBy2mdjlqqEBF
	 i87tRQUzh+P5LMnKP6XWywDapg1QeeIiOiOeiR8QUlUZanUmWDIsnaI22qYZqkXIkN
	 rTSqfShIZpHp36z4B0hosmuD+pvovQ3O2Pa3ez+DkXQxcfARKdSRs9w+/QgZ8LL79R
	 mXSuDajzgiRsQ==
Message-ID: <ee0f7d29-1385-4799-ab4b-6080ca7fd74b@kernel.org>
Date: Fri, 2 Aug 2024 13:43:11 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
 <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
 <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org>
 <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/07/2024 20.54, Yosry Ahmed wrote:
> [..]
>>
>> Well... I'm still not convinced that it makes sense to have level >= 2
>> be the ongoing flusher.
>>
>> E.g. if a level 2 cgroup becomes ongoing flusher, and kswapd starts 12
>> NUMA flushes at the same time, then the code will have these 12 kswapd
>> threads spin on the lock, until ongoing flusher finishes. That is likely
>> what happened above (for a level 1).  These 12 spinning (root) flushers
>> will not recheck ongoing_flusher and will all flush the root
>> (unnecessarily 11 times).
> 
> Hmm regardless of whether or not the level-2 cgroup becomes the
> ongoing flusher, the kswapd threads will all spin on the lock anyway
> since none of them can be the ongoing flusher until the level-2 cgroup
> finishes. Right?
> 
> Is the scenario you have in mind that the level-2 cgroup starts
> flushing at the same time as kswapd, so there is a race on who gets to
> be the ongoing flusher? In this case as well, whoever gets the lock
> will be the ongoing flusher anyway.
> 
> Not allowing whoever is holding the lock to be the ongoing flusher
> based on level is only useful when we can have multiple ongoing
> flushers (with lock yielding). Right?
> 
> Perhaps I am missing something here.
> 
>>
>> So, I don't think it is a good idea to have anything else that the root
>> as the ongoing flusher.
>>
>> Can you explain/convince me why having sub-cgroups as ongoing flusher is
>> an advantage?
> 
> I just don't see the benefit of the special casing here as I mentioned
> above. If I missed something please let me know.
>

I do think you missed something. Let me try to explain this in another 
way. (I hope my frustrations doesn't shine through).

The main purpose of the patch is/was to stop the thundering herd of 
kswapd thread flushing (root-cgrp) at exactly the same time, leading to 
lock contention. This happens all-the-time/constantly in production.

The first versions (where ongoing was limited to root/level=0) solved 
this 100%.  The patches that generalized this to be all levels can 
become ongoing flush, doesn't solve the problem any-longer!

I hope it is clear what fails. E.g. When a level>0 becomes ongoing 
flusher, and 12 kswapd simultaneously does a level=0/root-cgrp flush, 
then we have 12 CPU cores spinning on the rstat lock. (These 12 kswapd 
threads will all go-through completing the flush, as they do not 
discover/recheck that ongoing flush was previously became their own level).

I think we need to go back to only having root-cgroup as ongoing flusher.

--Jesper

