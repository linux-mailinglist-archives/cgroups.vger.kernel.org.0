Return-Path: <cgroups+bounces-8487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5978AD5D96
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 19:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDFA16B2ED
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7223958C;
	Wed, 11 Jun 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGQAiysI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VcN2Kp0R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGQAiysI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VcN2Kp0R"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2501229B38
	for <cgroups@vger.kernel.org>; Wed, 11 Jun 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664669; cv=none; b=tglF2TWWKCYhQxgWYZSQNSC+5F0s0zpANgjgsGyHlf/O3PZcrpmYWOwy1QdE3EoVo71GYZLSaKW2QqoUHlKP7vA5K9IMWmFkGmfrjoZXQ34Hr1HkXboFwufJmjZDirH2PwI2N/88wyftpzhfh/OZQy3T9ivY8YuXoeWGcfPO6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664669; c=relaxed/simple;
	bh=SEijMsxsIR2Saxm6OlXmeotZaQb1SQYvRUkHr8kOD64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=smDWGu/0O3r6L1iZE8af0bBy53dop6S1a2KW9Sgsk00m04t9ZSIsDi4DdI8dJJrtaLnSD9N205g4LO8rOHmxCzXEC9IgjpwdmHA/bzaFkc1thDkqzCP7gBt+OOYhXpV3UxaJd1L2efjMTTN91mI+qy1fWGyDHt2hBeH9BmBSX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGQAiysI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VcN2Kp0R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGQAiysI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VcN2Kp0R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4C2221921;
	Wed, 11 Jun 2025 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749664665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VhoXWW6F68B+fBMvoXJeILEJUgHeYVE8gaY+ZRAg9Ow=;
	b=qGQAiysIR0GuooorxKARHF0/hcxq7HVD7uFvSuieZ7HmA1CHothZoN9UFCWxKcqhWw1Oxl
	5m7b8rihF5c1Rb4gmXwzJ6eUD4rszXLShaFKwB/EnttlgYK6a6ZOxT3/3XTfEgTB0NRcLg
	ZAQ4NXt3R5QJvZeTy2tgiU/DcSbXbZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749664665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VhoXWW6F68B+fBMvoXJeILEJUgHeYVE8gaY+ZRAg9Ow=;
	b=VcN2Kp0RE+wYMuEwGlzTMbmzNze/CGmWtvovbbBG5RlfNvyuceoYZLTcE18lGTEvJ1NI2d
	dDRpx6MdA9ss4fDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749664665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VhoXWW6F68B+fBMvoXJeILEJUgHeYVE8gaY+ZRAg9Ow=;
	b=qGQAiysIR0GuooorxKARHF0/hcxq7HVD7uFvSuieZ7HmA1CHothZoN9UFCWxKcqhWw1Oxl
	5m7b8rihF5c1Rb4gmXwzJ6eUD4rszXLShaFKwB/EnttlgYK6a6ZOxT3/3XTfEgTB0NRcLg
	ZAQ4NXt3R5QJvZeTy2tgiU/DcSbXbZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749664665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VhoXWW6F68B+fBMvoXJeILEJUgHeYVE8gaY+ZRAg9Ow=;
	b=VcN2Kp0RE+wYMuEwGlzTMbmzNze/CGmWtvovbbBG5RlfNvyuceoYZLTcE18lGTEvJ1NI2d
	dDRpx6MdA9ss4fDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D2C4139CE;
	Wed, 11 Jun 2025 17:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jQTAJZnDSWhhIgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 11 Jun 2025 17:57:45 +0000
Message-ID: <68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz>
Date: Wed, 11 Jun 2025 19:57:45 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking/local_lock, mm: sparse warnings about shadowed variable
Content-Language: en-US
To: Charlemagne Lasse <charlemagnelasse@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <ast@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, LKML <linux-kernel@vger.kernel.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
References: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linutronix.de,goodmis.org,infradead.org,stgolabs.net,vger.kernel.org,kvack.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Level: 

On 6/11/25 19:37, Charlemagne Lasse wrote:
> HI,
> 
> when I run `make C=2 mm/mlock.o CHECK="sparse -Wshadow"`, I get a lot of
> 
> ./include/linux/local_lock.h:88:1: warning: symbol 'l' shadows an earlier one
> ./include/linux/local_lock.h:88:1: originally declared here
> 
> after commit
> 
> 51339d99c0131bc0d16d378e9b05bc498d2967e2 is the first bad commit
> commit 51339d99c0131bc0d16d378e9b05bc498d2967e2
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   2025-04-02 19:55:14 -0700
> 
>    locking/local_lock, mm: replace localtry_ helpers with local_trylock_t type

Looks like __DEFINE_LOCK_GUARD_1() has "_type *l" and __local_lock_acquire()
has "local_lock_t *l;". It can be fixed e.g. like this, although it's
harmless? The _release() part is not necessary, just for symmetry.

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8d5ac16a9b17..075338f270d0 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -97,17 +97,17 @@ do {                                                                \
 #define __local_lock_acquire(lock)                                     \
        do {                                                            \
                local_trylock_t *tl;                                    \
-               local_lock_t *l;                                        \
+               local_lock_t *ll;                                       \
                                                                        \
-               l = (local_lock_t *)this_cpu_ptr(lock);                 \
-               tl = (local_trylock_t *)l;                              \
+               ll = (local_lock_t *)this_cpu_ptr(lock);                \
+               tl = (local_trylock_t *)ll;                             \
                _Generic((lock),                                        \
                        __percpu local_trylock_t *: ({                  \
                                lockdep_assert(tl->acquired == 0);      \
                                WRITE_ONCE(tl->acquired, 1);            \
                        }),                                             \
                        __percpu local_lock_t *: (void)0);              \
-               local_lock_acquire(l);                                  \
+               local_lock_acquire(ll);                                 \
        } while (0)
 
 #define __local_lock(lock)                                     \
@@ -165,11 +165,11 @@ do {                                                              \
 #define __local_lock_release(lock)                                     \
        do {                                                            \
                local_trylock_t *tl;                                    \
-               local_lock_t *l;                                        \
+               local_lock_t *ll;                                       \
                                                                        \
-               l = (local_lock_t *)this_cpu_ptr(lock);                 \
-               tl = (local_trylock_t *)l;                              \
-               local_lock_release(l);                                  \
+               ll = (local_lock_t *)this_cpu_ptr(lock);                \
+               tl = (local_trylock_t *)ll;                             \
+               local_lock_release(ll);                                 \
                _Generic((lock),                                        \
                        __percpu local_trylock_t *: ({                  \
                                lockdep_assert(tl->acquired == 1);      \


