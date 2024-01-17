Return-Path: <cgroups+bounces-1166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56752830DE3
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 21:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0FB1C21F7A
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FF24B32;
	Wed, 17 Jan 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VTi+4PnX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750D249F2
	for <cgroups@vger.kernel.org>; Wed, 17 Jan 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522883; cv=none; b=XpAZ1Y7ejT0AqMD6ZFFD4MvDHl71vKdJlHY8jtiXc03ypIRwP0cc8Izgic1PMBduTaAeJQkctDG+eF5jE+MVKxvvdt9NyZf6fRegJZu8XIhq/jwKLjkMfkSVWtW5rRJ/H8C7muECpMs1p8p1WVdbLCiB783KNHEmztzY4o4v368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522883; c=relaxed/simple;
	bh=JivwyaF97QtjAsr/iFAizwqA1z7RQVn8gvQMg18rZqI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type;
	b=uyHp6guBmellVWR2vbnrTGTr0NlDeUb/EyZ2hSgKulmQKZYTQWHRm4pbBhVo95Zz19H5/3o9qzXQr2RbqqI8t6MfBPHovTVmEvwd/JJMChTxF8l+AMrbUleY1v4ttaq74wbxaZT6lMYglHd0TVE7CmcsqC+WeAVOmWNUL7L4lX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VTi+4PnX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-559b3ee02adso2628538a12.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jan 2024 12:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705522879; x=1706127679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VANeRlQcKNuS02RIKSNSaBerKvZvwIN+PjhVd8nh4E4=;
        b=VTi+4PnXwqbiOfJjg9uWDX7QayEQl5FqXbKU/7gTKBSdDcgD4pQa3tRr6NrXuMS3/H
         yhytECYYnfYl4snMP/ZYsrypWYhiFNVruXvofuAQiJUAQnw0tQyF0qY+hS0w8GoQ9ChJ
         /r8WXFTanaS/V1nTGRurM5W06ETPhQQOrHx9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522879; x=1706127679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VANeRlQcKNuS02RIKSNSaBerKvZvwIN+PjhVd8nh4E4=;
        b=TARPQ+axO1U0V9PfPZ14R5d6VWk6gwnpdNcry+XfmzWEsKGvW+1+K8ULcFhKesMQal
         mVcqHGymkkagno55DqCB68s4EafhKGMPQisx/TJW6wWOhdMpiXKXauKDd5yNe/icH/Wt
         3qiEZhZQRpJ2HObW77UAlqOmT6sqx3kXqY5Hl8+TsflhzBptygSLLY7b5pwPLFHkPgMZ
         lYQy9Y49piG0lGEFMEywpjJe3vXFYxqmPfTMxjOZ/nEC1h3c44MInplFckN4DznvXPQI
         IcD+likN/VP1dfsEcKC4GgjdRstY1HbQIB8DFawqqlrg+Yzv4gKU4Jla4IeUkla87MhS
         6r+A==
X-Gm-Message-State: AOJu0Yz9aFzrNS3VgOLNVJqizYg2m28n+0HGhnFzfIRSGdchjS/Xjram
	mAP1a0FV8PVQzFwgTEXOrKwLQ3ri/nPAi23oneqFBk3w1/KLRfBT
X-Google-Smtp-Source: AGHT+IHiH0coYHDixJx7NpFlFnc8cofn+i6MhppSakEYAdAb8Tb3dng6Nkbz6NA/JOtwBLqmbokxWw==
X-Received: by 2002:a17:906:b343:b0:a28:c0c2:2d56 with SMTP id cd3-20020a170906b34300b00a28c0c22d56mr2931346ejb.226.1705522879644;
        Wed, 17 Jan 2024 12:21:19 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090699c600b00a2ed222d61esm1147299ejn.199.2024.01.17.12.21.18
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:21:18 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e86a76c11so19179495e9.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jan 2024 12:21:18 -0800 (PST)
X-Received: by 2002:a05:600c:1552:b0:40d:5502:5834 with SMTP id
 f18-20020a05600c155200b0040d55025834mr3233229wmg.14.1705522877914; Wed, 17
 Jan 2024 12:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org> <20240117193915.urwueineol7p4hg7@treble>
In-Reply-To: <20240117193915.urwueineol7p4hg7@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 12:20:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
Message-ID: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Josh Poimboeuf <jpoimboe@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Shakeel Butt <shakeelb@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> That's a good point.  If the microbenchmark isn't likely to be even
> remotely realistic, maybe we should just revert the revert until if/when
> somebody shows a real world impact.
>
> Linus, any objections to that?

We use SLAB_ACCOUNT for much more common allocations like queued
signals, so I would tend to agree with Jeff that it's probably just
some not very interesting microbenchmark that shows any file locking
effects from SLAB_ALLOC, not any real use.

That said, those benchmarks do matter. It's very easy to say "not
relevant in the big picture" and then the end result is that
everything is a bit of a pig.

And the regression was absolutely *ENORMOUS*. We're not talking "a few
percent". We're talking a 33% regression that caused the revert:

   https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex-9020/

I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
single allocation, it would be much nicer to account at a bigger
granularity, possibly by having per-thread counters first before
falling back to the obj_cgroup_charge. Whatever.

It's kind of stupid to have a benchmark that just allocates and
deallocates a file lock in quick succession spend lots of time
incrementing and decrementing cgroup charges for that repeated
alloc/free.

However, that problem with SLAB_ACCOUNT is not the fault of file
locking, but more of a slab issue.

End result: I think we should bring in Vlastimil and whoever else is
doing SLAB_ACCOUNT things, and have them look at that side.

And then just enable SLAB_ACCOUNT for file locks. But very much look
at silly costs in SLAB_ACCOUNT first, at least for trivial
"alloc/free" patterns..

Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
file lock caches") for the history here.

                 Linus

