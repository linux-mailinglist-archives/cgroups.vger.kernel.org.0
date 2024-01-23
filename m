Return-Path: <cgroups+bounces-1221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718083948B
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93952B232A8
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541796281F;
	Tue, 23 Jan 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IHAU3ilv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IHAU3ilv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547395F545;
	Tue, 23 Jan 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026750; cv=none; b=nilZRNCLtKPYsWzevR6WtPY1cxr2wC96WhtCbo19If/JF622p21wKeDLMzHREXPVdyAdBiXy2PJqP5NQ4JIWK15hWUJbMRaYx5sb8L4tnnjTDEPa280PzWAwHP+t6O4yqHxo2H5kHan/nV2CzDDXWN65IftlX/NZmRvmdaoz6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026750; c=relaxed/simple;
	bh=dKY7sL5Xosek6KNvxiHatF7GmQzsHJmHkbUoHmhPiFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHBZAmG8FFT+arcdnOowL4ib+e/f86RhoHNZ7NgrcZiGAY27kG/UWD4L0NOwcAARiV+OHcjyw6VM4Z95VjPejI7sy81N48H91ef5AQITL74NRgI6dnPBSI0t9jq+L+x0OKN8btEw3y8PpfhdOxNnjwZiqhyJdYKqEG31lDG5YoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IHAU3ilv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IHAU3ilv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D0B92244D;
	Tue, 23 Jan 2024 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706026745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAy3ketzvRMwRbLQUV4pgMQkbDKQ5GdBAhMyiIwhx+k=;
	b=IHAU3ilv6nTkpi9HeEfp8+omCcPYaW1FIBDOIsxiTVqRUdx/FGWxsCpgppOePQMF2hGuWI
	ABZjfXd8UO3dpBHWqtRIBvu6aD0sQaB/plj0mhDz42owfX2XGI82iBUbOGy8uvSNPbwbB1
	N3FnnAxdZyQOpCTKoXlMVkAgJTTrO78=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706026745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAy3ketzvRMwRbLQUV4pgMQkbDKQ5GdBAhMyiIwhx+k=;
	b=IHAU3ilv6nTkpi9HeEfp8+omCcPYaW1FIBDOIsxiTVqRUdx/FGWxsCpgppOePQMF2hGuWI
	ABZjfXd8UO3dpBHWqtRIBvu6aD0sQaB/plj0mhDz42owfX2XGI82iBUbOGy8uvSNPbwbB1
	N3FnnAxdZyQOpCTKoXlMVkAgJTTrO78=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18A7E136A4;
	Tue, 23 Jan 2024 16:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EpzeAfnmr2UTCQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 23 Jan 2024 16:19:05 +0000
Date: Tue, 23 Jan 2024 17:19:00 +0100
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
Message-ID: <Za_m9Pymh0y-lzgX@tiehlicka>
References: <20240121214413.833776-1-tjmercier@google.com>
 <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IHAU3ilv
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D0B92244D
X-Spam-Level: 
X-Spam-Score: -4.81
X-Spam-Flag: NO

On Tue 23-01-24 05:58:05, T.J. Mercier wrote:
> On Tue, Jan 23, 2024 at 1:33 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sun 21-01-24 21:44:12, T.J. Mercier wrote:
> > > This reverts commit 0388536ac29104a478c79b3869541524caec28eb.
> > >
> > > Proactive reclaim on the root cgroup is 10x slower after this patch when
> > > MGLRU is enabled, and completion times for proactive reclaim on much
> > > smaller non-root cgroups take ~30% longer (with or without MGLRU).
> >
> > What is the reclaim target in these pro-active reclaim requests?
> 
> Two targets:
> 1) /sys/fs/cgroup/memory.reclaim
> 2) /sys/fs/cgroup/uid_0/memory.reclaim (a bunch of Android system services)

OK, I was not really clear. I was curious about nr_to_reclaim. 
 
> Note that lru_gen_shrink_node is used for 1, but shrink_node_memcgs is
> used for 2.
> 
> The 10x comes from the rate of reclaim (~70k pages/sec vs ~6.6k
> pages/sec) for 1. After this revert the root reclaim took only about
> 10 seconds. Before the revert it's still running after about 3 minutes
> using a core at 100% the whole time, and I'm too impatient to wait
> longer to record times for comparison.
> 
> The 30% comes from the average of a few runs for 2:
> Before revert:
> $ adb wait-for-device && sleep 120 && adb root && adb shell -t 'time
> echo "" > /sys/fs/cgroup/uid_0/memory.reclaim'

Ohh, so you want to reclaim all of it (resp. as much as possible).

[...]

> > > After the patch the reclaim rate is
> > > consistently ~6.6k pages/sec due to the reduced nr_pages value causing
> > > scan aborts as soon as SWAP_CLUSTER_MAX pages are reclaimed. The
> > > proactive reclaim doesn't complete after several minutes because
> > > try_to_free_mem_cgroup_pages is still capable of reclaiming pages in
> > > tiny SWAP_CLUSTER_MAX page chunks and nr_retries is never decremented.
> >
> > I do not understand this part. How does a smaller reclaim target manages
> > to have reclaimed > 0 while larger one doesn't?
> 
> They both are able to make progress. The main difference is that a
> single iteration of try_to_free_mem_cgroup_pages with MGLRU ends soon
> after it reclaims nr_to_reclaim, and before it touches all memcgs. So
> a single iteration really will reclaim only about SWAP_CLUSTER_MAX-ish
> pages with MGLRU. WIthout MGLRU the memcg walk is not aborted
> immediately after nr_to_reclaim is reached, so a single call to
> try_to_free_mem_cgroup_pages can actually reclaim thousands of pages
> even when sc->nr_to_reclaim is 32. (I.E. MGLRU overreclaims less.)
> https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/

OK, I do see how try_to_free_mem_cgroup_pages might over reclaim but I
do not really follow how increasing the batch actually fixes the issue
that there is always progress being made and therefore memory_reclaim
takes ages to terminates?
-- 
Michal Hocko
SUSE Labs

