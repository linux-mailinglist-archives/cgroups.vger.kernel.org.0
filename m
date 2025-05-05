Return-Path: <cgroups+bounces-8006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB7AA9120
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 12:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C37B3B8428
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9F1FF1B0;
	Mon,  5 May 2025 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wgju/r0Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7HF6QuGH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wgju/r0Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7HF6QuGH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364A1FF1D5
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440927; cv=none; b=WtbY10mNOcg1LFtlnwPBmQc71vEHmXseqvLlXGGhrHwKG1xEtE2ZFimh4itcldTiexuchYtGxSaWeGwg3GqEbPplek5YfNmUt420nf2LXxqJoTYR1oFH7rDWFWOZDVy4rSbu9OYAKedrV5wGoD3cHj1dJL3aitFV8Ml7pkoJEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440927; c=relaxed/simple;
	bh=xIcOI+rjF3wJTGw4eMiYZwpFjQIjmwn5TZ7wOVL4//I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROShRPSYcpkIlzUB+dOi0XsnmWwoIzEuD+vmWgvC9yg8NeesG2/YRZCN3Kne7UQQV7P+oWiSN440EWLIaArU9xQ66uDYVTvBArPvra8lksFtxZXG4MS1hEuR559zSJlGtXW6wsFAId4uYgLjjxHONoS1ESVbPUaJ24mzOeJhXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wgju/r0Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7HF6QuGH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wgju/r0Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7HF6QuGH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CB4A216E7;
	Mon,  5 May 2025 10:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746440923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUKmF0l1uoVegKQTRJ4xaHNRok4JcaH5/hPpcntKhyI=;
	b=Wgju/r0Qemj5aT0tMy2WWHYQEpRd+WGMHVqvzJXgCR+gq4FJaiw3L7fWfrsJb4JjrDV8Vj
	uldC7dRTjWTaqY8cT3Hil+aQ21Kyu4e7L15S2tWfQqfeIbYMZmns5z1Ewg5CCpkW435K2D
	gfbSIUwXvjSlQziPOrRmrwgXVrVd2hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746440923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUKmF0l1uoVegKQTRJ4xaHNRok4JcaH5/hPpcntKhyI=;
	b=7HF6QuGHuORbmwguxzRS9EEaMSSqL1j3+OCe3f0DjNrolRC0muiMK1yo1NmfICY9ekFw0q
	zopGSA3510VzfgBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Wgju/r0Q";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7HF6QuGH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746440923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUKmF0l1uoVegKQTRJ4xaHNRok4JcaH5/hPpcntKhyI=;
	b=Wgju/r0Qemj5aT0tMy2WWHYQEpRd+WGMHVqvzJXgCR+gq4FJaiw3L7fWfrsJb4JjrDV8Vj
	uldC7dRTjWTaqY8cT3Hil+aQ21Kyu4e7L15S2tWfQqfeIbYMZmns5z1Ewg5CCpkW435K2D
	gfbSIUwXvjSlQziPOrRmrwgXVrVd2hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746440923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUKmF0l1uoVegKQTRJ4xaHNRok4JcaH5/hPpcntKhyI=;
	b=7HF6QuGHuORbmwguxzRS9EEaMSSqL1j3+OCe3f0DjNrolRC0muiMK1yo1NmfICY9ekFw0q
	zopGSA3510VzfgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7527813883;
	Mon,  5 May 2025 10:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ck+zG9uSGGjafQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 May 2025 10:28:43 +0000
Message-ID: <81a2e692-dd10-4253-afbc-062e0be67ca4@suse.cz>
Date: Mon, 5 May 2025 12:28:43 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
 <20250502001742.3087558-4-shakeel.butt@linux.dev>
 <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
 <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9CB4A216E7
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 5/3/25 01:03, Shakeel Butt wrote:
>> > index cd81c70d144b..f8b9c7aa6771 100644
>> > --- a/mm/memcontrol.c
>> > +++ b/mm/memcontrol.c
>> > @@ -1858,7 +1858,6 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
>> >  {
>> >         struct memcg_stock_pcp *stock;
>> >         uint8_t stock_pages;
>> > -       unsigned long flags;
>> >         bool ret = false;
>> >         int i;
>> >
>> > @@ -1866,8 +1865,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
>> >                 return ret;
>> >
>> >         if (gfpflags_allow_spinning(gfp_mask))
>> > -               local_lock_irqsave(&memcg_stock.lock, flags);
>> > -       else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
>> > +               local_lock(&memcg_stock.lock);
>> > +       else if (!local_trylock(&memcg_stock.lock))
>> >                 return ret;
>>
>> I don't think it works.
>> When there is a normal irq and something doing regular GFP_NOWAIT
>> allocation gfpflags_allow_spinning() will be true and
>> local_lock() will reenter and complain that lock->acquired is
>> already set... but only with lockdep on.
> 
> Yes indeed. I dropped the first patch and didn't fix this one
> accordingly. I think the fix can be as simple as checking for
> in_task() here instead of gfp_mask. That should work for both RT and
> non-RT kernels.

These in_task() checks seem hacky to me. I think the patch 1 in v1 was the
correct way how to use the local_trylock() to avoid these.

As for the RT concerns, AFAIK RT isn't about being fast, but about being
preemptible, and the v1 approach didn't violate that - taking the slowpaths
more often shouldn't be an issue.

Let me quote Shakeel's scenario from the v1 thread:

> I didn't really think too much about PREEMPT_RT kernels as I assume
> performance is not top priority but I think I get your point. Let me

Agreed.

> explain and correct me if I am wrong. On PREEMPT_RT kernel, the local
> lock is a spin lock which is actually a mutex but with priority
> inheritance. A task having the local lock can still get context switched

Let's say (seems implied already) this is a low prio task.

> (but will remain on same CPU run queue) and the newer task can try to

And this is a high prio task.

> acquire the memcg stock local lock. If we just do trylock, it will
> always go to the slow path but if we do local_lock() then it will sleeps
> and possibly gives its priority to the task owning the lock and possibly
> make that task to get the CPU. Later the task slept on memcg stock lock
> will wake up and go through fast path.

I think from RT latency perspective it could very much be better for the
high prio task just skip the fast path and go for the slowpath, instead of
going to sleep while boosting the low prio task to let the high prio task
use the fast path later. It's not really a fast path anymore I'd say.

