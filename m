Return-Path: <cgroups+bounces-15192-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBdnJFDO1Wm/+AcAu9opvQ
	(envelope-from <cgroups+bounces-15192-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 05:41:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66F3B69C7
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 05:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A52F302B745
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2026 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FD34DB59;
	Wed,  8 Apr 2026 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHQpQSC6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3F34D90C
	for <cgroups@vger.kernel.org>; Wed,  8 Apr 2026 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775619630; cv=none; b=h6ep6XaTrOy4BryGPY/jdaj7As5Qqa11KPrPCFA9/zBe2L9cbtin7ld+ryhFlnlxLCtgDtr5/wJwQs5Bq3qDxE9RkBYq+Vdoykfc7iHlvmz/PgiLxHZY0B1h1IjfQ9GaGbBa91zKdE7VCnJuM3gri6J0AyoE4RKZZlDme9qQ3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775619630; c=relaxed/simple;
	bh=FAyaFLd89C3vKZnxSy4E7CWfgiELeM+2id1WIOxVxUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnI1diF8o5kJKPpgx6PRv/MNyFUiOkvu5B2bxEHa0IJrf1wO2GUMSxgOKwnLxNvoBMpRC0LFerQ0URbf+LaWD0spE/sXXMJ6wTjEvnGC4EEnmXtkcN2wsppEjANZDKnkjPQe2wYVZIuXDGRH4xow1W5ztbZ6UZ+Hx8u2s/RIAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHQpQSC6; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbba5076c8so2165051a34.0
        for <cgroups@vger.kernel.org>; Tue, 07 Apr 2026 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775619627; x=1776224427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Ds3pHng15kKOEJE0OjDpk2jM6or+3GmYgHlHYpLlk=;
        b=YHQpQSC6Y40ZByY5Fo9t14dus7r+tlir7qJnwG6ZfzfXuWczXhL6/6q2RQKiWqq9y6
         Hel2v8PeO9dgXLK+dnfRWeN1MUKHzxyLx0kFJRgBpQ6NYukxQpOJmxWk44M3KrimELkj
         HO005gqUlNcd/Qa3kI2eYS1GeSUQxmCpLrePrVuBBfhFwbwuYV4BgOD7l2L4yK5YLjsz
         aOXfUTiMRWwqxe+AY9VAh3q5LkK/QjZMpPxK1SjK4weeSYK1lBWl9OIHI/A6zgWBe16p
         OFBLbri5uSK994/Uk5RENDSGg3444b9TIfzsfNK9UDnKMkK45J4PuFIZNGd8TbMjpeLP
         LCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775619627; x=1776224427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8Ds3pHng15kKOEJE0OjDpk2jM6or+3GmYgHlHYpLlk=;
        b=Ll8I8VO8kEVCV7lkCtDU8RVWL3sjxAKYCcNEcSlknYQ70i7M5ztiDa48nStFt4KN3g
         E8JsKWNxY5ekHAfP6I0cTr0kvOuAbNN/qtH7b80LJGyIRkND7sjqnrz3OQqNT4xTv9mu
         nsDIRL+bLczN54bTal5NPtOFOE6yvgYVR4V5wGwlBQsF1LBl/aqIYj/Cz9n3Yu9lPXRi
         5G+dBge5W1XcaW2qPRArp9VtOxWO6qsIb8cANxLpNyTCdcwTIi5aMzciRuH50aLmt0VF
         VjZoaXgbtKATDu5XvnUAIILRvfdThQhKZHuwIvgSiobtdg8PH7IYtoRQhdPJomhd19lY
         s2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU7Gp0ZKxwOXgcaRV9dkfmBA5owXAnex9ytKxxAv43nQRwu0vVy/jl1MkE4QZOJwhpXD2jjrCY@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXEHc5fLjNRsiT2dpWErNrqwKn2gjLaBVhHt/NN5n8AUtdGRD
	JbTAhMduu+YiYAmjAnexahg5GOkvAjESl75BvcjW8FMTWMYvE8Hj9I1QWwRTUA==
X-Gm-Gg: AeBDievmj7SXze46UxlgDWLp6xF3D6HE7pcsJNyvwcJl4DWGZLZZlyzprG19xDiOAu1
	9vYy4WlmjZdNJkzZp3ZaeNTy3iPTlVDpo5LmWpxotFZtWmuTYrPorlSK2jMsStQ1ZdIG1GKhxdd
	JWV6iry8MUNFay67o5oLm3dSLRu1F4YRiQUSrQcEWdxJF7BfTOaZruWSA67FMMo2znP1oIQSluS
	7wSHNek2qGPcuVEoGUQ5kXv7lhQtdoDxXbbrzAmVnRZrscz8y0NZUVbh5+VAAtBnW2sQ1cCtJXd
	G3wrtZgOP7xjtKrbUQ/5TT3IGwLYOQEE6c0EAh65tBqjcSj0WZExVDv4xrPinORe1gHZgJSy7RG
	Iq+C5A6ryZ2SJNW2HPVeMm0dz3EL939Ewvp0roGyWK/l9QA3zCnKugcyU21SfdS0Fmq3JV528pr
	7l41GVViPBi+aUO3Zo56QBwQ==
X-Received: by 2002:a05:6830:391c:b0:7d7:419a:7ac8 with SMTP id 46e09a7af769-7dbb7517e0cmr11694018a34.15.1775619627529;
        Tue, 07 Apr 2026 20:40:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbed6c3512sm3988912a34.4.2026.04.07.20.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:40:26 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Date: Tue,  7 Apr 2026 20:40:24 -0700
Message-ID: <20260408034025.3317937-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <adXAG52R6WVHd0n9@hyeyoo>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15192-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2B66F3B69C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 11:40:27 +0900 "Harry Yoo (Oracle)" <harry@kernel.org> wrote:

> On Fri, Apr 03, 2026 at 08:38:43PM -0700, Joshua Hahn wrote:
> > enum memcg_stat_item includes memory that is tracked on a per-memcg
> > level, but not at a per-node (and per-lruvec) level. Diagnosing
> > memory pressure for memcgs in multi-NUMA systems can be difficult,
> > since not all of the memory accounted in memcg can be traced back
> > to a node. In scenarios where numa nodes in an memcg are asymmetrically
> > stressed, this difference can be invisible to the user.
> > 
> > Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> > to give visibility into per-node breakdowns for percpu allocations.
> > 
> > This will get us closer to being able to know the memcg and physical
> > association of all memory on the system. Specifically for percpu, this
> > granularity will help demonstrate footprint differences on systems with
> > asymmetric NUMA nodes.
> > 
> > Because percpu memory is accounted at a sub-PAGE_SIZE level, we must
> > account node level statistics (accounted in PAGE_SIZE units) and
> > memcg-lruvec statistics separately. Account node statistics when the pcpu
> > pages are allocated, and account memcg-lruvec statistics when pcpu
> > objects are handed out.
> > 
> > To do account these separately, expose mod_memcg_lruvec_state to be
> > used outside of memcontrol.
> > 
> > The memory overhead of this patch is small; it adds 16 bytes
> > per-cgroup-node-cpu. For an example machine with 200 CPUs split across
> > 2 nodes and 50 cgroups in the system, we see a 312.5 kB increase. Note
> > that this is the same cost as any other item in memcg_node_stat_item.
> > 
> > Performance impact is also negligible. These are results from a kernel
> > module which performs 100k percpu allocations via __alloc_percpu_gfp
> > with GFP_KERNEL | __GFP_ACCOUNT in a cgroup, across 20 trials.
> > Batched performs 100k allocations followed by 100k frees, while
> > interleaved performs allocation --> free --> allocation ...
> > 
> > +-------------+----------------+--------------+--------------+
> > |    Test     | linus-upstream |    patch     |     diff     |
> > +-------------+----------------+--------------+--------------+
> > | Batched     | 6586 +/- 51    | 6595 +/- 35  | +9 (0.13%)   |
> > | Interleaved | 1053 +/- 126   | 1085 +/- 113 | +32 (+0.85%) |
> > +-------------+----------------+--------------+--------------+
> > 
> > One functional change is that there can be a tiny inconsistency between
> > the size of the allocation used for memcg limit checking and what is
> > charged to each lruvec due to dropping fractional charges when rounding.
> > In reality this value is very very small and always lies on the side of
> > memory checking at a higher threshold, so there is no behavioral change
> > from userspace.
> > 
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  include/linux/memcontrol.h |  4 +++-
> >  include/linux/mmzone.h     |  4 +++-
> >  mm/memcontrol.c            | 12 +++++-----
> >  mm/percpu-vm.c             | 14 ++++++++++--
> >  mm/percpu.c                | 45 ++++++++++++++++++++++++++++++++++----
> >  mm/vmstat.c                |  1 +
> >  6 files changed, 66 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > index 4f5937090590d..e36b639f521dd 100644
> > --- a/mm/percpu-vm.c
> > +++ b/mm/percpu-vm.c
> > @@ -65,6 +66,10 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
> >  				__free_page(page);
> >  		}
> >  	}
> > +
> > +	for_each_node(nid)
> > +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> > +				-1L * nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
> 
> Can this end up with mis-accounting due to CPU hotplug?

Hey Harry, thanks for giving this patch a look!

Yes, definitely. I think the solution is just to charge based on possible
CPUs, even if that might lead to some inaccuracy (by however many CPUs
aren't online at that moment). Seems like that's what already happens
in memcg anyways, so I think this discrepancy is OK to tolerate.

Will spin up a v3! Thanks a lot, Harry! Have a great day : -)
Joshua

