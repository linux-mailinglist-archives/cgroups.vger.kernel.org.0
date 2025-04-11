Return-Path: <cgroups+bounces-7478-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E27A8653B
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 20:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6194D3BA6C9
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CCF258CE8;
	Fri, 11 Apr 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPu/ezpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzLxMm2P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPu/ezpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzLxMm2P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A229258CE6
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394781; cv=none; b=AZx9axVUe1bcp8I3Z7fsNChHIO+Ie7HVJfIesakAcO4AoClns2otZpoYIwtFXZprUyqNBdOGvPkhGhVnTyMrJcThjQc6+2tFc5ONa8UYs+B9WgWZ30c2FN2hRsPsFVoHJowK5j7WtoMzAUpHocwsHVvDkm0oytIcHVLtAGZcnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394781; c=relaxed/simple;
	bh=ll6jYyIJK91Egam5YZq23oz57DO9B1/3u/Z1NHRqv2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lusbxuoHrwwKB51FVjyXNLKqyWj0Yozua5YZZpbaAS0LXltfrh6fW32qlSsUH6wXflQ4Wm34RXb4UHvCVtF5+lOnh+B6m5Xto4gEEJsDYwImwzknqlnXp+pzeUOCVtsO000cfICyK+O4ZuHXE7XfIKTkYpxXcTre4P2MU7Oe0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPu/ezpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzLxMm2P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPu/ezpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzLxMm2P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 625C421192;
	Fri, 11 Apr 2025 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744394777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSB2ncRIaB8MGwCyPZodshLfZ6drnJjoqfJfTj5uO7o=;
	b=dPu/ezpJKvyI34rU3nNJkDYzXW8v+uOfvhFTRbWkkglaKXHsV6jl4rqEH53P1NmAP3Bgbe
	5WP/DA+BAQ3LGBDjdljinqQFaKj+4sFetZMsICxxp9XURneUYTfIVoVc99nUATmhqMdR6Z
	6wu3GlPvC1tSJp8ozCxYiZoB2i8S83M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744394777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSB2ncRIaB8MGwCyPZodshLfZ6drnJjoqfJfTj5uO7o=;
	b=GzLxMm2Plqv//LoMUrMLo7uY3FkHcW5WpJ/DpFJw1+yRWScuS/oG3jCLKk/DqNi28Uyu4v
	It45QtemXOkWtKAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="dPu/ezpJ";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GzLxMm2P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744394777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSB2ncRIaB8MGwCyPZodshLfZ6drnJjoqfJfTj5uO7o=;
	b=dPu/ezpJKvyI34rU3nNJkDYzXW8v+uOfvhFTRbWkkglaKXHsV6jl4rqEH53P1NmAP3Bgbe
	5WP/DA+BAQ3LGBDjdljinqQFaKj+4sFetZMsICxxp9XURneUYTfIVoVc99nUATmhqMdR6Z
	6wu3GlPvC1tSJp8ozCxYiZoB2i8S83M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744394777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSB2ncRIaB8MGwCyPZodshLfZ6drnJjoqfJfTj5uO7o=;
	b=GzLxMm2Plqv//LoMUrMLo7uY3FkHcW5WpJ/DpFJw1+yRWScuS/oG3jCLKk/DqNi28Uyu4v
	It45QtemXOkWtKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C522136A4;
	Fri, 11 Apr 2025 18:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w+QBDhla+WemSQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Apr 2025 18:06:17 +0000
Message-ID: <8cce9a28-3b02-4126-a150-532e92c0e7f8@suse.cz>
Date: Fri, 11 Apr 2025 20:06:16 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Waiman Long <llong@redhat.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
 <CAGj-7pUxYUDdRGaiFon=V2EG+3Ex5s9i7VvWbDH5T0v-7SE-CQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAGj-7pUxYUDdRGaiFon=V2EG+3Ex5s9i7VvWbDH5T0v-7SE-CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 625C421192
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linutronix.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/11/25 19:54, Shakeel Butt wrote:
> (my migadu/linux.dev stopped working and I have to send through gmail,
> sorry for any formatting issue)
> 
> I don't see how local_irq_save() will break anything. We are working on
> a stock of a dead remote cpu. We actually don't even need to disable irq
> or need local cpu's local_lock. It is actually the calls to
> __mod_memcg_lruvec_state() and __mod_memcg_state() in
> __drain_obj_stock() which need irq-disabled on non-RT kernels and for
> RT-kernels they already have preempt_disable_nested().
> 
> Disabling irq even on RT seems excessive but this is not a performance
> critical code, so I don't see an issue unless there is
> local_lock_irqsave() alternative which does not disables irqs on RT
> kernels.

local_lock_irqsave() does not disable irqs on RT kernels :) so keeping
local_lock as is would do the irq disable on !RT and be more RT-friendly on
RT. It's just wrong from the logical scope of the lock to perform it on a
different cpu than the stock we modify. If one day we have some runtime
checks for that, they would complain.

