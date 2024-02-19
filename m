Return-Path: <cgroups+bounces-1691-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7C85A2E3
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 13:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FCFB20A90
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2E2C848;
	Mon, 19 Feb 2024 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mUO1CBBR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mUO1CBBR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9422F00;
	Mon, 19 Feb 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344694; cv=none; b=Z8iqH472kc7YRFZtrL2KpPeQCp9qJwKIcbQCeu+xLOQ4YCgVwJueRX3LkV77nHkKnbAfNXXXl0uxbrQpKjPuuf1lpGrOkNMpBJF4q6iAew69W9JdkCsegTDD33fZ27XoIHi1mu9pnVLYgIiKIRi5EMCBLmlnxG0t85eKX9AGZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344694; c=relaxed/simple;
	bh=RKA1FRCk3ma0tGwU4yw6balfgkgpjYcTeV2wBsGPWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWUaSaBbTykyJSPzsU1BoQBOMlUElfIC3IBnYsWIM5svkYpQDMCGjqSM/Z2OF/LWTmIvDr7In98S1YnwfI8qO6zHCZy123rnsg+NOW/G0nnYnmWJ/U8LHDOEkvwqkQUlJziRvLB8K1zkgbGCPMh+fM4d9T+WSUIXYy5a83OYtjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mUO1CBBR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mUO1CBBR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FF2D21E6D;
	Mon, 19 Feb 2024 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708344691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgEdE8pMlMrPDPVr2iZZlKCQOw1qxLHW5eescT7bZpg=;
	b=mUO1CBBRL3HyVHI2fWsDkW0cA/NpbcKxhZPLTjpUVNrn15DI+P6p0SBpC+BjTfClxVqY0b
	OaH+WJkFMGCOaI61UFckLXxAN8SE5Scv8tLSCP8ULatZb7VSAdEIYQ+DrchMsOBFiUy5Y/
	PI26M9CvjSnmzPnmFtQNRxvkYXhGDu8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708344691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgEdE8pMlMrPDPVr2iZZlKCQOw1qxLHW5eescT7bZpg=;
	b=mUO1CBBRL3HyVHI2fWsDkW0cA/NpbcKxhZPLTjpUVNrn15DI+P6p0SBpC+BjTfClxVqY0b
	OaH+WJkFMGCOaI61UFckLXxAN8SE5Scv8tLSCP8ULatZb7VSAdEIYQ+DrchMsOBFiUy5Y/
	PI26M9CvjSnmzPnmFtQNRxvkYXhGDu8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C8FB139D0;
	Mon, 19 Feb 2024 12:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /jviB3NF02VWPgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 19 Feb 2024 12:11:31 +0000
Date: Mon, 19 Feb 2024 13:11:26 +0100
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
Message-ID: <ZdNFbiH1ufbOTIDx@tiehlicka>
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka>
 <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka>
 <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
 <ZcFG2JoXI7i8XzQY@tiehlicka>
 <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
 <ZcFQMru5_oATGbuP@tiehlicka>
 <CABdmKX35GV3VFar0_pNR_vAXLpvxo+APALXMharsXh6TO+0mrQ@mail.gmail.com>
 <ZcH0wBPvOjqayjAD@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcH0wBPvOjqayjAD@tiehlicka>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue 06-02-24 09:58:41, Michal Hocko wrote:
> On Mon 05-02-24 20:01:40, T.J. Mercier wrote:
> > On Mon, Feb 5, 2024 at 1:16 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 05-02-24 12:47:47, T.J. Mercier wrote:
> > > > On Mon, Feb 5, 2024 at 12:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > This of something like
> > > > > timeout $TIMEOUT echo $TARGET > $MEMCG_PATH/memory.reclaim
> > > > > where timeout acts as a stop gap if the reclaim cannot finish in
> > > > > TIMEOUT.
> > > >
> > > > Yeah I get the desired behavior, but using sc->nr_reclaimed to achieve
> > > > it is what's bothering me.
> > >
> > > I am not really happy about this subtlety. If we have a better way then
> > > let's do it. Better in its own patch, though.
> > >
> > > > It's already wired up that way though, so if you want to make this
> > > > change now then I can try to test for the difference using really
> > > > large reclaim targets.
> > >
> > > Yes, please. If you want it a separate patch then no objection from me
> > > of course. If you do no like the nr_to_reclaim bailout then maybe we can
> > > go with a simple break out flag in scan_control.
> > >
> > > Thanks!
> > 
> > It's a bit difficult to test under the too_many_isolated check, so I
> > moved the fatal_signal_pending check outside and tried with that.
> > Performing full reclaim on the /uid_0 cgroup with a 250ms delay before
> > SIGKILL, I got an average of 16ms better latency with
> > sc->nr_to_reclaim across 20 runs ignoring one 1s outlier with
> > SWAP_CLUSTER_MAX.
> 
> This will obviously scale with the number of memcgs in the hierarchy but
> you are right that too_many_isolated makes the whole fatal_signal_pending
> check rather inefficient. I haven't missed that. The reclaim path is
> rather convoluted so this will likely be more complex than I
> anticipated. I will think about that some more.
> 
> In order to not delay your patch, please repost with suggested updates
> to the changelog. This needs addressing IMO but I do not think this is
> critical at this stage.

Has there been a new version or a proposal to refine the changelog
posted?
-- 
Michal Hocko
SUSE Labs

