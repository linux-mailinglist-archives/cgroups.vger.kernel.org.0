Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9616E228296
	for <lists+cgroups@lfdr.de>; Tue, 21 Jul 2020 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgGUOp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jul 2020 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUOp2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jul 2020 10:45:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE4C0619DA
        for <cgroups@vger.kernel.org>; Tue, 21 Jul 2020 07:45:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so11802020lfh.11
        for <cgroups@vger.kernel.org>; Tue, 21 Jul 2020 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pAwByUR93Lcw7763OHJXsSvUvLTrNih6qhx4gjT+aM=;
        b=RJPk4UVm3QG1OSNEE3CsSct0ln7CZy0uNFBtNkbOJqVixfV+ABWf25M4H+TnYcPfce
         Ta+awLrH5yk/hEx+EREuJMfro+hKQpGe5CFLuXIivkB9MRt63Mgki6+ZSqsYmq60+KGR
         saMyvxi2Hmz1v1xQI2GSgfDNxXTFo1iMzKVWjBJjRBqfCJ1CmI8KNgJBdaDfPJ2tuRhc
         1B2BJWsw4BWQe4cDBiWCe26f3Sag/jnK6MVlPixWUeRZaxdJW6M9dd3rU+dU/oYLU+7I
         NhW4hltGvXPB7wF1uCgYh08R3vYJ9kwAMy5b5J9dOBkBQSe9QqK7WkCSf+m3yniK49H9
         NTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pAwByUR93Lcw7763OHJXsSvUvLTrNih6qhx4gjT+aM=;
        b=ueomE3IhSRkpGa6WJ79Mg7pIrDNDn720uyggntV8tk/sNiCqUWjvrmgArPxT5Y+BpH
         GcfwBj6DbcDnp0ODE5DgvSCm12rjkJigFcnwYBr4IgxYWW8EL3uQfNI8m6Rn6LcO2SIA
         cBp7YULOriyhW8ias2cB+ECIhVnfx3JL8wdVNh3EtnYiM3nYgaAxUZQ13b7CrN1o5UAe
         Z4OA4N0lMEHgIPqWjYlEXaKaJmnTQlGk4QkxSSoouWN0ziyC7l92YMgbHzs/pNUtN3MG
         ISQO99ZV7ez6JYsM/SC7ky6Cpqpdj+ZyT3wxxQVjw9cfMk+Gxdd9SWdURWNRlivvNRb1
         7Erg==
X-Gm-Message-State: AOAM533+0azmybSOSBHK9CtZ/MlYoaiiNySMcKT90tW6EqjOcTVV5Cl7
        Lem+YCgqMYd+AFrIXJ+Q5kzxXD+Ic63w8WmOdG0fFQ==
X-Google-Smtp-Source: ABdhPJx+6QMWrXHBeyyEBoTcyZr8xV8VGVPYDS7ORai+toxRwj0nYcBfTYvA3wm86GBp4I6uRaZTjfvBKCYXxnSWba4=
X-Received: by 2002:ac2:4183:: with SMTP id z3mr10668274lfh.3.1595342725776;
 Tue, 21 Jul 2020 07:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
In-Reply-To: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Jul 2020 07:45:14 -0700
Message-ID: <CALvZod7xGNxJxTcJmo8mCVAgDkPdC5Pp12rhuBNsFsw-Yv=e+A@mail.gmail.com>
Subject: Re: PROBLEM: cgroup cost too much memory when transfer small files to tmpfs
To:     jingrui <jingrui@huawei.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 21, 2020 at 4:20 AM jingrui <jingrui@huawei.com> wrote:
>
> Cc: Johannes Weiner <hannes@cmpxchg.org> ; Michal Hocko <mhocko@kernel.org>; Vladimir Davydov <vdavydov.dev@gmail.com>
>
> Thanks.
>
> ---
> PROBLEM: cgroup cost too much memory when transfer small files to tmpfs.
>
> keywords: cgroup PERCPU/memory cost too much.
>
> description:
>
> We send small files from node-A to node-B tmpfs /tmp directory using sftp. On
> node-B the systemd configured with pam on like below.
>
> cat /etc/pam.d/password-auth | grep systemd
> -session     optional      pam_systemd.so
>
> So when transfer a file, a systemd session is created, that means a cgroup is
> created, then file saved at /tmp will associated with a cgroup object. After
> file transferred, session and cgroup-dir will be removed, but the file in /tmp
> still associated with the cgroup object.

Is there a way for you to re-use the cgroup instead of creating and
deleting cgroup for each individual file transfer session?

> The PERCPU memory in cgroup/css object
> cost a lot(about 0.5MB/per-cgroup-object) on 200/cpus machine.
>
> When lot of small files transferred to tmpfs, the cgroup/css object memory
> cost become huge in this scenes to be used.
>
> systemd related issue: https://github.com/systemd/systemd/issues/16499
>
> kernel version: 4.19+
>
> Problem:
>
> 1. Do we have any idea to descrease cgroup memory cost in this case?
> 2. When user remove cgroup directory, does it possible associated file memory to root cgroup?

No, the memory remains associated with the cgroup and the cgroup
becomes zombie on deletion.

> 3. Can we provide an option that do not associate memory with cgroup in tmpfs?

Only way, if you don't want to disable memcg, is to move the file
receiver process to root cgroup.
