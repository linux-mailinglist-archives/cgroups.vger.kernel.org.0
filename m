Return-Path: <cgroups+bounces-1347-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F784A70B
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2284528D380
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71598604A8;
	Mon,  5 Feb 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jXLOZEY9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jXLOZEY9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A7604AF;
	Mon,  5 Feb 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162020; cv=none; b=bklcEW3Sg3XngJfJiitfy4a/sU+32L5hh23VoNDyHlXIDM32hIOmExD7kzJsn6a6u+x7KFniFgqxOoLbsXXF04ed1Kg75QIP+w99jacOVT6xJv2334ENJ0FJ9ecG/ZW4Ox81c6xw/mUdALhXvxLE5niOuX817uYitSpdL31v0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162020; c=relaxed/simple;
	bh=h6fok/j/rmgFRaC3OERQa17hPFRvFNJ50J0rE1rRM8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHynur2xR6UiMdIIEgMbquuteG/q0TFLwTJphv5iqze9uJ+WO8HgE3wq1Cul6zfj68ah/3bx+RNOZ8kVgru8ubsa0OAaCI5GVNrBycvDbPSAeKub76Q2LGL0DQo9y2Y7FFge82Ze+EhRcJ0pMDaG1saT0KN/Guv3x4Xch4M/32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jXLOZEY9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jXLOZEY9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22C09220B0;
	Mon,  5 Feb 2024 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707162016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCAYeFTv9u2wjsEQ0QvNWNJYtGTTkhyunrC4I8efVjs=;
	b=jXLOZEY9Z2nbF3cV3dJl5rwDUFbl2dcqCqu8TRF67gsqNLDQshVfcuJWsWaDShiR0IuZ6b
	bnEjTM4ktfLocee/0/zAOfnvIMHzJMUQyYStG4EGmrkombgYg7aksMk7fXNO4SBhsfrytr
	33pK9FIQGv86hOyIRx1jeryQxk7/Bzw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707162016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCAYeFTv9u2wjsEQ0QvNWNJYtGTTkhyunrC4I8efVjs=;
	b=jXLOZEY9Z2nbF3cV3dJl5rwDUFbl2dcqCqu8TRF67gsqNLDQshVfcuJWsWaDShiR0IuZ6b
	bnEjTM4ktfLocee/0/zAOfnvIMHzJMUQyYStG4EGmrkombgYg7aksMk7fXNO4SBhsfrytr
	33pK9FIQGv86hOyIRx1jeryQxk7/Bzw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F128E136F5;
	Mon,  5 Feb 2024 19:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bifAOJ85wWWgPgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 19:40:15 +0000
Date: Mon, 5 Feb 2024 20:40:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, mkoutny@suse.com,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
Message-ID: <ZcE5n9cTdTGJChmq@tiehlicka>
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka>
 <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jXLOZEY9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 22C09220B0
X-Spam-Flag: NO

On Mon 05-02-24 11:29:49, T.J. Mercier wrote:
> On Mon, Feb 5, 2024 at 2:40 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 02-02-24 23:38:54, T.J. Mercier wrote:
> > > Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> > > reclaim") we passed the number of pages for the reclaim request directly
> > > to try_to_free_mem_cgroup_pages, which could lead to significant
> > > overreclaim. After 0388536ac291 the number of pages was limited to a
> > > maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> > > However such a small batch size caused a regression in reclaim
> > > performance due to many more reclaim start/stop cycles inside
> > > memory_reclaim.
> >
> > You have mentioned that in one of the previous emails but it is good to
> > mention what is the source of that overhead for the future reference.
> 
> I can add a sentence about the restart cost being amortized over more
> pages with a large batch size. It covers things like repeatedly
> flushing stats, walking the tree, evaluating protection limits, etc.
> 
> > > Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> > > nodes and cgroups over which the pages are spread. As such, the bigger
> > > the request, the bigger the absolute overreclaim error. Historic
> > > in-kernel users of reclaim have used fixed, small sized requests to
> > > approach an appropriate reclaim rate over time. When we reclaim a user
> > > request of arbitrary size, use decaying batch sizes to manage error while
> > > maintaining reasonable throughput.
> >
> > These numbers are with MGLRU or the default reclaim implementation?
> 
> These numbers are for both. root uses the memcg LRU (MGLRU was
> enabled), and /uid_0 does not.

Thanks it would be nice to outline that in the changelog.

> > > root - full reclaim       pages/sec   time (sec)
> > > pre-0388536ac291      :    68047        10.46
> > > post-0388536ac291     :    13742        inf
> > > (reclaim-reclaimed)/4 :    67352        10.51
> > >
> > > /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> > > pre-0388536ac291      :    258822       1.12            107.8
> > > post-0388536ac291     :    105174       2.49            3.5
> > > (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> > >
> > > /uid_0 - full reclaim     pages/sec   time (sec)
> > > pre-0388536ac291      :    72334        7.09
> > > post-0388536ac291     :    38105        14.45
> > > (reclaim-reclaimed)/4 :    72914        6.96
> > >
> > > Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive reclaim")
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > ---
> > > v3: Formatting fixes per Yosry Ahmed and Johannes Weiner. No functional
> > > changes.
> > > v2: Simplify the request size calculation per Johannes Weiner and Michal Koutný
> > >
> > >  mm/memcontrol.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 46d8d02114cf..f6ab61128869 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6976,9 +6976,11 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > >               if (!nr_retries)
> > >                       lru_add_drain_all();
> > >
> > > +             /* Will converge on zero, but reclaim enforces a minimum */
> > > +             unsigned long batch_size = (nr_to_reclaim - nr_reclaimed) / 4;
> >
> > This doesn't fit into the existing coding style. I do not think there is
> > a strong reason to go against it here.
> 
> There's been some back and forth here. You'd prefer to move this to
> the top of the while loop, under the declaration of reclaimed? It's
> farther from its use there, but it does match the existing style in
> the file better.

This is not something I deeply care about but generally it is better to
not mix styles unless that is a clear win. If you want to save one LOC
you can just move it up - just couple of lines up, or you can keep the
definition closer and have a separate declaration.

> > > +
> > >               reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > -                                     min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > > -                                     GFP_KERNEL, reclaim_options);
> > > +                                     batch_size, GFP_KERNEL, reclaim_options);
> >
> > Also with the increased reclaim target do we need something like this?
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4f9c854ce6cc..94794cf5ee9f 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1889,7 +1889,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
> >
> >                 /* We are about to die and free our memory. Return now. */
> >                 if (fatal_signal_pending(current))
> > -                       return SWAP_CLUSTER_MAX;
> > +                       return sc->nr_to_reclaim;
> >         }
> >
> >         lru_add_drain();
> > >
> > >               if (!reclaimed && !nr_retries--)
> > >                       return -EAGAIN;
> > > --
> 
> This is interesting, but I don't think it's closely related to this
> change. This section looks like it was added to delay OOM kills due to
> apparent lack of reclaim progress when pages are isolated and the
> direct reclaimer is scheduled out. A couple things:
> 
> In the context of proactive reclaim, current is not really undergoing
> reclaim due to memory pressure. It's initiated from userspace. So
> whether it has a fatal signal pending or not doesn't seem like it
> should influence the return value of shrink_inactive_list for some
> probably unrelated process. It seems more straightforward to me to
> return 0, and add another fatal signal pending check to the caller
> (shrink_lruvec) to bail out early (dealing with OOM kill avoidance
> there if necessary) instead of waiting to accumulate fake
> SWAP_CLUSTER_MAX values from shrink_inactive_list.

The point of this code is to bail out early if the caller has fatal
signals pending. That could be SIGTERM sent to the process performing
the reclaim for whatever reason. The bail out is tuned for
SWAP_CLUSTER_MAX as you can see and your patch is increasing the reclaim
target which means that bailout wouldn't work properly and you wouldn't
get any useful work done but not really bail out. 

> As far as changing the value, SWAP_CLUSTER_MAX puts the final value of
> sc->nr_reclaimed pretty close to sc->nr_to_reclaim. Since there's a
> loop for each evictable lru in shrink_lruvec, we could end up with 4 *
> sc->nr_to_reclaim in sc->nr_reclaimed if we switched to
> sc->nr_to_reclaim from SWAP_CLUSTER_MAX... an even bigger lie. So I
> don't think we'd want to do that.

The actual number returned from the reclaim is not really important
because memory_reclaim would break out of the loop and userspace would
never see the result.

-- 
Michal Hocko
SUSE Labs

