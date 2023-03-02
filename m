Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4356A85EE
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCBQOI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 11:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCBQOH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 11:14:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FB2C647
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 08:14:05 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so4061661ybu.8
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 08:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677773645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk3jxwGhDgrO97j71qZC7hN119s30TroFhBoZ90aiOw=;
        b=HOLaGjYG+E2moOTroF7Lrc+FT8kjPg8eO+2zq2UinSgu1L3KwflN5gtuQz0aDv9ZXP
         KckvhiQgN1sVCm2Hc5Yn1+cw9i8SMozFfdHsbL+AU7QVUr4jkT41uTH8LZGQmb0a6Zyi
         no4FFwYyuvgxDpfoo1taagMzOvHW+ePVVwvWXz9LTXbSNMqosnxaF+IsYpUHOzyH/Tkz
         /mwwZKGFNHwd/jt6Ud2+aiJBOGFURPV4LXpc9DU863O/dmd53NCqR/t6vQL5cmqrwzq8
         BjAV+kKZjlzQjPbo/AWcbYqHbGcwwvSf8THi1bV9ZERZZazHoRYC2q3QV6kNacTBeMmq
         XXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pk3jxwGhDgrO97j71qZC7hN119s30TroFhBoZ90aiOw=;
        b=RH4lHgpPnnMuM8jpWM1lCWwEtvcTdH4yVhfo17wF7Z+fVEGYpGS34tRu5b+qn1Rb9O
         Gb9PHhPk5jwc5TieSp35YY6K+2K6v/jrwHdvyNx7pQW5Ww9jXBtpD0M2BWhQ7B26SDnC
         Fl7Vlo4Gk/5Eqx+fsk980C5TxrhOqWfuTdnt06j83SJhZU8dr/DuyCG2y3MCwgNYa424
         iMyjsaz4OtCPMauJg8e0N2cj60+Y6/4UvqKx1/q0+DARDZfRuikEwurM1DcnmrWY6RYx
         XrA4ZaGMosvYgmwVygkVTaNq2fF+J+S5hFv1TVc9h5F/kHix85lzQSADrxlr/28VDBmP
         cmCQ==
X-Gm-Message-State: AO0yUKVibebtLedIr+LMRUsL7iUYiDzG8BkTAQZa7qmKgjMeK4AZJ0LO
        v44zJyxJnGAmKZeIdoLrfbP4bQ57BZ9Dass3kawvLA==
X-Google-Smtp-Source: AK7set9+bTrTQ51qMnNEYy8g/1SOF00A9AhrNkytx6kl+1TS0DOeSRD0r4Sq47w1fENuH5Bq/GsXLlw477NZXu+8vAM=
X-Received: by 2002:a5b:650:0:b0:997:bdfe:78c5 with SMTP id
 o16-20020a5b0650000000b00997bdfe78c5mr5867671ybq.6.1677773644842; Thu, 02 Mar
 2023 08:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20230301193403.1507484-1-surenb@google.com> <Y/+wlg5L8A1iebya@cmpxchg.org>
 <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com> <ZADBCEk68W1aGJAV@cmpxchg.org>
In-Reply-To: <ZADBCEk68W1aGJAV@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 2 Mar 2023 08:13:54 -0800
Message-ID: <CAJuCfpHF=9Dv_Yzph5jNmR1ZfTf7Lf=_oShztyLUq0ps_D=osQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for triggers
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, peterz@infradead.org,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 2, 2023 at 7:30 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Mar 01, 2023 at 12:48:38PM -0800, Suren Baghdasaryan wrote:
> > On Wed, Mar 1, 2023 at 12:07=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Wed, Mar 01, 2023 at 11:34:03AM -0800, Suren Baghdasaryan wrote:
> > > > Current 500ms min window size for psi triggers limits polling inter=
val
> > > > to 50ms to prevent polling threads from using too much cpu bandwidt=
h by
> > > > polling too frequently. However the number of cgroups with triggers=
 is
> > > > unlimited, so this protection can be defeated by creating multiple
> > > > cgroups with psi triggers (triggers in each cgroup are served by a =
single
> > > > "psimon" kernel thread).
> > > > Instead of limiting min polling period, which also limits the laten=
cy of
> > > > psi events, it's better to limit psi trigger creation to authorized=
 users
> > > > only, like we do for system-wide psi triggers (/proc/pressure/* fil=
es can
> > > > be written only by processes with CAP_SYS_RESOURCE capability). Thi=
s also
> > > > makes access rules for cgroup psi files consistent with system-wide=
 ones.
> > > > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers=
 and
> > > > remove the psi window min size limitation.
> > > >
> > > > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraj=
a@quicinc.com/
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  kernel/cgroup/cgroup.c | 10 ++++++++++
> > > >  kernel/sched/psi.c     |  4 +---
> > > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > > index 935e8121b21e..b600a6baaeca 100644
> > > > --- a/kernel/cgroup/cgroup.c
> > > > +++ b/kernel/cgroup/cgroup.c
> > > > @@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct =
kernfs_open_file *of,
> > > >       return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
> > > >  }
> > > >
> > > > +static int cgroup_pressure_open(struct kernfs_open_file *of)
> > > > +{
> > > > +     return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RE=
SOURCE)) ?
> > > > +             -EPERM : 0;
> > > > +}
> > >
> > > I agree with the change, but it's a bit unfortunate that this check i=
s
> > > duplicated between system and cgroup.
> > >
> > > What do you think about psi_trigger_create() taking the file and
> > > checking FMODE_WRITE and CAP_SYS_RESOURCE against file->f_cred?
> >
> > That's definitely doable and we don't even need to pass file to
> > psi_trigger_create() since it's called only when we write to the file.
> > However by moving the capability check into psi_trigger_create() we
> > also postpone the check until write() instead of failing early in
> > open(). I always assumed failing early is preferable but if
> > consolidating the code here makes more sense then I can make the
> > switch. Please let me know if you still prefer to move the check.
>
> Just for context, a person on our team is working on allowing
> unprivileged polls with windows that are multiples of 2s, which can be
> triggered from the regular aggregator threads. This should be useful
> for container delegation, and also for the desktop monitor app usecase
> that Chris Down brought up some time ago. At that point, everybody can
> open the file for write, and permissions are checked against the
> trigger parameters.
>
> So I don't think it's a big deal to check this particular permission
> at write time. But if you prefer we can also merge your patch as-is
> and do the refactor as part of the other series.

Let's roll this check without additional changes and then consolidate
the checking inside psi_trigger_create() in a separate patch. If
anybody objects to the late permission check we will just revert that
last change without affecting anything else.

>
> Your call. In either case, please feel free to add
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks! Will post the final patch with Ack's later today. Originally
it was purely cgroup-related change but now it's more of a PSI change.
Therefore Peter's tree will probably be the right place for it.
