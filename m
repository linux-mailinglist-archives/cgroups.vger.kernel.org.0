Return-Path: <cgroups+bounces-16085-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFcgI7V8DGoSiQUAu9opvQ
	(envelope-from <cgroups+bounces-16085-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:07:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E875811B2
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7D9530667BD
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A821637AA64;
	Tue, 19 May 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geXqvDvc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E03546FE;
	Tue, 19 May 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202821; cv=none; b=PhUa9N0ssmCawL+SjvxGhQibPHf4ymbikjPWsH+OnnGIZuZyny53+LYwSy3Jd5I3Xvp6EBpUvsyGpdJm7JRAVLwpLQB5x4igo9qGTJPkM7TSCj2G0EvhZe4FiPhL4FSYfjjaS3PbEa4QtjlVsQPZAiAoLe2yVWpG9akr9gC+ylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202821; c=relaxed/simple;
	bh=+vafbmR6P35W1uPb6vJ+4sthJQy6Z+LMEd69JGdKiKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGrUg9c8lo94wVYRwtsVvVCpTUEX7vXCf5KD773eL+ThT8jQ8pYdrS7R+WZ+cNYltuVauNxMk5zEaBliswyslkulCzjv9Q673IsSY0wGC1+JyNCpe7LjjGQE0zQP3K4GMZG42wBlcqeWjPFzuwlwm55iA40zKTWa/Fl/crxu7c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geXqvDvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CFFC2BCB3;
	Tue, 19 May 2026 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202821;
	bh=+vafbmR6P35W1uPb6vJ+4sthJQy6Z+LMEd69JGdKiKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=geXqvDvc1oWGQxvj2TsovQelBq2ywdFPQQyYsBI1gbg/54JH5yOlGnKHwpy7p9vkF
	 TdCxavWRyTcebE5FHmsC80cTvkB7WwU1i1KqXF1pVjXN/REheRLvXKNAqxxmZS4aac
	 Bxo7kUGhPNOoeu+TazCiFDcAlYpEswO1jkxsCxE+LvNEU9Y1QBO5p6bdeCCobUkxJA
	 qPGi/Y2+/SWGU5ENPe5NohU0O/B87AVeJUS1WOh9hdeBWIgaW4u5/xrOwSV6WXlPjo
	 KfkGyMw6/yK5w6c4CNRqXDLyu6pW1F//hGETczuAbuppSVtbsihiso2Q/JjGEfgSTP
	 J4aW7D6RB2LGw==
Message-ID: <ca8e655d-5fe7-4957-8a36-6667616be8b6@kernel.org>
Date: Wed, 20 May 2026 00:00:16 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: cache obj_stock by memcg, not by objcg pointer
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260518222827.110696-1-shakeel.butt@linux.dev>
 <aguiSnY3ie1y4nEl@linux.dev>
 <4e296262-fbbf-4ac7-aecc-3ef831583704@kernel.org>
 <agxszIIN6FtK0fEb@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <agxszIIN6FtK0fEb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16085-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 33E875811B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/19/26 11:02 PM, Shakeel Butt wrote:
> On Tue, May 19, 2026 at 03:46:51PM +0900, Harry Yoo wrote:
>>
>>
>> On 5/19/26 8:41 AM, Shakeel Butt wrote:
>>> On Mon, May 18, 2026 at 03:28:27PM -0700, Shakeel Butt wrote:
>>>> Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
>>>> per-node type") split a memcg's single obj_cgroup into one per NUMA
>>>> node, but the per-CPU obj_stock_pcp still keys cached_objcg by
>>>> pointer. Cross-NUMA workloads now see a drain on every refill and a
>>>> miss on every consume that targets a sibling per-node objcg of the
>>>> same memcg, producing the 67.7% stress-ng switch-mq regression
>>>> reported by LKP.
>>>>
>>>> stock->nr_bytes are fungible across per-node objcgs of one memcg.
>>>> Treat the cache as keyed by memcg in __consume_obj_stock() and
>>>> __refill_obj_stock() so siblings share the reserve. Compare via
>>>> READ_ONCE(objcg->memcg) directly: pointer-compare only, no deref, so
>>>> the rcu_read_lock contract on obj_cgroup_memcg() does not apply.
>>>>
>>>> Sharing the reserve without re-caching means bytes funded by one
>>>> per-node objcg's slow path can be consumed/freed under a different
>>>> sibling, leaving sub-page residue on whichever sibling was cached at
>>>> drain time. The pre-existing obj_cgroup_release() path would WARN and
>>>> silently drop that residue, leaking up to nr_node_ids * (PAGE_SIZE - 1)
>>>> bytes per memcg lifecycle from the page_counter. Forward the residue
>>>> into a per-node objcg of the same (post-reparent) memcg at release time
>>>> instead, so it can be reconciled later via a refill atomic_xchg or
>>>> another release; the chain terminates at root_mem_cgroup, whose
>>>> page_counter has no enforced limit.
>>>>
>>>> Please note that this is temporary fix and will be reverted when
>>>> per-node kmem accounting is introduced.
>>
>> ... because once per-node kmem accounting is introduced,
>> "stock->nr_bytes are fungible across per-node objcgs of one memcg"
>> no longer holds?
> 
> Yes
> 
>>
>> And the follow-up plain is to revert this and address it with a multi-objcg
>> percpu stock [1], similar to a multi-memcg percpu charge cache we have now,
>> right? (regardless of per-node kmem accounting's progress)
>>
> 
> Yes

Thanks for confirming!

>> If this temporary fix imposes other potential correctness issues, would it
>> make sense to land [1] in mainline before the next LTS release and skip this
>> temporary fix?
>>
>> [1] https://lore.kernel.org/oe-lkp/agtPMpQK2jXdQAY4@linux.dev
>>
> 
> The full clean solution might take one more cycle and I think we can not just
> ignore 67% regression on 7.1.

That is valid point, unfortunately.

One more thing I have to ask... for v7.1, wouldn't it be a safer option 
to revert the per-node object change and re-introduce it once we have a 
cleaner solution?

This change was introduced in v5, but the implementation before v4 had 
been exposed in -next for a while, and I think we don't have enough 
justification to keep the per-node objcgs change, at least for v7.1, 
given that we have an unexpected last-minute regression and
correctness concerns (albeit slight).

-- 
Cheers,
Harry / Hyeonggon


