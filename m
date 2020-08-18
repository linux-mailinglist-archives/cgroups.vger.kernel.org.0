Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD642482C8
	for <lists+cgroups@lfdr.de>; Tue, 18 Aug 2020 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgHRKSD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Aug 2020 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHRKSA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Aug 2020 06:18:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DDC061342
        for <cgroups@vger.kernel.org>; Tue, 18 Aug 2020 03:17:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 6so14713944qtt.0
        for <cgroups@vger.kernel.org>; Tue, 18 Aug 2020 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m1d0Rse+qIi8qOmerhrf+MBXKELTuAtcs3p/xFrqf9w=;
        b=s4u3GuRFjGb61CKAXSbV1lMqnOMke9WVYpJMh0BBQqdPfrVKbnnOMGI9JvyBbgPm6e
         x6rVvOlI1ANNxy8+m3bcc1IECDj2KsJGcWVy2WR+CvANx/bwNtWdEoEKDgNVzfp3pHop
         hA9rOJBnJ6hFK8QUbuzjs02965lEQZmkx0qyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m1d0Rse+qIi8qOmerhrf+MBXKELTuAtcs3p/xFrqf9w=;
        b=qUIUX+VM6aBK8F4csu4X/d3yg1CJ/WdOW9PLm/V9E+JJfrf5CPyFMbvR4IX2p3ofPJ
         OJ1OWk/E3QQN1vcx3EsWhShvvqe7mEPK0ELq2zdyTQ4DRXDYHOWpxxbQbkjTegGgiLmQ
         cfI+rkcz7bv5A4n1Kgcvr93pbhJMy8hxXWirz0aMSZwhQCuZZc349MELAD2XjloIGBWq
         ovaJJwEaaZDNtHcyBQci92v/S/6o9e5gGsWkLBArEJwkDnz4dZc1g6DdAwO0/qUtv/cR
         K8/62ooS0nZ6rr/rHgIiKBqqXZXf9GpF0XkbYHo3pNJ3chfhvK7tI0Vwn5sUX3nww/BV
         Y0QA==
X-Gm-Message-State: AOAM531IAu789tgRb+pgy1QEOK1IoO+Qw6b7nV3hQ12axgHaahc9mn1X
        qtcMTmRNv3q/iny7ddYbjZsYjQ==
X-Google-Smtp-Source: ABdhPJwu2U26qaTDnNyVaIc78vhIlLEidrEGudHY3cyjqUjwF2jv5oW0015yCO0u1NOmZFEU8PeD0g==
X-Received: by 2002:ac8:65c2:: with SMTP id t2mr16990912qto.370.1597745878056;
        Tue, 18 Aug 2020 03:17:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:179c])
        by smtp.gmail.com with ESMTPSA id w1sm20614419qkj.90.2020.08.18.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 03:17:57 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:17:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     peterz@infradead.org
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <20200818101756.GA155582@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818095910.GM2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

peterz@infradead.org writes:
>But then how can it run-away like Waiman suggested?

Probably because he's not running with that commit at all. We and others use 
this to prevent runaway allocation on a huge range of production and desktop 
use cases and it works just fine.

>/me goes look... and finds MEMCG_MAX_HIGH_DELAY_JIFFIES.
>
>That's a fail... :-(

I'd ask that you understand a bit more about the tradeoffs and intentions of 
the patch before rushing in to declare its failure, considering it works just 
fine :-)

Clamping the maximal time allows the application to take some action to 
remediate the situation, while still being slowed down significantly. 2 seconds 
per allocation batch is still absolutely plenty for any use case I've come 
across. If you have evidence it isn't, then present that instead of vague 
notions of "wrongness".
