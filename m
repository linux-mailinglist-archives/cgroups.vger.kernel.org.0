Return-Path: <cgroups+bounces-15315-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHWnFTSj32miXAAAu9opvQ
	(envelope-from <cgroups+bounces-15315-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 16:39:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48140568C
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED763019525
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CC3D3322;
	Wed, 15 Apr 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEcRJ4Dh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0E3A3E99
	for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263627; cv=none; b=F95pX2D3A6K9MXQkL94r16ZLoz5ZRx5XQEdOurGVxL71MtV/hb5oMizZw2kT83h2qK3KdBEf9vtpgMRMSCQ08RGFxk4LWTJ3yKN2ipqWEKmfUON3o5a6p2KPNcDf9UxgzdOCi0J+2Ij/sxvXQLS4wCUxkDzuPBSLbFkcbKfEqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263627; c=relaxed/simple;
	bh=xeYCvVYl5EmlyGhsvk2ia+r2JwTVIu16RVm9l3KArIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ6eaf9bBT5yJFPwVEg2dzTzuoG8/LmhQCt/7VdWGRaxrL34/wZ3V2xlRDyFFjZ7ljhRUaPTdlNJB8aXpNWWRDBzbNaJLy0+hw2oB/1E2Uoo7gn0OntYeVQf6PIGEnE7Kx5TzEpaVEi7HWwg8UodjJ3SxhJks6mckAX1q1bDP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEcRJ4Dh; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so6095145a34.2
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776263624; x=1776868424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6++CI4laqgUkEu/9WjoRCFUvBg1ZLNaXzfHGKxYlnY=;
        b=jEcRJ4DhvYbumj7pOB8WPx8X5NRIIfgvSfIk/PFHyOfk9UDcLm4qSNZMicqZFuab2N
         Bw5SfQuip2+Hds/jvjfBp+fqdRFxrMR5yksMy0HrvXSTqhpKG9korBepZokfStATIbr7
         8hHwwg8WnoIx1WhKIO4uAsojPzEvOvr2P7W4aioEePLzdaUupwZzRj5Bod4GBAICjRrh
         Sd4ke2RVomjfaNo2KSN+tcnJAcjhdfEKPgVOfWr8vSU/JJM9Si+ayV9U2EreGN6uxjlo
         0zDTnVdPXX9ru8TMfWcp0ZC0UOqT9UPp50gTzHcpLbpC/oyVH/NIi1Vn40RryjA9yHWu
         pE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263624; x=1776868424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6++CI4laqgUkEu/9WjoRCFUvBg1ZLNaXzfHGKxYlnY=;
        b=Eq80H/5maKWeMSw8MgZr7BQCyHMx0GTNrOndwuixGMLkgUnXxElt/9WlC2uHZo0sBf
         9fjB0/mxCJuKg+P/1eJXz1Ie6cggiej5WqcY72Ul5yMqXj4vWOvyxiqxcUlVIE+darFM
         k1ii+r6IrDFvtX4QIa3oJkq6aXN4oo7+4DeI7YR1Kfxryj7orlFcXJ1y0pFVvNLBV55Y
         qry84xMJrrsqnbqTGKw6YwyL9yBaZ0hfrjC0HoKE3Eh2fL/21FTTEiLci/b76wG9/rqu
         qN44wBkcMzHZvE3sh8iIGaRyAwq7pBMGHIt+icJv8oD4e3zbJw6U80ZWQBJ7/W3EIkZ3
         5vnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9c3VeHl4DJj9EgFPsQB7kBcxlaIt8R+VegR+Bj9MFeHElRM/V0XZKuObqIuXWPi/tUbGxBeKG1@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcL+0ktNgWIuFvXPHIyVnqhLt/v/P9R4A9s+IGmsSFHlWEPP5
	IWFhaGk6VwpArlDSlve8iYgAa/sF97c8w753QVWxXiOmdknqK9lkL8AL
X-Gm-Gg: AeBDiet7O/WvN7mHXbpd6u+N6CGElPIFF6x49rkGq2C1WuvDPh5QtzrAUhVo6zYQxKI
	Nlo6Zj9Sm0VtbUn3yYXJiZ16g5TG4pbjcFzhi+k0MbKk9wgwDwSW0wuYr7BJnxdIANsMhNEnLm5
	5bvpT0y222/TRVrIXjtSbsRxj3FtiAoD8Av+hRVdmEzIzkziRtWdwlxrT4SUkJdAIn46Z4ni+5+
	wCUrJZg5BjMAHVxMgHpgVtVBLplFsnWfvTTPx3h3dB8tMfUQXU/d4Y64awnxfcbwtRCnJnd441r
	TAFFCvq2n6CuKo+et3WpzjFmJs+w8GTWHjck0918s0ckqpk6Wzvvii9xK61Ib83U7mAVMJFwCV8
	uAjlF7hPXckh8jQih5v3VWR+gpNCGRQET/GnZlrls90hKSluDLqa0sr6J40n96MZPybKrJh7blr
	Nu7h8JaVsk51h+kfx3Ljqa+A==
X-Received: by 2002:a05:6830:6ae9:b0:7d7:d8ca:c211 with SMTP id 46e09a7af769-7dc27dde06fmr13267298a34.1.1776263624373;
        Wed, 15 Apr 2026 07:33:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76a3612dsm1524656a34.10.2026.04.15.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:33:43 -0700 (PDT)
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
Date: Wed, 15 Apr 2026 07:33:41 -0700
Message-ID: <20260415143342.81714-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ad74z5aSkwxn9QQG@hyeyoo>
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
	TAGGED_FROM(0.00)[bounces-15315-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D48140568C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 11:32:47 +0900 "Harry Yoo (Oracle)" <harry@kernel.org> wrote:

> On Tue, Apr 14, 2026 at 01:26:31PM -0700, Joshua Hahn wrote:
> > On Fri,  3 Apr 2026 20:38:43 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > 
> > > enum memcg_stat_item includes memory that is tracked on a per-memcg
> > > level, but not at a per-node (and per-lruvec) level. Diagnosing
> > > memory pressure for memcgs in multi-NUMA systems can be difficult,
> > > since not all of the memory accounted in memcg can be traced back
> > > to a node. In scenarios where numa nodes in an memcg are asymmetrically
> > > stressed, this difference can be invisible to the user.
> > > 
> > > Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> > > to give visibility into per-node breakdowns for percpu allocations.
> > > 
> > > This will get us closer to being able to know the memcg and physical
> > > association of all memory on the system. Specifically for percpu, this
> > > granularity will help demonstrate footprint differences on systems with
> > > asymmetric NUMA nodes.
> > > 
> > > Because percpu memory is accounted at a sub-PAGE_SIZE level, we must
> > > account node level statistics (accounted in PAGE_SIZE units) and
> > > memcg-lruvec statistics separately. Account node statistics when the pcpu
> > > pages are allocated, and account memcg-lruvec statistics when pcpu
> > > objects are handed out.
> > 
> > [...snip...]
> > 
> > > @@ -55,7 +55,8 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
> > >  			    struct page **pages, int page_start, int page_end)
> > >  {
> > >  	unsigned int cpu;
> > > -	int i;
> > > +	int nr_pages = page_end - page_start;
> > > +	int i, nid;
> > >  
> > >  	for_each_possible_cpu(cpu) {
> > >  		for (i = page_start; i < page_end; i++) {
> > > @@ -65,6 +66,10 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
> > >  				__free_page(page);
> > >  		}
> > >  	}
> > > +
> > > +	for_each_node(nid)
> > > +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> > > +				-1L * nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
> > >  }
> > >  
> > >  /**
> > > @@ -84,7 +89,8 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
> > >  			    gfp_t gfp)
> > >  {
> > >  	unsigned int cpu, tcpu;
> > > -	int i;
> > > +	int nr_pages = page_end - page_start;
> > > +	int i, nid;
> > >  
> > >  	gfp |= __GFP_HIGHMEM;
> > >  
> > > @@ -97,6 +103,10 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
> > >  				goto err;
> > >  		}
> > >  	}
> > > +
> > > +	for_each_node(nid)
> > > +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> > > +				    nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
> > >  	return 0;
> > 
> > Hello reviewers,
> > 
> > Since I submitted this, I have been thinking about the feedback that Sashiko
> > has given this patch [1]. Harry has already pointed out the points about
> > drifting due to CPU hotplug, but one there is one particular concern that
> > I have been trying to tackle with no avail.
> > 
> > The issue is, pcpu allocations for CPUs on node A may actually fall back to
> > node B, if node A is out of space and under pressure. This design seems to be
> > intentional, to prevent memory pressure from failing these allocations.
> > 
> > However, this means that we cannot charge percpu memory based on the number
> > of CPUs present on a node, because although the memory "belongs" to the node
> > (since the CPU it actually belongs to is on the node), the memory can be
> > serviced from elsewhere.
> 
> Ouch.
> 
> > To handle this, I've tried several approaches. All of them were either too
> > expensive (iterating through all pages at allocation / free time)
> 
> How expensive was it compared to the baseline?

I haven't done any performance analyses, but the changes that were made required
every pcpu allocation to iterate over all the pages in a loop, and account the
page where it came from, whereas previously we didn't need to do any iteration,
just charging or uncharging based on the size. But maybe it's not so bad
after all, since these allocations should usually be pretty small.

Let me try running some tests to see what the absolute worst case scenario
regression would look like.

> > or introduces
> > new drift (I thought of managing per-chunk statistics as well).
> 
> How does it introduce a new drift?

The other approach I tried to do to avoid the iteration over pages was to
stash per-node counters per-chunk. But of course this doesn't work well if
we need to have statistics per-pcpu allocation, or if we change the ordering
of the charges based on the ordering of the chunk's pcpu allocations.

In any case, thanks for taking the time to check on the patch.
I'll try to spin up something soon!

Joshua

