Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F2246E85
	for <lists+cgroups@lfdr.de>; Mon, 17 Aug 2020 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgHQRdA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Aug 2020 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389200AbgHQQ4M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Aug 2020 12:56:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46142C061346
        for <cgroups@vger.kernel.org>; Mon, 17 Aug 2020 09:56:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i20so1354358qkk.8
        for <cgroups@vger.kernel.org>; Mon, 17 Aug 2020 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sre2n1Pi8KkTqGTv1s6yeby+p8079BRqjBOJcwiSLww=;
        b=e0lnhMNX4rbCpfxhO+gQeYAWXdMT9zu80lFA0njs6xwsW1qMBlgAAwdV2fB0ZrDmbI
         DJwU3H9e/x24KArsI3bcQm9YF2fnooWNYRP2u0lBlOJpfLosNy8hnAKjfFXmNtk1tfH5
         iHxLc3XXadcqboQN3EKUpEvNmXTEMAqp2DHM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sre2n1Pi8KkTqGTv1s6yeby+p8079BRqjBOJcwiSLww=;
        b=IV9yN2Uu6MEb7SrsuhGO+8/0wB5Vx7gV2QK2b+GNb6i6We7GRVFwCYVqClBkqqPtAe
         GG0BHMYkrLrZQTiZp1e4Ri+VUnIDA8W6iPJ07CHQiMCu/LIwufLgfT9hexVIAd2deOsE
         RDVIlQlXHq0tvoqqeeIIe5IPtGqogWmcwUTh1M9HWe55hI39JBgPovhkyqOTVDoER5jt
         3naIiu21mRSvXljZxszg5ZeVdLKLnl39f9MmdgqZBUkzdMvVBNmbpWLwLRiT3T+NzEXI
         QBx3mLiPmbMAVILIAsx6Msm4UFK5K9dcxjM+RgHI0ZPLbjCqhvZw9bWJQqI3NeB6TNhG
         8UZw==
X-Gm-Message-State: AOAM533y6XLDHtkUBRNE44X6fSe4wNUsKM8lpQuyJYfpeQUplC+iUDXG
        TBoNYtcQjnvuBViRdSHOHp3Qew==
X-Google-Smtp-Source: ABdhPJxZri8aP3S0zZTZ5oc+FXv5KMWFUhk31+VgZOzDluuloBhLwcX29rp5YCOCLko4QBnQct7MsQ==
X-Received: by 2002:a37:4144:: with SMTP id o65mr13531902qka.32.1597683370402;
        Mon, 17 Aug 2020 09:56:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:47cc])
        by smtp.gmail.com with ESMTPSA id n184sm17781669qkn.49.2020.08.17.09.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:56:09 -0700 (PDT)
Date:   Mon, 17 Aug 2020 17:56:08 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 1/8] memcg: Enable fine-grained control of over
 memory.high action
Message-ID: <20200817165608.GA58383@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817140831.30260-2-longman@redhat.com>
 <CALvZod5V3N3K9-tDoaq=JgkeuAK=0TkRf97Vua0khXL+Lxw+Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALvZod5V3N3K9-tDoaq=JgkeuAK=0TkRf97Vua0khXL+Lxw+Pg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Shakeel Butt writes:
>> Sometimes, memory reclaim may not be able to recover memory in a rate
>> that can catch up to the physical memory allocation rate especially
>> when rotating disks are used for swapping or writing dirty pages. In
>> this case, the physical memory consumption will keep on increasing.
>
>Isn't this the real underlying issue? Why not make the guarantees of
>memory.high more strict instead of adding more interfaces and
>complexity?

Oh, thanks Shakeel for bringing this up. I missed this in the original 
changelog and I'm surprised that it's mentioned, since we do have protections 
against that.

Waiman, we already added artificial throttling if memory reclaim is not 
sufficiently achieved in 0e4b01df8659 ("mm, memcg: throttle allocators when 
failing reclaim over memory.high"), which has been present since v5.4. This 
should significantly inhibit physical memory consumption from increasing. What 
problems are you having with that? :-)
