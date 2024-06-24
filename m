Return-Path: <cgroups+bounces-3299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EA3914508
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 10:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6AA1F21247
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87705380F;
	Mon, 24 Jun 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RLR+OlB4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RLR+OlB4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2B4F201;
	Mon, 24 Jun 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218281; cv=none; b=BSX9ZR3n0ksrvvdcvw25TIcJ4bcZpMn+Qh4uQoL/PItzifx6rU1vaAaIpScNhuFktIX1GmEFslpJRVH5t0jlN+BqhlJMz7qD68eNavrm9Eak/A6Ym3thdUNpyV6jpo04IlGVzfsVKOK3lC4h2r7wuEnKhafHZTxNPJSH8RrDxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218281; c=relaxed/simple;
	bh=S/7B2MsUNMvty6ZQKzTkFNvBoyrfX87rmchFj3A9s+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIuk25TPV80BSk/7qzxTF+Eav/rG7c7Q6h7lw+vFnreIVDII5OPVen6B64G8N2hVGqZsxRazDyF4Gljfq1VfLxjn/GctuovYPiPPyliBEsmRkGYtk++/iaL+NM1Uys+jR7K/Cj/R0lGnIQWKqRa99hVRKmW9FGXJW2aQXuVgdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RLR+OlB4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RLR+OlB4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8559821A3E;
	Mon, 24 Jun 2024 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719218277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98fTMwEf+6SsUi7Nji/bTtxwDz8Dltlq3IXSCx/PIwQ=;
	b=RLR+OlB4jwmNTGBze3tJl5MW65PTZYFf+JXs6GPrEHdmbeqUuedS1FCS1kr3POVdUXPGZa
	BK6BTaMnjZvxHxO++x/+gdKVbiJWKA9J2T3KkVJS091JZq7WuBm3yEf3WLbZ7edp1w9vbX
	nlSgKm57tOD7MCnDpqlUynBVxD32YCU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719218277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98fTMwEf+6SsUi7Nji/bTtxwDz8Dltlq3IXSCx/PIwQ=;
	b=RLR+OlB4jwmNTGBze3tJl5MW65PTZYFf+JXs6GPrEHdmbeqUuedS1FCS1kr3POVdUXPGZa
	BK6BTaMnjZvxHxO++x/+gdKVbiJWKA9J2T3KkVJS091JZq7WuBm3yEf3WLbZ7edp1w9vbX
	nlSgKm57tOD7MCnDpqlUynBVxD32YCU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6815513AA4;
	Mon, 24 Jun 2024 08:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0pNeF2UweWbxFAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 24 Jun 2024 08:37:57 +0000
Date: Mon, 24 Jun 2024 10:37:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Alex Kalenyuk <akalenyu@redhat.com>, Peter Hunt <pehunt@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] memcg: Add a new sysctl parameter for automatically
 setting memory.high
Message-ID: <ZnkwYFx4DSvcc2Zs@tiehlicka>
References: <20240623204514.1032662-1-longman@redhat.com>
 <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sun 23-06-24 16:52:00, Waiman Long wrote:
> Correct some email addresses.
> 
> On 6/23/24 16:45, Waiman Long wrote:
> > With memory cgroup v1, there is only a single "memory.limit_in_bytes"
> > to be set to specify the maximum amount of memory that is allowed to
> > be used. So a lot of memory cgroup using tools and applications allow
> > users to specify a single memory limit. When they migrate to cgroup
> > v2, they use the given memory limit to set memory.max and disregard
> > memory.high for the time being.
> > 
> > Without properly setting memory.high, these user space applications
> > cannot make use of the memory cgroup v2 ability to further reduce the
> > chance of OOM kills by throttling and early memory reclaim.
> > 
> > This patch adds a new sysctl parameter "vm/memory_high_autoset_ratio"
> > to enable setting "memory.high" automatically whenever "memory.max" is
> > set as long as "memory.high" hasn't been explicitly set before. This
> > will allow a system administrator or a middleware layer to greatly
> > reduce the chance of memory cgroup OOM kills without worrying about
> > how to properly set memory.high.
> > 
> > The new sysctl parameter will allow a range of 0-100. The default value
> > of 0 will disable memory.high auto setting. For any non-zero value "n",
> > the actual ratio used will be "n/(n+1)". A user cannot set a fraction
> > less than 1/2.

I am sorry but this is a bad idea. It is also completely unnecessary. If
somebody goes all the way to set the hard limit there is no reason to
not set the high limit along the way. I see a zero reason to make a
global hard coded policy for something like that.  Not to mention that
%age is a really bad interface as it gets hugely impractical with large
%limits.

> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>

Nacked-by: Michal Hocko <mhocko@suse.com>

> > ---
> >   Documentation/admin-guide/sysctl/vm.rst | 10 ++++++
> >   include/linux/memcontrol.h              |  3 ++
> >   mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
> >   3 files changed, 54 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index e86c968a7a0e..250ec39dd5af 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -46,6 +46,7 @@ Currently, these files are in /proc/sys/vm:
> >   - mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=y)
> >   - memory_failure_early_kill
> >   - memory_failure_recovery
> > +- memory_high_autoset_ratio
> >   - min_free_kbytes
> >   - min_slab_ratio
> >   - min_unmapped_ratio
> > @@ -479,6 +480,15 @@ Enable memory failure recovery (when supported by the platform)
> >   0: Always panic on a memory failure.
> > +memory_high_autoset_ratio
> > +=========================
> > +
> > +Specify a ratio by which memory.high should be set as a fraction of
> > +memory.max if it hasn't been explicitly set before.  It allows a range
> > +of 0-100.  The default value of 0 means auto setting will be disabled.
> > +For any non-zero value "n", the actual ratio used will be "n/(n+1)".
> > +
> > +
> >   min_free_kbytes
> >   ===============
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 030d34e9d117..6be161a6b922 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -221,6 +221,9 @@ struct mem_cgroup {
> >   	 */
> >   	bool oom_group;
> > +	/* %true if memory.high has been explicitly set */
> > +	bool memory_high_set;
> > +
> >   	/* protected by memcg_oom_lock */
> >   	bool		oom_lock;
> >   	int		under_oom;
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 71fe2a95b8bd..2cfb000bf543 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -48,6 +48,7 @@
> >   #include <linux/swap.h>
> >   #include <linux/swapops.h>
> >   #include <linux/spinlock.h>
> > +#include <linux/sysctl.h>
> >   #include <linux/eventfd.h>
> >   #include <linux/poll.h>
> >   #include <linux/sort.h>
> > @@ -6889,6 +6890,35 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
> >   }
> >   #endif
> > +/*
> > + * The memory.high autoset ratio specifies a ratio by which memory.high
> > + * should be set as a fraction of memory.max if it hasn't been explicitly
> > + * set before. The default value of 0 means auto setting will be disabled.
> > + * For any non-zero value "n", the actual ratio is "n/(n+1)".
> > + */
> > +static int sysctl_memory_high_autoset_ratio;
> > +
> > +#ifdef CONFIG_SYSCTL
> > +static struct ctl_table memcg_table[] = {
> > +	{
> > +		.procname	= "memory_high_autoset_ratio",
> > +		.data		= &sysctl_memory_high_autoset_ratio,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= SYSCTL_ZERO,
> > +		.extra2		= SYSCTL_ONE_HUNDRED,
> > +	},
> > +};
> > +
> > +static inline void memcg_sysctl_init(void)
> > +{
> > +	register_sysctl_init("vm", memcg_table);
> > +}
> > +#else
> > +static void memcg_sysctl_init(void)	{ }
> > +#endif /* CONFIG_SYSCTL */
> > +
> >   static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
> >   {
> >   	if (value == PAGE_COUNTER_MAX)
> > @@ -6982,6 +7012,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> >   		return err;
> >   	page_counter_set_high(&memcg->memory, high);
> > +	memcg->memory_high_set = true;
> >   	for (;;) {
> >   		unsigned long nr_pages = page_counter_read(&memcg->memory);
> > @@ -7023,6 +7054,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
> >   	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
> >   	bool drained = false;
> >   	unsigned long max;
> > +	unsigned int high_ratio = sysctl_memory_high_autoset_ratio;
> >   	int err;
> >   	buf = strstrip(buf);
> > @@ -7032,6 +7064,13 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
> >   	xchg(&memcg->memory.max, max);
> > +	if (high_ratio && !memcg->memory_high_set) {
> > +		/* Set memory.high as a fraction of memory.max */
> > +		unsigned long high = max * high_ratio / (high_ratio + 1);
> > +
> > +		page_counter_set_high(&memcg->memory, high);
> > +	}
> > +
> >   	for (;;) {
> >   		unsigned long nr_pages = page_counter_read(&memcg->memory);
> > @@ -7977,6 +8016,8 @@ static int __init mem_cgroup_init(void)
> >   		soft_limit_tree.rb_tree_per_node[node] = rtpn;
> >   	}
> > +	memcg_sysctl_init();
> > +
> >   	return 0;
> >   }
> >   subsys_initcall(mem_cgroup_init);

-- 
Michal Hocko
SUSE Labs

