Return-Path: <cgroups+bounces-16251-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFfINeOaFGo0OwcAu9opvQ
	(envelope-from <cgroups+bounces-16251-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 20:54:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD965CDD5C
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 20:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C503F3024CA4
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0492F383339;
	Mon, 25 May 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O1yTKEXi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03F2853EE
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735213; cv=none; b=PScbOLTdBdJODRukqjjVfJHl1zBcZAMD1M2C1vLwE9V0ltVInjNS437PkhFZv9sWX05YGAwMkEofosywdzvMQUNtyF0OwQlExWx/im6/JU3IGb0Gk8Gb98/cSp2KHigpLptdWCRWIHTFPhXL+8NR85Fi0YaXvlGwmznAh1ex8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735213; c=relaxed/simple;
	bh=uZ/a9wOrcFzd8WaLUwvevRTbcRArv3eeqfMViTtBiLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfFoVTOdeJM84I2oR19ToUm0QZ6PkZ0kHwZp1KImzDy2yf2MSvQqb9Oro7tIn8aU+6Zj6LmTGQ6j7LittRP7YwJa2NjQ0q7FXAT3HRcfRzI2AU9s9dDTHjIyHj8aj67oGJPNWP4MveYkrNvfFtAHoaVlKu0Cf7a9Jt1oTG8B2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O1yTKEXi; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 May 2026 11:53:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779735199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2QFQ7BTMixxlbnZQLMk0q07QCSPnGwVgu1LfJW46xE=;
	b=O1yTKEXiYPTNyv6AaTj2UJ3dxovLWFeTSxcS5+2a/sMNAEgp9JKVVdJkgXS52r6X/eiZW/
	4CRrMhT2imibry/fsmn289JH4y4N4lhomVSK7Jbjik/NQYIVNEi3GLri1bGLGhIhkB9T/O
	1US80fxDrb1H/26uabBheDAQazKm1pk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Harry Yoo <harry@kernel.org>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 0/4] memcg: shrink obj_stock_pcp and cache multiple
 objcgs
Message-ID: <ahSaKlJ04BYsayQZ@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
 <20260522193440.40e20563422afcc69b8445dd@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522193440.40e20563422afcc69b8445dd@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-16251-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3CD965CDD5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 07:34:40PM -0700, Andrew Morton wrote:
> On Thu, 21 May 2026 18:19:04 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> > per-node type") split a memcg's single obj_cgroup into one per NUMA
> > node so that reparenting LRU folios can take per-node lru locks. As a
> > side effect, the per-CPU obj_stock_pcp -- which caches a single
> > cached_objcg pointer -- thrashes on workloads where threads of the
> > same memcg run on different NUMA nodes. The kernel test robot reported
> > a 67.7% regression on stress-ng.switch.ops_per_sec from this pattern.
> > 
> > Commit d0211878ce06 ("memcg: cache obj_stock by memcg, not by objcg
> > pointer") landed as a temporary fix by treating sibling per-node
> > objcgs as equivalent for the cache lookup, intended to be reverted
> > once per-node kmem accounting is introduced. This series takes a more
> > general approach: cache multiple objcgs per CPU using the multi-slot
> > pattern memcg_stock_pcp already uses, so the per-node objcg variants
> > of one memcg can all coexist in the stock without ever forcing a
> > drain. The temporary fix can then be reverted.
> > 
> > To avoid increasing the per-CPU cache footprint, the first three
> > patches shrink the existing single-slot obj_stock_pcp fields.
> > The final patch converts cached_objcg and nr_bytes into
> > NR_OBJ_STOCK=5 slot arrays and reorders the struct so the entire
> > consume/refill/account hot path fits within a single 64-byte cache
> > line on non-debug 64-bit builds (verified with pahole).
> 
> Thanks, I added this to mm.git's mm-new branch, along with a couple of
> possible todo notes from the review.
> 
> Sashiko asked a thing:
> 	https://sashiko.dev/#/patchset/20260522011908.1669332-1-shakeel.butt@linux.dev
> 
> Did you already see this?  The footers there indicate that an email was
> sent out but I don't know if it works?

Yes, I saw that comment. It is kind of very specific to archs with 256KiB base
page sizes. Anyways, I have a simple fix for that and there were minor
suggestions from others for simple changes, I will send v3 with the requested
changes.

