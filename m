Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85A53EEC5
	for <lists+cgroups@lfdr.de>; Mon,  6 Jun 2022 21:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiFFTlr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jun 2022 15:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiFFTlq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jun 2022 15:41:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B7ED3C5
        for <cgroups@vger.kernel.org>; Mon,  6 Jun 2022 12:41:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h5so21242081wrb.0
        for <cgroups@vger.kernel.org>; Mon, 06 Jun 2022 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9yJbx0i06GNbf8v7gInYN9hw57l8mmMKWeeJflk0qEI=;
        b=OfvEIo74VLd9T5IwhXy5EMZxZvHlk4ZiGd7W3x3BSiifBAa2m3eM7+P6GPdioIC0Qn
         iz6ZKfl/E1j1awO/0mJ51oC6k4LOuwaAlWqWPzNM+SuMDSeeyGIIGwgQU9iaetClFXA4
         2F0EHH1Wesx4Auk9Qp16xrq/u4OxkVDuXgbmHdGQWwflbQeqFjx95Mk6emG7pXdBU41G
         3NOtqqJsLeFht46E4vKE8nMQCMQrk5T7oswlFJLm+zjSAp54SqwK64fs7Gs6gUDSoijw
         GLxqGoBFMP7+UTCl1x9R8zJq26z9FFrFzDIAHxntIj10oKxJPrtwb2l3/EvgoowqzGl6
         /YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9yJbx0i06GNbf8v7gInYN9hw57l8mmMKWeeJflk0qEI=;
        b=yUJKoSTEw7Ug8xZY2Pg2QMvFBHeqGenBrqUi69/P5q9CtSQlVyePsbVQgiD0hZjx6V
         WLZXS8rzX3PVpYo8vmfvnmqlLYnHl1hGRqNnx8qk+Hg7JKlL0FR02izVF+O1RKfgebqW
         TrnV7jDrjyReB7XOUS4bvdaJMTcQeBIudhycElAAiC659vKHpNCQRHsp9OGME6cr+LaH
         4UhBVJuIMaimenGi6neKQFO7Ks0DKBRoCJBbrxcbWFV1ORquwNRB+Ew76qi5+skJ45js
         nn6Oacgs5Ay0nZ0Rx1NAUMFYroZxeJJFHQFkojfKEzg7+v2fAv8BsBFgNXdV6Gps4BLB
         aPeQ==
X-Gm-Message-State: AOAM531PX7INJflFEW+vuq3gJViW5u5SftBoqOynm1oCHYT/CGSoqeYk
        h+ALUAc8DDx9i+YIqcqR/ly/f0w06jZjy0JldeBHJg==
X-Google-Smtp-Source: ABdhPJwKE3oJwxygAKjMumZvwdl1/otPjldbrkO/5D8AlW9o41lzGar3s4aoJv5kxNLWsT97LTDBftvGw8978dyAwgQ=
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id
 c5-20020adffb05000000b0020ae1138f3fmr23580389wrr.534.1654544502734; Mon, 06
 Jun 2022 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220520012133.1217211-1-yosryahmed@google.com>
 <20220520012133.1217211-6-yosryahmed@google.com> <20220603162339.GA25043@blackbody.suse.cz>
 <CAJD7tkYwU5dW9Oof+pC81R9Bi-F=-EuiXpTn+HDeqbhTOTCcuw@mail.gmail.com> <20220606123222.GA4377@blackbody.suse.cz>
In-Reply-To: <20220606123222.GA4377@blackbody.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Jun 2022 12:41:06 -0700
Message-ID: <CAJD7tkbi7Gnnf4NiUt-J61G7185NsRcySvP6qOQsFKMou7qZJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/5] bpf: add a selftest for cgroup
 hierarchical stats collection
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 6, 2022 at 5:32 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Fri, Jun 03, 2022 at 12:52:27PM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > Good catch. I get confused between cgrp->subsys and
> > task->cgroups->subsys sometimes because of different fallback
> > behavior. IIUC cgrp->subsys should have NULL if the memory controller
> > is not enabled (no nearest ancestor fallback), and hence I can use
> > memory_subsys_enabled() that I defined just above task_memcg() to test
> > for this (I have no idea why I am not already using it here). Is my
> > understanding correct?
>
> You're correct, css_set (task->cgroups) has a css (memcg) always defined
> (be it root only (or even a css from v1 hierarchy but that should not
> relevant here)). A particular cgroup can have the css set to NULL.
>
> When I think about your stats collecting example now, task_memcg() looks
> more suitable to achieve proper hierarchical counting in the end (IOW
> you'd lose info from tasks who don't reside in memcg-enabled leaf).

I guess it depends on how userspace reasons about this, and whether or
not you want to collect stats from leaves that don't reside in a
memcg-enabled leaf. I will go through all the memcg-enabled checks and
make sure they make sense and are consistent, maybe add some comments
to make the userspace policy here clear.

>
> (It's just that task_memcg won't return NULL. Unless the kernel is
> compiled without memcg support completely, which makes me think how do
> the config-dependent values propagate to BPF programs?)

I don't know if there is a standard way to handle this, but I think
you should know the configs of your kernel when you are loading a bpf
program? In this particular case, if CONFIG_CGROUPS=3D0 then the bpf
programs will not even load due to lack of hook points or kfuncs won't
exist. If the CONFIG_CGROUPS=3D1 but CONFIG_MEMCG=3D0 I think everything
will work normally except that task_memcg() will always return NULL so
no stats will be collected, which makes sense. There will be some
overhead to running bpf programs that will always do nothing, but I
would argue that it's the userspace's fault here for loading bpf
programs on a non-compatible kernel.

>
> Thanks,
> Michal
