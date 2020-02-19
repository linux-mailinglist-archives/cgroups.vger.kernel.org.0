Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6B164A54
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBSQ3D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 11:29:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41652 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQ3D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 11:29:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so1249813wrw.8
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ge/4+ByC0/Mud4KiwRUU53N7gO/qK6WBDI8vObP1gB8=;
        b=nDEVLs/IIZtpORix+sjwoMjmtO3ZAlRhhQOEfU0Q3KD5K86wBr1q0mJXuabDlIvOQn
         bWxkMy74M7+LpTozg1bTdVroNdJeMZB86wLHLvmgqG6hPqBEbJLuSIxO98UyMi2CO2Cg
         F/qVeSmjj3CsDqfixTLub97ue2qI8iicYlfld0biO2Ij6QI08x5vVOTJ2cc6XWa9oaIt
         KWkrOo9yjogrswdLtiCsg4MTzFw6YueFqqNbfHkDY73ocDk8GXU2a2GGvtFWVfqqp1NX
         WZOgptcWjxiTjC17ZwO0BXYsXIiY9nsntQ3a1wjPCFgL1BLE9yWYBAi5JGRkGUCdWl/j
         qdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ge/4+ByC0/Mud4KiwRUU53N7gO/qK6WBDI8vObP1gB8=;
        b=H1jR0+qYG6+N//VB+zpg27FPK+/rwYqXHYncr0MqenIO63eQ6Mzr4X9eRPjg91lWE8
         ZJrcC79S/lCGsa0V7+W9mhrPmxgcjEI/40XUg8beiCXUPjlJJCMkHcEnp+fJ/S7KY8gn
         jCcuC/QhWRdHa87aY3zPuDpkZJ1f440SMuZi9vLToRNgkXGg64rNzex9W/npflzVr4ph
         +NR2HXXiM2/MlvbsT67NY1zvPqSvnCFvQDufz+9pOIykS6pJBGUDrk3SG9T0+Vhj9W1r
         eZL9QtnncsB7CCMx051u3K+k6eFWo9a879GnHnQxcn5ZEIg6QEkqbqdgFcPVn/Zf9cDb
         zmRw==
X-Gm-Message-State: APjAAAW7/OFsXAfnK4/uctcZPNGHLgWzjlFg1h4hKKysYb+1+RWrQsaU
        r2yh+LFp08t8oFmpkG9skgoXBHwIu8GNFH1MSQVI9hnHsFg=
X-Google-Smtp-Source: APXvYqyP+L9+XOLBDf5SEUNbZhoITOmxettkhcIIuxzCeHf43MW2BeliuAzIc4CO4JF7Ah7P3g9oJtkoiotJv45DS9Y=
X-Received: by 2002:adf:cd03:: with SMTP id w3mr37455254wrm.191.1582129741265;
 Wed, 19 Feb 2020 08:29:01 -0800 (PST)
MIME-Version: 1.0
References: <20200214155650.21203-1-Kenny.Ho@amd.com> <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local> <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com> <20200219161850.GB13406@cmpxchg.org>
In-Reply-To: <20200219161850.GB13406@cmpxchg.org>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 19 Feb 2020 11:28:48 -0500
Message-ID: <CAOWid-e=7V4TUqK_h5Gs9dUXqH-Vgr-Go8c1dCkMux98Vdd1sQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, nirmoy.das@amd.com, damon.mcdougall@amd.com,
        juan.zuniga-anaya@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 11:18 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Yes, I'd go with absolute units when it comes to memory, because it's
> not a renewable resource like CPU and IO, and so we do have cliff
> behavior around the edge where you transition from ok to not-enough.
>
> memory.low is a bit in flux right now, so if anything is unclear
> around its semantics, please feel free to reach out.

I am not familiar with the discussion, would you point me to a
relevant thread please?  In addition, is there some kind of order of
preference for implementing low vs high vs max?

Regards,
Kenny
