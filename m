Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389B3FD83B
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2019 09:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKOI65 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 03:58:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38044 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKOI64 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 03:58:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so9847953ljh.5
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2019 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+pg9wj7yRXgLDbaXk97MrdYcFuUJiaocpSFiWUQa1o=;
        b=UTHgI7il6nkwPJ5t8b7FMh0XJmESz0IGK7rLutWB2vw6I0WyJlHZc5HzSJe9OJO/Ja
         cy90XKj0jyihqQIuf3/Ck0cF/JNi8a+GasJC5mVdphNQ7QLH8qwoPiyf5YOLM25O8vUE
         e8HS4mV64/idioykbqun7VK9SHxe/G39ajtZOMaPkNT4mZiM3aHLURCdjKP3qGnV9YAF
         qZfzHyhsp1iwHI3ganjVtmXZ/Z8kRYHYojIyVFx6IdWBhExFxC+EmY3F7bcGcsbuVv1A
         3GVwJ9NAqejEzjvYAnJylfaw7p8QaRTdtXztlHIoB5j4SiHJJMjpmlprWqNwfzWFc3or
         IsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+pg9wj7yRXgLDbaXk97MrdYcFuUJiaocpSFiWUQa1o=;
        b=Ic6iW0tUKa1nlDUcK9vqYLRjGYBTF5VM66JnypLapN8UZruL6vJ6QKa0p2IPcp3xiS
         pe90vGVHRc+3Ai3SsyMMO7P7QDZL5VGU8ehXVrsJ7OEATbaJQoRIY59IiCDqBSi98iI7
         nfFKwZ0vTi5+joXF5WtO+eb0CvKsQzSPXligDFCHD6PhdO+RW+LjIur278AqKvWXHtKX
         Noo761fIH4/Vn4yEzKn8boh+H7QePqPWwqXNbdTNuIYev7LsQRI/9CvHtUFmz8zeMLVu
         Y7mtFAqiFozf7cm67159VXrQg7Wg8MkSTp/JyutrDZiWlxzzbS9oykNJMAAWp8tU3ttD
         qE/g==
X-Gm-Message-State: APjAAAVlWph6/88Jy/54i8OhynidtlhnHJ11/DFSmxiT2FQXDAnsW9nN
        kApK6X06LvRHtNQiBPBSFjwtwJrpiiId6LMO2sV18w==
X-Google-Smtp-Source: APXvYqwIDdyPqvILxslSpTDagXqgZxcyneXp6w20bE5evFxcLeT7zIkuP+8wNFzYA/MQKGJ1IfoewtfpTYYk4NobWk0=
X-Received: by 2002:a2e:888a:: with SMTP id k10mr10290408lji.195.1573808334796;
 Fri, 15 Nov 2019 00:58:54 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYviReoG+gq=Jm8yQOMd01j2opae5p+VTGGMK7aLn0xWgw@mail.gmail.com>
 <20191114224213.GN4163745@devbig004.ftw2.facebook.com>
In-Reply-To: <20191114224213.GN4163745@devbig004.ftw2.facebook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Nov 2019 14:28:43 +0530
Message-ID: <CA+G9fYu-w+3qgkGet4B4NeBxQNaXoWij49j0WRwPAYELgakb6w@mail.gmail.com>
Subject: Re: linux-next: arm32: beagleboard x15: WARNING: CPU: 0 PID: 0 at
 /usr/src/kernel/kernel/cgroup/cgroup.c:1969 cgroup_setup_root+0x36c/0x4e8
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, lizefan@huawei.com,
        hannes@cmpxchg.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Fri, 15 Nov 2019 at 04:12, Tejun Heo <tj@kernel.org> wrote:
> > [    0.015402] WARNING: CPU: 0 PID: 0 at /usr/src/kernel/kernel/cgroup/cgroup.c:1969
> > cgroup_setup_root+0x36c/0x4e8
> ...
> > [    0.015726] [<c053ac48>] (cgroup_setup_root) from [<c1c2a260>]
> > (cgroup_init+0x108/0x560)
>
> So, that's saying that the initial kernfs_node ino allocation returned
> something other than 1.  Hmmm... x86_32 works fine.  What does the
> following say?
>
> # mkdir -p /tmp/cgroup2
> # mount -t cgroup2 none /tmp/cgroup2
> # ls -lid /tmp/cgroup2


 mkdir -p /tmp/cgroup2
 mount -t cgroup2 none /tmp/cgroup2
 ls -lid /tmp/cgroup2
 1 dr-xr-xr-x 5 root root 0 Nov 15 08:00 /tmp/cgroup2


Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1011451#L1170

- Naresh
