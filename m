Return-Path: <cgroups+bounces-16243-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOjpA34+FGq6LAcAu9opvQ
	(envelope-from <cgroups+bounces-16243-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:20:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18A5CA63F
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C22DF301586E
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D053812DB;
	Mon, 25 May 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gOr+SW++";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/bf8OI2J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t+oCC0Pj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mYLjb8mt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455237DAA0
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711610; cv=none; b=ecIgdnPxC3ktRCXWMOVbh72WLQJpXSeBEOkX15Zodwl579coH3UMwa6RgJUOLfLILEd/02/8FOPBrnWI4hlJ0/yiA6U7Kgya17MqZO0sHzTbfRqxEvooGS0y6H9z3QuVjSRGPETimTPbQM3267hkxzt/SBK4CfF0U4J6Y8TvKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711610; c=relaxed/simple;
	bh=yCMoCLCrLXaiLf5t0kz+NiL3iaEmN33yjEtznzG5zkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlQSff1pBlJTSjD3DHgWtXWg/gFDzJnrtbb7xnpK7sZ2t/Jp1Jj0PP6GkHmvuvA8hscUze9Jg6dAZW5qoHEYr6OFDRI8Wwmqj9b7DZu8w4ohksN5JusnpBQZRen5mhsqCKHygN66tMfRShoad/wUPJh8O0osHCVpSmpKaz+sQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gOr+SW++; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/bf8OI2J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t+oCC0Pj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mYLjb8mt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFF946B5B7;
	Mon, 25 May 2026 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779711607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqfB1Kr5g6SVxfd6pFjgYACkSulPuOJ/RrprUx1Yf9c=;
	b=gOr+SW++IhoWNq+bc9l1riY+T8Wadxyds+6bj1YX70wZVq5R4QSVT6cNXpFU4s5/Ewhawd
	uNHapk5+qf1mX1NY7OrsheeAbjnXvI+a7gXFDlMFKHmgYJ5Lug5NoQiuNKaBSmzoYZUT7B
	e8P1SIMFpNHLAUQA5bl/8AJPv+tzlSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779711607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqfB1Kr5g6SVxfd6pFjgYACkSulPuOJ/RrprUx1Yf9c=;
	b=/bf8OI2J/6hCTJRH9OTL1lruS6RVcmzeMZuwn/6utearl8bvbi2q30/u4xKdZpImlkGx9O
	LPlm29Uk0MSHUVBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t+oCC0Pj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mYLjb8mt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779711606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqfB1Kr5g6SVxfd6pFjgYACkSulPuOJ/RrprUx1Yf9c=;
	b=t+oCC0Pj85PX857Tcq2heOdieSU4kQkjH208IQ9o/Tnl3bKKEYCzQS5fUMG30GAJYrU7pL
	Yo1++iRFd1svys0ynUa2Y8uAxjXY4k6O4wgjERYXlxNhHpsK+pYUnT8HhT+ngmsJ4cUAPc
	zYrIuGRP0992kwCVCASVd9NHCOABzNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779711606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqfB1Kr5g6SVxfd6pFjgYACkSulPuOJ/RrprUx1Yf9c=;
	b=mYLjb8mt/iNKz7nrEUZnakkFvcTWxl8UQERt0rFy8anZHDkLwAiDOnsrUojcVCg3pq93gx
	+XCqusQEQ4VoLdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B13E759C37;
	Mon, 25 May 2026 12:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CBfcKnY+FGogMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 12:20:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55552A08D7; Mon, 25 May 2026 14:20:06 +0200 (CEST)
Date: Mon, 25 May 2026 14:20:06 +0200
From: Jan Kara <jack@suse.cz>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kshitij Doshi <kshitijd@uber.com>
Subject: Re: [PATCH RFC] memcg: add per-cgroup dirty page controls
 (dirty_ratio, dirty_min)
Message-ID: <u2ckfxudxhp6xjljlpext3m3dc3fbx3ebatyz7tbfhk2v7am5b@mn3ye7xstiqf>
References: <20260501-rfc-memcg-dirty-v1-v1-1-9a8c80036ec1@uber.com>
 <pbwzmyglpz33d3k63aopi5vlghz4jmur2k2g4res6mhktuujhh@rmqooz6bqaao>
 <CA+w=M=RkewNB0Fc=KNXTrOnt-YABFy+7ZALLmp1wQOP5k_=13Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+w=M=RkewNB0Fc=KNXTrOnt-YABFy+7ZALLmp1wQOP5k_=13Q@mail.gmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16243-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6C18A5CA63F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the details and sorry for a delayed reply. I had two conferences
lately...

On Wed 13-05-26 21:10:10, Alireza Haghdoost wrote:
> On Wed 06-05-26 16:21:00, Jan Kara wrote:
> > Things like motivation actually belong to the changelog itself, measured
> > results how the patch helps as well. On the other hand stuff like history
> > is largely irrelevant here, frankly I don't have a bandwidth to carefully
> > read the huge amount of text LLM has generated below so please try to make
> > it more concise for next time.
> 
> Understood. Will trim for the non-RFC posting; apologies for the
> volume.
> 
> > ... I quite don't see how a multisecond stalls you are describing would
> > happen [...] If we are below freerun in the memcg, the task dirtying
> > folios from that memcg shouldn't be throttled at all, once we get above
> > freerun we throttle by maximum of throttling delay decided from global
> > and memcg situation [...]
> 
> The stall is reachable even with the victim's memcg well below its
> own freerun. The freerun shortcut in balance_dirty_pages() is an AND,
> not OR:
> 
>   if (gdtc->freerun && (!mdtc || mdtc->freerun))
>           goto free_running;

True but this is mostly a performance optimization.

> Once gdtc is over freerun (because the noisy neighbour pushed it
> there) the shortcut does not fire, even when mdtc->freerun is true.

Below in balance_dirty_pages() we also have:

                /*
                 * Calculate global domain's pos_ratio and select the
                 * global dtc by default.
                 */
                balance_wb_limits(gdtc, strictlimit);
                if (gdtc->freerun)
                        goto free_running;
                sdtc = gdtc;

                if (mdtc) {
                        /*
                         * If memcg domain is in effect, calculate its
                         * pos_ratio.  @wb should satisfy constraints from
                         * both global and memcg domains.  Choose the one
                         * w/ lower pos_ratio.
                         */
                        balance_wb_limits(mdtc, strictlimit);
                        if (mdtc->freerun)
                                goto free_running;

which is the key logic. So unless you have strictlimit enabled (which you
didn't mention you'd have), being under freerun limit in your memcg is
enough to protect you from a noisy neighbor.

> After the shortcut fails, the per-task pause is computed from the
> dtc with the smaller pos_ratio:
> 
>   if (mdtc->pos_ratio < gdtc->pos_ratio)
>           sdtc = mdtc;
> 
> When global is the worse domain, the victim sleeps against global
> state, not memcg state.

*If* you are above freerun in your memcg (or have strictlimit enabled) then
yes, I agree.

> > So can you perhaps share more details about the configuration where
> > you observe these delays to innocent tasks due to another task
> > dirtying a lot of memory? How many page cache in total and dirty
> > pages are there in each memcg [...]? Is the delayed task really
> > throttled in balance_dirty_pages()?
> 
> Yes. Re-ran the reproducer: stock 7.0-rc5, ext4 on virtio-blk
> throttled to 256 KB/s, dirty_bytes=32M, dirty_background_bytes=16M
> (freerun = 24 MB), noisy = single fio job doing unlimited buffered
> randwrite, victim = single fio job doing 4 KiB sequential write
> rate-limited to 500 KB/s.
> 
> Per-memcg snapshot during the contended phase, ~10 s into the run:
> 
>                        noisy memcg     victim memcg     global
>   memory.current        47 MB            21 MB           --
>   file (cache)          38 MB            14 MB           --
>   file_dirty            26 MB           1.7 MB           27 MB
>   file_writeback       1.5 MB           4.0 MB          5.3 MB
> 
> Victim memcg holds 1.7 MB dirty, far below any reasonable per-memcg
> freerun. Global dirty (NR_FILE_DIRTY + NR_WRITEBACK ~ 32 MB) is over
> the 24 MB freerun ceiling, driven entirely by noisy.

Ah, OK. I think I see what's going on. How much page cache does the machine
have in total and what are memory limits for the noisy and victim memcgs?
Because there's this somewhat surprising behavior when you configure dirty
limits in bytes in domain_dirty_limits() - the memcg dirty limit will
roughly be dirty_bytes / global_available_memory * memcg_available (where
memcg_available is memcg page cache size + how much memcg can grow from the
current size until it hits memory limit). Since you set dirty_bytes to 32M,
your machine presumably has gigabytes of memory, then it's possible victim
memcg dirty limits end up really low.

> The victim writer (fio with psync) is in fact sleeping in
> balance_dirty_pages(). One stack snapshot during a stall:
> 
>   [<0>] balance_dirty_pages+0x5c5/0xac0
>   [<0>] balance_dirty_pages_ratelimited_flags+0x2a1/0x380
>   [<0>] generic_perform_write+0x194/0x280
>   [<0>] ext4_buffered_write_iter+0x63/0x110
>   [<0>] vfs_write+0x28d/0x450
>   [<0>] __x64_sys_pwrite64+0x8c/0xc0
>   [<0>] do_syscall_64+0xfa/0x520
>   [<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Sampling /proc/<pid>/wchan at 100 Hz across the contended phase
> yields the histogram:
> 
>   104  balance_dirty_pages
>    88  hrtimer_nanosleep    (the fio rate-limit sleep between writes)
>    12  RUNNING
>     4  p9_client_rpc        (virtfs, host-guest filesystem RPC)
>     3  d_alloc_parallel
> 
> The vast majority of non-rate-limit samples have the writer parked
> in balance_dirty_pages(). Victim per-IO clat in this run reaches a
> 3 s tail (worst single 4 KiB pwrite blocked ~3.0 s) while its own
> memcg holds < 2 MB dirty.

If dirty limits for the victim memcg end up really low, then yes, this is
what I'd expect.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

