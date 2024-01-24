Return-Path: <cgroups+bounces-1226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B6183A382
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 08:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0801E1F216AC
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D9168DF;
	Wed, 24 Jan 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d9yJYnB8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d9yJYnB8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66440168D7;
	Wed, 24 Jan 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082649; cv=none; b=bVNvzbjUJ+P4oX2QlB9bxfooCA9+FMBxpkmt1dSBOB49xlNmrw3QDKUE4KDYjA785xlUQStxcHvQDE/fJRD/zbXMMcpujj0MaXxQ+p1QQfQHlDOs3dnmDXXvTxAiN83X5Eju2raAPF4ORMwiP4+o/rSMuJ+BphxGEYPeNySu7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082649; c=relaxed/simple;
	bh=cC2LHOBYxvF1gJoW39qXQupPj84QBL5OBB3dmmbB0Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQYwz3/s64p1+KZUafpobl1iZajrXwRGY2dQOiSAWkOmJH8usnoz1UKk+SBnKJmbPSFkLi06T/tZPKTsV/T3OJXImAD5NfpzHKxxcUUZGCzosxaKX24uD6VMCeAr4CcAZalLPxCzywWHRroNePs3cGipyVJtdJJjjd+DrWerH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d9yJYnB8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d9yJYnB8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C8D021EB6;
	Wed, 24 Jan 2024 07:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706082644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUY8xqCzF/ho9H6VnM7nIW3YTPMmxBLu+pNBzIkIdWc=;
	b=d9yJYnB8gVI3nNOhaiezeRXyIDCwE3OFGeee6sYMbH9eTyPTWPGRq6gf/75o5M7uWPSftQ
	1ItK3LWFd4chp+82V2UIy8EDmTrYn42Lv1IelQop4bBQJMiUBj8ICT99u3/PMD1maW8bMe
	wPcoLOpfnPIdANtQ1Q6tjip8lUE7k4Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706082644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUY8xqCzF/ho9H6VnM7nIW3YTPMmxBLu+pNBzIkIdWc=;
	b=d9yJYnB8gVI3nNOhaiezeRXyIDCwE3OFGeee6sYMbH9eTyPTWPGRq6gf/75o5M7uWPSftQ
	1ItK3LWFd4chp+82V2UIy8EDmTrYn42Lv1IelQop4bBQJMiUBj8ICT99u3/PMD1maW8bMe
	wPcoLOpfnPIdANtQ1Q6tjip8lUE7k4Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 098771333E;
	Wed, 24 Jan 2024 07:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vhqROlPBsGWhXAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 24 Jan 2024 07:50:43 +0000
Date: Wed, 24 Jan 2024 08:50:43 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "T.J. Mercier" <tjmercier@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com,
	yuzhao@google.com, yangyifei03@kuaishou.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
Message-ID: <ZbDBU_1BcLkKmLbA@tiehlicka>
References: <20240121214413.833776-1-tjmercier@google.com>
 <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
 <20240123164819.GB1745986@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123164819.GB1745986@cmpxchg.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=d9yJYnB8
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2C8D021EB6
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 11:48:19, Johannes Weiner wrote:
> The revert isn't a straight-forward solution.
> 
> The patch you're reverting fixed conventional reclaim and broke
> MGLRU. Your revert fixes MGLRU and breaks conventional reclaim.
> 
> On Tue, Jan 23, 2024 at 05:58:05AM -0800, T.J. Mercier wrote:
> > They both are able to make progress. The main difference is that a
> > single iteration of try_to_free_mem_cgroup_pages with MGLRU ends soon
> > after it reclaims nr_to_reclaim, and before it touches all memcgs. So
> > a single iteration really will reclaim only about SWAP_CLUSTER_MAX-ish
> > pages with MGLRU. WIthout MGLRU the memcg walk is not aborted
> > immediately after nr_to_reclaim is reached, so a single call to
> > try_to_free_mem_cgroup_pages can actually reclaim thousands of pages
> > even when sc->nr_to_reclaim is 32. (I.E. MGLRU overreclaims less.)
> > https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/
> 
> Is that a feature or a bug?
> 
>  * 1. Memcg LRU only applies to global reclaim, and the round-robin incrementing
>  *    of their max_seq counters ensures the eventual fairness to all eligible
>  *    memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().
> 
> If it bails out exactly after nr_to_reclaim, it'll overreclaim
> less. But with steady reclaim in a complex subtree, it will always hit
> the first cgroup returned by mem_cgroup_iter() and then bail. This
> seems like a fairness issue.

Agreed. We would need to re-introduce something like we used to have
before 1ba6fc9af35bf.

> We should figure out what the right method for balancing fairness with
> overreclaim is, regardless of reclaim implementation. Because having
> two different approaches and reverting dependent things back and forth
> doesn't make sense.

Absolutely agreed!

> Using an LRU to rotate through memcgs over multiple reclaim cycles
> seems like a good idea. Why is this specific to MGLRU? Shouldn't this
> be a generic piece of memcg infrastructure?
> 
> Then there is the question of why there is an LRU for global reclaim,
> but not for subtree reclaim. Reclaiming a container with multiple
> subtrees would benefit from the fairness provided by a container-level
> LRU order just as much; having fairness for root but not for subtrees
> would produce different reclaim and pressure behavior, and can cause
> regressions when moving a service from bare-metal into a container.
> 
> Figuring out these differences and converging on a method for cgroup
> fairness would be the better way of fixing this. Because of the
> regression risk to the default reclaim implementation, I'm inclined to
> NAK this revert.

I do agree that a simple revert doesn't seem to be the way to go.

-- 
Michal Hocko
SUSE Labs

