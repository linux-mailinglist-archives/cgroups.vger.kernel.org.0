Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267FD5F189F
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiJACbj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 22:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiJACba (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 22:31:30 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21826125D96;
        Fri, 30 Sep 2022 19:31:29 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-127dca21a7dso7399296fac.12;
        Fri, 30 Sep 2022 19:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TsSNtaxjzzrx0UGRlq15EZuhaugUhUgclS9Wef+tMjA=;
        b=kaUDziaMuKIsPXEo1NARHh6a8YfZ7PCTfT9/4dAjqpR1bf7i+xcJ+KXsWgHIhBDvkI
         JyQ+EdlsDdcxuF9aOGcUepMhWYcm9C1g3lnYzHHVa5b7EYKeLATDa0zLEuPUNEU9P3YO
         Nt8O77O95l+WMszY3azrrXe69g8wnGfeWyLTGRbcrMAQ5JPL/mMHnSsGRd32WHYpbg+c
         C4GykgbpKh5wT/NxS/elCsl2I4DS8lErGfc2QUF26gOP0OVEA3e76U98pSbE4zzxkzp8
         S7/oa9rLAl0zV6WcfCd+tEn1sr33bh/6g9m4Kpc44ghgOeHlaiP7hrx2LB3amS4AfAzJ
         PzCw==
X-Gm-Message-State: ACrzQf1tvtUwA/re8/D1Axjh/vL0NekT2nqHFRDTVHZ9ZsQvlH2rNIZQ
        9XUME8csjIwd9HY4eiO4szaPyCJjLpRStqInWT8=
X-Google-Smtp-Source: AMsMyM7Yi1zPsDiXRfU1bZZHzwmu8SBCTd/6ZNM+dwKzBgmouEYVAxUpY+L4PS/jzdxYlVAY+5ffaUbRPOpty+fg9hQ=
X-Received: by 2002:a05:6871:14f:b0:131:a644:7c58 with SMTP id
 z15-20020a056871014f00b00131a6447c58mr469446oab.209.1664591488387; Fri, 30
 Sep 2022 19:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org> <CAEf4BzZhHYYOmNhLdrpsXSDE5kaXvgSN00X-8aAySDwAKX0RCw@mail.gmail.com>
In-Reply-To: <CAEf4BzZhHYYOmNhLdrpsXSDE5kaXvgSN00X-8aAySDwAKX0RCw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Sep 2022 19:31:17 -0700
Message-ID: <CAM9d7ch8RUgf8V1hi=ccgV84XSfujuWtUKKgre8eQdGmtdiFLA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 30, 2022 at 3:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 21, 2022 at 9:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The recent change in the cgroup will break the backward compatiblity in
> > the BPF program.  It should support both old and new kernels using BPF
> > CO-RE technique.
> >
> > Like the task_struct->__state handling in the offcpu analysis, we can
> > check the field name in the cgroup struct.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > Arnaldo, I think this should go through the cgroup tree since it depends
> > on the earlier change there.  I don't think it'd conflict with other
> > perf changes but please let me know if you see any trouble, thanks!
> >
> >  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 29 ++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > index 488bd398f01d..4fe61043de04 100644
> > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > @@ -43,12 +43,39 @@ struct {
> >         __uint(value_size, sizeof(struct bpf_perf_event_value));
> >  } cgrp_readings SEC(".maps");
> >
> > +/* new kernel cgroup definition */
> > +struct cgroup___new {
> > +       int level;
> > +       struct cgroup *ancestors[];
> > +} __attribute__((preserve_access_index));
> > +
> > +/* old kernel cgroup definition */
> > +struct cgroup___old {
> > +       int level;
> > +       u64 ancestor_ids[];
> > +} __attribute__((preserve_access_index));
> > +
> >  const volatile __u32 num_events = 1;
> >  const volatile __u32 num_cpus = 1;
> >
> >  int enabled = 0;
> >  int use_cgroup_v2 = 0;
> >
> > +static inline __u64 get_cgroup_v1_ancestor_id(struct cgroup *cgrp, int level)
> > +{
> > +       /* recast pointer to capture new type for compiler */
> > +       struct cgroup___new *cgrp_new = (void *)cgrp;
> > +
> > +       if (bpf_core_field_exists(cgrp_new->ancestors)) {
> > +               return BPF_CORE_READ(cgrp_new, ancestors[level], kn, id);
>
> have you checked generated BPF code for this ancestors[level] access?
> I'd expect CO-RE relocation for finding ancestors offset and then just
> normal + level * 8 arithmetic, but would be nice to confirm. Apart
> from this, looks good to me:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for your review!

How can I check the generated code?  Do you have something works with
skeletons or do I have to save the BPF object somehow during the build?

Thanks,
Namhyung
