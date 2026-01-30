Return-Path: <cgroups+bounces-13529-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OJ2NtX/e2lhJwIAu9opvQ
	(envelope-from <cgroups+bounces-13529-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:48:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96AB600C
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1664300AB05
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262522D73A7;
	Fri, 30 Jan 2026 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NfitKoMr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68174C9D
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769734098; cv=none; b=D6OVl3eEiZtuNxuYv6AaW2xa7fg5jWxqoBl1LIeH5wSkfp7o/VBBsZKaMfVyg+9ien9hffL+MYKgxM1JQXhX3lfkrAgPE0hJrrK1rpgS1+D4eBzIbb1OWGeoQXjFO/E2llZqqkCplL8cQM3YmUrhzf9fGbncmXLr5ImRWvudz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769734098; c=relaxed/simple;
	bh=yAVC74DfDR/zd4fiVB7+zar9cqE+QxyRqgD3p672vGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2YKQfCCug6T7zvE+IBGB4WQ/raUfGXRsu9t4z+Jb/X71SNMTEGwkVS+FzlpV2NZgriFSblCx9Df6VbcBCi3OkidQwgfaX2Q0IhaEp3PV6wINBRAE86rIo7Eki2KRpg7zW73v0dpVOm9YYhwLSbTIHaXhtKiK1pah1QePCdSIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NfitKoMr; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Jan 2026 16:47:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769734094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3A7pdALAafDL6kVov9I53Tgt62PET1/OP4Y8CWDvMKY=;
	b=NfitKoMrfWHJEnK3FhKbb+oShyVAZTBfjwr8XLV9TIyZokJxCNMF4keXeuZcm+Q1s3ZApR
	e0DX89ObAsutfv9yR9T+itV6cEKczkWp7+oz69T01XjFU4hWx10VmRx2m9MHnEtzVaek3r
	ZdzYZNot83emT4Xfld8CCUaVEqEFJBo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>, 
	Song Liu <songliubraving@fb.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix NR_FILE_PAGES accounting in
 collapse_file()
Message-ID: <aXv_HI8JM9mZCr4-@linux.dev>
References: <20260129184054.910897-1-shakeel.butt@linux.dev>
 <aXvjdArhPpUNF8BI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXvjdArhPpUNF8BI@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13529-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 3F96AB600C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:47:16PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 29, 2026 at 10:40:54AM -0800, Shakeel Butt wrote:
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> 
> Are you sure this is the right Fixes?  99cb0dbd47a1 wasn't cgroup
> aware:
> 
>         if (nr_none) {
>                 struct zone *zone = page_zone(new_page);
> 
>                 __mod_node_page_state(zone->zone_pgdat, NR_FILE_PAGES, nr_none);
> -               __mod_node_page_state(zone->zone_pgdat, NR_SHMEM, nr_none);
> +               if (is_shmem)
> +                       __mod_node_page_state(zone->zone_pgdat,
> +                                             NR_SHMEM, nr_none);
>         }
> 
> b8eddff8886b added cgroup support:
> 
>         if (is_shmem)
> -               __inc_node_page_state(new_page, NR_SHMEM_THPS);
> +               __inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
>         else {
> -               __inc_node_page_state(new_page, NR_FILE_THPS);
> +               __inc_lruvec_page_state(new_page, NR_FILE_THPS);
>                 filemap_nr_thps_inc(mapping);
>         }
> 
> which would seem like the right Fixes: to me?
> 

b8eddff8886b is about different stats NR_SHMEM_THPS & NR_FILE_THPS.
However as Johannes responded this code was broken even before memcg
awareness for NR_FILE_PAGES and NR_SHMEM.

I will send v2 with correct handling of NR_SHMEM as well.


