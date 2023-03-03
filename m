Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203F56A8E91
	for <lists+cgroups@lfdr.de>; Fri,  3 Mar 2023 02:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCCBQq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 20:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCCBQq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 20:16:46 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE71ACC5
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 17:16:45 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536be69eadfso15923597b3.1
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 17:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677806204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnHArXpnIln4mR9B6GQIrF77J/3Fo4zMukNf/BHzahY=;
        b=RHZ/5e8m9fy3BrS8H8EuZi/rzgU5IOzlIA8zeJ5GS+PM41zVTymZSYbmzfQmb6OvVl
         XbYMzhWI2XYBouWUFdAi3S9YuNgZK4dQ1pMEbzVemOlITarcYhDbrAvpvUNLOmNO0uNb
         nSN08VzpIdhLwlFCfmEhEXARu67/KiCdyKcZSIchfC/ToxDkZAJw/Y8hlcpRiWPmdpYo
         UOZ5Ki7t/dMFspouEbW3kmRb+c1YsfQu1ym8WzCEiHGbwjfUFG1ZEmhkWkGcbRH78lrw
         I+jlQIAUVSmtMxCjT2ToCcbJlQoCCnkSOQIyYGh5aqimOH1BKDiZMWJk9SIIbMS4ANiY
         SU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677806204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnHArXpnIln4mR9B6GQIrF77J/3Fo4zMukNf/BHzahY=;
        b=KSG83Ap1EPfiEkTyw0bEmROJUO+CjoLeJKp4Ym7eJrtPni09q/prWW4Oa/VFI9gvk4
         LXWHp7zlTAE07Z5ZPxCT7y1QEfyBMI8+W2BDchG0SSl7slWcKlNLskRvJy8+q8cZdQPq
         R0ihSD/6g632ojhy08X/g8Zpdq7HsAG0dCRB68xp7bsoHa/0ek7waSI012SjoFzVt9G0
         7l1pQQ8ZIIil1R2KcK3GwrjO0F3k+p644xsYo0OURZV/aPIi8wiQWnSEojA0nE270V1S
         0yKqStqInd6u8eyJ/7fVkqmruK+TGsSxoRNjNlCJshKuEDcThhFU518izVIC6945xPV+
         mgxQ==
X-Gm-Message-State: AO0yUKWyagd6QkkAVJ58bkn4hqM8tVYbgado901i/xYdQPzdZB6oPoSE
        rKZEIX0D2FcKHvssgQrWY6GnfyT5O2OxdF4pusbucQ==
X-Google-Smtp-Source: AK7set8gB5DbIJ+gLG4zNATh0e4toIdpQr8pDGSph9LTbZyyG9xVSqP7QGYXQGpSjbV8FZuCQlxxqO+eS0dALZFgTVU=
X-Received: by 2002:a81:af52:0:b0:533:9d49:f9c9 with SMTP id
 x18-20020a81af52000000b005339d49f9c9mr7715100ywj.0.1677806204010; Thu, 02 Mar
 2023 17:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20230303011346.3342233-1-surenb@google.com>
In-Reply-To: <20230303011346.3342233-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 2 Mar 2023 17:16:33 -0800
Message-ID: <CAJuCfpHcgu5Cti0t+U=S1C5-0ZgebhxzrOnhDiSu5qCyuq5_Wg@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 2, 2023 at 5:13=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> Current 500ms min window size for psi triggers limits polling interval
> to 50ms to prevent polling threads from using too much cpu bandwidth by
> polling too frequently. However the number of cgroups with triggers is
> unlimited, so this protection can be defeated by creating multiple
> cgroups with psi triggers (triggers in each cgroup are served by a single
> "psimon" kernel thread).
> Instead of limiting min polling period, which also limits the latency of
> psi events, it's better to limit psi trigger creation to authorized users
> only, like we do for system-wide psi triggers (/proc/pressure/* files can
> be written only by processes with CAP_SYS_RESOURCE capability). This also
> makes access rules for cgroup psi files consistent with system-wide ones.
> Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> remove the psi window min size limitation.
>
> Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quic=
inc.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Forgot to change the --to field from Tejun to PeterZ.
Peter, just to clarify, this change is targeted for inclusion in your tree.
Thanks!

> ---
>  kernel/cgroup/cgroup.c | 10 ++++++++++
>  kernel/sched/psi.c     |  4 +---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 935e8121b21e..b600a6baaeca 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct kernfs=
_open_file *of,
>         return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
>  }
>
> +static int cgroup_pressure_open(struct kernfs_open_file *of)
> +{
> +       return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOUR=
CE)) ?
> +               -EPERM : 0;
> +}
> +
>  static void cgroup_pressure_release(struct kernfs_open_file *of)
>  {
>         struct cgroup_file_ctx *ctx =3D of->priv;
> @@ -5266,6 +5272,7 @@ static struct cftype cgroup_psi_files[] =3D {
>         {
>                 .name =3D "io.pressure",
>                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_IO=
]),
> +               .open =3D cgroup_pressure_open,
>                 .seq_show =3D cgroup_io_pressure_show,
>                 .write =3D cgroup_io_pressure_write,
>                 .poll =3D cgroup_pressure_poll,
> @@ -5274,6 +5281,7 @@ static struct cftype cgroup_psi_files[] =3D {
>         {
>                 .name =3D "memory.pressure",
>                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_ME=
M]),
> +               .open =3D cgroup_pressure_open,
>                 .seq_show =3D cgroup_memory_pressure_show,
>                 .write =3D cgroup_memory_pressure_write,
>                 .poll =3D cgroup_pressure_poll,
> @@ -5282,6 +5290,7 @@ static struct cftype cgroup_psi_files[] =3D {
>         {
>                 .name =3D "cpu.pressure",
>                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_CP=
U]),
> +               .open =3D cgroup_pressure_open,
>                 .seq_show =3D cgroup_cpu_pressure_show,
>                 .write =3D cgroup_cpu_pressure_write,
>                 .poll =3D cgroup_pressure_poll,
> @@ -5291,6 +5300,7 @@ static struct cftype cgroup_psi_files[] =3D {
>         {
>                 .name =3D "irq.pressure",
>                 .file_offset =3D offsetof(struct cgroup, psi_files[PSI_IR=
Q]),
> +               .open =3D cgroup_pressure_open,
>                 .seq_show =3D cgroup_irq_pressure_show,
>                 .write =3D cgroup_irq_pressure_write,
>                 .poll =3D cgroup_pressure_poll,
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 02e011cabe91..0945f956bf80 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -160,7 +160,6 @@ __setup("psi=3D", setup_psi);
>  #define EXP_300s       2034            /* 1/exp(2s/300s) */
>
>  /* PSI trigger definitions */
> -#define WINDOW_MIN_US 500000   /* Min window size is 500ms */
>  #define WINDOW_MAX_US 10000000 /* Max window size is 10s */
>  #define UPDATES_PER_WINDOW 10  /* 10 updates per window */
>
> @@ -1278,8 +1277,7 @@ struct psi_trigger *psi_trigger_create(struct psi_g=
roup *group,
>         if (state >=3D PSI_NONIDLE)
>                 return ERR_PTR(-EINVAL);
>
> -       if (window_us < WINDOW_MIN_US ||
> -               window_us > WINDOW_MAX_US)
> +       if (window_us =3D=3D 0 || window_us > WINDOW_MAX_US)
>                 return ERR_PTR(-EINVAL);
>
>         /* Check threshold */
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
