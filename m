Return-Path: <cgroups+bounces-16083-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IxtOnJuDGomhwUAu9opvQ
	(envelope-from <cgroups+bounces-16083-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 16:06:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB9F5803C6
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629A83078B16
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE63ED3CC;
	Tue, 19 May 2026 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k/Sf/ctN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A4029B79B
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199407; cv=none; b=LHJdL3Bt9O3MWIqdUcLuTJdsLIBUTAXEigtkQubD30SRO0jK7SlPVhOto8BVLhxWrAAXnDyjunYsdVo6jmWy8yATUSHkLMfXlknV2UIRMOpi8gI85CB6dO2iKXSshusL5tddtAh6v/v5lZRf5OIpldz89FCUuJPNKdOMIk8yeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199407; c=relaxed/simple;
	bh=OxYKVT+8P4ybN/wzn3h6yUrqje4l9mbayRiLtNAFPWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppFjHi/l+qCgnWlmRSmZ5YVB8KnSVePLZPK9QJosOcenl89cwfMdBWZCmCqQaJKEE+ZDIF1RvqfxGrV5UJuHIdX+gBrW9mbOVZDzviTFihXZNpL9OQix4R01OKjwDP90nSZcipxQsJtRCK9TtymDz6B/jVYApt61ao/aThJDj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k/Sf/ctN; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 May 2026 07:02:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779199391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLkJJxHnitGVDPhMID677Jv5DkOQCt8pQUC50Rx5KFQ=;
	b=k/Sf/ctN+0g0y8K/IpdbvTp1cYEfoUAApm7k/DJj6iPyQHQkBLM9gQ6ylpR0M2yakt6epr
	jI0VSIqp37yHfaJPa46xMDp3LZg9yTfFjrirJEbUePonoLShekskAYNYqheBsfSPWAFsG9
	Ukp0H+D0/xyn1dk/GrfPw8zgWZRKFFs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3] memcg: cache obj_stock by memcg, not by objcg pointer
Message-ID: <agxszIIN6FtK0fEb@linux.dev>
References: <20260518222827.110696-1-shakeel.butt@linux.dev>
 <aguiSnY3ie1y4nEl@linux.dev>
 <4e296262-fbbf-4ac7-aecc-3ef831583704@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e296262-fbbf-4ac7-aecc-3ef831583704@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16083-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7DB9F5803C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 03:46:51PM +0900, Harry Yoo wrote:
> 
> 
> On 5/19/26 8:41 AM, Shakeel Butt wrote:
> > On Mon, May 18, 2026 at 03:28:27PM -0700, Shakeel Butt wrote:
> > > Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> > > per-node type") split a memcg's single obj_cgroup into one per NUMA
> > > node, but the per-CPU obj_stock_pcp still keys cached_objcg by
> > > pointer. Cross-NUMA workloads now see a drain on every refill and a
> > > miss on every consume that targets a sibling per-node objcg of the
> > > same memcg, producing the 67.7% stress-ng switch-mq regression
> > > reported by LKP.
> > > 
> > > stock->nr_bytes are fungible across per-node objcgs of one memcg.
> > > Treat the cache as keyed by memcg in __consume_obj_stock() and
> > > __refill_obj_stock() so siblings share the reserve. Compare via
> > > READ_ONCE(objcg->memcg) directly: pointer-compare only, no deref, so
> > > the rcu_read_lock contract on obj_cgroup_memcg() does not apply.
> > > 
> > > Sharing the reserve without re-caching means bytes funded by one
> > > per-node objcg's slow path can be consumed/freed under a different
> > > sibling, leaving sub-page residue on whichever sibling was cached at
> > > drain time. The pre-existing obj_cgroup_release() path would WARN and
> > > silently drop that residue, leaking up to nr_node_ids * (PAGE_SIZE - 1)
> > > bytes per memcg lifecycle from the page_counter. Forward the residue
> > > into a per-node objcg of the same (post-reparent) memcg at release time
> > > instead, so it can be reconciled later via a refill atomic_xchg or
> > > another release; the chain terminates at root_mem_cgroup, whose
> > > page_counter has no enforced limit.
> > > 
> > > Please note that this is temporary fix and will be reverted when
> > > per-node kmem accounting is introduced.
> 
> ... because once per-node kmem accounting is introduced,
> "stock->nr_bytes are fungible across per-node objcgs of one memcg"
> no longer holds?

Yes

> 
> And the follow-up plain is to revert this and address it with a multi-objcg
> percpu stock [1], similar to a multi-memcg percpu charge cache we have now,
> right? (regardless of per-node kmem accounting's progress)
> 

Yes

> If this temporary fix imposes other potential correctness issues, would it
> make sense to land [1] in mainline before the next LTS release and skip this
> temporary fix?
> 
> [1] https://lore.kernel.org/oe-lkp/agtPMpQK2jXdQAY4@linux.dev
> 

The full clean solution might take one more cycle and I think we can not just
ignore 67% regression on 7.1.

