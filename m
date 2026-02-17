Return-Path: <cgroups+bounces-13972-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t8zRHWIdlGkpAAIAu9opvQ
	(envelope-from <cgroups+bounces-13972-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 08:48:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 155FC1494FA
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 08:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F19033008C3C
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C92D838C;
	Tue, 17 Feb 2026 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPqJgddj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377162D7392
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314527; cv=none; b=cXX0oHLvfhi5PTMVqr3e4M+PQIPVAJZtVyobYpcda0QbepaWUJlvXoBEKJDXLtKGo9vp6KH/BXJ58iKBWLOlJsPiMveNizezOFNARRHIYt9q4qqcD/k/NvShEM0lrvJCYYRifX3Ts0VFNlNRjMqoRO9mXXkmlzMIEAQ3va1TKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314527; c=relaxed/simple;
	bh=NPI6mWl+poWFT5q7oQSSbSjNljd6hZWCNDu3vvNn0uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u61s9GA0zxVpl9eOneATQ2UouBDAKUsXZCny5L3a3IJboD8mDh94DkrSgocmv6iLPT4xaha/jjdUvMzAtKQzHhEJ9HOxgYan+qT8k9zrabJnz4lXlp2hHn3RKX37LQBGcclXbETFtkdqOhrIBpXfh15yH4rVOstCqbFQDjYF+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPqJgddj; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1248d27f293so8827068c88.0
        for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 23:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771314525; x=1771919325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnMNqYmQNZzpA0ckivNAm3K36XWptoI0fu8qkH7ny3w=;
        b=mPqJgddjznqd7TFWHyGJITady3D2Z+L3TV7o+Qn31vBPtJXapmxhTs50IeaKciS62X
         /uolMUufavaRZwuxASWDLxPyv54c9xc0neWnFezJxxN6mEFPpYyfW3o6zVXOe2lgO+X1
         7WkZfpGq8TuDAn22gVM7IVrNIeidrVNiCGD1Ov3zbyPlcXGEtVoyr8Xk+Jy9bZ67apKa
         wDaEaU4yKcnMrc4a6SSo79KzuVIqTqWCM8WDxdDidBa+jtD8Kf2+FQ2T+7jcGESI6D+E
         kVx4rRXY4BysHHY5mrDT7tpuhwnXR2/X0RuIFIEkwFf+C3CZtSZ3AZgo73cAlL8DZHU0
         48cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771314525; x=1771919325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnMNqYmQNZzpA0ckivNAm3K36XWptoI0fu8qkH7ny3w=;
        b=SVsqvnfMireisfj0906gbwSvI1Csce995G1O8V9dpeNT+yGtaDoutaqQoKMxkDyZnz
         In75FYgBmYq9JwLWwBrInyJDWSMVUyVOviVYvNL/fMt7JzvcyvK3vk/4WkwdAjeRMz+O
         3qz95KwgYpy8mAzjzOd+vMMuo2UQ5icNXpg9ihEVx6INfJZfyHibSAU7uTosRY0FrIbk
         CaaRKPA+s5LiKKVSIXf9m76aXmMY0EHptF30SYvCElFWlb/pfoCCXffvGu8VYRrfmppS
         yITNlsJNhRoJVxcBfvn7ANlk//0XaxRdEs+UhqDl/GJbSpdFWDu9O8L7492dO8LFtzvg
         4EYA==
X-Forwarded-Encrypted: i=1; AJvYcCVlzRZOSFemp35y6Qm3nrPPxpJz6Flgns8/99JZpeSo67KVK+sMSRcV+nj20lVjdwUhj+U/7Zzv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ar7m8wPvfs4NsekgpK2TIfDOwIvD9dcFkKth0wArpH41ps9V
	MdRn/y85RCidzMQr22IIxughiRh0yUOqFdr9+c23QCS9aii3kFElbvvX
X-Gm-Gg: AZuq6aIe0qaq8GHVRNzix3UoqMqxp9/71rFAq2/nXgGB10C5uYKLy1E2N651glybTFl
	CzJFurl8WFjOHZMLv/1TiXiD5eTpWKWshDl6s7qjqAwbytHnQ86Fl59l5IeiJS6MdacWE2VO3n0
	KeX7Ed/Dwk5pNJq1qKcD3UPiiOVYWu57numZXnTUPYM/fpiEU0euWfhurYyl1PSPVGASEga4VxS
	/kdTrSemAVHIY+4qMAsjkto1mjuS38crQkmnbiSF0DBMfb6R3Ec87DMOGQlN7JL2GJL3F9zoE2D
	R0aPAOG6efnHsZ2wmWlwmWN3T6VVdB75NvopIIbboBkjy+BRsUzqqXUu/GALfhql7lTOGfG/9ZW
	XE1LneUuqNTAD6LBdcsvDgHzGC4qG4cKoNFexlNwnm346nnEINg7EJIu6LU9cRNew0AVE/SSDon
	AKXnX/acMjCJrdy7Tk9dRrCIrlG2NnrNdN
X-Received: by 2002:a05:7022:f102:b0:11d:e25a:d9ca with SMTP id a92af1059eb24-1273ae69c9bmr5761013c88.26.1771314525054;
        Mon, 16 Feb 2026 23:48:45 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cada1csm13124794c88.9.2026.02.16.23.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 23:48:44 -0800 (PST)
Message-ID: <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com>
Date: Mon, 16 Feb 2026 23:48:42 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com> <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com> <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com> <aZOHIQj3pJ-9dW_0@tiehlicka>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <aZOHIQj3pJ-9dW_0@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-13972-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 155FC1494FA
X-Rspamd-Action: no action

On 2/16/26 1:07 PM, Michal Hocko wrote:
> On Mon 16-02-26 09:50:26, JP Kobryn (Meta) wrote:
>> On 2/16/26 12:26 AM, Michal Hocko wrote:
>>> On Thu 12-02-26 13:22:56, JP Kobryn wrote:
>>>> On 2/11/26 11:29 PM, Michal Hocko wrote:
>>>>> On Wed 11-02-26 20:51:08, JP Kobryn wrote:
>>>>>> It would be useful to see a breakdown of allocations to understand which
>>>>>> NUMA policies are driving them. For example, when investigating memory
>>>>>> pressure, having policy-specific counts could show that allocations were
>>>>>> bound to the affected node (via MPOL_BIND).
>>>>>>
>>>>>> Add per-policy page allocation counters as new node stat items. These
>>>>>> counters can provide correlation between a mempolicy and pressure on a
>>>>>> given node.
>>>>>
>>>>> Could you be more specific how exactly do you plan to use those
>>>>> counters?
>>>>
>>>> Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
>>>> we identify the affected node(s), the new mpol counters (this patch)
>>>> allow us correlate the pressure to the mempolicy driving it.
>>>
>>> I would appreciate somehow more specificity. You are adding counters
>>> that are not really easy to drop once they are in. Sure we have
>>> precedence of dropping some counters in the past so this is not as hard
>>> as usual userspace APIs but still...
>>>
>>> How exactly do you tolerate mempolicy allocations to specific nodes?
>>> While MPOL_MBIND is quite straightforward others are less so.
>>
>> The design does account for this regardless of the policy. In the call
>> to __mod_node_page_state(), I'm using page_pgdat(page) so the stat is
>> attributed to the node where the page actually landed.
> 
> That much is clear[*]. The consumer side of things is not really clear to
> me. How do you know which policy or part of the nodemask of that policy
> is the source of the memory pressure on a particular node? In other
> words how much is the data actually useful except for a single node
> mempolicy (i.e. MBIND).

Other than the bind policy, having the interleave (and weighted) stats
would allow us to see the effective distribution of the policy. Pressure
could be linked to a user configured weight scheme. I would think it
could also help with confirming expected distributions.

You brought up the node mask so with the preferred policy, I think this
is a good one for using the counters as well. Once we're at the point
where we know the node(s) under pressure and then see significant
preferred allocs accounted for, we could search the numa_maps that have
"prefer:<node>" to find the tasks targeting the affected nodes.

I mentioned this on another thread in this series but I'll include here
as well and expand some more. For any given policy, the workflow would
be:
1) Pressure/OOMs reported while system-wide memory is free.
2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
down node(s) under pressure. They become available in
/sys/devices/system/node/nodeN/vmstat.
3) Check per-policy allocation counters (this patch) on that node to
find what policy was driving it. Same readout at nodeN/vmstat.
4) Now use /proc/*/numa_maps to identify tasks using the policy.

> 
> [*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
> target node even when the allocation is from a remote node from the
> "local" POV.

It's a good point. The accounting as a result of fallback cases
shouldn't detract from an investigation though. We're interested in the
node(s) under pressure so the relatively few fallback allocations would
land on nodes that are not under pressure and could be viewed as
acceptable noise.

