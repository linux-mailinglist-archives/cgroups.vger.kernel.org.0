Return-Path: <cgroups+bounces-1134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A182C4A1
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 18:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA502866FA
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11D22621;
	Fri, 12 Jan 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="coh+Fnu1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="coh+Fnu1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45F22618;
	Fri, 12 Jan 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 145DF1F396;
	Fri, 12 Jan 2024 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705080226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHxzNkl3+lg5RxMKF+f20439C0qvkhGvp+j1/UrE0ss=;
	b=coh+Fnu1UJz13gGiunWRvCcSzWJD2fwZrkHJ5sUDzW6vhjdNim8KWDD2ba23fDxBMIh1lB
	Jp5SehF/gfoh3YoHmxoQ9FtbDGLOeqgz3mVfxnA2nOI4th84z5IY4S80dEy8XvzzBee4jM
	BbATxr1ambWoEyMxadVor+ufkHahK20=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705080226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHxzNkl3+lg5RxMKF+f20439C0qvkhGvp+j1/UrE0ss=;
	b=coh+Fnu1UJz13gGiunWRvCcSzWJD2fwZrkHJ5sUDzW6vhjdNim8KWDD2ba23fDxBMIh1lB
	Jp5SehF/gfoh3YoHmxoQ9FtbDGLOeqgz3mVfxnA2nOI4th84z5IY4S80dEy8XvzzBee4jM
	BbATxr1ambWoEyMxadVor+ufkHahK20=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAE3E136A4;
	Fri, 12 Jan 2024 17:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uTxdNqF1oWW+OAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 12 Jan 2024 17:23:45 +0000
Date: Fri, 12 Jan 2024 18:23:45 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Message-ID: <ZaF1oQyovAOMA3be@tiehlicka>
References: <20240111132902.389862-1-hannes@cmpxchg.org>
 <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org>
 <ZaFxn7JC8FeR-Si0@tiehlicka>
 <ZaFyiTFC-ped0IdA@P9FQF9L96D.corp.robot.car>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaFyiTFC-ped0IdA@P9FQF9L96D.corp.robot.car>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=coh+Fnu1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.36 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.13)[67.72%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[cmpxchg.org,linux-foundation.org,google.com,linux.dev,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.36
X-Rspamd-Queue-Id: 145DF1F396
X-Spam-Flag: NO

On Fri 12-01-24 09:10:33, Roman Gushchin wrote:
> On Fri, Jan 12, 2024 at 06:06:39PM +0100, Michal Hocko wrote:
> > On Thu 11-01-24 14:28:07, Johannes Weiner wrote:
> > [...]
> > > @@ -2867,11 +2882,17 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >  		}
> > >  	} while ((memcg = parent_mem_cgroup(memcg)));
> > >  
> > > +	/*
> > > +	 * Reclaim is set up above to be called from the userland
> > > +	 * return path. But also attempt synchronous reclaim to avoid
> > > +	 * excessive overrun while the task is still inside the
> > > +	 * kernel. If this is successful, the return path will see it
> > > +	 * when it rechecks the overage and simply bail out.
> > > +	 */
> > >  	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
> > >  	    !(current->flags & PF_MEMALLOC) &&
> > > -	    gfpflags_allow_blocking(gfp_mask)) {
> > > +	    gfpflags_allow_blocking(gfp_mask))
> > >  		mem_cgroup_handle_over_high(gfp_mask);
> > 
> > Have you lost the check for the dying task here?
> 
> It was moved into mem_cgroup_handle_over_high()'s body.

Ohh, right. Somehow overlooked that even when I was staring at that
path.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs

