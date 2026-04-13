Return-Path: <cgroups+bounces-15272-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBTRCBwj3WkYaQkAu9opvQ
	(envelope-from <cgroups+bounces-15272-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 19:08:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 696883F0D2D
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 19:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B5B31BB48B
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D1A30FC1E;
	Mon, 13 Apr 2026 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ehz/0s4n"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F22230E0FD
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098662; cv=none; b=k+7UVjNdEGJWVXSYpKxWa1JZtg/USeDCOlgFtP6xuu36R6zWuJBGR9owdhRvW8+cdyWdCOn633D6UuMdlN0p7h+rarCzejmGxItBJa7eGFzSfO1kqE6cX6phOFxlvsKiIXLLKy5euAkYRMgf9Q/CCLh3oisGKEPndf7KTPrUczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098662; c=relaxed/simple;
	bh=Xw9cQjk7v9b+/21yZ5WNQQyLvc6VPCIYYVNOd12Snq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJsoSEUJ5xDELEXONwfAUvi0aeBLnECV/LZTvZ9pFo3Aj6edzR8x5iXYRdBoYIbVkoTkyOWc7QNgEx6FS41uqfMYtwnGX4mbboHNzqTnjtIzErAG5DoSWJJUq3ulVXBJvylbl9NRvaVWWuLDo13nO15pD40pNB4f5xI2hIYgdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ehz/0s4n; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Apr 2026 09:44:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776098659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGD68R6Uf2ICmpKMNcReMOAnqjM0xbCg+mOS+G4WF7w=;
	b=Ehz/0s4nbqoB9CGWCN3L7jXsJGgyREW1oQeAdzzWQFJFw0dMRCGLsNZUvGNBNiudpCqSIw
	mZu/ZZDPolx7I98I1SkSzYq1LeNPLPC4RlBaIOzREx9xxy72ByOHWQ+nmyyxJtlvX2BPcm
	OK2sR2tA1Es9QNyYOBhkeH2MC3z4wMM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Cao Ruichuang <create0818@163.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/memcontrol: restore irq wrapper for
 lruvec_stat_mod_folio()
Message-ID: <ad0clnEYxf1H4_S1@linux.dev>
References: <20260413064833.964-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413064833.964-1-create0818@163.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15272-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups,1a3353a77896e73a8f53];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 696883F0D2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 02:48:33PM +0800, Cao Ruichuang wrote:
> Commit c1bd09994c4d ("memcg: remove __lruvec_stat_mod_folio") removed
> the local_irq_save/restore wrapper around lruvec_stat_mod_folio(), based
> on the assumption that the underlying stat update path was already
> IRQ-safe.

Why is that an assumption? Please explain how lruvec_stat_mod_folio() is not
safe against IRQs?

> 
> That assumption is too broad for lruvec_stat_mod_folio() callers.
> This helper is not just a thin stat primitive.  It also resolves
> folio -> memcg -> lruvec under a helper-managed RCU read-side section.
> 
> syzbot now reports a PREEMPT_RT warning from:

The syzbot link you have provided has the kernel config without PREEMPT_RT?
Where does this claim come from?

> 
>   __filemap_add_folio()
>     -> lruvec_stat_mod_folio()
>        -> __rcu_read_unlock()
> 
> ending in bad unlock balance / negative RCU nesting.

If there is bad unlock balance, how is disabling/enabling IRQs would solve that
issue?


