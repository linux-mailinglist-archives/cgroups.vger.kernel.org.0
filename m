Return-Path: <cgroups+bounces-1218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE202838A62
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 10:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BEDB238E4
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A91859B5D;
	Tue, 23 Jan 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S+BrXl9K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S+BrXl9K"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8959B4C;
	Tue, 23 Jan 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002420; cv=none; b=AW5dlAvX5/9XJ3j6YG1rSTE3EHwUg1YXMlyCsrOYSHVWBmozGppQhtTLeip12OCZbVbPq1/Eq/MByxJV0kO1119C0HIRdlm/enFCqUeQFDQEqhhvwzeYChT34V7nLuzb0U3BM7/uLTKi3JFwoKs1yXBlrt8DJ6F5Y/IVfrv5MPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002420; c=relaxed/simple;
	bh=2KnS/m/aJXF9pgC7sa33Pkk2SdNYQMgvjyWG/WyoxTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqMPnLs3ItmhDv5lsRW81fvzHegP85mwv4+l9VsqzC5/d2braGMMR82/VGdw0Ecvc8r1wYi9igxjkWiLETxWJRuUUQ6v9SrW0g8SUsqVPF3LdGSsbebJFQ1gBso4tLVurBENLX5n7RFNaUJfOGyBoD3QX+IPh8/tBy/RMwGOqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S+BrXl9K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S+BrXl9K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3249622177;
	Tue, 23 Jan 2024 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706002417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vr0dVSL74POTu+Iy/t8VsndcOHjm5FnK2rIR21aIjBA=;
	b=S+BrXl9K9p1cn9yvSqLBO6VScZ2ywrf6is1PxTTlOrOQLKR/o1eBgNPpxkLlrCuQiXFQQl
	ppba9WHp4P1Rk+Xl+nS5t5H/PqltWHfRSpGhUke8SVx0Y9i2fBBGEWEMzWKRzzqxG8e32f
	9YiuDQWiNDXvvemyB6ndXo393rAodMo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706002417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vr0dVSL74POTu+Iy/t8VsndcOHjm5FnK2rIR21aIjBA=;
	b=S+BrXl9K9p1cn9yvSqLBO6VScZ2ywrf6is1PxTTlOrOQLKR/o1eBgNPpxkLlrCuQiXFQQl
	ppba9WHp4P1Rk+Xl+nS5t5H/PqltWHfRSpGhUke8SVx0Y9i2fBBGEWEMzWKRzzqxG8e32f
	9YiuDQWiNDXvvemyB6ndXo393rAodMo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13D05136A4;
	Tue, 23 Jan 2024 09:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bXbOAfGHr2VMBwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 23 Jan 2024 09:33:37 +0000
Date: Tue, 23 Jan 2024 10:33:36 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com,
	yuzhao@google.com, yangyifei03@kuaishou.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
Message-ID: <Za-H8NNW9bL-I4gj@tiehlicka>
References: <20240121214413.833776-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121214413.833776-1-tjmercier@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S+BrXl9K
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 3249622177
X-Spam-Flag: NO

On Sun 21-01-24 21:44:12, T.J. Mercier wrote:
> This reverts commit 0388536ac29104a478c79b3869541524caec28eb.
> 
> Proactive reclaim on the root cgroup is 10x slower after this patch when
> MGLRU is enabled, and completion times for proactive reclaim on much
> smaller non-root cgroups take ~30% longer (with or without MGLRU).

What is the reclaim target in these pro-active reclaim requests?

> With
> root reclaim before the patch, I observe average reclaim rates of
> ~70k pages/sec before try_to_free_mem_cgroup_pages starts to fail and
> the nr_retries counter starts to decrement, eventually ending the
> proactive reclaim attempt.

Do I understand correctly that the reclaim target is over estimated and
you expect that the reclaim process breaks out early>

> After the patch the reclaim rate is
> consistently ~6.6k pages/sec due to the reduced nr_pages value causing
> scan aborts as soon as SWAP_CLUSTER_MAX pages are reclaimed. The
> proactive reclaim doesn't complete after several minutes because
> try_to_free_mem_cgroup_pages is still capable of reclaiming pages in
> tiny SWAP_CLUSTER_MAX page chunks and nr_retries is never decremented.

I do not understand this part. How does a smaller reclaim target manages
to have reclaimed > 0 while larger one doesn't?
 
> The docs for memory.reclaim say, "the kernel can over or under reclaim
> from the target cgroup" which this patch was trying to fix. Revert it
> until a less costly solution is found.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4c8735e7c85..cee536c97151 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6956,8 +6956,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			lru_add_drain_all();
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> -					GFP_KERNEL, reclaim_options);
> +						nr_to_reclaim - nr_reclaimed,
> +						GFP_KERNEL, reclaim_options);
>  
>  		if (!reclaimed && !nr_retries--)
>  			return -EAGAIN;
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

-- 
Michal Hocko
SUSE Labs

