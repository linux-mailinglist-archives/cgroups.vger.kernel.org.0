Return-Path: <cgroups+bounces-418-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416857EB7B6
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 21:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B362812DA
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67B35F0D;
	Tue, 14 Nov 2023 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FB0fB5ml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+qGu9MiL"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7C26AF3
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 20:21:49 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA63F5;
	Tue, 14 Nov 2023 12:21:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C9A7204B3;
	Tue, 14 Nov 2023 20:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699993307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkDw8JxpkfmgcwQMuM79MHBZrTfS3XQLnbqEXbxd1e0=;
	b=FB0fB5mlxkfLSwXVXvvnzeNCVrsZLPJLL37UFmN6SJtXpt5w9Op30EdlzIJMLGDQWxm6Ml
	MnlDeeMyvavUEl3GgX7Rcn7W4td4YYJe7qaeDm98p7REIuJkdlIYN6uG+nzrh7HOlBub9V
	rcwwmdAVm7LwyaoyHrq8P2SphU61JwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699993307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkDw8JxpkfmgcwQMuM79MHBZrTfS3XQLnbqEXbxd1e0=;
	b=+qGu9MiLq74eMSMqhHOuh3bpHzO9nTbpEQ2/Uja0s0JbUNJQl9/kv248UHxCwtm/mR5XS6
	iT7+rPIhxFvCPpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C771113460;
	Tue, 14 Nov 2023 20:21:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cPTxL9rWU2UcXQAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 14 Nov 2023 20:21:46 +0000
Message-ID: <40819423-6ed3-73c4-43a8-7b43095b1443@suse.cz>
Date: Tue, 14 Nov 2023 21:21:46 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/20] mm/slab: move the rest of slub_def.h to mm/slab.h
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
 <20231113191340.17482-32-vbabka@suse.cz> <202311132037.F4FA0B2@keescook>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202311132037.F4FA0B2@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.19
X-Spamd-Result: default: False [-3.19 / 50.00];
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
	 BAYES_HAM(-0.59)[81.59%];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,arm.com,cmpxchg.org,googlegroups.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

On 11/14/23 05:38, Kees Cook wrote:
> On Mon, Nov 13, 2023 at 08:13:51PM +0100, Vlastimil Babka wrote:
>> mm/slab.h is the only place to include include/linux/slub_def.h which
>> has allowed switching between SLAB and SLUB. Now we can simply move the
>> contents over and remove slub_def.h.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Now is the chance to do any whitespace updates! I saw a few #defines
> that looked like they could be re-tab-aligned, but it's not a big deal. :P

Right, I did some updates to accomodate line length especially where
checkpatch complained, will check for the other ones too.

> Reviewed-by: Kees Cook <keescook@chromium.org>
> 


