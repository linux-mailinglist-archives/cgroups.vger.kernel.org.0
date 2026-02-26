Return-Path: <cgroups+bounces-14412-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FLMEHngn2lLegQAu9opvQ
	(envelope-from <cgroups+bounces-14412-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 06:56:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E121A1262
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 06:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC8C30547D5
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A62AE68;
	Thu, 26 Feb 2026 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hIy3utgt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FA27603A
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772085255; cv=none; b=c/u3mT0gWbyEsRJu7Ae911WHTwKrG0gRMMdGJWWGd8DftAdUcMLOY4f3x/0Uc3AN2srw60e4OGZceEkBjuJ46flcPKOQhXoBi6iSk+ECU9USISXuvYTHrMGMgWrYVqreXp6C5NrENujmZV6XaeVNCF2LSyXBpYzSvB73ke1JOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772085255; c=relaxed/simple;
	bh=ofUMJPShl+CQ+x00gAvrjDE/Dd34Gui2w8gTeLvVDow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfpT/s4KhlUUKqNhT4kxbRMKlDIly/k6LZ/qFS1ONr8Wl8ExaPOxtI4w/MsKHAOW///R0hG8NoGi7ieXQrCMqKzhaXeJmvv6tAgXDBgCSZgo0QFujzSwCkIZ3rgsX4JryX/zhNaofz4TvoiSwOX+OIKeJ4ec2UUKRvziSDhurb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hIy3utgt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb49f63238so24775985a.0
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 21:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772085253; x=1772690053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fI0pTJ34/6sVzsoFrrk7qColB3pOoTYylL8enXM9wuE=;
        b=hIy3utgttilNOHx/lN0HPelntt9wCaIurthBBolTxSw6t0SUkSA7e3287UD/fbk5nB
         J9ebaG9JkYoPWkkXMfHthNoEVs5rNmZxQqAEt9IlVm6YvnsryUrTwzPKfPSLPr4denfG
         f9VmiakR472dgK4FzNvnOjtNAAC6YJbNkh67DUkYFOmT51Ub5RITnYFVT+DH7uDn3+Cw
         Ii5Qb2mxPn1Jz8Mk3bo5FffwYMcrj0Jwy0/TFHxs/2REL3cAzg7TOrq0S743Ua4FWJV3
         W1vzLArC99S45d82TCj+HQlzZn8m1/yiP+J+OB+t9CK+1KJXiADr+u6pxMkniI/e4630
         l0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085253; x=1772690053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fI0pTJ34/6sVzsoFrrk7qColB3pOoTYylL8enXM9wuE=;
        b=Ic7ZY09dJDuWBplwmDOJulWWOa/4Uo3VHWeONBPBmMdvnKMWtK2LqkmiO70pobnxWR
         ntT2nJ+r89NYgZpto+MTv35PXCfk1gEGOC+aXKOSgkjUuKB2WD8VYLlQmWUWhucSi0Gt
         hFzu6cmA+ceMYuRvWrtL7ihTZsODyskjnXr3Z9ygrxcsPqAiKriVkpOk4h1TQANtDcgW
         q1uo0PB4Ol7Xt99S06/Bkb0xsCHBw5A3aui5lYdE9vuSb2aaxTZon7/5ksu9ROIqVjZr
         zaZ4eArqI1rSIIquJEmmMgHWnbggq7nvnqNkwWDwH5B2EZdJTN/TIVOZ22VManYFt3P3
         xoGw==
X-Forwarded-Encrypted: i=1; AJvYcCWrL9kKVmtdODe/hkY/J8fgxAuwfGcMClkQqfpPcLHQO1NgdleWLc/smO7E9VkBWDN4+xw5EaJR@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvS3ZV2jVBxC8yb0E/TbLXXhKvuCXCnGCzws9lzklDzUW1KhM
	2kAmWYqSs4uf7xNoiJPR2+0gwKcetJBRrA8+nWucvlosobvmBINCCqH+C5EdGpJrJQ4=
X-Gm-Gg: ATEYQzxf8wubYCVeB4IL0PTuqMh9nj9S4qy2WbKZ+Pnh0BYF/rB1/JkBWt8XoaHStVz
	6ILwBiFBmBslvKr1iZa5GLrSKzX0eJha+V/ldM+RddH+oNvhnKG7wnFmXSOm5a83mJYJCRbcwC4
	DReToVN7G2+KkAB+oGWfob87Ld6qp1Vb7GSm6lk84yt3DY66eS71j9lmQLkSznJsBwYi88w8ZVH
	WlCjMYpCAKORaJMs1G9L4mirCZzr7MU9xDBn9KTJxmikIcEfGCTMHuqzz4JbYdlhpv7/OX7dpQf
	4kPGC7M4fXWIM8/HxtBIjL/jXBvlMrgsD78Ld227hPWq9966V5h+5Al9ipB/BTxcnxda5kx2b6x
	K+7I3iTVqDj0k0z60QzZev9+59qVQYHRqeq9FUUKCJcd3PI0392o4utDV9wivyBOOw7VFKGz0G0
	0wh6CrxgX5+IJSpx+0PMrOt1bqVNr/5OdzHW8qUb/g8H1n6THjSuQ8Y79usXhwSzgGXLj/7S6Fv
	70JmQw6Bw==
X-Received: by 2002:a05:620a:288e:b0:8cb:4128:ec3c with SMTP id af79cd13be357-8cbc11f57bdmr90671085a.64.1772085252472;
        Wed, 25 Feb 2026 21:54:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f940fsm122507885a.23.2026.02.25.21.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:54:11 -0800 (PST)
Date: Thu, 26 Feb 2026 00:54:08 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZ_gALm7aE3d4IcP@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14412-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98E121A1262
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:27:24PM +1100, Alistair Popple wrote:
> On 2026-02-25 at 02:17 +1100, Gregory Price <gourry@gourry.net> wrote...
> > 
> > DEVICE_COHERENT is the odd-man out among ZONE_DEVICE modes. The others
> > use softleaf entries and don't allow direct mappings.
> 
> I think you have this around the wrong way - DEVICE_PRIVATE is the odd one out as
> it is the one ZONE_DEVICE page type that uses softleaf entries and doesn't
> allow direct mappings. Every other type of ZONE_DEVICE page allows for direct
> mappings.
> 

Sorry, you are correct.  I have trouble keeping the ZONE_DEVICE modes
straight sometimes, and all the hook sites have different reasons for why
all the different ZONE_DEVICE modes and it mucks with my head :[

Device Coherent is the one that doesn't allow pinning, but still comes
with all the baggage of not being on the lru.

Spoke a bit too bluntly here, apologies.

> Don't you still have to add code to hook every operation you care about for your
> private managed nodes?
> 
... snip ... below
> > I don't think that's needed if we just recognize ZONE is the wrong
> > abstraction to be operating on.
> > 
... snip ... below
> > If your service only allocates movable pages - your ZONE_NORMAL is
> > effectively ZONE_MOVABLE.  
> 
> This is interesting - it sounds like the conclusion of this is ZONE_* is just a
> bad abstraction and should be replaced with something else maybe some like this?
> 

Yeah i'm not totally married to this being a node, but it makes far more
sense to me than a zone.

ZONE_DEVICE sorta kinda really *wants* to be its own node, but it seems
that "what constitutes a node" was largely informed by ACPI Proximity
Domains.  Nothing in the rules say that has to remain the case.

To answer your question above - yea you still need to add code to hook
the operations - but this is essentially already true of ZONE_DEVICE
(except you have to contend with other weird ZONE_DEVICE situations).

Some of the hooks here are an experimentation in what's possible, not
what I think is reasonable (mempolicy is a good example - i don't think
userland should really be doing this anyway... but neat, it works :P)

> And FWIW I'm not tied to the ZONE_DEVICE as being a good abstraction, it's just
> what we seem to have today for determing page types. It almost sounds like what
> we want is just a bunch of hooks that can be associated with a range of pages,
> and then you just get rid of ZONE_DEVICE and instead install hooks appropriate
> for each page a driver manages. I have to think more about that though, this
> is just what popped into my head when you start saying ZONE_MOVABLE could also
> disappear :-)

Yup! Basically ZONE_MOVABLE and CMA and ZONE_DEVICE/COHERENT all try to
do similar things for different reasons.

Zones manage to somehow be both too-broad AND too-narrow.

In my head, we should just be able to just plop these things "into the
buddy" and provide hooks that say what's allow "for those pages".

That sounds like Non-Uniform Memory Access *cough* :P

Heck, I was even playing with adding these nodes *back into* the
fallback lists for some situations.

NP_OPS_DIRECT / NP_OPS_FALLBACK
	don't require __GFP_PRIVATE, but give me the hooks I want :V 

> > Where there are new injection sites, it's because ZONE_DEVICE opts
> > out of ever touching that code in some other silently implied way.
> 
> Yeah, I hate that aspect of ZONE_DEVICE. There are far too many places where we
> "prove" you can't have a ZONE_DEVICE page because of ad-hoc "reasons". Usually
> they take the form of it's not on the LRU, or it's not an anonymous page and
> this isn't DAX, etc.
>

It's kinda the opposite of how operating systems do everything else.

Generally we start from a basis of isolation and then poke deliberate
holes, as opposed to try to patch things up after the fact.

> > If NUMA is the interface we want, then NODE_DATA is the right direction
> > regardless of struct page's future or what zone it lives in.
> > 
> > There's no reason to keep per-page pgmap w/ device-to-node mappings.
> 
> In reality I suspect that's already the case today. I'm not sure we need
> per-page pgmap.
>

Probably, and maybe there's a good argument for stealing 80-90% of the
common surface here, shunting ZONE_DEVICE to use this instead of pgmap
before we go all the way to private nodes.

cough cough maybe i'll have looked into this by LSFMM cough cough

> > On (1): ZONE_DEVICE NUMA UAPI is harder than it looks from the surface
> 
> Ok, I will admit I've only been hovering on the surface so need to give this
> some more thought. Everything you've written below makes sense and is definitely
> food for thought. Thanks.
> 

cheers! thanks for reading :)

~Gregory

