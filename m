Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780271BEDDA
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgD3BuX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD3BuX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 21:50:23 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D30C035494;
        Wed, 29 Apr 2020 18:50:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i16so4412739ils.12;
        Wed, 29 Apr 2020 18:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8ASo8zpK+8qPNof8u/cHdMqtlz7+kslUfS8Oj2LKzo=;
        b=YsKFQT3reOM6k0etzlNKatoAoB8eS3oSXg4aogSsGj+BS7hEjdMtOWVXaO77T/HQKw
         hEHrq0ofC8VjwZ/x3c3taB/oV7KRQUk+1oNGjllLZimTrlsev1U6dhu0zYATgrIupuLp
         q0+Pb1D18JWDP/JQ8CNbqKpSNyCWfzylUEcabcyuin1SoTDUBQOEuLVXEL1nTk/jZFS9
         hECoJovbAA/7cRjo02LMY0G2azloJS4+2tS526YUo20DtmTdxQEvDDrFzhMO3rPMVxH4
         xgBf93K/xt09nGnW7hloNRwre4qBtdkX5aRu425sPKLvu0HFOheQBbJp6rxIBG/dv1li
         Tfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8ASo8zpK+8qPNof8u/cHdMqtlz7+kslUfS8Oj2LKzo=;
        b=TaB1/EEomAj4KFhqMtx732zsA2V49a+RO7BtRgDVhdC0Tqgy9wYmzOCb75nnX8ZbBG
         SZ6BNjBDaeivZ7QIFeQumPGarlw6RVKoAcj/xTjgbzKcIlRsSErMBwZt0LKuiNV5BNLe
         HaB/qAIV9Mf24nmQXENEiuxYV6JNkzHSiBQG6M6eQoELavkXcP3wcqQhgoeIwJQVLXor
         ooso4pmvS2xN6nj2uFJRSIWQHPpWQ/m6qPUDmTpbYXcY0lCYgxboMff304KgxA5mILlZ
         o/kWRmi4HjXa2L8jhL0Xyv3NthfQCDPn+GIo1ninDqqG558fHIMRw+2feoObEMK7cE2/
         zOUQ==
X-Gm-Message-State: AGi0PuZUJ81XxwNcoypICF5MWkRarSRD6rXf3oG0cIZsVwI6stBwWDc/
        0gTSHXwywmBP4qlbJIErHaEXcs3jj72UAv5pAqs=
X-Google-Smtp-Source: APiQypKaO9W65Xbq6DTbEi00VBnOqfpMGUq/H4qUQG6zRhnIEl6P9hJ6oEhz+iXGRx5G3BxLEZMkw1nz0eiSb08RjA8=
X-Received: by 2002:a92:8d9d:: with SMTP id w29mr1330029ill.168.1588211422430;
 Wed, 29 Apr 2020 18:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588092152.git.chris@chrisdown.name> <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <CALOAHbCotD1-+o_XZPU_4_i8Nn98r5F_5NpGVd=z6UG=rUcCmA@mail.gmail.com>
 <20200430011626.GA2754277@chrisdown.name> <CALOAHbCL_JJgcy9r99Kn81-o_t-fs_nQ+n7aKMHO-02QMCufEw@mail.gmail.com>
 <20200430014603.GB2754277@chrisdown.name>
In-Reply-To: <20200430014603.GB2754277@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Apr 2020 09:49:46 +0800
Message-ID: <CALOAHbAzZUwGq3mnEtOcSetvAAm+m=X_KnQ2eS9U0QQVHggWYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 30, 2020 at 9:46 AM Chris Down <chris@chrisdown.name> wrote:
>
> Yafang Shao writes:
> >My concern is why we add these barriers to memcg protection
> >specifically but don't add these barriers to the other memebers like
> >memcg->oom_group which has the same issue ?
> >What is the difference between these members and that members ?
>
> There are certainly more missing cases -- I didn't look at oom_group
> specifically, but it sounds likely if there's not other mitigating factors.
> Most of us have just been busy and haven't had time to comprehensively fix all
> the potential store and load tears.
>
> Tearing is another case of something that would be nice to fix once and for all
> in the memcg code, but isn't causing any significant issues for the timebeing.
> We should certainly aim to avoid introducing any new tearing opportunities,
> though :-)
>
> So the answer is just that improvement is incremental and we've not had the
> time to track down and fix them all. If you find more cases, feel free to send
> out the patches and I'll be happy to take a look.

Thanks for your suggestion.
I'm planning to add these barriers all over the memory cgroup code.

-- 
Thanks
Yafang
