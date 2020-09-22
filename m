Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFE274225
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIVMhp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 08:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgIVMhp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 08:37:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC682C0613D1
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 05:37:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n25so14009543ljj.4
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gA220xpuIaxUuyuMwr6nlukSuBX7MpFrxgJa3f1luDw=;
        b=GReCqit5HTO/ziRjftty0K8XZi2ySCuJzKJveaG0MdXTTpgULihVLwMvfADeawU2QZ
         IbAydMl3Tn/9XZF79/7c4WOv1D9hB06rNVFZ/DiHhbarrKyedLyRCcCrKNAAgAgynsvl
         PuiO+M0DWum3yqYFnTFuppHoZ6RUqQ5x1aZtz6a6hAJDQtyZm8Nk5IuIu/m6lV5zU0Qa
         YPhNCDslcn72ErQ130linofe9GJPNOAEaCIrlopykwgfmAJg0zLWoF20Oug79KD1o/ie
         h0iyMZUYd3e33ZiaWMrDN63XT+TuA6+CR0zCHGKr/FQJkVpg0EeSRf5Qih1CxKrTnkq8
         Ut5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gA220xpuIaxUuyuMwr6nlukSuBX7MpFrxgJa3f1luDw=;
        b=Tnaa+zzJUJDCCipBraMiVCRgYrWqazeY7a1gJPbV0BTt7R/93wYltaKWRdzDZihwka
         ckl4WmqJVb9YlpsriRwnSXmeaoHHUM875IipM/xOXrV3eLTycLCqs6tHNkY5bo6gElb7
         /ZniWZcHyIRZTh9P7WHEbRKQLrgr7iyWHljB7V4Tc3YEfVkDTiACyFEMGqPqbOAL/NYN
         egFVr4ML1Fjxi26Z8EwGlNpdvksCv1yEcowxtIirtTpi3vsd+jKvOg6HHiSPcuS7h3+l
         BxgByIjTA8ooC8qiRDzC6WkC0YMKR7Dott5WTuw4P+9F0jSyKQZVWU7dalzg9C1zcPn0
         l6fg==
X-Gm-Message-State: AOAM533oFREBMnb1r2dr4/gLaZI4PJESZHasQTPrBn65Bd2tzojI07jc
        s2YQXV56raEjp5J0mISkMhybi8a6q5Pk0iQBhrTdZg==
X-Google-Smtp-Source: ABdhPJy2uCCGncfmVCuod/IiCiTTfxrKsDOlJTrFdVxVRrWlq7JKLI4j/OgY4j/S5nJzpdTEsCyW0xWnIGQadAicUpY=
X-Received: by 2002:a2e:9089:: with SMTP id l9mr1605962ljg.408.1600778262989;
 Tue, 22 Sep 2020 05:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200921080255.15505-1-zangchunxin@bytedance.com>
 <20200921081200.GE12990@dhcp22.suse.cz> <CALOAHbDKvT58UFjxy770VDxO0VWABRYb7GVwgw+NiJp62mB06w@mail.gmail.com>
 <20200921110505.GH12990@dhcp22.suse.cz> <CAKRVAeN5U6S78jF1n8nCs5ioAdqvVn5f6GGTAnA93g_J0daOLw@mail.gmail.com>
 <20200922095136.GA9682@chrisdown.name> <CAKRVAePisoOg8QBz11gPqzEoUdwPiJ-9Z9MyFE2LHzR-r+PseQ@mail.gmail.com>
 <20200922104252.GB9682@chrisdown.name>
In-Reply-To: <20200922104252.GB9682@chrisdown.name>
From:   Chunxin Zang <zangchunxin@bytedance.com>
Date:   Tue, 22 Sep 2020 20:37:32 +0800
Message-ID: <CAKRVAeOjST1vJsSXMgj91=tMf1MQTeNp_dz34z=DwL7Weh0bmg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 22, 2020 at 6:42 PM Chris Down <chris@chrisdown.name> wrote:
>
> Chunxin Zang writes:
> >On Tue, Sep 22, 2020 at 5:51 PM Chris Down <chris@chrisdown.name> wrote:
> >>
> >> Chunxin Zang writes:
> >> >My usecase is that there are two types of services in one server. The=
y
> >> >have difference
> >> >priorities. Type_A has the highest priority, we need to ensure it's
> >> >schedule latency=E3=80=81I/O
> >> >latency=E3=80=81memory enough. Type_B has the lowest priority, we exp=
ect it
> >> >will not affect
> >> >Type_A when executed.
> >> >So Type_A could use memory without any limit. Type_B could use memory
> >> >only when the
> >> >memory is absolutely sufficient. But we cannot estimate how much
> >> >memory Type_B should
> >> >use. Because everything is dynamic. So we can't set Type_B's memory.h=
igh.
> >> >
> >> >So we want to release the memory of Type_B when global memory is
> >> >insufficient in order
> >> >to ensure the quality of service of Type_A . In the past, we used the
> >> >'force_empty' interface
> >> >of cgroup v1.
> >>
> >> This sounds like a perfect use case for memory.low on Type_A, and it's=
 pretty
> >> much exactly what we invented it for. What's the problem with that?
> >
> >But we cannot estimate how much memory Type_A uses at least.
>
> memory.low allows ballparking, you don't have to know exactly how much it=
 uses.
> Any amount of protection biases reclaim away from that cgroup.
>
> >For example:
> >total memory: 100G
> >At the beginning, Type_A was in an idle state, and it only used 10G of m=
emory.
> >The load is very low. We want to run Type_B to avoid wasting machine res=
ources.
> >When Type_B runs for a while, it used 80G of memory.
> >At this time Type_A is busy, it needs more memory.
>
> Ok, so set memory.low for Type_A close to your maximum expected value.

Please forgive me for not being able to understand why setting
memory.low for Type_A can solve the problem.
In my scene, Type_A is the most important, so I will set 100G to memory.low=
.
But 'memory.low' only takes effect passively when the kernel is
reclaiming memory. It means that reclaim Type_B's memory only when
Type_A  in alloc memory slow path. This will affect Type_A's
performance.
We want to reclaim Type_B's memory in advance when A is expected to be busy=
.

Best wishes
Chunxin
