Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17300223B3E
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgGQMRx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 08:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgGQMRx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 08:17:53 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB4C061755
        for <cgroups@vger.kernel.org>; Fri, 17 Jul 2020 05:17:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id br7so10491174ejb.5
        for <cgroups@vger.kernel.org>; Fri, 17 Jul 2020 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n/pa5dW3hIKbP2t0G0f2EcEX6PNbXUQ5fuTdYCae6vA=;
        b=IV2BvGMeNhyhjNOB2Es2XKswxXP3OHp2eQYgh22DqMsl6TerVaUZO23vPyszdLx9Vq
         cFTst0pdov917g0M4eFrsOopy4Cz34VvQ0sBXmpZlszX7IvigmOqk0zp5ZJeXNZMYjF/
         q10TaZMjTNhDQu2wLqIjdFpM8JxdSQ8TzCI80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n/pa5dW3hIKbP2t0G0f2EcEX6PNbXUQ5fuTdYCae6vA=;
        b=e9Fw9OszuTyde49bM6N7UDrVyCHrMwI6QfidLycIPwKuEbgDcztwDbHgggR9DmAxnO
         JqXgI5BTJ7GLVEVjAeXoMq8OCq7kaqn94p6dIlsUnhA1xCNyQWWPYVajTeMxoSDk41Ec
         8G8WTLAqnixnNqbbOjrgY9tz5Lg0bEYpWKUmHWFrjAANZ7QL4+wPp+6UZvoaifsVM7KS
         +uuC7CZ2VTyuhVBDX/IHuAWqKU4zDh0b4Q+g5y8XjtuMVtxQVxpNY1jOS7NbiOzYGoEc
         i+PTpQa+rrfDw4F+yp3GDlabWzGoPMcMc1jljnGmUcxkBfWAVL/KUWUHgUKAwDaXSP0C
         +MHA==
X-Gm-Message-State: AOAM530r3cimc16z5GROTwOrbLcAh5DrpzaL3l4C78q+VMRv8QMEjEMM
        pogUVTkcyfOOBizAv4m/8SbSdg==
X-Google-Smtp-Source: ABdhPJz7wKfXvuyTUniCMMV5pqpKoyxtlthWPk8n9t0shkwzJ5H8cFc1LinEnHX0oWfIs2EbzfMVzw==
X-Received: by 2002:a17:906:748:: with SMTP id z8mr8513197ejb.257.1594988271544;
        Fri, 17 Jul 2020 05:17:51 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:a5b1])
        by smtp.gmail.com with ESMTPSA id v25sm8161318edr.74.2020.07.17.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 05:17:51 -0700 (PDT)
Date:   Fri, 17 Jul 2020 13:17:50 +0100
From:   Chris Down <chris@chrisdown.name>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, memcg: provide a stat to describe reclaimable memory
Message-ID: <20200717121750.GA367633@chrisdown.name>
References: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com>
 <20200715131048.GA176092@chrisdown.name>
 <alpine.DEB.2.23.453.2007151046320.2788464@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2007151046320.2788464@chino.kir.corp.google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi David,

David Rientjes writes:
>With the proposed anon_reclaimable, do you have any reliability concerns?
>This would be the amount of lazy freeable memory and memory that can be
>uncharged if compound pages from the deferred split queue are split under
>memory pressure.  It seems to be a very precise value (as slab_reclaimable
>already in memory.stat is), so I'm not sure why there is a reliability
>concern.  Maybe you can elaborate?

Ability to reclaim a page is largely about context at the time of reclaim. For 
example, if you are running at the edge of swap, at a metric that truly 
describes "reclaimable memory" will contain vastly different numbers from one 
second to the next as cluster and page availability increases and decreases. We 
may also have to do things like look for youngness at reclaim time, so I'm not 
convinced metrics like this makes sense in the general case.

>Today, this information is indeed possible to calculate from userspace.
>The idea is to present this information that will be backwards compatible,
>however, as the kernel implementation changes.  When lazy freeable memory
>was added, for instance, userspace likely would not have preemptively been
>doing an "active_file + inactive_file - file" calculation to factor that
>in as reclaimable anon :)

I agree it's hard to calculate from userspace without assistance, but I also 
generally think generally exposing a highly nuanced and situational value to 
userspace is a recipe for confusion. The user either knows mm internals and can 
understand it, or don't and probably only misunderstand it. There is a non-zero 
cognitive cost to adding more metrics like this, which is why I'm interested in 
knowing more about the userspace usage semantics intended :-)

>The example I gave earlier in the thread showed how dramatically different
>memory.current is before and after the introduction of deferred split
>queues.  Userspace sees ballooning memcg usage and alerts on it (suspects
>a memory leak, for example) when in reality this is purely reclaimable
>memory under pressure and is the result of a kernel implementation detail.

Again, I'm curious why this can't be solved by artificial workingset 
pressurisation and monitoring. Generally, the most reliable reclaim metrics 
come from operating reclaim itself.
