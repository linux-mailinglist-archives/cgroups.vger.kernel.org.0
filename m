Return-Path: <cgroups+bounces-547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8EC7F7001
	for <lists+cgroups@lfdr.de>; Fri, 24 Nov 2023 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAD7B20A30
	for <lists+cgroups@lfdr.de>; Fri, 24 Nov 2023 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6F916420;
	Fri, 24 Nov 2023 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wi7zjCRT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0W5OjFqN"
X-Original-To: cgroups@vger.kernel.org
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 01:35:07 PST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB26FD54;
	Fri, 24 Nov 2023 01:35:07 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05E2E21CC1;
	Fri, 24 Nov 2023 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700817996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LgMMddRm1Z0VKUmKvdY8oWuzJ6UIJ2B5WVeljH1gzY=;
	b=wi7zjCRTJoJFYmrOSrFq1Fu/59T4P6MokqaDJsIPGxE68UXGgkFGQUmtbemkvLqIBDUosD
	6dbZDPN8N2wtenWqevFy2J+IbBFPl8h6rN6B6dHYWvVhjUR97kDZI9KJ+AaQyUQUgNRW28
	PQNluc8R7uZOseUGFVzaemA8aiyqifg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700817996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LgMMddRm1Z0VKUmKvdY8oWuzJ6UIJ2B5WVeljH1gzY=;
	b=0W5OjFqNGkfGKKXJaWmpdCXySuZEq4uZZiDFlis8GjNTJepSeVMo/29CF/7SB4OGNMiPS+
	xd3ALVU+Ukwt5XCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB51D13A98;
	Fri, 24 Nov 2023 09:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 739GMUtsYGVxZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 Nov 2023 09:26:35 +0000
Message-ID: <2d0626b2-793c-315f-dc93-af021bd5cb85@suse.cz>
Date: Fri, 24 Nov 2023 10:26:35 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 00/21] remove the SLAB allocator
Content-Language: en-US
To: David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
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
 linux-hardening@vger.kernel.org, Michal Hocko <mhocko@suse.com>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <b4d53ec4-482d-23ec-b73f-dfbc58ccc149@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b4d53ec4-482d-23ec-b73f-dfbc58ccc149@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.20
X-Spam-Level: 
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
	 BAYES_SPAM(0.00)[35.47%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On 11/24/23 01:45, David Rientjes wrote:
> On Mon, 20 Nov 2023, Vlastimil Babka wrote:
> 
>> Changes from v1:
>> - Added new Patch 01 to fix up kernel docs build (thanks Marco Elver)
>> - Additional changes to Kconfig user visible texts in Patch 02 (thanks Kees
>>   Cook)
>> - Whitespace fixes and other fixups (thanks Kees)
>> 
>> The SLAB allocator has been deprecated since 6.5 and nobody has objected
>> so far. As we agreed at LSF/MM, we should wait with the removal until
>> the next LTS kernel is released. This is now determined to be 6.6, and
>> we just missed 6.7, so now we can aim for 6.8 and start exposing the
>> removal to linux-next during the 6.7 cycle. If nothing substantial pops
>> up, will start including this in slab-next later this week.
>> 
> 
> I agree with the decision to remove the SLAB allocator, same as at LSF/MM.  
> Thanks for doing this, Vlastimil!
> 
> And thanks for deferring this until the next LTS kernel, it will give any 
> last minute hold outs a full year to raise any issues in their switch to 
> SLUB if they only only upgrade to LTS kernels at which point we'll have 
> done our due diligence to make people aware of SLAB's deprecation in 6.6.
> 
> I've completed testing on v1 of the series, so feel free to add
> 
> Acked-by: David Rientjes <rientjes@google.com>
> Tested-by: David Rientjes <rientjes@google.com>

Thanks! And others too.

I've now pushed this series to slab/for-6.8/slab-removal and slab/for-next



