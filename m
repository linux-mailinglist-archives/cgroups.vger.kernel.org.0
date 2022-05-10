Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32286522733
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiEJWuN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 18:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiEJWuM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 18:50:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012124DC50
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 15:50:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dv4so583375qvb.13
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pgf2LC4mfZtxmKKitMud+Oy12RPGcU3F46iHWGsadA=;
        b=ekAQBJLQ0g2H+FUmFV5f70dwdMJlmpMe43UT4QIXA58jzQ7eDTurlQUHhbMjmFXgUn
         iSvHyXVOpjYMsk92HbvRZQl8ByOek4TmP4dutBYmWmysLSp+0lz8VY73TGj93QW0TK/I
         wFDu3nWggMxUUhT25DqnrpkQRHcZyfZQlsTbTl94c/g9RyI7z/yYTSrr78bkYPz4zPE6
         iY4Bp9up41gXopOTZgVvz0svbTi1cJwop5wCmJ5rigsS40iOXz4jYN10Zh1qCwptI9S1
         NrCYR94Zlax6XmK+bd61BAf+16YQeV+dhN2Bpph/aIHzuhFyMVqWf35ODyxRjEeOQHST
         hZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pgf2LC4mfZtxmKKitMud+Oy12RPGcU3F46iHWGsadA=;
        b=TvZR+Oj3Ckczj0dHztbrG5TQPtcBh5a/ACGlP1BrfXVl/oIVZVce5/WTUdXj9SmXNW
         PXEiFJwXE2uH+8sH/hCYLIoyhxmlm2DCyA6jEzd89WHtQvj5n75yrQcLlAucp3jQccjW
         N8ATh7bAFV62GYqZ8p/xlecDs/RLP6OoQdmLqViFVJFTyLsu2Z53DVmDuaVXx3rabu6+
         YcHN0fwv7oF/aQYdTB9ZfwzNBm8USi1jjN6YVkF0GW/lQ/MVngy+TcaRY71sC1rjWq3P
         RsAUdGlvcNs/LLn21nFgWJv2i/ye+FyKAqF5KvoRK00Kb0Pxen72ut/cBuoM/FCmI6oo
         FDiQ==
X-Gm-Message-State: AOAM533S56idIXi0sky9z63PFEnmeis1AJKXvdPvZaoU4zOBKm75PTMZ
        FAAeKjgBHplW3gIxt7wbMf8uM5IfzjDrGJ2fcrmQ5A==
X-Google-Smtp-Source: ABdhPJzAFn9/jIPprW6IL+T0z4v5PPLX/63yNDyYNQ0qdZ3QxvFVYV7PhbjIoCNQF1WFZkNWMTKoVzPSeNUYybVJQSc=
X-Received: by 2002:ad4:4753:0:b0:456:34db:614b with SMTP id
 c19-20020ad44753000000b0045634db614bmr19945189qvx.17.1652223010267; Tue, 10
 May 2022 15:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
 <20220510001807.4132027-9-yosryahmed@google.com> <Ynq04gC1l7C2tx6o@slm.duckdns.org>
 <CA+khW7girnNwap1ABN1a4XuvkEEnmkztTV+fsuC3MsxNeB08Yg@mail.gmail.com> <YnriMPYyOP9ibskc@slm.duckdns.org>
In-Reply-To: <YnriMPYyOP9ibskc@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 10 May 2022 15:49:59 -0700
Message-ID: <CA+khW7gUdZQq77jO2_A6rvE6f+HV=sGfBVGvAmazGPvwudE0RQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 8/9] bpf: Introduce cgroup iter
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org
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

On Tue, May 10, 2022 at 3:07 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 10, 2022 at 02:12:16PM -0700, Hao Luo wrote:
> > > Is there a reason why this can't be a proper iterator which supports
> > > lseek64() to locate a specific cgroup?
> > >
> >
> > There are two reasons:
> >
> > - Bpf_iter assumes no_llseek. I haven't looked closely on why this is
> > so and whether we can add its support.
> >
> > - Second, the name 'iter' in this patch is misleading. What this patch
> > really does is reusing the functionality of dumping in bpf_iter.
> > 'Dumper' is a better name. We want to create one file in bpffs for
> > each cgroup. We are essentially just iterating a set of one single
> > element.
>
> I see. I'm just shooting in the dark without context but at least in
> principle there's no reason why cgroups wouldn't be iterable, so it might be
> something worth at least thinking about before baking in the interface.
>

Yep. Conceptually there should be no problem to iterate cgroups in the
system. It may be better to have two independent bpf objects: bpf_iter
and bpf_dumper. In our use case, we want bpf_dumper, which just
exports data out through fs interface.

Hao
