Return-Path: <cgroups+bounces-417-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034717EB7AE
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 21:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5212812E6
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 20:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116F735F0B;
	Tue, 14 Nov 2023 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oehcGKUo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+/IUBYFc"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D935F07
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 20:20:15 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A469DD;
	Tue, 14 Nov 2023 12:20:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D871204CF;
	Tue, 14 Nov 2023 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699993212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRZqg1eyXGXcPqi9GpGEFNWWf1q5PJQkVGVoL8YbRuE=;
	b=oehcGKUovNG4JKvnraYQaSd66dKmRdfimaqV5UccwyyNITDK9Dp5fH+M+fttE6Hijl5cqo
	yX0AChKJPd9swjHxX8+hdTdqi+bm0Sm7GK6lLW0fi9l/gqJFEKXBPpAltPdMjlT9shtZaK
	3RhW1+ZC6tdkuBMF078fgHQtUz1tLDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699993212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRZqg1eyXGXcPqi9GpGEFNWWf1q5PJQkVGVoL8YbRuE=;
	b=+/IUBYFc/RYdTVuQKXCnl+G0Ou5Zj5FoGWOs6qNqXBQ8kWvMNT47QY51/SGutzFVbH+x+p
	pg5sorSCw3T6vACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32DBA13460;
	Tue, 14 Nov 2023 20:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id j8/QC3zWU2WFXAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 14 Nov 2023 20:20:12 +0000
Message-ID: <6d8b51c5-4610-66b0-d4a0-e1032597bcb6@suse.cz>
Date: Tue, 14 Nov 2023 21:20:11 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/20] mm/slab: remove mm/slab.c and slab_def.h
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org, Mark Hemment <markhe@nextd.demon.co.uk>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-30-vbabka@suse.cz>
 <CANpmjNNkojcku+2-Lh=LX=_TXq3+x0M0twYQG2dBWA0Aeqr=Xw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNNkojcku+2-Lh=LX=_TXq3+x0M0twYQG2dBWA0Aeqr=Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.63
X-Spamd-Result: default: False [-6.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL563rtnmcmc9sawm86hmgtctc)];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 BAYES_HAM(-0.03)[57.16%];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,arm.com,cmpxchg.org,chromium.org,googlegroups.com,nextd.demon.co.uk];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

On 11/14/23 09:06, Marco Elver wrote:
> On Mon, 13 Nov 2023 at 20:14, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Remove the SLAB implementation. Update CREDITS (also sort the SLOB entry
>> properly).
>>
>> RIP SLAB allocator (1996 - 2024)
>>
>> Cc: Mark Hemment <markhe@nextd.demon.co.uk>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  CREDITS                  |   12 +-
>>  include/linux/slab_def.h |  124 --
>>  mm/slab.c                | 4026 --------------------------------------
> 
> There are still some references to it left (git grep mm/slab.c). It
> breaks documentation in Documentation/core-api/mm-api.rst

Thanks, will check.

