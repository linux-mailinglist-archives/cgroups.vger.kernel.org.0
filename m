Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF251B3797
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDVGhk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgDVGhj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:37:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF3C03C1A6;
        Tue, 21 Apr 2020 23:37:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so504935pju.2;
        Tue, 21 Apr 2020 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M3V1L8dUG+LHRmYCPUTMgmjn7UaZHh+VkReKQj/vaHo=;
        b=VLLZvjTyPjUgrOmfVUzEK98z+a3DuIJzk8YklsxG4duu/ZaQG/OxRt8VGQQoJk5rSq
         w7PDHAUR5t3p6G6E5k1yyL2g/BJnmWDAzsogEl/KU5MclGkgNEPL4u+ymQ9CzV86Qwsy
         0DVS6CS9PA+EgKfrysJ1Pol0cTsJA5+L+3fv7IzvAL6fh+PoJ5JNVu+S5fnmoOHeQWDX
         TAZTS4f/IqI97thaP3pnigLg89b/Gvu1vz/7gT1qkKSgpX1SMizwilKhgqrKOYye0583
         aM9l8fc9I5Wdv0p0yXEAD0AxRoj9ohgIbIzLiNGTYouJqv4OA1f8sX7e9qzwcHgN+PWS
         17bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M3V1L8dUG+LHRmYCPUTMgmjn7UaZHh+VkReKQj/vaHo=;
        b=I2GPHhwX/P8+eNBjwwMTqKWSeIM4cJeB+f6MlPIE6vpqvilpSxCoC5/6ai8ibnAS3/
         zjiRPmTpEw+m741+MLxGCL3DAWUIhVv0kpKwvNCHw+8sAsqph/atR6IXGuLveQmNffWm
         S3aRIcrNICTKmGMMU0L4PaHAxvTPBCKzK2T97R6CqcGJIgteJZ7vn6C50w5BbXlyMlzv
         D4CzFIkH+Kr5aa5u/u5qYnp25WFmmItOfFNohYJOTwExG+t4j1Cl1QyUYpO1hmtgCOFY
         ES2IupRbEUkT71kpJzeFDq0Lc+iItZATkRFcFuQMP+z66BNshWNZhVF0QmsXU7PBUc3w
         aagA==
X-Gm-Message-State: AGi0Pua+HPA5MerrDPP6fzCCPIll4OuVqwXwd8VNivz/QNGJnZZnOdvm
        /9MozTYXyv46DULCHls90d8=
X-Google-Smtp-Source: APiQypJPHB6y2FOy7ihkfqvwyGsoDRZ9hscuVvE02808VtIGkZYuLBvWbO5B9VdXZnS6hGVW6chmBA==
X-Received: by 2002:a17:902:d693:: with SMTP id v19mr26122013ply.9.1587537459292;
        Tue, 21 Apr 2020 23:37:39 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n17sm4387026pff.81.2020.04.21.23.37.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:37:38 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:37:33 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 04/18] mm: memcontrol: move out cgroup swaprate throttling
Message-ID: <20200422063732.GD6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-5-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-5-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:12PM -0400, Johannes Weiner wrote:
> The cgroup swaprate throttling is about matching new anon allocations
> to the rate of available IO when that is being throttled. It's the io
> controller hooking into the VM, rather than a memory controller thing.
> 
> Rename mem_cgroup_throttle_swaprate() to cgroup_throttle_swaprate(),
> and drop the @memcg argument which is only used to check whether the
> preceding page charge has succeeded and the fault is proceeding.
> 
> We could decouple the call from mem_cgroup_try_charge() here as well,
> but that would cause unnecessary churn: the following patches convert
> all callsites to a new charge API and we'll decouple as we go along.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

