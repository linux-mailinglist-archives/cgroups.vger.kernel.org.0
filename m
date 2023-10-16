Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725757CB699
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJPWeT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJPWeT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 18:34:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AB895
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 15:34:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9c145bb5bso36485ad.1
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697495657; x=1698100457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNaafexrbu6pnn24PMIqsD4prSCGfjBYmlc/DxhvRmw=;
        b=AyV9HAEABw91cHepsELFKrQRODIeMpGH+w6rkrPIokJ9sWTyLjSv0exqrYLMN0dqQ0
         xWT7y9XQ/19a4Z/fomhWiorroSxsWN8Ro0OCCknmLc6LTt9FbYuijB1unNhTbB3LHB72
         lFTzkFS6gb4I4bbI2b8RNU1ScEoEjZ7KeUGMpA68lXCv9VQMUC8gGE39hK7vABEgtmbk
         jzk+b0iC1KcoxYDZq2zlkpQhK3ZELF29V3uL5X+/FKQ+PNGCoEtNRIgRMdKiHPpnM3UI
         l380/Umjybt6PpueiGJX7o0fzJ/GQGLmK98a6cSZPkcMlcGvuJ649UpI5uFz8CUavpx6
         QxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697495657; x=1698100457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNaafexrbu6pnn24PMIqsD4prSCGfjBYmlc/DxhvRmw=;
        b=rc/ZQlSQ3ct4234l75RO8pnbWL3JwC9C0mm7bEKxj76++345CAtUk8KCDDbkdDl3/u
         JL7spj7LUebfuUvfkjl12e6sZKgbpUum190LV60i+G9zwDuoDHEZpUi+w4VWNBHPd2PJ
         BiWwMiB+Usd0bQf2jqYYn0g8a7zSoCy5LVqkgrou78c/fYrTITVxz8Y65spm2rU6d48i
         quwTDEKraa0NENBP144lnngu+dsk2VauPqSeuuNBXtWVPO22g2YdIa4DL7oOYB1ajAog
         VZ21FyqBX+Gc2ww8L+RKQ02bVBERhtqn4xU47pOZdyRct9BQYBQTmOGTjVqGb4zd8Xd3
         wgEg==
X-Gm-Message-State: AOJu0Yw0G3uWkbEsW+JaCsJtNZ8VHXSZuQoPpQOGhVjOt3ngOH6EeUvh
        5CVAEIhOSpABFRzdSJsspIHF6F2q207QgdLQFUr0YdNOgwU1n/fniKU=
X-Google-Smtp-Source: AGHT+IG3ySgH6r4NHrjsWGFuZm4kiRC1nt1ET06dFz1yUmkopUw3bQVUWWxa7YU+FO6MIW6+pjxeEFm6NmHAi5xJXkc=
X-Received: by 2002:a17:903:2406:b0:1bb:2c7b:6d67 with SMTP id
 e6-20020a170903240600b001bb2c7b6d67mr35150plo.11.1697495657132; Mon, 16 Oct
 2023 15:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231016221900.4031141-1-roman.gushchin@linux.dev> <20231016221900.4031141-3-roman.gushchin@linux.dev>
In-Reply-To: <20231016221900.4031141-3-roman.gushchin@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 16 Oct 2023 15:34:05 -0700
Message-ID: <CALvZod7yT4=RegYNJd+8Wcb4vcySLOdGZOTmDCrBL0mzKu=+GA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 16, 2023 at 3:19=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> To charge a freshly allocated kernel object to a memory cgroup, the
> kernel needs to obtain an objcg pointer. Currently it does it
> indirectly by obtaining the memcg pointer first and then calling to
> __get_obj_cgroup_from_memcg().
>
> Usually tasks spend their entire life belonging to the same object
> cgroup. So it makes sense to save the objcg pointer on task_struct
> directly, so it can be obtained faster. It requires some work on fork,
> exit and cgroup migrate paths, but these paths are way colder.
>
> To avoid any costly synchronization the following rules are applied:
> 1) A task sets it's objcg pointer itself.
>
> 2) If a task is being migrated to another cgroup, the least
>    significant bit of the objcg pointer is set atomically.
>
> 3) On the allocation path the objcg pointer is obtained locklessly
>    using the READ_ONCE() macro and the least significant bit is
>    checked. If it's set, the following procedure is used to update
>    it locklessly:
>        - task->objcg is zeroed using cmpxcg
>        - new objcg pointer is obtained
>        - task->objcg is updated using try_cmpxchg
>        - operation is repeated if try_cmpxcg fails
>    It guarantees that no updates will be lost if task migration
>    is racing against objcg pointer update. It also allows to keep
>    both read and write paths fully lockless.
>
> Because the task is keeping a reference to the objcg, it can't go away
> while the task is alive.
>
> This commit doesn't change the way the remote memcg charging works.
>
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
