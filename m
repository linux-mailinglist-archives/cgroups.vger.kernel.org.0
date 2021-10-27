Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D1E43C020
	for <lists+cgroups@lfdr.de>; Wed, 27 Oct 2021 04:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbhJ0CpH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Oct 2021 22:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbhJ0CpG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Oct 2021 22:45:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847AC061570;
        Tue, 26 Oct 2021 19:42:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g10so4530210edj.1;
        Tue, 26 Oct 2021 19:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CEbUbWOhQSqqOGE19xqh9rkRH8otndDTOABWkoBG0A=;
        b=iUCh//iTlainZark1GEBDt7mbEnmNwF/ebiApqKXkVVaFOKG4UvLUBOlHeN2Ukj+3I
         m+joeM3Gj5SVnTm8ERqJ5tq25qKV2W6bh+vArU56GOB7wNCI6EqacKsNKKS2UuGeKj09
         SofgfJ2g+2L1/N9CkbbcOmHuvtlZx8ZVx+iDwtUkOrhRBcZ+riMExomk40O85XX7eMXl
         gqztk/7oFbzOxd0EEnOHBHZw+l0aIIR8gPEZGUpqKod2/pUcCFy2P9WdICP+PX6GQl9i
         63S6+beQ+tAHwQ518y8fdrSGWG2uI0c4IAM1KeKepWXvRWQxZHcLF9pKNPG9TKVxSukG
         2mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CEbUbWOhQSqqOGE19xqh9rkRH8otndDTOABWkoBG0A=;
        b=r36NbTorjnlE3lMTo6mx3zFSRmaA4l9ZUbO5oEwoRGlCQB3ku0JYcwI6N887UcoA6o
         tuMoXdDt0GvFKYYTnXhbs8rI7Np2iSn9jytSpPcEoN7m7A9B/M/QXmrBpaxGY2H6e61I
         xzwFxzR5Bqem84E+f4J8mzVk6RJLrQsJPR5BXGeLZHY2gEX2XZwckQUVWlun5ixxYpYo
         SufxCFuqzu1qOMuOahIDBU4Be9ue/IcWPabKYLDhf9stya2+65ScR7Iu4NXcbw0UmbiP
         waLtG5eda5XPPOlWnaVj1PU2iJs2Aoc7pQ/mdhNCCuSG5/gWNpHh/7TYw7Rzql0ATvns
         Ti/g==
X-Gm-Message-State: AOAM533ks9U8JW+MequFRhC1XIol4pmsFl4MF6peiHTn/Fzgw9MchwP+
        hcOLq2h6uvXk11D4aaWiD4+QzXIsIAN8h0Tdk8M=
X-Google-Smtp-Source: ABdhPJwHv3koXe+a6zrtuXCVXs1KTc55Halh3VLIoGK5KqSLaDBVVii7yYDtttA3ZLvhH8TmpbQIrfZCII7/3/sz1LM=
X-Received: by 2002:a17:906:26ce:: with SMTP id u14mr35488141ejc.559.1635302560832;
 Tue, 26 Oct 2021 19:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <20211026235808.34168-1-21cnbao@gmail.com> <f795f8be-a184-408a-0b5a-553d26061385@redhat.com>
 <CAGsJ_4wZJyKh+FUsmL8TMaCHofmr9J5UCzk3YYEYckD8ZWZW+w@mail.gmail.com> <4637ebd4-61ef-5ad6-d2bd-976663f5c4a1@redhat.com>
In-Reply-To: <4637ebd4-61ef-5ad6-d2bd-976663f5c4a1@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 27 Oct 2021 15:42:29 +1300
Message-ID: <CAGsJ_4y__nBDpLo6pmEHeTJQMQFtHmQhNLTsFFunBJLknChQsA@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Waiman Long <longman@redhat.com>
Cc:     Amit Pundir <amit.pundir@linaro.org>, cgroups@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>, groeck@chromium.org,
        hannes@cmpxchg.org, joel@joelfernandes.org, jsbarnes@google.com,
        kernel-team@android.com, Greg Kerr <kerrnel@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lizefan@huawei.com,
        Peter Zijlstra <peterz@infradead.org>, sonnyrao@google.com,
        Tejun Heo <tj@kernel.org>, vpillai@digitalocean.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 27, 2021 at 3:35 PM Waiman Long <longman@redhat.com> wrote:
>
> On 10/26/21 10:21 PM, Barry Song wrote:
> > On Wed, Oct 27, 2021 at 2:06 PM Waiman Long <longman@redhat.com> wrote:
> >>
> >> On 10/26/21 7:58 PM, Barry Song wrote:
> >>>> I think Tejun is concerned about a change in the default behavior of
> >>>> cpuset v1.
> >>>>
> >>>> There is a special v2 mode for cpuset that is enabled by the mount
> >>>> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
> >>>> v2 behavior. I introduced this v2 mode a while back to address, I think,
> >>>> a similar concern. Could you try that to see if it is able to address
> >>>> your problem? If not, you can make some code adjustment within the
> >>>> framework of the v2 mode. As long as it is an opt-in, I think we are
> >>>> open to further change.
> >>> I am also able to reproduce on Ubuntu 21.04 LTS.
> >>>
> >>> all docker will be put in this cgroups and its child cgroups:
> >>> /sys/fs/cgroup/cpuset/docker
> >>>
> >>> disabling and enabling SMT by:
> >>> echo off > /sys/devices/system/cpu/smt/control
> >>> echo on > /sys/devices/system/cpu/smt/control
> >>>
> >>> or unpluging and pluging CPUs by:
> >>> echo 0 > /sys/devices/system/cpu/cpuX/online
> >>> echo 1 > /sys/devices/system/cpu/cpuX/online
> >>>
> >>> then all docker images will lose some CPUs.
> >>>
> >>> So should we document the broken behaviours somewhere?
> >> Is the special cpuset_v2_mode mount option able to fix the issue?
> >>
> >> This mode is documented in
> >>
> >> Documentation/admin-guide/cgroup-v1/cpuset.rst:
> >>
> >> The cpuset.effective_cpus and cpuset.effective_mems files are
> >> normally read-only copies of cpuset.cpus and cpuset.mems files
> >> respectively.  If the cpuset cgroup filesystem is mounted with the
> >> special "cpuset_v2_mode" option, the behavior of these files will become
> >> similar to the corresponding files in cpuset v2.  In other words, hotplug
> >> events will not change cpuset.cpus and cpuset.mems.  Those events will
> >> only affect cpuset.effective_cpus and cpuset.effective_mems which show
> >> the actual cpus and memory nodes that are currently used by this cpuset.
> >> See Documentation/admin-guide/cgroup-v2.rst for more information about
> >> cpuset v2 behavior.
> >>
> >> Maybe we can make it more visible.
> > Is it possible to make cpuset_v2_mode true in default? not quite sure if
> > it will harm something.
>
> The cpuset_v2_mode is a change in v1 behavior and that is why it is an
> opt-in as we don't want to break existing applications that have a
> dependency on the current v1 behavior. If users switch to use cgroup v2,
> they get the new behavior. Alternately, they can modify the system
> startup script to use the v2 behavior by using the mount option. I don't
> think we are going to change the v1 default behavior.

ok, understood.

the old behaviour seems quite odd and linux distributions don't realize it.
for example, ubuntu is simply losing cpu for docker.

>
> Cheers,
> Longman

Thanks
barry
