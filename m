Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95824C712
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 23:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHTVRN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 17:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgHTVRM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 17:17:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438ADC061385
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 14:17:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r25so1671057lfe.5
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhaGrKUZGrplU3FJ6j8umgFZML1T4Qnjaml2sZz9odo=;
        b=ZuKqiQ3xaX3Lfh2PTU894rP8VOkqmdcx27cCOxnOBt7xEFAEjJ3CC+ln9bLTpy1WsS
         yTEtdUEhIi4Pea02zFDTl3ALkkvTjqUWMzXNZ27pIiYWx6639XGiDITdyKKBsKFk6WzV
         4T+Vrvw7laL+WCnbgP38MWDiqXy3tS1pSiGWzbDlvNJU0rOgM6+rqQf2Zsi8qxF+nezl
         yl0Qn5djgLqI+x4v39W8REzYFed8KfpkMY3tBiFZ3HIPBGmxHylg70foADv47+UiJqzG
         UK5kl+J9T4QE48lfZ5x5QZOXuJoapDUsHiQaoneEpuMBzXrlRbgMZKaIQN7LPkErMG7P
         TQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhaGrKUZGrplU3FJ6j8umgFZML1T4Qnjaml2sZz9odo=;
        b=jbuXaPAqJzj4UcdJM50smZJl+rcFWkCxQnTJmp3jTRRbhtThmZ0JjqSJJTU39cVDF1
         mWukJ1i8MpbeotRyg0L39PET+s3VH8M/vHh0hb9ugks8vD6swqUwksnJG0Gz4HkqG72A
         EiQ9lplIySuaGmw9EdQdWX+YTJ1f+bETnRkWppKpDwv3X3da2FSD8LChibFukvbyQZ39
         xF22S1pdNUd6Hz8gfF/utiTv0l90YQzmB/kQRvqhfCQgNf8MHYk4XJKxa5IjmvEV2QwH
         IWEUGcu6y++wZUX3XULyxXvrJR0aASvheznUD/bQXp38m/7CnEtU/p58DFPE3t+TxnqX
         c5cg==
X-Gm-Message-State: AOAM533DegIvH0aE8SaE+EsJZPYjkuEwjFobOzfcd/eRQXFBLkES+a+z
        l+FTyZIPHskEu7OtwLZv/Mi3+pF+oj3VNfsrTvxXGA==
X-Google-Smtp-Source: ABdhPJwFSgY1ZKwA4Xx16Cyag1R0mdXgDS8nZReXQnK4r2SqECPyVb9ZyAtyMuV+OsgI6PJwK+ZDUSEuRMX23LABV4M=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr126684lff.189.1597958230344;
 Thu, 20 Aug 2020 14:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200820130350.3211-1-longman@redhat.com> <20200820130350.3211-2-longman@redhat.com>
In-Reply-To: <20200820130350.3211-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 14:16:59 -0700
Message-ID: <CALvZod7=aENT98Lrm6UvDnUrtG8ZT5FosUNb=+EmCkZag3=8GA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/memcg: Clean up obsolete enum charge_type
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 6:04 AM Waiman Long <longman@redhat.com> wrote:
>
> Since commit 0a31bc97c80c ("mm: memcontrol: rewrite uncharge API") and
> commit 00501b531c47 ("mm: memcontrol: rewrite charge API") in v3.17, the
> enum charge_type was no longer used anywhere. However, the enum itself
> was not removed at that time. Remove the obsolete enum charge_type now.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
