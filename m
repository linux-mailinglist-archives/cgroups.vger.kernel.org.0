Return-Path: <cgroups+bounces-14385-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO4OCxJkn2lRagQAu9opvQ
	(envelope-from <cgroups+bounces-14385-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:05:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CB19D97C
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7B8F3018D4D
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A630DEA5;
	Wed, 25 Feb 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iufhk8Rr"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8016FF37
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053282; cv=none; b=eMteP+aB8/kmp58nDYZpLjtmXqQ/kREF5DWDO47PFQ4WgWV9rX3/E/hFd4w3SDPO0jNHpE0lYTa1U1VBsIWueodhzncyjVfCE5SNN9x+T4avmumE+CganuoUb8WEzoJ2RzPEBY3XVkmFNwacNxQKwUh+nPWc5iQ5aTarupZCM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053282; c=relaxed/simple;
	bh=bFs/wWJt+Kp1Z9WbeZg9b1w4j5LDmIP72Pt85sQzTRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMfQVwx9L9IxOUxAa0mv72+pI+F1+afu/Y1MpXh5xe5hdscmsT6Dwa2hJMK1zvX1m0Gu1FFS8vlzmSAQh6jsiKnFbwS3zm7V9xI4OGesH0/BpolRkuSLj8/tPp87UC1uYrubEGfHBRRr+jjX4st1J7BiHCfxQVp1j1vezWvUCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iufhk8Rr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ljBa12aKJZbgxi3pinlImLFV5DTWyizlkuBiwkvq884=; b=iufhk8RraGjWl5ATUPxdQHz3P7
	bfpVX//Bc/64PlMyPfKEIybRPQoIaX9LvBnYup1AlK7F+8ZkGo1ytfp+scPv+mQNIDWMwRgX6/pIS
	y4QBWY5LMcNx2x6H7XZ1P7KoD/xpcoWZNbyhKB8fGq8pSVe+/p/zIDQsga2jed42FVi/bH5MOoqdi
	7ylooKTJOBCbe1PMlPVeItWo4eAjRyUAdJMWqR4y5B+e/OOLLmzuWSPhZ+JOG+9k5w/w/p3UwUCCE
	CuR6DybrVMPYEiVgs/2LZFO7XWx0qhbkO6lAlxSrM4IpYkpfXHoaVEELOCLXRZvUwWxx4oMpB5eMg
	2HEZD/jg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvM0U-00000001eGe-2y1H;
	Wed, 25 Feb 2026 21:01:18 +0000
Date: Wed, 25 Feb 2026 21:01:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/3] ptdesc: Account page tables to memcgs again
Message-ID: <aZ9jHvd-kpnQzMgC@casper.infradead.org>
References: <20260225162319.315281-1-willy@infradead.org>
 <20260225162319.315281-4-willy@infradead.org>
 <aZ8oT-n4a8VDY2AH@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8oT-n4a8VDY2AH@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-14385-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out,90.155.50.34:query timed out,100.90.174.1:query timed out];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C21CB19D97C
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 08:55:54AM -0800, Shakeel Butt wrote:
> >  #ifdef CONFIG_MEMCG
> > -	unsigned long pt_memcg_data;
> > +	struct mem_cgroup *pt_memcg;
> 
> This is kernel memory, so this would be struct obj_cgroup * instead of struct
> mem_cgroup pointer. We will need something similar to __folio_objcg(), maybe
> __ptdesc_objcg() and then call obj_cgroup_memcg() on it. Basically how
> folio_memcg() handles the kernel memory.

Why would we want to do that instead of just stashing a pointer to the
memcg in the ptdesc?  I feel very stupid about the differences between
all of these things and would dearly love to read some documentation to
learn.

