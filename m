Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D568752E6D5
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346783AbiETH7s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346763AbiETH7b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 03:59:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E31815D30B
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 00:59:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg25so4093588wmb.4
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ea7uCWmZvVi7x8pZXNpq32JNdBnZG/d3z6FlMpmBFbQ=;
        b=aEdYT6oI+uAOu9UjBKXVmQR4Vqb7G4k23KZ5L2K3v79YnkqWwIWGGGpsdip/no9LKF
         OX6p+BYYQM+OElnkM9nMH0jOpS1lznXRg3lJ6uwuxhXtFofh4fsrAfY8PoByvVgIOv14
         TnBJGNIAxOy63rP8B+4+4uWMpcRLRAsdAJDUbp+llYUTUriz6jRPAyL4AWOccmuIKhOI
         69qZZCmel4W+VjPG+18N18R/0StDr7wRnLfT06tb+/NpzgX2jn1EsTpE4Ls55bXco/k/
         wIf7IpYqEmW72htmBiltvUNLA/eOWjZyVZAxP36v1WUwj5Mh1B+IcLpkSxewV90tvTLs
         HEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea7uCWmZvVi7x8pZXNpq32JNdBnZG/d3z6FlMpmBFbQ=;
        b=d6xpAsSfH8a6pJ1o27afBPd3C+OOkeKCPcmQmew7DgtsFxjQExwsghqOD6l4A0bT7O
         Ix9ZNbwY1X/elqTJresAArKhbK9OyNVyy27WEvoWuQWWgYMLpJD9r35+IQlq123Vjs+u
         YlRMCY2glipX9F1qTXM37ggwh3Ea+M/lvufriCn4UCPlBt0RHH18O3cQhB1wdcYEp/FA
         aSNjn8T7Kpg5Y32yS2+AVqxPoFDNRPIGfy54Rf4K3+JxcvOPiUWpeFjXC0rESRq7467Z
         +qFklWkkBnWUgtibMNiFcMxQplnYjCJgPaHKxZmdo7CPT7BBGka7E77UmKxwM7p6ttHU
         u6WA==
X-Gm-Message-State: AOAM5310Db/5z4DoVXhYib6N+gUrnxytcaWWK3q5LtRnnvlZR8KJfiY9
        UshhBVU452YN33j5lpXT9e9HyeKZLUC37eRmyJlU/w==
X-Google-Smtp-Source: ABdhPJzkbcWaIOOyEvvxjJVCin6gWKz/UgskGdAE5PNQ9w+UErfnjSVu3h7gWMQNdUWckLnyYGW2D4/mAvuI+pGBiow=
X-Received: by 2002:a05:600c:1908:b0:394:867d:66c4 with SMTP id
 j8-20020a05600c190800b00394867d66c4mr7447568wmq.152.1653033568515; Fri, 20
 May 2022 00:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220520012133.1217211-1-yosryahmed@google.com>
 <20220520012133.1217211-4-yosryahmed@google.com> <YodGI73xq8aIBrNM@slm.duckdns.org>
In-Reply-To: <YodGI73xq8aIBrNM@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 20 May 2022 00:58:52 -0700
Message-ID: <CAJD7tkbvMcMWESMcWi6TtdCKLr6keBNGgZTnqcHZvBrPa1qWPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/5] bpf: Introduce cgroup iter
To:     Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
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

On Fri, May 20, 2022 at 12:41 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, May 20, 2022 at 01:21:31AM +0000, Yosry Ahmed wrote:
> > From: Hao Luo <haoluo@google.com>
> >
> > Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> > iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> > be parameterized by a cgroup id and prints only that cgroup. So one
> > needs to specify a target cgroup id when attaching this iter. The target
> > cgroup's state can be read out via a link of this iter.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> This could be me not understanding why it's structured this way but it keeps
> bothering me that this is adding a cgroup iterator which doesn't iterate
> cgroups. If all that's needed is extracting information from a specific
> cgroup, why does this need to be an iterator? e.g. why can't I use
> BPF_PROG_TEST_RUN which looks up the cgroup with the provided ID, flushes
> rstat, retrieves whatever information necessary and returns that as the
> result?

I will let Hao and Yonghong reply here as they have a lot more
context, and they had previous discussions about cgroup_iter. I just
want to say that exposing the stats in a file is extremely convenient
for userspace apps. It becomes very similar to reading stats from
cgroupfs. It also makes migrating cgroup stats that we have
implemented in the kernel to BPF a lot easier.

AFAIK there are also discussions about using overlayfs to have links
to the bpffs files in cgroupfs, which makes it even better. So I would
really prefer keeping the approach we have here of reading stats
through a file from userspace. As for how we go about this (and why a
cgroup iterator doesn't iterate cgroups) I will leave this for Hao and
Yonghong to explain the rationale behind it. Ideally we can keep the
same functionality under a more descriptive name/type.

>
> Thanks.
>
> --
> tejun
