Return-Path: <cgroups+bounces-15270-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE+1GqsL3WkZZAkAu9opvQ
	(envelope-from <cgroups+bounces-15270-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 17:28:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF263EDF3E
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84E9B300CFC3
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3FD3CCFD9;
	Mon, 13 Apr 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AQeZGQkP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583D3CAE8A
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094120; cv=none; b=Es/fhbf9vacEXfFh8Kn6LG7I3CM/kFNySEMpe9/HUHffBuIJ4NxwFIvOL06eS5ITLSdslWxpzsVzDoFFdyMyw6EeoDhJC1n+GNRrCp1WbT0GOMXpMvsvinHnOtOd1Elp/wPZH3ur+OAaE8rS86ghzN9yvdnbIzK1RIGH+S5gtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094120; c=relaxed/simple;
	bh=/z2vsGkuBMnx/La/Vbp1C6rg4cDiDCVcfCfF6edkQh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4C49wgc/XwWR7R63HPcbCaNSYYsA7Da3PxuTGwuAcLFdjKW8ZMqI6nXX62f1WtWOqfPkmiIRlAukjP5RAPNRJfQI/rpTvCZRkm3esq0EDP61kOJrrTN03W7dyphwr+wHGsPvCPkxagi8uFABKQ1EwVdm4lsUIJsSCnXq8/BrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AQeZGQkP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso48722255e9.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776094117; x=1776698917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wet7hLRLN2GT7pig65ujdZ2ffuA5bew4whWaQBopYTA=;
        b=AQeZGQkPOagAR/mHg8EEJtGATup/6TfesmVPsZDKJ1aQKPf/TIYz+dXabTafUJGb5a
         yD/BBgbd0LV90OT47w3VkodNYlBbXrfqzf0HznceOf+1/oVBiEMWZ2JQmxFwWswUsTyA
         SGo9GevW2yVIRJX7UcHFR629NZ6TDFJudTSsUZTULArYmYGPfagE7pmFCgJr3sv5aDet
         8RH4r8124zDvwDoWQVpfqNw91cvzS8pz02zaNLNPOx53eTFJLaczWQsyxX1Bs+jZqEB/
         F2QZRpKb8UZyUqk6cGyQEG6TF1cJob3aJMrGnDiRadcmn12OXVRJn170bqu84eMbESJv
         aTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094117; x=1776698917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wet7hLRLN2GT7pig65ujdZ2ffuA5bew4whWaQBopYTA=;
        b=k9HHwknFm5KDzgbs/haMT4XjFyHf+3+nNhCfy65tzif8hUa1R2hj8hezwjqUZM2Bu0
         iyFyHa6ZJckD5BmlzYq5grEeJ0FoBMdsuYLb1xQbiPlRGRaQ+NO60ilnoGveZGWMikQW
         8ZuPYphBrUU+yxIYPxgcgxVFwJ+0LsU4P/NzA3Ox3wg3J3FMzo/RoxZZmu2i3zUZW7Fq
         0YsznoLh5aacZrrlyktJNoXSLUVB4QJRg6PgzmYGekM/I11Ea5g97tTax768n0dagUvp
         e8174sTg+R9kIxEH5ZTOkd30fnW5h/5krrU12RM3W86cocmpMH4SCajcU8BoJV6M8F3x
         1Krg==
X-Forwarded-Encrypted: i=1; AFNElJ9ad6687Z9aA04C2kaL/zFQqi+dQBdmRcgpsw9qmc2mDBu0jhODD2FZlCcOR6EdOj54r6alL6g3@vger.kernel.org
X-Gm-Message-State: AOJu0YzybVlQx/PMEdCeXGEw/xw9Bcr3Ay7prrasORMWXtpKjmtSDkq3
	3gh4ePRu5QXyKkWqbL1q3wSPtxlWoMCK5YyUIektm5RCLvG0KCDxgPhtdv17/eY3odya/Zts3K5
	+Wj+R3iE=
X-Gm-Gg: AeBDietwyj3zG0TYsnPgS3W6EzyyqFRCzqSUkpZxwTJKVQ1CkVEfRb3zjeW60277KL7
	upEHxZrtbYhvRukHIiuT7l7PtmNSP6HGHsLyI90BcHPzmCatsE1Do/yWkbUCpefKPpKiAdJ3wdY
	37QM81e4O5LRVZcrRoXbo9Nzxvr6Lq7chVRNiQ6WFZDBBm3RaXGd5/kUBQlrHX95v8LlgNs+nwJ
	AAii00fT8q66odLKGnuHrLDWugbacqaJ4cVIhRVe3CFHorXVwUvoELJFEUfblGxIo5HGe8VofHD
	s1M7scOapXmNoJc4mkgOWTfg9bZ8Wn9tQajucX7mck+5g2Yt0PqoFhiJSN4V4DQw9GlAi+QIXNF
	PQ97f+P4pbgAjjMrf+KL1nTOtb0dm1npaUYYWzTxSRD0SD4zE1h5Pzv1EC7WzAniLpapQrjcLVW
	fv0fvEfCJ7OYvfoga3M5UJKpK/rZ+qo8iZ3ssHPJ+phlfJ
X-Received: by 2002:a05:600c:154d:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-488d685b6ddmr183708165e9.6.1776094116989;
        Mon, 13 Apr 2026 08:28:36 -0700 (PDT)
Received: from localhost (109-81-29-22.rct.o2.cz. [109.81.29.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm128558245e9.5.2026.04.13.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:28:36 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:28:35 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/8 RFC] mm/memcontrol, page_counter: move stock from
 mem_cgroup to page_counter
Message-ID: <ad0LoxXjP49PZBwR@tiehlicka>
References: <adyZ-t4fiKFv_X5p@tiehlicka>
 <20260413142958.2037913-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413142958.2037913-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15270-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CAF263EDF3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 13-04-26 07:29:58, Joshua Hahn wrote:
> On Mon, 13 Apr 2026 09:23:38 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> Hello Michal,
> 
> Thank you for your review as always!
> 
> > On Fri 10-04-26 14:06:54, Joshua Hahn wrote:
> > > Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
> > > allocations, allowing small allocations and frees to avoid walking the
> > > expensive mem_cgroup hierarchy traversal on each charge. This design
> > > introduces a fastpath to charge/uncharge, but has several limitations:
> > > 
> > > 1. Each CPU can track up to 7 (NR_MEMCG_STOCK) mem_cgroups. When more
> > >    than 7 mem_cgroups are actively charging on a single CPU, a random
> > >    victim is evicted, and its associated stock is drained, which
> > >    triggers unnecessary hierarchy walks.
> > > 
> > >    Note that previously there used to be a 1-1 mapping between CPU and
> > >    memcg stock; it was bumped up to 7 in f735eebe55f8f ("multi-memcg
> > >    percpu charge cache") because it was observed that stock would
> > >    frequently get flushed and refilled.
> > 
> > All true but it is quite important to note that this all is bounded to
> > nr_online_cpus*NR_MEMCG_STOCK*MEMCG_CHARGE_BATCH. You are proposing to
> > increase this to s@NR_MEMCG_STOCK@nr_leaf_cgroups@. In invornments with
> > many cpus and and directly charged cgroups this can be considerable
> > hidden overcharge. Have you considered that and evaluated potential
> > impact?
> 
> This is a great point. I would like to note though, that for systems running
> less than 7 leaf cgroups (I'm not sure what systems typically look like outside
> of Meta, so I cannot say whether this is likely or not!) this change would
> be an optimization since we allocate only for the leaf cgroups we need ; -)
> 
> But let's do the math for the worst-case scenario:
> Because we initialize the stock to be 0 and only refill on a charge / 
> uncharge, the worst-case scenario involves a workload that charges
> to all CPUs just once, so that it is not enough to benefit from the
> cacheing. On a very large system, say 300 CPUs, with 4k pages, that's
> 300 * 64 * 4kb = 75 mb of overcharging per leaf-cgroup.
>
> This is definitely a serious amount of overcharging. With that said, I
> would like to note that this seems like quite a rare scenario; what
> would cause a workload to jump across 300 CPUs? 

A typical situation I would expect this to be more visible is a large
machine hosting a lot of smaller containers. Not an untypical situation.

Without an external pressure those caches could accumulate a lot. On the
other hand a large machine the overall overcharging shouldn't cause the
memory depletion even if we are talking about 1000s of memcgs. The
behavior will change though and this is something you should explain
in your changelog. There will certainly be cons that we need to weigh
against pros. There are many good points below that you can use.
[...]

> > > 2. Stock management is tightly coupled to struct mem_cgroup, which
> > >    makes it difficult to add a new page_counter to struct mem_cgroup
> > >    and do its own stock management, since each operation has to be
> > >    duplicated.
> > 
> > Could you expand why this is a problem we need to address?
> 
> Yes of course. So to give some context, I realized that stock was a bit
> uncomfortable to work with at a memcg granularity when I tried to introduce
> a new page counter for toptier memory tracking (in order to enforce strict
> limits. I didn't explicitly note this in the cover letter because I thought
> that there was a lot of good motivation aside from the specific use case
> I was thinking of, so decided to leave it out. What do you think? : -)

Yes, if there are future plans that might benefit from this then this is
worth mentioning. Because just based on 1 I cannot really tell whether
going this way is better then tune NR_MEMCG_STOCK. As I've said I like
the resulting code better but there are some practical cons as well.

> I'm not a memcgv1 user so I cannot tell from experience whether this is a
> pain point or not, but I also did find it awkward that one stock gated the
> charges for two page_counters memsw and memory, which made the slowpath
> incur double the hierarchy walks on a single stock failing, instead of keeping
> them separate so that it is less likely for both the page hierarchy walks
> to happen on a single charge attempt.

v1 is legacy and we have decided to not invest into new
optimizations/feature long ago.

> 
> > > 3. Each stock slot requires a css reference, as well as a traversal
> > >    overhead on every stock operation to check which cpu-memcg we are
> > >    trying to consume stock for.
> > 
> > Why is this a problem?
> 
> I don't think this is really that big of a problem, but just something that
> I wanted to note as a benefit of these changes. I remember being a bit
> confused by the memcg slot scanning & traversal when reading the stock
> code, personally I think being able to directly be able to attribute stock
> to the page_cache it comes from, as well as not randomly evicting stock
> could be helpful.

OK so this boils down to code clarity.

> > Please also be more explicit what kind of workloads are going to benefit
> > from this change. The existing caching scheme is simple and ineffective
> > but is it worth improving (likely your points 2 and 3 could clarify that)?
> 
> I think that the biggest strength for this series is actually not with
> performance gains but rather with more interpretable semantics for stock
> management and transparent charging in try_charge_memcg.
> 
> But to break it down, any systems using less than 7 cgroups will get
> reduced memory overhead (from the percpu structs) and comparable performance.
> Any systems using more than 7 leaf cgroups will benefit because stock is
> no longer randomly evicted and needed to refill.
> 
> >From my limited benchmark tests, these didn't seem too visible from a
> wall time perspective. But I can trace for how often we refill the stock
> in the next version, and I hope that it can show more tangible results.

Another points for the changelog.
-- 
Michal Hocko
SUSE Labs

