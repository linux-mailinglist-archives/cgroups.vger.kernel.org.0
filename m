Return-Path: <cgroups+bounces-16530-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHxUBbfPHWqjewkAu9opvQ
	(envelope-from <cgroups+bounces-16530-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 20:30:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F0623FE5
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A40733094324
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74233EA979;
	Mon,  1 Jun 2026 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="JvLlfMzc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F843E929C
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337859; cv=none; b=MukcBDy00CgeYuvVUacYcONPMbZglCGPw0c8NzEcGMkz7XXl2+/IbHMtuC8jxgs5ltz6Ya9MAXdTBbITFFraDYBJ7fYw8FePmXoF1yWUOFb8qKcFAIvMU0kBJDuE4dO4+z3GFYDcIs8fhslqStGztaJvDvmWkKp8b79AwWPBF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337859; c=relaxed/simple;
	bh=1/RNHbF9gcIr+25us1GUQ2ywJNe/LbwyGHURTAD4T+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZrk4EG3/9GmXaCIJJT2rmUOcUm3BNAeJsLwIGCA3iB7BzoNQpPa9S9Z2z5MuHteM0Xry0dq03Bhh6HrfBLrHoY2SQD57eBYsig0x+c69xxL45USTp6dfRx8Uyzkm1d/JgNr0eNk3UhQIEUDkxB6+evXBI3pQ2+tIAI8Tb3DZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=JvLlfMzc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9154ca1aa1dso227866585a.0
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1780337850; x=1780942650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NTSUw9VV/FBiRGz8GLXz2sTHCVhhPAhaYWRfzd8BYM=;
        b=JvLlfMzcKT/VjNz3lXSJioOrFWF8Do5Aba6OYsSHkxcW4neWOiDxBvcCMbOCbFKnsS
         iyJunp5DJ72eXclkGjbScOenRLlJ/Inip289RFaRG/9OIk8TRqdv8BYG8qGrEn7HX2Hu
         Yk0V4nTKusNSqXfZJqRi48DvoWRnyeYaAQiXJJWX94fsmXoxOhvSmDd/YW2EcRbCbSzR
         ZjuHWX0nc3FIIzo0Bz7KpnfCN4Sbo6/yver3CT6IJMY6o4BX+7jmvPhSqRJ19Cnc3QD8
         aCFO/6Dex6vq2VuKgIbeQjAhgxYF1bDJNaHtCt4K8bWtmcdWA/JZRh9xPvOk5U0jdtJM
         +M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337850; x=1780942650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NTSUw9VV/FBiRGz8GLXz2sTHCVhhPAhaYWRfzd8BYM=;
        b=KUlZNxk939PZBzQK6l7MwI4OqYzbBZNt3ZTupmtXkWvChDqxIGr4XC0hkX258gZ/GI
         XReY/bT0sRQjVCQP3lKKgS3cI3a/8E+gGeIsJW6MqfgtJErn3V/QWR5GHuw/OjJKxc+G
         EJHl4OpuS6KbEiUPD5AH2uF59NmKXj46fcvaBhTUusUcrBsmJJrVQvh9IQ+bgz9wpSVI
         KyBIvISLOaEpwBdEBZONWISClovGhzcJw4r3LJre1hrCPkFkjSxHP3F7U7q3FjluV4om
         90VLzBJtCE9TZP4hPyGiFwNAE117xGU5A1EBz0vbs+uL5tWQ9Y67g63ShZS4QZZ5w45R
         LvrA==
X-Forwarded-Encrypted: i=1; AFNElJ+P84f1lp+m+gdFNIJpzlH7UOR5Lw5aFlJ9nMRPmmRxX0YUUpFQspsXaUflzQkZNdTEQqBiD5pB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcz4ddtMl3GhWw6UuoaTMd3P/hYWsTofeAUA5fKpifFumOijgT
	glVwWapOkKi/VsJ0JeY5Yg0wN6f9yMX0EkLOMacofC358Y92J2VwDl/mu9xCiWnay+0=
X-Gm-Gg: Acq92OFeaBbU8qlcp4MjF8j2QwtsuhkxfxcoYIDTRlyZ27WnIP8QoXR8VONNeo8UHma
	oexFC6AZYdfSx2csYs0w9qMxrnzmiW3KUqyRQlUI3+tqGzbbfFQ7Q8Ks6OfX1xa89z4KpNf9LMY
	7CWBsfladWevM9GBGzf2E2o9kZF6P5U4CRx/N5BTRCWwvpQVqAnPVEs7HREA9b9arbg7HkctB25
	c3AH/u6IRntHj3r4qOJheGCp1+x5hDkLwD8jnIg69e5XYUxlxl3XyS4UxP3NJEo7EwoGYfcWX3W
	F2Fe/7SwtgGoXH5+us9GOJ+MnfFQCCdaKkErIxGH1gQP8zU/WtznDoNhy3uIxYeNv6MWdLU9a3x
	qz0v69XrZUcbNhpadJE0pVecbvIWNqQE27bjcjMV5sD7t0HkdaK1vdBvYj90WimezN8Bvw16sNi
	nV+uMEOllofJ94CdBeLbMmKKKkANOm2krI
X-Received: by 2002:a05:620a:444f:b0:915:4cb9:8e68 with SMTP id af79cd13be357-91577f2ec48mr98534785a.21.1780337850174;
        Mon, 01 Jun 2026 11:17:30 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153265d20csm1068654985a.46.2026.06.01.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:17:29 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:17:28 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, shakeel.butt@linux.dev,
	mhocko@kernel.org, david@fromorbit.com, roman.gushchin@linux.dev,
	muchun.song@linux.dev, qi.zheng@linux.dev, yosry.ahmed@linux.dev,
	ziy@nvidia.com, liam@infradead.org, usama.arif@linux.dev,
	kas@kernel.org, vbabka@kernel.org, ryncsn@gmail.com,
	zaslonko@linux.ibm.com, gor@linux.ibm.com, baohua@kernel.org,
	dev.jain@arm.com, npache@redhat.com, ryan.roberts@arm.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Message-ID: <ah3MuK3GuimKVORB@cmpxchg.org>
References: <20260527204757.2544958-10-hannes@cmpxchg.org>
 <20260601132135.14272-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601132135.14272-1-lance.yang@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16530-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 186F0623FE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 09:21:35PM +0800, Lance Yang wrote:
> 
> On Wed, May 27, 2026 at 04:45:16PM -0400, Johannes Weiner wrote:
> [...]
> >diff --git a/mm/swap_state.c b/mm/swap_state.c
> >index 04f5ce992401..9c3a5cf99778 100644
> >--- a/mm/swap_state.c
> >+++ b/mm/swap_state.c
> >@@ -465,6 +465,16 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
> > 		return ERR_PTR(-ENOMEM);
> > 	}
> > 
> 
> Shouldn't this be limited to anon swapin?
> 
> e.g. vmf && vma_is_anonymous(vmf->vma)
> 
> >+	if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> 
> __swap_cache_alloc() is also used by shmem direct swapin, so shmem can
> get here too when handling a large swap entry:
> 
> shmem_get_folio_gfp()
>   shmem_swapin_folio()
>     shmem_swap_alloc_folio()
>       swapin_sync()
>         swap_cache_alloc_folio()
>           __swap_cache_alloc()
>             folio_memcg_alloc_deferred()

Good catch, I think you're right. I shouldn't have dismissed that
branch due to "/* Direct swapin skipping swap cache & readahead */"

> @Baolin please correct me if I got it wrong :)
> 
> folio_memcg_alloc_deferred() itself doesn't filter shmem out either; it
> only allocates the memcg list_lru metadata for deferred_split_lru:
> 
> int folio_memcg_alloc_deferred(struct folio *folio)
> {
> 	if (mem_cgroup_disabled())
> 		return 0;
> 	return folio_memcg_list_lru_alloc(folio, &deferred_split_lru, GFP_KERNEL);
> }
> 
> Since deferred_split_lru only queues anon large folios, doing this for
> shmem swapin doesn't buy us anything :)

Yes, agreed. I don't think it's a big deal / show stopper in terms of
user-visible effect, but of course still worth fixing.

I'll send a follow-up patch.

