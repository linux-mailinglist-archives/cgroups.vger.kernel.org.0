Return-Path: <cgroups+bounces-14566-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIQxFqgCp2k7bgAAu9opvQ
	(envelope-from <cgroups+bounces-14566-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 16:47:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B42221F2E6B
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D78030417AC
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8160047DF8D;
	Tue,  3 Mar 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="cqQ4Dt4e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D642F55E
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552618; cv=none; b=h4gGvoGZ4Sd4bwsoLj9/VPfUcFIIVlQ6pMYKu7w63iVdA8dyv4/haW61G2VX0XF4yFtrvFB8kB6gseMkes8Xh+j7R0hq3xcRgUlNxouMLT2H7N+fFiI/8QTk/fm2gY4rb772m5qH/3AuyQngmqJlM9fC5RZqQkJykS8o6gCv+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552618; c=relaxed/simple;
	bh=WnhesxNW489SQ6o9/JVmLHwAJ+1lIx01AIUokx4m7x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=domz9A3SbLhmH7Zcr14eZQuicw8Orfudc7JqttzlXFTnIpK3TuCVgkzWB+I3/CSj6wCUxtq9XQSwjkI4GVAEyd3xBsDaIgbi3/YAqObAHOCbH8goWzuIRaJiRI1N3jnbyPsUZXcGweaDewUEOcXW8gsb/SArowt9QQ1WzUXoF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=cqQ4Dt4e; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a0ecbc713so7970106d6.1
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2026 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772552615; x=1773157415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5iJQaiUJrWfplRxtcMoHp1zPaYjGQn94g6/CCuRZvsM=;
        b=cqQ4Dt4ePHk8gYbSUkw+Es+PrNkl1xj2N0d/myQpYb0qzrR7hTOItklIZN8Z7akJze
         8wyAlHcSoSKrl0vfL0CFeP05KoT3gfFRUuKn8RrMZyJ7cQYBt3B0thLKhF6IKOo0WABT
         PcgEy3eDiRn3h7H50orV0iOiYR+NI5Ihg0IIoixjR7ILM85Fd0koQ9x/6ExCupkY3GUf
         eyZdITDzGCqgYq8PSiMisnQ5AkjmEGMC/GjBXCAo4m3+Sw374tVYcrrYmGdNunKo5Cj1
         3mdbRAnm35Ba87vzqbAJr53+Pt58MrVicEWdJzNbBwO6aijSTmARgZIaPbLBULXEPvav
         UiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552615; x=1773157415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iJQaiUJrWfplRxtcMoHp1zPaYjGQn94g6/CCuRZvsM=;
        b=I9sfp3bfHYa64rbCwa0/78cl0yifkHm5gD/l7bzmSyixQwnA0V4i7Cp01/AxtPUtSr
         aXPUeSwD+wrOw2aXpJ/ZRhli1kL1ZIBZ5FDqALF77UqgOC/Co3x1lKatqY+5Xf0Nrh1a
         Ibv4TDeuaRIAcB0WyCcyk3fZ9WaluCBVP2k1HCOjA2Nx14GDvK3+oiDZ5BVwR6swvVTo
         Fcp1GYFuLa/TcEfaOMUfNR4taq9vyYD7OcmDYpQf1Tb0yXACPJ6W0B7dbm9DRIU77yBA
         1yIkwjoiACUQaJKLB2GQE1Cme+jFXBJ4APpmqVh5feyzskdEOMfVr37emnwth4Mlh43G
         bNOw==
X-Forwarded-Encrypted: i=1; AJvYcCVUO1mGxaFTlP4Hkno+qrbrMzSzW3wh1sFvDyGjX6h/euhUQ8OeeirqVNBN3VtPkBEKatmupWxD@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZgTI9RGU4u1rVct7u/DAssL4rrL+HywFi4heEtpw/lW/sNqR
	GiUVvKpmNJMKJXNfP1Tqvdurvdct4JnKdCovxu8lOdGPAtoIY67Jxst0nSKaMUt+4Ec=
X-Gm-Gg: ATEYQzz+iQHSuDZ8VsGIJG54C+lHYjnRwvsyYWajlz70xn7C2KpHgO8v8QjmJVulICr
	S29UITc3ArO4BgB//ERU4kPMwbxkcQDrmM3ebkWJ/Fzk0HSZoGgJrl2btEIhKvg5sw1VBff4Oef
	rnOTJuMYPfKfHwXjnnaI2vhIaG9uQ+rwg9FTaWhxvD17OJ8dgQYnbn4aacUJU9UNPogyIa5VENo
	Icw8uA6wThigE1WxmU9+cDGA65NwF5ffVddnza/c4OS5hh2VUCPnUtJJKOS6mhTbTPcya4ef7+j
	4/6o7Pw+aLeI8MqkuCdIQyEs6K3nEH1LvMFhqi6QfzCBf3NvTJzd7LJErKegn6DS7TaR89YuUlf
	oeKejisXTFlvwjbKx3cSq0J236B5c7rBXzf9OEzUjMS7rSQUkUFGekXVKbjQxYeWxNFCUvdMCBK
	jff6v0xfCiWxALFvaW05El7ottvS73yjOg
X-Received: by 2002:a05:6214:21c7:b0:899:f39f:b884 with SMTP id 6a1803df08f44-89a0a86c9d5mr33626696d6.9.1772552614690;
        Tue, 03 Mar 2026 07:43:34 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7374e07sm134729676d6.33.2026.03.03.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:43:33 -0800 (PST)
Date: Tue, 3 Mar 2026 10:43:29 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: memcg: separate slab stat accounting from objcg
 charge cache
Message-ID: <aacBoazC21TAi-Q2@cmpxchg.org>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-6-hannes@cmpxchg.org>
 <ji2jjt4vtmt2ox7wzytpivttc4z7j3u6cwmv23r6xit5322gns@te4t4djl5nlk>
 <541a6661-7bfe-4517-a32c-5839002c61e5@kernel.org>
 <aablae2eFl9ne5fW@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aablae2eFl9ne5fW@linux.dev>
X-Rspamd-Queue-Id: B42221F2E6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14566-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:45:18AM -0800, Shakeel Butt wrote:
> On Tue, Mar 03, 2026 at 11:42:31AM +0100, Vlastimil Babka (SUSE) wrote:
> > On 3/3/26 09:54, Hao Li wrote:
> > > On Mon, Mar 02, 2026 at 02:50:18PM -0500, Johannes Weiner wrote:
> > >> Cgroup slab metrics are cached per-cpu the same way as the sub-page
> > >> charge cache. However, the intertwined code to manage those dependent
> > >> caches right now is quite difficult to follow.
> > >> 
> > >> Specifically, cached slab stat updates occur in consume() if there was
> > >> enough charge cache to satisfy the new object. If that fails, whole
> > >> pages are reserved, and slab stats are updated when the remainder of
> > >> those pages, after subtracting the size of the new slab object, are
> > >> put into the charge cache. This already juggles a delicate mix of the
> > >> object size, the page charge size, and the remainder to put into the
> > >> byte cache. Doing slab accounting in this path as well is fragile, and
> > >> has recently caused a bug where the input parameters between the two
> > >> caches were mixed up.
> > >> 
> > >> Refactor the consume() and refill() paths into unlocked and locked
> > >> variants that only do charge caching. Then let the slab path manage
> > >> its own lock section and open-code charging and accounting.
> > >> 
> > >> This makes the slab stat cache subordinate to the charge cache:
> > >> __refill_obj_stock() is called first to prepare it;
> > >> __account_obj_stock() follows to hitch a ride.
> > >> 
> > >> This results in a minor behavioral change: previously, a mismatching
> > >> percpu stock would always be drained for the purpose of setting up
> > >> slab account caching, even if there was no byte remainder to put into
> > >> the charge cache. Now, the stock is left alone, and slab accounting
> > >> takes the uncached path if there is a mismatch. This is exceedingly
> > >> rare, and it was probably never worth draining the whole stock just to
> > >> cache the slab stat update.
> > >> 
> > >> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > >> ---
> > >>  mm/memcontrol.c | 100 +++++++++++++++++++++++++++++-------------------
> > >>  1 file changed, 61 insertions(+), 39 deletions(-)
> > >> 
> > >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > >> index 4f12b75743d4..9c6f9849b717 100644
> > >> --- a/mm/memcontrol.c
> > >> +++ b/mm/memcontrol.c
> > >> @@ -3218,16 +3218,18 @@ static struct obj_stock_pcp *trylock_stock(void)
> > >>  
> > > 
> > > [...]
> > > 
> > >> @@ -3376,17 +3383,14 @@ static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
> > >>  	return flush;
> > >>  }
> > >>  
> > >> -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> > >> -		bool allow_uncharge, int nr_acct, struct pglist_data *pgdat,
> > >> -		enum node_stat_item idx)
> > >> +static void __refill_obj_stock(struct obj_cgroup *objcg,
> > >> +			       struct obj_stock_pcp *stock,
> > >> +			       unsigned int nr_bytes,
> > >> +			       bool allow_uncharge)
> > >>  {
> > >> -	struct obj_stock_pcp *stock;
> > >>  	unsigned int nr_pages = 0;
> > >>  
> > >> -	stock = trylock_stock();
> > >>  	if (!stock) {
> > >> -		if (pgdat)
> > >> -			__account_obj_stock(objcg, NULL, nr_acct, pgdat, idx);
> > >>  		nr_pages = nr_bytes >> PAGE_SHIFT;
> > >>  		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
> > >>  		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
> > >> @@ -3404,20 +3408,25 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> > >>  	}
> > >>  	stock->nr_bytes += nr_bytes;
> > >>  
> > >> -	if (pgdat)
> > >> -		__account_obj_stock(objcg, stock, nr_acct, pgdat, idx);
> > >> -
> > >>  	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
> > >>  		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> > >>  		stock->nr_bytes &= (PAGE_SIZE - 1);
> > >>  	}
> > >>  
> > >> -	unlock_stock(stock);
> > >>  out:
> > >>  	if (nr_pages)
> > >>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
> > >>  }
> > >>  
> > >> +static void refill_obj_stock(struct obj_cgroup *objcg,
> > >> +			     unsigned int nr_bytes,
> > >> +			     bool allow_uncharge)
> > >> +{
> > >> +	struct obj_stock_pcp *stock = trylock_stock();
> > >> +	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge);
> > >> +	unlock_stock(stock);
> > > 
> > > Hi Johannes,
> > > 
> > > I noticed that after this patch, obj_cgroup_uncharge_pages() is now inside
> > > the obj_stock.lock critical section. Since obj_cgroup_uncharge_pages() calls
> > > refill_stock(), which seems non-trivial, this might increase the lock hold time.
> > > In particular, could that lead to more failed trylocks for IRQ handlers on
> > > non-RT kernel (or for tasks that preempt others on RT kernel)?

Good catch. I did ponder this, but forgot by the time I wrote the
changelog.

> > Yes, it also seems a bit self-defeating? (at least in theory)
> > 
> > refill_obj_stock()
> >   trylock_stock()
> >   __refill_obj_stock()
> >     obj_cgroup_uncharge_pages()
> >       refill_stock()
> >         local_trylock() -> nested, will fail
> 
> Not really as the local_locks are different i.e. memcg_stock.lock in
> refill_stock() and obj_stock.lock in refill_obj_stock().

Right, refilling the *byte* stock could produce enough excess that we
refill the *page* stock. Which in turn could produce enough excess
that we drain that back to the page counters (shared atomics).

> However Hao's concern is valid and I think it can be easily fixed by
> moving obj_cgroup_uncharge_pages() out of obj_stock.lock.

Note that we now have multiple callsites of __refill_obj_stock(). Do
we care enough to move this to the caller?

There are a few other places with a similar pattern:

- drain_obj_stock(): calls memcg_uncharge() under the lock
- drain_stock(): calls memcg_uncharge() under the lock
- refill_stock(): still does full drain_stock()

All of these could be more intentional about only updating the per-cpu
data under the lock and the page counters outside of it.

Given that IRQ allocations/frees are rare, nested ones even rarer, and
the "slowpath" is a few extra atomics, I'm not sure it's worth the
code complication. At least until proven otherwise.

What do you think?

