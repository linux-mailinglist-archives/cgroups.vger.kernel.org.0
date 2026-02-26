Return-Path: <cgroups+bounces-14402-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBJhJguNn2nYcgQAu9opvQ
	(envelope-from <cgroups+bounces-14402-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 01:00:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 186C319F3A8
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 01:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C633E3022F76
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334133C199;
	Thu, 26 Feb 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AGlwvQuQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF35224B15
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064008; cv=none; b=LOQLTxpzTI+5En0Ihvuiqs7kr9ojR3Hj11uoRtIoDhywPdgDUBAPDkBxLpc19qqVu6tNrNUMLox7318xnEK3RJvZ96UE0doYsC1A/c/LSdVCgIJddstdud2oO/8v2IGk/XIfbzIYDvJVFckkfN4SSNqKBnhUVaNs7HFpEEO4cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064008; c=relaxed/simple;
	bh=ZwXkuLbNtBiV0ALMwk6j+6/MlReleR0M0iHtCFbRX9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwjofnk14B4fI8J+MC+cpSZ95xDe4360ji6sSuhI6tp+KHPkVZd5LULVPz0B4ghZzECx8fUySpY9sfsDRRSD61nZBwVkMUfLUOYlQi4LclM4W8kKOQK7cfGXhixaalAnqO2PtUafJaTieyLi0PTkk++MaqYMqvCVESCphMKkwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AGlwvQuQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 16:00:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772064004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wawHLyOTJp2IXUoV4PemjW87N7htBQucAPkl0+HuDtA=;
	b=AGlwvQuQN+0uaJ8qH6Ehe4SZQoqfoPvzfxZUrv6EIeE/o3WNCyvlzFuer5C/vTA6AgaKZ0
	PuynYss88Gi3ryI5Pyf/F0CDNjP1kRYJXCa498rcUE3Akd9vRJF7u3uSJLc2hAyQkRsCeY
	IVNZnkFwZxooMU9CqbvAUuui1X6shK0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/3] ptdesc: Account page tables to memcgs again
Message-ID: <aZ-Innu9a3ND6Pdq@linux.dev>
References: <20260225162319.315281-1-willy@infradead.org>
 <20260225162319.315281-4-willy@infradead.org>
 <aZ8oT-n4a8VDY2AH@linux.dev>
 <aZ9jHvd-kpnQzMgC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9jHvd-kpnQzMgC@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14402-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 186C319F3A8
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:01:18PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 25, 2026 at 08:55:54AM -0800, Shakeel Butt wrote:
> > >  #ifdef CONFIG_MEMCG
> > > -	unsigned long pt_memcg_data;
> > > +	struct mem_cgroup *pt_memcg;
> > 
> > This is kernel memory, so this would be struct obj_cgroup * instead of struct
> > mem_cgroup pointer. We will need something similar to __folio_objcg(), maybe
> > __ptdesc_objcg() and then call obj_cgroup_memcg() on it. Basically how
> > folio_memcg() handles the kernel memory.
> 
> Why would we want to do that instead of just stashing a pointer to the
> memcg in the ptdesc?

Not the memcg pointer but the objcg pointer, a bit background first though.

Underlying we are using alloc_pages_noprof(__GFP_ACCOUNT) and __free_pages() for
ptdesc, so allocation path looks like the following:

	alloc_pages_noprof(__GFP_ACCOUNT)
	...
		-> __alloc_frozen_pages_noprof(__GFP_ACCOUNT)
			-> __memcg_kmem_charge_page()
				-> page_set_objcg(page, objcg)

and page_set_objcg() is defined as 

static void page_set_objcg(struct page *page, const struct obj_cgroup *objcg)
{
	page->memcg_data = (unsigned long)objcg | MEMCG_DATA_KMEM;
}

page->memcg_data overlaps with ptdesc->pt_memcg_data, so we need remove
MEMCG_DATA_KMEM to get the objcg pointer.

If we want to store a pointer in struct ptdesc then we can't use the raw page
allocator/free functions. We have to allocate without __GFP_ACCOUNT and then do
the charging in __pagetable_ctor and uncharging in pagetable_dtor explicitly.

BTW we are trying to migrate from memcg pointers to objcg pointers in most of
the places due to zombie issue.

> I feel very stupid about the differences between
> all of these things and would dearly love to read some documentation to
> learn.

Unfortunetely we don't have a good documentation, just code.

