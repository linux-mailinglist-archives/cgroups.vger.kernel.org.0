Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1395F164E
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiI3Wsy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 18:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiI3Wsw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 18:48:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9095208540;
        Fri, 30 Sep 2022 15:48:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a41so7739111edf.4;
        Fri, 30 Sep 2022 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLr4Pui1WgAmc20FBE5q6rikXP7BZ6KUet36h8qjGrQ=;
        b=j/f7sU21OUk8kPvxztuKT5RBnJwNT0hXLpzsQ2xrK8zgdjoKihE425h6cOYq7h8jhD
         BmxZbSm/gW8kVMpISmmD6SmOhUiguGYs3Byys1w0Zy/P5QefmjDN12gsnBW6Uu9rErAV
         2DQ9bm7dg3CJ0lrxl4Ve6NJKftG/Xhn9/KRS3DDC67P7MX3DpgTnenITb5tI0RQ5xZyy
         oR4A5OHpMMIMgU+H/r23k4CLd2+TsRJJSmrgQYH+3ep+SOIkv2qjR8KU+cAA9kahCs3U
         gZmgCXIfFNHDAMFICPmTEmNcXOPnX4gUI30gKgEFSVPw/z2AA+hk8rPtCHbY8RqZi+cq
         0w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLr4Pui1WgAmc20FBE5q6rikXP7BZ6KUet36h8qjGrQ=;
        b=vJH3malLD4HZ4s9+ziFpMIS7C45I6kUV60JBR2jzwsC69uJz+bxxIDMKGNeekbYMsB
         vykOxzCgc/ERhChs5uC0kq/BPQJSXGHm5VPrI6YhZc4BOCAWlY5y+pbsh+SPqWQ5y4d3
         6IYPqNCeK6Sp40cqKnYa/UAHyWQtrU4QAlgYjqkYD49sAUGjl7bq9V2ARyfV5pPUEZsR
         DfVrBnMGVJQ7V8Py4qUbztKugcImQAFD5mXALd8lVFuxDHUBpgA2MurDaXXXL1ugpoxH
         cnnUl3HWXCwrj9RnMVYhK+C7oKmnn2z1nRTwxsKVaCjNc3lv3Fgvq3OxiXFaIQA+f89n
         uVVw==
X-Gm-Message-State: ACrzQf2mpOYKIIVyjLLZEVCWe3knOulgjk6sqqqJ16BxjCLErRBi4qIu
        Czi6pIaO1jQYcqGoSFybjdVgx65ym2oBpnuNF/s=
X-Google-Smtp-Source: AMsMyM6kTaPp82RsLTBIdE70LtBvlGZA+t4Za7Bc6FSdfkfXXiVShoLTuXXi46uwlWdfAFNxKLU+vhua46T/vwC6Wdg=
X-Received: by 2002:a05:6402:518e:b0:452:49bc:179f with SMTP id
 q14-20020a056402518e00b0045249bc179fmr9659877edd.224.1664578129257; Fri, 30
 Sep 2022 15:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org>
In-Reply-To: <20220922041435.709119-1-namhyung@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 15:48:37 -0700
Message-ID: <CAEf4BzZhHYYOmNhLdrpsXSDE5kaXvgSN00X-8aAySDwAKX0RCw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
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

On Wed, Sep 21, 2022 at 9:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The recent change in the cgroup will break the backward compatiblity in
> the BPF program.  It should support both old and new kernels using BPF
> CO-RE technique.
>
> Like the task_struct->__state handling in the offcpu analysis, we can
> check the field name in the cgroup struct.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> Arnaldo, I think this should go through the cgroup tree since it depends
> on the earlier change there.  I don't think it'd conflict with other
> perf changes but please let me know if you see any trouble, thanks!
>
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 29 ++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 488bd398f01d..4fe61043de04 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -43,12 +43,39 @@ struct {
>         __uint(value_size, sizeof(struct bpf_perf_event_value));
>  } cgrp_readings SEC(".maps");
>
> +/* new kernel cgroup definition */
> +struct cgroup___new {
> +       int level;
> +       struct cgroup *ancestors[];
> +} __attribute__((preserve_access_index));
> +
> +/* old kernel cgroup definition */
> +struct cgroup___old {
> +       int level;
> +       u64 ancestor_ids[];
> +} __attribute__((preserve_access_index));
> +
>  const volatile __u32 num_events = 1;
>  const volatile __u32 num_cpus = 1;
>
>  int enabled = 0;
>  int use_cgroup_v2 = 0;
>
> +static inline __u64 get_cgroup_v1_ancestor_id(struct cgroup *cgrp, int level)
> +{
> +       /* recast pointer to capture new type for compiler */
> +       struct cgroup___new *cgrp_new = (void *)cgrp;
> +
> +       if (bpf_core_field_exists(cgrp_new->ancestors)) {
> +               return BPF_CORE_READ(cgrp_new, ancestors[level], kn, id);

have you checked generated BPF code for this ancestors[level] access?
I'd expect CO-RE relocation for finding ancestors offset and then just
normal + level * 8 arithmetic, but would be nice to confirm. Apart
from this, looks good to me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> +       } else {
> +               /* recast pointer to capture old type for compiler */
> +               struct cgroup___old *cgrp_old = (void *)cgrp;
> +
> +               return BPF_CORE_READ(cgrp_old, ancestor_ids[level]);
> +       }
> +}
> +
>  static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  {
>         struct task_struct *p = (void *)bpf_get_current_task();
> @@ -70,7 +97,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>                         break;
>
>                 // convert cgroup-id to a map index
> -               cgrp_id = BPF_CORE_READ(cgrp, ancestors[i], kn, id);
> +               cgrp_id = get_cgroup_v1_ancestor_id(cgrp, i);
>                 elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
>                 if (!elem)
>                         continue;
> --
> 2.37.3.968.ga6b4b080e4-goog
>
