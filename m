Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A840648B686
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 20:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiAKTLy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 14:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243270AbiAKTLy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 14:11:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773AC06173F
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:11:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o6so276552edc.4
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B44bvcGMR7HJrF8RjjxVk6yTIMoiYipBLak96y+Vc5U=;
        b=b2vOkvqM6CrU97KTnO6tCUMPeqtx4Tb9raQiqg+DsCBvIm5TjoldAmKmEfiOSjOJi8
         Q2wHU19wTfiKrO4kFP5KoxmIJN/5uCNBtFVo+DFeoT5q8s6S7/g7wbRMshY/F57KQpZc
         HByWVJ89WRq9xPL/+lWSfsSWUMQUEeyGZRwaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B44bvcGMR7HJrF8RjjxVk6yTIMoiYipBLak96y+Vc5U=;
        b=cLhlKs56TLzjy4czAtfH6MBq5alHMdfzlmwdIOJ0gcwwY5QIYC1TKtDd0CKp2iCCA8
         525ErfH/lI1DkQkxsJ+uAFzk99BZg4Koa+QBS8QF1IBDND1fXDtTdFXRLu30nhlAgXdm
         XlmaYJ//hxunlEfLpb1JfrgMQtZWMQkg+dMMg/1VRxLDclIsc+dbOiY1BUk5R3H8NRvo
         xYviPavdEtcPTzZ25s+muBCpXmwD3gxe9BQUXrFKGLIR1MLdmz87Jy6NOuhtDzYZfc1I
         pm6bFGk9aKB38UfyZFB/X+HVWlSU2onu2TMZo2MixY2t0LO/e6p2aGP4mdt+/TDq8E4R
         isIQ==
X-Gm-Message-State: AOAM531UhcPv+VXqyz0+LIswx98S+P6qvf4QKguyyR90Dj9s4TbgNmcJ
        IfqYeAhA7TDy4D59BmmJFJsm2eXOmFz3Wv1M9xI=
X-Google-Smtp-Source: ABdhPJyGUD/77YEt4U1KJUeJfhS/IE75evRIg0Elfw51gns2uuKebqx5u8nErA3jrLMMa39Eyud46Q==
X-Received: by 2002:a17:906:a411:: with SMTP id l17mr4901565ejz.11.1641928312343;
        Tue, 11 Jan 2022 11:11:52 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id o1sm3856973ejy.150.2022.01.11.11.11.48
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:11:49 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id d19so144480wrb.0
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:11:48 -0800 (PST)
X-Received: by 2002:a5d:6083:: with SMTP id w3mr1539236wrt.281.1641928308184;
 Tue, 11 Jan 2022 11:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20220111071212.1210124-1-surenb@google.com> <Yd3RClhoz24rrU04@sol.localdomain>
In-Reply-To: <Yd3RClhoz24rrU04@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 11:11:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com>
Message-ID: <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 10:48 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> The write here needs to use smp_store_release(), since it is paired with the
> concurrent READ_ONCE() in psi_trigger_poll().

A smp_store_release() doesn't make sense pairing with a READ_ONCE().

Any memory ordering that the smp_store_release() does on the writing
side is entirely irrelevant, since the READ_ONCE() doesn't imply any
ordering on the reading side. Ordering one but not the other is
nonsensical.

So the proper pattern is to use a WRITE_ONCE() to pair with a
READ_ONCE() (when you don't care about memory ordering, or you handle
it explicitly), or a smp_load_acquire() with a smp_store_release() (in
which case writes before the smp_store_release() on the writing side
will be ordered wrt accesses after smp_load_acquire() on the reading
side).

Of course, in practice, for pointers, the whole "dereference off a
pointer" on the read side *does* imply a barrier in all relevant
situations. So yes, a smp_store_release() -> READ_ONCE() does work in
practice, although it's technically wrong (in particular, it's wrong
on alpha, because of the completely broken memory ordering that alpha
has that doesn't even honor data dependencies as read-side orderings)

But in this case, I do think that since there's some setup involved
with the trigger pointer, the proper serialization is to use
smp_store_release() to set the pointer, and then smp_load_acquire() on
the reading side.

Or just use the RCU primitives - they are even better optimized, and
handle exactly that case, and can be more efficient on some
architectures if release->acquire isn't already cheap.

That said, we've pretty much always accepted that normal word writes
are not going to tear, so we *have* also accepted just

 - do any normal store of a value on the write side

 - do a READ_ONCE() on the reading side

where the reading side doesn't actually care *what* value it gets, it
only cares that the value it gets is *stable* (ie no compiler reloads
that might show up as two different values on the reading side).

Of course, that has the same issue as WRITE_ONCE/READ_ONCE - you need
to worry about memory ordering separately.

> > +     seq->private = new;
>
> Likewise here.

Yeah, same deal, except here you can't even use the RCU ones, because
'seq->private' isn't annotated for RCU.

Or you'd do the casting, of course.

              Linus
