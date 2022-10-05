Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A195F5CC3
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 00:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJEWgx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 18:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJEWgw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 18:36:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800036068D;
        Wed,  5 Oct 2022 15:36:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z23so686745ejw.12;
        Wed, 05 Oct 2022 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IDa4zO8fjCrFtrwiC0X35h30/CNk4qiLrUvMAkxVAs=;
        b=bm30/cArbm6oXF4zz1/TtHAWlji0iXVLwmqbQ8S+eX+WoOj3CAuuIz6pZTPsG/T+x8
         tQuWs0gvBC5SG/yfefFxVY2DB4LqAzzAd3/kN3emfJiPT5otMXw6F8Hnsig2FHnJaswi
         xyU6sVIQ9t48MFF1pB5zpnyNuo7f/Wo9gQ06BgxfSzrZoPS2PIzQIvz5rH2Hj7CZltvw
         EE1cHiLJW3Nx55kuMDHjzlm9+iSe749VmzE7X20P54yDycBMuaOEnnipVWFVMwzetjq3
         AKlp0g8DBThkQM/uQSi27PJN7F3IdQi14TUpoO/hPCY/hN+X3QmV/7eRYIMax/s3LrUe
         Xb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IDa4zO8fjCrFtrwiC0X35h30/CNk4qiLrUvMAkxVAs=;
        b=qzuCWCR6ngV6dgCpqns9lefekJxeUGQIBdT9Gi/VYBo99BU26YgGP2yw4y0tSF28H/
         qpEJpZTv2SibFDKOl2UuJkT6W0ZUd90EcfSIUWjq46tHRglxqxW0fUwtAtolQSZRaiTk
         zS0MFDpHFcZSvAv8wMPz5voM5q/cA0nFe4Aox2IxiMuqozlhClX01b4tCaGUNxl6yQgD
         Z7e0gYXFmE58NUkqJ+j4XG+kZtIg47i3wu9+U1BGL2I1d8qCBwZyf8FxVByjThQXBOBn
         DqmCusMBI1i71HVZK2+PNoNhxK12rtN+g8yaAT2RLuJdEdzIgUE+Rq1cDh95CcR1mdcP
         sQvg==
X-Gm-Message-State: ACrzQf1cvl+XHXcTCRxZkkEOhI3oqo8yuWg5mqPOxnh20YK/cGvQGajU
        n+FZahYFaCa3+Ju89UpEmdcec49QPY7ud9l0HDg=
X-Google-Smtp-Source: AMsMyM6/ch5wARIR0pg7YHIz3pTGEEc2KZkCtkscs8/h76CNWrKne/Is4+U0XiChE9jAPq+RWQvCYZ3IQuYcLKFMbJI=
X-Received: by 2002:a17:906:5a4c:b0:78c:c893:74e6 with SMTP id
 my12-20020a1709065a4c00b0078cc89374e6mr1475975ejc.545.1665009409931; Wed, 05
 Oct 2022 15:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org> <CAEf4BzZhHYYOmNhLdrpsXSDE5kaXvgSN00X-8aAySDwAKX0RCw@mail.gmail.com>
 <CAM9d7ch8RUgf8V1hi=ccgV84XSfujuWtUKKgre8eQdGmtdiFLA@mail.gmail.com>
In-Reply-To: <CAM9d7ch8RUgf8V1hi=ccgV84XSfujuWtUKKgre8eQdGmtdiFLA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 15:36:37 -0700
Message-ID: <CAEf4Bza0dt6v8YLNvQbANH+O9E5naZZj1cc4H6j=KK9WQcym8w@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 30, 2022 at 7:31 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Fri, Sep 30, 2022 at 3:48 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Sep 21, 2022 at 9:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The recent change in the cgroup will break the backward compatiblity in
> > > the BPF program.  It should support both old and new kernels using BPF
> > > CO-RE technique.
> > >
> > > Like the task_struct->__state handling in the offcpu analysis, we can
> > > check the field name in the cgroup struct.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > Arnaldo, I think this should go through the cgroup tree since it depends
> > > on the earlier change there.  I don't think it'd conflict with other
> > > perf changes but please let me know if you see any trouble, thanks!
> > >
> > >  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 29 ++++++++++++++++++++-
> > >  1 file changed, 28 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > index 488bd398f01d..4fe61043de04 100644
> > > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > > @@ -43,12 +43,39 @@ struct {
> > >         __uint(value_size, sizeof(struct bpf_perf_event_value));
> > >  } cgrp_readings SEC(".maps");
> > >
> > > +/* new kernel cgroup definition */
> > > +struct cgroup___new {
> > > +       int level;
> > > +       struct cgroup *ancestors[];
> > > +} __attribute__((preserve_access_index));
> > > +
> > > +/* old kernel cgroup definition */
> > > +struct cgroup___old {
> > > +       int level;
> > > +       u64 ancestor_ids[];
> > > +} __attribute__((preserve_access_index));
> > > +
> > >  const volatile __u32 num_events = 1;
> > >  const volatile __u32 num_cpus = 1;
> > >
> > >  int enabled = 0;
> > >  int use_cgroup_v2 = 0;
> > >
> > > +static inline __u64 get_cgroup_v1_ancestor_id(struct cgroup *cgrp, int level)
> > > +{
> > > +       /* recast pointer to capture new type for compiler */
> > > +       struct cgroup___new *cgrp_new = (void *)cgrp;
> > > +
> > > +       if (bpf_core_field_exists(cgrp_new->ancestors)) {
> > > +               return BPF_CORE_READ(cgrp_new, ancestors[level], kn, id);
> >
> > have you checked generated BPF code for this ancestors[level] access?
> > I'd expect CO-RE relocation for finding ancestors offset and then just
> > normal + level * 8 arithmetic, but would be nice to confirm. Apart
> > from this, looks good to me:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks for your review!
>
> How can I check the generated code?  Do you have something works with
> skeletons or do I have to save the BPF object somehow during the build?
>

skeleton is generated from ELF BPF object file. You can do
llvm-objdump -d <obj.bpf.o> to see instructions. Unfortunately you
can't see BPF CO-RE relocations this way, you'd have to use something
like my custom tool ([0]).

But anyways, I checked locally similar code pattern and I think it's
all good from BPF CO-RE perspective. I see appropriate relocations in
all the necessary places. So this should work.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

  [0] https://github.com/anakryiko/btfdump

> Thanks,
> Namhyung
