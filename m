Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6007398ED8
	for <lists+cgroups@lfdr.de>; Wed,  2 Jun 2021 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFBPl5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Jun 2021 11:41:57 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45799 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhFBPl5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Jun 2021 11:41:57 -0400
Received: by mail-lf1-f50.google.com with SMTP id j10so4038330lfb.12
        for <cgroups@vger.kernel.org>; Wed, 02 Jun 2021 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=674c29vRdYAk6FicWWelzpFqgoTb+93XHQAYD/1H3Rk=;
        b=bMiDXVuqX3MZ1ebHXMXAnz4i1FuII1AA/TtaUU/88MAika1cxyLKtGEw4MIsREXO+X
         CmZ71Pfe+P+ouAxW5F5HeR1iDagoaN3GJttsjpbjfSz1LSg+IuI4e5UNdn4UjORrl6K+
         XaPqXvgdw8TLFvyMzqZtVFtQS5SFrFKGudfhr+uc9hUomLbUqgFFrFiu3w55ZZk1jP39
         hr35swpMuqa9ALpJR7bmDsxEZlhrUqP02UN7iDrYy5z5MKkj0qrIrk3lCYyl/p4apSad
         EUvuVDgHsnEQqx5zQ1pjEdTpkGHpon7Q8wHvorS7CxXoxpEp+I2oZctN6bdA2OPFk2si
         DWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=674c29vRdYAk6FicWWelzpFqgoTb+93XHQAYD/1H3Rk=;
        b=FfW7SGmZOuKtW/yMSW4D++tCopY8fq8N7ROUHqs0Sx1nsrOCmIxEP5I+VhSdHjhyVH
         hXnYjA+G4cxofKHKYtQ9Blf7W1rS/i1X1tXypNWluhAeZ0zGgGTVbyt1qxVheg//+5HV
         cseuf54uoE2t4auDeP8LqSxNoGJMSkjbv+jUk/s/zT4cCMwJBPwWQl3b6d5/AR7bhyeZ
         TdsCv8isnLtoWKEXgeulw7W3l14odn6a+eernGOL0U1k6Q7F4sEm4IgjSN3a7tyPM/hL
         bx8zGI8our4IUj96Z4yrii+p1pzNaL1souoSzbEY8LRcN8wyeDCkF1ByeQ4D1Wden98L
         8EOA==
X-Gm-Message-State: AOAM533HHjxFrRz6JQJ5ImMjPdz1jc+wpgt35mE570IA6+SfT6f8zNMp
        GbrOkKzC0eP/WWLR5Kyfyf7CLGFOv7LFKfx6ULDNNA==
X-Google-Smtp-Source: ABdhPJzUw8dMj8EA8JBuJZCLP1LL+HR9H3i2lXbH4Cv+UfaMzKjX96HEn5EaYGeRejpEEFOwMIB0RqQcUBfhNXWuomM=
X-Received: by 2002:a05:6512:531:: with SMTP id o17mr10519925lfc.358.1622648353129;
 Wed, 02 Jun 2021 08:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622043596.git.yuleixzhang@tencent.com> <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
 <YLZIBpJFkKNBCg2X@chrisdown.name> <CACZOiM21STLrZgcnEwm8w2t82Qj3Ohy-BGbD5u62gTn=z4X3Lw@mail.gmail.com>
In-Reply-To: <CACZOiM21STLrZgcnEwm8w2t82Qj3Ohy-BGbD5u62gTn=z4X3Lw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 2 Jun 2021 08:39:02 -0700
Message-ID: <CALvZod7w1tzxvYCP54KHEo=k=qUd02UTkr+1+b5rTdn-tJt45w@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 2, 2021 at 2:11 AM yulei zhang <yulei.kernel@gmail.com> wrote:
>
> On Tue, Jun 1, 2021 at 10:45 PM Chris Down <chris@chrisdown.name> wrote:
> >
> > yulei zhang writes:
> > >Yep, dynamically adjust the memory.high limits can ease the memory pressure
> > >and postpone the global reclaim, but it can easily trigger the oom in
> > >the cgroups,
> >
> > To go further on Shakeel's point, which I agree with, memory.high should
> > _never_ result in memcg OOM. Even if the limit is breached dramatically, we
> > don't OOM the cgroup. If you have a demonstration of memory.high resulting in
> > cgroup-level OOM kills in recent kernels, then that needs to be provided. :-)
>
> You are right, I mistook it for max. Shakeel means the throttling
> during context switch
> which uses memory.high as threshold to calculate the sleep time.
> Currently it only applies
> to cgroupv2.  In this patchset we explore another idea to throttle the
> memory usage, which
> rely on setting an average allocation speed in memcg. We hope to
> suppress the memory
> usage in low priority cgroups when it reaches the system watermark and
> still keep the activities
> alive.

I think you need to make the case: why should we add one more form of
throttling? Basically why memory.high is not good for your use-case
and the proposed solution works better. Though IMO it would be a hard
sell.
