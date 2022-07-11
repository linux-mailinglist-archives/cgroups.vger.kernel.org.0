Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C756D472
	for <lists+cgroups@lfdr.de>; Mon, 11 Jul 2022 08:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGKGBg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Jul 2022 02:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGKGBf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Jul 2022 02:01:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933ED186FA
        for <cgroups@vger.kernel.org>; Sun, 10 Jul 2022 23:01:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d18so5025855qtw.8
        for <cgroups@vger.kernel.org>; Sun, 10 Jul 2022 23:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrs4ZeeiZ30d9zxxyd0TAMHLWBLjUqpYMMgWU2Rjksk=;
        b=o3x3uU7aTeQVHBt9dwXxqVH+LURiGmbgWGv5f2lh+MhkWW4Q7M5Y/2XQRL5kRjmkWZ
         QmRVk9DIMPYjwfTrYCTnZwgjSm1ixtdCNp5H0px54eUWOm0QHnab+EhPXGqNlJPUkkwT
         Gs6caZOS3WNlZxB3pffmztHLVrAdk1CWK/lzXMN4jw9nj/xITQ1o3hhBG8LNs1Bs+AO6
         mhq5c0pMM5Y+77LuJ+6TFHuhMdoT4DE9sa51o977kpXqiQIKPfJm2ZrBUTldF0J6uY5z
         KWAuvN0v+AyzBHVSKPxPW1fxGbVvjPi2fvqXXZIdyMfpCksQrsIXFdnyxxqCGVQyQzHU
         Qeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrs4ZeeiZ30d9zxxyd0TAMHLWBLjUqpYMMgWU2Rjksk=;
        b=J5eB640ILBzHXtDWX+ljGiyrY7dXipIqKVSwdwFLq/UDuvf5pO59xd2Bv5F3ZB88Ac
         sym4WcBhp+GFXn57WAaIeWueqx5fd9ifAoZrb1kkdofwU8p4ky9yOZ9R8pCDYgRy+Rj8
         snBJ6GcnscTBCaw+khF1za+2MxgaOxbf0wvCe2gSV+sEutEXXA+HTx+aaGlIv59y1BDZ
         aEjVAtlAtRFIxf+DCWz3XvNlPA0Lo8T9Mbxw3nn8tBu1KqJo7NhJQKWlIDqZfWs/d0mA
         TPEbCGnVdF08CPmS1tHq4Cj+vWktv3F1YhHzZWAHD/ow6RoFQ8CFkknXLkee5zGPQVrw
         aH1w==
X-Gm-Message-State: AJIora9sc+DAJx9BN/ZxySYJFdp0RaFqyisvHAUJtPoE+ug9WfeBZNff
        aapOdIsneDdN8hnZA3h6FShLSjcSRYrz3wuDmiKGtw==
X-Google-Smtp-Source: AGRyM1vllFid1RbeSo6O7xIbgqpuO85Yi4h9D30bhqakvzDSShcLExy1LgBZ1hedgDp9i78qZ+EUHEmzN87T5VlmN50=
X-Received: by 2002:a05:622a:87:b0:31d:3cf5:6ac8 with SMTP id
 o7-20020a05622a008700b0031d3cf56ac8mr12638939qtw.565.1657519293380; Sun, 10
 Jul 2022 23:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220709000439.243271-1-yosryahmed@google.com>
 <20220709000439.243271-9-yosryahmed@google.com> <b4936952-2fe7-656c-2d0d-69044265392a@fb.com>
 <9c6a0ba3-2730-eb56-0f96-e5d236e46660@fb.com>
In-Reply-To: <9c6a0ba3-2730-eb56-0f96-e5d236e46660@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Sun, 10 Jul 2022 23:01:22 -0700
Message-ID: <CA+khW7gu73pRFi73BR20OCJhzrs8-kHfTYYR38+MJUpt6wqXoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] bpf: add a selftest for cgroup
 hierarchical stats collection
To:     Yonghong Song <yhs@fb.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jul 10, 2022 at 5:51 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/10/22 5:26 PM, Yonghong Song wrote:
[...]
>
> BTW, CI also reported the test failure.
> https://github.com/kernel-patches/bpf/pull/3284
>
> For example, with gcc built kernel,
> https://github.com/kernel-patches/bpf/runs/7272407890?check_suite_focus=true
>
> The error:
>
>    get_cgroup_vmscan_delay:PASS:cgroup_id 0 nsec
>    get_cgroup_vmscan_delay:PASS:vmscan_reading 0 nsec
>    check_vmscan_stats:FAIL:child1_vmscan unexpected child1_vmscan:
> actual 28390910 != expected 28390909
>    check_vmscan_stats:FAIL:child2_vmscan unexpected child2_vmscan:
> actual 0 != expected -2
>    check_vmscan_stats:PASS:test_vmscan 0 nsec
>    check_vmscan_stats:PASS:root_vmscan 0 nsec
>

Yonghong,

I noticed that the test only failed on test_progs-no_alu32, not
test_progs. test_progs passed. I believe Yosry and I have only tested
on test_progs. I tried building and running the no_alu32 version, but
so far, not able to run test_progs-no_alu32. Whenever I ran
test_progs-no_alu32, it exits without any message. Do you have any
clue what could be wrong?

> >
[...]
