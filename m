Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1315AE95
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2019 07:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfF3FKm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jun 2019 01:10:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53791 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfF3FKm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jun 2019 01:10:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so12667457wmj.3
        for <cgroups@vger.kernel.org>; Sat, 29 Jun 2019 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/21JLQKbSiGCUYaRJe7+nwJe/s7BHXcW2bb6YBBe9vE=;
        b=sMh5OGxWkcMzotiqbQAZxq5yUs747U8hXAm5IU0xWuMx2HB0QTohc/KWCW+i5xCPRL
         2u51ZA2iwTJZy01MbN4wVlNbrc960x2iOGG+7IGxcR/pPFG4bOqBVRWTbefqZMg6U6Xa
         bPB57rLDSFq5spK5XYoVY9v3X0AjFsPIClCANA6+cRPO1uUyZawZVpoqt1uygaOqvCYI
         JKI4zSLgm6bSb1Pql0InBkG1f8KGby58+V1I1RSCBoHACfmqVPaQT/VIjDWiJo04hPf6
         Ostxl+B+CyubRU11qRC2qlq7tqVEkfSIMvIjD1WLOFPzIjJxFlhe+00xQq0HlKQB47Qg
         Ab1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/21JLQKbSiGCUYaRJe7+nwJe/s7BHXcW2bb6YBBe9vE=;
        b=j2J2ibSQOHZIG15m0DNovnudnTYqYJh55w32T7aBu9arclA3R39bEfNXSjhBGnwegN
         kwhR+uVfWNg004zE5rMqIQ1vz1FdUk0qLbGvlIaxd/keDLV5IdTfh5UJKW4+px7ITnTr
         81s1YNoZuP5kvTaYZ3mV5eb4b3P8P96WKUSjGyeQx0gbc2JQ6z8eZU6i1lA9j52JakQx
         Jl2MuSYx7ZWRY9fQnjWxQyQBb4aXRk209l/LALgqs2/II7/GWU65r8G1TBXt76bEXCBH
         hMlTw0Aj/FcQ2dXH9L1YB6dYU2y8d1uO3LAgR/pcpQhLL230gLNnP2UrUWwxfy2Hj2dz
         nL+A==
X-Gm-Message-State: APjAAAWOb+kh3zkK+ZM4DcV4o1PX8LPVYczp6VRxdSq+QyW6jB5wTopI
        QcL3yk8OZs+Q2W8YDpqcWPUzaxAeloo3Um7M7Zc=
X-Google-Smtp-Source: APXvYqxpaJBC2iDXF6u5DwDzM9SQtL1TwvLfLxe+y66Lwo3m7+Fkhz6wV6G6nXxJ9B6XU8wJQ2T/O3AgjvDeo4AY21g=
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr12370472wme.29.1561871439807;
 Sat, 29 Jun 2019 22:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <CAKMK7uFq7qCpzXqrD4o8Vw_dOwt=ny_oS7TRZFsANpPdC604vw@mail.gmail.com>
In-Reply-To: <CAKMK7uFq7qCpzXqrD4o8Vw_dOwt=ny_oS7TRZFsANpPdC604vw@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Sun, 30 Jun 2019 01:10:28 -0400
Message-ID: <CAOWid-e-gxFBoiBii4wZs0HMnHwCvJWOQWpNopdPHi8So53gNw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/11] new cgroup controller for gpu/drm subsystem
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, Jerome Glisse <jglisse@redhat.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 27, 2019 at 3:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> Another question I have: What about HMM? With the device memory zone
> the core mm will be a lot more involved in managing that, but I also
> expect that we'll have classic buffer-based management for a long time
> still. So these need to work together, and I fear slightly that we'll
> have memcg and drmcg fighting over the same pieces a bit perhaps?
>
> Adding Jerome, maybe he has some thoughts on this.

I just did a bit of digging and this looks like the current behaviour:
https://www.kernel.org/doc/html/v5.1/vm/hmm.html#memory-cgroup-memcg-and-rss-accounting

"For now device memory is accounted as any regular page in rss
counters (either anonymous if device page is used for anonymous, file
if device page is used for file backed page or shmem if device page is
used for shared memory). This is a deliberate choice to keep existing
applications, that might start using device memory without knowing
about it, running unimpacted.

A drawback is that the OOM killer might kill an application using a
lot of device memory and not a lot of regular system memory and thus
not freeing much system memory. We want to gather more real world
experience on how applications and system react under memory pressure
in the presence of device memory before deciding to account device
memory differently."

Regards,
Kenny
