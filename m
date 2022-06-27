Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9DE55B4D6
	for <lists+cgroups@lfdr.de>; Mon, 27 Jun 2022 03:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiF0BFn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jun 2022 21:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF0BFm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Jun 2022 21:05:42 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364052AE6;
        Sun, 26 Jun 2022 18:05:42 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-101b4f9e825so11175592fac.5;
        Sun, 26 Jun 2022 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEDEWM/uIediVqxTgHJ1ffqjVVrgXA7HPhbIDVnGRjA=;
        b=N0kobSzdTz1T5pZSU48sBPPO1LDhIsX6IU8x3mwYeyaf9BsgbSveanERApsoUkF6e3
         2wR3FtV9u/Fx6PCJX7oe/R/5ul4XjCJrnIh3GJEMSR88iF6j3rkjiJoncM+02Z4fLOYB
         v+QcK249wDse+JdkMxAOzb0lLtvlrlJv/8Qf4iY4B9Vy302menS+GWt0kexRSOQj4bvN
         HUv0frlzdNtwdCCnJ+gIESQUF0ZynlonbAkkqOFNPPg8MyUnxKZzVb7n/S0KvPajOWF/
         tX63CdA8mNYxHFVjGEh9J+rrhsvA3T0EEJ27F1MI8qmjVWMWIIw9zeNB4yqYo2mo52SV
         b3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEDEWM/uIediVqxTgHJ1ffqjVVrgXA7HPhbIDVnGRjA=;
        b=lR+DPMbcnwqfvOyjdzqmKeA+LeFzbAIIS3RNFVaVvmhHdTk8EDNzz+I1WzCkf7I6Yr
         3tIiFO6eSU/fpmJm6eISm5NvWvvLEl6hUBL+5D1rFf70Keg+vbnYl4i8CGHuSEuyp29+
         TAp/K9bhohFAambgjM03WHtJPFb1uoQ/VWbjsaD5L4aKhBM85BEfClU8x0EugDQTnsOP
         /GKciBUUZbTvQpcv/WfHimmkGCMYYhrtUGErHLDZ5DxeLzzK5ZDyBHOwwCXUIVJvnNGN
         XKLZgABQzkq+WsRkDmKV3r6Oos5s+ZyBhy59luun5eiilIy0SXk24yRVW6EwEV8L6sSZ
         oOgg==
X-Gm-Message-State: AJIora/+JKWHpvZ5ENX9HusRHrMZxVgvWyarSTf9HvCKkOPs13+ARzGh
        OHpU2FiIRSNa98Q72VNV7WGhYoeAZK4vh7w6HHc=
X-Google-Smtp-Source: AGRyM1usK8XoCZ+Jm60xYYm5XWgIu/hR2mwVJiqsxvAhVLdVx5kpsc2MfE0Cvr+InPsxFp+qlwuYqkLSOhZFREg+e/I=
X-Received: by 2002:a05:6870:b52a:b0:101:d9d7:e879 with SMTP id
 v42-20020a056870b52a00b00101d9d7e879mr6548422oap.258.1656291940718; Sun, 26
 Jun 2022 18:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220625061844.226764-1-xiangyang3@huawei.com>
In-Reply-To: <20220625061844.226764-1-xiangyang3@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 27 Jun 2022 06:35:28 +0530
Message-ID: <CAFqt6zYd2GVv4kb4tWVVen-pq4ynN=q8jbE+AWmsjfeD8SJmqg@mail.gmail.com>
Subject: Re: [PATCH -next] mm/memcontrol.c: replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled()
To:     Xiang Yang <xiangyang3@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 25, 2022 at 11:51 AM Xiang Yang <xiangyang3@huawei.com> wrote:
>
> mem_cgroup_kmem_disabled() checks whether the kmem accounting is off.
> Therefore, replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled(),
> which is the same work in percpu.c and slab_common.c.
>
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
Acked-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 85adc43c5a25..4672c9ddd188 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3815,7 +3815,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> -       if (cgroup_memory_nokmem)
> +       if (mem_cgroup_kmem_disabled())
>                 return 0;
>
>         if (unlikely(mem_cgroup_is_root(memcg)))
> @@ -3830,7 +3830,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>
>  static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  {
> -       if (cgroup_memory_nokmem)
> +       if (mem_cgroup_kmem_disabled())
>                 return;
>
>         if (unlikely(mem_cgroup_is_root(memcg)))
> --
> 2.22.0
>
>
