Return-Path: <cgroups+bounces-4252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F6F951B45
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477CA1C23444
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D951B012D;
	Wed, 14 Aug 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+QLheuc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75C142651;
	Wed, 14 Aug 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640263; cv=none; b=PpI0R9a1gSJ1Hx+Z7RGwg3/U64+PQvXDTlZqKnW/lshyEh+exjRcDzBMS1r9vz5psson92OfRuAToQAhP0sElniHn9x2ili4ESpahHbfX//HFauDu1c2LcwgRSeXUOxxYZqjE9THM2tLnxJV5r0TalNs4XZrvV3RhHRQUt1wTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640263; c=relaxed/simple;
	bh=aTyhtGtgdJk4Q5FCiryBiL3pR4RSq8FA/pjWp1jwZLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPx3j3I/QEBn3/GEf93N9x4oh4wE5HpncGIsBDL66lBTTVlcpwsSyLuF5NHvShGebN+5wMnYzFmewG+5XtpkrQeEFf05jZrF8NaIBZvrHNrV9UX0d1DMBqlrII6HBGPe64CmnLc3mZeti21KQcKFgzxAe4iqT2V7KtaoW70cCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+QLheuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD02C32786;
	Wed, 14 Aug 2024 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723640262;
	bh=aTyhtGtgdJk4Q5FCiryBiL3pR4RSq8FA/pjWp1jwZLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L+QLheucYpn6NXe5AWVMiKgJkvZl34jrpH1MUqNKt60ApPTUOl9bXD6RvwZ0eNMkP
	 3j7/3KcLedGn8TwWpNNaSe584n/PaST/63jUJ1cHPh1FNUMivaxYEjythm6ZoF43hU
	 qdIo5Dh1nsAl8b5xhTGeXPTVJp0oabFsyDK3mlW0uwvBxBemHLWfvpwREVTiCRSMyF
	 IstVAl9ggvLcBY5ZW1IIKJAG4MJoZWtYB5AlhV4k2o79t2GQ8yRDQQ8y57ry/g9e3J
	 NGM6l0WwLiAJMal052OcCDfkIfKXinbdJ9bTd5029Ht4ZWJL7KCWBpH8C8a7QBMVuQ
	 25tvTcoWy0q6w==
Message-ID: <edf4f619-8735-48a3-9607-d24c33c8e450@kernel.org>
Date: Wed, 14 Aug 2024 14:57:38 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Yu Zhao <yuzhao@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
 <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
 <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/08/2024 00.30, Shakeel Butt wrote:
> On Tue, Aug 13, 2024 at 02:58:51PM GMT, Yosry Ahmed wrote:
>> On Tue, Aug 13, 2024 at 2:54 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>
>>> The Meta prod is seeing large amount of stalls in memcg stats flush
>>> from the memcg reclaim code path. At the moment, this specific callsite
>>> is doing a synchronous memcg stats flush. The rstat flush is an
>>> expensive and time consuming operation, so concurrent relaimers will
>>> busywait on the lock potentially for a long time. Actually this issue is
>>> not unique to Meta and has been observed by Cloudflare [1] as well. For
>>> the Cloudflare case, the stalls were due to contention between kswapd
>>> threads running on their 8 numa node machines which does not make sense
>>> as rstat flush is global and flush from one kswapd thread should be
>>> sufficient for all. Simply replace the synchronous flush with the
>>> ratelimited one.
>>>
>>> One may raise a concern on potentially using 2 sec stale (at worst)
>>> stats for heuristics like desirable inactive:active ratio and preferring
>>> inactive file pages over anon pages but these specific heuristics do not
>>> require very precise stats and also are ignored under severe memory
>>> pressure.
>>>
>>> More specifically for this code path, the stats are needed for two
>>> specific heuristics:
>>>
>>> 1. Deactivate LRUs
>>> 2. Cache trim mode
>>>
>>> The deactivate LRUs heuristic is to maintain a desirable inactive:active
>>> ratio of the LRUs. The specific stats needed are WORKINGSET_ACTIVATE*
>>> and the hierarchical LRU size. The WORKINGSET_ACTIVATE* is needed to
>>> check if there is a refault since last snapshot and the LRU size are
>>> needed for the desirable ratio between inactive and active LRUs. See the
>>> table below on how the desirable ratio is calculated.
>>>
>>> /* total     target    max
>>>   * memory    ratio     inactive
>>>   * -------------------------------------
>>>   *   10MB       1         5MB
>>>   *  100MB       1        50MB
>>>   *    1GB       3       250MB
>>>   *   10GB      10       0.9GB
>>>   *  100GB      31         3GB
>>>   *    1TB     101        10GB
>>>   *   10TB     320        32GB
>>>   */
>>>
>>> The desirable ratio only changes at the boundary of 1 GiB, 10 GiB,
>>> 100 GiB, 1 TiB and 10 TiB. There is no need for the precise and accurate
>>> LRU size information to calculate this ratio. In addition, if
>>> deactivation is skipped for some LRU, the kernel will force deactive on
>>> the severe memory pressure situation.
>>>
>>> For the cache trim mode, inactive file LRU size is read and the kernel
>>> scales it down based on the reclaim iteration (file >> sc->priority) and
>>> only checks if it is zero or not. Again precise information is not
>>> needed.
>>>
>>> This patch has been running on Meta fleet for several months and we have
>>> not observed any issues. Please note that MGLRU is not impacted by this
>>> issue at all as it avoids rstat flushing completely.
>>>
>>> Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@kernel.org [1]
>>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>>
>> Just curious, does Jesper's patch help with this problem?
> 
> If you are asking if I have tested Jesper's patch in Meta's production
> then no, I have not tested it. Also I have not taken a look at the
> latest from Jesper as I was stuck in some other issues.
> 

I see this patch as a whac-a-mole approach.  But it should be applied as
a stopgap, because my patches are still not ready to be merged.

My patch is more generic, but *only* solves the rstat lock contention
part of the issue.  The remaining issue is that rstat is flushed too
often, which I address in my other patch[2] "cgroup/rstat: introduce
ratelimited rstat flushing".  In [2], I explicitly excluded memcg as
Shakeel's patch demonstrates memcg already have a ratelimit API specific
to memcg.

  [2] 
https://lore.kernel.org/all/171328990014.3930751.10674097155895405137.stgit@firesoul/

I suspect the next whac-a-mole will be the rstat flush for the slab code
that kswapd also activates via shrink_slab, that via
shrinker->count_objects() invoke count_shadow_nodes().

--Jesper

