Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B77B3920
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjI2Rsr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjI2Rsq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 13:48:46 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399919F;
        Fri, 29 Sep 2023 10:48:44 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35135b79b6aso31716275ab.0;
        Fri, 29 Sep 2023 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696009724; x=1696614524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE4uVI3BgG9zhaccv2sl/DHhY85ABFNODKczcla6bgo=;
        b=bnmSA6BQ4m8TkJSEILAOzLH05/yY4DQ6IGwPB9rOKyVTJiJ3euEPUjGjke4/lDcWwq
         1QQLovN499kWqexehRw5y2LawfrBMYi/1+tGeJGqP+qmnsSp9/LSsqgplKTcRIX4w1qo
         iTGGUB4dvKM/Q4T+bX0z2BfjZrZBBGT1CO4rlVgyYoYgGFGb1WlpYLII8qpm+8QPoYwm
         Gp6OGo0OjnhAREbg4afI8wTEWJ5EYJwCqa8qXaFBvqP6r7YfnAi0mi7s4Pc2UQrhZnDk
         dgUN82kKuAsLFJNwX+Nk6zCOvlyKusysdAtLDcXmqWUT1d1MNrdEgJ626Ygir1zFsAAD
         2OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009724; x=1696614524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE4uVI3BgG9zhaccv2sl/DHhY85ABFNODKczcla6bgo=;
        b=WNjpprozrEek399y6CO6TnsjbAJPZJpBHkafDEpvN+jbi2Nsbavm/3KWKr0rZPecnk
         EvgdiqQTVaQhhWHpepoE8ELtaohoLk4W9aExdqvgRysoLIzQBEteQLcu95sszpmZslVA
         4oUFfsLjv3dsCeEbrQ7g1JjOxRnBbnFAtM3Hb7zbyc++ZozB1d0Wf8dEe7Xd4j8yusfY
         H2+c9pRhoOgCG1DMZ7dIzcDX6k8sR7BwJraWwandDn79CzRofQIO6RppAZTtbSscOnZz
         dip+0+rmHofDl7Nlf88K7IA1tv0zTSqLtEZsRAof35/P8G4c5jUKsuPAEdCD6y5IolEb
         dyow==
X-Gm-Message-State: AOJu0Yw6P6hOB2s9TKWvrj2HIELNQQbA2DmcLYIelBIzQssoLU9hmqEE
        4NmQBjZXBcg2Bpdr/mXIafQcAMACsp/gfSpeQ+8=
X-Google-Smtp-Source: AGHT+IEhqZ+p7B4KM5qyJEESBUsjjfb2MGo1JYjvDfMezIKUQkuNF20l8RYkYSMPzg74+dV07rOI+zTF6I55TzeFrUY=
X-Received: by 2002:a05:6e02:2166:b0:34f:bed6:60d4 with SMTP id
 s6-20020a056e02216600b0034fbed660d4mr6191320ilv.10.1696009724140; Fri, 29 Sep
 2023 10:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
 <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
 <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
 <CAJD7tkaeDBTHC3UM91O56yrp8oCU-UBO6i_5HJMjVBDQAw0ipQ@mail.gmail.com>
 <20230929150829.GA16353@cmpxchg.org> <CAJD7tkZ1NiMMvQhxGSGzsPqYfBpwzP6svPe17s2FTDoHY6jYWQ@mail.gmail.com>
 <20230929174221.GA19137@cmpxchg.org>
In-Reply-To: <20230929174221.GA19137@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 29 Sep 2023 10:48:33 -0700
Message-ID: <CAKEwX=NJ2oGvmbVnvhP+XsqHrdgoP6HW-vsEQDWjjhhy_d6Xbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 29, 2023 at 10:42=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, Sep 29, 2023 at 08:11:54AM -0700, Yosry Ahmed wrote:
> > On Fri, Sep 29, 2023 at 8:08=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Thu, Sep 28, 2023 at 06:18:19PM -0700, Yosry Ahmed wrote:
> > > > My concern is the scenario where the memory controller is mounted i=
n
> > > > cgroup v1, and cgroup v2 is mounted with memory_hugetlb_accounting.
> > > >
> > > > In this case it seems like the current code will only check whether
> > > > memory_hugetlb_accounting was set on cgroup v2 or not, disregarding
> > > > the fact that cgroup v1 did not enable hugetlb accounting.
> > > >
> > > > I obviously prefer that any features are also added to cgroup v1,
> > > > because we still didn't make it to cgroup v2, especially when the
> > > > infrastructure is shared. On the other hand, I am pretty sure the
> > > > maintainers will not like what I am saying :)
> > >
> > > I have a weak preference.
> > >
> > > It's definitely a little weird that the v1 controller's behavior
> > > changes based on the v2 mount flag. And that if you want it as an
> > > otherwise exclusive v1 user, you'd have to mount a dummy v2.
> > >
> > > But I also don't see a scenario where it would hurt, or where there
> > > would be an unresolvable conflict between v1 and v2 in expressing
> > > desired behavior, since the memory controller is exclusive to one.
> > >
> > > While we could eliminate this quirk with a simple
> > > !cgroup_subsys_on_dfl(memory_cgrp_subsys) inside the charge function,
> > > it would seem almost punitive to add extra code just to take somethin=
g
> > > away that isn't really a problem and could be useful to some people.
> > >
> > > If Tejun doesn't object, I'd say let's just keep implied v1 behavior.
> >
> > I agree that adding extra code to take a feature away from v1 is
> > probably too much, but I also think relying on a v2 mount option is
> > weird. Would it be too much to just have a v1-specific flag as well
> > and use cgroup_subsys_on_dfl(memory_cgrp_subsys) to decide which flag
> > to read?
>
> Yeah, let's not preemptively add explicit new features to cgroup1.
>
> Since we agree the incidental support is weird, let's filter hugetlb
> charging on cgroup_subsys_on_dfl(memory_cgrp_subsys) after all. If
> somebody wants this for v1 - and it doesn't sound like Google is even
> in that category according to Frank - they should send a separate
> patch and we can go through all the reasons why switching to v2 is not
> an option for them.

My gut reaction when I became aware of this is to just eliminate it with
!cgroup_subsys_on_dfl(memory_cgrp_subsys) too :)

Yeah, let's just keep it simple + safe and disable it on cgroupv1 for now.
We can have this conversation again later in the future when someone
wants this in v1 (and yes, this conversation should include the option
of moving to v2).

Consider it yet another incentive to migrate to cgroupv2 ;)
