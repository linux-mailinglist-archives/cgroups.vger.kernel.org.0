Return-Path: <cgroups+bounces-13954-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G4cMaSZj2lQRwEAu9opvQ
	(envelope-from <cgroups+bounces-13954-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 22:37:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2806139A2B
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 22:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C00C30074E1
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0CC1E1C11;
	Fri, 13 Feb 2026 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbIFYCQE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC82C237F
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771018653; cv=none; b=X6+rGGM8BYSLPs5RZbh4VImaOd3TRnglXnmaVNMiW56eGFUX9TJRgR73vgEXK36jji4bEWhC48zNM18962uRqQ7FVrqPtWUnAp9XVthVjf+EyCG8rxQexLY5YqLqGM1CU7fi0dXnyTUhoYdAHZ9T14jeW2e5o7XweEInCLLoLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771018653; c=relaxed/simple;
	bh=mH50sMrriyGDz+Qbrz5Taix8L1V/wsCNQUq+G3Lfn6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f83nabcOYEfRP16OFHID9+DkiujzmMz6sKgtvielrP9iixf9ZQ793MRF0FdFGCIN+CKASwA1ie0fWR1AQoHb8uQ1D5XRBybj/Bc8M63o5ocXvtr4YAMAVTzqp5nRUxvx7g1ksn7iZmH9FBDlg608lweZEjSWeiC7DGH2Qh2x9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbIFYCQE; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb38e86cf2so153834885a.1
        for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 13:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771018651; x=1771623451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yr4En5251tETgtYzeFZ5nnuFAQ7w2oyqC71nR7DQ8Wk=;
        b=dbIFYCQEAE6zC7ve1vlS9DJNfP7xlls4Aralt8YA5iSQaOHkFxhsgxolL57kg1aOEb
         JWa/Usc3e5TwUjZqOzaCSi5wwv+rVM7eGNDlmeq8m+J7C4FMRergH1dOwZk/5pgm2CjK
         mqaHAVKtuwZ9OsYpiLlEGai9Nwf60s258EZzNiIFUuogedSSylTEQMDad0NOg0ugVfDx
         sxWkYaNv88wAjdD0vJyj+G9eAiKU/ECrfLvxrQdXO1r8MRe8QAPog1sHteQuhTWKkFdf
         MTtbXy4EQWUWp6D3azMWMe35y9MRu147DeGRM1ZtnwVw47AbryDMLDT4eE+5SAkMhcar
         gThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771018651; x=1771623451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yr4En5251tETgtYzeFZ5nnuFAQ7w2oyqC71nR7DQ8Wk=;
        b=uKuTDyiHywDObAKeNsP8p85soBKXoJp5RZz8CtS1tX0V0I50uBikXP7Ca20E/JIzzC
         hb1RZdJHndqazeHKYJ5yV6HltMssLvMZ9198x991Q8tVMMzxD5O+SQv+Ja96ocSFPqTL
         58Fu3PRX9UNOSHfsLe3GLYETpiJ3D8w7qfxAQsNky/yMBQr8oS+ZrAM88X70CUQt7AY/
         7wpYv3TQbzsOIYFZPYceGVV2OsW7OE6wLWrTIOV9UfAuCVc+Xjx2jCeCqCWgN2USxDQ+
         4VNVMUWh8g6lmtgCKdBq3bDqgNAb4vNOd6xQzy7LZtcZF/huzMEg4bsf8vMXE6qpAOFw
         NHPA==
X-Forwarded-Encrypted: i=1; AJvYcCWjV925tBhfdzML3rTbtEk36hbX8c2z6hIS77otDEXwpPX8didYgsQTPQm0FbKS0l6xekFQpnBj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DWLgiptIri4YsNNZB4PpNS6uf3KEMns/ff8YhtZGdcFzFeUn
	IB8LLAEFPFjpJo9876SOPH4s939IuaIgIukxMKMVyRTQMi6hACQrfcI20EQY8J7D
X-Gm-Gg: AZuq6aIrsxXZTUQ/A57FfuKAezO4Y6DoZKS6hpETO0xPFbtt8QImJ1+5cINiX9kVcdg
	HbIcoWtx37DnPUguoh6jnUKfWW5TKgGfVvPPXCcsfl3eblKCYFZ6NV/QXrkH7AQuHeEDH7VgQ00
	MncXystiQwFxR6MKG4xIMS4nMgKhMzjT8tJGiNNyRW90JQRujvWttAjzvwbgxcWcQbB75bdT7sc
	+Hk8hUDEXO25jLfa3gRrO6CtIqfja0aMglrU6XAcTTk1daCKq82O2owWz5gFF4r0Cbmj8mZltsq
	eOfEYKhR5dzRh9LcmZqw0LUuS9ZpDF/0MdPacT3MoY5OCA4Man6AcyPcEz9INApvCGY6RB4UzgP
	2GRM7ZOuXEg10dHhsDc+MpWFR7MUM5XnEEKwZv4SWYKHeac+llBmGsNu289RReaPopcX8tGoh6l
	Qf3aLN/e37RLQlL6XTm3bP4jsmXM4SFad/
X-Received: by 2002:a05:7022:618e:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-1273ae30dbemr1295141c88.28.1771012577689;
        Fri, 13 Feb 2026 11:56:17 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a69cc93sm8742855c88.6.2026.02.13.11.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 11:56:17 -0800 (PST)
Message-ID: <fd56ae2c-64ac-46bd-bcb2-503df995a6a1@gmail.com>
Date: Fri, 13 Feb 2026 11:56:15 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc: apopple@nvidia.com, akpm@linux-foundation.org, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, mhocko@suse.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <96b63efb-551f-4dd5-b4a2-ac67da577431@suse.cz>
 <b5927ae8-3108-4d65-bee9-be306fb697b4@gmail.com>
 <d52066f1-c83e-4406-adca-5a403adb4f44@suse.cz>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <d52066f1-c83e-4406-adca-5a403adb4f44@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13954-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,suse.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email]
X-Rspamd-Queue-Id: F2806139A2B
X-Rspamd-Action: no action

On 2/13/26 12:54 AM, Vlastimil Babka wrote:
> On 2/12/26 22:25, JP Kobryn wrote:
>> On 2/12/26 7:24 AM, Vlastimil Babka wrote:
>>> On 2/12/26 05:51, JP Kobryn wrote:
>>>> It would be useful to see a breakdown of allocations to understand which
>>>> NUMA policies are driving them. For example, when investigating memory
>>>> pressure, having policy-specific counts could show that allocations were
>>>> bound to the affected node (via MPOL_BIND).
>>>>
>>>> Add per-policy page allocation counters as new node stat items. These
>>>> counters can provide correlation between a mempolicy and pressure on a
>>>> given node.
>>>>
>>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>>
>>> Are the numa_{hit,miss,etc.} counters insufficient? Could they be extended
>>> in a way that would capture any missing important details? A counter per
>>> policy type seems exhaustive, but then on one hand it might be not important
>>> to distinguish beetween some of them, and on the other hand it doesn't track
>>> the nodemask anyway.
>>
>> The two patches of the series should complement each other. When
>> investigating memory pressure, we could identify the affected nodes
>> (patch 2). Then we can cross-reference the policy-specific stats to find
>> any correlation (this patch).
>>
>> I think extending numa_* counters would call for more permutations to
>> account for the numa stat per policy. I think distinguishing between
>> MPOL_DEFAULT and MPOL_BIND is meaningful, for example. Am I
> 
> Are there other useful examples or would it be enough to add e.g. a
> numa_bind counter to the numa_hit/miss/etc?

Aside from bind, it's worth emphasizing that with default policy
tracking we could see if the local node is the source of pressure. In
the interleave case, we would be able to see if the loads are being
balanced or, in the weighted case, being distributed properly.

On extending the numa stats instead, I looked into this some more. I'm
not sure if they're a good fit. They seem more about whether the
allocator succeeded at placement rather than which policy drove the
allocation. Thoughts?

> What I'm trying to say the level of detail you are trying to add to the
> always-on counters seems like more suitable for tracepoints. The counters
> should be limited to what's known to be useful and not "everything we are
> able to track and possibly could need one day".
In a triage scenario, having the stats collected up to the time of the
reported issue would be better. We make use of the tool called below[0].
It periodically samples the system and allows us to view the
historical state prior to the issue. If we started at the time of the
incident and attached tracepoints it would be too late.

The triage workflow would look like this:
1) Pressure/OOMs reported while system-wide memory is free.
2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
down node(s) under pressure.
3) Check per-policy allocation counters (this patch) on that node to
find what policy was driving it.

[0] https://github.com/facebookincubator/below

