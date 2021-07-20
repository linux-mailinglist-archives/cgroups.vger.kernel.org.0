Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5993D0250
	for <lists+cgroups@lfdr.de>; Tue, 20 Jul 2021 21:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhGTTIt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jul 2021 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGTTIc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jul 2021 15:08:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6DCC061762
        for <cgroups@vger.kernel.org>; Tue, 20 Jul 2021 12:39:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s13so16005189lfi.12
        for <cgroups@vger.kernel.org>; Tue, 20 Jul 2021 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+MjaH1R1E0F0RWN0i5cSWeDaZRVcDk5Z+roBLBaQww=;
        b=SZzRTqY+pX1aPq5w/WdqDiLB176GplKJ66paQIBWPcVU2KYjcig77AvWa8ubb9Jt8p
         7x/G+AWlv+nLASckmvWWav9PPCbmOqfdl1tOlLC6Q6igjzYwMhYYbsKhVCtbneYxGIVK
         HNrMuYnL6TNDY6EkyhfX17PrbaPZpVYf/YkF93m66+0SJgEZJx5GrPBuJN6CsVV0Q0oL
         pYGUZ181yxFFld48EYPQi+Yx4ypEMf3hgUjhjd9AnIKI6jylx0pjPBVpDES/dXF9JxAR
         OR/SwlcnoT/YOiRLp/zEcZ8gzMy+FBSnB9YbHgJ0g2Ol/G7V4z/QVJngwpcq1lI4tqlO
         oaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+MjaH1R1E0F0RWN0i5cSWeDaZRVcDk5Z+roBLBaQww=;
        b=CNXdNoT5ma1BKdJkqfU+RTluWA7Z7KwPc30uShSbgVt84Z2W7KZGCRf4BEI7ZdXVDk
         Tceb9ubM8INtsZWHNkCbsP1h2TTHKgov08aM0HtvkinjMjPObyg/0CbqmNb2JdcNWpUc
         ncC/GjZqD+7WuFwelT9dgLQ4Evc2jZACLqCMoqALippVUYuy1Bxg2CE5KQaeO2Ol6B9g
         qhI1gZqlhKK2zkZrQmH18EFRpALfUasUoROVzPPlF19PfIQWi+yOPwxZxFbVxm/A51Y7
         Q+Gz1e1k+et+l7OMxPk9n0vFmE+eChS5EMuY6xMaHQfKWnwNew3DJUvz2ixMh5WKiF9V
         QKHg==
X-Gm-Message-State: AOAM530KxK+HUk1SiyMcIJi9XZc0iHInRa74btsIJYGgxoj9MS5fVa6V
        HMBLXr+qSt9U7Fjr89JauN5JAvEvUy+XgVDqTHEojg==
X-Google-Smtp-Source: ABdhPJzG+1FC3rXExMyn/9M/NI+Kx7wgorWIv2GRtmMHPbZt5j+QFFKreGl7OQgcpzc6KGbjJgoMmvmXzE9vriGn/fk=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr23349025lfc.117.1626809982091;
 Tue, 20 Jul 2021 12:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <1626675625-9883-1-git-send-email-nglaive@gmail.com>
In-Reply-To: <1626675625-9883-1-git-send-email-nglaive@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Jul 2021 12:39:31 -0700
Message-ID: <CALvZod5RGZwta+Dpeak9McQd=n_QShzooALCsYrMLbz3ihSiBQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: charge io_uring related objects
To:     Yutian Yang <nglaive@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        shenwenbo@zju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jul 18, 2021 at 11:20 PM Yutian Yang <nglaive@gmail.com> wrote:
>
> This patch is a more complete version than the previous one, adding
> accounting flags to nearly all syscall-triggerable kernel object
> allocations. The patch does not account for temporary objects, i.e.,
> objects that are freed soon after allocation, to avoid meaningless
> performance penalty.
>
> Thanks!
>
> Yutian Yang,
> Zhejiang University
>
>
> Signed-off-by: Yutian Yang <nglaive@gmail.com>

Can you please bring back the commit message of the previous version
(which has the program to trigger the unaccounted allocations) and can
add the details on this one to that?
