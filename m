Return-Path: <cgroups+bounces-16941-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BC0XKDvBL2poFwUAu9opvQ
	(envelope-from <cgroups+bounces-16941-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:09:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 438ED684E8B
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:09:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bpOCPu9c;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16941-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16941-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8A93028ECF
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46FD2DB7B4;
	Mon, 15 Jun 2026 09:02:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEE1A4F2F;
	Mon, 15 Jun 2026 09:02:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514127; cv=none; b=RBLhLDTzzkC4XZ36HMeVzmZAsacDboa+sc7cw5KbbZ/C+vWao2T09ughcXWdIOU+vGRWXShA2dM4kC8FteeSsoZadHGULHF0EA7YelG0rHLSVC8p2OWQFdrjhAGUkiIpqnjvQEz0/BDXnsnaZusWZ3YhZxmviPndwRDwAoX/z0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514127; c=relaxed/simple;
	bh=eYO33OZYyxYtKwg4xXi5walByUVR1rAPD3k36LxnZc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXnpcjOMQvlTzHY72Ka+0V2UqykhrBXGSetbNc3wHF54y3y4AhL5xeaxrWm9hJi3vPxp9tyKfHizmdIxR6HJmiB83ncJzSK1ErOHVzIArzuGYumP4eHTZQ7BafLC7/4clg0IZ8wgFe6hFImSg7F7ICov4iJmOJZMU0p74yUBR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpOCPu9c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61E71F000E9;
	Mon, 15 Jun 2026 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781514126;
	bh=zejvIfX8d2dRdR2mAJ04OI+CXDIR6kMQOBHLrkrQTuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bpOCPu9cAnQ49Uo92ymBgaDMsNNkCNFKwGJhICCG+otI4FMV/1oOM9BbFmEiw5Em4
	 C8wyRuso85zHacKQClkoVbhC99Qsbm8cmYaHrJ49uXB1J/tYEK+rCvNXsvrecquD7J
	 kVgQwxtFU+5aDWA/ytr87bu917cKElEi7bbwLi+D91RJgEQO4cmrM9yOVBM4Hfxx9P
	 SG93yjMZJnEoUuUMlo4c6fyG1UZFJuLRJfx5bN00r2+sriy+T6V/7PrtSWCk7LGuwk
	 KXVr9X83dNSbMhpQ+2NqtyD41/ZR7kSIQyPYaVUtRUYg9VfALr3666VqLlO3RG9MTk
	 pVT8qdIw+QhdQ==
Message-ID: <f927f1b4-3f60-471e-b42b-8d098c1ce5dd@kernel.org>
Date: Mon, 15 Jun 2026 11:02:01 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: Hao Li <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>,
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
 <aiuBoDbQc0N-l7e-@fedora>
 <CAJuCfpGSHfNUvL9AzbftSg=uGRW4cJLbO6iB15keyN6A_eSWEw@mail.gmail.com>
 <CAADnVQJPETYAOd9R9Bg2JuuF1q7grg8VtEnvdvr0fDFhxb9O6A@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <CAADnVQJPETYAOd9R9Bg2JuuF1q7grg8VtEnvdvr0fDFhxb9O6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:surenb@google.com,m:hao.li@linux.dev,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16941-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 438ED684E8B

On 6/15/26 04:16, Alexei Starovoitov wrote:
> On Sun, Jun 14, 2026 at 7:01 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Thu, Jun 11, 2026 at 8:50 PM Hao Li <hao.li@linux.dev> wrote:
>> >
>> > On Wed, Jun 10, 2026 at 05:40:07PM +0200, Vlastimil Babka (SUSE) wrote:
>> > > Similarly to the page allocators, introduce slab-allocator specific
>> > > alloc flags that internally control allocation behavior in addition to
>> > > gfp_flags, without occupying the limited gfp flags space.
>> > >
>> > > Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly to
>> > > page allocator's ALLOC_TRYLOCK and will be used to reimplement
>> > > kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
>> > > gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM flags,
>> > > importantly __GFP_KSWAPD_RECLAIM. This can give false-positive results
>> > > e.g. in early boot with a restricted gfp_allowed_mask.
>> > >
>> > > Also introduce alloc_flags_allow_spinning() to replace the usage of
>> > > gfpflags_allow_spinning().
>> > >
>> > > Start using alloc_flags and the new check first in alloc_from_pcs() and
>> > > __pcs_replace_empty_main(). This means some slab allocations that were
>> > > falsely treated as kmalloc_nolock() due to their gfp flags will now have
>> > > higher chances of succeed, and this will further increase with followup
>>
>> nit: I think it should be either "higher chances of succeess" or
>> "higher chances to succeed".

success it is

>>
>> > > changes.
>> > >
>> > > Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimate to
>> > > reach it from a slab allocation that's not _nolock() and yet lacks
>> > > __GFP_KSWAPD_RECLAIM for other reasons.
>> > >
>> > > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> > > ---
>> >
>> > Reviewed-by: Hao Li <hao.li@linux.dev>
>>
>> I would call SLAB_ALLOC_TRYLOCK something like SLAB_ALLOC_NOSPIN or
>> SLAB_ALLOC_NOLOCK but naming is hard and I don't claim myself to be
>> good at it. So, feel free to adopt my suggestion if you like it or
>> ignore it otherwise.
>>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
> Just noticed "trylock" in the #define SLAB_ALLOC_TRYLOCK
> 
> Please call it SLAB_ALLOC_NOLOCK.
> 
> Initial api was using 'trylock' name and it was a mistake,
> since people assumed normal spin_trylock() like semantics.
> "trylock" implies that it fails under contention
> and retry is a normal next step. It's not the case.
> No one should be retrying. That's why the final api was kmalloc_nolock().
> So please keep this important distinction in the name.
> SLAB_ALLOC_NOLOCK should mean that spinning locks
> should not be taken. It should not mean "just go to trylock everywhere".

Eh, ok then, will change to SLAB_ALLOC_NOLOCK. Even though it's mostly internal.

So next thing we change page allocator's ALLOC_TRYLOCK to ALLOC_NOLOCK too?


