Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6643BF92
	for <lists+cgroups@lfdr.de>; Wed, 27 Oct 2021 04:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhJ0CYE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Oct 2021 22:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbhJ0CYA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Oct 2021 22:24:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B63C061767;
        Tue, 26 Oct 2021 19:21:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h7so4218596ede.8;
        Tue, 26 Oct 2021 19:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+ecs9ULK67ak6+18lMqOJvsYYYpLvK+1XGUHv7GZac=;
        b=Hb++FmaY5noeUGIiUHVLNmcYM97twwAwbd1DR2/3G2Fg6fAzraDyPdOxKfKCtj6r95
         6nzgJD/7XktInCNTBaFwYe8LpwJpYdt3NbPQ5GBWHu+hMlWKJjpBbRhEaVl4eoOo/8eW
         0UsMyuAJZ6X7ziSEGU1gEBOXWqAwNcpBL64B+mBgCj1WQav4va8YK7y2kx3w2p398fUS
         nIejmBw8KP85VlsUQeIk2XovgdYUC+S/M0h+ld3JpNLAK91jCRb1gC+7vFZeR9p5Yco0
         lAI8wkL6EiYHd32/ZedBrawDzrudRnzL/YJsBINaoe0+s68fSJ7aOkxonMdIIubawvCe
         EX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+ecs9ULK67ak6+18lMqOJvsYYYpLvK+1XGUHv7GZac=;
        b=ibKeYrq8TiSSh64V4P6KGhEvzFA5/40SxQTW+QytIPjG2fQ509W/zQ6TGqEDBV4MtT
         N7i9SpRWa6IOIrfXxFJKRmfkl73NgGLpIqcMXC4pLgvbBMy8KzvLjPtpj0bH1wiS5rJZ
         YjWQjgzBaWWgl0RtQ/nGJ5Oltu0WocrMERF3UTzgECKw+NQi2mFd4q3H5yejuysGoAgy
         u3HEFt5K+D6ftaIwuAY5/uwotgntbZxFgNJ48iR4aAsKd1M+2w9I32+5ulO13yHjn5bk
         15j/0Z7vPNq3bevrEh+bs/Si+qP2MPtsS26elZW/7MHr9ActKOeVTu7xNMCxMDnFhq0f
         1t8w==
X-Gm-Message-State: AOAM531s9bA5XUQ7alZvTfYl+25jIy3Jvc22MQodsuwdcCs4m6peruIX
        HYiTlHopM9ssCR0nlMFhBd5dzhckq0JtdsU4RsI=
X-Google-Smtp-Source: ABdhPJwvwq9qEe+kecb9LoFdv8/bK3YkjHNtEVo2RPkY04ERVd7N1tcwmUKMxfr2aLQKsm99DXo82Om7UmeDXNcyBdc=
X-Received: by 2002:a50:ce5d:: with SMTP id k29mr5297655edj.385.1635301294224;
 Tue, 26 Oct 2021 19:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <20211026235808.34168-1-21cnbao@gmail.com> <f795f8be-a184-408a-0b5a-553d26061385@redhat.com>
In-Reply-To: <f795f8be-a184-408a-0b5a-553d26061385@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 27 Oct 2021 15:21:22 +1300
Message-ID: <CAGsJ_4wZJyKh+FUsmL8TMaCHofmr9J5UCzk3YYEYckD8ZWZW+w@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Waiman Long <longman@redhat.com>
Cc:     amit.pundir@linaro.org, cgroups@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>, groeck@chromium.org,
        hannes@cmpxchg.org, joel@joelfernandes.org, jsbarnes@google.com,
        kernel-team@android.com, kerrnel@google.com,
        LKML <linux-kernel@vger.kernel.org>, lizefan@huawei.com,
        Peter Zijlstra <peterz@infradead.org>, sonnyrao@google.com,
        Tejun Heo <tj@kernel.org>, vpillai@digitalocean.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 27, 2021 at 2:06 PM Waiman Long <longman@redhat.com> wrote:
>
>
> On 10/26/21 7:58 PM, Barry Song wrote:
> >> I think Tejun is concerned about a change in the default behavior of
> >> cpuset v1.
> >>
> >> There is a special v2 mode for cpuset that is enabled by the mount
> >> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
> >> v2 behavior. I introduced this v2 mode a while back to address, I think,
> >> a similar concern. Could you try that to see if it is able to address
> >> your problem? If not, you can make some code adjustment within the
> >> framework of the v2 mode. As long as it is an opt-in, I think we are
> >> open to further change.
> > I am also able to reproduce on Ubuntu 21.04 LTS.
> >
> > all docker will be put in this cgroups and its child cgroups:
> > /sys/fs/cgroup/cpuset/docker
> >
> > disabling and enabling SMT by:
> > echo off > /sys/devices/system/cpu/smt/control
> > echo on > /sys/devices/system/cpu/smt/control
> >
> > or unpluging and pluging CPUs by:
> > echo 0 > /sys/devices/system/cpu/cpuX/online
> > echo 1 > /sys/devices/system/cpu/cpuX/online
> >
> > then all docker images will lose some CPUs.
> >
> > So should we document the broken behaviours somewhere?
>
> Is the special cpuset_v2_mode mount option able to fix the issue?
>
> This mode is documented in
>
> Documentation/admin-guide/cgroup-v1/cpuset.rst:
>
> The cpuset.effective_cpus and cpuset.effective_mems files are
> normally read-only copies of cpuset.cpus and cpuset.mems files
> respectively.  If the cpuset cgroup filesystem is mounted with the
> special "cpuset_v2_mode" option, the behavior of these files will become
> similar to the corresponding files in cpuset v2.  In other words, hotplug
> events will not change cpuset.cpus and cpuset.mems.  Those events will
> only affect cpuset.effective_cpus and cpuset.effective_mems which show
> the actual cpus and memory nodes that are currently used by this cpuset.
> See Documentation/admin-guide/cgroup-v2.rst for more information about
> cpuset v2 behavior.
>
> Maybe we can make it more visible.

Is it possible to make cpuset_v2_mode true in default? not quite sure if
it will harm something.

>
> Cheers,
> Longman

Thanks
Barry
