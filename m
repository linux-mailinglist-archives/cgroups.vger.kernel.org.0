Return-Path: <cgroups+bounces-1168-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76E830E7B
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 22:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87082B21444
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 21:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280BF25569;
	Wed, 17 Jan 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OJYY9NBv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kObKjIwg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OJYY9NBv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kObKjIwg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1C25560;
	Wed, 17 Jan 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526392; cv=none; b=JpN7deHHzkNsGvHGcV4Mo/ahs7bWfQOkGLQ607w3SB4d0oAB/CTyk1FhKr9bMhSW8lf7yL/MstksarGfR5/n6plbdSp3gO/HQNfkTN4J/94tqioEAW8AXth07Vvx5CPNAb/5cGRIyWhqn6yUoPwZNKa0jrLtgTSbqWaB5Hf8Vbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526392; c=relaxed/simple;
	bh=GJAIZItic+J9cysod3HZGR/+95ATJtUKrFgTrnaqnPU=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Score:
	 X-Spam-Flag; b=OEYS3XUM1JN0Ri6tNhsEJs1s1hmYq0vDIJgfKU48HIh4anFvSvbCoMQx9Rk4dQwOV8y26mhWMY2UNzVYQ0jQ1iRyeqwC70be6tqIN4v1qSFkbvnZUZvdTk4lxN+SVTSp3b2bkRBDpgCL0uZtQ+X0BT7QnQUyBhXa3NRa48GLuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OJYY9NBv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kObKjIwg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OJYY9NBv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kObKjIwg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 120AC1F394;
	Wed, 17 Jan 2024 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705526389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOtedWW5sk9kt63tDi6gSElkilzVJDdT0NMSpAQS/1Q=;
	b=OJYY9NBv1bUyR2dMiRPiaaMkvRffU/O4BZAzbdJEuyBPdGkWnHAtmP7v1ltBoSTraaHh1/
	ImNvZ9QehZB6rlY9f8gpMC8EWTUFJoBy4ZLmy0LW8bUCuMJTOmRw63V0QoteEgDe+cZro0
	8rW4jXXJQ8RT1pUhqtUTv2ysXAE0t6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705526389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOtedWW5sk9kt63tDi6gSElkilzVJDdT0NMSpAQS/1Q=;
	b=kObKjIwgI1BB9Njw7QUL8zq5ZRqPzRq/ZpD7khMQkesgkCGuVDgfTUgf43xmTTmxM5ujYx
	6CPJMV7mUuR7TJAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705526389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOtedWW5sk9kt63tDi6gSElkilzVJDdT0NMSpAQS/1Q=;
	b=OJYY9NBv1bUyR2dMiRPiaaMkvRffU/O4BZAzbdJEuyBPdGkWnHAtmP7v1ltBoSTraaHh1/
	ImNvZ9QehZB6rlY9f8gpMC8EWTUFJoBy4ZLmy0LW8bUCuMJTOmRw63V0QoteEgDe+cZro0
	8rW4jXXJQ8RT1pUhqtUTv2ysXAE0t6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705526389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOtedWW5sk9kt63tDi6gSElkilzVJDdT0NMSpAQS/1Q=;
	b=kObKjIwgI1BB9Njw7QUL8zq5ZRqPzRq/ZpD7khMQkesgkCGuVDgfTUgf43xmTTmxM5ujYx
	6CPJMV7mUuR7TJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D439F13808;
	Wed, 17 Jan 2024 21:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H41qM3REqGVvAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Jan 2024 21:19:48 +0000
Message-ID: <f1e43327-30ce-4a73-8a24-c813a516f97f@suse.cz>
Date: Wed, 17 Jan 2024 22:19:48 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Shakeel Butt <shakeelb@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
 Vasily Averin <vasily.averin@linux.dev>, Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble>
 <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OJYY9NBv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kObKjIwg
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 120AC1F394
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

On 1/17/24 21:20, Linus Torvalds wrote:
> On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>
>> That's a good point.  If the microbenchmark isn't likely to be even
>> remotely realistic, maybe we should just revert the revert until if/when
>> somebody shows a real world impact.
>>
>> Linus, any objections to that?
> 
> We use SLAB_ACCOUNT for much more common allocations like queued
> signals, so I would tend to agree with Jeff that it's probably just
> some not very interesting microbenchmark that shows any file locking
> effects from SLAB_ALLOC, not any real use.
> 
> That said, those benchmarks do matter. It's very easy to say "not
> relevant in the big picture" and then the end result is that
> everything is a bit of a pig.
> 
> And the regression was absolutely *ENORMOUS*. We're not talking "a few
> percent". We're talking a 33% regression that caused the revert:
> 
>    https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex-9020/
> 
> I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
> single allocation, it would be much nicer to account at a bigger
> granularity, possibly by having per-thread counters first before
> falling back to the obj_cgroup_charge. Whatever.

Counters are one thing (afaik some batching happens on the memcg side via
"stocks"), but another is associating the memcg with the allocated objects
in slab pages, so kmem_cache_free() knows which counter to decrement. We'll
have to see where the overhead is today.

If there's overhead due to calls between mm/slub.c and mm/memcontrol.c we
can now reduce that with SLAB gone.

> It's kind of stupid to have a benchmark that just allocates and
> deallocates a file lock in quick succession spend lots of time
> incrementing and decrementing cgroup charges for that repeated
> alloc/free.
> 
> However, that problem with SLAB_ACCOUNT is not the fault of file
> locking, but more of a slab issue.
> 
> End result: I think we should bring in Vlastimil and whoever else is
> doing SLAB_ACCOUNT things, and have them look at that side.

Roman and Shakeel are already Cc'd. Roman recently did
https://lore.kernel.org/lkml/20231019225346.1822282-1-roman.gushchin@linux.dev/
which is mentioned in the cover letter and was merged in 6.7, but cover says
it didn't help much, too bad. So is it still 33% or how much?

> And then just enable SLAB_ACCOUNT for file locks. But very much look
> at silly costs in SLAB_ACCOUNT first, at least for trivial
> "alloc/free" patterns..
> 
> Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
> thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
> file lock caches") for the history here.
> 
>                  Linus


