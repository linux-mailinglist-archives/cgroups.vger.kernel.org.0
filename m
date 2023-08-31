Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8878F165
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbjHaQks (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHaQkr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 12:40:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99414124
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:40:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1d03e124so113217966b.2
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500043; x=1694104843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drcv5mKJ9RhO4L7vLkvVuevPSBYeBJBAmcU4Oua4F00=;
        b=yTA644q6Seh2/5aVPQn7DTe+hvJiKfe7COTZEj1glHSCcL7fDKUK/1sywwKG5n8iER
         c4jKh5yEDHpRWaHqY8tLVG/EaKE13MuC1zzhih6R08Gl3r11V6dmrcPiVlPJ6+1hdLxr
         MNj+XFgUQRpFcNJBHOJS3VVexBB0SlFXPaIq0rDfY5ot3dGgaazyxPwdJKTso9TOV0qL
         C2RJzRP2Nkc2zBrwxQKX6VJstxV/lUoRx2JbIue0do+mgbBYv//842aKyqUQHTU5v1pZ
         DEMVfaBX/tx/xlIDLq/Nb+X/9NajYL7H3DmtV2sPrev7+uWLU0tcbTYRa65363Zz6saF
         uTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500043; x=1694104843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drcv5mKJ9RhO4L7vLkvVuevPSBYeBJBAmcU4Oua4F00=;
        b=Tv4D66GYqzqeGPGJ95a4U6hqR/XctTqY3BP81UC0mHymqMzw4oepJXnnCJdgt3BA3u
         JNJcLq33+x2aJWTn07S5zJEa4aelECHa+jVG58zm7mW0M5QyyX2Hk23xM0tsvefUwWx6
         Ny1qs+c+f2KAcLw2x5ifw5tJ2OFR3Ctdgk6Y2TLVNh9RiuPcngIFJJaMJS0raAgFhx3F
         utMJATnjW2+Sxq/rxgUtIooXvQ3EslNi3cP+wzYyP0m/R4zjeu2uRF+wCBRJCzX9VFDv
         Y0At5ZW89mVcQ+tqgk4mZ769L+CHoq7UCTDF5OswAhV5zNq9VEOXMd65CZ+qCWhob4Id
         3fvQ==
X-Gm-Message-State: AOJu0YyLxxR4EkNqwHiCIGxIIlrPsYgR0q9sdGRao8x280w3kCfspGYF
        BCCnmwDs9r8pRJJO7GelGXjOaPcIpBffcjmTwrZ8NA==
X-Google-Smtp-Source: AGHT+IGV24LZs9Ao9Nl3shUgQtSezVqin+bodeBsASR3yYN0F0gmiEmn2HA+jI3wOLaoklU27jzdjhbQxQ19eonVUNw=
X-Received: by 2002:a17:906:8450:b0:9a1:db2e:9dbb with SMTP id
 e16-20020a170906845000b009a1db2e9dbbmr4355097ejy.0.1693500042855; Thu, 31 Aug
 2023 09:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230830175335.1536008-5-yosryahmed@google.com> <202308311025.538QuXBV-lkp@intel.com>
In-Reply-To: <202308311025.538QuXBV-lkp@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 31 Aug 2023 09:40:03 -0700
Message-ID: <CAJD7tkbo28Mc9ydPnqL_gKmi-QZGORE-FVcZcQnsLVTCA1UBzA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 30, 2023 at 8:08=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Yosry,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master next-20230830]
> [cannot apply to v6.5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-mem=
cg-properly-name-and-document-unified-stats-flushing/20230831-015518
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20230830175335.1536008-5-yosryah=
med%40google.com
> patch subject: [PATCH v3 4/4] mm: memcg: use non-unified stats flushing f=
or userspace reads
> config: i386-randconfig-r013-20230831 (https://download.01.org/0day-ci/ar=
chive/20230831/202308311025.538QuXBV-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git =
ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230831/202308311025.538QuXBV-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308311025.538QuXBV-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> mm/memcontrol.c:667:6: warning: no previous prototype for function 'me=
m_cgroup_user_flush_stats' [-Wmissing-prototypes]
>    void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
>         ^
>    mm/memcontrol.c:667:1: note: declare 'static' if the function is not i=
ntended to be used outside of this translation unit
>    void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
>    ^
>    static
>    1 warning generated.

Ah silly mistake on my end. Will send v4 after making
mem_cgroup_user_flush_stats() static.

>
>
> vim +/mem_cgroup_user_flush_stats +667 mm/memcontrol.c
>
>    658
>    659  /*
>    660   * mem_cgroup_user_flush_stats - do a stats flush for a user read
>    661   * @memcg: memory cgroup to flush
>    662   *
>    663   * Flush the subtree of @memcg. A mutex is used for userspace rea=
ders to gate
>    664   * the global rstat spinlock. This protects in-kernel flushers fr=
om userspace
>    665   * readers hogging the lock.
>    666   */
>  > 667  void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
>    668  {
>    669          mutex_lock(&stats_user_flush_mutex);
>    670          do_stats_flush(memcg);
>    671          mutex_unlock(&stats_user_flush_mutex);
>    672  }
>    673
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
