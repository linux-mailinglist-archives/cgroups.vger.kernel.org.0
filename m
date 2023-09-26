Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB67AE7F1
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjIZIXg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjIZIXe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 04:23:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCAFC
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 01:23:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso721173166b.0
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695716606; x=1696321406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9tTw5sUAPOrchYqA3E5owwjKmHdzzHpZh+gEC9Bxy8=;
        b=sIrkm5fnHq62gxdiLho0PUJxuyqiaaJhNCpRLVeRdyS3virxw6FMkSakOFNGstwHnS
         IJPKspbKgEjUgDLxLHFXVYyiFL/JD7ZE2yYvv7Ibl8wXqFn5uhZBsESOhUXc4ABULXRk
         1PFIQIPxPFZjjiWMloZICYiMEyArrl5WDO1WMb3G5tNUe3Eogh0p4bDqNqvIaarsa8Sb
         tKf/UajuXwcYyjlO4N7Tm85kjCfeOJ/WDXs1+LWOD7a+p0IngBsXa0b0JX7jbS0qoHjA
         OQw9rcWdDar/GyM9lN9X4vssT3B20Psu6yLOKtbZ9eS8g980fenMlTfo40+Ckbb3hC14
         msrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695716606; x=1696321406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9tTw5sUAPOrchYqA3E5owwjKmHdzzHpZh+gEC9Bxy8=;
        b=F7HCl6Sie7NAFS44cLrZumCY95JGNJkZeBfgvdlkWt0A/8aWcaMtMdqOOosGtmtRaN
         zGgdVwFCUqzcRabKaKr11qnh+zOdIeBVJBMi0srJjiDjiJCVUNywxsrInz1GIIzJLBKp
         Il2mWetvj1Fe0ezigY3MMHF/vqLfml/UAJQ6cGXNmnGshgqxWWluLLgVj132MOGigutt
         QzqpUuXDv+eGA7e3M4UaA+tTiWKt3VVRIt5N2Bi+0+bB0Zg7NCjyiusjarxdTzkytH36
         QrpfpuJrJ8BrY0UZi9tGq/KDpfxPOY4/uFVNzSadNVjLI3RVmq3TQL+r7bjUSFoenzP1
         l7VQ==
X-Gm-Message-State: AOJu0YzVq/4bIFb96KEe3uXixi/bpplx8YCi+mgA6+xu5hGvOJnKnQLr
        M8W+u6GLHeqvCcCGPJCfSAHg1YUSAeqkLXs5n3vJiA==
X-Google-Smtp-Source: AGHT+IGkkx1U2rNgqDwWhUXXyiFqJYMFNsgfzF84t+MVL60Zor+PPsTYDtb+H0XGSTY7RJyc59zxkbbMgkgbUR0S9To=
X-Received: by 2002:a17:906:9d1:b0:9ad:ad5a:939b with SMTP id
 r17-20020a17090609d100b009adad5a939bmr7710821eje.7.1695716606170; Tue, 26 Sep
 2023 01:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230902100728.3850149-1-liushixin2@huawei.com> <ZRKIdTE+4cm0KDCI@infradead.org>
In-Reply-To: <ZRKIdTE+4cm0KDCI@infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 26 Sep 2023 01:22:47 -0700
Message-ID: <CAJD7tkYY7je3x-MRhayyrC0xCFvKZO8CuiEnQHanF5_ErZ2n6Q@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: expose swapcache stat for memcg v1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Liu Shixin <liushixin2@huawei.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 12:30=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Sat, Sep 02, 2023 at 06:07:28PM +0800, Liu Shixin wrote:
> > Since commit b6038942480e ("mm: memcg: add swapcache stat for memcg v2"=
)
> > adds swapcache stat for the cgroup v2, it seems there is no reason to
> > hide it in memcg v1. Conversely, with swapcached it is more accurate to
> > evaluate the available memory for memcg.
>
> Why are we adding new features to the long deprecated cgroup v1?
>

Technically this is not a new feature, we are just exposing a stat
that the kernel is already tracking (for both cgroup v1 and v2).

The reason I suggested to expose this for cgroup v1 is because a
recent series [1] started using this stat in the kernel to make some
reclaim decisions, for both cgroup v1 and v2. Exposing the stat in v1
will make sure no one assumes the stat is only useful for v2 and break
the tracking for v1 (which might cause some reclaim regressions then).

[1]https://lore.kernel.org/lkml/20230915083417.3190512-1-liushixin2@huawei.=
com/
