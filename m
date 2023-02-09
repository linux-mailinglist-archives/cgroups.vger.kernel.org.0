Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D5690DF8
	for <lists+cgroups@lfdr.de>; Thu,  9 Feb 2023 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBIQJD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Feb 2023 11:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIQJC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Feb 2023 11:09:02 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA0330EE;
        Thu,  9 Feb 2023 08:09:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a13so1061806ljq.6;
        Thu, 09 Feb 2023 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZWmpAN7z+mnIIM1VS6ygj9xj2/3VBtdPQMRi1uNDD0=;
        b=IxGLmL0/yJ2qV/iwG4f069e7/09g6UC26Xw5OIymQepANRtD29sTgbDiRe7d36F7R7
         jUywBAcvanvgJmhJrtfUskpENyPLxm3nVY3HxCUO6uS5EK6Ie89bctANX4HvaHLHS8MW
         5ZPD1rP9Q5vl/Y4+B6yo6ArXQp9RpvWSwh1vBpIvs7uVD21eOWhZPLEHcuJcBTKd1rE1
         O4Vmi+OItjh/5qnPZcVqZtwvq9J7L18CCc7FthYdoTBkv8ewHUVHSPn74wRA6fW5pOEE
         TH24O7smcRvp2NtYoFnvFNdhFWyPklRnGXVIXijQg8SuRYGIpQCcVTHcUYbxcDQ1HXFF
         TnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZWmpAN7z+mnIIM1VS6ygj9xj2/3VBtdPQMRi1uNDD0=;
        b=jeSy369HHld24ifb5fuZTYOEOTuWZLRTHwlGNp1cDB12UfJKPSFQGGlidbhSBBp6Gg
         TxHAo/M+zDrnQhWs7o3DSgV1wG9e1AHE0DUCJDKEDXWOeh2HUBDIGWKAULVpfmzcKvhG
         ZyvNLn6jBDrr3w+g2lIGs9Xiep8EkorgdesF0wJKh9zWlC5poIoBB5jcsT91fIHYwNDN
         aK0TOJ9wq49k7Lz0JpQhxt5sFmyr/DfqUrOE8ujPbkBo4Gr8qdNfB+m2vKDapzXCjVvp
         TaqlnVpVH7nS4koDv3V9t5l8cbuvc/tpfBDYNcb1Yl1xv26Xxd/J5Gsw8MGOfVkt66bj
         kn1Q==
X-Gm-Message-State: AO0yUKVPRKenIBjblPmT3bY9jDL6eeosl0L3bA0B3dVxbkg8335e0usb
        AR8bPPaZvSO7eWzpEA3Xsto52tc2wd8ginteVzQDachWMddWVcC2
X-Google-Smtp-Source: AK7set+/Y+dwSm2KywkOQdEjmr/lHmv7PUzWUUwMUVqxw6FZ1HOyiT2uOdWtJTunIctCIsOG31ZgFPe4BfKhoa5smqQ=
X-Received: by 2002:a05:651c:2c9:b0:287:4eeb:53dc with SMTP id
 f9-20020a05651c02c900b002874eeb53dcmr2083592ljo.27.1675958939757; Thu, 09 Feb
 2023 08:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20230208161654.99556-1-ryncsn@gmail.com> <20230208161654.99556-3-ryncsn@gmail.com>
 <20230208172956.GF24523@blackbody.suse.cz> <Y+P17OVZZWVpYIb0@cmpxchg.org>
In-Reply-To: <Y+P17OVZZWVpYIb0@cmpxchg.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 10 Feb 2023 00:08:40 +0800
Message-ID: <CAMgjq7Bem+8g8A_OR26PHhYYx-A7LHHO3tyQNR_tMnaaKNxkug@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=9B=9B 03:20=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Feb 08, 2023 at 06:29:56PM +0100, Michal Koutn=C3=BD wrote:
> > On Thu, Feb 09, 2023 at 12:16:54AM +0800, Kairui Song <ryncsn@gmail.com=
> wrote:
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > Signed-off-by: Kairui Song <ryncsn@gmail.com>
> >
> > Typo?
> >
> > > -static inline struct psi_group *task_psi_group(struct task_struct *t=
ask)
> > > +static inline struct psi_group *psi_iter_first(struct task_struct *t=
ask, void **iter)
> > >  {
> > >  #ifdef CONFIG_CGROUPS
> > > -   if (static_branch_likely(&psi_cgroups_enabled))
> > > -           return cgroup_psi(task_dfl_cgroup(task));
> > > +   if (static_branch_likely(&psi_cgroups_enabled)) {
> > > +           struct cgroup *cgroup =3D task_dfl_cgroup(task);
> > > +
> > > +           *iter =3D cgroup_parent(cgroup);
> >
> > This seems to skip a cgroup level -- maybe that's the observed
> > performance gain?
>
> Hm, I don't think it does. It sets up *iter to point to the parent for
> the _next() call, but it returns task_dfl_cgroup()->psi. The next call
> does the same: cgroup =3D *iter, *iter =3D parent, return cgroup->psi.
>
> It could be a bit more readable to have *iter always point to the
> current cgroup - but no strong preference either way from me:
>
> psi_groups_first(task, iter)
> {
> #ifdef CONFIG_CGROUPS
>         if (static_branch_likely(&psi_cgroups_enabled)) {
>                 struct cgroup *cgroup =3D task_dfl_cgroup(task);
>
>                 *iter =3D cgroup;
>                 return cgroup_psi(cgroup);
>         }
> #endif
>         return &psi_system;
> }
>
> psi_groups_next(iter)
> {
> #ifdef CONFIG_CGROUPS
>         if (static_branch_likely(&psi_cgroups_enabled)) {
>                 struct cgroup *cgroup =3D *iter;
>
>                 if (cgroup) {
>                         *iter =3D cgroup_parent(cgroup);
>                         return cgroup_psi(cgroup);
>                 }
>         }
>         return NULL;
> #endif
> }
> psi_groups_next(iter)
> {
> #ifdef CONFIG_CGROUPS
>         if (static_branch_likely(&psi_cgroups_enabled)) {
>                 struct cgroup *cgroup =3D *iter;
>
>                 if (cgroup) {
>                         *iter =3D cgroup_parent(cgroup);
>                         return cgroup_psi(cgroup);
>                 }
>         }
>         return NULL;
> #endif
> }

It should be like this, right? For psi_groups_next, retrieving cgroup
parent should be done before "if (cgroup)".
+ psi_groups_next(iter)
+ {
+ #ifdef CONFIG_CGROUPS
+         if (static_branch_likely(&psi_cgroups_enabled)) {
+                 struct cgroup *cgroup =3D *iter;
+
+                 cgroup =3D cgroup_parent(cgroup);
+                 if (cgroup) {
+                         *iter =3D cgroup;
+                         return cgroup_psi(cgroup);
+                 }
+         }
+         return NULL;
+ #endif
+ }

Thanks for the suggestion!

I think your style is better indeed.

I tried to re-benchmark the code just in case, and found it seems my
previous benchmark result is not accurate enough now, some results
changed after I did a rebase to latest master, or maybe just 100 times
of perfpipe is not enough to get a stable result.

With a few times of retest, the final conclusion of the commit message
is still valid, will post V2 later just after more test.
