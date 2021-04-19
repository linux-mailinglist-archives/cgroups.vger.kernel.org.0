Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4243648C0
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhDSRJE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRJD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 13:09:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A6C06174A
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 10:08:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 12so56928462lfq.13
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWSezx4tLawsVl0ivC9DPvWS+UGVQ+OHWW5pAYUu5aA=;
        b=LFr0ylNy8D1aC+Q9gktMwpXL6tsOLRZS5+ZKdzscXKIyBQSWIWjr+jhoDkAu3TC11D
         NUa1blMJJRHWrG5hzu9ox/314cUh0FWeOfCG2whXUIgI29BKd29RG07beqjMeyJxbynd
         JXqbXQdLGEMSzvgJ8MTmq+OVC+nw5Gj4KnKt1dwQbkl6W6gNnUA5pQRIhSAfkZ4SY7wI
         nTG5avujs2EM5Zeoa2z00f+odGiSSGH9QXFo9yxLx+r0FWfyFGxoSH1b9CCKoSiMMeDa
         nmQY49InzflFXUEgpTOGszVHOk132rK0Kb1HXegd5h/E561qhpKQNvS4VSUQ+qe41bXE
         ZqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWSezx4tLawsVl0ivC9DPvWS+UGVQ+OHWW5pAYUu5aA=;
        b=WfzUN8YEufU0cM4DOYnVhZLUQAVFV0ubxFqbbMXTn9dpMRkYGcRM2zBw3id5q5pP4u
         UTsAYGBkswuP59JofqXqNpruxi+92akd2I18Mr8K/AQbZgwnefo+Hc/WWUhAJYM1ik2W
         MnS1Pq7tdjia7DCLIG+I7FVxC7TXcQ4Eve22jHaz0GpWlHrIzAkca2zh2x2c9CrJXPOp
         LIQlw7Ul7jx2JKdLPpG6FkVX1VCQx7v1x5ZplHZQTk7cb+8QEAypow4zctSt1gbNbZfW
         tHvPPXQjWdX3KG+X8xKfDPTN1YPE4byKidEsi3kYxiczT+SPmsxNKRlw7sBzlGW0C5l9
         k18Q==
X-Gm-Message-State: AOAM532YU2wxnzVZEOf9440/uJ5h55colMtIeLSnhY8wUYRgBnpac6SG
        +aHUReJMwq7Ts5DsFZ+ucKuB9Am2ZtY2x6W4R3vRRdYR8i6h8Q==
X-Google-Smtp-Source: ABdhPJwGujHjmpczg5w/Siby6hR6SXK1/e0IYxbBFobQsad7eQKg083STa4L481jM/0g+YoXtBA9vhYBrvtcO/nAwH0=
X-Received: by 2002:ac2:5a0f:: with SMTP id q15mr10853896lfn.299.1618852111319;
 Mon, 19 Apr 2021 10:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
In-Reply-To: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 19 Apr 2021 10:08:19 -0700
Message-ID: <CALvZod6haoRmgp++9sqvZaYCo+gaK6t5MSfSZ7XFpm4p6wACwA@mail.gmail.com>
Subject: Re: Killing cgroups
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 8:56 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Hey,
>
> It's not as dramatic as it sounds but I've been mulling a cgroup feature
> for some time now which I would like to get some input on. :)
>
> So in container-land assuming a conservative layout where we treat a
> container as a separate machine we tend to give each container a
> delegated cgroup. That has already been the case with cgroup v1 and now
> even more so with cgroup v2.
>
> So usually you will have a 1:1 mapping between container and cgroup. If
> the container in addition uses a separate pid namespace then killing a
> container becomes a simple kill -9 <container-init-pid> from an ancestor
> pid namespace.
>
> However, there are quite a few scenarios where one or two of those
> assumptions aren't true, i.e. there are containers that share the cgroup
> with other processes on purpose that are supposed to be bound to the
> lifetime of the container but are not in the same pidns of the
> container. Containers that are in a delegated cgroup but share the pid
> namespace with the host or other containers.
>
> This is just the container use-case. There are additional use-cases from
> systemd services for example.
>
> For such scenarios it would be helpful to have a way to kill/signal all
> processes in a given cgroup.
>
> It feels to me that conceptually this is somewhat similar to the freezer
> feature. Freezer is now nicely implemented in cgroup.freeze. I would
> think we could do something similar for the signal feature I'm thinking
> about. So we add a file cgroup.signal which can be opened with O_RDWR
> and can be used to send a signal to all processes in a given cgroup:

and the descendant cgroups as well.

>
> int fd = open("/sys/fs/cgroup/my/delegated/cgroup", O_RDWR);
> write(fd, "SIGKILL", sizeof("SIGKILL") - 1);

The userspace oom-killers can also take advantage of this feature.
