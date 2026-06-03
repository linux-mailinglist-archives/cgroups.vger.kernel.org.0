Return-Path: <cgroups+bounces-16600-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UYjABCsPIGr+vAAAu9opvQ
	(envelope-from <cgroups+bounces-16600-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:25:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD94637039
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 13:25:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ObJVdzjS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16600-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16600-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7615430DB666
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3E3D47A4;
	Wed,  3 Jun 2026 11:22:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42183CAE9E
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 11:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485768; cv=none; b=r25ieysxuVuU7OdbXFKp/cv/Y9vQPkq+b2V0bRRxBxDkxWI5kTMc8BA1CHad6vXuAQlMpmEO+wllcJbDDYaEXKlJFWyd6+WmICncy6RBWB7yedZbuioyCpQzmRNxzE77G9/m7He30y3b/gm8d/d2sA4lPqmDrz+M/n3/txd0mXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485768; c=relaxed/simple;
	bh=PBmzY9Mio4AslOoNANTOa4rcMBhtLC4qWVMb7zbJVnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAvr6dQUrlxkroFjH4GbFQ7SM8N1FZXvlZ13bcf0CXUnL8DTV5G2mEbPltmQ5ekW2/n0Ca+76zG5wHHkNoMFQym/JYoh8FvniXFmnEUTUB6rl6BmPfMXgq2fYYHgjnNTRknl7CjudiFf5F0I/7HW6LpVUY9IZW0LxOzKyxnwa9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObJVdzjS; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so5957494a91.0
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780485767; x=1781090567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZSbyRe0Cm9MsW0vFwS1Xzmiqu2z6riqDTx2v5DdObE=;
        b=ObJVdzjSvhTIWJj7/3c/m8bi+f0C2SYaSqu+iKtGTf3LHbWzpBW9+ojBk6ujAIFmdE
         mZ/aqeZrFXAH3QeZre45anP8DL3jK7wcSKJoIjORqHQUCX92yNXt7W1KWdCTxePYhGiq
         k//BKLdn+lHVyvbHVV5kOE4teL7Jx4UPo1Nni8iRi49lUs1zvKTac9Bmb61jMMEwN9Im
         61aOHtimiy0N7Y92wlR0dzqxZ8oeVAPKuJzmD4/tPD/JeS4dlxHmiIAuqMQddm5SnU0Q
         5sI3xYDXGjsM7o1syNHw8eKE/2/DHCvxMtcgbfaTF/ZRTmlEpj/mzYx5194ZeAzcJod2
         2oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485767; x=1781090567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZSbyRe0Cm9MsW0vFwS1Xzmiqu2z6riqDTx2v5DdObE=;
        b=k3KO4Iztzl4QU+Cb1BFY8Z8xiAVJxAr2aialeKyN2GCsGHXi8DbtQEpVGbEQpD34BY
         bdGFcAuL98LLYcQ8IypcWXfP4o21kj6cSBswekAW5u/pkycbMgAsoikG/PCRJF9m8kxd
         /eA2swOHxJAHFmrlcXGZPTuKPaP/3PnaWp4jkkYTCYQgqy1TNxu93Ebl/+QRvYOwGgfl
         HE4oapcNGhN/+L1sS+nqBM8XwkKLsCE3j6VS/BTi+8lfxbAV5japQu4muFVrNgKT2vXi
         /hnEEYUABu9sei+I+Lg2gHh9SK+izi+HEhhn/DX0eTxVVJdB74lGRSkDCHHgbhfo+yR+
         3GtA==
X-Forwarded-Encrypted: i=1; AFNElJ/g404vTU/w0zs7kmulbnEKNJvFsmbtWnzGAKisOTVLGbSvH8fsr7tdACv43WXWjCVU9ylHzFaX@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIIFYZLmnpWYg5KuQoQs6hf5+6FayzYxVdXhXjBLV2NiXll55
	9fce4XYC43vBWRO4lGgL/UZp8MJd7giPbigrN971luVCQEKibs3iKPrd
X-Gm-Gg: Acq92OHl0QXRUoQmeOdaWqs5+7tr+qUD8dtaNDWWmCLdlcjkXRvdc9ZRzJu2EOO1wUz
	MRyqpHsWQQNWyeraj9rIAMaIb5cyNdCau6QdECFI715t7VwY1Ahf6vG4gF9GRYwEF1PpPCJzEYZ
	w8YMqgEi/Ly5A/MSL0RTqVw7TScct51ZewAwJf25DENfeLGWf6yuSM0qwjLqtgyARPtECu/uUw4
	d5o917PTaD3ksVHu/OWDJjfWmgKGmwlCPnJWC6Ir2NA1hJVFPMB5mWBCOwPa2vvXpy8OMR+t7Y4
	wkLOLnaAsIP+2iCjm04f0RYAMZ32B1qCFmtKGVvvGYSr4FQgg0RYYPihwJFuIl0M4BwDprIeJvp
	BSi53Oz96Xs8xfXQ/GfZrSVMozqt2moT8b934cJcw6L6q3JZmuiYmitIqOIMLFSqST3HRLY2Ebt
	Ew5AtERJVU04zU6zWokpNA0WZVOiybKzSIsZjmoccmwfxdxQN9vOC7p/oGrQW7ntu3
X-Received: by 2002:a17:90b:4b47:b0:366:5c38:fd61 with SMTP id 98e67ed59e1d1-36e32f1676amr2884302a91.12.1780485766827;
        Wed, 03 Jun 2026 04:22:46 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6b904c88sm802459a91.0.2026.06.03.04.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 04:22:46 -0700 (PDT)
Message-ID: <6deeaea7-3cd1-4403-29fc-d2dc55c297f8@gmail.com>
Date: Wed, 3 Jun 2026 19:22:36 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com>
 <CAKEwX=MQe_KFZe2vBXQYh0aa-x+E8AzNwmyjJGJk4tDoS9ML3A@mail.gmail.com>
 <aho_VtLCmIRsNyvO@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <aho_VtLCmIRsNyvO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16600-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lixiang.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BD94637039



On 2026/5/30 09:40, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 12:58:09PM -0700, Nhat Pham wrote:
>> On Tue, May 26, 2026 at 4:46 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>
>>> From: Hao Jia <jiahao1@lixiang.com>
>>>
>>> Zswap currently writes back pages to backing swap reactively, triggered
>>> either by the shrinker or when the pool reaches its size limit. There is
>>> no mechanism to control the amount of writeback for a specific memory
>>> cgroup. However, users may want to proactively write back zswap pages,
>>> e.g., to free up memory for other applications or to prepare for
>>> memory-intensive workloads.
>>>
>>> Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
>>> interface. When specified, this key bypasses standard memory reclaim
>>> and exclusively performs proactive zswap writeback up to the requested
>>> budget. If omitted, the default reclaim behavior remains unchanged.
>>>
>>> Example usage:
>>>    # Write back 100MB of pages from zswap to the backing swap
>>>    echo "100M zswap_writeback_only" > memory.reclaim
>>
>> Hmmm, so this 100MB is the pre-compression size? i.e if this 100 MB
>> compresses to 25 MB, then you're only freeing 25 MB?
>>
>> I'm ok-ish with this, but can you document it?
> 
> That's a good point. I think pre-compressed size doesn't make sense to
> be honest. We should care about how much memory we are actually trying
> to save by doing writeback here.
> 
> The pre-compressed size is only useful in determining the blast radius,
> how many actual pages are going to have slower page faults now. But
> then, I don't think there's a reasonable way for userspace to decide
> that.
> 
> I understand passing in the compressed size is tricky because we need to
> keep track of the size of the compressed pages we end up writing back,
> but it should be doable.

Agreed. Using pre-compressed size is probably easier to implement. IIRC, 
interfaces like ZRAM writeback_limit are also calculated using the 
pre-compressed size.

I'll clarify this in the documentation in the next version.

> 
> If we really want pre-compressed size here, then yes we need to make it
> very clear, and I vote that we use a separate interface in this case
> because memory.reclaim having different meanings for the amount of
> memory written to it is extremely counter-intuitive.
> 
Agree. This would indeed break the semantics of memory.reclaim. I will 
use a separate interface for proactive writeback in the next version.

Thanks，
Hao
>>
>> The rest seems solid to me, FWIW. I'll defer to Johannes and Yosry for
>> opinions on zswap-only proactive reclaim.

