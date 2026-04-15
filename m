Return-Path: <cgroups+bounces-15304-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GguHtr43mkNNAAAu9opvQ
	(envelope-from <cgroups+bounces-15304-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 04:32:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E00453FFCB6
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B76D7300E3D1
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E97D303C83;
	Wed, 15 Apr 2026 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihO8yONh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0B301486;
	Wed, 15 Apr 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220370; cv=none; b=A0bMrfLIaQVMulNbwz2sbmBds8YyEWL33olBiwDDmgjsyBcz7T2/WOkUd5K6Ed9e4iOguOhmDm6jPrhJb7mGvCNnRMJ1rkryoq3FcH31I3UPbng1lh6qxVgvq8jsBdsFKelBoPP2zTOV/48Lp5yarUUzm1am4s0aQPrwoHYmB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220370; c=relaxed/simple;
	bh=nJMDOKwUC4j12LbXLzHBYxV0fA5WtS3uw2VZtj0OTNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMeNB8hS1SLM5L1DJEcEYMHa58duvJhtDWHzHau7GErPfVE1HAGumBmEhj99KlHWh9o8dG1uxIJFEldOHIPbX6as16MDp3uYADjgavk4dBrF/VDzjEV+oIPhN+SfGVPLC0GybSaKinj509s5byXbyAQI2tHU4rJ5sPhDpqAq2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihO8yONh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4C3C19425;
	Wed, 15 Apr 2026 02:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776220370;
	bh=nJMDOKwUC4j12LbXLzHBYxV0fA5WtS3uw2VZtj0OTNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihO8yONhn73jqtT9LKoDI8ZQvx+l2ahTGx+fKK5FDeGDdx43suX9nWb1kgJ8GzZNg
	 u8OdnnwKye8rgsgGTLidab2SYSTZ0JyTtpayVtZLhqJZSuJVb1BscXnwA/XMEU17AZ
	 6gSKbcn16Qd+OXCnjbozDLpCyunvc2q62WycDcZB+dxiRCPVoXaHHxD1/1QB8Zr7hM
	 unRtpY/GXTc0v/nJKc/zI12bfcfdHIr14nQW4IJ1XRIfSM2O7oNU0sjWobavxiNuzZ
	 kRKKwRe7zayEqxVcUKN9cuv2/8h/Mb3ut3/8lyW9TMqBoy1+TDmwTYdFt0vTSmcfhq
	 /J6HZJ+NhBOKw==
Date: Wed, 15 Apr 2026 11:32:47 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>, Yosry Ahmed <yosry@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/percpu, memcontrol: Per-memcg-lruvec percpu
 accounting
Message-ID: <ad74z5aSkwxn9QQG@hyeyoo>
References: <20260404033844.1892595-1-joshua.hahnjy@gmail.com>
 <20260414202631.2753640-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414202631.2753640-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15304-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E00453FFCB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 01:26:31PM -0700, Joshua Hahn wrote:
> On Fri,  3 Apr 2026 20:38:43 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
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
> 
> [...snip...]
> 
> > @@ -55,7 +55,8 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
> >  			    struct page **pages, int page_start, int page_end)
> >  {
> >  	unsigned int cpu;
> > -	int i;
> > +	int nr_pages = page_end - page_start;
> > +	int i, nid;
> >  
> >  	for_each_possible_cpu(cpu) {
> >  		for (i = page_start; i < page_end; i++) {
> > @@ -65,6 +66,10 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
> >  				__free_page(page);
> >  		}
> >  	}
> > +
> > +	for_each_node(nid)
> > +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> > +				-1L * nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
> >  }
> >  
> >  /**
> > @@ -84,7 +89,8 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
> >  			    gfp_t gfp)
> >  {
> >  	unsigned int cpu, tcpu;
> > -	int i;
> > +	int nr_pages = page_end - page_start;
> > +	int i, nid;
> >  
> >  	gfp |= __GFP_HIGHMEM;
> >  
> > @@ -97,6 +103,10 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
> >  				goto err;
> >  		}
> >  	}
> > +
> > +	for_each_node(nid)
> > +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> > +				    nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
> >  	return 0;
> 
> Hello reviewers,
> 
> Since I submitted this, I have been thinking about the feedback that Sashiko
> has given this patch [1]. Harry has already pointed out the points about
> drifting due to CPU hotplug, but one there is one particular concern that
> I have been trying to tackle with no avail.
> 
> The issue is, pcpu allocations for CPUs on node A may actually fall back to
> node B, if node A is out of space and under pressure. This design seems to be
> intentional, to prevent memory pressure from failing these allocations.
> 
> However, this means that we cannot charge percpu memory based on the number
> of CPUs present on a node, because although the memory "belongs" to the node
> (since the CPU it actually belongs to is on the node), the memory can be
> serviced from elsewhere.

Ouch.

> To handle this, I've tried several approaches. All of them were either too
> expensive (iterating through all pages at allocation / free time)

How expensive was it compared to the baseline?

> or introduces
> new drift (I thought of managing per-chunk statistics as well).

How does it introduce a new drift?

> To be honest, I think I'm out of ideas at this point :/ So I wanted to see
> what others thought about how to track physical locations for pcpu allocations
> that were allocated via fallback. Are these rare enough that we are OK with
> the misattributing here? Should we eat the cost of iterating through all pages
> to find out where it is physically?
> 
> Or is this patch not worth pursuing at the moment? ; -)
> 
> I hope this all makes sense. Thank you all in advance!
> Joshua
> 
> [1] https://sashiko.dev/#/patchset/20260404033844.1892595-1-joshua.hahnjy%40gmail.com

-- 
Cheers,
Harry / Hyeonggon

