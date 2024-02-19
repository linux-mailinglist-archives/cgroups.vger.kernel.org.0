Return-Path: <cgroups+bounces-1700-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB53685AC03
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 20:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA1D1C2194B
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD050A6C;
	Mon, 19 Feb 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eUTltlkA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eUTltlkA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF550A63;
	Mon, 19 Feb 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371201; cv=none; b=QdIci/JY0JScOV2QvSPjpkMEcUsrcJQhG1dwpedESJDA7cXVa/AL+Pu0mH3d0qgp+LCCrKJ03pwOcMnYDtp8K1+1ex6BxSd6ojOxWdoxu5vzc8w2FiSnRd/THHuC0F2mh1462A8w/QkkS6TlZHFfkuU5w40vs+2qQND1MQqtN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371201; c=relaxed/simple;
	bh=sZtkQ/t47jm0/Z+f0905C111FkLdAT6+mATAdcqgVN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1Y0GBUwRnM3/5DByu32sbxH3ZhBXoDPPR6xcAsXDOlEuar1an6LkGo92/NwfKi9Zru+yABW720kIuoYXMTOTDzxPL/BQedvxWmdDGLDwrhojFfgeJnOyaJd8opQPfaV+zwWdZRJGG/2wjfMMz6k+p69KrcPEojFRKgV4hiJFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eUTltlkA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eUTltlkA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3DBF1F818;
	Mon, 19 Feb 2024 19:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708371197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HchPlLlQKkMnB/voXt+FYr9ksQ0f3O3AlZgGnPQ1ZbM=;
	b=eUTltlkAJEIKHb8lgQPRELfsY7gXNQbKmphlmmEagp7K+2eLe7nvcp5L86ZJEd/F3V7PEm
	YnDwYZqEiId8yZyb3KellQNzTCIWZL/fBXb/Mcce58uhAZEbx6tZT5IQ8XIMNFSwAsR3wq
	GkbakPgC1vydwLgKvn7BaByfCWoGumA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708371197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HchPlLlQKkMnB/voXt+FYr9ksQ0f3O3AlZgGnPQ1ZbM=;
	b=eUTltlkAJEIKHb8lgQPRELfsY7gXNQbKmphlmmEagp7K+2eLe7nvcp5L86ZJEd/F3V7PEm
	YnDwYZqEiId8yZyb3KellQNzTCIWZL/fBXb/Mcce58uhAZEbx6tZT5IQ8XIMNFSwAsR3wq
	GkbakPgC1vydwLgKvn7BaByfCWoGumA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1A4713647;
	Mon, 19 Feb 2024 19:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KwUK/2s02UILAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 19 Feb 2024 19:33:17 +0000
Date: Mon, 19 Feb 2024 20:33:17 +0100
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
Message-ID: <ZdOs_fCxrFCbjnr0@tiehlicka>
References: <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka>
 <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
 <ZcFG2JoXI7i8XzQY@tiehlicka>
 <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
 <ZcFQMru5_oATGbuP@tiehlicka>
 <CABdmKX35GV3VFar0_pNR_vAXLpvxo+APALXMharsXh6TO+0mrQ@mail.gmail.com>
 <ZcH0wBPvOjqayjAD@tiehlicka>
 <ZdNFbiH1ufbOTIDx@tiehlicka>
 <CABdmKX0-nWU4P7ZJqOMusRCuhewf+kg1x==U7m52=MaKeRCYWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0-nWU4P7ZJqOMusRCuhewf+kg1x==U7m52=MaKeRCYWg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 19-02-24 08:39:19, T.J. Mercier wrote:
> On Mon, Feb 19, 2024 at 4:11 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 06-02-24 09:58:41, Michal Hocko wrote:
> > > On Mon 05-02-24 20:01:40, T.J. Mercier wrote:
> > > > On Mon, Feb 5, 2024 at 1:16 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 05-02-24 12:47:47, T.J. Mercier wrote:
> > > > > > On Mon, Feb 5, 2024 at 12:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > [...]
> > > > > > > This of something like
> > > > > > > timeout $TIMEOUT echo $TARGET > $MEMCG_PATH/memory.reclaim
> > > > > > > where timeout acts as a stop gap if the reclaim cannot finish in
> > > > > > > TIMEOUT.
> > > > > >
> > > > > > Yeah I get the desired behavior, but using sc->nr_reclaimed to achieve
> > > > > > it is what's bothering me.
> > > > >
> > > > > I am not really happy about this subtlety. If we have a better way then
> > > > > let's do it. Better in its own patch, though.
> > > > >
> > > > > > It's already wired up that way though, so if you want to make this
> > > > > > change now then I can try to test for the difference using really
> > > > > > large reclaim targets.
> > > > >
> > > > > Yes, please. If you want it a separate patch then no objection from me
> > > > > of course. If you do no like the nr_to_reclaim bailout then maybe we can
> > > > > go with a simple break out flag in scan_control.
> > > > >
> > > > > Thanks!
> > > >
> > > > It's a bit difficult to test under the too_many_isolated check, so I
> > > > moved the fatal_signal_pending check outside and tried with that.
> > > > Performing full reclaim on the /uid_0 cgroup with a 250ms delay before
> > > > SIGKILL, I got an average of 16ms better latency with
> > > > sc->nr_to_reclaim across 20 runs ignoring one 1s outlier with
> > > > SWAP_CLUSTER_MAX.
> > >
> > > This will obviously scale with the number of memcgs in the hierarchy but
> > > you are right that too_many_isolated makes the whole fatal_signal_pending
> > > check rather inefficient. I haven't missed that. The reclaim path is
> > > rather convoluted so this will likely be more complex than I
> > > anticipated. I will think about that some more.
> > >
> > > In order to not delay your patch, please repost with suggested updates
> > > to the changelog. This needs addressing IMO but I do not think this is
> > > critical at this stage.
> >
> > Has there been a new version or a proposal to refine the changelog
> > posted?
> 
> Hi Michal,
> 
> I updated the commit message in V4 to include a sentence about restart
> cost, and added a line above each reclaim test to note the MGLRU
> config and whether the memcg LRU was used or not.
> 
> https://lore.kernel.org/all/20240206175251.3364296-1-tjmercier@google.com/

Hmm, missed that one for some reason.

-- 
Michal Hocko
SUSE Labs

