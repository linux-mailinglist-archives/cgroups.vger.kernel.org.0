Return-Path: <cgroups+bounces-16563-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IT4tLmPBHmraUgAAu9opvQ
	(envelope-from <cgroups+bounces-16563-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 13:41:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C362D9E2
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 13:41:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iJJPWGDi;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16563-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16563-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858A43040AB5
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39158353EF7;
	Tue,  2 Jun 2026 11:32:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22903DB315
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 11:32:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399973; cv=none; b=VmzkueAJ03gkFf0WIwM7Ql3N8/vy7zni6CU++ke3Y1OIZqtvrLs7XKbbChTrZlp+UXzh/6+TLyzB11YDQsobvc6iSjuygArljuHkR0xgJmr8kuGlPQ9JMsBCck5m4nUxI2At71C91K6qGnVaeufHjYeI93C+lQCoRa+3XSOSrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399973; c=relaxed/simple;
	bh=hsJj1CfMkHXWpn91odTR8H0K9jbzOaukZllClpaQHTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZu8U+NiHac6j9QCcB78f96u/BtDiO6revkNXKV388iMUYtpoZvo0iZoViVNMQSxD24/TmfoWPgNThioUPGDdTLxMp6lUp9qu7ikrw/9YgKEBttYrj0400+nzvnWOIEZ2fZExgeIttpUEIF2o8MeW+ungSeKvP/yrW951yUX7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJJPWGDi; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso1355475b3a.3
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780399968; x=1781004768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWu0sre5Jwby9OB3KDM9noNXPSopPTpmyBRZ89OmKZ8=;
        b=iJJPWGDikjv1pMhRoMGhTYrdyT2dF5iEZwfIgORf2kdzrrpNZozpKmGaco8YsfqRA6
         KWDKVj1o6e8DvGK7RHxXV/Fbenzje4m1drhAUltR6IBS+hh0fRcva67ju4E3mo8eiN7y
         uh4aToVcjKEAOKhDA9KaZmjVy8JQ9RPvX5LoxSOb577CNggawaLUHar7ovQpgb479fHE
         hxilwtGsSlhitpwlMLBJY7/oW3AW5bh6vEb3iNpqLCtMywFIe5/MTEw/d8GuQCOfaLLT
         COeZCD4Y8cWQm00d5ZjExWmHUYcgeU6eCdEl9TofxxSrozLl/nt4dNasD8ejc5B1SP0q
         xRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399968; x=1781004768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWu0sre5Jwby9OB3KDM9noNXPSopPTpmyBRZ89OmKZ8=;
        b=PwotmJ2eW3jvajZtHhqg68IYd3Q0NBiw6vpBqQYife/EN0GI+56KkaYpwgP/BDZiHf
         hEQZNreMKon6WM8FodLoCo0fnVVnxEUAgAw0yT9im0DsCQnPhvTmr1iUsppZTuDfXtNo
         n4GJJ+rfu4BZeF4Bdl7OwsbHb5yFr0gXAKF4oF55CtBPdYE2iwYpSnBZM0dWnnvn4GhN
         noIRMOVoU2fYIfJrr4opUa0GmTOoPk1ykhj1VcZs5D953lBezRMhYAmbiBhnf9QXBI1+
         LQzcHo7FoBjjgoJFHweQr8WI5jKDtfy6cxlgsjWpiqPDZ4ucpe8s4YnGow+4l812dwAq
         8lVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n6hbNBxN+UvUxfU6VECaLlQ8wwgfX9sUTc6pogqyodvRqEOli9BGFn6l1o5sl+4PeR+jsGgEW@vger.kernel.org
X-Gm-Message-State: AOJu0YzfX4wwUkZeQ6htmKzMvt7sMvabrMHBjg2CTUwjeUCBjyrRsleY
	eI+Xs/lT2C/9dnTSNx//jBpqi6sLzAp4J9PtXNqVO/nWy0ni7aRzgyt2
X-Gm-Gg: Acq92OGsCQi5nascvPtZrCK4efLm4U0LSmE1ZpyxCCWXBTdalc7zZ1xoNRdrOIk96ie
	Jq4YhO+sCKviYGvE4qy0PbM5sAHGyfzzjIHV9xO8b+b2JowLF5eNdkK7M0W9WX8NntI0Gmm5M3f
	2p7DNC2jvrQ+CGLqmBM4LD+kCherLHKE3D7qgA56GrLGsaT+YaocS1NgdleumgBP0dPojHeBKY1
	tDbChYeah9txG8UD7AedHqIEGhJDinLx4a1eeiCInGj7PhWN41m4JZVmLAysoEx2jEFIndXTWBf
	4hUBjBu46vMrrmuI13AqRpqGNCFEhppLUVxKBuwdbem5cjwM99B1lTyIM0l9Q3/wKT7IqC+mjzv
	gSJXQWzssMJdWrrKnPutyNLKzu8YD+9KWZWGKb+PBUIFxIm7Y4IyLF5fsRv+MsHXQL/gBIFxtJA
	1OXx2PDLQRChLjXSeMjUevljsaBZ8Y6hk4dbhocLYOFdpv4YdcMN4ehw==
X-Received: by 2002:a05:6a00:2389:b0:842:37d3:de21 with SMTP id d2e1a72fcca58-84237d3de5amr11841016b3a.40.1780399967742;
        Tue, 02 Jun 2026 04:32:47 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423dc9f361sm8310801b3a.24.2026.06.02.04.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 04:32:47 -0700 (PDT)
Message-ID: <22473c1e-8448-fc18-e454-7bfb38e89561@gmail.com>
Date: Tue, 2 Jun 2026 19:32:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, tj@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
 <CAKEwX=NoQNXOMDD0uTSOPWHQX-CMNU1dw=zEuFj=eLcS3fB-ow@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=NoQNXOMDD0uTSOPWHQX-CMNU1dw=zEuFj=eLcS3fB-ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16563-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lixiang.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 100C362D9E2



On 2026/6/2 01:08, Nhat Pham wrote:
> On Mon, Jun 1, 2026 at 4:07 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>>
>>
>> On 2026/5/30 09:24, Yosry Ahmed wrote:
>>> On Tue, May 26, 2026 at 07:45:58PM +0800, Hao Jia wrote:
>>>> From: Hao Jia <jiahao1@lixiang.com>
>>>>
>>>> The zswap background writeback worker shrink_worker() uses a global
>>>> cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-robin
>>>> across the online memcgs under root_mem_cgroup.
>>>>
>>>> Proactive writeback also wants a similar per-memcg cursor that is
>>>> scoped to the specified memcg, so that repeated invocations against
>>>> the same memcg make forward progress across its descendant memcgs
>>>> instead of restarting from the first child memcg each time.
>>>
>>> Is this a problem in practice?
>>>
>>> Is the concern the overhead of scanning memcgs repeatedly, or lack of
>>> fairness? I wonder if we should just do writeback in batches from all
>>> memcgs, similar to how reclaim does it, then evaluate at the end if we
>>> need to start over?
>>>
>>
>> Not using a per-cgroup cursor will cause issues for "repeated
>> small-budget calls" cases. For example, repeatedly triggering a 2MB
>> writeback might result in only writing back pages from the first few
>> child memcgs every time. In the worst-case scenario (where the writeback
>> amount is less than WB_BATCH), it might only ever write back from the
>> first child memcg.
>>
>> Similar to how memory reclaim uses mem_cgroup_iter() (via struct
>> mem_cgroup_reclaim_iter) and the old shrink_worker() used
>> zswap_next_shrink, we need a shared cursor here.
> 
> I think each proactive reclaim invocation just walk the entire subtree
> for page reclaim right (see shrink_node_memcgs())? Would that be
> acceptable for you?

Our current approach is very similar to how proactive memory reclaim 
works in shrink_node_memcgs().
shrink_node_memcgs() first calls memcg = mem_cgroup_iter(target_memcg, 
NULL, partial);. By doing this, it uses 
target_memcg->nodeinfo[nid]->iter->position to retrieve the child memcg 
where the last reclaim left off, and then resumes the iteration.

The catch is that zswap can't just reuse 
memcg->nodeinfo[nid]->iter->position, as that would mess up the cursor 
used by the memory reclaim.


> 
> I also wonder if we can at least make this structure dynamically
> allocated... In a system, you only really invoke proactive reclaim
> against a few target cgroups, no?

It is possible to allocate it dynamically, but I am concerned that it 
might introduce a slight performance overhead. We would need to add a 
**check** like if (READ_ONCE(memcg->zswap_wb_iter)) every time 
zswap_mem_cgroup_iter() is called. Furthermore, to handle concurrent 
allocations, we might also need to introduce cmpxchg() to resolve race 
conditions.

The additional code would look something like this:

static struct zswap_wb_iter *get_zswap_wb_iter(struct mem_cgroup *memcg)
{
     struct zswap_wb_iter *iter, *new_iter;

     iter = READ_ONCE(memcg->zswap_wb_iter);
     if (likely(iter))
         return iter;

     new_iter = kzalloc(sizeof(*new_iter), GFP_KERNEL);
     if (!new_iter)
         return NULL;
     spin_lock_init(&new_iter->lock);

     if (cmpxchg(&memcg->zswap_wb_iter, NULL, new_iter) != NULL) {
         /* Lost the race, someone else installed first. */
         kfree(new_iter);
     }
     return READ_ONCE(memcg->zswap_wb_iter);
}

Thanks,
Hao

