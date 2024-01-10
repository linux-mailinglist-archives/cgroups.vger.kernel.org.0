Return-Path: <cgroups+bounces-1112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C78297AD
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 11:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423BEB26063
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702C3FE26;
	Wed, 10 Jan 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ckOO/5A0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ckOO/5A0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5341205;
	Wed, 10 Jan 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC8292206D;
	Wed, 10 Jan 2024 10:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704882779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXR7PBJo/0k7RMlA2liuV9sILDH8IFvToNJCRDJt55E=;
	b=ckOO/5A0SO7+ciUHsiXzgEYJhcMrLorPd+ohuWjdgh6e5IE3uzah0+OYHvQkFui0OujWpM
	R0pDPwN/bAwf06163wv+Wa9IkgzoOddCg0ZwgoP0PMVo0r1+1ULorGEhKCqZmbXZNHsN6j
	7nq1V338IJfg07YIrCOh5FbK+7/omjc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704882779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXR7PBJo/0k7RMlA2liuV9sILDH8IFvToNJCRDJt55E=;
	b=ckOO/5A0SO7+ciUHsiXzgEYJhcMrLorPd+ohuWjdgh6e5IE3uzah0+OYHvQkFui0OujWpM
	R0pDPwN/bAwf06163wv+Wa9IkgzoOddCg0ZwgoP0PMVo0r1+1ULorGEhKCqZmbXZNHsN6j
	7nq1V338IJfg07YIrCOh5FbK+7/omjc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FEB113CB3;
	Wed, 10 Jan 2024 10:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TxhKHFtynmUkewAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 10 Jan 2024 10:32:59 +0000
Date: Wed, 10 Jan 2024 11:32:58 +0100
From: Michal Hocko <mhocko@suse.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
	David Rientjes <rientjes@google.com>, Chris Li <chrisl@kernel.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZ5yWriL-T59Bcu_@tiehlicka>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com>
 <CAOUHufZ-hTwdiy7eYgJWo=CHyPbdxTX60hxjPmwa9Ox6FXMYQQ@mail.gmail.com>
 <ZZWlT5wmDaMceSlQ@dschatzberg-fedora-PC0Y6AEN>
 <ZZYE36e0BFFzi0X3@google.com>
 <ZZZw5NSEFNYwbjZM@tiehlicka>
 <CAOUHufbEuAWwz-51tq6OB7SPJ8W3UJ9Roq2-yXesWAbmzstdKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufbEuAWwz-51tq6OB7SPJ8W3UJ9Roq2-yXesWAbmzstdKw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: **********
X-Spam-Score: 10.30
X-Spamd-Result: default: False [10.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,google.com,kernel.org,bytedance.com,cmpxchg.org,lwn.net,linux.dev,redhat.com,infradead.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue 09-01-24 16:54:15, Yu Zhao wrote:
> On Thu, Jan 4, 2024 at 1:48 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 03-01-24 18:07:43, Yu Zhao wrote:
> > > On Wed, Jan 03, 2024 at 01:19:59PM -0500, Dan Schatzberg wrote:
> > > > On Wed, Jan 03, 2024 at 10:19:40AM -0700, Yu Zhao wrote:
> > > > [...]
> > > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > > index d91963e2d47f..394e0dd46b2e 100644
> > > > > > --- a/mm/vmscan.c
> > > > > > +++ b/mm/vmscan.c
> > > > > > @@ -92,6 +92,11 @@ struct scan_control {
> > > > > >         unsigned long   anon_cost;
> > > > > >         unsigned long   file_cost;
> > > > > >
> > > > > > +#ifdef CONFIG_MEMCG
> > > > > > +       /* Swappiness value for proactive reclaim. Always use sc_swappiness()! */
> > > > > > +       int *proactive_swappiness;
> > > > > > +#endif
> > > > >
> > > > > Why is proactive_swappiness still a pointer? The whole point of the
> > > > > previous conversation is that sc->proactive can tell whether
> > > > > sc->swappiness is valid or not, and that's less awkward than using a
> > > > > pointer.
> > > >
> > > > It's the same reason as before - zero initialization ensures that the
> > > > pointer is NULL which tells us if it's valid or not. Proactive reclaim
> > > > might not set swappiness and you need to distinguish swappiness of 0
> > > > and not-set. See this discussion with Michal:
> > > >
> > > > https://lore.kernel.org/linux-mm/ZZUizpTWOt3gNeqR@tiehlicka/
> > >
> > >  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > >                               size_t nbytes, loff_t off)
> > >  {
> > >         struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > >         unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > >         unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > > +       int swappiness = -1;
> > > ...
> > >                 reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > >                                         min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > > -                                       GFP_KERNEL, reclaim_options);
> > > +                                       GFP_KERNEL, reclaim_options,
> > > +                                       swappiness);
> > >
> > > ...
> > >
> > > +static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
> > > +{
> > > +       return sc->proactive && sc->proactive_swappiness > -1 ?
> > > +              sc->proactive_swappiness : mem_cgroup_swappiness(memcg);
> > > +}
> >
> > Tpo be completely honest I really fail to see why this is such a hot
> > discussion point. To be completely clear both approaches are feasible.
> 
> Feasible but not equal.
> 
> > The main argument for NULL check based approach is that it is less error
> > prone from an incorrect ussage because any bug becomes obvious.
> 
> Any bug becomes *fatal*, and fatal isn't only obvious but also hurts
> in production systems.
> 
> This was the reason for going through the trouble switching from
> VM_BUG_ON() to VM_WARN_ON() and documenting it in
> Documentation/process/coding-style.rst:
> 
> 22) Do not crash the kernel
> ---------------------------
> 
> In general, the decision to crash the kernel belongs to the user, rather
> than to the kernel developer.
> 
> Isn't?

I do agree with this general statement but I do not think it is
applicable in this context.

This is not an explicit BUG() when kernel explicitly sets to panic the
system. We are talking about subtle misbehavior which might be
non-trivial to debug (there are other reasons to not swap at all) vs. a
potential NULL ptr which will kill the userspace in a very obvious way.
Sure there are risks with that but checks for potential NULL ptr
dereferncing is easier than forgot explicit initialization. There are
clear pros and cons for both approaches. NULL default initialized
structures members which allow for behavior override are a general
kernel pattern so I do not really see this going way off the rails.
-- 
Michal Hocko
SUSE Labs

