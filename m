Return-Path: <cgroups+bounces-2073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A4881179
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6611F24370
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D33FB2A;
	Wed, 20 Mar 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mj/2E0/5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mj/2E0/5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AA2E64F;
	Wed, 20 Mar 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936584; cv=none; b=Trs89bfvpD5UMIX9aGJ4pdsGQHLHkBD3POtyBl0uhVaF9e9lrtCYi//Be6W+vhu5pAJtowEGisIHEjlRHNAl23upkzvSFDKXob4Q/Ij8cBtEqgrIiB334JJkwU3E0mEgHuaNRn5s2lA/OWFmpPtGw1D2YIlWavYKc4DVj7tiW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936584; c=relaxed/simple;
	bh=uYjWKzepl0AYTp3ckeZa2oD+/frdzyFfCgDNDxBrDsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3KD2+BunTBjtxHDC4qSJcnNM0FOej9E6s/plFe+hQeoCeifMoFbPc+8zaAeHG01QvMO2ZFBi0Ov9uUBr+9LjJKMHVfbPII/LC7XLWOzN39vLvvHwMkmfQsR1hnaHKf9JGTT9qgfzLvP0K7iW7h6ptOx5h8VJyu7xTq6v06Gpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mj/2E0/5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mj/2E0/5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DB51343A8;
	Wed, 20 Mar 2024 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710936577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHOMMEAuTVumsvUa0s4ONSCEm/gaHIgEjhSYOqP1F4Y=;
	b=mj/2E0/5TZON9G1Mp/Nhmw8SXKJ5mIo0sqnTy2GCUF7obOGsl9qV+Apk1EVo9RUTQlb5E5
	CsD/HRa9wquFGI9RkjNgQQUDviFFQ0fO1GfTZoWkCFGbmkMtLWGrMBRcdyPM6iXOA1k0u9
	7AScJw+OPTp6T/hN+mbYYGFBb853moQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710936577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHOMMEAuTVumsvUa0s4ONSCEm/gaHIgEjhSYOqP1F4Y=;
	b=mj/2E0/5TZON9G1Mp/Nhmw8SXKJ5mIo0sqnTy2GCUF7obOGsl9qV+Apk1EVo9RUTQlb5E5
	CsD/HRa9wquFGI9RkjNgQQUDviFFQ0fO1GfTZoWkCFGbmkMtLWGrMBRcdyPM6iXOA1k0u9
	7AScJw+OPTp6T/hN+mbYYGFBb853moQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE820136D6;
	Wed, 20 Mar 2024 12:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OMDZNwDS+mXcDgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 20 Mar 2024 12:09:36 +0000
Date: Wed, 20 Mar 2024 13:09:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Davydov <vdavydov.dev@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH] mm/memcontrol: stop resize loop if limit was changed
 again
Message-ID: <ZfrR_Fj0Ye1n1gYw@tiehlicka>
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
 <Zfq6XaACmN2JssTW@tiehlicka>
 <be8cfada-f4bd-4894-848d-1b7706b14035@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8cfada-f4bd-4894-848d-1b7706b14035@virtuozzo.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="mj/2E0/5"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,openvz.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 1DB51343A8
X-Spam-Flag: NO

On Wed 20-03-24 18:55:05, Pavel Tikhomirov wrote:
> 
> 
> On 20/03/2024 18:28, Michal Hocko wrote:
> > On Wed 20-03-24 18:03:30, Pavel Tikhomirov wrote:
> > > In memory_max_write() we first set memcg->memory.max and only then
> > > try to enforce it in loop. What if while we are in loop someone else
> > > have changed memcg->memory.max but we are still trying to enforce
> > > the old value? I believe this can lead to nasty consequence like getting
> > > an oom on perfectly fine cgroup within it's limits or excess reclaim.
> > 
> > I would argue that uncoordinated hard limit configuration can cause
> > problems on their own.
> 
> Sorry, didn't know that.

Well, just consider potential over-reclaim as a result of several
competing actors to set the same limit. Or completely indeterministic
final output of the limit setting depending on timing. This simply
cannot work reliably.
 
> > Beside how is this any different from changing
> > the high limit while we are inside the reclaim loop?
> 
> I believe reclaim loop rereads limits on each iteration, e.g. in
> reclaim_high(), so it should always be enforcing the right limit.

Reclaim loop might happen to take quite some time...
 
> > > We also have exactly the same thing in memory_high_write().
> > > 
> > > So let's stop enforcing old limits if we already have a new ones.
> > 
> > I do see any reasons why this would be harmful I just do not see why
> > this is a real thing or why the new behavior is any better for racing
> > updaters as those are not deterministic anyway. If you have any actual
> > usecase then more details would really help to justify this change.
> > 
> > The existing behavior makes some sense as it enforces the given limit
> > deterministically.
> 
> I don't have any actual problem, usecase or reproduce at hand, I only see a
> potential problem:
> 
> Let's imagine that:
> 
> a) We set cgroup max limit to some small value, memory_max_write updates
> memcg->memory.max and starts spinning in loop as it wants to reclaim some
> memory which does not fit in new limit.
> 
> b) We don't need small limit anymore and we raise the limit to a big value,
> but memory_max_write() from (a) is still spinning. And if we are lucky
> enough and processes of cgroup are constantly consuming memory, to
> compensate effect from memory_max_write() from (a), so that it will continue
> spinning there forever.

This is a killable operation, so if you decide to change mind about
limit setting and the current update is still in progress then just
terminate it rather then override by a different process.

> Yes it is not that bad, because memory_max/high_write() also constantly
> checks for pending signals in loop so they won't actually get irreversibly
> stuck. But I just thought it was worth fixing.

If we want to fix this parallel limits setting then we should also think
about a reasonable and predictable behavior and that would likely
require some sort of locking IMO.
-- 
Michal Hocko
SUSE Labs

