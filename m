Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0623648EF
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhDSRSi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 13:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhDSRSh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 13:18:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27703C06174A
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 10:18:07 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g125so6970320iof.3
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIxa5pKZhjkMDZD7tn48a2LRBGPPmQPQiyr/iVjlfqw=;
        b=0+KNldlgijf3Fpbv/CdK9CemVYKn3Fxwo6WkGaJvXNgi/98kFb1TewHRMDD8Uaukqm
         QW+8UbzPS/y1awQeK7hb2wci0DWtDhPwwLyu4P9hQOK2jW+zPCZaVLMKgCoF2/CBEAf+
         uzc9tC+oqK9milB9dIrV5vGvxWNZCNilYGlDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIxa5pKZhjkMDZD7tn48a2LRBGPPmQPQiyr/iVjlfqw=;
        b=s2cPqg54OTp7BG86cWE9CK7h4W3SSQZB/Yo+tqncxR81DBjO74tOj8QH2yz3y8pfLF
         gg6RgVsrTdY6JEj+eVTwoWJ82z9K8nkAuyCPQRHk1xXDGT/J6sL7sjLXS7ybkxpb4beZ
         LuO97MbjhfTUT5t2lLBh43SahadQcuG5wOnBo3MTS5/boeLU20UgXFUDbwTz30XinQfK
         jDVnkpLYiRyXrP4bgG/HIxrgyJpVN3/daKasUOmTWPdcQvWpjS+RPpHScDeatw+b45CX
         eCVOIdX2ouyfEzk0+gVY/79bKbIzjAlaSp9ZNfpyTyU8BA28J8tyVaFys8cAwZpENaPF
         kn/g==
X-Gm-Message-State: AOAM533oe4clcUGEGws+ETUQAzbR9yu2SQxsOKvjf3EFObvWcAqKpDxk
        ZegN+0OgXTjhycArFxlfM604n8s3y7OoFjeN4c13KQbf+nfu1Q==
X-Google-Smtp-Source: ABdhPJySD5BFbdoO5vG1LnsIBU/9infvehlSJRi2FIt8oApmOom4/jJyx6jrTp6O4shunzX6sGEwHG2wjYncm6FPVfE=
X-Received: by 2002:a02:c017:: with SMTP id y23mr5261555jai.48.1618852686377;
 Mon, 19 Apr 2021 10:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155607.gmwu376cj4nyagyj@wittgenstein> <CALvZod6haoRmgp++9sqvZaYCo+gaK6t5MSfSZ7XFpm4p6wACwA@mail.gmail.com>
In-Reply-To: <CALvZod6haoRmgp++9sqvZaYCo+gaK6t5MSfSZ7XFpm4p6wACwA@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 19 Apr 2021 10:17:29 -0700
Message-ID: <CAMp4zn9_hgKOmamdzzBy5nzLr5pAXQBbuR1sjso-Wck0_3rEfA@mail.gmail.com>
Subject: Re: Killing cgroups
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 10:08 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Apr 19, 2021 at 8:56 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > Hey,
> >
> > It's not as dramatic as it sounds but I've been mulling a cgroup feature
> > for some time now which I would like to get some input on. :)
> >
> > So in container-land assuming a conservative layout where we treat a
> > container as a separate machine we tend to give each container a
> > delegated cgroup. That has already been the case with cgroup v1 and now
> > even more so with cgroup v2.
> >
> > So usually you will have a 1:1 mapping between container and cgroup. If
> > the container in addition uses a separate pid namespace then killing a
> > container becomes a simple kill -9 <container-init-pid> from an ancestor
> > pid namespace.
> >
> > However, there are quite a few scenarios where one or two of those
> > assumptions aren't true, i.e. there are containers that share the cgroup
> > with other processes on purpose that are supposed to be bound to the
> > lifetime of the container but are not in the same pidns of the
> > container. Containers that are in a delegated cgroup but share the pid
> > namespace with the host or other containers.
> >
> > This is just the container use-case. There are additional use-cases from
> > systemd services for example.
> >
> > For such scenarios it would be helpful to have a way to kill/signal all
> > processes in a given cgroup.
> >
> > It feels to me that conceptually this is somewhat similar to the freezer
> > feature. Freezer is now nicely implemented in cgroup.freeze. I would
> > think we could do something similar for the signal feature I'm thinking
> > about. So we add a file cgroup.signal which can be opened with O_RDWR
> > and can be used to send a signal to all processes in a given cgroup:
>
> and the descendant cgroups as well.
>
> >
> > int fd = open("/sys/fs/cgroup/my/delegated/cgroup", O_RDWR);
> > write(fd, "SIGKILL", sizeof("SIGKILL") - 1);
>
> The userspace oom-killers can also take advantage of this feature.

This would be nice for the container runtimes that (currently) freeze,
then kill all the pids, and unfreeze. Do you think that this could also
be generalized to sigstop?
