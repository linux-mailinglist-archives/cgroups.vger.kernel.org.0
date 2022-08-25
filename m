Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A413D5A0554
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiHYAsu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHYAss (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 20:48:48 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422AF915C1
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 17:48:47 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j17so14113268qtp.12
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=q79ck/AetSOthZ6hFpX5t7QfBKfX7F+uUXc0H4h3law=;
        b=I1ZnPe5OrWyp6LVENTFATmozgLZ7ZkdmjybmuFrk1V4XML5gtlNtieEL2obZoXMgxX
         nerAmkVQg+eYBWB2U5NJulY/1iBr5Q21ukGu4Hr8K9JSuY+Es3p3unZMzUkvu5l7rwJC
         xJ+/8z31Gi4kJn+b/JWcy03XRR6tNpcNLoDc1O75HphHnSS01Lk2S3oGcvZVQyMYgrl0
         sW128SgJU2S0XgP9IrMdPIG9z497lkzKQ3NHZ1nokrc0hYaq3jVlRDf1LRbsxNTKjUpS
         DkkhpmDCsWUWwc/R3khgTuCovLvcCLxc5dqI5B50DqL740oIgIjgWjcIfsOo1A0UoRIp
         0NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=q79ck/AetSOthZ6hFpX5t7QfBKfX7F+uUXc0H4h3law=;
        b=T+BQS0CpavM5/zeKztvobAmvGCowG8WfqEH3IgKaH0GYwJ1UjDp3x2XJfsltRtSvzY
         5iMPmEI6JwpVYuqoV1aQGKk2mR8170LuF7qHVlLblTdm0So2KSqZc0V/LVCuQCfGVuPo
         IxRSCiTHxiD0Lcq0QJ5rw6r2DmRMYXG4yMiDQGxKwvZqcCGatgUfo5jk2rv9ESGVozWe
         L6xJcJ/3nuAOJ8AFOwZTFUkTASiEe1RGeG6vD6241XMoNTCLERzS9Sp2Ohee97Diwiz9
         KJc3pm9SYPBjfV/9zghPX3t7t0GobM5k6/Z+vG6YWppTpvaVRQFZQD2O68bsSdt9ffxZ
         9kjQ==
X-Gm-Message-State: ACgBeo0wHCmPW8Mx+vA9MDwVsRYyAEDMkma3mT2JuJcuKR0x8SzIohVK
        caZ5BXBLUzh6T9RnGsMLp0KkqpALJUWuxakILP2ISg==
X-Google-Smtp-Source: AA6agR7N8cvbqqiOqWHk04hMyYDErfgVTBgYt4gHkcwIdZocFD/VS29vZ/4h/085kacWnmwNXvjidJc4qHeqgE3clj0=
X-Received: by 2002:a05:622a:552:b0:342:f8c2:442 with SMTP id
 m18-20020a05622a055200b00342f8c20442mr1729734qtx.478.1661388526277; Wed, 24
 Aug 2022 17:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220824233117.1312810-1-haoluo@google.com> <CAADnVQLT3JE8LtOYrs30mL88PNs+NaSeXgQqAPEAup5LUC+BPQ@mail.gmail.com>
 <CA+khW7gQi+BK7Qy4Khk=Ro72nfNQaR2kNkwZemB9ELnDo4Nk3Q@mail.gmail.com> <CAADnVQKJDoE3Krn4TEwubJ0Us-QA5cE4oyZ3G2g2MiRMDn3=Cw@mail.gmail.com>
In-Reply-To: <CAADnVQKJDoE3Krn4TEwubJ0Us-QA5cE4oyZ3G2g2MiRMDn3=Cw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 24 Aug 2022 17:48:35 -0700
Message-ID: <CA+khW7gzV5DyNaAdpYWApVnTe4B=5JFW_EbnmYqRAye4MmdCvw@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v9 0/5] bpf: rstat: cgroup hierarchical
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 24, 2022 at 5:47 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 24, 2022 at 5:42 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Wed, Aug 24, 2022 at 5:29 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Aug 24, 2022 at 4:31 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > This patch series allows for using bpf to collect hierarchical cgroup
> > > > stats efficiently by integrating with the rstat framework. The rstat
> > > > framework provides an efficient way to collect cgroup stats percpu and
> > > > propagate them through the cgroup hierarchy.
> > > >
> > > > The stats are exposed to userspace in textual form by reading files in
> > > > bpffs, similar to cgroupfs stats by using a cgroup_iter program.
> > > > cgroup_iter is a type of bpf_iter. It walks over cgroups in four modes:
> > > > - walking a cgroup's descendants in pre-order.
> > > > - walking a cgroup's descendants in post-order.
> > > > - walking a cgroup's ancestors.
> > > > - process only a single object.
> > > >
> > > > When attaching cgroup_iter, one needs to set a cgroup to the iter_link
> > > > created from attaching. This cgroup can be passed either as a file
> > > > descriptor or a cgroup id. That cgroup serves as the starting point of
> > > > the walk.
> > > >
> > > > One can also terminate the walk early by returning 1 from the iter
> > > > program.
> > > >
> > > > Note that because walking cgroup hierarchy holds cgroup_mutex, the iter
> > > > program is called with cgroup_mutex held.
> > > >
> > > > ** Background on rstat for stats collection **
> > > > (I am using a subscriber analogy that is not commonly used)
> > > >
> > > > The rstat framework maintains a tree of cgroups that have updates and
> > > > which cpus have updates. A subscriber to the rstat framework maintains
> > > > their own stats. The framework is used to tell the subscriber when
> > > > and what to flush, for the most efficient stats propagation. The
> > > > workflow is as follows:
> > > >
> > > > - When a subscriber updates a cgroup on a cpu, it informs the rstat
> > > >   framework by calling cgroup_rstat_updated(cgrp, cpu).
> > > >
> > > > - When a subscriber wants to read some stats for a cgroup, it asks
> > > >   the rstat framework to initiate a stats flush (propagation) by calling
> > > >   cgroup_rstat_flush(cgrp).
> > > >
> > > > - When the rstat framework initiates a flush, it makes callbacks to
> > > >   subscribers to aggregate stats on cpus that have updates, and
> > > >   propagate updates to their parent.
> > > >
> > > > Currently, the main subscribers to the rstat framework are cgroup
> > > > subsystems (e.g. memory, block). This patch series allow bpf programs to
> > > > become subscribers as well.
> > > >
> > > > Patches in this series are organized as follows:
> > > > * Patches 1-2 introduce cgroup_iter prog, and a selftest.
> > > > * Patches 3-5 allow bpf programs to integrate with rstat by adding the
> > > >   necessary hook points and kfunc. A comprehensive selftest that
> > > >   demonstrates the entire workflow for using bpf and rstat to
> > > >   efficiently collect and output cgroup stats is added.
> > > >
> > > > ---
> > > > Changelog:
> > > > v8 -> v9:
> > > > - Make UNSPEC (an invalid option) as the default order for cgroup_iter.
> > > > - Use enum for specifying cgroup_iter order, instead of u32.
> > > > - Add BPF_ITER_RESHCED to cgroup_iter.
> > > > - Add cgroup_hierarchical_stats to s390x denylist.
> > >
> > > What 'RESEND' is for?
> > > It seems to confuse patchwork and BPF CI.
> > >
> > > The v9 series made it to patchwork...
> > >
> > > Please just bump the version to v10 next time.
> > > Don't add things to subject, since automation cannot recognize
> > > that yet.
> >
> > Sorry about that. I thought it was RESEND because no content has
> > changed. It was just adding an entry in s390 denylist.
> >
> > Are we good now? Or I need to send a v10?
>
> No need. Assuming that 'RESEND' version will be green in CI.

Sounds good. I will monitor the CI. :)
