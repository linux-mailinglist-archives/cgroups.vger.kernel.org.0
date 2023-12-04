Return-Path: <cgroups+bounces-783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A88038AE
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDE11F213E1
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3A2C1BA;
	Mon,  4 Dec 2023 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Qx435/8a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2954CF2;
	Mon,  4 Dec 2023 07:23:50 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BC34220D8;
	Mon,  4 Dec 2023 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701703428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSfuO+OQqjKaU4tpQqlga4ZTtzNlctSschnkLgDRivg=;
	b=Qx435/8aK+ZnOG7Hv2GM0J7AuyqsexLTDkphaopr7hyK/MeSQAylHN/RuGGYI0Te8D27OP
	TkCVr4PXQ502a7kEIJzauKJeTbOclWyNnnLMWI36eLvPhBGvBOCtJ9Z0C5BJZs6lf2EcWG
	FPRBE2s7R4YBMPA2g78KYOvPnbo+vFw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 427FA1398A;
	Mon,  4 Dec 2023 15:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id feo9DATvbWUMUgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 04 Dec 2023 15:23:48 +0000
Date: Mon, 4 Dec 2023 16:23:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZW3vAz9KF5wM3HgE@tiehlicka>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
 <ZWmoTa7MlD7h9FYm@tiehlicka>
 <20231201170955.GA694615@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201170955.GA694615@cmpxchg.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,linux.dev,google.com,vivo.com,vger.kernel.org,kvack.org,linux-foundation.org,redhat.com,infradead.org,intel.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.30

On Fri 01-12-23 12:09:55, Johannes Weiner wrote:
> On Fri, Dec 01, 2023 at 10:33:01AM +0100, Michal Hocko wrote:
> > On Thu 30-11-23 11:56:42, Johannes Weiner wrote:
> > [...]
> > > So I wouldn't say it's merely a reclaim hint. It controls a very
> > > concrete and influential factor in VM decision making. And since the
> > > global swappiness is long-established ABI, I don't expect its meaning
> > > to change significantly any time soon.
> > 
> > As I've said I am more worried about potential future changes which
> > would modify existing, reduce or add more corner cases which would be
> > seen as a change of behavior from the user space POV. That means that we
> > would have to be really explicit about the fact that the reclaim is free
> > to override the swappiness provided by user. So essentially a best
> > effort interface without any actual guarantees. That surely makes it
> > harder to use. Is it still useable?
> 
> But it's not free to override the setting as it pleases. I wrote a
> detailed list of the current exceptions, and why the user wouldn't
> have strong expectations of swappiness being respected in those
> cases. Having reasonable limitations is not the same as everything
> being up for grabs.

Well, I was not suggesting that future changes would be intentionally
breaking swappiness. But look at the history, we've had times when
swappiness was ignored most of the time due to heavy page cache bias.
Now it is really hard to assume future reclaim changes but I can easily
imagine that IO refault cost to balance file vs. anon lrus would be in
future reclaim improvements and extensions.

> Again, the swappiness setting is ABI, and people would definitely
> complain if we ignored their request in an unexpected situation and
> regressed their workloads.
> 
> I'm not against documenting the exceptions and limitations. Not just
> for proactive reclaim, but for swappiness in general. But I don't
> think it's fair to say that there are NO rules and NO userspace
> contract around this parameter (and I'm the one who wrote most of the
> balancing code that implements the swappiness control).

Right, but the behavior might change considerably between different
kernel versions and that is something to be really careful about. One
think I would really like to avoid is to provide any guarantee that
swappiness X and nr_to_reclaim has an exact anon/file pages reclaimed
or this is a regression because $VER-1 behaved that way. There might be
very ligitimate reasons to use different heuristics in the memory
reclaim.

Another option would be drop any heuristics when swappiness is provided
for the memory.reclaim interface which would be much more predictable
but it would also diverge from the normal reclaim and that is quite bad
IMHO.
-- 
Michal Hocko
SUSE Labs

