Return-Path: <cgroups+bounces-8156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DE5AB4C88
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 09:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B597F16E591
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF71F03DE;
	Tue, 13 May 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ROraWs7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p0MMbgRl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ROraWs7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p0MMbgRl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73B433B1
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120528; cv=none; b=ZEq8J2hWVHxrebD5soclBCNk7Qm80HLQn5Ta6jEZs0kccl/G2NUWnkJhmv6GUsdZNTWBJuyAh6WbOSjeGhZcaApZ7Y7FOwdCuDpV277wZ8A7xQ/nCU5dIj3qcI0ERH5UzYQRIoJGlo+DX/fPeacL43zj27pL7GAdIq13HiiBfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120528; c=relaxed/simple;
	bh=jVZ5/2j32r5gSro7eUI5O2QTGiEFQ0aQT1niktiUiGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAOdLkBhrqsKKfsMtUiy6SNwh4QVRcTWQzsd7+0zC0zvTx38cl2U3rjK3tOLNf30w0E6goGqgaaP5A1sC3FEgo32Smz+SfiK8I/qAA1bAF/hxm5womJIjyMJ3ptFIFezvWaMeSTI8QryGOxKcYW5sGG9ig8mzimEfgAvcV6yK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ROraWs7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p0MMbgRl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ROraWs7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p0MMbgRl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 447B01F443;
	Tue, 13 May 2025 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747120524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be8oLaF1XY+ew3NrcaBsZrwtLFQ8Y+wmaaeGX1M5udQ=;
	b=2ROraWs7n7h8YDCl7bDSG0oIj+Cp+2cg0DPODFWCnbfdYwjSLEMsUAXWHkhExob9HSav53
	7heEoJS9XabZoDlnx4ALiNtc2xJ1J7v0Yi1Mb3NjL1RFFpBt7CaKSlwZIFpS7qYiLoDYDJ
	w4JwIciqwPCSp6Mv8cI1ydsaPNDVxxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747120524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be8oLaF1XY+ew3NrcaBsZrwtLFQ8Y+wmaaeGX1M5udQ=;
	b=p0MMbgRlMPZl8K82MK4rdhKr93W8rKYimUD6vBwRNDQRO7CUrXOKiewqO0K5dWALz44m1Y
	DkIVOHi56A1xQ8Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2ROraWs7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p0MMbgRl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747120524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be8oLaF1XY+ew3NrcaBsZrwtLFQ8Y+wmaaeGX1M5udQ=;
	b=2ROraWs7n7h8YDCl7bDSG0oIj+Cp+2cg0DPODFWCnbfdYwjSLEMsUAXWHkhExob9HSav53
	7heEoJS9XabZoDlnx4ALiNtc2xJ1J7v0Yi1Mb3NjL1RFFpBt7CaKSlwZIFpS7qYiLoDYDJ
	w4JwIciqwPCSp6Mv8cI1ydsaPNDVxxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747120524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be8oLaF1XY+ew3NrcaBsZrwtLFQ8Y+wmaaeGX1M5udQ=;
	b=p0MMbgRlMPZl8K82MK4rdhKr93W8rKYimUD6vBwRNDQRO7CUrXOKiewqO0K5dWALz44m1Y
	DkIVOHi56A1xQ8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F31981365D;
	Tue, 13 May 2025 07:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S4mxLYvxImjwVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 07:15:23 +0000
Message-ID: <07e4e8d9-2588-41bf-89d4-328ca6afd263@suse.cz>
Date: Tue, 13 May 2025 09:15:23 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
 <mzrsx4x5xluljyxy5h5ha6kijcno3ormac3sobc3k7bkj5wepr@cuz2fluc5m5d>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <mzrsx4x5xluljyxy5h5ha6kijcno3ormac3sobc3k7bkj5wepr@cuz2fluc5m5d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 447B01F443
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 5/12/25 21:12, Shakeel Butt wrote:
> I forgot to CC Tejun, so doing it now.
> 
> On Mon, May 12, 2025 at 05:56:09PM +0200, Vlastimil Babka wrote:
>> On 5/10/25 01:28, Shakeel Butt wrote:
>> > BPF programs can trigger memcg charged kernel allocations in nmi
>> > context. However memcg charging infra for kernel memory is not equipped
>> > to handle nmi context. This series adds support for kernel memory
>> > charging for nmi context.
>> > 
>> > The initial prototype tried to make memcg charging infra for kernel
>> > memory re-entrant against irq and nmi. However upon realizing that
>> > this_cpu_* operations are not safe on all architectures (Tejun), this
>> 
>> I assume it was an off-list discussion?
>> Could we avoid this for the architectures where these are safe, which should
>> be the major ones I hope?
> 
> Yes it was an off-list discussion. The discussion was more about the
> this_cpu_* ops vs atomic_* ops as on x86 this_cpu_* does not have lock
> prefix and how I should prefer this_cpu_* over atomic_* for my series on
> objcg charging without disabling irqs. Tejun pointed out this_cpu_* are
> not nmi safe for some archs and it would be better to handle nmi context
> separately. So, I am not that worried about optimizing for NMI context

Well, we're introducing in_nmi() check and different execution paths to all
charging. This could be e.g. compiled out for architectures where this_cpu*
is NMI safe or they don't have NMIs in the first place.

> but your next comment on generic_atomic64_* ops is giving me headache.
> 
>> 
>> > series took a different approach targeting only nmi context. Since the
>> > number of stats that are updated in kernel memory charging path are 3,
>> > this series added special handling of those stats in nmi context rather
>> > than making all >100 memcg stats nmi safe.
>> 
>> Hmm so from patches 2 and 3 I see this relies on atomic64_add().
>> But AFAIU lib/atomic64.c has the generic fallback implementation for
>> architectures that don't know better, and that would be using the "void
>> generic_atomic64_##op" macro, which AFAICS is doing:
>> 
>>         local_irq_save(flags);                                          \
>>         arch_spin_lock(lock);                                           \
>>         v->counter c_op a;                                              \
>>         arch_spin_unlock(lock);                                         \
>>         local_irq_restore(flags);                                       \
>> 
>> so in case of a nmi hitting after the spin_lock this can still deadlock?
>> 
>> Hm or is there some assumption that we only use these paths when already
>> in_nmi() and then another nmi can't come in that context?
>> 
>> But even then, flush_nmi_stats() in patch 1 isn't done in_nmi() and uses
>> atomic64_xchg() which in generic_atomic64_xchg() implementation also has the
>> irq_save+spin_lock. So can't we deadlock there?
> 
> I was actually assuming that atomic_* ops are safe against nmis for all
> archs. I looked at atomic_* ops in include/asm-generic/atomic.h and it
> is using arch_cmpxchg() for CONFIG_SMP and it seems like for archs with
> cmpxchg should be fine against nmi. I am not sure why atomic64_* are not
> using arch_cmpxchg() instead. I will dig more.

Yeah I've found https://docs.kernel.org/core-api/local_ops.html and since it
listed Mathieu we discussed on IRC and he mentioned the same thing that
atomic_ ops are fine, but the later added 64bit variant isn't, which PeterZ
(who added it) acknowledged.

But there could be way out if we could somehow compile-time assert that
either is true:
- CONFIG_HAVE_NMI=n - we can compile out all the nmi code
- this_cpu is safe on that arch - we can also compile out the nmi code
- (if the above leaves any 64bit arch) its 64bit atomics implementation is safe
- (if there are any 32bit applicable arch left) 32bit atomics should be
enough for the nmi counters even with >4GB memory as we flush them? and we
know the 32bit ops are safe

> I also have the followup series on objcg charging without irq almost
> ready. I will send it out as rfc soon.
> 
> Thanks a lot for awesome and insightful comments.
> Shakeel


