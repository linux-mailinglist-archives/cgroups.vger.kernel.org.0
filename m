Return-Path: <cgroups+bounces-17338-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6dZuEpuXPmrHIgkAu9opvQ
	(envelope-from <cgroups+bounces-17338-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 17:15:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F36CE636
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 17:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WjfEBCkb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17338-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17338-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 463F530CE2FB
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DF377EB0;
	Fri, 26 Jun 2026 15:09:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C161A0B15;
	Fri, 26 Jun 2026 15:09:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486570; cv=none; b=ItdZVZJeb1y5E8uF3FhN3LLAoSGPZVBQgFaSR8voUjO1QgBQiMRZUfojfw9DJERYzL/ddjvH0f03/HKLLJ9dMVJRT/wcUgazOGDKnCuOWszzdTZ8ABE4C4QKTugmkrVauS3Mi7bncXwFyhEvqGf590e4S9O7Jss0Zh/drMDwtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486570; c=relaxed/simple;
	bh=pO9q5/ZERzUyuBHblTMwVmboLPS+gVP4fti4BaerVVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiOCAnG7mMI+8PWT2rhSMRR4LFSHcpP1LpCLe/MPjQbTyfOuTL75BXYPzLQ7NQAhcFPnoFa4bsVcrmfWPG1uPJxPJ4hgCiRJXs/rLtSSNF4bVil77vKqqkRF44+r0MaAw9vCCN7murtBi1b59pL+KbrAZBZbYIqb098YNL9wD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjfEBCkb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8761F00A3A;
	Fri, 26 Jun 2026 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486568;
	bh=6MBy2BPUkeyOXyUL7Fz57L0BYcumMFApFKpBkO/8PzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WjfEBCkbGzVRIUD2Rmtyu6PIgaqLFU89CsEhXqdgmnDmy8UPaex1BeWyAc+/T1U0G
	 +lhSPR3pV/ErHMPicQ7/CB6S3xjf1U/SCq/sXYVynnnLPwIkhc5k8C/nxAIPmmMDB/
	 K4BxeNO4M6SsgxJA4pjOZ8JwgiRkYETVHmQkyEiG6OfHagiRewDiDwgqEBhay3otGQ
	 n5feb/OLALrPJXumW0fOxMnhu6G54np5AJvfpkvZcFdqhQZc6LT64kT/tyF9vIr9hy
	 y7gKK9N7maJqGjrnMCKKIxAkR47SKaRBeVFQ3kYdpJ+7srmarYJtTjKrDMG6s07pOr
	 BYWELocHLM1xg==
Message-ID: <b40a096a-ae54-40e2-816b-86c853435803@kernel.org>
Date: Fri, 26 Jun 2026 17:09:23 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
Content-Language: en-US
To: Harry Yoo <harry@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
 <DJHF7S039QNX.KNVMFISSMLMU@gmail.com>
 <b71f08a7-c767-4551-8e74-bc37aa1b028b@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <b71f08a7-c767-4551-8e74-bc37aa1b028b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:alexei.starovoitov@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:ast@kernel.org,m:pfalcato@suse.de,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,cmpxchg.org,linux.dev,linux-foundation.org,gentwo.org,google.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17338-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D18F36CE636

On 6/24/26 22:19, Harry Yoo wrote:
> 
> 
> On 6/25/26 1:30 AM, Alexei Starovoitov wrote:
>> On Wed Jun 24, 2026 at 6:11 AM PDT, Harry Yoo (Oracle) wrote:
>>>
>>> Bug 1 was reported by lockdep, and bugs 2 [2] and 3 [3] were
>>> reported by Sashiko.
>> 
>> ... and in fixes for sashiko complains sashiko finds more issues.
>> I don't think it will ever end. I suggest to fix realistic scenarios
>> instead of one out of billion cases that sashiko think is plausible
>> but will never be hit in reality.
> 
> But we can trigger debug warnings for the first two bugs fairly
> easily with slub_kunit. Doesn't that count as realistic scenarios?
> 
> (Ok, I admit that the last bug was purely theoretical, and would not
>  have bothered if the fix was not straightforward)
> 
> You might argue that it's not as urgent as we might assume
> (e.g., it's okay to not fix them asap or backport), but I don't think
> we can just ignore them.

Agreed, should be fixed, even if rare.

> It might be bit harder to cause an actual deadlock than to
> trigger a debug warning, though. We can discuss that [1] [2].
> 
>> The chance of server crashing
>> due to cosmic rays are higher than such bugs.
> 
> I'm not convinced that it's the case.

Yeah, especially with large fleets this will manifest for some machines, and
as the usage of the API intensifies.

> Well, I don't know what are the chances of calling kmalloc_nolock()
> in NMI, or within slab or memcg (via tracing), and that is an important
> factor here.
> 
>>> To BPF folks: do we need to backport kmalloc_nolock() support
>>> for architectures without __CMPXCHG_DOUBLE to v6.18?
>> 
>> nope.
> 
> Thanks, that was what I was hoping :)
> 
> # The discussion
> 
> [1] Bug 1: freeing a slab object via kfree_nolock() or draining
> the stock in kmalloc_nolock() happens very frequently. The objcg should
> have been reparented (which happens upon cgroup removal, which is not
> too rare) at some point if the objcg stock or a slab object is holding
> the last reference.
> 
> Can this cause an actual deadlock? That depends on the chances of
> calling kmalloc/kfree_nolock() in the middle of reparenting (see
> reparent_[un]locks()) or objcg list manipulation under objcg_lock.
> 
> [2] Bug 2: You should exceed memcg limit to invoke
> memcg_alloc_abort_single(), but you don't even have to be under
> memory pressure to exceed that. (yeah, I had to modify the
> kernel to implement a fault-injection-like-feature to trigger this).
> Unfortunately, you cannot reclaim memory in unknown context when you
> hit the limit. This should be fairly easy to trigger.
> 
> Can this cause an actual deadlock? That depends on the chances
> of calling kmalloc/kfree_nolock() within the slab allocator.
> 


