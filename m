Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF22B1DE880
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2020 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgEVOIL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 May 2020 10:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOIL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 May 2020 10:08:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1CC061A0E
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 07:08:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w15so6556227lfe.11
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASpIJRV1LgbYaIn/8sihf9PSqZ7K//HA8oIfV5Jji1U=;
        b=Q98veh9b1zBp4PWhmCf74WRK0Byrzkwey2rtOIQaXyx1kyEDcG3M6jXlCJOhaNxM5/
         9sj2TOOYHXEwh0fYzQ9FWMZfc0E8eE1/WZ2qrZajc+2KYj6iyYljfm/4TvkU3jkfOFI3
         YYUty1xtwI/bERs9jSMcLkRivOd74V0q8VEyy+weMSJJux6/WgAlmVEJMy5S77lYpI6X
         C4RRVTYaZZ3O6DoGtybBgW13esxeDx7YL6yHgkoJ4xGvMUndKjLCAM0tNGLW0pfCIKJU
         1RIk/vV7uokJ+qdYAfnkLwrgbKEC2CRiXSL18tpjvsHmOZiGRKjVtgqW4lxZcNme/MRF
         2niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASpIJRV1LgbYaIn/8sihf9PSqZ7K//HA8oIfV5Jji1U=;
        b=XWXXXe9oA5kwFd2+KFPDCB4nrSiPhzj+iWnAHSm55pU3k+DmN3NGXHiGy7GTLJRqVc
         XyPdSUZ3hRD6XRcU9IodpteQXMwR9Rc1nXE1w8sL8FOPELqkjEF1AXy1w+shatPJN4gA
         gYgG5P9VztTJLAeTCIFUXAP7Q1ei7dFPBikiTdkhTJ1NKfRRFOAATXP7Nod4eXblZ01s
         mEDv1bV6sF6CKJs1Rj3+l2EbzATVgIDCrc/1VBEgLyHoPJZA7S1418egaZlGBo9fwweP
         UYpIMmGO7UEHvDy512c5DDMWpLySCp3q0ob4TPYBXSUZvOIuQ4fFI0meHtgjfNu1bOip
         sUdw==
X-Gm-Message-State: AOAM530vdjuBHbI13Eh5qOeqB+3WzwVJOHiDDwhXyB2TFonTwBUkdo1U
        43apPcZ6h5n/O3aYzdIGBrxYjNtgl68RQmW46SfkQloX
X-Google-Smtp-Source: ABdhPJx2ifzFEDI+8FVLUA5dMaNvcKyEcuulaqadgxsGJ+06MBXDJr9QzwzWTQLe7Y3YlQblnOnWWMOrrm/JyeFd854=
X-Received: by 2002:a19:490d:: with SMTP id w13mr7491640lfa.96.1590156487605;
 Fri, 22 May 2020 07:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163142.GA808793@chrisdown.name>
In-Reply-To: <20200520163142.GA808793@chrisdown.name>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 May 2020 07:07:56 -0700
Message-ID: <CALvZod6ijEUKTXzi1oDV0R2HdU6bcxUn_zDigskuSPtzn-vw0g@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page allocator
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 20, 2020 at 9:32 AM Chris Down <chris@chrisdown.name> wrote:
>
> Reclaim retries have been set to 5 since the beginning of time in
> 66e1707bc346 ("Memory controller: add per cgroup LRU and reclaim").
> However, we now have a generally agreed-upon standard for page reclaim:
> MAX_RECLAIM_RETRIES (currently 16), added many years later in
> 0a0337e0d1d1 ("mm, oom: rework oom detection").
>
> In the absence of a compelling reason to declare an OOM earlier in memcg
> context than page allocator context, it seems reasonable to supplant
> MEM_CGROUP_RECLAIM_RETRIES with MAX_RECLAIM_RETRIES, making the page
> allocator and memcg internals more similar in semantics when reclaim
> fails to produce results, avoiding premature OOMs or throttling.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
