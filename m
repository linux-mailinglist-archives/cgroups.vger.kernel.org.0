Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA11C6A8521
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 16:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCBPal (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 10:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCBPaV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 10:30:21 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF039113F1
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 07:30:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id nf5so11882745qvb.5
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1677771018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MLSfo+hz5vTJ5ohI3IndEOkVuqNdnrD+B9QuUnbZ7t0=;
        b=Yuc3GjL5Ae3STASZNhGMCqtIxArcAh5Wnnbvn4E9b8+BMSkHR1RoivucbdqQ/fcWMb
         pUqUgMFarQvdmGoZEOycuK8epRhiUmc3k8itieZ6PwaIla/rlWd8hVJjACl/b3oqemuw
         7JN1JLE/p0Jd9o/WpjBcsFZ9qAJ2kAZ0XvvIW28lUpEwsJgluteqYbfF0IDigG6MlJfI
         KbHP+F86TOuVcoSsouz+IUw9UwdSOg5N3LugwO1HlldQl2spyTX/dh5e5grSMQOhdIrq
         XnvvCM7U4ynFjeQLWUvR3t0P/dTBiWq7LQN6dRssMQtt5fGIJ5psvko5kv1o0ITqDoGt
         slJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677771018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLSfo+hz5vTJ5ohI3IndEOkVuqNdnrD+B9QuUnbZ7t0=;
        b=kOdU1YkVwKZ6rMkAUh2h/ExdZHcxMKIcoWZ+ZiS/0eB2+oYQcF3HZyGAzWaG3VgI4D
         AgZsvXJW0P7HYZ/NQtRdTBWYSLvsJICZiBAjdWHsGXzhV8TCzgEQyouHXl6OkBrgah8Y
         DLiXJOzAQmYoZZQkpAz5/svM/LjjewopM+80PkgHASQ2GGMtxgSBTy3h4fkOGogRo413
         aMwB9xyyLMh3IPP2Xnc+VdxjXzsSLIKnHNJ+ZU59dtoSTbOjcyV/9Lh/kdXITbo00Vm+
         kUbd33S//DfNQpVAeUuI2jGzvzVDzBylGE589TplqiCc8zoTx6wZcl5/8WOcflzZuJwk
         jG2w==
X-Gm-Message-State: AO0yUKX38ZnsAN6/ZF/0S0EbNIHjzN1rv/HTSb/dTGjPD2j9OYKjGXUE
        kATRky7y1YJzFekz98y4GWfKRA==
X-Google-Smtp-Source: AK7set8Zi94EO/G0MiD2tk0zJB/YMF0sCaWg4Nr73waCi4EUvedOqA7UJ9O/l9aYTW8lBwtkvGMozw==
X-Received: by 2002:a05:6214:e8f:b0:537:7061:89d7 with SMTP id hf15-20020a0562140e8f00b00537706189d7mr19950984qvb.40.1677771018035;
        Thu, 02 Mar 2023 07:30:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:19d])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b006fa16fe93bbsm11111379qkm.15.2023.03.02.07.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 07:30:17 -0800 (PST)
Date:   Thu, 2 Mar 2023 10:30:16 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, peterz@infradead.org,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for
 triggers
Message-ID: <ZADBCEk68W1aGJAV@cmpxchg.org>
References: <20230301193403.1507484-1-surenb@google.com>
 <Y/+wlg5L8A1iebya@cmpxchg.org>
 <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 01, 2023 at 12:48:38PM -0800, Suren Baghdasaryan wrote:
> On Wed, Mar 1, 2023 at 12:07 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Mar 01, 2023 at 11:34:03AM -0800, Suren Baghdasaryan wrote:
> > > Current 500ms min window size for psi triggers limits polling interval
> > > to 50ms to prevent polling threads from using too much cpu bandwidth by
> > > polling too frequently. However the number of cgroups with triggers is
> > > unlimited, so this protection can be defeated by creating multiple
> > > cgroups with psi triggers (triggers in each cgroup are served by a single
> > > "psimon" kernel thread).
> > > Instead of limiting min polling period, which also limits the latency of
> > > psi events, it's better to limit psi trigger creation to authorized users
> > > only, like we do for system-wide psi triggers (/proc/pressure/* files can
> > > be written only by processes with CAP_SYS_RESOURCE capability). This also
> > > makes access rules for cgroup psi files consistent with system-wide ones.
> > > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> > > remove the psi window min size limitation.
> > >
> > > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quicinc.com/
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  kernel/cgroup/cgroup.c | 10 ++++++++++
> > >  kernel/sched/psi.c     |  4 +---
> > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > index 935e8121b21e..b600a6baaeca 100644
> > > --- a/kernel/cgroup/cgroup.c
> > > +++ b/kernel/cgroup/cgroup.c
> > > @@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
> > >       return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
> > >  }
> > >
> > > +static int cgroup_pressure_open(struct kernfs_open_file *of)
> > > +{
> > > +     return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE)) ?
> > > +             -EPERM : 0;
> > > +}
> >
> > I agree with the change, but it's a bit unfortunate that this check is
> > duplicated between system and cgroup.
> >
> > What do you think about psi_trigger_create() taking the file and
> > checking FMODE_WRITE and CAP_SYS_RESOURCE against file->f_cred?
> 
> That's definitely doable and we don't even need to pass file to
> psi_trigger_create() since it's called only when we write to the file.
> However by moving the capability check into psi_trigger_create() we
> also postpone the check until write() instead of failing early in
> open(). I always assumed failing early is preferable but if
> consolidating the code here makes more sense then I can make the
> switch. Please let me know if you still prefer to move the check.

Just for context, a person on our team is working on allowing
unprivileged polls with windows that are multiples of 2s, which can be
triggered from the regular aggregator threads. This should be useful
for container delegation, and also for the desktop monitor app usecase
that Chris Down brought up some time ago. At that point, everybody can
open the file for write, and permissions are checked against the
trigger parameters.

So I don't think it's a big deal to check this particular permission
at write time. But if you prefer we can also merge your patch as-is
and do the refactor as part of the other series.

Your call. In either case, please feel free to add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
