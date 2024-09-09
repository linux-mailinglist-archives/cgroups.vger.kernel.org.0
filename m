Return-Path: <cgroups+bounces-4751-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21BB971117
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 10:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6766E28056F
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488661B143C;
	Mon,  9 Sep 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iduwALTG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Mc8dePn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iduwALTG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Mc8dePn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB76171E5A;
	Mon,  9 Sep 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868762; cv=none; b=FbVhvT/OJMsJ2dCf5RrOkyvUzijZA00Ob2yMhO+RbSIFE46f3JXFwkHvqrEfgOiugltV5TIFQc0yPMIjqx+PSLamtEA5MKHb8XJgDTQckdWvs5RGso52q9Uy2EhKUxc3FAuHzW8GI97iBcW6jO0byOHnNhFVNZZguW8VPTuExRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868762; c=relaxed/simple;
	bh=2ON4+jsubtMNGaVISbhqTXNI/uDuvc7Jim8Xe1jMqqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNDzjtF1ieM+LV6AYZliklv6W+JeAvrcKe1TTwBq8TPc86skqR9BeFCeGFKUXHfuppLYum+uvM94qa4HKRXoKERN+8ueIv/nomDKhoRBBC80GdU083+gOJGIlZAWkm0ilNIb5V0FVR/o6QPuAN7VNqYy34ICW/TrD7lhB/bkK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iduwALTG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Mc8dePn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iduwALTG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Mc8dePn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77A271F79C;
	Mon,  9 Sep 2024 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725868758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cfj1nLjvrQb5cWeEo4SbrFcdjZ8L9z7qDs6osYAgawU=;
	b=iduwALTGkw0Wle4ZA+Vp2VeBHgdcMsIQpH1dp+JJku0+5K29aC94lOcxc7hyPHWhnIRjpE
	H4V1ZOSuUYMzT88cOjpzbC7r+SgbVHb9RiXtZoBuvUnXlNg/txFsM9fkSLZECOoCn0Laq7
	cyEzd2jMhcy4FkenPL/4lvaBiql09yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725868758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cfj1nLjvrQb5cWeEo4SbrFcdjZ8L9z7qDs6osYAgawU=;
	b=2Mc8dePnGTX9cR+AeAHfVsPiKzZKntFAD4pzh2jYjT804muHBH/AiB9Oi5YoNTANvBAbqo
	DXtwcvyFaC7P3fDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725868758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cfj1nLjvrQb5cWeEo4SbrFcdjZ8L9z7qDs6osYAgawU=;
	b=iduwALTGkw0Wle4ZA+Vp2VeBHgdcMsIQpH1dp+JJku0+5K29aC94lOcxc7hyPHWhnIRjpE
	H4V1ZOSuUYMzT88cOjpzbC7r+SgbVHb9RiXtZoBuvUnXlNg/txFsM9fkSLZECOoCn0Laq7
	cyEzd2jMhcy4FkenPL/4lvaBiql09yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725868758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cfj1nLjvrQb5cWeEo4SbrFcdjZ8L9z7qDs6osYAgawU=;
	b=2Mc8dePnGTX9cR+AeAHfVsPiKzZKntFAD4pzh2jYjT804muHBH/AiB9Oi5YoNTANvBAbqo
	DXtwcvyFaC7P3fDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43A2D13312;
	Mon,  9 Sep 2024 07:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WI/4D9aq3mZAZgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Sep 2024 07:59:18 +0000
Message-ID: <bda30291-ab04-4b72-89c1-b4cb4373cfce@suse.cz>
Date: Mon, 9 Sep 2024 09:59:17 +0200
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
 <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz>
 <CAJD7tkZNGETjvuA97=PGy-MfmF--n6GdSfOCHboScP+wN1gTag@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJD7tkZNGETjvuA97=PGy-MfmF--n6GdSfOCHboScP+wN1gTag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,google.com,gmail.com,davemloft.net,redhat.com,kvack.org,vger.kernel.org,meta.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 9/6/24 19:38, Yosry Ahmed wrote:
>> But in case of kmalloc() the allocation must have been still attempted with
>> __GFP_ACCOUNT so a kmalloc-cg cache is used even if the charging fails.
> 
> It is still possible that the initial allocation did not have
> __GFP_ACCOUNT, but not from a KMALLOC_NORMAL cache (e.g. KMALLOC_DMA
> or KMALLOC_RECLAIM). In this case kmem_cache_charge() should still
> work, right?

Yeah it would work, but that's rather a corner case implementation detail so
it's better to just require __GFP_ACCOUNT for kmalloc() in the comment.

>>
>> If there's another usage for kmem_cache_charge() where the memcg is
>> available but we don't want to charge immediately on purpose (such as the
>> Linus' idea for struct file), we might need to find another way to tell
>> kmalloc() to use the kmalloc-cg cache but not charge immediately...
> 
> Can we just use a dedicated kmem_cache for this instead?

Right, as Shakeel mentioned, that would be the case of struct file. If all
such cases in the future are fine with dedicated cache (i.e. not variable
sized allocations), it should be fine.

