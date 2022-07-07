Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3756AF13
	for <lists+cgroups@lfdr.de>; Fri,  8 Jul 2022 01:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiGGXgh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Jul 2022 19:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiGGXgg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Jul 2022 19:36:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3092CE12
        for <cgroups@vger.kernel.org>; Thu,  7 Jul 2022 16:36:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c13so25087795qtq.10
        for <cgroups@vger.kernel.org>; Thu, 07 Jul 2022 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XH4cPztGrQqsT+SfmP8eyqdVMM+gtgpNj/VjG8VG1nM=;
        b=RFDw+QHkFGDIWwRdYchdMvdzsKCZaAPs4rT4ufLkxWlPRK1TI6fo0tjk8JODZtXKd4
         O72HgDCHviGjhjlEXZIeWeRgMHge4ii8LtPQRk1ZM82WyleakaHT/bxJQNT7uYoRE8yd
         SOGYpBPdjvDJJFdnTOaO+cMv6a2l85flA9T+BpAnhJq3g+mfulEU+5cpzBnFASy/TLUZ
         N9Cwcsd0p4otAVw0a9HYeTSCK1Sxz4CS2n9g8UPBtXsPDroiRwmeHTmafUJH0EaJcSGS
         O/nPs75YVwnKxl4fHAQR8KMDd+7m3K4UhR5DhjExN/y7NOq4kENl9IZ+KDKOPDR2/Q/9
         7jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XH4cPztGrQqsT+SfmP8eyqdVMM+gtgpNj/VjG8VG1nM=;
        b=StEBp692xxP3gSkQ9Dehqmik4tMpnY6L3zj91ZjYwOEJL4GreyIqIoOPPn8bXWrWN4
         7WBrzhaq2kxnQ9Mh+UXHdk6rnENXerc0S3lFtxwxAiear3FQYBIp//lhHj3E9lMKG2P0
         JsVzMGsF69MpWtR9/m5cmDYlgGQipkaUzEuqZyP0OrhH8dFnmDqAOilWoto3PJHnZaMU
         oVsu4RBAq9uIUc8DRTz8t/lqBs77qdUSY+2WnWJiY5phbHlTvIB/QvHw2JMt9G9R0b8U
         IcR0cCrzvPE/Q+VWCzH97lRSnE+Goo32/MkyVymUd4q4BV0J5euKF37wnFoUZZZsYLIP
         Rqrw==
X-Gm-Message-State: AJIora/Kys+AKHUhG01hXEN0VgXk+3o2JpkNno1zuWI/eS4Kh8DaX4Ki
        OU0XaHezwjZHR7AAn4EPEhClDRoWh61gtJW6J7rjzw==
X-Google-Smtp-Source: AGRyM1sBme6J6p5RCO5xjhv3NKpjQ0wj5ST2F+p/Xh1EL/z7+dP5eFQHgL71McKnLl+LsLYXpBQv/G7H5+l03mEnHyY=
X-Received: by 2002:a05:6214:c6c:b0:470:a322:6777 with SMTP id
 t12-20020a0562140c6c00b00470a3226777mr501392qvj.85.1657236994169; Thu, 07 Jul
 2022 16:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
 <20220610194435.2268290-5-yosryahmed@google.com> <40114462-d5e2-ab07-7af9-5e60180027f9@fb.com>
In-Reply-To: <40114462-d5e2-ab07-7af9-5e60180027f9@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 7 Jul 2022 16:36:23 -0700
Message-ID: <CA+khW7hqVbNWFbZcJz2QWV=c5SD1ci5KOD+t4drYt2-yqpyNTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/8] bpf: Introduce cgroup iter
To:     Yonghong Song <yhs@fb.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 9:14 PM Yonghong Song <yhs@fb.com> wrote:
>
> > +static int __cgroup_iter_seq_show(struct seq_file *seq,
> > +                               struct cgroup_subsys_state *css, int in_stop)
> > +{
> > +     struct cgroup_iter_priv *p = seq->private;
> > +     struct bpf_iter__cgroup ctx;
> > +     struct bpf_iter_meta meta;
> > +     struct bpf_prog *prog;
> > +     int ret = 0;
> > +
> > +     /* cgroup is dead, skip this element */
> > +     if (css && cgroup_is_dead(css->cgroup))
> > +             return 0;
> > +
> > +     ctx.meta = &meta;
> > +     ctx.cgroup = css ? css->cgroup : NULL;
> > +     meta.seq = seq;
> > +     prog = bpf_iter_get_info(&meta, in_stop);
> > +     if (prog)
> > +             ret = bpf_iter_run_prog(prog, &ctx);
>
> Do we need to do anything special to ensure bpf program gets
> up-to-date stat from ctx.cgroup?
>

Let's leave that to be handled by bpf programs. The kfunc rstat_flush
can be called to sync stats, if using rstat.

> > +
> > +     /* if prog returns > 0, terminate after this element. */
> > +     if (ret != 0)
> > +             p->terminate = true;
> > +
> > +     return 0;
> > +}
> > +
> [...]
