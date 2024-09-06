Return-Path: <cgroups+bounces-4738-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EB96F9E6
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEE02830CA
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F51D0DC0;
	Fri,  6 Sep 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c7ned8ZP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8OADDU7H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c7ned8ZP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8OADDU7H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE381CFEC9;
	Fri,  6 Sep 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643740; cv=none; b=gSCHd21rRw7r06xUaMmXawUO5DDaADv/u/WBljCEQmB1BRt17t0Rr683nMWbl8DZdLrD6P2QsZIo6gkz8OiwAZyEUCSv3Dk/g/hf4hcbpI8Xk7EIql1LzOtyAWGjH+OKWVZEyUHZ460ehZ0TYIo+gN1vI+BcbLdm7aVNS+rrp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643740; c=relaxed/simple;
	bh=Srt4ZoXGGUPHWwmhve8sqExgnWrHTPNI6e+JVmcjlSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2/H1uBSfz1b++Q/qcTX6oUS3QL8k/MrJJ/xTXousggbp0vY3jNY4zHYLV0t+IHJEmisnBHD10MLPwwDr1MghYp5/FLsnSSeuWlNtUx9osQ6Xo00aKdhBEfcoUv2lPK6gViyi+/ImfHlMOVUA87DoJ6U0v4zk7DoZAGVFuQ54Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c7ned8ZP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8OADDU7H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c7ned8ZP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8OADDU7H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1A2D1F8C8;
	Fri,  6 Sep 2024 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725643736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cV0qElpqfiC4D7E24Y+a7MLjdiJjm5f6gPBpGdL1uDs=;
	b=c7ned8ZP0S6h9WYHssF7lA8nL7TrpUozuQR1AljEbKVkFS0T5TtctnhUwagdtnimPQ6usY
	1/qWOPlXNW8N4beR88uVXP2TAEZlsUkkGVVEvwPCa3k34yUS7JwuDHZac4fM/mzwAhQUa7
	IY/mtfpWcEmkqjBkKvEAsWvWCBtl+6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725643736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cV0qElpqfiC4D7E24Y+a7MLjdiJjm5f6gPBpGdL1uDs=;
	b=8OADDU7H5WXARJ2WmLXGfMzB/DQI+oyPh0ARoE6lwN275FEM4tl/gmaiUSE1JugJHlMP5o
	L8OvJxmSxPW86RCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c7ned8ZP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8OADDU7H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725643736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cV0qElpqfiC4D7E24Y+a7MLjdiJjm5f6gPBpGdL1uDs=;
	b=c7ned8ZP0S6h9WYHssF7lA8nL7TrpUozuQR1AljEbKVkFS0T5TtctnhUwagdtnimPQ6usY
	1/qWOPlXNW8N4beR88uVXP2TAEZlsUkkGVVEvwPCa3k34yUS7JwuDHZac4fM/mzwAhQUa7
	IY/mtfpWcEmkqjBkKvEAsWvWCBtl+6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725643736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cV0qElpqfiC4D7E24Y+a7MLjdiJjm5f6gPBpGdL1uDs=;
	b=8OADDU7H5WXARJ2WmLXGfMzB/DQI+oyPh0ARoE6lwN275FEM4tl/gmaiUSE1JugJHlMP5o
	L8OvJxmSxPW86RCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AF6C1395F;
	Fri,  6 Sep 2024 17:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b+uGIdg722Y4ZwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 06 Sep 2024 17:28:56 +0000
Message-ID: <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz>
Date: Fri, 6 Sep 2024 19:28:56 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
 <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx>
 <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz>
 <CAJD7tkZ+PYqvq6oUHtrtq1JE670A+kUBcOAbtRVudp1JBPkCwA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJD7tkZ+PYqvq6oUHtrtq1JE670A+kUBcOAbtRVudp1JBPkCwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B1A2D1F8C8
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,google.com,gmail.com,davemloft.net,redhat.com,kvack.org,vger.kernel.org,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 9/6/24 19:19, Yosry Ahmed wrote:
> [..]
>> I felt it could be improved more, so ended up with this. Thoughts?
>>
>> /**
>>  * kmem_cache_charge - memcg charge an already allocated slab memory
>>  * @objp: address of the slab object to memcg charge
>>  * @gfpflags: describe the allocation context
>>  *
>>  * kmem_cache_charge allows charging a slab object to the current memcg,
>>  * primarily in cases where charging at allocation time might not be possible
>>  * because the target memcg is not known (i.e. softirq context)
>>  *
>>  * The objp should be pointer returned by the slab allocator functions like
>>  * kmalloc (with __GFP_ACCOUNT in flags) or kmem_cache_alloc. The memcg charge
> 
> Aren't allocations done with kmalloc(__GFP_ACCOUNT) already accounted?
> Why would we need to call kmem_cache_charge() for those?

AFAIU current_obj_cgroup() returns NULL because we're in the interrupt
context and no remote memcg context has been set. Thus the charging is
skipped. The patch commit log describes such scenario for network receive.
But in case of kmalloc() the allocation must have been still attempted with
__GFP_ACCOUNT so a kmalloc-cg cache is used even if the charging fails.

If there's another usage for kmem_cache_charge() where the memcg is
available but we don't want to charge immediately on purpose (such as the
Linus' idea for struct file), we might need to find another way to tell
kmalloc() to use the kmalloc-cg cache but not charge immediately...

> I am assuming what you are referring to is kmalloc() allocations that
> are not fulfilled from KMALLOC_NORMAL caches, but I am not sure how to
> capture this here.
> 
>>  * behavior can be controlled through gfpflags parameter, which affects how the
>>  * necessary internal metadata can be allocated. Including __GFP_NOFAIL denotes
>>  * that overcharging is requested instead of failure, but is not applied for the
>>  * internal metadata allocation.
>>  *
>>  * There are several cases where it will return true even if the charging was
>>  * not done:
>>  * More specifically:
>>  *
>>  * 1. For !CONFIG_MEMCG or cgroup_disable=memory systems.
>>  * 2. Already charged slab objects.
>>  * 3. For slab objects from KMALLOC_NORMAL caches - allocated by kmalloc()
>>  *    without __GFP_ACCOUNT
>>  * 4. Allocating internal metadata has failed
>>  *
>>  * Return: true if charge was successful otherwise false.
>>  */
>>
>> >> > +
>> >> > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
>> >>
>> >> Is it possible to point to the commit that has the explanation here?
>> >> The one you pointed me to before? Otherwise it's not really obvious
>> >> where the circular dependency comes from (at least to me).
>> >>
>> >
>> > Not sure about the commit reference. We can add more text here.
>> > Vlastimil, how much detail do you prefer?
>>
>> What about:
>>
>>         /*
>>          * Ignore KMALLOC_NORMAL cache to avoid possible circular dependency
>>          * of slab_obj_exts being allocated from the same slab and thus the slab
>>          * becoming effectively unfreeable.
>>          */
>>
>>
>> > thanks,
>> > Shakeel
>>


