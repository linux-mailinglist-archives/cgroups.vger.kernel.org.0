Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C994752683D
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382401AbiEMRXt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352522AbiEMRXs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:23:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0902D1117B
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:23:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m12so8587894plb.4
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUiCnPMeV2tewEXDSR1Opfl8CW/W1nTXt/fBcyuE7po=;
        b=hcbrT8LB9KtUyOFhJcjNGDoACadQCvR45e8T6zhTyidWst7gm9QCPlPUMus2qyKZO5
         F5DqklOOcurOuJJoDyNyaahuz9kll92/JgnSl7AlqgPH+K3Sn2fBXIsuvf7m/+R6yAVS
         fsGK3TwUuxHbSqM+peiMHJozwxnh0TRDv3ZGQTeyAIlOMdMVBvwteTZ4PytPmR9t47Gg
         pqGrxwTsmpv7IbPbGbuf/rmrhjr8qRe8wpa4F75swNWUD2SfEYFj+qQV2DV/gexKRIvo
         8snEpImCqQT57ffaUneyHTR7IkLcLcdzbaRzu3MoseaxEL7zq3AKDZum93Mv0C+hXL9+
         x1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUiCnPMeV2tewEXDSR1Opfl8CW/W1nTXt/fBcyuE7po=;
        b=ciKaCH/xqSR9QGAUNUA1T61tKBr2lhTF1pTmTW9aIfWROcXaU4ALAlRwF1G/fRc9k+
         mg7c/oozUum8nQt27OoMybB7Ft+KfOK/J5hHKEHozZgWkh9nXAhHizqlgF+3F9tXL5UI
         ka5qdx5c0jgLREq4pLblLpw9ZOh08/3FueQhmQHCEaragBpU5SQWZk4TXC1DUiM7epj8
         Ogm7X5bdqI2aFxBE3KE5MZOTaOsQxzN/mdRuWdnt1CPZ7TPBOt/nXXo0X19aQ2govBQB
         J/ZStsluDkii27c0xwipqkRdbUuIE5/9H+NIyALr11x7ogOViu29NPc0VwL+7tShKcTt
         0Q6g==
X-Gm-Message-State: AOAM533MgTAhKTnRUKAk/ElrSGNe1oLkfXvTmkm5cNc9uNVkyHPjEv2l
        O+vUJ4kALqiP5ZgJo6VCUAQjQvpd2M+p1BvwZB8Bow==
X-Google-Smtp-Source: ABdhPJz4VHbNlIGbH/16c9aEUEopLMQoK6LkB7d36n7lf29oYijqqNLTzk2YOn+i0DI+nxCAjpyhWmReuAOUVN9lSMM=
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr5479352plr.6.1652462627392; Fri, 13 May
 2022 10:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220510152847.230957-1-hannes@cmpxchg.org> <20220510152847.230957-7-hannes@cmpxchg.org>
In-Reply-To: <20220510152847.230957-7-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 13 May 2022 10:23:36 -0700
Message-ID: <CALvZod6kBZZFfD6Y5p_=9TMJr8P-vU_77NTq048wGUDr0wTv0Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, May 10, 2022 at 8:29 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
> +void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> +
> +       /* PF_MEMALLOC context, charging must succeed */
)
Instead of these warnings and comment why not just explicitly use
memalloc_noreclaim_[save|restore]() ?

> +       if (obj_cgroup_charge(objcg, GFP_KERNEL, size))

Can we please make this specific charging an opt-in feature or at
least provide a way to opt-out? This will impact users/providers where
swap is used transparently (in terms of memory usage). Also do you
want this change for v1 users as well?

> +               VM_WARN_ON_ONCE(1);
> +
> +       rcu_read_lock();
> +       memcg = obj_cgroup_memcg(objcg);
> +       mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
> +       mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> +       rcu_read_unlock();
> +}
> +
