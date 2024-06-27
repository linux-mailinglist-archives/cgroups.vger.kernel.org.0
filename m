Return-Path: <cgroups+bounces-3420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2130891AF89
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 21:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB531F22A1D
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C2433AB;
	Thu, 27 Jun 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7D2CZnn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663482EAEA;
	Thu, 27 Jun 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515919; cv=none; b=K0Jj7MhIp9cS5xwhlO+en8DVV1Q50svIqc2ULvi2zjAybsZz/cZrCqPSdbrpJVfNlniiU810XlQIr5hJ0gG62HZYROKuaPhjmj7JFGSN0EcnFrnbme83IGhNROoWwuKez2ZJDt5A1WdPxyNoQGEb2aoWx/0slUWgay8hIp8usRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515919; c=relaxed/simple;
	bh=Mfh5H1CxCCBXkdkl0aIpRYEfHebAshsjVdelkLPdtrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3uiluQ9B64RxMgTOuFTwliHXAY2B8HKTGtnWcP4pH9ibZhh3gP9oWyqcpt1mlxuQHULlNeukINyWTqVDWTageDeeJc7wwdbVlVZz5cD0NwgzUr/+07v+34QLUi7WE/4TigejTrc4XgY7IPYu75dlivBpSCqswso0hBkVh7wszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7D2CZnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37201C2BBFC;
	Thu, 27 Jun 2024 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515919;
	bh=Mfh5H1CxCCBXkdkl0aIpRYEfHebAshsjVdelkLPdtrc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d7D2CZnn1vLpvysuU2ME7JBu80T75XHsBcmams9VD7htZCi+hF4Mlb+rWuP6PeuYd
	 nTEwmGb2/1RjYjY0YRwVKpzCimtihJdMevh3c1KaXTGRJtqXzBRK1DRXHWmphT2zqo
	 0GfS2REKDcoRTlppPMsv4t3Cwe9Q6cMQUsMyGZZtz8OA4EL2dfJ4+HvaVu8l2h8EsL
	 5S22obIng9rHhOS/10l92QiJbqB1FrtUWmimFlx5qxIfzpVX5A3fLF0KKc8j4z6a/v
	 5Fq8vPqrQ4P3NA3XINDnmcl3o4EBbn9goW1BVV8dTNn6QnDR4Q76sA0h9lXc6RjVB3
	 UW5qou2yLteHw==
Message-ID: <c3875745-dae6-4b79-8c4f-86b4d7147db9@kernel.org>
Date: Thu, 27 Jun 2024 21:18:35 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171943667611.1638606.4158229160024621051.stgit@firesoul>
 <171943668946.1638606.1320095353103578332.stgit@firesoul>
 <CAJD7tkbBpPqFW5fhmhcwDAfrze+aj8xFCF+3S4egBfipA4zKgQ@mail.gmail.com>
 <CAJD7tkYFKTA7aLcBE=X0jA1vKG_V+6Z-HstJRnnNrvMnjnLzHw@mail.gmail.com>
 <f4hbugpz5fudmiooxe73dbcbmi4stufm3msu4j37atv2feqhc6@ywai42srcwto>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <f4hbugpz5fudmiooxe73dbcbmi4stufm3msu4j37atv2feqhc6@ywai42srcwto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/06/2024 20.45, Shakeel Butt wrote:
> On Thu, Jun 27, 2024 at 04:32:03AM GMT, Yosry Ahmed wrote:
>> On Thu, Jun 27, 2024 at 3:33 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> [...]
>>>
>>> The reason why I suggested that the completion live in struct cgroup
>>> is because there is a chance here that the flush completes and another
>>> irrelevant flush starts between reading cgrp_rstat_ongoing_flusher and
>>> calling wait_for_completion_interruptible_timeout().
> 

I didn't add this per cgroup because I fear the race of adding a 
wait_for_completion on a cgroup that gets stuck there, but looking at 
the code the completion API should be able to avoid this.


> Yes this can happen if flusher for irrelevant cgroup calls
> reinit_completion() while the initial flusher was just about to call
> wait_for_completion_interruptible_timeout().
> 

Restoring two main functions to assist reviewer seeing the race:

On 26/06/2024 23.18, Jesper Dangaard Brouer wrote:
 > +#define MAX_WAIT	msecs_to_jiffies(100)
 > +/* Trylock helper that also checks for on ongoing flusher */
 > +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
 > +{
 > +retry:
 > +	bool locked = __cgroup_rstat_trylock(cgrp, -1);
 > +	if (!locked) {
 > +		struct cgroup *cgrp_ongoing;
 > +
 > +		/* Lock is contended, lets check if ongoing flusher is
 > +		 * taking care of this, if we are a descendant.
 > +		 */
 > +		cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
 > +		if (!cgrp_ongoing)
 > +			goto retry;
 > +

Long wait/race here, can cause us to see an out-dated cgrp_ongoing.
And then another CPU manage to reach reinit_completion() below, before
execution continues here.

 > +		if (cgroup_is_descendant(cgrp, cgrp_ongoing)) {
 > +			wait_for_completion_interruptible_timeout(
 > +				&cgrp_rstat_flusher_done, MAX_WAIT);
 > +
 > +			return false;
 > +		}
 > +		__cgroup_rstat_lock(cgrp, -1, false);
 > +	}
 > +	/* Obtained lock, record this cgrp as the ongoing flusher */
 > +	reinit_completion(&cgrp_rstat_flusher_done);
 > +	WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
 > +
 > +	return true; /* locked */
 > +}
 > +
 > +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
 > +{
 > +	WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
 > +	complete_all(&cgrp_rstat_flusher_done);
 > +	__cgroup_rstat_unlock(cgrp, -1);
 > +}


>>>
>>> This will cause the caller to wait for an irrelevant flush, which may
>>> be fine because today the caller would wait for the lock anyway. Just
>>> mentioning this in case you think this may happen enough to be a
>>> problem.

Yes, it would wait for an irrelevant flush.

>>
>> Actually, I think this can happen beyond the window I described above.
>> I think it's possible that a thread waits for the flush, then gets
>> woken up when complete_all() is called, but another flusher calls
>> reinit_completion() immediately. The woken up thread will observe
>> completion->done == 0 and go to sleep again.
> 
> I don't think it will go to sleep again as there is no retry.
> 
>>
>> I think most of these cases can be avoided if we make the completion
>> per cgroup. It is still possible to wait for more flushes than
>> necessary, but only if they are for the same cgroup.
> 
> Yeah, per-cgroup completion would avoid the problem of waiting for
> irrelevant flush.

Great, I will code up a version with per-cgroup completion.

--Jesper


