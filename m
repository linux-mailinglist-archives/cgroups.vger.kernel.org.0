Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8C07B0C25
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjI0Srn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 14:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjI0Srm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 14:47:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDDDD
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 11:47:41 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65b07651b97so43700756d6.1
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695840460; x=1696445260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJDZTm7Z2nhowm3hyHG41iZ5XoprYwdk3aDSfrZG2wk=;
        b=obUzTvGIVWCyFyMgTEUduB3VTZ8WdRJ3ggskFwJc3VOfE7zXgr/tkqtAkOzPuG2S5A
         NCWm95XvN7OOrrNBU26j+i/axvk1uIVHjUurw71tbVDLS3RSO1a3/qZUbCHxxSK6Fr/S
         R2N4dS5OomhAKdD5Zk7UjPvfOKBwywN2aMq0O95EHh3m5nZ5TkkmBnETKqAo0DAcYsC5
         rBNedXFszLvwkC/1ZLsGlv7Pc80TDjnX0DZG0/gONKlu3fNF5ZMDcvjBuiHaAukySngr
         uoqM2K/qxSLqV3i05EYGfZUBnm7fGPv/CuZ0HDl2Amn5mZThkaHpkI+cjNNoac/2xjP9
         hGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695840460; x=1696445260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJDZTm7Z2nhowm3hyHG41iZ5XoprYwdk3aDSfrZG2wk=;
        b=U+4Ud+tMZD8yS3sf6EZQCtweQzQiO0fovhJ951uUADbkvNufb4s/Xt6JdwtOQ5YVLS
         6QlYCIAaT2MMM/FJPT8wfT/QhhS40851sOuhvfLuicBIMseLmM1OtaFfLvcBypS0Euwx
         RZ7jg+Ed5ewfdrTH3nBr6POPrCa6T7duF+O/XwGaOWgKhe4EdA+r3SCwSvRq+GsQ6cdU
         2tFFBHQTcXscwvfmXvnP9CH5mm3U1jxNr+8DDIHnB2kV7tbOaDkeNfIt6X0eEAIi0BmF
         PVynFPPA9fhX++0ZaAbwDtBolV4SwXCzsg9oWl55v0dXmBemma+Vb7SPIh+3fuFdN1wu
         24Ig==
X-Gm-Message-State: AOJu0YyPBmaL5+l5SdQ5vQgykCJ3Duq7O7to+C9nBYNyAs7bIkOAra3H
        HkjFYJkPhln8TaS+ZRyOcVUckA==
X-Google-Smtp-Source: AGHT+IFS0GAJTIKyRi/gn/s1TGAJLJql9VVJCPzoxk2ZZUAsBsGksmZLMXnDUJWb0On6ZCV9hgsN5Q==
X-Received: by 2002:a0c:8d4a:0:b0:65b:10db:cd59 with SMTP id s10-20020a0c8d4a000000b0065b10dbcd59mr2748931qvb.33.1695840460202;
        Wed, 27 Sep 2023 11:47:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id b19-20020a0ccd13000000b00646e0411e8csm2995137qvm.30.2023.09.27.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:47:39 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:47:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20230927184738.GC365513@cmpxchg.org>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 01:21:20PM +0200, Michal Hocko wrote:
> On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> > Currently, hugetlb memory usage is not acounted for in the memory
> > controller, which could lead to memory overprotection for cgroups with
> > hugetlb-backed memory. This has been observed in our production system.
> > 
> > This patch series rectifies this issue by charging the memcg when the
> > hugetlb folio is allocated, and uncharging when the folio is freed. In
> > addition, a new selftest is added to demonstrate and verify this new
> > behavior.
> 
> The primary reason why hugetlb is living outside of memcg (and the core
> MM as well) is that it doesn't really fit the whole scheme. In several
> aspects. First and the foremost it is an independently managed resource
> with its own pool management, use and lifetime.

Honestly, the simpler explanation is that few people have used hugetlb
in regular, containerized non-HPC workloads.

Hugetlb has historically been much more special, and it retains a
specialness that warrants e.g. the hugetlb cgroup container. But it
has also made strides with hugetlb_cma, migratability, madvise support
etc. that allows much more on-demand use. It's no longer the case that
you just put a static pool of memory aside during boot and only a few
blessed applications are using it.

For example, we're using hugetlb_cma very broadly with generic
containers. The CMA region is fully usable by movable non-huge stuff
until huge pages are allocated in it. With the hugetlb controller you
can define a maximum number of hugetlb pages that can be used per
container. But what if that container isn't using any? Why shouldn't
it be allowed to use its overall memory allowance for anon and cache
instead?

With hugetlb being more dynamic, it becomes the same problem that we
had with dedicated tcp and kmem pools. It didn't make sense to fail a
random slab allocation when you still have memory headroom or can
reclaim some cache. Nowadays, the same problem applies to hugetlb.

> There is no notion of memory reclaim and this makes a huge difference
> for the pool that might consume considerable amount of memory. While
> this is the case for many kernel allocations as well they usually do not
> consume considerable portions of the accounted memory. This makes it
> really tricky to handle limit enforcement gracefully.

I don't think that's true. For some workloads, network buffers can
absolutely dominate. And they work just fine with cgroup limits. It
isn't a problem that they aren't reclaimable themselves, it's just
important that they put pressure on stuff that is.

So that if you use 80% hugetlb, the other memory is forced to stay in
the remaining 20%, or it OOMs; and that if you don't use hugetlb, the
group is still allowed to use the full 100% of its host memory
allowance, without requiring some outside agent continuously
monitoring and adjusting the container limits.

> Another important aspect comes from the lifetime semantics when a proper
> reservations accounting and managing needs to handle mmap time rather
> than than usual allocation path. While pages are allocated they do not
> belong to anybody and only later at the #PF time (or read for the fs
> backed mapping) the ownership is established. That makes it really hard
> to manage memory as whole under the memcg anyway as a large part of
> that pool sits without an ownership yet it cannot be used for any other
> purpose.
>
> These and more reasons where behind the earlier decision o have a
> dedicated hugetlb controller.

Yeah, there is still a need for an actual hugetlb controller for the
static use cases (and even for dynamic access to hugetlb_cma).

But you need memcg coverage as well for the more dynamic cases to work
as expected. And having that doesn't really interfere with the static
usecases.

> Also I will also Nack involving hugetlb pages being accounted by
> default. This would break any setups which mix normal and hugetlb memory
> with memcg limits applied.

Yes, no disagreement there. I think we're all on the same page this
needs to be opt-in, say with a cgroup mount option.
