Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4423746D1
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhEER2o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbhEERLs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 13:11:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E9C061350
        for <cgroups@vger.kernel.org>; Wed,  5 May 2021 09:43:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z9so3469014lfu.8
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uYZs26n/wyQy1YB8Ay0KGcQh6u0u3FYwEcGuskdOQ8=;
        b=vuuG/mWR6GfoQ9g+2kdjgPJ71W6uK0U4PA6MFirzClqWduHDBDZ0DcmKif+sj7YM5z
         r4lBFW5HF9yY7cI7fqo7GTg9eSfkPfvdWAQKOu3qwoXtRxmJBMXkAqaWmZ6jM2iWeOaF
         UBUn4Xs/LTmsVAttnxgcsqc/7YRmcioCRFI44pInVVdpYYAYeS+BGlSHNWEWbfhO3URH
         FXmRWSnutnQgkHbjOTwbc9a08CpB8HJxJOP3ntRMH8d4r8MJyBeBb6g9VOwxdF6N0BAW
         8pqDgZx3Xt0QqpiUyC8VIOn82dJTB4xsNEkTKGIFEEkuPiZloQP0G/Pt3QbfVN1TbcIU
         pDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uYZs26n/wyQy1YB8Ay0KGcQh6u0u3FYwEcGuskdOQ8=;
        b=fPxAaAkK370p8ToqrvPOUJ1RL5fsk2aqsPfzX+vcGCvM+sbdDon0PAZ+PXZMXOUm1I
         aCArmk8ELT5T5yfvHimV13lDvHy7dOaDK0V8zqMmUGRly1SrNi8rsjRnm1u/vWP1gn0z
         rYhwLNHAKQP5RRcHivz141C58d9WCjna7TjDDBT8+47zpmLTisCK5ZN1/rhtm7kPYPee
         jXzBQnNpqT+07KaBDKhqZUR7eXSXDcyxcniq+XZosPB2VsEbOEmS7+nIqQjTuFWW11SS
         n1boit7YneZ49Tf83vyBBs3Gwxw9QUs3DLwlectNtsROlhcvbYTwF3JljERlxpUHTNVS
         LCnQ==
X-Gm-Message-State: AOAM530zpUOnq4iFQ/5oFqiD0450A+fpLM6R9RCgvD/4+RKIYFtdo6SY
        ngT6FwjU0NWqNd9ko+IkUqAE1TykugXXuT4GIlblhg==
X-Google-Smtp-Source: ABdhPJyllJorNZ6luwFuNScOGvpLenqTKW4ZqA6Xuosi/pPgew0JijomWSScNaZ1MK23p0OHI+11hwkVt9qNss0Pjl4=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr11732217lfr.117.1620233007859;
 Wed, 05 May 2021 09:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210503143922.3093755-1-brauner@kernel.org> <20210503143922.3093755-4-brauner@kernel.org>
In-Reply-To: <20210503143922.3093755-4-brauner@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 09:43:17 -0700
Message-ID: <CALvZod51giGe2_MsHHp=7czY0rKdXBRMi-Ug-oc5avgFwhFaVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tests/cgroup: move cg_wait_for(), cg_prepare_for_wait()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>, containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 3, 2021 at 7:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> as they will be used by the tests for cgroup killing.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
