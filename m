Return-Path: <cgroups+bounces-1201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A72836F5C
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B134290E73
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4C83E462;
	Mon, 22 Jan 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPCF1fbJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6CD405D4
	for <cgroups@vger.kernel.org>; Mon, 22 Jan 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945119; cv=none; b=S3dbI2fo89QR7XQHvhMIHZKrM4IoUxuLcPQuNpxxfsr0eIDZITJKPAFShY3xrqx2iO/y4P3NkMtFDprxKHfXoBakB997bWZuZDLWsO3gXNDYqAj0aZy6GGLShPSC1xeN0pU+0jEtmLOSs4q4p5BRItfuJvPFjgZhwdqg9pLHwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945119; c=relaxed/simple;
	bh=lx13kHG0tJJSdUreOeJdloyx12tNITbn9wmXA6Zx684=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWCgUIgmyYyKtCX25E42TnkD4XKSGT06QuuLPegrsxUM+2++QblGyUJ3TTc9Z2AXbD7rz/AK1jYbkVIBjKKYXf0Xu4wGPLdx5O5P/RgwaxijZMo+3mDsfHi6AII+TambC5GGknBIX8S9WLyPd8Nit7iG2X1Sb9ONTKdtGCTPHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPCF1fbJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d72d240c69so253915ad.1
        for <cgroups@vger.kernel.org>; Mon, 22 Jan 2024 09:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705945117; x=1706549917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UuQsVtmQQmr5HjqyMtyAk8R8Y84z4aC4k61fXm7dcc=;
        b=yPCF1fbJt88udfi4IbYvyaXYX1RwZVyFK5gY8d4VgFcIHQfE23M7XwhosOmHMl7BSw
         1f2ch0AVVFdaRvBeDfwm1Dx3LPBiol/n1wR7FJJuAo5L6FDFzvUlHz1gV6X5bPTy1Kmx
         RKhjIETiDmyPys3CDehoYWfEpHESDMTCapSKiGdGka7ryTwq/zKsrJqHCsMbu+yVxXlA
         49lYvZyMLr7jiTPTi/pmV/HGwBC+sOJv9BVuM2L3UTGKoH1ffNCyTzQfpoVteKAulTit
         kiPRTYXLk7smW4XpMxCIX25uXX/RsApCHtPRHd7o4ihYa9OBLGk9EX7cdiupmcQmgTiK
         DKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945117; x=1706549917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UuQsVtmQQmr5HjqyMtyAk8R8Y84z4aC4k61fXm7dcc=;
        b=rZFtwJzoYNrERGLkN+FDd3Sb9K+vCtu2QzsgjchCELPwok71xntFXjLQZqbpZ59hW/
         k5QRvvNVeACqeSygfpW0aW+io0RR5h34vNp0hnMzlgeritV+ZLtLlZr3sNmiiPGaAMQ8
         +5nD6KlAJOTocQw+g1BQrozwwrwoYiD7Kb50rqTS5gUSZ7Dft8/cAhOtLyB7kIGU0Y59
         0tCMBeMleUIPf05L7TnkOTo7uVaTiqocpW5xNf+MNrpcC7fL0uspY/PBkTdiVR9NypY3
         yiSWA6aUtEDHs8HzSntVfSQJtyGgHjNOz/P0a5YwCUgDGDuKx0QPwUR398Y+0UgS+obF
         05kg==
X-Gm-Message-State: AOJu0YzidtHClNSlsOqbLsr3fJmqhpBGckaYTYTxPJV/XrmUl7Ff+eXn
	SmKI+Qgnl1+N1cPpct/43C3CW4wLYRnYzvJO1R6blfowruAKT+Y1A9fgKYFqmptPTfq5Y9gVUBH
	yp/up2psX3hWx7gOyCOhf+U07IGqXqhq/ED/7
X-Google-Smtp-Source: AGHT+IFYv5tHX1WQPl3UKkucHmsgclS/9mQvJ8BtkspQnHW8INm/bfJkBEp88NMt7Nyb4tbGmP3GUFNzcPfeUEN4+yY=
X-Received: by 2002:a17:902:e747:b0:1d6:f66b:1057 with SMTP id
 p7-20020a170902e74700b001d6f66b1057mr2985plf.28.1705945117286; Mon, 22 Jan
 2024 09:38:37 -0800 (PST)
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
 <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
In-Reply-To: <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 22 Jan 2024 09:38:23 -0800
Message-ID: <CALvZod6tCb=3+W18V7kntjJZBRMigGnyPQGjQK0no9Q1KmpcRQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, Jan 21, 2024 at 9:16=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 17 Jan 2024 at 14:56, Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > So I don't see how we can make it really cheap (say, less than 5% ove=
rhead)
> > > without caching pre-accounted objects.
> >
> > Maybe this is what we want. Now we are down to just SLUB, maybe such
> > caching of pre-accounted objects can be in SLUB layer and we can
> > decide to keep this caching per-kmem-cache opt-in or always on.
>
> So it turns out that we have another case of SLAB_ACCOUNT being quite
> a big expense, and it's actually the normal - but failed - open() or
> execve() case.
>
> See the thread at
>
>     https://lore.kernel.org/all/CAHk-=3Dwhw936qzDLBQdUz-He5WK_0fRSWwKAjtb=
VsMGfX70Nf_Q@mail.gmail.com/
>
> and to see the effect in profiles, you can use this EXTREMELY stupid
> test program:
>
>     #include <fcntl.h>
>
>     int main(int argc, char **argv)
>     {
>         for (int i =3D 0; i < 10000000; i++)
>                 open("nonexistent", O_RDONLY);
>     }
>
> where the point of course is that the "nonexistent" pathname doesn't
> actually exist (so don't create a file called that for the test).
>
> What happens is that open() allocates a 'struct file *' early from the
> filp kmem_cache, which has SLAB_ACCOUNT set. So we'll do accounting
> for it, failt the pathname open, and free it again, which uncharges
> the accounting.
>
> Now, in this case, I actually have a suggestion: could we please just
> make SLAB_ACCOUNT be something that we do *after* the allocation, kind
> of the same way the zeroing works?
>
> IOW, I'd love to get rid of slab_pre_alloc_hook() entirely, and make
> slab_post_alloc_hook() do all the "charge the memcg if required".
>
> Obviously that means that now a failure to charge the memcg would have
> to then de-allocate things, but that's an uncommon path and would be
> marked unlikely and not be in the hot path at all.
>
> Now, the reason I would prefer that is that the *second* step would be to
>
>  (a) expose a "kmem_cache_charge()" function that takes a
> *non*-accounted slab allocation, and turns it into an accounted one
> (and obviously this is why you want to do everything in the post-alloc
> hook: just try to share this code)
>
>  (b) remote the SLAB_ACCOUNT from the filp_cachep, making all file
> allocations start out unaccounted.
>
>  (c) when we have *actually* looked up the pathname and open the file
> successfully, at *that* point we'd do a
>
>         error =3D kmem_cache_charge(filp_cachep, file);
>
>     in do_dentry_open() to turn the unaccounted file pointer into an
> accounted one (and if that fails, we do the cleanup and free it, of
> course, exactly like we do when file_get_write_access() fails)
>
> which means that now the failure case doesn't unnecessarily charge the
> allocation that never ends up being finalized.
>
> NOTE! I think this would clean up mm/slub.c too, simply because it
> would get rid of that memcg_slab_pre_alloc_hook() entirely, and get
> rid of the need to carry the "struct obj_cgroup **objcgp" pointer
> along until the post-alloc hook: everything would be done post-alloc.
>
> The actual kmem_cache_free() code already deals with "this slab hasn't
> been accounted" because it obviously has to deal with allocations that
> were done without __GFP_ACCOUNT anyway. So there's no change needed on
> the freeing path, it already has to handle this all gracefully.
>
> I may be missing something, but it would seem to have very little
> downside, and fix a case that actually is visible right now.
>

Thanks for the idea. Actually I had a discussion with Vlastimil at LPC
'22 on a similar idea but for a different problem i.e. allocation in
irq context or more specifically charging sockets for incoming TCP
connections. If you see inet_csk_accept() we solved this for TCP
memory by charging at accept() syscall but the kernel memory holding
socket is still uncharged.

So, I think having the framework you suggested would help more
use-cases. I will take a stab at this in the next couple of days
(sorry stuck in some other stuff atm).

thanks,
Shakeel

