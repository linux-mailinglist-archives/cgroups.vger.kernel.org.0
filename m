Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC33F2E17
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhHTOaS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhHTOaR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 10:30:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158EC061575;
        Fri, 20 Aug 2021 07:29:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w5so20665953ejq.2;
        Fri, 20 Aug 2021 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AcRjO0xn0//tKpsefB7FKZRMM8l5ZYGF15ZbjtpoAwc=;
        b=TWeYTHvGvR0cOQKdJQxLaHbz89VS4iAf2sA0cXbL8lbSvh4YCxheGK/bYtm27yVOGi
         Nsq4u3RPE5xUohWi6naocP38+1gL35O9AT6HU+m42uKyXid6C5KfYrZ2WUFF9Y2ADv+W
         t7sab2777I5dKUOCnKxTR29xng+cMxCCwbx39g6rY6kFYK1KdTDcpEv4ySpcpQNivrAk
         l27JqtARINoSWYUHGbIFKBVlKHhik4aUhYmy/AFgrGBdJuNTYVx14c/UQ5twYn9a5csn
         tPUPCq9QAeowEKVZC2imbRitgY+UTbFYGW/jd5EuT114hP0laTFG3FMiXmCMKK+TgjBM
         MVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AcRjO0xn0//tKpsefB7FKZRMM8l5ZYGF15ZbjtpoAwc=;
        b=e9GthX3pmnVXKxCK4KBuXjV4Lmvzg0n6zK7rQP1Vi8zqOBbAOqO0g8xXZ4kNXXE5IZ
         X9YkVIqMzTeFvM1bQVdO2LRMlG0/RP6/3KAAaV3Pntjrd83jOe261bMOcnBPVosdhVxT
         6ewOMmOfIHqJElNk8iHlDJ8NwJrKcjfiPDpN6ECMC7Q+Ow6b0uh7OPcUCRj0JsQSY3/4
         mdqkUg3gQwwpAQi9MJz/BUEdXeLq5j3sJzjFo6DmXzKpo9UOZjePNAx/06du7i2WWLrd
         Ay0IdSBc2sYAOwCLDEzKhyMYZ7+Ls25psbWbUcIHnrqCeDDRn/tEVoxftUK+QAriuHdr
         4/+g==
X-Gm-Message-State: AOAM530lQ0qMwrcwdse6JA1T4eeP1ED3yfZnvnNXaPvyzgw4eDMToNfp
        tutgRGGlpmJSnhUtuigIc7bKqySWAzaIQNkdJk4=
X-Google-Smtp-Source: ABdhPJwl9Szaq0NwViH9tbZzRec2evrbfvGpbQ4MDluQFkX033nMgneAjafalGucnJYUxLvnziS5DOyJlhAzMp+W+hk=
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr21857061eje.240.1629469778125;
 Fri, 20 Aug 2021 07:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn> <CALvZod5usW9OEsJSbeGYBnSGVDNLLKqMoGAx-JQrX6s62r-XiA@mail.gmail.com>
In-Reply-To: <CALvZod5usW9OEsJSbeGYBnSGVDNLLKqMoGAx-JQrX6s62r-XiA@mail.gmail.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Fri, 20 Aug 2021 22:29:27 +0800
Message-ID: <CAOH5QeCf6+xiT_Wjtw=BegCYWc2H52qeKVsTh2aha0SG2xyU5w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wangyong <wang.yong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Shakeel Butt <shakeelb@google.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 19, 2021 at 4:54 PM <yongw.pur@gmail.com> wrote:
> >
> > From: wangyong <wang.yong@zte.com.cn>
> >
> > Inspired by PSI features, vmpressure inotifier function should
> > also be configured to decide whether it is used, because it is an
> > independent feature which notifies the user of memory pressure.
> >
>
> It is also used by the networking stack to check memory pressure. See
> mem_cgroup_under_socket_pressure().

 Thanks for your replly, mem_cgroup_under_socket_pressure does use vmpressu=
e,
 I'll check it.
