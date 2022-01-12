Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600DE48CA07
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 18:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiALRn7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 12:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243483AbiALRn4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 12:43:56 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D13C061751
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 09:43:56 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t24so3967071qkg.11
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eP5J8KdvwPTzx2Kh8QKLifNfox7/NjpkOpmG9av6VCk=;
        b=KOnNi/erjJKDmXshSZZv7C3gKcJm3IwJxMouUmE8kJwjg35FNi2J3VpRJJE/XQaq+f
         ouYLgnZDFAaNV/dqxDZDk6O3Fv6kndvxJTf9AH6O4akiYKs9CyjyX3pWSP26jU17VEXI
         6ErUlQZ3+TUb2xsmk1ccCDw9ox3MzN4DbY+Gik5rJVQOkCfjDDk7H1g7Yf66gTgdMZ0B
         xX7ItBjgp1QlQISrAdgTibHYblom3PdgqvpX8tr+VOTUf+X4TBASg+486PvrMw4KlZD7
         CYY5L51LKMZK8LUaHHFZsldW3arkrea20wfWQ0cJ5wMJObXD8DPKu+feJ+i17rNp84mq
         Jraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eP5J8KdvwPTzx2Kh8QKLifNfox7/NjpkOpmG9av6VCk=;
        b=R2GwbFeNRqdakU6+Ev+e6K7K2wpKHe61uOZ4Onpx/xTCqPeLzUUyQBmAd1VaBO9qPe
         8oHnCl6vss+56Xc6/Y5w7WqsuM9EWW1p3fYbjD3vUlpgq0vZKRh7e3RsngNnHAWxNBOW
         bfg8w7cQs4+O7j/bIdRXicH077ThMsdMMldZbkIvJZ14L22ifQSjwaR068xMrqvLEV1S
         /9OsSSA8omVmxYnXu1kab5747CbXYfXHr8iWZkZXv+dOU9Spx9bfcJASw7YjuTHRH66U
         K43rh831lp8sJRFM5fsZ2J/VsWrJn4MdZvGbjF79oqaaLqS4/cZg0xoQe8xheMxp1kpM
         Elxw==
X-Gm-Message-State: AOAM531SsIrxw8yOuzB9JOmdiFI7kzkpQy9rTo21WBY6FsreCM1FZGDk
        vCkNUO0LZeLhqW0wfw24/LtBtrV1wn/J23EJw4d3KQ==
X-Google-Smtp-Source: ABdhPJxLWwmyro/LoBJqQDlBZtRxFKL0M6eFBNtTxql56a0+Bl0VWjyjB5YOXPDVFGgaUWS7krAoLWZb5Bhs1xjIjtM=
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr987928ybt.225.1642009434832;
 Wed, 12 Jan 2022 09:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20220111232309.1786347-1-surenb@google.com> <Yd7oPlxCpnzNmFzc@cmpxchg.org>
In-Reply-To: <Yd7oPlxCpnzNmFzc@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Jan 2022 09:43:43 -0800
Message-ID: <CAJuCfpGHLXDvMU1GLMcgK_K72_ErPhbcFh1ZvEeHg025yinNuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

)

On Wed, Jan 12, 2022 at 6:40 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Jan 11, 2022 at 03:23:09PM -0800, Suren Baghdasaryan wrote:
> > With write operation on psi files replacing old trigger with a new one,
> > the lifetime of its waitqueue is totally arbitrary. Overwriting an
> > existing trigger causes its waitqueue to be freed and pending poll()
> > will stumble on trigger->event_wait which was destroyed.
> > Fix this by disallowing to redefine an existing psi trigger. If a write
> > operation is used on a file descriptor with an already existing psi
> > trigger, the operation will fail with EBUSY error.
> > Also bypass a check for psi_disabled in the psi_trigger_destroy as the
> > flag can be flipped after the trigger is created, leading to a memory
> > leak.
> >
> > Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> > Cc: stable@vger.kernel.org
> > Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
> > Analyzed-by: Eric Biggers <ebiggers@kernel.org>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Hmm. kernel test robot notified me of new (which are not really new)
warnings but I don't think this patch specifically introduced them:

kernel/sched/psi.c:1112:21: warning: no previous prototype for
function 'psi_trigger_create' [-Wmissing-prototypes]
   struct psi_trigger *psi_trigger_create(struct psi_group *group,
                       ^
   kernel/sched/psi.c:1112:1: note: declare 'static' if the function
is not intended to be used outside of this translation unit
   struct psi_trigger *psi_trigger_create(struct psi_group *group,
   ^
   static
>> kernel/sched/psi.c:1182:6: warning: no previous prototype for function 'psi_trigger_destroy' [-Wmissing-prototypes]
   void psi_trigger_destroy(struct psi_trigger *t)
        ^
   kernel/sched/psi.c:1182:1: note: declare 'static' if the function
is not intended to be used outside of this translation unit
   void psi_trigger_destroy(struct psi_trigger *t)
   ^
   static
   kernel/sched/psi.c:1249:10: warning: no previous prototype for
function 'psi_trigger_poll' [-Wmissing-prototypes]
   __poll_t psi_trigger_poll(void **trigger_ptr,
            ^
   kernel/sched/psi.c:1249:1: note: declare 'static' if the function
is not intended to be used outside of this translation unit
   __poll_t psi_trigger_poll(void **trigger_ptr,
   ^

This happens with the following config:

CONFIG_CGROUPS=n
CONFIG_PSI=y

With cgroups disabled these functions are defined as non-static but
are not defined in the header
(https://elixir.bootlin.com/linux/latest/source/include/linux/psi.h#L28)
since the only external user cgroup.c is disabled. The cleanest way to
fix these I think is by doing smth like this in psi.c:

struct psi_trigger *_psi_trigger_create(struct psi_group *group, char
*buf, size_t nbytes, enum psi_res res)
{
  // original psi_trigger_create code
}

#ifdef CONFIG_CGROUPS

struct psi_trigger *psi_trigger_create(struct psi_group *group, char
*buf, size_t nbytes, enum psi_res res)
{
    return _psi_trigger_create(group, buf, nbytes, res);
}

#else

static struct psi_trigger *psi_trigger_create(struct psi_group *group,
char *buf, size_t nbytes, enum psi_res res)
{
    return _psi_trigger_create(group, buf, nbytes, res);
}

#endif

Two questions:
1. Is this even worth fixing?
2. If so, I would like to do that as a separate patch (these warnings
are unrelated to the changes in this patch). Would that be ok?
Thanks,
Suren.
