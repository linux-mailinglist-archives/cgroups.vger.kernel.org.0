Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF185844F7
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiG1R0s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 13:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiG1R0q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 13:26:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4512D1D
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 10:26:44 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x11so1582774qts.13
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=id4JWD15x2b6Sb0RDjkodbSRKI5pJBPMhp/NyAFO6Wg=;
        b=ZIv6KqB5YatdsGxiUke6mhx2cB60Jg0nC16W2vfPQN0fh/N7+rSg2esvcPFp3oQ0Qo
         VHjyWTcrZS4B2xIeRUQg3Gp6mFclRSXQTuXEq4EBLT9560pu4oKuV2IcCmrPaN3K57YD
         fqkWbB62X3m1yLgVGqW29+TyZDcTl05KFRbvNOhw5qm4araf+Og1cnkexpRLSmrnqH+e
         8dEi+uSiErW4xqdWg5wBrqWGS+eC2RKjvCWmK/k9Lgkgpintww82349+3yFfSGnbrQL3
         TI8oLqq57xt37hUMYpK9bVuJrreQjyuyOPW6IV+epVfGVfQiPKHIQpUL5j+bEfgLBWYK
         qA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=id4JWD15x2b6Sb0RDjkodbSRKI5pJBPMhp/NyAFO6Wg=;
        b=ORRbk1mhZMpmfxj0VVD5sDNer3UMoYzcQa9Ly0RwBoxwWez1DmEULNeuZq+k42FOVq
         vSyDrJHszbVfFBvSNV1AWT2WyBIGBuryaNoA1oM/bABILPK64342e5HWnRZpvEVqXK0n
         ecAuhCkVoxLqNcWqPGGNRW9z1IufiAgJGGBOti/Z/vplZk/tkqfNdGxtTptUnvxwIwQu
         qwQj1+trZ/tI1pZvFvB8ksn/ftZbhhuw+IfCx3ap+Fe2gV3aIWwBCI8NL80HjN2UD6TM
         taG6WbxUh2ztoFG5X6/Ox2AWtztiW/ectzIb92Ml49Kn5kT2lDDyj/Sl/hD7aaAODOAL
         V4Gw==
X-Gm-Message-State: AJIora+JOSGPLuTGN9907+Jby2kp8sOuZ7/QTXo+6KYFAP7kgqPQrPea
        NYhTjqOLk2tD9852Ijlo1y5ZQIKOIfjbpSOuHq2A6g==
X-Google-Smtp-Source: AGRyM1uNmkDF5eUWmMWUtxx54+WWPwsyJAA0KcJodRCj9w6qDWXJAZ+hAkiFyUDpP6ZiTN1NX5HGQAfcJfwPt0YolLI=
X-Received: by 2002:a05:622a:54a:b0:31f:3822:7009 with SMTP id
 m10-20020a05622a054a00b0031f38227009mr7489qtx.478.1659029203831; Thu, 28 Jul
 2022 10:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174829.3422466-1-yosryahmed@google.com>
 <20220722174829.3422466-5-yosryahmed@google.com> <CAP01T76p7CCj2i4X7PmZiG3G3-Bfx_ygnO0Eg+DnfwLHQiEPbA@mail.gmail.com>
 <CA+khW7g2kriOb7on0u_UpGpS2A0bftrQowTB0+AJ=S7rpLKaZA@mail.gmail.com> <639f575e-bc8c-46b9-b21b-bd9fbba835c1@fb.com>
In-Reply-To: <639f575e-bc8c-46b9-b21b-bd9fbba835c1@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 28 Jul 2022 10:26:32 -0700
Message-ID: <CA+khW7gws1+bWQ2zpodVfAP_rtXv=8K3SSMLx4e9Lh4eKgtnmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/8] bpf: Introduce cgroup iter
To:     Yonghong Song <yhs@fb.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 27, 2022 at 11:56 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/22/22 1:33 PM, Hao Luo wrote:
> > On Fri, Jul 22, 2022 at 11:36 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >>
> >> On Fri, 22 Jul 2022 at 19:52, Yosry Ahmed <yosryahmed@google.com> wrote:
<...>
> >>> +
> >>> +static int __cgroup_iter_seq_show(struct seq_file *seq,
> >>> +                                 struct cgroup_subsys_state *css, int in_stop);
> >>> +
> >>> +static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
> >>> +{
> >>> +       /* pass NULL to the prog for post-processing */
> >>> +       if (!v)
> >>> +               __cgroup_iter_seq_show(seq, NULL, true);
> >>> +       mutex_unlock(&cgroup_mutex);
> >>
> >> I'm just curious, but would it be a good optimization (maybe in a
> >> follow up) to move this mutex_unlock before the check on v? That
> >> allows you to store/buffer some info you want to print as a compressed
> >> struct in a map, then write the full text to the seq_file outside the
> >> cgroup_mutex lock in the post-processing invocation.
> >>
> >> It probably also allows you to walk the whole hierarchy, if one
> >> doesn't want to run into seq_file buffer limit (or it can decide what
> >> to print within the limit in the post processing invocation), or it
> >> can use some out of band way (ringbuf, hashmap, etc.) to send the data
> >> to userspace. But all of this can happen without holding cgroup_mutex
> >> lock.
> >
> > Thanks Kumar.
> >
> > It sounds like an idea, but the key thing is not about moving
> > cgroup_mutex unlock before the check IMHO. The user can achieve
> > compression using the current infra. Compression could actually be
> > done in the bpf program. user can define and output binary content and
> > implement a userspace library to parse/decompress when reading out the
> > data.
>
> Right mutex_unlock() can be moved to the beginning of the
> function since the cgroup is not used in
>    __cgroup_iter_seq_show(seq, NULL, true)

Ok. Will do.
