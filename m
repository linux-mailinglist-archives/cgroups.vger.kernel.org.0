Return-Path: <cgroups+bounces-14832-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGwdNjzOt2mDVgEAu9opvQ
	(envelope-from <cgroups+bounces-14832-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 10:32:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409122970F6
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 10:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA0E5300EA93
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523737B409;
	Mon, 16 Mar 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="fUn/RqjJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CF25228D
	for <cgroups@vger.kernel.org>; Mon, 16 Mar 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653503; cv=none; b=heduXmDWWOryDrGJQjjr0AS/nY195luANuy7K+VmKngm9itbEOWq4PvNCfdv37I1tjTyJ0J8VxIDVX0owYpDbwI7aa7bI2Erez8sHgr1q705laDpKz3qTaSptH9XjxbvtAwwoSaIGwn0zp+EalFyk+ZZTVVtVtrDIjvNB4j9IRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653503; c=relaxed/simple;
	bh=bbUxPQ1mj4Nf3Fw4S+JgxMAUPWq/3GQAOXF2ZVXbd04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxRhjy7uSVLqdFrZr9Ye0O3jL2K5YcwM995PS8QaAxsslkwZ7UOuzUKJzZCEsxJjrkqfWoQSJR1sfgEsoMNyILEYSqJxbgp5NcaA8dceHDHDLaVQJuTngysV+fFdlSJXd0iiiuc0SLaCfYA4OUFdB06rJUjzhjLzmoRD4EHdyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=fUn/RqjJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso1645735e9.3
        for <cgroups@vger.kernel.org>; Mon, 16 Mar 2026 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1773653500; x=1774258300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+j0v98M3c9Yt88UPpiN3BaLxthOV1CMBTj730pi0KW0=;
        b=fUn/RqjJi6B5Vua3OGOcIogBAoujUhbgp8ZyvQHG5DQ5++tq52hCR6gIi0opQJe04F
         Ft6NoyhBRmNTkqaUGnEQWctcrRSfGse7fvFzGwOttH8a2V+nAB7PzDp8DY4pmpFsaLMK
         +Lurdv6HgdM2bkWaljywWQla8SOfmdWL2nGASTZ9G1y2SH4mEyNe4HUJ51I6yUIrPylt
         1j0lpQZGtxcRxcpIqC5Ndc7w4/YTa9cXXHobdzPKNdj1bUDNc8OgKVgIAOtnn+flmUkm
         o5YKPDOkcgA5p96+rJwqCrGFVI2WSmXSQYj5u/VyzitbAiF5uAKxqyWKpJSeFjjJTIKn
         J88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653500; x=1774258300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+j0v98M3c9Yt88UPpiN3BaLxthOV1CMBTj730pi0KW0=;
        b=WLXVe5rlaCtpNRKc4G4lTU5qmACwX7PrOc793IgGUEc3AfxK8hn7iBAHsHgPkPuwug
         hUq+8e9uuEYg3bW+/thWue0ZAMcfVYApZ/lx5kQJQaNS/ygRYaykhkk5Yh0wJlqVM8lZ
         59Uu/Uai7K8xoCAvGnQj6FKRAbc4dwWcQVrHwDtSlWjqYBjRX8DKtcLG6BMpOO2HNHp4
         8VjmAQ0jWIs2C4akDpqIVNUHVS7M9PQICqn6vN3ueBpJvpEPP2k0X2n8Y640FwH/n0Y6
         vwIyZ8ji+wMXdxdeMLSUPcJUtVsxWxGQ53mgyowRC8WhEurQw846mmjCNx4tmXJO9uYC
         cpjg==
X-Gm-Message-State: AOJu0YxmGS87QMxWQxTg8PTRe8ThKqz8a3rXpc2grS3hquuKidyeW4aq
	jZ5BwGNF+QLi5yC/ZcrVL7yZuhr1Zsi4CNtc4GdwKralCJjfjQz6c6552kZBWPBoN60=
X-Gm-Gg: ATEYQzxyHzDeZ2v7nMkulfL8SF1qOwdPnPWclbSEMdBZ60MkA0giG3AjQKTxORp9n79
	z79eLlr3VJJQAN0IqZOa//+G8tVaSkYbf+5IDkIoylmSrjU9El6L59qHMlTxBx4fibGpakD5HIr
	VCfAn3yyX9jXa4f0XlCbUXPnr1XweDBrTrjDw6aclYv7CIQF6G49M2jDkI54+af8J2kDm8ySpiE
	1zu/7p698GilyiywwdapexIui+DJWHFxFLAyTUdFSGgUfDwW+CTMIZk61zhBkp5eoyM2j15Qwpo
	PW3IFeJ9uNFb+4X6KeyXzS1ol81NXecS03nb6eoAODRTZmB+gS4PT2z+XyH1Y3ChPGRtm+/miOn
	9Mm8q6SRiNt8T49RU9t7wfm8/sHua1rvjD7bQ3gFabM8utCeGQLUSxKeQ/wedWvHAw9+8AmeCvp
	6+GE9UlyuCLCivU+N5I3rPYv0BxU3r6gKke+neuZYMF4y7
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-485566ca967mr198323625e9.3.1773653499446;
        Mon, 16 Mar 2026 02:31:39 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm871878505e9.10.2026.03.16.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:31:39 -0700 (PDT)
Message-ID: <a965580a-568a-4d68-a2ad-53c962ec06b9@ursulin.net>
Date: Mon, 16 Mar 2026 09:31:38 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
 <cf522bc4-09ef-4e19-afc4-2c8a9d8a1abc@ursulin.net>
 <792705f1-e50e-48f8-ae06-95b6da0bb0f1@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <792705f1-e50e-48f8-ae06-95b6da0bb0f1@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14832-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ursulin.net];
	FREEMAIL_TO(0.00)[gmx.de,lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ursulin.net:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tursulin@ursulin.net,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ursulin.net:dkim,ursulin.net:mid]
X-Rspamd-Queue-Id: 409122970F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 16/03/2026 09:05, Natalie Vock wrote:
> On 3/13/26 15:11, Tvrtko Ursulin wrote:
>>
>> On 13/03/2026 11:40, Natalie Vock wrote:
>>> When checking whether to skip certain buffers because they're protected
>>> by dmem.low, we're checking the effective protection of the evictee's
>>> cgroup, but depending on how the evictor's cgroup relates to the
>>> evictee's, the semantics of effective protection values change.
>>>
>>> When testing against cgroups from different subtrees, page_counter's
>>> recursive protection propagates memory protection afforded to a parent
>>> down to the child cgroups, even if the children were not explicitly
>>> protected. This prevents cgroups whose parents were afforded no
>>> protection from stealing memory from cgroups whose parents were afforded
>>> more protection, without users having to explicitly propagate this
>>> protection.
>>>
>>> However, if we always calculate protection from the root cgroup, this
>>> breaks prioritization of sibling cgroups: If one cgroup was explicitly
>>> protected and its siblings were not, the protected cgroup should get
>>> higher priority, i.e. the protected cgroup should be able to steal from
>>> unprotected siblings. This only works if we restrict the protection
>>> calculation to the subtree shared by evictor and evictee.
>>>
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_bo.c | 43 +++++++++++++++++++++++++++++++++ 
>>> + ++++++---
>>>   1 file changed, 40 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>> index 7300b91b77dd3..df4f4633a3a53 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -628,11 +628,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk 
>>> *walk, struct ttm_buffer_object *
>>>   {
>>>       struct ttm_bo_evict_walk *evict_walk =
>>>           container_of(walk, typeof(*evict_walk), walk);
>>> +    struct dmem_cgroup_pool_state *limit_pool, *ancestor = NULL;
>>> +    bool evict_valuable;
>>>       s64 lret;
>>> -    if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state- 
>>> >limit_pool,
>>> -                          bo->resource->css, evict_walk->try_low,
>>> -                          &evict_walk->hit_low))
>>> +    /*
>>> +     * If may_try_low is not set, then we're trying to evict 
>>> unprotected
>>> +     * buffers in favor of a protected allocation for charge_pool. 
>>> Explicitly skip
>>> +     * buffers belonging to the same cgroup here - that cgroup is 
>>> definitely protected,
>>> +     * even though dmem_cgroup_state_evict_valuable would allow the 
>>> eviction because a
>>> +     * cgroup is always allowed to evict from itself even if it is 
>>> protected.
>>> +     */
>>> +    if (!evict_walk->alloc_state->may_try_low &&
>>> +            bo->resource->css == evict_walk->alloc_state->charge_pool)
>>> +        return 0;
>>
>> Hm.. should this hunk go into the previous patch?
> 
> Hm. Maybe, I can move it there in a v7.

Do you see it as logically belonging to 5/6, or not?

>>> +
>>> +    limit_pool = evict_walk->alloc_state->limit_pool;
>>> +    /*
>>> +     * If there is no explicit limit pool, find the root of the 
>>> shared subtree between
>>> +     * evictor and evictee. This is important so that recursive 
>>> protection rules can
>>> +     * apply properly: Recursive protection distributes cgroup 
>>> protection afforded
>>> +     * to a parent cgroup but not used explicitly by a child cgroup 
>>> between all child
>>> +     * cgroups (see docs of effective_protection in mm/ 
>>> page_counter.c). However, when
>>> +     * direct siblings compete for memory, siblings that were 
>>> explicitly protected
>>> +     * should get prioritized over siblings that weren't. This only 
>>> happens correctly
>>> +     * when the root of the shared subtree is passed to
>>> +     * dmem_cgroup_state_evict_valuable. Otherwise, the effective- 
>>> protection
>>> +     * calculation cannot distinguish direct siblings from unrelated 
>>> subtrees and the
>>> +     * calculated protection ends up wrong.
>>> +     */
>>> +    if (!limit_pool) {
>>> +        ancestor = dmem_cgroup_get_common_ancestor(bo->resource->css,
>>> +                               evict_walk->alloc_state->charge_pool);
>>> +        limit_pool = ancestor;
>>> +    }
>>> +
>>> +    evict_valuable = dmem_cgroup_state_evict_valuable(limit_pool, 
>>> bo- >resource->css,
>>> +                              evict_walk->try_low,
>>> +                              &evict_walk->hit_low);
>>> +    if (ancestor)
>>> +        dmem_cgroup_pool_state_put(ancestor);
>>> +
>>> +    if (!evict_valuable)
>>
>> This part is probably better reviewed by someone more familiar with 
>> the dmem controller. One question I have though is whether this patch 
>> is independent from the rest of the series or it really makes sense 
>> for it to be last?
> 
> It depends on patch 2/6 (cgroup,cgroup/dmem: Add 
> (dmem_)cgroup_common_ancestor helper). I could potentially reorder it, 
> though then there's likely going to be quite a few rebase conflicts.

I will not insist on it, ordering is probably not that critical in this 
case. It just looked to me the added condition is an independent fix 
from the charge accounting and unprotected eviction changes. Up to you 
for what I am concerned at least.

Regards,

Tvrtko

