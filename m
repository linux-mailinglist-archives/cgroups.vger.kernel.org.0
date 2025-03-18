Return-Path: <cgroups+bounces-7127-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA8A66D38
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C119A7AD136
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFE1DE4DC;
	Tue, 18 Mar 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1iHoUpml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H1ckTrWy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1R4xYH3y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i99fN9rI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402A1A08A8
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284942; cv=none; b=P8tq5gEcsxQJbfzI7Sb4VS4kvu7vcYPTPNy4GkbWwS1cnsS7PNpiwP1/VCy/h4+kiCr9+HpSGfdqyUK6IvWK8MXwy/w7nNgI6KAyqblgIwuLDwidF2iH9Vf+e/cfQQejnWKx933QZDS+M6jWBqwLXsT3phUfQS5QY8ajjt87N+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284942; c=relaxed/simple;
	bh=cNLIHQoAcvw/8UQcz7D4OKQrpHWgfp+DZ+Obtl7IUwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfCD1/Czi6KDsbTqPJQ6ShojE/7XYWns34Xe+NNxXXKgPtU+Tf2ZdNcCXpJxQl/jn1IlDn/kLZSi7UOAcnFyrM9RSr84rFYA4L251SFrssNFWjP2Gh3SAgIb69329Y5lkxZjTH5vW9Ea68Hn7xJhcB64o86QAD5sycQxpnZDDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1iHoUpml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H1ckTrWy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1R4xYH3y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i99fN9rI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4625A1FE8A;
	Tue, 18 Mar 2025 08:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CguAyUC+jGuNR5lcEiJNg7PbJt/+ncS/Zz9QAnzsc08=;
	b=1iHoUpmlZk4P7hKNh4/YT3uYG4TcWUF6roGR0b0F/UZ7VoE9kLx6b5Q9eJ+lXLlnAfoQg/
	N7stskWbW2UfSjj+UlZPOyMtG+NSkylhQYlfb6qpzWeJEtVs7FiHJzbAyaV8UgiguJv87i
	3LncZJN82LLcOyKrks0L/24TvXFU/E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CguAyUC+jGuNR5lcEiJNg7PbJt/+ncS/Zz9QAnzsc08=;
	b=H1ckTrWyIwvUXL/t2Dl/gOjhms/Y42JX2qWGKGmbsnBujJRRWP0r6Kk6zbcgnK+Vz1WcZM
	y1AnHAqjdAU+TtCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CguAyUC+jGuNR5lcEiJNg7PbJt/+ncS/Zz9QAnzsc08=;
	b=1R4xYH3y65pstwz2NIdSMmxg/DO71YPl3euqNAfahcp8jcdx6qBmOH3pUA1nqqsKwRLf4f
	kQFXGTo09bvUgOsMvpzkKN8zDgCVySFkg+lHihglrZIF39wmqifwp6ctdZ4LmKfwXCxiUP
	BMIF8SMk+6T7pd1qdM8fSMkbxkP4hH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CguAyUC+jGuNR5lcEiJNg7PbJt/+ncS/Zz9QAnzsc08=;
	b=i99fN9rIAkgtzpd1mbVeH2eyumTXvg2k/BftUEugx6g1IxPTybKvAuWPiU4hvYeTsC03cE
	UM6S52M+qtbrJwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A8201379A;
	Tue, 18 Mar 2025 08:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T5P3CYko2WfWBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Mar 2025 08:02:17 +0000
Message-ID: <24a8fa02-6504-4597-a445-a8124919410f@suse.cz>
Date: Tue, 18 Mar 2025 09:02:16 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] memcg: use __mod_memcg_state in drain_obj_stock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-8-shakeel.butt@linux.dev>
 <7d50a14a-edfb-410d-840e-17876806a63b@suse.cz>
 <6n7rsw565dy4kt7yxmik5kpxdz2b5h2bdsysfvi2rwmvl4juml@npkqfiyzfqua>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6n7rsw565dy4kt7yxmik5kpxdz2b5h2bdsysfvi2rwmvl4juml@npkqfiyzfqua>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,linux.dev:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/17/25 22:54, Shakeel Butt wrote:
> On Mon, Mar 17, 2025 at 09:56:39PM +0100, Vlastimil Babka wrote:
>> On 3/15/25 18:49, Shakeel Butt wrote:
>> > For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
>> > disabled, so we can use __mod_memcg_state() instead of
>> > mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
>> > in __mod_memcg_state().
>> > 
>> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> 
>> I've asked in the RFC and from Sebastian's answer I think my question was
>> misunderstod, so let me try again.
>> 
>> After this patch we'll have from mod_memcg_state():
>> 
>> mod_memcg_state()
>>   local_irq_save(flags);
>>   __mod_memcg_state()
>>     memcg_stats_lock(); <- new and unnecessary?
>> 
>> Instead of modifying __mod_memcg_state() we could be more targetted and just
>> do in drain_obj_stock():
>> 
>> memcg_stats_lock();
>> __mod_memcg_state();
>> memcg_stats_unlock();
>> 
>> Am I missing something?
> 
> This seems unnecessary because this patch is adding the first user of
> __mod_memcg_state()

You mean first other user than mod_memcg_state() itself.

> but I think maintainability is better with
> memcg_stats_[un]lock() inside __mod_memcg_state().
> 
> Let's take the example of __mod_memcg_lruvec_state(). It is being
> called from places where non-RT kernel, the irqs are disabled through
> spin_lock_irq*, so on RT kernel, the irq would not be disabled and
> thus explicitly need preemption disabled. What if in future
> __mod_memcg_state() is being used by a caller which assumes preemption
> is disabled through irq disable. The RT kernel would be buggy there.
> 
> I am not sure if it is easy to force the future users to explicitly add
> memcg_stats_[un]lock() across the call to __mod_memcg_state().

I see the point. Well least memcg_stats_lock() isn't expensive, and it's a
no-op on non-debug !RT anyway.

Acked-by: Vlastimil Babka <vbabka@suse.cz>



