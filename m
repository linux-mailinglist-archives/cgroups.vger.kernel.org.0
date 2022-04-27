Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42AA51107C
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 07:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiD0F0y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 01:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245654AbiD0F0x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 01:26:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA91154F2
        for <cgroups@vger.kernel.org>; Tue, 26 Apr 2022 22:23:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a11so686470pff.1
        for <cgroups@vger.kernel.org>; Tue, 26 Apr 2022 22:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwauUeBlcHvBLcNyAimJGJIhIGSQVXs8oid0dWAxNRI=;
        b=nxABqQf6lZRKa97gncv5efuRIZgUZAdO5gy+OF4jUXCOKpj9bbJWK3r1gjH4Xw8PuN
         ktWmeG+np9gFm5AlHfhYGoEF6hgQvbXAvE8Quf/i9hC0H/nngx/EtDJDD9UyTTDYkAJT
         uHEDpmH3K3X7h19iV2m7d+uEYToyhrRt5/3VUYkZg4SOCqK0j5Nwhb1AdhdzECIqPo0D
         6fiUmxExbZNRQJj1AZPLh48eAj/VDbqfjf/2RVcThYoIBxWVFZI0Gnq9jo9vnf4orWCu
         AcfxlihjntfM/JqbBBJDAEDbfYDCrNFcrzMLq9J5zMricu4rMtwS+dqCljWdIGdyWkVj
         vUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwauUeBlcHvBLcNyAimJGJIhIGSQVXs8oid0dWAxNRI=;
        b=q5s8kN0YKajSgWuTsivj8nGi9UGpsaQTRz4BoWp5KemvBVKyTmBkoXV4MyydPetbW9
         LSIjcX3evO8xycQ8OQ9ursPHs4RATjhgKc1w8EViQgXPNZXx5N0sMnR/F4rq6Wd+mdTE
         JvzKVB53jKSJ6FsiQBrNtxRK/tPAcjNZQHSEPajIEhK2Kr3AI8gpFEmAD+HHr4MUEmht
         NSbJi/mIizIEd4P7fARNJ6ZxbPqtOAqepADresleEAbZPezqUaEjSG8YzZo1g0C6cU2x
         WJ/qKVxKf25cgrpk4ZX3iDTL30WSW4KEse0R3WTv+MDYOkvbRu/kNGKq16dpIGuEIIh5
         34+A==
X-Gm-Message-State: AOAM531ykrqqIUVNg6w0NAR/deAqsmHaqgip+aoeqM/Luq8dk8W5kgfo
        OkbsB/ifR3X/FrYLL9YMQP9IvO0pdQaZ3HljCEluGQ==
X-Google-Smtp-Source: ABdhPJwemIJMuNvur9xoVeyM2lh0O0LGlsT3yrBbDXhCa2tzdHR3c/Mp+1SptclF6mKluY9dz3wC3yrntS/Wa46igdg=
X-Received: by 2002:a63:5b53:0:b0:39c:c6b8:d53b with SMTP id
 l19-20020a635b53000000b0039cc6b8d53bmr22140578pgm.166.1651037023216; Tue, 26
 Apr 2022 22:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <YmdeCqi6wmgiSiWh@carbon> <33085523-a8b9-1bf6-2726-f456f59015ef@openvz.org>
In-Reply-To: <33085523-a8b9-1bf6-2726-f456f59015ef@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 26 Apr 2022 22:23:32 -0700
Message-ID: <CALvZod4oaj9MpBDVUp9KGmnqu4F3UxjXgOLkrkvmRfFjA7F1dw@mail.gmail.com>
Subject: Re: [PATCH memcg v4] net: set proper memcg for net_init hooks allocations
To:     Vasily Averin <vvs@openvz.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
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

On Mon, Apr 25, 2022 at 11:43 PM Vasily Averin <vvs@openvz.org> wrote:
>
> __register_pernet_operations() executes init hook of registered
> pernet_operation structure in all existing net namespaces.
>
> Typically, these hooks are called by a process associated with
> the specified net namespace, and all __GFP_ACCOUNT marked
> allocation are accounted for corresponding container/memcg.
>
> However __register_pernet_operations() calls the hooks in the same
> context, and as a result all marked allocations are accounted
> to one memcg for all processed net namespaces.
>
> This patch adjusts active memcg for each net namespace and helps
> to account memory allocated inside ops_init() into the proper memcg.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

[...]
>
> +static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
> +{
> +       struct mem_cgroup *memcg;
> +

Do we need memcg_kmem_enabled() check here or maybe
mem_cgroup_from_obj() should be doing memcg_kmem_enabled() instead of
mem_cgroup_disabled() as we can have "cgroup.memory=nokmem" boot
param.

> +       rcu_read_lock();
> +       do {
> +               memcg = mem_cgroup_from_obj(p);
> +       } while (memcg && !css_tryget(&memcg->css));
> +       rcu_read_unlock();
> +       return memcg;
> +}
