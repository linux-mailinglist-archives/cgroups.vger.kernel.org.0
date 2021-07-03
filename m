Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD553BA96B
	for <lists+cgroups@lfdr.de>; Sat,  3 Jul 2021 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhGCQVN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Jul 2021 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCQVN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Jul 2021 12:21:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BA3C061762;
        Sat,  3 Jul 2021 09:18:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i20so21287262ejw.4;
        Sat, 03 Jul 2021 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SFx0l3EFfXNlGfyI4GVdZzRabxV5Q5+sQtiSDXNWyA=;
        b=Y89WEwsifC2v0VdErRLJjYeyJmIWBXHrtZzhT6IZHQdx/2Nsemmeil8SulvH9KRj22
         A0Z4KglyhDv0BfV7EQtbvIGrJd6mAagDmlsICgrwU5UCwcSFBcz/ZNLIh/YNAaxYbqM0
         7Y3SJFoXL6FokOSyo/uTlcMKTOk+lfmlRIn6oDp9MqwiiFZRpYHHtcaceEaWiTrKZxQj
         clRa0/2TAIx0uSBeawIVdmNqtU2GiIjfR6AQBbCIZIR1+tayHXy02exYi5VQNqPzKnbU
         fBY3jKfCTAPHStRotUekp2kOWYZ3Ml8xGNHDMLpd7CRelawB2FnloxzSY0Opt5YAojyg
         UpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SFx0l3EFfXNlGfyI4GVdZzRabxV5Q5+sQtiSDXNWyA=;
        b=h//x6c/FvXGPJ1pbHBxxaiJPyFwA1bHT8PWfcOKvuiu8Yqfy/rBtAvLghxMkQx9Q7y
         7+8tQVQAZF8yHBOX0nKo0ZCZYkAoODtwG2tB5fb9YSOEKG7ZAmhDGXilIpCpxNVm+o3E
         9mtGRfCl0Cx+4jE+WJ8lTOYGHP8HCkbcyKW50hjP1E1hWb97/WD90IcaqVgg67RcCRgg
         70mu8jsX0IBPT9dDNEt9l5ggtrFuZD3UbRoCmy31RI1I0vaaZarzcUatCdRiq0pjiN1Q
         Y3anwpFuE903rVBfzhnqctLcNqb5GQWIiOUUAt1xukl6CDWReJdhnxzB1MiATAzSghaI
         xFFg==
X-Gm-Message-State: AOAM530NJVrD51BHngenJ12B1ruxVYBqJ/nR0MPJYFQ8kgrurX3DM7Vc
        8MQ2/2/Hrw+StplEEHuSnD32kyPEa/8eMA0pojh710prtGEk+A==
X-Google-Smtp-Source: ABdhPJyIW/gHmhWZpraIEnHpbIr8igMFbgS3aJkgvRtJleUmEjWgSls5GThsHsT/TQjnxCxv5qi9q8Jw2YfdfeIdlIA=
X-Received: by 2002:a17:906:15c2:: with SMTP id l2mr5335696ejd.348.1625329116880;
 Sat, 03 Jul 2021 09:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <60decdb6.1c69fb81.6130e.7642@mx.google.com> <20210702200742.wuhdg4dhpolher3t@oracle.com>
In-Reply-To: <20210702200742.wuhdg4dhpolher3t@oracle.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Sun, 4 Jul 2021 00:18:22 +0800
Message-ID: <CA+PpKPmN2E5zCjP3mkurNA2GANtLCUmoPG+_4mUq3E8cxOhuhQ@mail.gmail.com>
Subject: Re: [Question] Do we need remote charging for cpu and cpuacct subsys?
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 3, 2021 at 4:07 AM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> Hello,
>
> On Fri, Jul 02, 2021 at 08:26:27AM -0000, Hao Lee wrote:
> > memcg currently has a remote charging mechanism that can charge usage to other
> > memcg instead of the one the task belongs to.
> >
> > In our environment, we need to account the cpu usage consumed by some kworkers
> > to a specific cgroup. Thus, we want to introduce a remote-charging mechanism to
> > cpu and cpuacct subsys in our kernel.
>
> I also want to see this upstream, and am actually working on it right
> now, have been for some time.
>
> So far, this is needed to properly account multithreaded padata jobs,
> memory reclaim, and net rx. Android folks have raised this issue in the
> past too, though I'm not aware of the specific kthreads that are giving
> them problems.
>
> So naturally, I'm curious about your use case and how it may be
> different from these others. What kworkers would you like to account?

Thanks. We use a workqueue to perform asynchronous reclaim for cgroups.
The kworker may consume lots of CPU cycles if the cgroup memory pressure
is extremely high, so we want to charge the cpu usage to the related
cgroup for which the kworker works. Otherwise, the reclaim kworker will
steal cpu time from the system level, which breaks the resource isolation.

>
> > I want to know if the community has a plan to do this?
> > What will the community approach look like?
>
> There has been discussion about this here,
>
>    https://lore.kernel.org/lkml/20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com/
>

Yes, our work is very similar to Johannes'.

> more recently here,
>
>    https://lore.kernel.org/lkml/YGxjwKbec68sCcqo@slm.duckdns.org/
>
> and we may talk about it at LPC:
>
>    https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-perform

I also found that you posted a patchset in 2019 to introduce a
cgroup-aware workqueue. In that discussion, back-charging is considered
to be a suitable solution.
    https://lore.kernel.org/lkml/20190611195549.GL3341036@devbig004.ftw2.facebook.com/

I also have a question here. Are the back-charging and remote charging
the same thing?

>
> > I think we need to move the active_memcg to a separated active_cgroup struct,
> > and the latter will contain active_memcg, active_tg, and active_cpuacct.
>
> I'm not seeing how that could work for cases that don't know the cgroup
> when the remote charging period begins.

This is indeed a problem. Neither cgroup-aware kthread nor remote
charging can address this. Maybe this is the biggest obstacle hindering
fine-grained charging.

> The only one I'm aware of
> that's like that is net rx, where the work to process packets has to
> start before their ultimate destination, and therefore cgroup, is known.

Sorry. Is this a typo? It seems the word "known" should be "unknown"...


Regards,
Hao Lee

>
> thanks,
> Daniel
