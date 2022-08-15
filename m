Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE0592CC5
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiHOJ0I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiHOJ0G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 05:26:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01613F8B;
        Mon, 15 Aug 2022 02:26:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z6so9875998lfu.9;
        Mon, 15 Aug 2022 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=m64dCm5y6abMgyqwAQFCPVcLqHA6yb02EbRC6+noQbw=;
        b=nnmZdSGgeYdNQlt7klf2KWrMATSS13t2yHEkVMt+x0DICtLrR28QtzNdoDTRaEmPom
         z+Gs8Dqq57cX383CEv81ElNXe4hwEdFC/yx/espCw2xpTQameFuDpE7JbCuTbWB+Kbol
         yO27DHFvxupX+VcmZM86sl6boJZeqggbNf4o8YzZtEaZQeYGSShIxAUkWIBfNtoTsM9T
         Cr27BqXZo98/XfG56V1Yvc/jztezBrzouNmTZvHA/wtgonY4MU0pci1t+I+tRr3mf5HO
         sdAx6MpIxbc1GK37dE/4nGERixFc6AjZOLsoU/8XHkj2Yc63r6S/c5WZxknVrcBXx/3D
         7pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=m64dCm5y6abMgyqwAQFCPVcLqHA6yb02EbRC6+noQbw=;
        b=RT6YJPAJueei7w63vVPs9dVCRx4QBOfpXclsM4r//GL8EYpiBly6Xu4QKMs8NNVE6H
         o8F4fHgrQt/4fAn0axpS/aDhv0q0qHnc090DR/mqNB4SLdLb7EayCyCjc58BOIKe6TIM
         NGSirZkSUAXUmj5MGKMlr6oF1l357jLYtLHkaP9lowxWqqp/9zHu1kwb0TMLxC1Srf/X
         QrYT1oRsKWRFaPpFl/1cieJS0ff7j8Jj2Qv/ilCYnXQxT1E924OwTEulNX8bCtI/HSLX
         R7d3gJNpMw2i/pO/U9qorihpa5qt8qb2RUY7woVaDoDGemCtYHLh8ZwcB+EQr2xh1q8Q
         eDkw==
X-Gm-Message-State: ACgBeo3Y/6eknJtqCYI3SgozN9+pUujbs9w/KxY8UWWnIk0U9QE8VLkg
        Kklc77WFYZcCtYfGwfxpN8YoLgZYwV5v7fiihYk=
X-Google-Smtp-Source: AA6agR6CMLudliLU8DkPuETG1wkoC+cdz48zIm15B0wjSPjwtbMMftxqAWoUVL/mbhEco5kEFVzLgUqmqMD3Vr4rsnk=
X-Received: by 2002:a05:6512:168d:b0:491:3206:b63 with SMTP id
 bu13-20020a056512168d00b0049132060b63mr3115806lfb.149.1660555563305; Mon, 15
 Aug 2022 02:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com> <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com> <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org> <YuGTBLkFerUboctl@slm.duckdns.org>
 <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com> <20220815090556.GB27407@blackbody.suse.cz>
In-Reply-To: <20220815090556.GB27407@blackbody.suse.cz>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 15 Aug 2022 17:25:52 +0800
Message-ID: <CAB8ipk90LxNNbq5OKamd-ArkqhEZjxS1fFZJXtnbQwGzyyJ3wQ@mail.gmail.com>
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and cpu_hotplug_lock
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, Tejun Heo <tj@kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, tglx@linutronix.de, steven.price@arm.com,
        peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>,
        Zhang Qiao <zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal

On Mon, Aug 15, 2022 at 5:06 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> +Cc: Zhao Gongyi <zhaogongyi@huawei.com>, Zhang Qiao <zhangqiao22@huawei.=
com>
>
> On Fri, Aug 12, 2022 at 03:57:00PM +0530, Mukesh Ojha <quic_mojha@quicinc=
.com> wrote:
> > The original patch of yours [1]  and the revert of [2] is fixing the is=
sue
> > and it is also confirmed here [3].
> > Can we get proper fix merge on your tree?
> >
> > [1] https://lore.kernel.org/lkml/YuGbYCfAG81mZBnN@slm.duckdns.org/
> >
> > [2]
> > https://lore.kernel.org/all/20220121101210.84926-1-zhangqiao22@huawei.c=
om/
>
> The revert + Tejun's patch looks fine wrt the problem of the reverted
> patch (just moves cpus_read_lock to upper callers).

Your means is that the problem should be fixed by [1]+[2]'s revert ?
I just tested the case which reverted the [2]. Need I test with [1] and [2]=
?

Thanks!

>
> I'd just suggest a comment that'd explicitly document also the lock
> order that we stick to, IIUC, it should be:
>
>         cpu_hotplug_lock // cpus_read_lock
>         cgroup_threadgroup_rwsem
>         cpuset_rwsem
>
> Michal
>
> >
> > [3] https://lore.kernel.org/lkml/CAB8ipk-72V-bYRfL-VcSRSyXTeQqkBVj+1d5M=
HSVV5CTar9a0Q@mail.gmail.com/
> >
> > -Mukesh
