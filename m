Return-Path: <cgroups+bounces-4794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA65B972D49
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 11:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5831C22065
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244F187878;
	Tue, 10 Sep 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lfBDbMgK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSw/04k5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lfBDbMgK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSw/04k5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AF12B143;
	Tue, 10 Sep 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959973; cv=none; b=FVLGOsrtTC/qdm83pf/41VwW4BoLWstVg1MDXEDSL+qE/A+ugrq02K7WhonGt6eK0+9GJnyyoo6QOUbKF4zR+bUdNkvrVibl7BRfGbCYc4cZ+5HbIC9/18udHupN49y9fBb2oPkv0jZRqut5ISspjzrncTljPtYrO1uzPA/WHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959973; c=relaxed/simple;
	bh=EZJ2KjVe8+MIqoxXJa3jnPZTaaasnYdfUc4J7h8X9Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYIjKgYM7RYPaQCgy/DUvqkVzjxMMJpaE05ut2eZgaDwHQQBNNJJ7Z7ZBCh4CqS03Co1SBs64FG8K/m6DAaFrTWRt7+TBCyXA2HDGsph6WbUxeOC6xc0CxLVOqpNF/wJigqoehkI3RltbLIuHcvB+LovKrf62y0hJr5Ca4+cch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lfBDbMgK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSw/04k5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lfBDbMgK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSw/04k5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A3511F7CA;
	Tue, 10 Sep 2024 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725959970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iHifeSDy1hOrQBMy6zAhiahj/omSnqHRNld70oH1lB8=;
	b=lfBDbMgKn59KuCOI0BmhZrdL9u8jnyJbSi73Z7nnY+EtqtYEha6puIOgROlT/1gI7b/jPC
	wGH3HmSlYoslgSYlz/LQ+htJiAvqlZTgBQgeEmMu8jDSRUe9mXrW67iGIhMn5+7XBG5WIh
	KKC5XX8oA4Rt6IpJ02G6DCiaz6OE/CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725959970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iHifeSDy1hOrQBMy6zAhiahj/omSnqHRNld70oH1lB8=;
	b=hSw/04k5A0n+xQJ9JF57ti/nISsxO3zKM1aEff2RfwKn8MnQBzyWdU2SfB0Mhmtikd9e1D
	cIkIbBglasWMt0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725959970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iHifeSDy1hOrQBMy6zAhiahj/omSnqHRNld70oH1lB8=;
	b=lfBDbMgKn59KuCOI0BmhZrdL9u8jnyJbSi73Z7nnY+EtqtYEha6puIOgROlT/1gI7b/jPC
	wGH3HmSlYoslgSYlz/LQ+htJiAvqlZTgBQgeEmMu8jDSRUe9mXrW67iGIhMn5+7XBG5WIh
	KKC5XX8oA4Rt6IpJ02G6DCiaz6OE/CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725959970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iHifeSDy1hOrQBMy6zAhiahj/omSnqHRNld70oH1lB8=;
	b=hSw/04k5A0n+xQJ9JF57ti/nISsxO3zKM1aEff2RfwKn8MnQBzyWdU2SfB0Mhmtikd9e1D
	cIkIbBglasWMt0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E97CE13A3A;
	Tue, 10 Sep 2024 09:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aBWeOCEP4GawSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 10 Sep 2024 09:19:29 +0000
Message-ID: <e8756edc-1c85-4a03-9c6b-663a9e7d46eb@suse.cz>
Date: Tue, 10 Sep 2024 11:19:29 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <5d48fe26-1e18-4941-99d4-8c03e83f5e76@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <5d48fe26-1e18-4941-99d4-8c03e83f5e76@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,google.com,gmail.com,davemloft.net,kvack.org,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/10/24 10:26, Paolo Abeni wrote:
> On 9/5/24 19:34, Shakeel Butt wrote:
>>    * kmem_cache_alloc_node - Allocate an object on the specified node
>>    * @s: The cache to allocate from.
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index 64d07b842e73..3c13ca8c11fb 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -715,6 +715,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
>>   	release_sock(sk);
>>   	if (newsk && mem_cgroup_sockets_enabled) {
>>   		int amt = 0;
>> +		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
>>   
>>   		/* atomically get the memory usage, set and charge the
>>   		 * newsk->sk_memcg.
>> @@ -731,8 +732,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
>>   		}
>>   
>>   		if (amt)
>> -			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
>> -						GFP_KERNEL | __GFP_NOFAIL);
>> +			mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp);
>> +		kmem_cache_charge(newsk, gfp);
>>   
>>   		release_sock(newsk);
>>   	}
> 
> The networking bits looks sane to me - with a very minor nit about the 
> reverse xmas tree order in variables declaration above.
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Great, thanks, I will adjust the ordering.



