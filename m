Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7652F551
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353639AbiETVt7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiETVt6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 17:49:58 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4119C761
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 14:49:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c1so8466789qkf.13
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5lqA4V2Z2dTb6TSdgJsb3QItFMtbNECXgovUnmle3Y=;
        b=kS4vFnX94EFG9U4QcDfkpXRrX2RNEKg6t5fFXIM1d4BF31cv67BKOWBC2/lKKWdWbn
         eAiIo+bdJTHT1tFbHYiYmgVpOrVsoU4ftSDk7vordIX8o06a1mV0wVr6JDtOc50c47Y+
         0GLRmWg6ZMMrDP/lrewoqr2ZIF//PQqiqRIMWoBfc+gkgSVLmF7StWfErdeSzc8IStzs
         Dpqt3hNNZFs1UiH/n2pe0dgtzveVE5rAsr/WcqdlXXfiGC9hLiZaINDKyifpLvdtlCUs
         BuqqQ6VdPyyv9LSKYr3Orpz88v4ptMLSyEV3N8jFFGfKGlpEvQiPEU6RQs+WPn2sulTo
         CTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5lqA4V2Z2dTb6TSdgJsb3QItFMtbNECXgovUnmle3Y=;
        b=4tyWe2hQ4qOjgMy80WpFpDvZitPygw6CUxNd0O3tUCDhDFGk8NqtQeP+INTSAuTWSQ
         7Ppvpflbmg+Aa5rMxTpxKQ9aqAnw7qHuBNIlRc893d78s1ZdpL9qLOBwRSY6BJWKp/8F
         NwGRTMktWxCjWVUaLSYejLv1IkBeHf79TQ7O5zKiKo3NZIBf9z48PxphiFL3OlZ14pQq
         HZbQZQ9duFI9loEZ7/a2Z6jli46Lfl32Z8PJ47Ve3gVtJ2Zdh9XBVXIgqpCHgHbIKlGD
         /ygmxpYk1VKVqoQCW6AJcaXjQkYzEjW/ghhPkdQqk62iXD5TjS4obM0xPjhCc5Es9xsC
         i52w==
X-Gm-Message-State: AOAM533TakphSdsxUC3tD2NW5zAcPdylfSdE7BvyzdcBzACu6DJGpcPb
        ao/7s9Nw4RNdGY9lypwS5Vwb5ZtWvpdGZ7Mvcnt5gw==
X-Google-Smtp-Source: ABdhPJxonSSQ4Ctjgy9FHZhPALvEvqDuaDCFX0JXitnObExcsts1K2cefYYK0aJQqCjAgyOsCzzmQzREppJ+UnZ2YeI=
X-Received: by 2002:ae9:f504:0:b0:69f:ba2d:29ff with SMTP id
 o4-20020ae9f504000000b0069fba2d29ffmr7651495qkg.583.1653083396226; Fri, 20
 May 2022 14:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220520012133.1217211-1-yosryahmed@google.com>
 <20220520012133.1217211-4-yosryahmed@google.com> <YodGI73xq8aIBrNM@slm.duckdns.org>
 <CAJD7tkbvMcMWESMcWi6TtdCKLr6keBNGgZTnqcHZvBrPa1qWPw@mail.gmail.com>
 <YodNLpxut+Zddnre@slm.duckdns.org> <73fd9853-5dab-8b59-24a0-74c0a6cae88e@fb.com>
 <YofFli6UCX4J5YnU@slm.duckdns.org> <CA+khW7gjWVKrwCgDD-4ZdCf5CMcA4-YL0bLm6aWM74+qNQ4c0A@mail.gmail.com>
In-Reply-To: <CA+khW7gjWVKrwCgDD-4ZdCf5CMcA4-YL0bLm6aWM74+qNQ4c0A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 20 May 2022 14:49:45 -0700
Message-ID: <CA+khW7iDDkO3h5WQixEA=nUL-tBmCTh7fMAf3iwNy98UfM-k9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/5] bpf: Introduce cgroup iter
To:     Tejun Heo <tj@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
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

Hi Tejun and Yonghong,

On Fri, May 20, 2022 at 12:42 PM Hao Luo <haoluo@google.com> wrote:
>
> Hi Tejun and Yonghong,
>
> On Fri, May 20, 2022 at 9:45 AM Tejun Heo <tj@kernel.org> wrote:
> > On Fri, May 20, 2022 at 09:29:43AM -0700, Yonghong Song wrote:
> > >    <various stats interested by the user>
> > >
> > > This way, user space can easily construct the cgroup hierarchy stat like
> > >                            cpu   mem   cpu pressure   mem pressure ...
> > >    cgroup1                 ...
> > >       child1               ...
> > >         grandchild1        ...
> > >       child2               ...
> > >    cgroup 2                ...
> > >       child 3              ...
> > >         ...                ...
> > >
> > > the bpf iterator can have additional parameter like
> > > cgroup_id = ... to only call bpf program once with that
> > > cgroup_id if specified.
>
> Yep, this should work. We just need to make the cgroup_id parameter
> optional. If it is specified when creating bpf_iter_link, we print for
> that cgroup only. If it is not specified, we iterate over all cgroups.
> If I understand correctly, sounds doable.
>

Yonghong, I realized that seek() which Tejun has been calling out, can
be used to specify the target cgroup, rather than adding a new
parameter. Maybe, we can pass cgroup_id to seek() on cgroup bpf_iter,
which will instruct read() to return the corresponding cgroup's stats.
On the other hand, reading without calling seek() beforehand will
return all the cgroups.

WDYT?
