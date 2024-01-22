Return-Path: <cgroups+bounces-1181-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6FA835A34
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 06:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87009B2289E
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 05:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F84C6D;
	Mon, 22 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FJOe4o0K"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D464C65
	for <cgroups@vger.kernel.org>; Mon, 22 Jan 2024 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705900230; cv=none; b=W2xvB0pXITiwBqjB7eQmSs4fk9KrTGISaG+7vyAb77xk149OtTWNz8Wpr9Fxk+or1ygzscdRtHDad2bx3107otFspUQbMtqujcEIA54urKjn3sCN79aNN/MCWSijzSXO/Vv2sK/6y2hnterM/GPor2cew8OOXxAqd8c5Q/0MXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705900230; c=relaxed/simple;
	bh=IVCfn+pI29tjNzjS3wp0wFp5/+Z2nUKsVuz8Y3dLxVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa2he1EqvqmJAzdfos4VNNQhnqG+8ACES68AZ8Cky7wq8z2cDdW+mVPeh1sTC5DWFKxXmB4c1/MNUGhJA57LuoOqAEEId9ZG8PaBF5skMKQTr5KEAMeTWUxGWnPRUjxgiDwYWmInYD5D34Ayngg1Xm3Q4mGIn1SHCk+cYd0A0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FJOe4o0K; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so325644066b.1
        for <cgroups@vger.kernel.org>; Sun, 21 Jan 2024 21:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705900226; x=1706505026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bX4dObL3c95165XLM7yzt7rEIgdTlOtpBnPF9EhNwGQ=;
        b=FJOe4o0KRE8ZFKBopDFbPI/1ydJWNXqjNqiEqBLcIDnzmFgSY/75CCOHYTK+xyLQ+5
         JhHO4af4kJr9ivNG59npjBaXOjYVaAp9E2g6qYzIqCM80IoX2ZBGCVhimWfoDFhLgifv
         Mnekwu5nmFwqmR16DWrLauK21mCryVNCHAiY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705900226; x=1706505026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX4dObL3c95165XLM7yzt7rEIgdTlOtpBnPF9EhNwGQ=;
        b=dcVOBuvoZsgNQcSVur9/ssP1iAhLn7qoYrk45b8z0VxzMwhQlmM1FQ54iyYfG/tvmw
         N9XappF2nNXCP82W300+CN/hj6ziuu15qUz3TFNTk5J+/tY+NP9DX4T2KB/p6h14eqVP
         pl0aa6BAtxYmW7x+dev5BlF/rsoiYu/YmjNUnp7C2OmmZWw2JUtAHPVTRKzEV+KomUPR
         NlselTp18obglfParnf1Naw2LbKJ9IvIHXSdfvSn5oYi5NSFRx9dR+q+633SQULs5H3J
         MrluzugEYSLIOLSkclGH/BFktiQx0vKS3ZTvRWp6w4i6Au7xfm/gbZ2x1nQ5UpJ8bMKW
         xieA==
X-Gm-Message-State: AOJu0YzwpOggvICMqICBtrrpisEviT6ec9RSwJ45PhnzDA+bBPSUHWus
	WGfJ/1/pdcMZGx3wkwMObu5FfnM7t0fWqrLOi1v2KbMRoJgqSbvyLtZhPr8a766vlnWjzG6FMkA
	dUcwUsaHP
X-Google-Smtp-Source: AGHT+IHMjTVb/K2SgWowWlG5YSfV5rE1G9klZ+qLycrCwCN6kArZ35SKEf4I19oDEr/bciHEUtEI/w==
X-Received: by 2002:a17:907:268a:b0:a28:e6d8:dd15 with SMTP id bn10-20020a170907268a00b00a28e6d8dd15mr1451668ejc.33.1705900226506;
        Sun, 21 Jan 2024 21:10:26 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906190100b00a2689e28445sm12969664eje.106.2024.01.21.21.10.26
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 21:10:26 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339208f5105so2386119f8f.1
        for <cgroups@vger.kernel.org>; Sun, 21 Jan 2024 21:10:26 -0800 (PST)
X-Received: by 2002:a7b:ce95:0:b0:40e:49ac:e4a6 with SMTP id
 q21-20020a7bce95000000b0040e49ace4a6mr1440118wmj.171.1705900225838; Sun, 21
 Jan 2024 21:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble> <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
 <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
 <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car> <CALvZod4V3QTULTW5QxgqCbDpNtVO6fXzta33HR7GN=L2LUU26g@mail.gmail.com>
In-Reply-To: <CALvZod4V3QTULTW5QxgqCbDpNtVO6fXzta33HR7GN=L2LUU26g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 21:10:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
Message-ID: <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 14:56, Shakeel Butt <shakeelb@google.com> wrote:
> >
> > So I don't see how we can make it really cheap (say, less than 5% overhead)
> > without caching pre-accounted objects.
>
> Maybe this is what we want. Now we are down to just SLUB, maybe such
> caching of pre-accounted objects can be in SLUB layer and we can
> decide to keep this caching per-kmem-cache opt-in or always on.

So it turns out that we have another case of SLAB_ACCOUNT being quite
a big expense, and it's actually the normal - but failed - open() or
execve() case.

See the thread at

    https://lore.kernel.org/all/CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com/

and to see the effect in profiles, you can use this EXTREMELY stupid
test program:

    #include <fcntl.h>

    int main(int argc, char **argv)
    {
        for (int i = 0; i < 10000000; i++)
                open("nonexistent", O_RDONLY);
    }

where the point of course is that the "nonexistent" pathname doesn't
actually exist (so don't create a file called that for the test).

What happens is that open() allocates a 'struct file *' early from the
filp kmem_cache, which has SLAB_ACCOUNT set. So we'll do accounting
for it, failt the pathname open, and free it again, which uncharges
the accounting.

Now, in this case, I actually have a suggestion: could we please just
make SLAB_ACCOUNT be something that we do *after* the allocation, kind
of the same way the zeroing works?

IOW, I'd love to get rid of slab_pre_alloc_hook() entirely, and make
slab_post_alloc_hook() do all the "charge the memcg if required".

Obviously that means that now a failure to charge the memcg would have
to then de-allocate things, but that's an uncommon path and would be
marked unlikely and not be in the hot path at all.

Now, the reason I would prefer that is that the *second* step would be to

 (a) expose a "kmem_cache_charge()" function that takes a
*non*-accounted slab allocation, and turns it into an accounted one
(and obviously this is why you want to do everything in the post-alloc
hook: just try to share this code)

 (b) remote the SLAB_ACCOUNT from the filp_cachep, making all file
allocations start out unaccounted.

 (c) when we have *actually* looked up the pathname and open the file
successfully, at *that* point we'd do a

        error = kmem_cache_charge(filp_cachep, file);

    in do_dentry_open() to turn the unaccounted file pointer into an
accounted one (and if that fails, we do the cleanup and free it, of
course, exactly like we do when file_get_write_access() fails)

which means that now the failure case doesn't unnecessarily charge the
allocation that never ends up being finalized.

NOTE! I think this would clean up mm/slub.c too, simply because it
would get rid of that memcg_slab_pre_alloc_hook() entirely, and get
rid of the need to carry the "struct obj_cgroup **objcgp" pointer
along until the post-alloc hook: everything would be done post-alloc.

The actual kmem_cache_free() code already deals with "this slab hasn't
been accounted" because it obviously has to deal with allocations that
were done without __GFP_ACCOUNT anyway. So there's no change needed on
the freeing path, it already has to handle this all gracefully.

I may be missing something, but it would seem to have very little
downside, and fix a case that actually is visible right now.

              Linus

