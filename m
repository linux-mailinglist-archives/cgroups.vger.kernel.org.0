Return-Path: <cgroups+bounces-3566-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E692A598
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082311F21873
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5871411E7;
	Mon,  8 Jul 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFTDBjFU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DAA76035;
	Mon,  8 Jul 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452408; cv=none; b=JTm2YeBjZ5OCh5xdmLmGGDeL0gurj9EBEspsx81wuNaMzapuqj6GkRjwWrj6wk9Jkkt/GfyDIrxYqqe6j9xNNUNJazHInjiG4+30dLxYKQTeOMgbz4Vv83KFkwiXEXfAyWbmJqBRfMz+ptEZfCNJDWXn73b13ULEucOBLcX9Ndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452408; c=relaxed/simple;
	bh=cjsprHnjp5XNdWf8EStlLIvj8tCDoS/WMOdakGDpGjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FoFGKAhZtYXRKS7dtvRu4MehaA+p2URCaRqumaa8SNqlLMuh79jXbKvT3UAcZzcpFY0NhS5t8PPTZ7F1a51Tvqq10aOWnbMWWdM8oGtrmOKS2QGXP57FcQbqQlm+km/QMW1mptA5x9KvV4+wV9SHBmqG3ddNtF9uKYNszEd5Us8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFTDBjFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86E7C116B1;
	Mon,  8 Jul 2024 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452407;
	bh=cjsprHnjp5XNdWf8EStlLIvj8tCDoS/WMOdakGDpGjQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UFTDBjFUIPjatPoSN6tTKvG49TYK5WSHWkE0aUx1HmML6OYv2xpDhfINMaaGi8A6O
	 ljJd5IR7M+FwCnZf/NSOAsDnp08L/bQHG4ethTQia8mpITFcN2Lv/sGb3ltKjIB4dQ
	 aApEV+sEJmqn6Mz8SkKwZIA/kf6y92ZvNU3PWuH33QXbitQu43G72/ZDynPmse30fJ
	 pAiY/qIREXjZxF4R9hjK3Uc0/kiYjWG7Eopo2BQd1wv0YRE31eK0Bvq9EoT140la/Z
	 6NKCVwQZTSfAQtnVFQNg0YqVmEV2q5xp4zJmRHFXkrLqrH6x3n/SvJQjOAwtQTssOQ
	 5/keIjNZ2aENw==
Message-ID: <9a7930b9-dec0-418c-8475-5a7e18b3ec68@kernel.org>
Date: Mon, 8 Jul 2024 17:26:44 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
 <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org>
Content-Language: en-US
In-Reply-To: <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 28/06/2024 11.39, Jesper Dangaard Brouer wrote:
> 
> 
> On 28/06/2024 01.34, Shakeel Butt wrote:
>> On Thu, Jun 27, 2024 at 11:18:56PM GMT, Jesper Dangaard Brouer wrote:
>>> Avoid lock contention on the global cgroup rstat lock caused by kswapd
>>> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
>>> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
>>> call inlined in shrink_node, which takes the rstat lock.
>>>
[...]
>>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>>> @@ -312,6 +315,45 @@ static inline void __cgroup_rstat_unlock(struct 
>>> cgroup *cgrp, int cpu_in_loop)
>>>       spin_unlock_irq(&cgroup_rstat_lock);
>>>   }
>>> +#define MAX_WAIT    msecs_to_jiffies(100)
>>> +/* Trylock helper that also checks for on ongoing flusher */
>>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
>>> +{
>>> +    bool locked = __cgroup_rstat_trylock(cgrp, -1);
>>> +    if (!locked) {
>>> +        struct cgroup *cgrp_ongoing;
>>> +
>>> +        /* Lock is contended, lets check if ongoing flusher is already
>>> +         * taking care of this, if we are a descendant.
>>> +         */
>>> +        cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>>> +        if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoing)) {
>>
>> I wonder if READ_ONCE() and cgroup_is_descendant() needs to happen
>> within in rcu section. On a preemptable kernel, let's say we got
>> preempted in between them, the flusher was unrelated and got freed
>> before we get the CPU. In that case we are accessing freed memory.
>>
> 
> I have to think about this some more.
> 

I don't think this is necessary. We are now waiting (for completion) and 
not skipping flush, because as part of take down function 
cgroup_rstat_exit() is called, which will call cgroup_rstat_flush().


  void cgroup_rstat_exit(struct cgroup *cgrp)
  {
	int cpu;
	cgroup_rstat_flush(cgrp);


>>> +            wait_for_completion_interruptible_timeout(
>>> +                &cgrp_ongoing->flush_done, MAX_WAIT);
>>> +
>>> +            return false;
>>> +        }
>>> +        __cgroup_rstat_lock(cgrp, -1, false);
>>> +    }
>>> +    /* Obtained lock, record this cgrp as the ongoing flusher */
>>> +    if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {

