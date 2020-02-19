Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1868B164A0D
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 17:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBSQV2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 11:21:28 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42886 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSQV2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 11:21:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id o28so617535qkj.9
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1IjE5f3DRWrL7DyNrD/EPrz9NqvpJo1LzwPmSu0Loyo=;
        b=Y0xUdyvI/KOwgnUyUAXVRQts2j2UDpi0MSoQ8O0ZIpFCbCbLaplKvU5pIrb49CIcHK
         Oko/yr/AtoCn2I7wP1Yz/l85vKpPmPYS2VLT7dy7v+KArYcmNL6mvY79eopcTfkaMHlR
         6ad0zsqSYvukfQwQMDKXW3o2M1y+7ZLCHho3eH9+XHp9GDKhBElQTtLcwPW1OzZqDG+o
         ey+6JO61zvRaKvwJ1VNS2Jvb4aETsOQDmV7IiKJxQwWThbSwQ3VPR/0SGwTsSc5081+r
         p4IwL9I721gfQnwgUof/i3OQS3UBN6v3KV2bdrPVFgNPBL/Fy8ditUJoByLUoc/wDrIn
         VXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1IjE5f3DRWrL7DyNrD/EPrz9NqvpJo1LzwPmSu0Loyo=;
        b=lkmBf6++hfCZTK/L97Y8vL5L5604val86OkMQxZ5YupBlxtXOMuBjStUJ34YscROcn
         X43g+o6nn79xxrpOV0vhrE+Freldr9b35gjsgk0ZAR1+1fXBQoyTxOWANecBEqFQ3/3c
         5NxeFYZZYnH4prSjMB5I9PEGzXlbd8ZAqdiFZYqEByCSKI5olZeOcU6efQKEk53mDRqa
         PLUnVjW0y0cGU/gLpCO31u/xBnl9XRdmGplRImDj67/yO1u1xs75y+pnQFH6qa0m00PE
         yRPrGv5zlN7tog5lN+S3iV5j3Yj6D6IY4QRvshtvijw07P9QZUWZ+O2sD4CUVEf9EdII
         o/SQ==
X-Gm-Message-State: APjAAAV5F7rad6SzH/Pe+WhYxsRgpidWDOKKmQa46Io48TS6FFn6MApv
        TCTb7G8iK/FlfD1A0VYPj6ruNA==
X-Google-Smtp-Source: APXvYqx3pDhfMLHjqJZav0TSJad25iHzflnIoh0HNoBZKgS2hYkzGuQm5PMiuKy/xxFf6JF9qCXKSw==
X-Received: by 2002:ae9:ed41:: with SMTP id c62mr23816689qkg.403.1582129287358;
        Wed, 19 Feb 2020 08:21:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id n4sm210781qti.55.2020.02.19.08.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:21:26 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:21:25 -0500
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
Message-ID: <20200219162125.GC13406@cmpxchg.org>
References: <20200214155650.21203-1-Kenny.Ho@amd.com>
 <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local>
 <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com>
 <CAOWid-dA2Ad-FTZDDLOs4pperYbsru9cknSuXo_2ajpPbQH0Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-dA2Ad-FTZDDLOs4pperYbsru9cknSuXo_2ajpPbQH0Xg@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 03:28:40PM -0500, Kenny Ho wrote:
> On Fri, Feb 14, 2020 at 2:17 PM Tejun Heo <tj@kernel.org> wrote:
> > Also, a rather trivial high level question. Is drm a good controller
> > name given that other controller names are like cpu, memory, io?
> 
> There was a discussion about naming early in the RFC (I believe
> RFCv2), the consensuses then was to use drmcg to align with the drm
> subsystem.  I have no problem renaming it to gpucg  or something
> similar if that is the last thing that's blocking acceptance.  For
> now, I would like to get some clarity on the implementation before
> having more code churn.

As far as precedence goes, we named the other controllers after the
resources they control rather than the subsystem: cpu instead of
scheduler, memory instead of mm, io instead of block layer etc.
