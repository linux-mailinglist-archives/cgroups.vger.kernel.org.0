Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB35492EC8
	for <lists+cgroups@lfdr.de>; Tue, 18 Jan 2022 20:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348997AbiARTy3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jan 2022 14:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348976AbiARTyT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jan 2022 14:54:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD87C06173F
        for <cgroups@vger.kernel.org>; Tue, 18 Jan 2022 11:54:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s30so75233986lfo.7
        for <cgroups@vger.kernel.org>; Tue, 18 Jan 2022 11:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLG3IDzGCmMuTJ6Lo7fCzvTJqI3hQH1J7qtya62FFTI=;
        b=FBf0wEoEZmYrfY/6yOjBzgydEx8VKqwZ8Ch024JkOhYKPMTXZB+t8YyjAURKEhqryK
         JN+VJ2NZigyahygOqJOGPDF/OmkyCI4BjOvNzGmnDmAfzUJVOodUutd9oqYw1AllHdEd
         jACTBytbhyPlqIQ4hYKIl96SBtUPCZix9Gbo0MUlRZmWis8a8xywWSmu3m6i+kmjrmuz
         t4LICgPw4Tb3O17gcn5o7I176EivuuydQKXTKooOxhMHJ94PoDUAxJuZYnigi201uoXq
         7f9XQQBHzAOvBB4PpEeWDjfOnw/UTG4F5Y5Dz6c3yFfHoq8npWj/4KkzcseYO1x+G1bE
         RXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLG3IDzGCmMuTJ6Lo7fCzvTJqI3hQH1J7qtya62FFTI=;
        b=hso2x8KzHs/GTE3tBJgQNX9sxLWOlcQlKkZ1KPM3Emv14Y4Fz/wL/MwgzeUsEVPb1n
         K14yUSMLxetRlIJv8kBISCbVGb1GIyn3NNwKNlux00fhRRVmrAXP1J6nvGz5KXlbCHbD
         jT/lnNrg9hpfaXe+lzSa5p+Pyovw9d8bjruxrmA2LmD6heKB1+NYvg/pdCiEvdMUVEgI
         d5gs5DeyLLK/imx2OcWG8t3G8PpcBc6GlS5LWYlVwPoqA8APEHSJ0/QXdbi474R0+Kk5
         THXUQkpo0vgflt1Ow1/fRnLgZKVoh0wH6CVgA/YrpAaCwaOwztYIF1aitZFYI1J0ElNC
         gQpA==
X-Gm-Message-State: AOAM5331aibyPozgZXDNFCMSIFBsEbj/LvI62uaPF5TkE1XkLgMZYv3D
        NF8LmdUD6rwBrN9bNZoAbVC/LVkMjsFZwb3rLBAqnDRibjs=
X-Google-Smtp-Source: ABdhPJy85EozpNsEzXaqWw1SJGpLYcfi+KrRxRAWUx2xP8iVyiAyVo7E1yNxSzwYpnYpYkYmWzOAwckjZixuHl9F+YM=
X-Received: by 2002:a2e:9093:: with SMTP id l19mr20391335ljg.231.1642535655048;
 Tue, 18 Jan 2022 11:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20211222225350.1912249-1-vipinsh@google.com> <YctGtWzYcNP2iTaN@google.com>
In-Reply-To: <YctGtWzYcNP2iTaN@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 18 Jan 2022 11:53:39 -0800
Message-ID: <CAHVum0czVQqugNs4BhwJpUx-+f6GZQHFRkTpH01Mmsu0FXSd+w@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, dmatlack@google.com, jiangshanlai@gmail.com,
        kvm@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 28, 2021 at 9:17 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Dec 22, 2021, Vipin Sharma wrote:
> > diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> > index 81c9e0685948..81d4b2f2acf0 100644
> > --- a/kernel/cgroup/cgroup-v1.c
> > +++ b/kernel/cgroup/cgroup-v1.c
> >  int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
> > @@ -58,6 +60,9 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
> >       struct cgroup_root *root;
> >       int retval = 0;
> >
> > +     if (!from)
> > +             from = kthreadd_task;
>
> Rather than sully cgroup_attach_task_all() with this behavior, can't KVM do
>
>         cgroup_attach_task_all(current->real_parent, current)
>
> since AFAICT real_parent is guaranteed to point at kthreadd_task.
>

Thanks for the "real_parent" suggestion. This is much cleaner and
better than changing cgroup logic. I will make this change.

> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index b0f7e6eb00ff..f7504578c374 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -5793,6 +5793,19 @@ static int kvm_vm_worker_thread(void *context)
> >       if (!kthread_should_stop())
> >               err = thread_fn(kvm, data);
> >
> > +out:
> > +     /*
> > +      * We need to move the kthread back to its original cgroups, so that it
>
> Please state what is being done, not what "needs" to be done.  The need to do
> something is implicit, otherwise we wouldn't be doing it.
>

I will update the statement. Thanks.

> > +      * doesn't linger in the cgroups of the user process after the user
> > +      * process has already terminated.
> > +      *
> > +      * kthread_stop() waits on 'exited' completion condition which is set
> > +      * in exit_mm(), via mm_release(), in do_exit(). However, kthread
> > +      * is removed from cgroups in the cgroup_exit() which is called after
> > +      * exit_mm(). This causes lingering of kthreads in cgroups after main
> > +      * VM process has finished.
> > +      */
> > +     WARN_ON(cgroup_attach_task_all(NULL, current));
>
> This should not WARN, cgroup_attach_task_all() needs to perform allocations and
> will fail with -ENOMEM even in the absense of kernel bugs.
>

I will remove WARN_ON and print an error using kvm_err(), it will be
similar to the earlier call of cgroup_attach_task_all() in the same
function.

Thanks
