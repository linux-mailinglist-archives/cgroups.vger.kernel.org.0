Return-Path: <cgroups+bounces-415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56247EB789
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5844BB20BD4
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCBE35F00;
	Tue, 14 Nov 2023 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KL32TVBx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L3J2R54N"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B326AD1
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 20:12:30 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050AD9;
	Tue, 14 Nov 2023 12:12:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A85D6228DF;
	Tue, 14 Nov 2023 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699992747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oWHSyp79oNEAgxAW4ytBgCxzKxU2JyVRlj3iU9Pw8Q=;
	b=KL32TVBxQW6+GtVEfqM8IxU1HpDPnjwzKYDi8t7DlqxtkVGoll2S6coi19xOD+SetzF8as
	CfxAmzEA17DWL6Ubjz4iuSkfiWCjwh+Phjz0Z+gam96Bey9MZuDrTCAeSxu3ZE1HZEsmPD
	Yk2+zEFYTUNyxJHsa7cN2HDO4Y63C6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699992747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oWHSyp79oNEAgxAW4ytBgCxzKxU2JyVRlj3iU9Pw8Q=;
	b=L3J2R54NClnDf61QqWa1WxXEGfMp3intqNZu57qpKVE39SYitMa5NuODSNEbw/0PLiBjV6
	6Da9th5iNMO/5SAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 658A613460;
	Tue, 14 Nov 2023 20:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id I44uGKvUU2XOWAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 14 Nov 2023 20:12:27 +0000
Message-ID: <893d2289-e463-dd00-84cc-e77aed93cf53@suse.cz>
Date: Tue, 14 Nov 2023 21:12:27 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 05/20] cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
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
 <20231113191340.17482-27-vbabka@suse.cz> <202311132020.5A4B63D@keescook>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202311132020.5A4B63D@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.62
X-Spamd-Result: default: False [-2.62 / 50.00];
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
	 R_RATELIMIT(0.00)[to_ip_from(RL563rtnmcmc9sawm86hmgtctc)];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 BAYES_HAM(-0.02)[51.67%];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,arm.com,cmpxchg.org,googlegroups.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

On 11/14/23 05:20, Kees Cook wrote:
> On Mon, Nov 13, 2023 at 08:13:46PM +0100, Vlastimil Babka wrote:
>> The CPUHP_SLAB_PREPARE hooks are only used by SLAB which is removed.
>> SLUB defines them as NULL, so we can remove those altogether.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/slab.h | 8 --------
>>  kernel/cpu.c         | 5 -----
>>  2 files changed, 13 deletions(-)
>> 
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index d6d6ffeeb9a2..34e43cddc520 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -788,12 +788,4 @@ size_t kmalloc_size_roundup(size_t size);
>>  
>>  void __init kmem_cache_init_late(void);
>>  
>> -#if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
>> -int slab_prepare_cpu(unsigned int cpu);
>> -int slab_dead_cpu(unsigned int cpu);
>> -#else
>> -#define slab_prepare_cpu	NULL
>> -#define slab_dead_cpu		NULL
>> -#endif
>> -
>>  #endif	/* _LINUX_SLAB_H */
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 9e4c6780adde..530b026d95a1 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -2125,11 +2125,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
>>  		.startup.single		= relay_prepare_cpu,
>>  		.teardown.single	= NULL,
>>  	},
>> -	[CPUHP_SLAB_PREPARE] = {
>> -		.name			= "slab:prepare",
>> -		.startup.single		= slab_prepare_cpu,
>> -		.teardown.single	= slab_dead_cpu,
>> -	},
>>  	[CPUHP_RCUTREE_PREP] = {
>>  		.name			= "RCU/tree:prepare",
>>  		.startup.single		= rcutree_prepare_cpu,
> 
> Should CPUHP_SLAB_PREPARE be removed from the enum too?

Yep, will do, thanks!


