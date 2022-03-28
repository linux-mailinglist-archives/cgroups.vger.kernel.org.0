Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC44E90EE
	for <lists+cgroups@lfdr.de>; Mon, 28 Mar 2022 11:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiC1JTK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Mar 2022 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiC1JTK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Mar 2022 05:19:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8A40917
        for <cgroups@vger.kernel.org>; Mon, 28 Mar 2022 02:17:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u22so12035870pfg.6
        for <cgroups@vger.kernel.org>; Mon, 28 Mar 2022 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpQSKtdwNb3KC+dlFVYdgCuQmYu2WXrTtlnYf3fe1l8=;
        b=YCsQDYTMhVfFS4jUgjugN+EKYW2QiI11NiiFh/w4yzJf8k0v+rR+WcwnSZ1DS/RnKP
         7GkAeIFgVSZcYgH9yYPcRw1VQuH8wf6MSjnx31JR4bmwVt+N7EG5ssSn4iorRC9/5TaF
         nVsY1CNVZUcfifMRRoRcBAgXAK1dhD0FLbwGOFlGr87RFvJKSgpyNaYT4XugCWPs+KJz
         S/R7pigyNxrGJ5jGrhVrThjkD5V1lkqRGQBw1/u2heG1ewyU/y1jUYJKmHbLeE1QGjTI
         MJGui/dwhfeQX32BFZ3xZCjFv+eXoBGlci9kCOx5YWMJxIy/5mPiJFYPZyEUXdgaDDvU
         weKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpQSKtdwNb3KC+dlFVYdgCuQmYu2WXrTtlnYf3fe1l8=;
        b=sJKF+ngktMF7vVxvnPHMS+WW+xt35jPWxXNjBJl5xs42aCmhhnzWhcMQVjBadWRZc8
         VD0rxQ8MsGrmgIeSBdioM4kzLjKftjMTO2ajRAn2216mVHWXL21LtEnXBMITyIweofbd
         ifkKQrmyrp5uTH9dmFtzsK8IWoG7ZGqVY+Gl8kXQh2ZtYWoS3/1bfGBObyM5CUnWV1kE
         +m1ob+57E+gVRqT96E6yrY8hDkZyAcC8uaFq6upHcvUYUWnEiI8i0HmaC9fvXdRpD7ku
         cdiqtgp/h3ecwgunzUY3QstfoBL+8mFY7vXuIIDOqDbgN8nPLrQjI9GyY19+Yuv6sG6U
         xcCQ==
X-Gm-Message-State: AOAM530mmrvCIy7qASDt27+g9Q7oKhKwQws42670YsPWCB4qm+lrbWoW
        ZCq1TtnWWKxRA/x4WxVeeqNLE7ZGqP1gJp2HNW4QnA==
X-Google-Smtp-Source: ABdhPJzNClzlxXy6do9tw7mpbWwP81WKjZPm+SVTHWOuMA+zQGyhRfvPYFLJ2ILCrxR0H8E1lbcgYU2wYHB9QGa6xK4=
X-Received: by 2002:a05:6a00:a0f:b0:4e1:309:83c0 with SMTP id
 p15-20020a056a000a0f00b004e1030983c0mr22567091pfh.68.1648459049579; Mon, 28
 Mar 2022 02:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <CAPhsuW6QTaCVekkT8Ah0N2K4JY7yiiO2wZjk6pVKuraEqjkoXQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6QTaCVekkT8Ah0N2K4JY7yiiO2wZjk6pVKuraEqjkoXQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 28 Mar 2022 02:16:53 -0700
Message-ID: <CAJD7tkaS0k9TVvsDDKP1XCahJ1TyJeSyRHGSM+NZygFwMD=wzQ@mail.gmail.com>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Song Liu <song@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Mar 18, 2022 at 12:59 PM Song Liu <song@kernel.org> wrote:
>
> On Wed, Mar 9, 2022 at 12:27 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Hey everyone,
> >
> > I would like to discuss an idea to facilitate collection of
> > hierarchical cgroup stats using BPF programs. We want to provide a
> > simple interface for BPF programs to collect hierarchical cgroup stats
> > and integrate with the existing rstat aggregation mechanism in the
> > kernel. The most prominent use case is the ability to extend memcg
> > stats (and histograms) by BPF programs.
> >
>
> + Namhyung,
>
> I forgot to mention this in the office hour. The aggregation efficiency
> problem is actually similar to Namhyung's work to use BPF programs
> to aggregate perf counters. Check:
>      tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
>
> Namhyung's solution is to walk up the cgroup tree on cgroup switch
> events. This may not be as efficient as rstat flush logic, but I think it
> is good enough for many use cases (unless the cgroup tree is very
> deep). It also demonstrates how we can implement some cgroup
> logic in BPF.
>
> I hope this helps.
>
> Thanks,
> Song
>
> [...]

Hi Song,

Thanks so much for pointing this out. I have an idea of a less
intrusive and more generic way to directly use rstat flushing in BPF
programs, which basically makes BPF programs maintain their own stats
and flushing logic and only using helpers to make calls to rstat
(instead of a whole new rstat map). I will work on an RFC patch series
for this.

If this doesn't work out, I will probably fallback to handling the
flushing completely in the BPF programs, similar to the example you
provided (which is a lot of help, thanks!).
