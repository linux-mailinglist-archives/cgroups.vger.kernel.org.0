Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53922481E0
	for <lists+cgroups@lfdr.de>; Tue, 18 Aug 2020 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHRJ1n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Aug 2020 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgHRJ1k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Aug 2020 05:27:40 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEDFC061343
        for <cgroups@vger.kernel.org>; Tue, 18 Aug 2020 02:27:40 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so17599288qkd.6
        for <cgroups@vger.kernel.org>; Tue, 18 Aug 2020 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1uRMktfRV5crgPVmS/xcdDcOHzetxlDlwwdgtJx5JA=;
        b=aXZCsxwprTxASQu2DNMwoUtCZ6t+hAn/5sw5abMV4tonMk0SgnkIntg7cbyYTZWblV
         6aEwV7fV6oFYpxM4V71CUTNFU+ySLfcQw6a2IuXnzfyCU985kgho/mfmw+W4V4KlsDoV
         HACh+ZAEE3ZN9fLfhWnARV3NpdrsfiULbLeio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1uRMktfRV5crgPVmS/xcdDcOHzetxlDlwwdgtJx5JA=;
        b=IDXrJT40zRKNS1yyZ7tX0BDNKPw9gM6wrShXLjfewPZOnXqqxMf9oh/WP8xZzw+OPM
         nyE4oLWo3P5vyAf2i2Uen0jLKDyAuiHE9/Vro7Rr5pdQvr7/aGE6rYupiHqulEcb7s1x
         o8ISxOY9gOVRVhg9iKEHbTlnpyAxsOpk0fcBI8MEvinNoVFM8EW54k/W0tg83b+7SR/v
         NtW+XPSOb3D21DtR/g16pBcYuHKuVzYcJLuwYASoUc/m9Zuwku4Z1wvv3V8+WlI1TzrO
         MhAg+6rlCfOMaFOwEIz5i6T0Sbqe5CAiB/SBH4ry+A9hI7MVfUriFomaSX2AYUS78WMZ
         zUFQ==
X-Gm-Message-State: AOAM533J2EZqgWlCg93SErG4G/i6fu4RK1fH0WA5LWyYKuwVSldltYN2
        K1WnEqP41ZYc95aIliKZIs1PZQ==
X-Google-Smtp-Source: ABdhPJyjRbj82qo14ynmuKZgINBcTQu1SV2ro8jRAdmhpvPscAYrmOepaS8i23X7ke5WKJ6U1bhfGg==
X-Received: by 2002:a37:a104:: with SMTP id k4mr16018682qke.384.1597742859405;
        Tue, 18 Aug 2020 02:27:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:179c])
        by smtp.gmail.com with ESMTPSA id d16sm19784856qkk.106.2020.08.18.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:27:39 -0700 (PDT)
Date:   Tue, 18 Aug 2020 10:27:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     peterz@infradead.org
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200818092737.GA148695@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818091453.GL2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

peterz@infradead.org writes:
>On Mon, Aug 17, 2020 at 10:08:23AM -0400, Waiman Long wrote:
>> Memory controller can be used to control and limit the amount of
>> physical memory used by a task. When a limit is set in "memory.high" in
>> a v2 non-root memory cgroup, the memory controller will try to reclaim
>> memory if the limit has been exceeded. Normally, that will be enough
>> to keep the physical memory consumption of tasks in the memory cgroup
>> to be around or below the "memory.high" limit.
>>
>> Sometimes, memory reclaim may not be able to recover memory in a rate
>> that can catch up to the physical memory allocation rate. In this case,
>> the physical memory consumption will keep on increasing.
>
>Then slow down the allocator? That's what we do for dirty pages too, we
>slow down the dirtier when we run against the limits.

We already do that since v5.4. I'm wondering whether Waiman's customer is just 
running with a too-old kernel without 0e4b01df865 ("mm, memcg: throttle 
allocators when failing reclaim over memory.high") backported.
