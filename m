Return-Path: <cgroups+bounces-13156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8188D1926B
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F733062E1B
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A87210F59;
	Tue, 13 Jan 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAvFxvgs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJ7zE/WJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAvFxvgs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJ7zE/WJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D138F954
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311916; cv=none; b=hpWzaPHbWN5c8ppSNkstF0geM4WLIQ+NCDlYdGsqsMgZNCKKB3VeibnfgEQqdROAYmF63rD/67LvH+wefs7OxyCHElXv4RJ93sH9JdQuyjywlI0zaUZABHxhNdMyzs1qv9A1mD4stlac0C9phu3oFXlrw6DySkZVFwqiv0Ywk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311916; c=relaxed/simple;
	bh=MMHQiHKRhetZkQhJqJfj44CANOd4uCj3BhXaWcQMLPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdmN9eRJ9wAsXRycdQBe76/UVHDs4fr5Oq5KWSsURQDxjz/UIPODSv4Jn4TQWg8Z6wyrXxC82YqNXIcndeMjEL+gt8DeyG+KIMzisvDz3mnxwMo0vC6cCR3UqPGjbzpXz3Dfvih/sXCjQWpY3PR2qC17bkrBrWNRPehxr2bl4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAvFxvgs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJ7zE/WJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAvFxvgs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJ7zE/WJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48A5C33681;
	Tue, 13 Jan 2026 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768311912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2moOxEzMFuu+KRWMPMMWRhe7dQoy5+0s8Uh3fikrpPE=;
	b=uAvFxvgs2uxtphOPUupeAOP2zAzthTFZ3bhDPqYoXPkRCo3ssunlOclzEXYQP6RYCuH0pK
	+YRHVE22wH2Pt8KqdMoaAQaMs937hNe0TxKcpG4IFcfN52Eh9jlwLnz1/ejYnBm7DQE/zA
	xoyKnj03/g4CqpJkEpgmTaU02fs+wXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768311912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2moOxEzMFuu+KRWMPMMWRhe7dQoy5+0s8Uh3fikrpPE=;
	b=SJ7zE/WJfcRQAyYaDpUYOQ9dLqr3QPhIMxAAJEVQz8oIsOdF7gegY+fIl7d4wVCx768FqD
	rpzJ7iaPLtYlR2Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uAvFxvgs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="SJ7zE/WJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768311912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2moOxEzMFuu+KRWMPMMWRhe7dQoy5+0s8Uh3fikrpPE=;
	b=uAvFxvgs2uxtphOPUupeAOP2zAzthTFZ3bhDPqYoXPkRCo3ssunlOclzEXYQP6RYCuH0pK
	+YRHVE22wH2Pt8KqdMoaAQaMs937hNe0TxKcpG4IFcfN52Eh9jlwLnz1/ejYnBm7DQE/zA
	xoyKnj03/g4CqpJkEpgmTaU02fs+wXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768311912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2moOxEzMFuu+KRWMPMMWRhe7dQoy5+0s8Uh3fikrpPE=;
	b=SJ7zE/WJfcRQAyYaDpUYOQ9dLqr3QPhIMxAAJEVQz8oIsOdF7gegY+fIl7d4wVCx768FqD
	rpzJ7iaPLtYlR2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 241023EA63;
	Tue, 13 Jan 2026 13:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mOeSCGhMZmm0IgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 13:45:12 +0000
Message-ID: <26d09b99-98fd-461e-bbdd-138fb37948e4@suse.cz>
Date: Tue, 13 Jan 2026 14:45:11 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 8/9] mm/slab: move [__]ksize and slab_ksize() to
 mm/slub.c
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
 dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
 rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
 shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
 yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, hao.li@linux.dev
References: <20260113061845.159790-1-harry.yoo@oracle.com>
 <20260113061845.159790-9-harry.yoo@oracle.com>
 <2cdff2ed-a45d-47e9-94ef-f8ecd178bbae@suse.cz> <aWZDDfq72XP3Uuef@hyeyoo>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aWZDDfq72XP3Uuef@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,gentwo.org,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 48A5C33681
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/13/26 2:05 PM, Harry Yoo wrote:
> On Tue, Jan 13, 2026 at 01:44:45PM +0100, Vlastimil Babka wrote:
>>>  
>>> -/**
>>> - * __ksize -- Report full size of underlying allocation
>>> - * @object: pointer to the object
>>> - *
>>> - * This should only be used internally to query the true size of allocations.
>>> - * It is not meant to be a way to discover the usable size of an allocation
>>> - * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
>>> - * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
>>> - * and/or FORTIFY_SOURCE.
>>> - *
>>> - * Return: size of the actual memory used by @object in bytes
>>> - */
>>> -size_t __ksize(const void *object)
>>
>> Think it could be also static and not in slab.h? I'll make that change
>> locally.
> 
> Uh, great. Thanks!
> 
> By the way `size_t __ksize(const void *objp);` is in both
> include/linux/slab.h and mm/slab.h.

Ack. Also moving the kerneldoc to ksize() as it should have been there
anyway.



