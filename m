Return-Path: <cgroups+bounces-16142-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN5/Krx6DmoW/AUAu9opvQ
	(envelope-from <cgroups+bounces-16142-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 05:23:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0685959E5CE
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 05:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A2BC3024505
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267F367B65;
	Thu, 21 May 2026 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THT5j+78"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E1368D43
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333775; cv=none; b=UEH7NzkccP998mfg1C6hYntShBskj1qoR4s2nFqnJd5S3ouqS1qCN4keBzHIBh0+niAPgpsKKjLvniPBSMJfd/QGcHcsVatOEOaN21qFhp+oy5WBLPueB2X9OpFRljThlQ8eq8qAH9UFfoWUfbqx0aL3r7gv9w21nyiQIivVpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333775; c=relaxed/simple;
	bh=2KM+WJfxfvhK3onCCgBv0kY15e0rpvyDbEWfA+CdVTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJjaZIRUcxhWbN0AtBYcTonWhVkbglN9DvaX3y6tfHqUkwfbd9cCstR97H0GzPpjLFNEdpXXidV75ZmkgoXVTyXkSmF5XwL3rkpD1TTw/QSi0BzeqSmP4dZ7F5uolqK7ZK5aooVgtKcUN/M6UnLJs+fNoDJTbq5/VBfbfgqbHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THT5j+78; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7de7dc85b74so5530469a34.2
        for <cgroups@vger.kernel.org>; Wed, 20 May 2026 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779333773; x=1779938573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCEFUIphaYwH63nwZhxQG+TN7ecroRFNX1EgOEudxtY=;
        b=THT5j+780wOJG/bYq0x3r8ibCbf+Y7laAEsM+VlQotkoyNE1gAY+uefVMG4aiNqj9g
         6Bdi9FZmM91p/nJMJPL0yPylGMiWFG6HLcuS0HNA5/X+RmGsK0c1KLmxydzkhyO2LdnI
         7XLOexrvZ8s42Xt1Hp/VmqUzrmWaxtozzzHwgWVQNeUi4Uq64F9P0JPP+44UnWFLEOia
         r+eM76mjTtYG61C3EZ7ObVP0ovacJrhTffl0UcKz/DGr5L1vDlijMbgscJ+r5iC4/b/4
         6DddXipQVM79LZu56Q1dJWEUc9A9RfZD9Ya8Awef/L6/FSS/oNzV6vVcr+ZywX87NDkw
         6Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779333773; x=1779938573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCEFUIphaYwH63nwZhxQG+TN7ecroRFNX1EgOEudxtY=;
        b=J5Inw/uXsEhKw4NerMuWNYJQfHmjd8NLpyoSM79joSefvJxRMH/phn1/9P3B415ciF
         Q0UalZkYJn74u2yvTG8jvyIdymgAzbQyOzvG5RDrOh3R3iG71Sxc6mO1/Ig7sYTWYecH
         z7bPUb8AKJwfwYj1gOTjLRFoKusuGZ5swHykr0vsPMdxkRsKE6yfv3gpYDYPih6Qbqh2
         hISKNxxcriJPXYQO2CAomt+KgERE4XJTWL9WkPx1D4FP0YJxNQXIuRSiTtff16f35yOO
         gKnXhkk4OJXRdFNf0Z3viNPS/BKoitEANdPZ3Haji7vlxbJZBZqg+niVP2SClDFrqvQJ
         8ZVg==
X-Forwarded-Encrypted: i=1; AFNElJ+Xslpz+2H3QxR5c7UJ82SQOrNXX3Ftk6NFWxJMyT22IFaMEkCfES4S7d+sUIHoHw1+HrIcBTXq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+754YCuKt0cVx+3gLhIVWRsJawap9Tqj1ax3tQFttPxOVylFZ
	UWvPPlYL9ETSuttuX0MINS6GZ+0j2lUyMF/9F8pBggcJwW/REBnXuBCILE8TRg==
X-Gm-Gg: Acq92OHeElfEJQqWOxrA/oOk9fK50QFIAcusjv6tl1giZ70l8BjE0vvDkDx9W4QMNel
	pGasDHZzjpIdThQ/4MVfFYmbRSPPYE3JV5eyLB/JRB2+ba1/PuceOCP8RBGgiNMoahacVM9NkOc
	21CgfURrjw1Ft/FCIm9Wt1n7BfJP3/fe5ue2qHZYNcqGCB91aFePXK+BQzRkXu5lx5McGvBacyu
	7MJkj3/OaSy26mEI6mp9yPas27/MvOCI6ddn1cZPlS23x2uasAvmCyjDFpeoEuYwHWt5hUpJNFm
	KEjLqtQzyrNs6WxWN9n41T2XjOoXVrOWZmAbUJguHhI8PJlNt7oCBE8oiVcPu1aBDskEIR9oMkk
	+McW2Dl0MrOQ9iIfdz9v3iWXZuo5H4ONYM/5geexkCbUOHK38f9CK3ZT798zibmSFJeCfMEH9ME
	YhIxW8Do2xK5lK0yTPQZcrIFaDDLEO8RB1JKiBsGywhWVNq7VlpYbc
X-Received: by 2002:a05:6830:6881:b0:7dc:3db6:f02 with SMTP id 46e09a7af769-7e5ec271d04mr523258a34.9.1779333773170;
        Wed, 20 May 2026 20:22:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c68d6sm13479796a34.3.2026.05.20.20.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 20:22:52 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 4/4] memcg: multi objcg charge support
Date: Wed, 20 May 2026 20:22:49 -0700
Message-ID: <20260521032250.3853564-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ag5Z9uIMoXpr3rLP@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16142-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 0685959E5CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 18:05:23 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, May 20, 2026 at 06:35:30PM +0900, Harry Yoo wrote:
> > 
> > 
> > On 5/20/26 2:31 PM, Shakeel Butt wrote:
> > > Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> > > per-node type") split a memcg's single obj_cgroup into one per NUMA
> > > node so that reparenting LRU folios can take per-node lru locks. As a
> > > side effect, the per-CPU obj_stock_pcp -- which caches exactly one
> > > cached_objcg -- thrashes on workloads where threads of the same memcg
> > > run on different NUMA nodes. The kernel test robot reported a 67.7%
> > > regression on stress-ng.switch.ops_per_sec from this pattern.
> > > 
> > > Mirror the multi-slot pattern already used by memcg_stock_pcp: turn
> > > nr_bytes and cached_objcg into NR_OBJ_STOCK-element arrays, scan all
> > > slots on consume/refill/account, prefer empty slots when inserting,
> > > and evict a random slot only when full. With multiple slots a CPU can
> > > hold the per-node objcg variants of one memcg plus a few siblings
> > > without ever forcing a drain.
> > > 
> > > A single int8_t index records which slot the cached slab stats belong
> > > to; the stats are flushed on slot or pgdat change. With NR_OBJ_STOCK
> > > = 5 the layout (verified with pahole) is:
> > > 
> > >    offset 0  : lock(1) + index(1) + node_id(2) + slab stats(4) = 8B
> > >    offset 8  : nr_bytes[5]                                     = 10B
> > >    offset 18 : padding                                         = 6B
> > >    offset 24 : cached[5]                                       = 40B
> > >    offset 64 : (line 2) work_struct + flags (cold)
> > > 
> > > so consume_obj_stock, refill_obj_stock and the slab account path each
> > > touch exactly one 64-byte cache line on non-debug 64-bit builds.
> > > 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> > > Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > ---
> > > @@ -3350,19 +3405,45 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > >   		goto out;
> > >   	}
> > > -	stock_nr_bytes = stock->nr_bytes;
> > > -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > > -		drain_obj_stock(stock);
> > > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > > +		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
> > > +
> > > +		if (!cached) {
> > > +			if (empty_slot == -1)
> > > +				empty_slot = i;
> > > +			continue;
> > > +		}
> > > +		if (cached == objcg) {
> > > +			slot = i;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (slot == -1) {
> > > +		slot = empty_slot;
> > > +		if (slot == -1) {
> > > +			slot = get_random_u32_below(NR_OBJ_STOCK);
> > 
> > It would break kmalloc_nolock() because _get_random_bytes() uses a spinlock.
> > perhaps prandom_u32_state() should be sufficient in this case.
> 
> > Is there a reason why it uses random eviction, unlike multi-memcg percpu
> > charge cache?
> 
> Oh I didn't know and actually we are already using get_random_u32_below() in
> refill_stock(). So, it need fixing as well. That would be a separate patch.

Hello Harry and Shakeel!

I just wanted to note that my work to push the memcg stock to page_counter [1]
actually gets rid of the random eviction and also the get_random_u32_below.
So the problem will no longer exist, at least for memcg/page_counter stock.

I was also thinking whether there was any way we can abstract or push down the
objcg stock to a different per_X slot (with finer granularity than per-node)
so we don't do random evictions, but it doesn't seem like there's a natural
point to do this from a quick glance.

The fix for get_random_32_below to use prandom_u32_state seems quite simple
though, so if either of you would like to send that in as a small hotfix
it shouldn't be a big deal to rebase on top of that instead too.

(Sorry for joining the conversation late too. I'll take a closer look at this
entire series tomorrow as well).

Thank you both. Have a great day!
Joshua

[1] https://lore.kernel.org/all/20260410210742.550489-1-joshua.hahnjy@gmail.com/

