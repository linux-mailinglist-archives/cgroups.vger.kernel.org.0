Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188736F4911
	for <lists+cgroups@lfdr.de>; Tue,  2 May 2023 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjEBRUt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 May 2023 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjEBRUs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 May 2023 13:20:48 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7BAB
        for <cgroups@vger.kernel.org>; Tue,  2 May 2023 10:20:46 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b99efd7c335so5890073276.0
        for <cgroups@vger.kernel.org>; Tue, 02 May 2023 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683048045; x=1685640045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xwUxHSl9WxBYX8EA+OtIHBIGktuHw8bbETo8ZwlLgw=;
        b=2Th2r05beLRKstRqgsFh8Vvg1TDSxZlv1zBS1P+U7o2IGwmzxIbw+dVnbN+6CP+eYb
         kEPmHx6Id+yViOJXDLtz4UZVDk3x5xmfFi2N7fMwYvlkKLj5fLlcp5Mnfyb+b3EPqkns
         Uhh2iOk/MQe9cKXIWLoGyVV9YcVl8TgcWQiUKdPE9cb+Nu6pYR8TcloSpLW9gf5gmiWZ
         jNEZgN6SDuvFgiPsaFU6LVXtIAdXZLz1YLXxroRnh4W2hSFXbkBUFRIPyXo9gu5eyQfr
         kVLstlwzW3hWXZprM5Y2i9aKruqaIm/ZGYyw0jpLqwtrFBFD9kBYAIaKBuOrKINO+IB+
         MMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048045; x=1685640045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xwUxHSl9WxBYX8EA+OtIHBIGktuHw8bbETo8ZwlLgw=;
        b=ZPD/QLC1F2NbQtBN/dBvyZUD73bRalEJFkiwcUl0oOqD4nM4YUU4Aemb7RxQrwy0k1
         oVFzz5cqq6S1EL2ZB+4rxhE+FC9ChJ7IlgdPnYCl/emoaShiP+Hx5uhXLr3zHEUG2oXv
         MeNCs6PFJorekxTQHaCkJLdi0xZ0wFm+nIszNHO4pM0/I+WyxxD+JncnNkIlY+yQQ2MH
         FVV5IudFAhlcHp00huqvMrLtS6VpuidO3qwFHd49qdpe3DvoNxiaxmLbe3pJ46por0Oh
         Sz4vZsxIRtbJfKOsC2zsEW020/U6seKJSZ99B/oh1/OjiI/bpJNWgPkzilrQcYr7dHQj
         LoTQ==
X-Gm-Message-State: AC+VfDwyL0QMLaRt/3WaUbfxOmGb0Bo77/nsLPJjFBUzsEVtpHlegGon
        LvDw/Fq8dvDW3GEuPMMmU6X76o24D+wkGlf3gWRt6w==
X-Google-Smtp-Source: ACHHUZ5BPCF2CKRubN5VcRAVI0/kbwYSQNoK3HbrxC9x+FXFK6CFt2hDzxdfts5hpjRgfPxX1Rvz7pU7xt5HFFdUGNY=
X-Received: by 2002:a25:2b41:0:b0:b8e:df64:f00f with SMTP id
 r62-20020a252b41000000b00b8edf64f00fmr16154502ybr.34.1683048045445; Tue, 02
 May 2023 10:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230303011346.3342233-1-surenb@google.com> <CAJuCfpHcgu5Cti0t+U=S1C5-0ZgebhxzrOnhDiSu5qCyuq5_Wg@mail.gmail.com>
In-Reply-To: <CAJuCfpHcgu5Cti0t+U=S1C5-0ZgebhxzrOnhDiSu5qCyuq5_Wg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 10:20:34 -0700
Message-ID: <CAJuCfpE_aB6KQZj6A0NTCcv09bJ26L1hECDho3M2OyiNoMfFEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: remove 500ms min window size limitation for triggers
To:     peterz@infradead.org
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 2, 2023 at 5:16=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Thu, Mar 2, 2023 at 5:13=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > Current 500ms min window size for psi triggers limits polling interval
> > to 50ms to prevent polling threads from using too much cpu bandwidth by
> > polling too frequently. However the number of cgroups with triggers is
> > unlimited, so this protection can be defeated by creating multiple
> > cgroups with psi triggers (triggers in each cgroup are served by a sing=
le
> > "psimon" kernel thread).
> > Instead of limiting min polling period, which also limits the latency o=
f
> > psi events, it's better to limit psi trigger creation to authorized use=
rs
> > only, like we do for system-wide psi triggers (/proc/pressure/* files c=
an
> > be written only by processes with CAP_SYS_RESOURCE capability). This al=
so
> > makes access rules for cgroup psi files consistent with system-wide one=
s.
> > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> > remove the psi window min size limitation.
> >
> > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@qu=
icinc.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Forgot to change the --to field from Tejun to PeterZ.
> Peter, just to clarify, this change is targeted for inclusion in your tre=
e.

I think this patch slipped through the cracks. Peter, could you please
take it into your tree?
Thanks,
Suren.

> Thanks!
>
> > ---
> >  kernel/cgroup/cgroup.c | 10 ++++++++++
> >  kernel/sched/psi.c     |  4 +---
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 935e8121b21e..b600a6baaeca 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct kern=
fs_open_file *of,
> >         return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
> >  }
> >
> > +static int cgroup_pressure_open(struct kernfs_open_file *of)
> > +{
> > +       return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESO=
URCE)) ?
> > +               -EPERM : 0;
> > +}
> > +
> >  static void cgroup_pressure_release(struct kernfs_open_file *of)
> >  {
> >         struct cgroup_file_ctx *ctx =3D of->priv;
> > @@ -5266,6 +5272,7 @@ static struct cftype cgroup_psi_files[] =3D {
> >         {
> >                 .name =3D "io.pressure",
> >                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_=
IO]),
> > +               .open =3D cgroup_pressure_open,
> >                 .seq_show =3D cgroup_io_pressure_show,
> >                 .write =3D cgroup_io_pressure_write,
> >                 .poll =3D cgroup_pressure_poll,
> > @@ -5274,6 +5281,7 @@ static struct cftype cgroup_psi_files[] =3D {
> >         {
> >                 .name =3D "memory.pressure",
> >                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_=
MEM]),
> > +               .open =3D cgroup_pressure_open,
> >                 .seq_show =3D cgroup_memory_pressure_show,
> >                 .write =3D cgroup_memory_pressure_write,
> >                 .poll =3D cgroup_pressure_poll,
> > @@ -5282,6 +5290,7 @@ static struct cftype cgroup_psi_files[] =3D {
> >         {
> >                 .name =3D "cpu.pressure",
> >                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_=
CPU]),
> > +               .open =3D cgroup_pressure_open,
> >                 .seq_show =3D cgroup_cpu_pressure_show,
> >                 .write =3D cgroup_cpu_pressure_write,
> >                 .poll =3D cgroup_pressure_poll,
> > @@ -5291,6 +5300,7 @@ static struct cftype cgroup_psi_files[] =3D {
> >         {
> >                 .name =3D "irq.pressure",
> >                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_=
IRQ]),
> > +               .open =3D cgroup_pressure_open,
> >                 .seq_show =3D cgroup_irq_pressure_show,
> >                 .write =3D cgroup_irq_pressure_write,
> >                 .poll =3D cgroup_pressure_poll,
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 02e011cabe91..0945f956bf80 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -160,7 +160,6 @@ __setup("psi=3D", setup_psi);
> >  #define EXP_300s       2034            /* 1/exp(2s/300s) */
> >
> >  /* PSI trigger definitions */
> > -#define WINDOW_MIN_US 500000   /* Min window size is 500ms */
> >  #define WINDOW_MAX_US 10000000 /* Max window size is 10s */
> >  #define UPDATES_PER_WINDOW 10  /* 10 updates per window */
> >
> > @@ -1278,8 +1277,7 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
> >         if (state >=3D PSI_NONIDLE)
> >                 return ERR_PTR(-EINVAL);
> >
> > -       if (window_us < WINDOW_MIN_US ||
> > -               window_us > WINDOW_MAX_US)
> > +       if (window_us =3D=3D 0 || window_us > WINDOW_MAX_US)
> >                 return ERR_PTR(-EINVAL);
> >
> >         /* Check threshold */
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >
