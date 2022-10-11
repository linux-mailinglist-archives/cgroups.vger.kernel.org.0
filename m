Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54A75FA92D
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJKAPG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 20:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJKAPE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 20:15:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA7D1C904
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 17:15:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so19178478wrr.3
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 17:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5R0pinv45UAtKlsTkuyPxf0dfiwVu4saizyc4kXh9wE=;
        b=lGfVgp1V/sLVfhecIm+c3tVUQ/aewnQG+QaeaREAG03T7IfKe5Wj51TVbaJb0DEGfO
         P2/Wy1LvPnCEec4RYlwpoXU+cJjY55Ec22YsKV6eYGCaDYhGuy6QSOfT3Su2fMY1zuoS
         RHn+76zhnLPjuj8OvtNqmpkEJjsv3jYGeV492h5EDtL6dSFatrjP/EvAxWKbGRKs2qlT
         GKHFFBsAC2BF229tBT/fd1E448SyoC90xpjOLt/ignQoxHEZsYPTkQTLcgdGagMw4TNm
         XvlxgbbaSspLvA7HxxaSKLJOnhoP9PgZkTL/aGXyottUjVcnIiKlGA4oJbhkuJOuTjFN
         YdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R0pinv45UAtKlsTkuyPxf0dfiwVu4saizyc4kXh9wE=;
        b=yH00nVWX6fBVuH4Q0d8N04qRYHusvUlL+Ngk7gTO/W7NUO3grP50albgZxWbrCZNo6
         l5NvA4Nc8ALxz6V3Fyt87m95FZCTFkr0oRgswG7KRwnQqq5vHIZkk2yY+tCLcMU56W2D
         XaiZsuZnYt33A603ULusxe9olV6Mv6dg8zgodlYMx/CKKdQk81EP7jcgUHxr98oT4JCP
         NRoi1K/gxcTvlMNqd4+GApbmx5b9wKKMKwSWMx9YnHnGD20EKflfg/ncUo4iRcF4T5kz
         ghJXz1J43ZSgD4Uiiew6pdanfTBjfGsmJ/wKaTQsD8BQgQk7O4hkybt7GnYWhmCrX4hu
         4pZQ==
X-Gm-Message-State: ACrzQf17CFCuHYiWGvpfPEEI2Mkbnvr02XQNXXJLESb9qJ0mJ3GAXa0h
        lSxPeHkSVoMaN4iRMpjkioSI1Nx3v3/BbtIyLXKE7A==
X-Google-Smtp-Source: AMsMyM77xxAb2+1+sEoKn+/mAmGstymluCfCPbCOolSJ3Q4rON2RpeyWYFAJZK9XJfU8pCbtzc8o+dt3HnE1+xKFwD4=
X-Received: by 2002:adf:fb05:0:b0:228:6463:b15d with SMTP id
 c5-20020adffb05000000b002286463b15dmr13468532wrr.534.1665447300721; Mon, 10
 Oct 2022 17:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221010235845.3379019-1-yosryahmed@google.com>
 <20221010235845.3379019-3-yosryahmed@google.com> <Y0S0nFSyivpU4H0n@slm.duckdns.org>
In-Reply-To: <Y0S0nFSyivpU4H0n@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 10 Oct 2022 17:14:24 -0700
Message-ID: <CAJD7tkbDNqxE+bYQvo5YAbK01qz7UVd-s6bOf==Ao44bmNsk=Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup: add cgroup_all_get_from_[fd/file]()
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Oct 10, 2022 at 5:11 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Oct 10, 2022 at 11:58:44PM +0000, Yosry Ahmed wrote:
> > Add cgroup_all_get_from_fd() and cgroup_all_get_from_file() that
> > support both cgroup1 and cgroup2.
>
> Looks generally good. How about cgroup_v1v2_ as the prefix?

Thanks for taking a look.

I don't have a strong opinion here. I picked cgroup_all_* vs
cgroup12_* or cgroup_v1v2_* because it's easier on the eyes.

My preference would have been to rename the old versions to
cgroup_dfl_* instead, but like you said this might confuse existing
users.

Anyway, I am fine with whatever you choose. Let me know if you need me
to send a v2 for changing the prefix.

>
> Thanks.
>
> --
> tejun
