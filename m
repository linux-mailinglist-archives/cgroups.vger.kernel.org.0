Return-Path: <cgroups+bounces-565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ECA7F9CAF
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6A1F20CA6
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510D16429;
	Mon, 27 Nov 2023 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZnzujSEb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643E110F;
	Mon, 27 Nov 2023 01:33:51 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0652B21B08;
	Mon, 27 Nov 2023 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701077630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wT+MufMGEB0ufjSt00Zd8HTGo5TcuBRHX37P346pxcM=;
	b=ZnzujSEbax23GqstRnJMfugfRQIVcnioLid6dLybj07wx9hjP/41wInCr4eFCaA0ysgQ2u
	2+m4YnrwfxksKjvo8a/WrfxC+BfgIIHHf8qZ00cON1a9Wr9jnRxDYseMou3Vy+3CjQhEoS
	J7kFa8LNWBSIXVkHPqSh0ulE+SrFXak=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7ED51379A;
	Mon, 27 Nov 2023 09:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7kaON31iZGX6QgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 27 Nov 2023 09:33:49 +0000
Date: Mon, 27 Nov 2023 10:33:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	kernel@sberdevices.ru, rockosov@gmail.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <ZWRifQgRR0570oDY@tiehlicka>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123193937.11628-3-ddrokosov@salutedevices.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 4.32
X-Spamd-Result: default: False [4.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.18)[-0.925];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[goodmis.org,kernel.org,cmpxchg.org,linux.dev,google.com,linux-foundation.org,sberdevices.ru,gmail.com,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[]

On Thu 23-11-23 22:39:37, Dmitry Rokosov wrote:
> The shrink_memcg flow plays a crucial role in memcg reclamation.
> Currently, it is not possible to trace this point from non-direct
> reclaim paths. However, direct reclaim has its own tracepoint, so there
> is no issue there. In certain cases, when debugging memcg pressure,
> developers may need to identify all potential requests for memcg
> reclamation including kswapd(). The patchset introduces the tracepoints
> mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> 
> Example of output in the kswapd context (non-direct reclaim):
>     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
>     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
>     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
>     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
>     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
>     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16

In the previous version I have asked why do we need this specific
tracepoint when we already do have trace_mm_vmscan_lru_shrink_{in}active
which already give you a very good insight. That includes the number of
reclaimed pages but also more. I do see that we do not include memcg id
of the reclaimed LRU, but that shouldn't be a big problem to add, no?

-- 
Michal Hocko
SUSE Labs

