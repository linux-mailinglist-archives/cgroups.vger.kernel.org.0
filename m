Return-Path: <cgroups+bounces-15839-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDGqGNfzAmrpywEAu9opvQ
	(envelope-from <cgroups+bounces-15839-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:33:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7451DCBB
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B194300E166
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15539A047;
	Tue, 12 May 2026 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzgZEhAK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8B4A33F1
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578371; cv=none; b=nZVqnlc+dnwXyfSt7y9y3ZS44uNu6s5G+K1Xd1JwqpbGrvUa5EbsUA6dn7b1Wmh6aSCvyYXFhYJ3YcTlmJBzfeus3dui6pTjIVQw/YwerqN0niR9U8Vyl3ugNaWw2FC15TkfVCmIKS8WgmXxtc73YhaUarUJAHBB+Fi/n+ogG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578371; c=relaxed/simple;
	bh=qTCm4e0SDhDs36LOqJFzDbvP5Osv9iHCn/M3glWmsfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljHBjZh4MXzcOABlyrjA87pslAk7kl/c88ZaO9+BzE15+BV9pCmvG88h6HUCN7Y6NFdwFtACP4xB6l9bsrAJ5flQA+fWQwYH2+6il7UiGSSqD5b0bESFtQojULGO0RN+MKbLdmPMs9zHL700lU4UuQzbF7cTVsjLlrwQYwT4m60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzgZEhAK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba6485d219so34258065ad.3
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578369; x=1779183169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G6+bx80FRHpgHi4yg0luQJohBPaG8COWz9arYdTBtw=;
        b=WzgZEhAKlp2IfpXWQqZjmSzf3m24/YZSQZC2Oe1KwBs9/FLrL0REYj9vEGxoZ911jP
         cKLc16W2EqMT/Bct4YcDaqQrSKIqdCIdBRBAXVEzOKAYzqIR7T/obW6ZmSEgAH4bhrlc
         BHEdKCVmlxE+96GDq8aZ8A1AV+tZZvyQJCPkbP1QdDXEN69RanD/5+yvl8V+CLYE0dqu
         tkHpgCMd7nlHmw0jUDH/mPZUjVCC32Soe5Z+T0yTuRVuYVisYl7yRFnu++EuYu+aUNZw
         jLZ0EfRMwl50b3ZMJcyoVy+bJC6Bzkaa0n+STCIvUbg9yR2CQ/2/VLI8DGqRyolH+0bu
         b5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578369; x=1779183169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5G6+bx80FRHpgHi4yg0luQJohBPaG8COWz9arYdTBtw=;
        b=n72yZSrGThmdyubHL5Y6ZG/tlheepOVQxGr/uJnYJrk7dp8BP5iKd4KlDXm/Di5Ks1
         wBWTGUq5BuxtNAL8VhNawXWdbjnKdH2SXIJjMdGT08JfIrCUxZjR4me+gwL/FZOVUrw/
         f+/q4TM3wiY5sEwFDatWngxwNEnnQQDYV7BHZIN1y77ftpmHJBP9r/ch6w7dDiBqpUUg
         T2LuCCY0sIy2tLB5b02EncO+P6SJu6sd7ap6FO4y7tv4Ot6L3PWPCbCAuOVg3Xjpm3ko
         bkx/8L5CEHLmVT3CT2tH2DXLC11b00TDyVs7qRGG3nzHse6C8t/P4YAZuNCx3YImq05n
         JHuA==
X-Forwarded-Encrypted: i=1; AFNElJ8vk8e217839DCQEgV9lFvIZZtpqql10LlqAIXvHwcBwh+Fnef4MVlyzaBrTAJaUEKezDiSTdj2@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMlap3YEW7ZAIJed9mgUCntI2eSX6HsObIfL9xMJNjfGzMay1
	7QF1Jdd4rI7pmdmsvPgRLC3+1X0PlWKJSwzM/45EMm0NFWbekkiHr9vx
X-Gm-Gg: Acq92OH9cZEsJ2Ow03YbJMS680DkMErc2DUPjHK8Bi1EApOV3pBL7PAhpPYl3D3E116
	0QKx1/sgjGk+tjC8bjFqyA7j2b5EaEacr6ICP7LhHAB9pYYLpuGmqC1wtZ095T33IYTjjy8Bb2w
	NGcbY6z0uxayG5BPvtWEs7B1rOUV3WChM8AH/iGnSwgM0E3ygjXCnvm6mX4BmCfF7LBItREgB2q
	ioGPyvFBQSnODEdqXcf8xTQiDOYdHsyeLz1CWmbpRe8kcMXV0IWYU3AuMBAbrxH72c5WUIA76ap
	wPGu49E61gPFSi40RSQ0dXdSx3xmtH+/pkHBLIr+vrNzBjB71aEUSrbsPQMwQsmt4yfov3WVpaU
	YIMtRIe3R+9UozNVJkXTiAOLERQ9BPSPnH5SH6w7Fu2+joiyObyVMFgC5re44fyut2WNOalw84Z
	PD051k3uKVCNDwLcMsURYYyvwRIdDwoASdcc2KCAdYctA=
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr288266195ad.13.1778578369221;
        Tue, 12 May 2026 02:32:49 -0700 (PDT)
Received: from [10.125.192.65] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebe0e8sm137692965ad.76.2026.05.12.02.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:32:47 -0700 (PDT)
Message-ID: <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com>
Date: Tue, 12 May 2026 17:32:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com>
 <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
 <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3C7451DCBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15839-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 2026/5/12 03:57, Yosry Ahmed wrote:
> On Mon, May 11, 2026 at 12:49 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> On Mon, May 11, 2026 at 3:52 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>
>>> From: Hao Jia <jiahao1@lixiang.com>
>>>
>>> Zswap currently writes back pages to backing swap devices reactively,
>>> triggered either by memory pressure via the shrinker or by the pool
>>> reaching its size limit. This reactive approach offers no precise
>>> control over when writeback happens, which can disturb latency-sensitive
>>> workloads, and it cannot direct writeback at a specific memory cgroup.
>>> However, there are scenarios where users might want to proactively
>>> write back cold pages from zswap to the backing swap device, for
>>> example, to free up memory for other applications or to prepare for
>>> upcoming memory-intensive workloads.
>>>
>>> Therefore, implement a proactive writeback mechanism for zswap by
>>> adding a new cgroup interface file memory.zswap.proactive_writeback
>>> within the memory controller.
>>

Thanks Nhat, Yosry — let me address both comments together.

>>
>> We already have memory.reclaim, no? Would that not work to create
>> headroom generally for your use case? Is there a reason why we are
>> treating zswap memory as special here?
> 

Apologies for the lack of detailed explanation in the patch description, 
which led to the confusion.

While we are already utilizing memory.reclaim, it does not fully address 
our requirements.

Our deployment runs a userspace proactive reclaimer that drives 
memory.reclaim based on the system's runtime state (memory/CPU/IO 
pressure, refault rate, ...) and workload-specific
policy. That first stage compresses cold anon pages into zswap. Entries 
that then remain in zswap past a policy-defined age threshold are 
considered "twice cold", and the reclaimer wants
to write them back to the backing swap device at a moment of its own 
choosing, to further reclaim the DRAM still held by the compressed data.

This is the "second-level offloading" pattern described in Meta's TMO 
paper [1]. zswap proactive writeback is what this series introduces to 
address that second-level offloading stage.

[1] https://www.pdl.cmu.edu/ftp/NVM/tmo_asplos22.pdf


> +1, why do we need to specifically proactively reclaim the compressed memory?
> 
> Also, if we do need to minimize the compressed memory and force higher
> writeback rates, we can do so with memory.zswap.max, right?

Here are a few reasons why memory.zswap.max is not enough:

1. Writing memory.zswap.max itself does not trigger any writeback 
immediately. For a memcg that has reached steady state (on which the 
userspace reclaimer is no longer invoking
memory.reclaim), after enough time has passed, the reclaimer has no good 
way to trigger proactive writeback for second-level offloading by 
lowering memory.zswap.max, because in steady
state nothing drives the zswap_store() -> shrink_memcg() path. The 
userspace reclaimer still has no control over when proactive writeback 
happens.

2. memory.zswap.max currently triggers zswap writeback via zswap_store() 
-> shrink_memcg(), and each over-limit event can write back at most 
NR_NODES entries. If zswap residency is far
above memory.zswap.max, converging to the target size requires at least 
O(over-limit pages / NR_NODES) zswap_store() events, with no batching — 
proactive writeback therefore has
significant latency.

3. memory.zswap.max is a stateful interface. If the userspace reclaimer 
crashes for any reason mid-operation, it may leave memory.zswap.max at 
some set value, putting the application in a
  persistently throttled bad state.

4. Once the userspace reclaimer has lowered memory.zswap.max, if the 
workload is rapidly expanding and triggers memory reclaim via 
memory.high / kswapd / etc., the actual amount written
back can exceed what was intended.

Thanks,
Hao

