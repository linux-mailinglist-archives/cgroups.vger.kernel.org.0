Return-Path: <cgroups+bounces-14738-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NWtLAg8sGmohQIAu9opvQ
	(envelope-from <cgroups+bounces-14738-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 16:43:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDEA253CE6
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 16:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FDC530E8741
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A843009ED;
	Tue, 10 Mar 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RJ70MCfZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6512FE582
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154409; cv=none; b=eCgIYj06H8niTbxFrUrYefPmgy2uQwg6D+yMXa0yErvi3wgpaggbaqS3s2fkProBqLrOVhRx+uSfMryW6IEKpZJqqLBxIpRbDDgvSnH/FBfvsb1AA9tR7dGGCsvRy1wNDnqZJA6HPHeeFZcAAZXmxAcVeDvJah+PXHW6IbpG3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154409; c=relaxed/simple;
	bh=TQArFFuZ9Y53LLXX2TEj4wDeBHlqJ/OFTLRPSNL9Vbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjbtkbjLQd6T7wXRLomD05hZNJD0UmBq3UV88z5Tk4ZIhUdjzmuSAonA22kHnxYatPmfc6Ink5zc0926YZPMcFu0Gup8I6R+AVAW/9TVrPqdiMVEvwu2M9vy1vLhZmaGAHiCvbkVTrZ3wznNuDXtzxymMjUQmR+9du8k1oiVSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RJ70MCfZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Mar 2026 07:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773154405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TwC6pQbU5gHuxh3zkLyr8F7z5S+cv/um/MQ7GFUg3ck=;
	b=RJ70MCfZUZ8oim853NhKIczs7H6wsAeJGmYw6yKIRMGVS7S/HlKGVccsLjpNf1rv3CDO2+
	MY/mrrZY1AH4PArNfzP67Y4oEkykaWnYAGNufGH5bp4JkvMeIYW25inkycGAXGc1plCYvY
	l3mPcmnI4yj1EuXY7C8AidiZzdkAz4g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com, 
	vbabka@suse.cz, apopple@nvidia.com, axelrasmussen@google.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, david@kernel.org, eperezma@redhat.com, gourry@gourry.net, 
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org, muchun.song@linux.dev, 
	zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev, surenb@google.com, 
	virtualization@lists.linux.dev, weixugc@google.com, xuanzhuo@linux.alibaba.com, 
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <abAmMjkZZLN9LXXM@linux.dev>
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <aa9aDGwk8YteaEob@linux.dev>
 <dcf2e654-ad2f-4390-9b62-078e664158de@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf2e654-ad2f-4390-9b62-078e664158de@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2CDEA253CE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14738-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:17:43PM -0700, JP Kobryn (Meta) wrote:
> On 3/9/26 4:43 PM, Shakeel Butt wrote:
> > On Fri, Mar 06, 2026 at 08:55:20PM -0800, JP Kobryn (Meta) wrote:
[...]
> > 
> > This seems like monotonic increasing metrics and I think you don't care about
> > their absolute value but rather rate of change. Any reason this can not be
> > achieved through tracepoints and BPF combination?
> 
> We have the per-node reclaim stats (pg{steal,scan,refill}) in
> nodeN/vmstat and memory.numa_stat now. The new stats in this patch would
> be collected from the same source. They were meant to be used together,
> so it seemed like a reasonable location. I think the advantage over
> tracepoints is we get the observability on from the start and it would
> be simple to extend existing programs that already read stats from the
> cgroup dir files.

Convenience is not really justifying the cost of adding 18 counters,
particularly in memcg. We can argue about adding just in system level metrics
but not for memcg.

counter_cost = nr_cpus * nr_nodes * nr_memcg * 16 (struct lruvec_stats_percpu)

On a typical prod machine, we can see 1000s of memcg, 100s of cpus and couple of
numa nodes. So, a single counter's cost can range from 200KiB to MiBs. This does
not seem like a cost we should force everyone to pay.

If you really want these per-memcg and assuming these metrics are updated in
non-performance critical path, we can try to decouple these and other reclaim
related stats from rstat infra. That would at least reduce nr_cpus factor in the
above equation to 1. Though we will need to actually evaluate the performance
for the change before committing to it.

