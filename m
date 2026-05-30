Return-Path: <cgroups+bounces-16472-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gABtNbM9Gmq02QgAu9opvQ
	(envelope-from <cgroups+bounces-16472-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 03:30:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE1E60AC6B
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 03:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887BD301C8A9
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492A238D52;
	Sat, 30 May 2026 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7MNhqe+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166B35957;
	Sat, 30 May 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104273; cv=none; b=emYOOsdP/xuErRiped5brKf1w/6Nrgx9J+/bKRCTso+2xE1snWC+gkAoGpEX3TISbSDxNh2IvUGG8fxyvFLK3VGVr0PoApmYAFefqRpp7oAtlX65Qe3siWYOOjAeIV7kosfN3eL9yYgpMO+sdvrRiFLQH0ByZNg7/6T/qn+I0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104273; c=relaxed/simple;
	bh=1l30HvXo0kYVZqRjbm6N31ktKokuNbwCCxVdwa+jLRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRcle8MHsIQzuqI2gAIqevCe958BGoEPMmviupnLdW0rbyowpIX/Th0ipHA6Yn3ddsHdZOa8b7Yq0Ni/DtYVPKwZcBkeXg9Dc5DTSrdDr5EMtFj/jG6txviByQKwx7aiw8PQQQN8kPWgxpNzAu9/nzY8tuihuwobCTDrJy+hpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7MNhqe+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0359A1F00893;
	Sat, 30 May 2026 01:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780104271;
	bh=//Pa32naUxmjScgI2Kd3HsHRQJ9KXrVWN/zHAstPObM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F7MNhqe+0Chu3B+AvEvjUu6v/Z/wPCHxWkFcmVFSzR7y0KprtUrixtAgwSjqlSncP
	 17wExybPZwPr+UICr9SQHV7lGdEbwdK8Gb25DsoMIXKZvNe/13nsb2jIo9HOpJjCA+
	 8FB+plkEkrQmZsZhpWPm24iqknsf0vGKdYid2c0QO81NFgA1DqBUzA5AYHzog2ZrZV
	 wmMtRvsayeFLK2F1VjvdguIfgME68J2Vm8Y9DTZaIJ/1ve3JzRhFv5/e1vpjgh7NAs
	 nHU0vjrFgtS2A30v9gZTqKDIweQRlw84bSGM5V7y1HBKCk5qOqAT5vlJotvK/djUfI
	 G3sqdHBY/s2Mg==
Date: Sat, 30 May 2026 01:24:29 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
Message-ID: <aho7nepN5jZtKmef@google.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526114601.67041-2-jiahao.kernel@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16472-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lixiang.com:email]
X-Rspamd-Queue-Id: 7FE1E60AC6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:45:58PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> The zswap background writeback worker shrink_worker() uses a global
> cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-robin
> across the online memcgs under root_mem_cgroup.
> 
> Proactive writeback also wants a similar per-memcg cursor that is
> scoped to the specified memcg, so that repeated invocations against
> the same memcg make forward progress across its descendant memcgs
> instead of restarting from the first child memcg each time.

Is this a problem in practice?

Is the concern the overhead of scanning memcgs repeatedly, or lack of
fairness? I wonder if we should just do writeback in batches from all
memcgs, similar to how reclaim does it, then evaluate at the end if we
need to start over?

> 
> Naturally, group the cursor and its protecting spinlock into a
> zswap_wb_iter struct, and make it a member of struct mem_cgroup to
> realize per-memcg cursor management. Accordingly, shrink_worker() now
> uses the lock and cursor in root_mem_cgroup->zswap_wb_iter.

If we really need to have per-memcg cursors (I am not a big fan), I
think we can minimize the overhead by making the cursor updates use
atomic cmpxchg instead of having a per-memcg lock.

> 
> Because the cursor is now per-memcg, the offline cleanup must visit
> every ancestor that could be holding a reference to the dying memcg.
> Factor out __zswap_memcg_offline_cleanup() and walk from dead_memcg up
> to the root.

Another reason why I don't like per-memcg cursors. There is too much
complexity and I wonder if it's warranted. If we stick with per-memcg
cursors please do the refactoring in separate patches to make the
patches easier to review.

Thanks!


