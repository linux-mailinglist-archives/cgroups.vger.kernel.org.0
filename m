Return-Path: <cgroups+bounces-3734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48193401F
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EBC1F22C88
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FB117F362;
	Wed, 17 Jul 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU5SZjmq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268B1E4B0
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232292; cv=none; b=C/75A1oadYgIwW0+4sD9OJtnQu11mENgr/MvyFEgSyE9TM/J0N4bvDrUn3bWhRvKIyX+jMVI2yzhNNJTKcV4/V2NyY0zeuYBqe65rA2vttylzx5MRAy97zNu8fn7z9wARbtZ91LAp4VNsVLSsCuBgfQYRHkeyPLKAnDj7XpXUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232292; c=relaxed/simple;
	bh=AoAZcZDBufYR6+8XmPD3d85dxJzmXDI3rW9IHEM0hhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqW98VB8ob6Umj2G9/rWLy/+sg0d9bKFch1sZiM5v1peNmln+p2LFPLOh1V6+2jzyTrkzwr2zqXjaJlhDpkDpzlAKcJM57YzCBYL25HAJwSZ1xBH2yCBT1/LQkhQrQXWs/rlQNNC5oENavOYhP59UiQnhl9AXjXLm5qiajnzNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU5SZjmq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a79fe8e6282so93693066b.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721232289; x=1721837089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKIjwSAQrkgMVgtHKV1uhwl6zysvp7/fR9dohyVGsJc=;
        b=UU5SZjmqxuGffg/iAIvKWIXjPjv2y9wIbhoGB/OgJtOvWL0aVeMdYDV2DUkM4iLQPq
         4dYEVMVlRKPS69a80aZP3O/Xef450tZrcyUq7w/ZPsvRzU1VH5gJqCsB+scDoHAqimdS
         7ZlF0ZqY3G7Ge/esPnWGxHlGnkOmGFrc1FU9RwmEAGNU41mJhvSJAATjsWcRntIEUqkj
         A3hAfVxkRdj8oIvLitGYthwfyIgd48Zk97nJUNfursU8yhliLMRiBzhdK2uih0y+CQIQ
         aNFOa/Qmy1Rpi7kCFKC3unZsTl4BFGUuwUvig5dNv9xDv3WRyDxUBdPj/bd6LTreNOJ8
         +/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721232289; x=1721837089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKIjwSAQrkgMVgtHKV1uhwl6zysvp7/fR9dohyVGsJc=;
        b=p3KI1XpaMrbFJ2Nr31TCzRQ7YS6ynpOIBhelsHbIiGc9Gj3wUc71IZb75BlJDFm4N1
         ayuE9DVPNj6Puoy/e8gE7F/vSL7540nvGht3g8IuAkLEXU7RyekL8uoTrlsEAar2Ek0i
         qBpNNoP5FG0oWiyKOdEJyuO86qADi647QJLadvMNhouER71umkIue+NfFIRBNMtRw3Gg
         ixJBnUrCao4K3LYF7rwprR+2XaxciRVy4n8ErVL2yCGVN1io0ZBWyyMOg66tfPi1zVg6
         IMcixCDU4etDWj+gs9hXvYXx8mEvihfasZKb3UbFlawT3X4cvAV28D9F8YPLc5GMhEGW
         9DnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGaYSsNgcVTPcR6IjLbXXHz1AlKrL6CI1cGdtS48rPAoZLzx8KbRWi0dD8OP0X+J/y8Vou1UXzUr085E/obgx/sgt3lWa2iw==
X-Gm-Message-State: AOJu0YyGsKNAtzvdbuBjh4qcBb5TvGj+vOxRKnR3iX4ro4BlNQEN5jpQ
	BEOWHaRSzIwmDIphpusUjuFz6ZfA5bHBZFbGN6qJp/sdqzjcCsRiPZJXhXGwb8jtAjSLMXKStJb
	YvibWMlqcAJHQXsgn9Wej5Sq7wwFs8HsBFAXq
X-Google-Smtp-Source: AGHT+IE+KGZPn8v42uAvYqn/WiCl5jZpR4/bzecrp0HAsD5IbBc4tqOnEKm34cqpnXBi+3JZQ/CJ/A4sgAhzyL14cIU=
X-Received: by 2002:a17:906:718:b0:a6f:b885:2042 with SMTP id
 a640c23a62f3a-a7a011e5186mr164953166b.18.1721232288273; Wed, 17 Jul 2024
 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
 <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org> <9a7930b9-dec0-418c-8475-5a7e18b3ec68@kernel.org>
 <CAJD7tkYX9OaAyWg=L_5v7GaKtKmptPpMGJh7Org5tcY4D-YnCw@mail.gmail.com> <e656b89a-1dcd-4fcc-811a-a7222232acc7@kernel.org>
In-Reply-To: <e656b89a-1dcd-4fcc-811a-a7222232acc7@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 09:04:07 -0700
Message-ID: <CAJD7tkZg4N9k7dUnTSJ06fjPdB9Ei=6JDjHW5UU_J91euyboSw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 12:46=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 16/07/2024 23.54, Yosry Ahmed wrote:
> > On Mon, Jul 8, 2024 at 8:26=E2=80=AFAM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >>
> >>
> >> On 28/06/2024 11.39, Jesper Dangaard Brouer wrote:
> >>>
> >>>
> >>> On 28/06/2024 01.34, Shakeel Butt wrote:
> >>>> On Thu, Jun 27, 2024 at 11:18:56PM GMT, Jesper Dangaard Brouer wrote=
:
> >>>>> Avoid lock contention on the global cgroup rstat lock caused by ksw=
apd
> >>>>> starting on all NUMA nodes simultaneously. At Cloudflare, we observ=
ed
> >>>>> massive issues due to kswapd and the specific mem_cgroup_flush_stat=
s()
> >>>>> call inlined in shrink_node, which takes the rstat lock.
> >>>>>
> >> [...]
> >>>>>    static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)=
;
> >>>>> @@ -312,6 +315,45 @@ static inline void __cgroup_rstat_unlock(struc=
t
> >>>>> cgroup *cgrp, int cpu_in_loop)
> >>>>>        spin_unlock_irq(&cgroup_rstat_lock);
> >>>>>    }
> >>>>> +#define MAX_WAIT    msecs_to_jiffies(100)
> >>>>> +/* Trylock helper that also checks for on ongoing flusher */
> >>>>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> >>>>> +{
> >>>>> +    bool locked =3D __cgroup_rstat_trylock(cgrp, -1);
> >>>>> +    if (!locked) {
> >>>>> +        struct cgroup *cgrp_ongoing;
> >>>>> +
> >>>>> +        /* Lock is contended, lets check if ongoing flusher is alr=
eady
> >>>>> +         * taking care of this, if we are a descendant.
> >>>>> +         */
> >>>>> +        cgrp_ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> >>>>> +        if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoin=
g)) {
> >>>>
> >>>> I wonder if READ_ONCE() and cgroup_is_descendant() needs to happen
> >>>> within in rcu section. On a preemptable kernel, let's say we got
> >>>> preempted in between them, the flusher was unrelated and got freed
> >>>> before we get the CPU. In that case we are accessing freed memory.
> >>>>
> >>>
> >>> I have to think about this some more.
> >>>
> >>
> >> I don't think this is necessary. We are now waiting (for completion) a=
nd
> >> not skipping flush, because as part of take down function
> >> cgroup_rstat_exit() is called, which will call cgroup_rstat_flush().
> >>
> >>
> >>    void cgroup_rstat_exit(struct cgroup *cgrp)
> >>    {
> >>          int cpu;
> >>          cgroup_rstat_flush(cgrp);
> >>
> >>
> >
> > Sorry for the late response, I was traveling for a bit. I will take a
> > look at your most recent version shortly. But I do have a comment
> > here.
> >
> > I don't see how this addresses Shakeel's concern. IIUC, if the cgroup
> > was freed after READ_ONCE() (and cgroup_rstat_flush() was called),
> > then cgroup_is_descendant() will access freed memory. We are not
> > holding the lock here so we are not preventing cgroup_rstat_flush()
> > from being called for the freed cgroup, right?
>
> If we go back to only allowing root-cgroup to be ongoing-flusher, then
> we could do a cgroup_rstat_flush(root) in cgroup_rstat_exit() to be sure
> nothing is left waiting for completion scheme. Right?

I am still not sure I understand how this helps.

We still need to call cgroup_is_descendant() because in cgroup v1 we
may have multiple root cgroups, right?

So it is still possible that the cgroup is freed after READ_ONCE() and
cgroup_is_descendant() accesses freed memory. Unless of course we have
other guarantees that the root cgroups will not go away.

Since at this point we are not holding the rstat lock, or actually
waiting for the ongoing flush (yet), I don't see how any
cgroup_rstat_flush() calls in the cgroup exit paths will help.

I actually think RCU may not help either for non-root cgroups, because
we call cgroup_rstat_flush() in cgroup_rstat_exit(), which is called
*after* the RCU grace period, and the cgroup is freed right away after
that. We may need to replace kfree(cgrp) with kfree_rcu(cgrp) in
css_free_rwork_fn().

>
> IMHO the code is getting too complicated with sub-cgroup's as ongoing
> flushers which also required having 'completion' queues per cgroup.
> We should go back to only doing this for the root-cgroup.

Because of multiple root cgroups in cgroup v1, we may still need that
anyway, right?

Please let me know if I am missing something.

