Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5994621F655
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2020 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGNPp5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jul 2020 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgGNPp4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jul 2020 11:45:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C037C061755
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2020 08:45:56 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z63so15949955qkb.8
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2020 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7U8JsZvgXHH3n8xgxoCLEbRbt6AY8Z+mxAelisJgRw8=;
        b=TeT4WtuDoSJlYSAQH2bV1YMeSx1E6X2BFU8rj0/8YyGh0bErT86/GtYKHAowuaOF6E
         i5sZLU99YAKqeQ4qr4Qp40qynq4yNSyzg1yH0BPltc5IY1ZLrkVQwxI8UTVm3ozseEdy
         5ZkeWdsxPMWs2cvuTkyXFRGoW6rRjLvtArEwKHjtaJEZrrRGsCnu7J5y946a97v7K8xc
         O8xhwzvcMs0lb/N+ymrisTzO4wstCoEc86JTj/YVRRwGUOkVXxACR80FW58sUvUxstgn
         J4rgoTKUsqwoXilNN1i9HA6gtgwsAfe+lhDNrffl8KLuAP0+jQXa9OkWVGhEGjbFqp8/
         6C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7U8JsZvgXHH3n8xgxoCLEbRbt6AY8Z+mxAelisJgRw8=;
        b=ulbIZD33T43Jw5Wyekzg2V7Nw+dOWhvaSXzw7bNXz/ai41omfFzUM7wR6EYQzjdb7o
         4DrXj2SUAHn87nt0/FVW8oC+gvpVwiv8ruudSFAFwLWkcBpf6/fpQE+mDhlDBLep5EBL
         LjrCnH0VebV7FJu8wz1uMdb7/53HdcFwhVTKS+L1nQ/JCVHqJdnWAaDVDd4uGQWHx7Wy
         K6KV1w6MM2OnIu9DqY24Rr0hna763coaALq6WlPWdHDBvCi/4i7tbT/vGRGWM9LPG9J5
         dA7EFWP5vLtbeiwWEq/+CKb2YIUIpFk+NUye+4VQuTX/69tOPzEL+9QLnwVKvQJoYRbR
         VJGg==
X-Gm-Message-State: AOAM531jH18e/ZYlIF8D82PowMLwTwBP0TwYC2LnErw+f1pLFgi/NCei
        8eXOpWQesKH4kNhNwDFqlD1DLQ==
X-Google-Smtp-Source: ABdhPJwDgYPEzL6yjkDXQkBKQCvfcAKX1idi2WJWmoKy4Y+Sz7jQrn0lIt5Ndq1K+62+h1vAQ0vstA==
X-Received: by 2002:a37:689:: with SMTP id 131mr4805114qkg.468.1594741554235;
        Tue, 14 Jul 2020 08:45:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:81a8])
        by smtp.gmail.com with ESMTPSA id r6sm23081172qtt.81.2020.07.14.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:45:53 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:45:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200714154504.GB215857@cmpxchg.org>
References: <cover.1594640214.git.chris@chrisdown.name>
 <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 13, 2020 at 12:42:35PM +0100, Chris Down wrote:
> In Facebook production, we've seen cases where cgroups have been put
> into allocator throttling even when they appear to have a lot of slack
> file caches which should be trivially reclaimable.
> 
> Looking more closely, the problem is that we only try a single cgroup
> reclaim walk for each return to usermode before calculating whether or
> not we should throttle. This single attempt doesn't produce enough
> pressure to shrink for cgroups with a rapidly growing amount of file
> caches prior to entering allocator throttling.
> 
> As an example, we see that threads in an affected cgroup are stuck in
> allocator throttling:
> 
>     # for i in $(cat cgroup.threads); do
>     >     grep over_high "/proc/$i/stack"
>     > done
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> 
> ...however, there is no I/O pressure reported by PSI, despite a lot of
> slack file pages:
> 
>     # cat memory.pressure
>     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
>     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
>     # cat io.pressure
>     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
>     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
>     # grep _file memory.stat
>     inactive_file 1370939392
>     active_file 661635072
> 
> This patch changes the behaviour to retry reclaim either until the
> current task goes below the 10ms grace period, or we are making no
> reclaim progress at all. In the latter case, we enter reclaim throttling
> as before.
> 
> To a user, there's no intuitive reason for the reclaim behaviour to
> differ from hitting memory.high as part of a new allocation, as opposed
> to hitting memory.high because someone lowered its value. As such this
> also brings an added benefit: it unifies the reclaim behaviour between
> the two.
> 
> There's precedent for this behaviour: we already do reclaim retries when
> writing to memory.{high,max}, in max reclaim, and in the page allocator
> itself.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
