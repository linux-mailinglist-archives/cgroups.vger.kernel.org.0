Return-Path: <cgroups+bounces-16929-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kkuwIm1nL2o2/wQAu9opvQ
	(envelope-from <cgroups+bounces-16929-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:46:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27805682ED1
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:46:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Jag6rI1F;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16929-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16929-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 954F63001D59
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 02:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA523C4FF;
	Mon, 15 Jun 2026 02:46:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB71339B1
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491560; cv=none; b=c3Mx/tjM/2b8MZIJZpzdRpAJetXgw0gJabTX5u/9dDoNGceSf7ojQjpAKCxmmIhemjQAAqURHIZ2j0lETaBMx+It0fiws/ZuAEmlRzyA1DSRt32hYnDuS84Z1rOnLvihvP3VZ93pAs5ld7vwjKRowT2UxtxCnBEFPulrDkDwtgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491560; c=relaxed/simple;
	bh=aR4W3BEIH8IzDqlwprPAbjrY4D4yzLAM0ofXLYgoDYs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gw0BnZ3uc1e0IwfVYIg3mzttIEP8SinWu17Ll+XXilJw+oHQ2AtJY7of5Cviomro9fWcVQLV+yxYoC2I5w0oI44P6SaPfIfszBBp1S25iTyxHhPd99wzBEnlRb/I6gTvkzx4Z63cXemUGPbARbcFYv4m5Zhub2X6BWRj0jsoAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jag6rI1F; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f869421so2211528b3a.3
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 19:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781491559; x=1782096359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8NLHGVjFApYnrN7TuvQPcE5946BfMaA9XvCk6482m8=;
        b=Jag6rI1FMUqPi5tSLDwGSR6NxRdjU+vayODZsRp0rQ3m1EApo+64kJLcIGGhO8XDpy
         FtPdzyOsJTJHkguVvLw5D+DKeuuRInNpzO6Ypj/a6wGADl6kIJy08JE9/Dof+KOwDlAf
         nc8hdtZGmzlZ1VJf/0d7sLDvhONy09yOa9TgWpm6QJa+S4W5dTYVYvi1zVPw0fjZFYoL
         6m0b2KReYsgGxpjNzz1VcDS6S+RVeFciMph+ISAgmQmcaVYOyht/qjM2a52BqoPNvoiJ
         tTsn4lgdsljYSTAMk/iZZJ6buuDFA0hh7gvEQdAm9vVld9lMKMIwJ2QBqyqEiOz7yHcg
         ZEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781491559; x=1782096359;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8NLHGVjFApYnrN7TuvQPcE5946BfMaA9XvCk6482m8=;
        b=F7GmfgBbEMYQIilHMBU3bZcHI70iNZhka5Z+vGjB222kDr8pYKDQ1oCFBbktUaVU1Y
         dpNII99UoKnsJME6z3k3jeJAk3+GZMv+Evpsn7WloM4gfNAmCUPRubjiMHlm789wF98O
         TUXY3gvrCl/0rECq+qtgh471ipzGjTYZy+n7RPQBhnTxXcjOqvGYh4bzVMfmr/re1tb7
         Ivkio2rLMpYSLHGpGT/aV/bIZi57DrQySxe9fQbVY/Kid8HO9wwzw3wfkrWxS0UIH6bl
         TE99gL2S0jclPdLjg3Qu9X9uA0SVgRD50Q5/3zS/0qUJFQoD0/bJK2VZTt21mdhcGVN3
         oYxw==
X-Forwarded-Encrypted: i=1; AFNElJ+GMidqvtNI0KiIwitueuLA2JTVQCNBIqSnRaKJTS+Ex3lfi6bTG1wyovXrQHHECQm8qiv+oxYY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0yG3lTSTY7rn5hAn4U65MXnw0FTWSO/3wQDjmLlomeiQ2fdRC
	0cMwUeVyhsEBXTutXA4NDJ8uYWttmZpmbVfrvJ7JXIsyGGIK8ASKwLs3
X-Gm-Gg: Acq92OF7WJmPwJQlje+mhRty9xHEYDrdb9v++scQySYZiJUeXpklVpqvJsiGaEyUdl1
	ecF3SAR/hb6uy9m09tdQHnN0oAmHEaVr/c2pUQdWeyZe6FxYQRas5yPb8+1agjpe/iwaO+zsUCh
	NkFdE9aIHw6bKmjnpquVyOxaJeZTmY7oQm8sVmEtW2FdduzB469E83rn/hW7wHdFoOt6R+m7QHh
	pl2nFeSRZkXmMX00Qm89p14ScoAeKVoN+hGLlyRGCX90uXTxA6EBglIRgrmXbAHpRVjUuOuetWn
	FYWw6wowEi5MWRkzDbSfvQisz+uGpzt8QwkeX2blTRUqay9NuKnXr3lc6+7gSk6JA+aFFLN7xRU
	m1piDcqxXft1teq03A4d5vcNFeafs/dtVS23z6kP5Q+p6LDRSIDg0cRPYyT58lnaaxvxIf6abKy
	MqWA31NdEbMsVgZ4ete3e53FKGIqIEmnQZswJdNi8U07eUEwPPFw==
X-Received: by 2002:a05:6a00:400b:b0:83a:3135:edbd with SMTP id d2e1a72fcca58-844e1931335mr9663347b3a.7.1781491558659;
        Sun, 14 Jun 2026 19:45:58 -0700 (PDT)
Received: from [10.125.192.102] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm8343847b3a.59.2026.06.14.19.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 19:45:58 -0700 (PDT)
Message-ID: <128c28a1-71b5-d435-fb1a-9882c23727ca@gmail.com>
Date: Mon, 15 Jun 2026 10:45:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
From: Hao Jia <jiahao.kernel@gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
To: Yosry Ahmed <yosry@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org,
 hannes@cmpxchg.org, mhocko@kernel.org, mkoutny@suse.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
 <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
 <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com>
 <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
 <CAO9r8zN6VVZz7dpjNrh8n7wbLkqcrsROPm70MQQxO49HJSmMFw@mail.gmail.com>
 <CAKEwX=MCFbsh9ndBtR0-bGRr_=v-6bBwTo=muzd9ZSD-LAK1nQ@mail.gmail.com>
 <1c25650e-bf98-2863-d505-9b94c385668b@gmail.com>
 <airypNnKrJJ54k_0@google.com> <aiw2JB1lZV9xuNSp@linux.dev>
 <CAO9r8zM=CMtUfV0RX3YyztqMNcw=s8M3WX6Q0epR5YHUvwTTKw@mail.gmail.com>
In-Reply-To: <CAO9r8zM=CMtUfV0RX3YyztqMNcw=s8M3WX6Q0epR5YHUvwTTKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16929-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:shakeel.butt@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,suse.com,linux.dev,vger.kernel.org,kvack.org,lixiang.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27805682ED1



On 2026/6/13 02:15, Yosry Ahmed wrote:
> On Fri, Jun 12, 2026 at 9:40 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Thu, Jun 11, 2026 at 05:39:16PM +0000, Yosry Ahmed wrote:
>>> On Tue, Jun 09, 2026 at 11:18:26AM +0800, Hao Jia wrote:
>>>>
>>>>
>>>> On 2026/6/9 02:01, Nhat Pham wrote:
>>>>> On Mon, Jun 8, 2026 at 9:48 AM Yosry Ahmed <yosry@kernel.org> wrote:
>>>>>>
>>>>>>> But OTOH, this does seem like a recipe for inefficient reclaim. We
>>>>>>> might exhaust hotter memory of a cgroup while sparing colder memory of
>>>>>>> another cgroup... But maybe if they're all cold anyway, then who
>>>>>>> cares, and eventually you'll get to the cold stuff of other child?
>>>>>>
>>>>>> Forgot to respond to this part, the unfairness is limited to the batch
>>>>>> size per-invocation, so it should be fine as long as you don't divide
>>>>>> the amount over 100 iterations for some reason. Also yes, all memory
>>>>>> in zswap is cold, the relative coldness is not that important (e.g.
>>>>>> compared to relative coldness during reclaim).
>>>>>
>>>>> Ok then yeah, I think we should shelve per-memcg cursor for the next
>>>>> version. Down the line, if we have more data that unfairness is an
>>>>> issue, we can always fix it. One step at a time :)
>>>>
>>>> Thanks a lot to Yosry, Nhat, and Shakeel for the great suggestions!
>>>>
>>>> Let me summarize what I plan to do in the next version to make sure we are
>>>> on the same page:
>>>>
>>>>   - Drop the per-memcg cursor and keep the root cgroup cursor
>>>> (zswap_next_shrink) logic intact.
>>>>   - Stick to using the zswap_writeback_only key, and change the proactive
>>>> writeback size to use the compressed size.
>>>>   - Consolidate and reuse the logic between shrink_worker() and
>>>> shrink_memcg(). Enable batch writeback in the shrink_worker() path, while
>>>> keeping the writeback behavior in the zswap_store() path unchanged.
>>>>
>>>> Please let me know if I missed or misunderstood anything. Thanks again for
>>>> clearing things up!
>>>
>>> Sorry for the late response, yes I think this makes sense. However, I
>>> have some comment about how this interacts with swap tiering, let me
>>> reply to the other thread.
>>>
>>
>> I think the swap tiers interaction will be figured out over next cycle. However
>> Hao can/should continue to push and we may decide to let it in orthogonal to
>> swap tiers.
> 
> Yeah I think there are a lot of changes we discussed outside of the
> memcg interface, so maybe keep the interface as-is for now, work on a
> new version with the other changes, and we can finalize the interface
> at the end?

Okay, I will split the non-memcg interface parts into a few separate 
patches. These will serve as the preparation work for proactive 
writeback and enable batch writeback in the shrink_worker() path.

However, I will still send the complete patchset using the 
zswap_writeback_only key approach in the next version. This should make 
it easier to review whether the preparation logic is reasonable, and to 
decide whether it should eventually be merged independently of the swap 
tiers.

Thanks,
Hao

