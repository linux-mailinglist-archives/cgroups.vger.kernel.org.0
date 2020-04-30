Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D801BEDCF
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 03:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgD3BqJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgD3BqI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 21:46:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7355C035495
        for <cgroups@vger.kernel.org>; Wed, 29 Apr 2020 18:46:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so85050wmb.4
        for <cgroups@vger.kernel.org>; Wed, 29 Apr 2020 18:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kVsytFlvwmRlPq2e2ylTjFJxkqfOFOkO0kcwGuxLXfk=;
        b=sf3CTAKS22+/2W8CwVyZC4W5QTvjxrSQYXYwimx3E04EnhPb09pbOUhgikHbXuQcH8
         4+kqjU+Fm6hsIahZ+JkODsSb30DePYkcdcqXccwLuKGWPQYKN3XiBFqR9XU6ww7e4oJS
         9Sr9WGpbT8cDQDnyDiRS7W5/TjJvUOnc3fL/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kVsytFlvwmRlPq2e2ylTjFJxkqfOFOkO0kcwGuxLXfk=;
        b=U53JG6cbLZDSCQdvJ8QDBMwnFoM0aLY5XajtFBlnO4rYKkXEObSB6BZOiAXX8pQe2x
         KLqKZE8pdiYEpCwjwjY0Oh+FaECEl5kyzESG2Aw9+GWUbyIq6UEOqcY1E4JjVwg46RW+
         tKVAyvbpNIoj5arSfrc0282t4xmy/yczQs31VTW+x1LCJRTWCZvFwadJwX54Kj0iOpFK
         JWbG98ANfeb0zScjzB5w2QMKzylrcHWa/lHUhyavdPj3ofhjyDuino8k5ZsVk9RZJxv7
         OOu2GlP2+2WduVVNwEyEu+dW5PZ1jpk0gNbR8Ecgn7cplbKgdOUufZ7Y0OWHeMz8ihmB
         w0LQ==
X-Gm-Message-State: AGi0PuZEMjUquEFHBPQnC8Hlir1HvXwBH7uz5dNIcp3vFP5gBrZ5WtHT
        pb5c8xi3OldYsY+h2g0/Eb+vsg==
X-Google-Smtp-Source: APiQypL/aU3Pwq63058Nq5MGjoH0yWWJ2d7gZXE32aHzAXjf5qhNdcbhBoNgFELiTQFwET2TOZwLhA==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr208786wmh.180.1588211165307;
        Wed, 29 Apr 2020 18:46:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id a187sm10437581wmh.40.2020.04.29.18.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:46:04 -0700 (PDT)
Date:   Thu, 30 Apr 2020 02:46:03 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200430014603.GB2754277@chrisdown.name>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <CALOAHbCotD1-+o_XZPU_4_i8Nn98r5F_5NpGVd=z6UG=rUcCmA@mail.gmail.com>
 <20200430011626.GA2754277@chrisdown.name>
 <CALOAHbCL_JJgcy9r99Kn81-o_t-fs_nQ+n7aKMHO-02QMCufEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbCL_JJgcy9r99Kn81-o_t-fs_nQ+n7aKMHO-02QMCufEw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yafang Shao writes:
>My concern is why we add these barriers to memcg protection
>specifically but don't add these barriers to the other memebers like
>memcg->oom_group which has the same issue ?
>What is the difference between these members and that members ?

There are certainly more missing cases -- I didn't look at oom_group 
specifically, but it sounds likely if there's not other mitigating factors.  
Most of us have just been busy and haven't had time to comprehensively fix all 
the potential store and load tears.

Tearing is another case of something that would be nice to fix once and for all 
in the memcg code, but isn't causing any significant issues for the timebeing.  
We should certainly aim to avoid introducing any new tearing opportunities, 
though :-)

So the answer is just that improvement is incremental and we've not had the 
time to track down and fix them all. If you find more cases, feel free to send 
out the patches and I'll be happy to take a look.
