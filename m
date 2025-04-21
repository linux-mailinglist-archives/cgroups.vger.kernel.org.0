Return-Path: <cgroups+bounces-7688-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40DA959CC
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 01:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ED2189689A
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F41EB1AF;
	Mon, 21 Apr 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BNgBdr8x"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF683D81
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745278651; cv=none; b=TtwNdIsB19k+1jzwywkKoZWJ4Fs1wngOUZGWJhbQUJEE4sLrt2KlesjthqSfkNCQr4qbB3gmXatfeHVVJlrFiR1P208dtYmQ0z8Ro6ORnEsv7VidnDKMzzXHa+lIgeEmx1Co+ltuBfnpewugV1N2T2BJpDDv9mNDpWgtW6qDQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745278651; c=relaxed/simple;
	bh=sbdGaZBNt2XEezDh/c1AFkYPOuGhzPfaiFGITKsQVTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhJYXCr3hxww8zGVqGYS7uEbjN5ylPRdp8CAkl7eAzOJRtVas4bzKWdoIlPGMPzASrvAFDSG2+ZlopjbCeuJccgw8mlamykwyqaCjlWRYVi6j+S0ah4sP6QZwJ0JuRQyYPQ+Q/f54m8A0KMminwZc402YNRfEqllwFJM5mZ3qDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BNgBdr8x; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 16:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745278646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iW0sWcGO1gvbOk/e+2PSHbPGtHAbNinELqlnlzCeUE=;
	b=BNgBdr8xLToLSABGJHQDRuIA1Sq5RmsJowUKjIfx8BKCbe6T5+LPm7rBUKmpR3OuqUJ7aI
	t3lscJp1GXo+um63hz1T9nA6zl8Y+Syh0+xRWNRQLEPLJZENn8R8zf2JogqBNBs2h0Vq5W
	R8g3EF3ywZlfQzMPMlm6P29ANQ7yXy8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, longman@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <snxed24sts5vsrcgi3aajxgngaswe2dtzf4kacfq7nyzc4aayt@4fmqp7i4gs3b>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419053824.1601470-3-gourry@gourry.net>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
>  static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		struct pglist_data *pgdat, struct scan_control *sc,
> -		struct reclaim_stat *stat, bool ignore_references)
> +		struct reclaim_stat *stat, bool ignore_references,
> +		struct mem_cgroup *memcg)
>  {
>  	struct folio_batch free_folios;
>  	LIST_HEAD(ret_folios);
> @@ -1109,7 +1116,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  	folio_batch_init(&free_folios);
>  	memset(stat, 0, sizeof(*stat));
>  	cond_resched();
> -	do_demote_pass = can_demote(pgdat->node_id, sc);
> +	do_demote_pass = can_demote(pgdat->node_id, sc, memcg);

For code paths where we might have folios of different memcgs in
folio_list, should we look at individual folios for their memcgs or is
it ok to ignore such cases? If we are ignoring then let's add a comment
about that.


