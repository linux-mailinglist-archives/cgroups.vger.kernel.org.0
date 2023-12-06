Return-Path: <cgroups+bounces-860-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1B806AD3
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 10:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E3A1F21505
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A261A717;
	Wed,  6 Dec 2023 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMsDkGCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jc5yeaY2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E8BA;
	Wed,  6 Dec 2023 01:37:08 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0548921A3B;
	Wed,  6 Dec 2023 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701855426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RhjCKHQblZR+lvAtLCjbDfVvYyouCwUYRk6G4t7QCw=;
	b=YMsDkGCglFuNtIk6OYP5Nkgu1unaIh0mmQwUe9gAm7q9dbPWDaLphkFivI3balS/8oWwy0
	0ixjx2/jtpqQUWEGJCBloCqp6Jj2epxuby50+D6Rj2wISFdwidDK6wjTUo4MfDppOKIayh
	gQV1UDyxh0U+cp7RYM6V5dsR/Pui+h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701855426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RhjCKHQblZR+lvAtLCjbDfVvYyouCwUYRk6G4t7QCw=;
	b=jc5yeaY2Sy9PUvC/9LM2FGBscljcQxAmngzs8qK/s5JX3Lk9DF/7HxEydGv0YAptOELLhw
	tQZ0qNFCtG/G/FDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA3E313408;
	Wed,  6 Dec 2023 09:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OgMBMcFAcGXVRgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 06 Dec 2023 09:37:05 +0000
Message-ID: <15e22e38-6eee-3a55-df27-51b7bc0c5976@suse.cz>
Date: Wed, 6 Dec 2023 10:37:05 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 09/21] mm/slab: remove mm/slab.c and slab_def.h
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver
 <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-9-9c9c70177183@suse.cz>
 <ZXA+Ur55OR1EU/5L@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZXA+Ur55OR1EU/5L@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,suse.cz:email,selenic.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com,cmpxchg.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.20
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 

On 12/6/23 10:31, Hyeonggon Yoo wrote:
> On Mon, Nov 20, 2023 at 07:34:20PM +0100, Vlastimil Babka wrote:
>> Remove the SLAB implementation. Update CREDITS.
>> Also update and properly sort the SLOB entry there.
>> 
>> RIP SLAB allocator (1996 - 2024)
>> 
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  CREDITS                  |   12 +-
>>  include/linux/slab_def.h |  124 --
>>  mm/slab.c                | 4005 ----------------------------------------------
>>  3 files changed, 8 insertions(+), 4133 deletions(-)
> 
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
>> diff --git a/CREDITS b/CREDITS
>> index f33a33fd2371..943a73e96149 100644
>> --- a/CREDITS
>> +++ b/CREDITS
>> @@ -9,10 +9,6 @@
>>  			Linus
>>  ----------
>>  
>> -N: Matt Mackal
>> -E: mpm@selenic.com
>> -D: SLOB slab allocator
> 
> by the way I just realized that commit 16e943bf8db
> ("MAINTAINERS: SLAB maintainer update") incorrectly put her lastname
> (Mackall is correct), maybe update that too?

Right, thanks a lot for noticing, will fix.


