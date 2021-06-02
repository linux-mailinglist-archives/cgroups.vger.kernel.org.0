Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC4398502
	for <lists+cgroups@lfdr.de>; Wed,  2 Jun 2021 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFBJN1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Jun 2021 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhFBJN0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Jun 2021 05:13:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537BC061574
        for <cgroups@vger.kernel.org>; Wed,  2 Jun 2021 02:11:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x15so1971087oic.13
        for <cgroups@vger.kernel.org>; Wed, 02 Jun 2021 02:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiAxINQdIi7+HKRfHkFG9l2vkzASih/fGHAjPl9o30o=;
        b=Lfml9qG8E5om9EGGt1K9NrtEPh3JmhHemfh/T9ecn4hRxiACaf+qtqZDkwaOb9trMG
         ixX+y+wRuf9EwKeYGeMFgWmTx4j4EFKRvSYA0T9z4yZrOudlee98LFKNYwrCY3zjbdkC
         yQQQEGXE9yiZwWEN3sZma/nlj+w6IZ+I+qQMga77fgthsNu9DMlV21wJIUt5FhABt4JQ
         8HcqQe7gyou6nJbv/rShsG5Mf/3ioXoGQkS3DDgwQ54l46DBN0WZbM8JMiodb55t0ppq
         I9dFPFDNvA7BTLTCQVG/Q3qItNTBfcihwoRp5Zum/8gMvXIPSUYGLALNE+vB3aSk88YP
         KodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiAxINQdIi7+HKRfHkFG9l2vkzASih/fGHAjPl9o30o=;
        b=i/3BKB4434tUEhc6cvcYryK8zBF3NMkFCWC7D3QgGwIRp5Esost/AQIAjh/AIjaHtr
         kRGC6KtrGEX4RE6L9RlAc6dVHWQ1GkK6oGG6kR8j4zMUxYyKTL6GPGlBPIUUVFkOWygk
         MUi20J0W5klYJLVspS0HG3K6jj2UpzJqiUqyve2gf+0selD+mzXlxI+h2qWDwvrLj7Oa
         /8nLyXsYJ9wGS69HW7xw+bozMGddiCMkKa+/oBTtid2QTGDXVNEi0fPrsQ8nfakAFT/Q
         ob19GLcNu0RycMZTdIl2ciFTXH3rFBjZgIeY4nDItZsV3NeyeRsECUsIsE8vEMZ4cd8Q
         +YHA==
X-Gm-Message-State: AOAM530V7EHTpkqG+tDCBaDFEl3BXUFR89g9LUkIt+lQiZ5coZKoqvIL
        pUVUgseQpPSquQ0BLOfyTn5ZsQtIxw5BsKcJI8o=
X-Google-Smtp-Source: ABdhPJxt0e62W0fleD+lVbVQs4PUfIpjRBhm4weeIQP47c+R5HbP+Sq1IvFsgmUWw4T7ULWm3dqQvJYL0ozfi+QiIqI=
X-Received: by 2002:aca:fcca:: with SMTP id a193mr3306773oii.40.1622625103325;
 Wed, 02 Jun 2021 02:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622043596.git.yuleixzhang@tencent.com> <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com> <YLZIBpJFkKNBCg2X@chrisdown.name>
In-Reply-To: <YLZIBpJFkKNBCg2X@chrisdown.name>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Wed, 2 Jun 2021 17:11:32 +0800
Message-ID: <CACZOiM21STLrZgcnEwm8w2t82Qj3Ohy-BGbD5u62gTn=z4X3Lw@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
To:     Chris Down <chris@chrisdown.name>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 1, 2021 at 10:45 PM Chris Down <chris@chrisdown.name> wrote:
>
> yulei zhang writes:
> >Yep, dynamically adjust the memory.high limits can ease the memory pressure
> >and postpone the global reclaim, but it can easily trigger the oom in
> >the cgroups,
>
> To go further on Shakeel's point, which I agree with, memory.high should
> _never_ result in memcg OOM. Even if the limit is breached dramatically, we
> don't OOM the cgroup. If you have a demonstration of memory.high resulting in
> cgroup-level OOM kills in recent kernels, then that needs to be provided. :-)

You are right, I mistook it for max. Shakeel means the throttling
during context switch
which uses memory.high as threshold to calculate the sleep time.
Currently it only applies
to cgroupv2.  In this patchset we explore another idea to throttle the
memory usage, which
rely on setting an average allocation speed in memcg. We hope to
suppress the memory
usage in low priority cgroups when it reaches the system watermark and
still keep the activities
alive.
