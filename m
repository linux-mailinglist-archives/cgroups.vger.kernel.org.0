Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C162274F0D
	for <lists+cgroups@lfdr.de>; Wed, 23 Sep 2020 04:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgIWCfm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 22:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgIWCfm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 22:35:42 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03917C0613D1
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 19:35:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y17so20298728lfa.8
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 19:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNLILPO9KGBr2EiE7fPnteeqqVFqeTm0/utbd5V0UfM=;
        b=gpENJad7aIY/S5kBL5o8YVttNP6P373hhEXKz6ErBwsU/D+zf22imm1nkW4ERBaSHD
         zpAbAVk6UoSZYDLYJDZkFGLPhDVWGMO30j0pUcW7h49Tryqf3NzJu4RZcL1iD02GoqA6
         MG4REMrV1LplGXzEGHcMfLHjAQZ1DpNK4aAMFIQctSZ6kzBGbm0dg2ZTVSIvvckdxqRX
         A8p1DU39WBmIgc/L4nnjM4X9tMLRq8LvlGdaeOQbqxSz6Ff+SemO4COh6UTnhUpLf6VS
         txktKu+z0qVosUhE2kp0VE8x0/fTRFl8/cXeYa/Z0ziyNv7xI9D9QFTcZQvRCBscssRC
         /Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNLILPO9KGBr2EiE7fPnteeqqVFqeTm0/utbd5V0UfM=;
        b=K3RJOiZMea/9A2gbpJ3YcBnO3QjOpS6uq3IVWqAcNFmDhp5TSkDEtOJshJimVwOZ/F
         MPSp93QsuNwJRT7gl8xD911D5oSKdT/+1gRXjeD10t/lSNcbyzDwLw4C547Pb+guQQIj
         SJXucjW+onfuPjdf5PH2ZQBqCkuXPNjRBD0qsA26wZ41KXzFQZyszT2HOwt2FhDLhdhU
         C5BPM8aa05Oq+u31evjrqx9Yup/n9qRLImV5GpCGojPfyMwjt7UMSE9jiZhG0QxEc0tf
         NGlIKwaBss35AKfaQ9xHBEA1l368Ny4YxJKFOgZWZNkQTDEpF/AyC3smTuRzkgvK/mJx
         uWfg==
X-Gm-Message-State: AOAM530I1z+GZBUb+tKMyignwpHP93RCE/CJRBVASSFH2mvaSmsJHiT5
        VnZyuwlymiLPBO1xmyOH2bR/vYAyDWssTk+YpED7kw==
X-Google-Smtp-Source: ABdhPJxyzcM22PrIegi03Dy1GMhdk2CcQ8TxOfp4CD5IlwC/YoSTAHHbEzvDZ3zvZGe7TGoUuOqs4yQ/LKXQgaUQgH8=
X-Received: by 2002:a19:8789:: with SMTP id j131mr2439699lfd.90.1600828540307;
 Tue, 22 Sep 2020 19:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
 <20200921081200.GE12990@dhcp22.suse.cz> <CALOAHbDKvT58UFjxy770VDxO0VWABRYb7GVwgw+NiJp62mB06w@mail.gmail.com>
 <20200921110505.GH12990@dhcp22.suse.cz> <CAKRVAeN5U6S78jF1n8nCs5ioAdqvVn5f6GGTAnA93g_J0daOLw@mail.gmail.com>
 <20200922095136.GA9682@chrisdown.name> <CAKRVAePisoOg8QBz11gPqzEoUdwPiJ-9Z9MyFE2LHzR-r+PseQ@mail.gmail.com>
 <20200922104252.GB9682@chrisdown.name> <CAKRVAeOjST1vJsSXMgj91=tMf1MQTeNp_dz34z=DwL7Weh0bmg@mail.gmail.com>
 <20200922124344.GA34296@chrisdown.name>
In-Reply-To: <20200922124344.GA34296@chrisdown.name>
From:   Chunxin Zang <zangchunxin@bytedance.com>
Date:   Wed, 23 Sep 2020 10:35:29 +0800
Message-ID: <CAKRVAeNCAVN4qOc57AU_-2dJ8sOT7p6JSO578aD0Seveuv0Rog@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/memcontrol: Add the drop_cache
 interface for cgroup v2
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 22, 2020 at 8:43 PM Chris Down <chris@chrisdown.name> wrote:
>
> Chunxin Zang writes:
> >Please forgive me for not being able to understand why setting
> >memory.low for Type_A can solve the problem.
> >In my scene, Type_A is the most important, so I will set 100G to memory.low.
> >But 'memory.low' only takes effect passively when the kernel is
> >reclaiming memory. It means that reclaim Type_B's memory only when
> >Type_A  in alloc memory slow path. This will affect Type_A's
> >performance.
> >We want to reclaim Type_B's memory in advance when A is expected to be busy.
>
> That's what kswapd reclaim is for, so this distinction is meaningless without
> measurements :-)

Thanks for these suggestions, I will give it a try.

Best wishes
Chunxin
