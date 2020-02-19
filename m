Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA8F164DC7
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSSio (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 13:38:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40960 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBSSio (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 13:38:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so950431qtr.8
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Doxcme7+jrZwJS6ST/rzTNwpMBSbirxVwxv1qEdw5s=;
        b=rYeKImttZI7x6bzjER2czevU8xhzoiO0fHOwBWL2BT4hsGECSGmyqPgoGTV4CucsBZ
         uTnJoXNwR7UAglw3UPw1NxLU5ddpTksdSVtT5QjXF1AnurYfoBBc8IdvY2YodtGt8z0M
         QacjY8wuodiTGBs0IVVATW2YMRzBMkLiyZHVjGvvF9BNoW9pjzl8ft6Qnc6yAvcSuxDs
         UzhfJPLoXJgkQP5KuxvV/2RNezt7UtdUOKjQ2fR59CK2Jo345MJFsX4yD2NmH1oVRyhb
         ArUtmfikqkqsHkSnUBKIK5mbtPTvuTR16p7k9MSKdETJT+ebL/CRLYK+ZgbmmphjUcH0
         eXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Doxcme7+jrZwJS6ST/rzTNwpMBSbirxVwxv1qEdw5s=;
        b=ocirwJqvRzguDIFMlcZhfoz/8d9jZY3YQPpxDzUW7zoJolv18sA0aEkiFVdiv/sftN
         ANf74LJTeZr9HC9ebCd2/hWcbO3XqlsBBmZVOVD9gEgO1kopFAN1MsW8WdJOET1ONw7Y
         53TiD8uIMS6Mn6s+/3kMl0UzzVzMGSTuv1edSrGNsgfJklnGqUIIV/H0BRnxuwlVQYn9
         4rFRXZvCNg0f/M1quAetxkjUXlbyvLIGtbRQMbMYzdGbL3baG3Ey0gAo/GgpVGgcU37D
         o5vigAEucK7AG9mjitVZFHQi9QSwIkuQeqZabYXWEN5spzHG9wIkhsSueEZBBfi9plYr
         ceBA==
X-Gm-Message-State: APjAAAXEsBtKIfpTa34JSQTIz3tNdOxCjdfLxJ9F98x6D1N0WL3jzs53
        p1sLBW5wWerb6KefKGipTzCDGA==
X-Google-Smtp-Source: APXvYqzKQY+wCwO5dOV01Ah7jfljGDG/Ul5zVw7kKLgCnfZrY8hsRus06+mtT0cEH4YRMtnIpYneFg==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr22890647qtg.314.1582137523279;
        Wed, 19 Feb 2020 10:38:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id z1sm402480qtq.69.2020.02.19.10.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:38:41 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:38:41 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, nirmoy.das@amd.com, damon.mcdougall@amd.com,
        juan.zuniga-anaya@amd.com
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
Message-ID: <20200219183841.GA54486@cmpxchg.org>
References: <20200214155650.21203-1-Kenny.Ho@amd.com>
 <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local>
 <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com>
 <20200219161850.GB13406@cmpxchg.org>
 <CAOWid-e=7V4TUqK_h5Gs9dUXqH-Vgr-Go8c1dCkMux98Vdd1sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-e=7V4TUqK_h5Gs9dUXqH-Vgr-Go8c1dCkMux98Vdd1sQ@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 11:28:48AM -0500, Kenny Ho wrote:
> On Wed, Feb 19, 2020 at 11:18 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Yes, I'd go with absolute units when it comes to memory, because it's
> > not a renewable resource like CPU and IO, and so we do have cliff
> > behavior around the edge where you transition from ok to not-enough.
> >
> > memory.low is a bit in flux right now, so if anything is unclear
> > around its semantics, please feel free to reach out.
> 
> I am not familiar with the discussion, would you point me to a
> relevant thread please?

Here is a cleanup patch, not yet merged, that documents the exact
semantics and behavioral considerations:

https://lore.kernel.org/linux-mm/20191213192158.188939-3-hannes@cmpxchg.org/

But the high-level idea is this: you assign each cgroup or cgroup
subtree a chunk of the resource that it's guaranteed to be able to
consume. It *can* consume beyond that threshold if available, but that
overage may get reclaimed again if somebody else needs it instead.

This allows you to do a ballpark distribution of the resource between
different workloads, while the kernel retains the ability to optimize
allocation of spare resources - because in practice, workload demand
varies over time, workloads disappear and new ones start up etc.

> In addition, is there some kind of order of preference for
> implementing low vs high vs max?

If you implement only one allocation model, the preference would be on
memory.low. Limits are rigid and per definition waste resources, so in
practice we're moving away from them.
