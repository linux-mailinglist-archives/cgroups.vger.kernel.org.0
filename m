Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150337AA2A5
	for <lists+cgroups@lfdr.de>; Thu, 21 Sep 2023 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjIUV1f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Sep 2023 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjIUV1X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Sep 2023 17:27:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE87900CA
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 14:01:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31f737b8b69so1237705f8f.3
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695330097; x=1695934897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rUsUqKbiTN+5AJFY5VneI8NJRSroN3WWkp9ziiQqp0=;
        b=LeT0qvzwdIkJKnc0j1Tny7Ql3nEAmAyZAQ459bCBozcmtHPyEML9EgxSMlN9x85XYR
         frT+YJZGqjeEoszbIVz6/OhXGGRqqRdBaFN/aIIhhcJLWZ4ZlZfNHcBZlp1iTQh0BQJX
         ysEyDTuXQhYRTHxxTy03fzrcQCoeoImdvG0zppGhKUCZMr62UC9uYJ5udK+T/f4Ar0Bb
         hz0/g7tT7xIjZRtIXAmjDTQz7lgQjPhyALtmRVtXxDEC+Deg/NnVvJ80jyWxmbv6WqJB
         Sq2d99IGSY6/ntoYsLUbM9jNS/MLs/eoNfHD22AvQ5rden58ZUL2hsBCZpsRvgOd130a
         Nlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695330097; x=1695934897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rUsUqKbiTN+5AJFY5VneI8NJRSroN3WWkp9ziiQqp0=;
        b=rcbwyx3erCqlYMFO6fPJMMFC8Mt0UssnXm7V/LcJsE6WvpXPRjKlr7YahAhAvNiFEV
         ScA+LkicbMtIInEGUuF0JZZksMEsa/BhnU4WPm64wderyP9cGhn7588CBTImeY2w7Tri
         0lzeUmRuf2n36XicZYqUZBGiFTvWEtC+BnAnwbR3qS0UdKnk/HOVaD5QFh8twAP2gFX5
         41qGsNy7GBvJHcgYEB3YBbE8R2XpIwUBXi4iFjU7NaV/ekCrF2jZUkiHmJcsZy4UwTc+
         6mdcESTBjzBAdl0igCJzpfaN1nTwajGha0Dve2znBkW+vyJdY/fZ+Qx5Qkd5l5DV2U+d
         B60g==
X-Gm-Message-State: AOJu0YxCIgBiLzSQI6jIvEflnpM3pmuPWuB/UP8sxoPTbOhW6hJzttot
        rE37BOW6BGs6h0pQbdLmuYSQRAk2Gj9/NXOz7HsGcA==
X-Google-Smtp-Source: AGHT+IG+lgB6b0FlP6FTLmxGTFwXXXbuDjRWJ1vjsbR9lCrf7xYl/EarkvsXMyrafWLuLdoGAIYtDTgDuHS2NedZsQM=
X-Received: by 2002:a5d:638a:0:b0:321:6fe4:d4eb with SMTP id
 p10-20020a5d638a000000b003216fe4d4ebmr4827582wru.2.1695330097084; Thu, 21 Sep
 2023 14:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230921081057.3440885-5-yosryahmed@google.com> <202309211829.Efuqg8NE-lkp@intel.com>
In-Reply-To: <202309211829.Efuqg8NE-lkp@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 21 Sep 2023 14:00:57 -0700
Message-ID: <CAJD7tkam6BV0p99t503x0V__ygVk_3sdrDSLjiEP5dsE_5T7Qg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: workingset: move the stats flush into workingset_test_recent()
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 21, 2023 at 4:06=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Yosry,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-mem=
cg-change-flush_next_time-to-flush_last_time/20230921-161246
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20230921081057.3440885-5-yosryah=
med%40google.com
> patch subject: [PATCH 4/5] mm: workingset: move the stats flush into work=
ingset_test_recent()
> config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/2023=
0921/202309211829.Efuqg8NE-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230921/202309211829.Efuqg8NE-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309211829.Efuqg8NE-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    mm/workingset.c: In function 'workingset_test_recent':
> >> mm/workingset.c:461:32: error: invalid use of undefined type 'struct m=
em_cgroup'
>      461 |         css_get(&eviction_memcg->css);
>          |                                ^~
>

Ah yes, I cannot dereference the memcg pointer here. I think we want
mem_cgroup_get_from_id (a getter version of mem_cgroup_from_id) or
mem_cgroup_get (similar to mem_cgroup_put) to have stubs when
!CONFIG_MEMCG. I will do this change in the next version, but I'll
wait for feedback on this version first.

>
> vim +461 mm/workingset.c
>
>    405
>    406  /**
>    407   * workingset_test_recent - tests if the shadow entry is for a fo=
lio that was
>    408   * recently evicted. Also fills in @workingset with the value unp=
acked from
>    409   * shadow.
>    410   * @shadow: the shadow entry to be tested.
>    411   * @file: whether the corresponding folio is from the file lru.
>    412   * @workingset: where the workingset value unpacked from shadow s=
hould
>    413   * be stored.
>    414   *
>    415   * Return: true if the shadow is for a recently evicted folio; fa=
lse otherwise.
>    416   */
>    417  bool workingset_test_recent(void *shadow, bool file, bool *workin=
gset)
>    418  {
>    419          struct mem_cgroup *eviction_memcg;
>    420          struct lruvec *eviction_lruvec;
>    421          unsigned long refault_distance;
>    422          unsigned long workingset_size;
>    423          unsigned long refault;
>    424          int memcgid;
>    425          struct pglist_data *pgdat;
>    426          unsigned long eviction;
>    427
>    428          rcu_read_lock();
>    429
>    430          if (lru_gen_enabled()) {
>    431                  bool recent =3D lru_gen_test_recent(shadow, file,
>    432                                                    &eviction_lruve=
c, &eviction,
>    433                                                    workingset);
>    434                  rcu_read_unlock();
>    435                  return recent;
>    436          }
>    437
>    438          unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workin=
gset);
>    439          eviction <<=3D bucket_order;
>    440
>    441          /*
>    442           * Look up the memcg associated with the stored ID. It mi=
ght
>    443           * have been deleted since the folio's eviction.
>    444           *
>    445           * Note that in rare events the ID could have been recycl=
ed
>    446           * for a new cgroup that refaults a shared folio. This is
>    447           * impossible to tell from the available data. However, t=
his
>    448           * should be a rare and limited disturbance, and activati=
ons
>    449           * are always speculative anyway. Ultimately, it's the ag=
ing
>    450           * algorithm's job to shake out the minimum access freque=
ncy
>    451           * for the active cache.
>    452           *
>    453           * XXX: On !CONFIG_MEMCG, this will always return NULL; i=
t
>    454           * would be better if the root_mem_cgroup existed in all
>    455           * configurations instead.
>    456           */
>    457          eviction_memcg =3D mem_cgroup_from_id(memcgid);
>    458          if (!mem_cgroup_disabled() && !eviction_memcg)
>    459                  return false;
>    460
>  > 461          css_get(&eviction_memcg->css);
>    462          rcu_read_unlock();
>    463
>    464          /* Flush stats (and potentially sleep) outside the RCU re=
ad section */
>    465          mem_cgroup_flush_stats_ratelimited();
>    466
>    467          eviction_lruvec =3D mem_cgroup_lruvec(eviction_memcg, pgd=
at);
>    468          refault =3D atomic_long_read(&eviction_lruvec->nonresiden=
t_age);
>    469
>    470          /*
>    471           * Calculate the refault distance
>    472           *
>    473           * The unsigned subtraction here gives an accurate distan=
ce
>    474           * across nonresident_age overflows in most cases. There =
is a
>    475           * special case: usually, shadow entries have a short lif=
etime
>    476           * and are either refaulted or reclaimed along with the i=
node
>    477           * before they get too old.  But it is not impossible for=
 the
>    478           * nonresident_age to lap a shadow entry in the field, wh=
ich
>    479           * can then result in a false small refault distance, lea=
ding
>    480           * to a false activation should this old entry actually
>    481           * refault again.  However, earlier kernels used to deact=
ivate
>    482           * unconditionally with *every* reclaim invocation for th=
e
>    483           * longest time, so the occasional inappropriate activati=
on
>    484           * leading to pressure on the active list is not a proble=
m.
>    485           */
>    486          refault_distance =3D (refault - eviction) & EVICTION_MASK=
;
>    487
>    488          /*
>    489           * Compare the distance to the existing workingset size. =
We
>    490           * don't activate pages that couldn't stay resident even =
if
>    491           * all the memory was available to the workingset. Whethe=
r
>    492           * workingset competition needs to consider anon or not d=
epends
>    493           * on having free swap space.
>    494           */
>    495          workingset_size =3D lruvec_page_state(eviction_lruvec, NR=
_ACTIVE_FILE);
>    496          if (!file) {
>    497                  workingset_size +=3D lruvec_page_state(eviction_l=
ruvec,
>    498                                                       NR_INACTIVE_=
FILE);
>    499          }
>    500          if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
>    501                  workingset_size +=3D lruvec_page_state(eviction_l=
ruvec,
>    502                                                       NR_ACTIVE_AN=
ON);
>    503                  if (file) {
>    504                          workingset_size +=3D lruvec_page_state(ev=
iction_lruvec,
>    505                                                       NR_INACTIVE_=
ANON);
>    506                  }
>    507          }
>    508
>    509          mem_cgroup_put(eviction_memcg);
>    510          return refault_distance <=3D workingset_size;
>    511  }
>    512
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
