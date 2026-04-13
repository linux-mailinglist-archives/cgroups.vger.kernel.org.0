Return-Path: <cgroups+bounces-15269-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HCuG1gA3Wk3YwkAu9opvQ
	(envelope-from <cgroups+bounces-15269-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 16:40:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C977A3ED635
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 16:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F253026322
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC43CE4A0;
	Mon, 13 Apr 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4DfiWaW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7F3D810F
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090603; cv=none; b=Jh/uAJSCtPZ3XXNsihY33kfiO06oqomm6kfQFeVx+wchr6QOGy6akXSKWbn4x0LClJAj+lDGO4Nz6Y2X0CnsaHw5+5JoLHrZrx+YnCQNggzJuMRhxlM1/46b0AJSGG5o94VXkfiiXxNiMS1KUg5nvy2PfipdJxpiTfhK/k+mfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090603; c=relaxed/simple;
	bh=Pvv0cj3HtpmgptOdThfCeXJjywKIHr7YY27o+Blw/5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5OYBZTpVMavU42DaqbEHIgwGUduK2WL8hgZu+orbAHpDvZ0p/sO1Ho3YuYMQuqQZRfMtW+LIA43IvPUawqcO2uxbyoKF5abde2piFHrtkCdy7O1cPTAtCtouNaIiRmGG/L1IiG0ea0uRsqoLpZdDlD9Ztmg0vVeWAol0cnXnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4DfiWaW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3275854fac.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776090601; x=1776695401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0ayyEFz5IFGW2l3yDhG5wSDGaciiRSS1hB04OlRr/E=;
        b=M4DfiWaWnFMf7j7/WqHhohiFCbSVenB7d92mZisvJerRtBxgiZ1ro5YeDzfThydoN+
         aDhr+U4IB/RCJ1ZE8P/ZSdliDZlmxLh1yGVaRnEom5V9QERYWxk/HWpYv99IhVORHwTf
         TgXcv77BuvobPhmCFgHiJ5hkADh+Tfs61uuzkEYdPL6qjNH15k9tDqgnGCumeeoHg6r+
         DrPiXv6R9O/iqMeJtpRLxzy6Ew1ioTa3irHdUhHmJq+ZdJz/uHOMDmG3jA0/k+edpCwi
         vAdFfAsSaSbgtRDW3xO+682CJ9qKgDQuBFBrV8+ahsbUHdMArX+8AdThW+z69Coec1T7
         pQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090601; x=1776695401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0ayyEFz5IFGW2l3yDhG5wSDGaciiRSS1hB04OlRr/E=;
        b=XI3+cB1mdmiP4MOjHqfP8bvcE/hrFv3xyk7YaH0MVywjIcOb0tN4jDh1wn0jqejvMl
         5UBKu6fFI4n3MBT6j8vbPCs5NC+sKiMC7j9p/jqRIk7tgq8y32LHIoxXSIJm7OcR8Ek1
         0z0xIcSNsjTp8ovggM3nunOZR8rbs9eaQr6USk1SPH4ywe3PPGJGCJ6oDVSvYk8AgSFW
         Uv/6EVzmMvOagxr/k6cZaSbsDkgRB5RMTUk0qHByVfLorxetkOEb6JMUJp7APRMbHKGT
         lorCuNEZ5FddeN0lN43+ifQRWyzYslnmf8cDA1L0H4T+pRgFTh2s4QOl8IK7QG8XY/DQ
         FSBA==
X-Forwarded-Encrypted: i=1; AFNElJ8xsR8DBKl4aHgWrlTT+QMDP9fslPvKbQjTjDNp9d6Js+cHh0aXYrICOqUWtIp750C4Yv6cwARb@vger.kernel.org
X-Gm-Message-State: AOJu0YyjnaG2SR5Nf79g7vp++nSY0dafa22/ycWOy02KBafMsdkPSP9p
	wSL9zT7EAsy5jKDZsPtdXYwFIXjs1NkfKliSUmbiTPqvXnhnyr/qBUow
X-Gm-Gg: AeBDieu1EaU5mPfyZsa9xXSNaxmwhLjm2sIC2bz0GltpvXFgnoUZOy2rIt5Ejw09we2
	FUTuuo4tUZo1Xf0BseF0W4Dabbaz5NmMZGICSMcp76Fq5wz4mRVQ69vCfhCufmF+YrhlAN5gqnR
	9Sv5DGhQCia6ZfVRooWi37WdRks9g62ySbaPHVBM3281JJvBLoCzPQyxHTKrjo6rgM1F+jwvZlc
	FSzqlGiEWlQ96CcBcx/rfPMaX1BGN1XCEDqjAdWG2wxzBRwv/53PkZC0xg6TI9oOyEjWSalCUQe
	TEn5LViCArPsFMTnJdtKZxCoEkXto5JBQo29qYzVK8d6Somd+0+cOIfLMNOwqBXSpZxzMlgkoyb
	G/D/HcH8deX7aboxmWE9xi9e2wyJoBDsAUGn1nmpPMY21tVHTECYh8zbQQh1JgbQNxDWlSXxowh
	1T+8LhJCP5cbNltpkjR/ONAEd1qzl80OGe
X-Received: by 2002:a05:6871:c929:b0:417:49da:7ff8 with SMTP id 586e51a60fabf-423e1160952mr7371472fac.34.1776090600683;
        Mon, 13 Apr 2026 07:30:00 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42403b8f87csm5884888fac.9.2026.04.13.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:30:00 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Michal Hocko <mhocko@suse.com>
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
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/8 RFC] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Mon, 13 Apr 2026 07:29:58 -0700
Message-ID: <20260413142958.2037913-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <adyZ-t4fiKFv_X5p@tiehlicka>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15269-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nr_memcg_stock:email]
X-Rspamd-Queue-Id: C977A3ED635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 09:23:38 +0200 Michal Hocko <mhocko@suse.com> wrote:

Hello Michal,

Thank you for your review as always!

> On Fri 10-04-26 14:06:54, Joshua Hahn wrote:
> > Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
> > allocations, allowing small allocations and frees to avoid walking the
> > expensive mem_cgroup hierarchy traversal on each charge. This design
> > introduces a fastpath to charge/uncharge, but has several limitations:
> > 
> > 1. Each CPU can track up to 7 (NR_MEMCG_STOCK) mem_cgroups. When more
> >    than 7 mem_cgroups are actively charging on a single CPU, a random
> >    victim is evicted, and its associated stock is drained, which
> >    triggers unnecessary hierarchy walks.
> > 
> >    Note that previously there used to be a 1-1 mapping between CPU and
> >    memcg stock; it was bumped up to 7 in f735eebe55f8f ("multi-memcg
> >    percpu charge cache") because it was observed that stock would
> >    frequently get flushed and refilled.
> 
> All true but it is quite important to note that this all is bounded to
> nr_online_cpus*NR_MEMCG_STOCK*MEMCG_CHARGE_BATCH. You are proposing to
> increase this to s@NR_MEMCG_STOCK@nr_leaf_cgroups@. In invornments with
> many cpus and and directly charged cgroups this can be considerable
> hidden overcharge. Have you considered that and evaluated potential
> impact?

This is a great point. I would like to note though, that for systems running
less than 7 leaf cgroups (I'm not sure what systems typically look like outside
of Meta, so I cannot say whether this is likely or not!) this change would
be an optimization since we allocate only for the leaf cgroups we need ; -)

But let's do the math for the worst-case scenario:
Because we initialize the stock to be 0 and only refill on a charge / 
uncharge, the worst-case scenario involves a workload that charges
to all CPUs just once, so that it is not enough to benefit from the
cacheing. On a very large system, say 300 CPUs, with 4k pages, that's
300 * 64 * 4kb = 75 mb of overcharging per leaf-cgroup.

This is definitely a serious amount of overcharging. With that said, I
would like to note that this seems like quite a rare scenario; what
would cause a workload to jump across 300 CPUs? For this to be a regression
it also has to be 8+ workloads all jumping around the CPUs and storing
not-to-be-used cache on all of them, and anything below that would still be
an optimization over the current setup.

Also, let's talk about what happens when we do reach the worst-case scenario.
Once we reach the degenerate state where the stock is charged and the workload
has no intention of running on the CPUs with idle cache, we would eventually
reach the failure branch of try_charge_memcg, which drains all stock!

So IMO, I think the issue of overcharging isn't too bad. It's very difficult
to reach the scenario where all CPUs are caching idle stock, and the existing
recovery mechanism in try_charge_memcg puts us right back into the optimal
scenario where none of the CPUs have stock, and we only refill those that
the workload runs on. I'll be sure to add this in the next spin of the series,
since I think it's important to note (the other overhead being the memory
that we have to allocate percpu for each of the stock structs, which is
only 2 words/cpu/memcg (including parents). But still worth noting explicitly!)

Above is the perspective from the system, in terms of memory pressure and
overcharging. From a user interpretability POV, I think there is a gap between
when a workload litters unused charge everywhere, but there is not enough
memory pressure to trigger a drain_all_stock, so a user might be confused
why their workload is using so much memory.

I think this could be a problem. Especially if there is a userspace
load balancer that schedules work based on how much memory the workload is
using. At Meta we use Senpai in userspace to create benevolent memory pressure
that should be enough to reap cold memory (and also idle stock), but I'm
wondering what this will mean for systems that don't have such cold memory
purging mechanisms. I'll think about this a little bit more.

> > 2. Stock management is tightly coupled to struct mem_cgroup, which
> >    makes it difficult to add a new page_counter to struct mem_cgroup
> >    and do its own stock management, since each operation has to be
> >    duplicated.
> 
> Could you expand why this is a problem we need to address?

Yes of course. So to give some context, I realized that stock was a bit
uncomfortable to work with at a memcg granularity when I tried to introduce
a new page counter for toptier memory tracking (in order to enforce strict
limits. I didn't explicitly note this in the cover letter because I thought
that there was a lot of good motivation aside from the specific use case
I was thinking of, so decided to leave it out. What do you think? : -)

I'm not a memcgv1 user so I cannot tell from experience whether this is a
pain point or not, but I also did find it awkward that one stock gated the
charges for two page_counters memsw and memory, which made the slowpath
incur double the hierarchy walks on a single stock failing, instead of keeping
them separate so that it is less likely for both the page hierarchy walks
to happen on a single charge attempt.

> > 3. Each stock slot requires a css reference, as well as a traversal
> >    overhead on every stock operation to check which cpu-memcg we are
> >    trying to consume stock for.
> 
> Why is this a problem?

I don't think this is really that big of a problem, but just something that
I wanted to note as a benefit of these changes. I remember being a bit
confused by the memcg slot scanning & traversal when reading the stock
code, personally I think being able to directly be able to attribute stock
to the page_cache it comes from, as well as not randomly evicting stock
could be helpful.

> Please also be more explicit what kind of workloads are going to benefit
> from this change. The existing caching scheme is simple and ineffective
> but is it worth improving (likely your points 2 and 3 could clarify that)?

I think that the biggest strength for this series is actually not with
performance gains but rather with more interpretable semantics for stock
management and transparent charging in try_charge_memcg.

But to break it down, any systems using less than 7 cgroups will get
reduced memory overhead (from the percpu structs) and comparable performance.
Any systems using more than 7 leaf cgroups will benefit because stock is
no longer randomly evicted and needed to refill.

From my limited benchmark tests, these didn't seem too visible from a
wall time perspective. But I can trace for how often we refill the stock
in the next version, and I hope that it can show more tangible results.

> All that being said, I like the resulting code which is much easier to
> follow. The caching is nicely transparent in the charging path which is
> a plus. My main worry is that caching has caused some confusion in the
> past and this change will amplify that by the scaling the amount of
> cached charge. This needs to be really carefully evaluated.

Thank you for the words of encouragement Michal!!!

On the point of cached charge, I hope that I've explained it above, I'll
think some more about that scenario as well. 

One last thing to note, that is orthogonal to our conversation here. Above,
I assumed 4k pages. But on systems with bigger base page sizes like 64k,
maybe it makes sense to lower the amount of stock that is cached. 
64 * 64kb = 4mb per CPU, maybe this is a bit overkill? ; -)

Thanks a lot for your thoughtful review, it is always appreciated.
I hope you have a great day!
Joshua

