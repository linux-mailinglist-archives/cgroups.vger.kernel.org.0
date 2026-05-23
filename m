Return-Path: <cgroups+bounces-16229-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EtloK0kSEWovhAYAu9opvQ
	(envelope-from <cgroups+bounces-16229-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 04:34:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759D5BCBD2
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 04:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 262333017FA1
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 02:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3F9313E1B;
	Sat, 23 May 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c00/stR2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59879235BE2;
	Sat, 23 May 2026 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779503682; cv=none; b=PmUSxXro4mez4GRICeT+W11cPD3yC1lVze8PnijV1I1nVLQbepTc3c4Mh71L3T6+KXkRA0zN7ixeubxygxN6FpHkO9ymfkywmN6daT8raQf6whhrP+uKNU6YcUF1bIdoehC0bLnwmJ3eteCn2y5ewpmGz1KtJljaUfXsFiKFQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779503682; c=relaxed/simple;
	bh=2yL0knDMVjdfBsIs0Be4M2hJ7i08o4Wei+YgF+SzF7M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=goZvnI4LiATCPltwwjpGBYVlU9dHN4IlxfWDHCZ1ESpo51D2Xt8cowkqeUWYWqnKcmZoHSS7QOvQ5XIea6GOMD2pKAxXsYNJApNGPMs5h0gXJ3T/9q7zoB+vq/kUXuXkL4pnFj1+undaUd+8prknwJvQKgudxjUxZedXab3xw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c00/stR2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE351F000E9;
	Sat, 23 May 2026 02:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779503681;
	bh=mb+a0dDtdR5L7Q5VQ5CEa/NHANDWzSQ1aXqxFnIKIO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c00/stR2QqGSFKqYZZi4q67VKjGgv9VlpfTU41yaXPrVZfYQ4fQoEbwDmPvoxoalu
	 UO0r4ceZw/iVPZSVRvhPSLNQTgNczurkCiBjJYcdGLoOvb8QBwd6/u1Er61XRQf+PZ
	 /XaE/zdUUIC7tdk+MvV0O/G7EEmp3lcPD1tkyZZ4=
Date: Fri, 22 May 2026 19:34:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Alexandre Ghiti
 <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>, Harry Yoo
 <harry@kernel.org>, Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 0/4] memcg: shrink obj_stock_pcp and cache multiple
 objcgs
Message-Id: <20260522193440.40e20563422afcc69b8445dd@linux-foundation.org>
In-Reply-To: <20260522011908.1669332-1-shakeel.butt@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16229-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux-foundation.org:mid,linux-foundation.org:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 1759D5BCBD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 18:19:04 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> per-node type") split a memcg's single obj_cgroup into one per NUMA
> node so that reparenting LRU folios can take per-node lru locks. As a
> side effect, the per-CPU obj_stock_pcp -- which caches a single
> cached_objcg pointer -- thrashes on workloads where threads of the
> same memcg run on different NUMA nodes. The kernel test robot reported
> a 67.7% regression on stress-ng.switch.ops_per_sec from this pattern.
> 
> Commit d0211878ce06 ("memcg: cache obj_stock by memcg, not by objcg
> pointer") landed as a temporary fix by treating sibling per-node
> objcgs as equivalent for the cache lookup, intended to be reverted
> once per-node kmem accounting is introduced. This series takes a more
> general approach: cache multiple objcgs per CPU using the multi-slot
> pattern memcg_stock_pcp already uses, so the per-node objcg variants
> of one memcg can all coexist in the stock without ever forcing a
> drain. The temporary fix can then be reverted.
> 
> To avoid increasing the per-CPU cache footprint, the first three
> patches shrink the existing single-slot obj_stock_pcp fields.
> The final patch converts cached_objcg and nr_bytes into
> NR_OBJ_STOCK=5 slot arrays and reorders the struct so the entire
> consume/refill/account hot path fits within a single 64-byte cache
> line on non-debug 64-bit builds (verified with pahole).

Thanks, I added this to mm.git's mm-new branch, along with a couple of
possible todo notes from the review.

Sashiko asked a thing:
	https://sashiko.dev/#/patchset/20260522011908.1669332-1-shakeel.butt@linux.dev

Did you already see this?  The footers there indicate that an email was
sent out but I don't know if it works?

