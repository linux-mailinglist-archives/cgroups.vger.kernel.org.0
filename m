Return-Path: <cgroups+bounces-420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB607EB7D3
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 21:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CA9B20BD4
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8635F10;
	Tue, 14 Nov 2023 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bz0Tanb9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1sGsexk"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0032FC2B
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 20:31:08 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A870111;
	Tue, 14 Nov 2023 12:31:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C50F20430;
	Tue, 14 Nov 2023 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699993864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8/NrlXrx7sKxKw33qQLGmJG4ajpbjlsvtZQ38cozIM=;
	b=bz0Tanb9Y3cak62EKwozN4JZtM1EhTLHsjIgv5TckwMI590xRU45d3JovLa+6SFsyKvs2/
	o5ghKFRI2Y8Jt/HtZSGjcqLB0NdyBPycLAuFkWsrld6TjftB3Te5iuFxaH5IMLpjpcbgk5
	VW+PGp8qKkuMzms6pm7UNipMPPKskTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699993864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8/NrlXrx7sKxKw33qQLGmJG4ajpbjlsvtZQ38cozIM=;
	b=U1sGsexkSCenG1J6TMRPFw6R8GIAzJNbVkcOX/AeR665x0R5K/WudYp5YDQciPcjElgvrx
	ek9r1bVuNVNQjcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0337013460;
	Tue, 14 Nov 2023 20:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id O8kbAAjZU2UpYQAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 14 Nov 2023 20:31:04 +0000
Message-ID: <b7fd34fa-5623-5f78-1d95-d01c986c2271@suse.cz>
Date: Tue, 14 Nov 2023 21:31:03 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 18/20] mm/slub: remove slab_alloc() and
 __kmem_cache_alloc_lru() wrappers
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver
 <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-40-vbabka@suse.cz> <202311132048.B3AADC400@keescook>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202311132048.B3AADC400@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.60
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 BAYES_HAM(-0.00)[41.96%];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,arm.com,cmpxchg.org,googlegroups.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

On 11/14/23 05:50, Kees Cook wrote:
> On Mon, Nov 13, 2023 at 08:13:59PM +0100, Vlastimil Babka wrote:
>> slab_alloc() is a thin wrapper around slab_alloc_node() with only one
>> caller.  Replace with direct call of slab_alloc_node().
>> __kmem_cache_alloc_lru() itself is a thin wrapper with two callers,
>> so replace it with direct calls of slab_alloc_node() and
>> trace_kmem_cache_alloc().
> 
> I'd have a sense that with 2 callers a wrapper is still useful?

Well it bothered me how many layers everything went through, it makes it
harder to comprehend the code.

>> 
>> This also makes sure _RET_IP_ has always the expected value and not
>> depending on inlining decisions.

And there's also this argument. We should evaluate _RET_IP_ in
kmem_cache_alloc() and kmem_cache_alloc_lru().

>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> [...]
>>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>>  {
>> -	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
>> +	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_,
>> +				    s->object_size);
>>  
> 
> Whitespace change here isn't mentioned in the commit log.

OK, will mention.

> Regardless:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

