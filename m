Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4303431A10
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhJRMxl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhJRMxk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 08:53:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC62C061714
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 05:51:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so12416678pjb.4
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qfX+ndSVWKM3Vi8c2fHOw8/MXzmsVryHdiKR0AyJ9xw=;
        b=sSv9dZOV+JAzYZFPXw+1oG8Vh/GTMCXkKdXXtKcac2ijdJAv1EcSM3SkiA7mC6O3W+
         2dRpqmvnGyYV9e2m64/IbFfC9zlgSxTLFtM7+I/brndJjnuxK0/vIiDIq6hDS+MmrgHB
         2KrH6UwdouPpwMbLOfbK3Fj778dbO6ZyQJgipYsxVXN2MEotKlskxaRG8QrfoBa1/Ss/
         hzpG8x9LQ3PhtOvpc2dq/k8jMQ4ABHTcTUI/UwXmDNl3TLOcRE5+d3szOYFWY4KutkbV
         nIIZ/jBt++HPMC0vCZzQj0tEDUNP207JrL7ZoJQPircDipt9sBjBeSSdyrI2G18iUbrA
         0GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=qfX+ndSVWKM3Vi8c2fHOw8/MXzmsVryHdiKR0AyJ9xw=;
        b=faeWlzuAlw5nT6UrjVahFAkkDy6OLRC+czzKcnGRFyTFo/QEMrLcwAzpGbGHN7MdRh
         g7/HTm08CBDTtAUR/Dh16XzlVUBgz5+wuIGOTuXhsOipai7P0usYC4hek1OnYQ/C5XPZ
         rySrj8VY6uE3R6bonwVK8EKCJRw9fjhdiUZEIoVE8uoCB+3LsB9TbTIRGTzMTESWjjXd
         vGHRjw5awGWLNW3d3eJqs4b18f5eoEcglB0TJPo6770PaUlapQsbtnQEjrD1Arf3qp98
         IznQxnkJGRso5UAC4MeC8UeQbF0N9BsCgHPu6LZ1xQ7hRvK2sggCyVD8IScoBR/2jyKX
         cKxA==
X-Gm-Message-State: AOAM5300yjG/9qoomRfA9/Oby8sghaBQ2JgmMYB88MsYSu2Or1jDj04K
        PezJ98UbVJkGtScdLiUHSCPiPqfVLwCdxc3WJuzGHA==
X-Google-Smtp-Source: ABdhPJzE1LgHATAFF1Wq/cTuV/lozzAKLvWm8zBU+nEtkLGhJSU0sTv84Na/zq2pLq7BZyJMwMy6kvGw0T62dQ4C1o4=
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr33780030pjb.173.1634561489167;
 Mon, 18 Oct 2021 05:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
In-Reply-To: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 18 Oct 2021 05:51:18 -0700
Message-ID: <CAHS8izPZZG6MEmyieQL-4aR=NArjb87Bk6fB7FP7ohFHD5DWww@mail.gmail.com>
Subject: Re: [RFC Proposal] Deterministic memcg charging for shared memory
To:     Roman Gushchin <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, cgroups@vger.kernel.org,
        riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 12:23 PM Mina Almasry <almasrymina@google.com> wrot=
e:
>
> Below is a proposal for deterministic charging of shared memory.
> Please take a look and let me know if there are any major concerns:
>

Friendly ping on the proposal below. If there are any issues you see
that I can address in the v1 I send for review, I would love to know.
And if the proposal seems fine as is I would also love to know.

Thanks!
Mina

> Problem:
> Currently shared memory is charged to the memcg of the allocating
> process. This makes memory usage of processes accessing shared memory
> a bit unpredictable since whichever process accesses the memory first
> will get charged. We have a number of use cases where our userspace
> would like deterministic charging of shared memory:
>
> 1. System services allocating memory for client jobs:
> We have services (namely a network access service[1]) that provide
> functionality for clients running on the machine and allocate memory
> to carry out these services. The memory usage of these services
> depends on the number of jobs running on the machine and the nature of
> the requests made to the service, which makes the memory usage of
> these services hard to predict and thus hard to limit via memory.max.
> These system services would like a way to allocate memory and instruct
> the kernel to charge this memory to the client=E2=80=99s memcg.
>
> 2. Shared filesystem between subtasks of a large job
> Our infrastructure has large meta jobs such as kubernetes which spawn
> multiple subtasks which share a tmpfs mount. These jobs and its
> subtasks use that tmpfs mount for various purposes such as data
> sharing or persistent data between the subtask restarts. In kubernetes
> terminology, the meta job is similar to pods and subtasks are
> containers under pods. We want the shared memory to be
> deterministically charged to the kubernetes's pod and independent to
> the lifetime of containers under the pod.
>
> 3. Shared libraries and language runtimes shared between independent jobs=
.
> We=E2=80=99d like to optimize memory usage on the machine by sharing libr=
aries
> and language runtimes of many of the processes running on our machines
> in separate memcgs. This produces a side effect that one job may be
> unlucky to be the first to access many of the libraries and may get
> oom killed as all the cached files get charged to it.
>
> Design:
> My rough proposal to solve this problem is to simply add a
> =E2=80=98memcg=3D/path/to/memcg=E2=80=99 mount option for filesystems (na=
mely tmpfs):
> directing all the memory of the file system to be =E2=80=98remote charged=
=E2=80=99 to
> cgroup provided by that memcg=3D option.
>
> Caveats:
> 1. One complication to address is the behavior when the target memcg
> hits its memory.max limit because of remote charging. In this case the
> oom-killer will be invoked, but the oom-killer may not find anything
> to kill in the target memcg being charged. In this case, I propose
> simply failing the remote charge which will cause the process
> executing the remote charge to get an ENOMEM This will be documented
> behavior of remote charging.
> 2. I would like to provide an initial implementation that adds this
> support for tmpfs, while leaving the implementation generic enough for
> myself or others to extend to more filesystems where they find the
> feature useful.
> 3. I would like to implement this for both cgroups v2 _and_ cgroups
> v1, as we still have cgroup v1 users. If this is unacceptable I can
> provide the v2 implementation only, and maintain a local patch for the
> v1 support.
>
> If this proposal sounds good in principle. I have an experimental
> implementation that I can make ready for review. Please let me know of
> any concerns you may have. Thank you very much in advance!
> Mina Almasry
>
> [1] https://research.google/pubs/pub48630/
