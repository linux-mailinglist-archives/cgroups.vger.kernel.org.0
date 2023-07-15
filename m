Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3D7545A3
	for <lists+cgroups@lfdr.de>; Sat, 15 Jul 2023 02:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGOAac (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jul 2023 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOAac (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jul 2023 20:30:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F783A99
        for <cgroups@vger.kernel.org>; Fri, 14 Jul 2023 17:30:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-316eabffaa6so2012848f8f.2
        for <cgroups@vger.kernel.org>; Fri, 14 Jul 2023 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689381028; x=1691973028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ptAxBcW7aHFl51V3a6EjybWpG1k8jXl2fJumuPzCWI=;
        b=OKBWZD7hUGWSmN+3mpSUHI7/TIUCwtTCSVhJFhqPPb2/YEUL9MtgCkWbZCQbhlPV26
         ZU9n46fYO9n14gKdH9pdnznVF3xxgsNFqBTEzlvYTseWX2rakSjIVOCOVJv8Woyh/P6/
         wutIaHQINaqQLf1SxDMmwhv/hdu/yneXvriNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689381028; x=1691973028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ptAxBcW7aHFl51V3a6EjybWpG1k8jXl2fJumuPzCWI=;
        b=Fe71ds+7hS4ZLwlHEgSv822eSfx2E0pMs0vARoRfO28odIMJjbFrjDtZ+R+XcyVGSl
         +1aMekNnRvkqhz0fElkcCx4sk6RX4SFgw8aQVIkw31rRlxPpQkwKKHhPn1Cx6JrTEkS5
         y0Ubof5uS99ClDCIXIJso+Quw7Kizx7tqQSkN4wVarpXW/9HdVKox2/e8AcM/8yzUwBZ
         YHT4TPxUqSToxLYlQd5GU2fSVg5UaNW+GXdr5focjV/ZbQWYl6uw+VN+VxK5Hx8sftjJ
         fiJDwC2VpIk+bQHzXHHdObUxhEPOn9HJ41GSACkYclpdKdPeIzs0iweOydDEWqIpT3tI
         zySQ==
X-Gm-Message-State: ABy/qLaJ00IeMF1wLeNHJ32sAf2vBp0feQVcGaEJocLTNSQPUz1bZXHQ
        mQxAewURMYOQlwPejI81eJU71OKkoLrk1l6VbN434Q==
X-Google-Smtp-Source: APBJJlHfci5eY4p/RZE6lnI2l2YdLECrCtLHmAVkgLDkkj7nPdNt5HWBvk0PfmPVd1Sc0Jzre1QRlRPaQxHbfFnP7I0=
X-Received: by 2002:a5d:514b:0:b0:313:e9d7:108f with SMTP id
 u11-20020a5d514b000000b00313e9d7108fmr4937042wrt.33.1689381027716; Fri, 14
 Jul 2023 17:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
In-Reply-To: <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 14 Jul 2023 17:30:16 -0700
Message-ID: <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Waiman Long <longman@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 13, 2023 at 4:25=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
> > My understanding of mem-stat and cpu-stat is that they are independent
> > of each other. In theory, reading one shouldn't affect the performance
> > of reading the others. Since you are doing mem-stat and cpu-stat readin=
g
> > repetitively in a loop, it is likely that all the data are in the cache
> > most of the time resulting in very fast processing time. If it happens
> > that the specific memory location of mem-stat and cpu-stat data are suc=
h
> > that reading one will cause the other data to be flushed out of the
> > cache and have to be re-read from memory again, you could see
> > significant performance regression.
> >
> > It is one of the possible causes, but I may be wrong.
>
> Do you think it's somewhat similar to how iterating a matrix in rows
> is faster than in columns due to sequential vs random memory reads?
>
> * https://stackoverflow.com/q/9936132
> * https://en.wikipedia.org/wiki/Row-_and_column-major_order
> * https://en.wikipedia.org/wiki/Loop_interchange
>
> I've had a similar suspicion and it would be good to confirm whether
> it's that or something else. I can probably collect perf counters for
> different runs, but I'm not sure which ones I'll need.
>
> In a similar vein, if we could come up with a tracepoint that would
> tell us the amount of work done (or any other relevant metric that
> would help) during rstat flushing, I can certainly collect that
> information as well for every reading combination.

Since cgroup_rstat_flush_locked appears in flamegraphs for both fast
(discrete) and slow (combined) cases, I grabbed some stats for it:

* Slow:

completed: 19.43s [manual / mem-stat + cpu-stat]

$ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to end.
^C
00:12:55
     usecs               : count     distribution
         0 -> 1          : 0        |                                      =
  |
         2 -> 3          : 0        |                                      =
  |
         4 -> 7          : 0        |                                      =
  |
         8 -> 15         : 0        |                                      =
  |
        16 -> 31         : 0        |                                      =
  |
        32 -> 63         : 0        |                                      =
  |
        64 -> 127        : 1        |                                      =
  |
       128 -> 255        : 191      |************                          =
  |
       256 -> 511        : 590      |**************************************=
**|
       512 -> 1023       : 186      |************                          =
  |
      1024 -> 2047       : 2        |                                      =
  |
      2048 -> 4095       : 0        |                                      =
  |
      4096 -> 8191       : 0        |                                      =
  |
      8192 -> 16383      : 504      |**********************************    =
  |
     16384 -> 32767      : 514      |**********************************    =
  |
     32768 -> 65535      : 3        |                                      =
  |
     65536 -> 131071     : 1        |                                      =
  |

avg =3D 8852 usecs, total: 17633268 usecs, count: 1992

* Fast:

completed:  0.95s [manual / mem-stat]
completed:  0.05s [manual / cpu-stat]

$ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to end.
^C
00:13:27
     usecs               : count     distribution
         0 -> 1          : 0        |                                      =
  |
         2 -> 3          : 0        |                                      =
  |
         4 -> 7          : 499      |**************************************=
**|
         8 -> 15         : 253      |********************                  =
  |
        16 -> 31         : 191      |***************                       =
  |
        32 -> 63         : 41       |***                                   =
  |
        64 -> 127        : 12       |                                      =
  |
       128 -> 255        : 2        |                                      =
  |
       256 -> 511        : 2        |                                      =
  |
       512 -> 1023       : 0        |                                      =
  |
      1024 -> 2047       : 0        |                                      =
  |
      2048 -> 4095       : 0        |                                      =
  |
      4096 -> 8191       : 0        |                                      =
  |
      8192 -> 16383      : 34       |**                                    =
  |
     16384 -> 32767      : 21       |*                                     =
  |

avg =3D 857 usecs, total: 904762 usecs, count: 1055

There's a different number of calls into cgroup_rstat_flush_locked and
they are much slower in the slow case. There are also two bands in the
slow case, with 8ms..32ms having the half of the calls.

For mem_cgroup_css_rstat_flush:

* Slow:

completed: 32.77s [manual / mem-stat + cpu-stat]

$ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to end.
^C
00:21:25
     usecs               : count     distribution
         0 -> 1          : 93078    |*                                     =
  |
         2 -> 3          : 3397714  |**************************************=
**|
         4 -> 7          : 1009440  |***********                           =
  |
         8 -> 15         : 168013   |*                                     =
  |
        16 -> 31         : 93       |                                      =
  |

avg =3D 3 usecs, total: 17189289 usecs, count: 4668338

* Fast:

completed:  0.16s [manual / mem-stat]
completed:  0.04s [manual / cpu-stat]

$ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to end.
^C
00:21:57
     usecs               : count     distribution
         0 -> 1          : 1441     |***                                   =
  |
         2 -> 3          : 18780    |**************************************=
**|
         4 -> 7          : 4826     |**********                            =
  |
         8 -> 15         : 732      |*                                     =
  |
        16 -> 31         : 1        |                                      =
  |

avg =3D 3 usecs, total: 89174 usecs, count: 25780

There's an 181x difference in the number of calls into
mem_cgroup_css_rstat_flush.

Does this provide a clue? Perhaps cgroup_rstat_cpu_pop_updated is
yielding a ton more iterations for some reason here?

* https://elixir.bootlin.com/linux/v6.1/source/kernel/cgroup/rstat.c#L196

It's inlined, but I can place a probe into the loop:

      7         for_each_possible_cpu(cpu) {
      8                 raw_spinlock_t *cpu_lock =3D
per_cpu_ptr(&cgroup_rstat_cpu_lock,
                                                               cpu);
     10                 struct cgroup *pos =3D NULL;
                        unsigned long flags;

                        /*
                         * The _irqsave() is needed because cgroup_rstat_lo=
ck is
                         * spinlock_t which is a sleeping lock on
PREEMPT_RT. Acquiring
                         * this lock with the _irq() suffix only
disables interrupts on
                         * a non-PREEMPT_RT kernel. The raw_spinlock_t
below disables
                         * interrupts on both configurations. The
_irqsave() ensures
                         * that interrupts are always disabled and
later restored.
                         */
                        raw_spin_lock_irqsave(cpu_lock, flags);
                        while ((pos =3D
cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
                                struct cgroup_subsys_state *css;

                                cgroup_base_stat_flush(pos, cpu);
     26                         bpf_rstat_flush(pos, cgroup_parent(pos), cp=
u);

     28                         rcu_read_lock();
     29                         list_for_each_entry_rcu(css,
&pos->rstat_css_list,
                                                        rstat_css_node)
     31                                 css->ss->css_rstat_flush(css, cpu);
     32                         rcu_read_unlock();
                        }
     34                 raw_spin_unlock_irqrestore(cpu_lock, flags);

I added probes on both line 26 and line 31 to catch the middle and inner lo=
ops.

* Slow:

completed: 32.97s [manual / mem-stat + cpu-stat]

 Performance counter stats for '/tmp/derp':

         4,702,570      probe:cgroup_rstat_flush_locked_L26
         9,301,436      probe:cgroup_rstat_flush_locked_L31

* Fast:

completed:  0.17s [manual / mem-stat]
completed:  0.34s [manual / cpu-stat]

 Performance counter stats for '/tmp/derp':

            31,769      probe:cgroup_rstat_flush_locked_L26
            62,849      probe:cgroup_rstat_flush_locked_L31

It definitely looks like cgroup_rstat_cpu_pop_updated is yielding a
lot more positions.

I'm going to sign off for the week, but let me know if I should place
any more probes to nail this down.
