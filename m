Return-Path: <cgroups+bounces-8142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B835FAB3CCA
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352657ABE21
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A6242D67;
	Mon, 12 May 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KKMaIo2j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3vtoZ/D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KKMaIo2j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3vtoZ/D"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A03242909
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065372; cv=none; b=GOSO+Z9p8wqKLgla6mQ/vlFAGLpUrc2XNMGHrzGaf2iGlz0o7UttQ4or0kjsJBNjEO1nA31L67TYDwM6LHwj27dXmEHbXAeXoOVwsj1KJGO2PV5eOj8/kqvgiCmWpmx7rxyBTWBLsHCpQagXs4WpwqUpIgW9Q/4WzsttywGSyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065372; c=relaxed/simple;
	bh=f2jWGaOfJzxueHAb4yFdMaMw58Z+YVOXeRTOkExZLiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saLE6i5IHu1jI7DWZqoBicm/DmHKKLFuDsqgh+9fdzF1PLYMIr9FlWR9GN1G8ReYAdWJa24ifICLHhdtQpa9yl6zPgafdOpRXESWV3X2dJ9P210Ce7biP4H9eQmSmS1ZuvrhBaKVM/woJFLroFeB/pernUQUwlzqC7GKwXpaQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KKMaIo2j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3vtoZ/D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KKMaIo2j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3vtoZ/D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FB3F21180;
	Mon, 12 May 2025 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747065369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tnje18TSkZvQ01oa5Qf7ZCcFzYVyVvw2JPB7RKiqgcI=;
	b=KKMaIo2jKbpBGkx/fBNsQS+Z+VWI5kTkYrJ95CpK/fczbBsRUOv/rYInjEW9AJI4aoHvrs
	lLG4L1aBQDT76uppQxClwIgM+FL/XJolkekRaTfzbGh62Y78KrotxQIshRcfWptXEDW236
	X65jU5Iatd2FJ/CmTGr7VsiDW5yDjZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747065369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tnje18TSkZvQ01oa5Qf7ZCcFzYVyVvw2JPB7RKiqgcI=;
	b=q3vtoZ/DRldVfOtcjsrqEFeV3/LXb691myGUPK/O6Fd8T2qHtzagR6dYbrz3pElKtNVUFM
	7MKhYj+/BF0H8LAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747065369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tnje18TSkZvQ01oa5Qf7ZCcFzYVyVvw2JPB7RKiqgcI=;
	b=KKMaIo2jKbpBGkx/fBNsQS+Z+VWI5kTkYrJ95CpK/fczbBsRUOv/rYInjEW9AJI4aoHvrs
	lLG4L1aBQDT76uppQxClwIgM+FL/XJolkekRaTfzbGh62Y78KrotxQIshRcfWptXEDW236
	X65jU5Iatd2FJ/CmTGr7VsiDW5yDjZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747065369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tnje18TSkZvQ01oa5Qf7ZCcFzYVyVvw2JPB7RKiqgcI=;
	b=q3vtoZ/DRldVfOtcjsrqEFeV3/LXb691myGUPK/O6Fd8T2qHtzagR6dYbrz3pElKtNVUFM
	7MKhYj+/BF0H8LAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4739B1397F;
	Mon, 12 May 2025 15:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZAPERkaImhdWQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 May 2025 15:56:09 +0000
Message-ID: <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
Date: Mon, 12 May 2025 17:56:09 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250509232859.657525-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30

On 5/10/25 01:28, Shakeel Butt wrote:
> BPF programs can trigger memcg charged kernel allocations in nmi
> context. However memcg charging infra for kernel memory is not equipped
> to handle nmi context. This series adds support for kernel memory
> charging for nmi context.
> 
> The initial prototype tried to make memcg charging infra for kernel
> memory re-entrant against irq and nmi. However upon realizing that
> this_cpu_* operations are not safe on all architectures (Tejun), this

I assume it was an off-list discussion?
Could we avoid this for the architectures where these are safe, which should
be the major ones I hope?

> series took a different approach targeting only nmi context. Since the
> number of stats that are updated in kernel memory charging path are 3,
> this series added special handling of those stats in nmi context rather
> than making all >100 memcg stats nmi safe.

Hmm so from patches 2 and 3 I see this relies on atomic64_add().
But AFAIU lib/atomic64.c has the generic fallback implementation for
architectures that don't know better, and that would be using the "void
generic_atomic64_##op" macro, which AFAICS is doing:

        local_irq_save(flags);                                          \
        arch_spin_lock(lock);                                           \
        v->counter c_op a;                                              \
        arch_spin_unlock(lock);                                         \
        local_irq_restore(flags);                                       \

so in case of a nmi hitting after the spin_lock this can still deadlock?

Hm or is there some assumption that we only use these paths when already
in_nmi() and then another nmi can't come in that context?

But even then, flush_nmi_stats() in patch 1 isn't done in_nmi() and uses
atomic64_xchg() which in generic_atomic64_xchg() implementation also has the
irq_save+spin_lock. So can't we deadlock there?

> 
> There will be a followup series which will make kernel memory charging
> reentrant for irq and will be able to do without disabling irqs.
> 
> We ran network intensive workload on this series and have not seen any
> significant performance differences with and without the series.
> 
> Shakeel Butt (4):
>   memcg: add infra for nmi safe memcg stats
>   memcg: add nmi-safe update for MEMCG_KMEM
>   memcg: nmi-safe slab stats updates
>   memcg: make objcg charging nmi safe
> 
>  include/linux/memcontrol.h |  6 +++
>  mm/memcontrol.c            | 87 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 88 insertions(+), 5 deletions(-)
> 


