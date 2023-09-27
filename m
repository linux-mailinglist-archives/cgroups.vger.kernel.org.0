Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7997B0A88
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjI0Qoe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0Qod (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 12:44:33 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D192
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 09:44:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4181251f83fso41577881cf.0
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695833071; x=1696437871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKbDRjvApMpYPGbWz9dHVkdjA8N/B9idfwIaFL32H1A=;
        b=PLpfPktJshumcXOWHyoTo6M0aFeAwzlVkr5SuKiV0KghhAg26VkKAK+zFLS7X1A6bE
         pGrwsWVcX8zKx5fKEcfONutJt/gl4yHNsFgr2uWCvCWpP7msv+NxOpFk2lY7TCg8SB4z
         j8yERiDn+imz7Y4xc4i+q7l3wGXYiHCGpa9Cvdqtg4J2SUJNPwzYhVEQ8ses7Ft15WCz
         TSrLWou+eqfDqkUjeTX6/4vMkE6X1mxGv5sFOCyw2CGTsqk17aWJiiJEXZ4MWnsd53KH
         5oWFv8rU2J+VB4TsA9QBQReh6q5Gdllrfa99djY0uZybZu5PXGm81Nlyq9OvaruMbyUk
         P6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833071; x=1696437871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKbDRjvApMpYPGbWz9dHVkdjA8N/B9idfwIaFL32H1A=;
        b=j0/wLA4t85o2AxRmhaeeFdv3upz+0v4KZzv83uMiYkE+NOaBXK0FDVTaSQGm7fq5PJ
         bVF8UtFrJRdgOXF4odQlcRxF3ERbD6T2NRRSUgWs5n0FVNRGlc7W/MV4E/duCJ1oScGg
         iDK9QfahNs4NtBKiQHzO8z0it2sZTWOcr8M09PReD8uEef/0GPZgvPWHHZOdW5PB3RXD
         pUZaueVwTxd5ODrc6eYGr5y2KN0s0HYFs2bollSBCuP2Q2VJzaqkoq72OpDbMA3dlwdV
         NkrYVyANH2+gWTqUm60vfmWn9bi23hN0mrdSX4Cs6wGifEwlpJgXCZ0HG58LIcilGfJG
         V0zA==
X-Gm-Message-State: AOJu0YyZwGm6GHZBx63hhR3lvzcLXcmwSEbSF8yoCeI/wWEqbugsV08H
        9C378PC0ueNC8TUIo567OvYVrQ==
X-Google-Smtp-Source: AGHT+IFOHIz2rG+1dO7b6kU+thPNTv0XP5gZ8Xowyl8cMwksCfd/KzkFVs+MMn71Ytt40M5tC7xwcQ==
X-Received: by 2002:a05:622a:15c4:b0:40f:cf7c:5e7c with SMTP id d4-20020a05622a15c400b0040fcf7c5e7cmr2914810qty.24.1695833071521;
        Wed, 27 Sep 2023 09:44:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id h11-20020a37c44b000000b00767b0c35c15sm5604683qkm.91.2023.09.27.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:44:31 -0700 (PDT)
Date:   Wed, 27 Sep 2023 12:44:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Frank van der Linden <fvdl@google.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20230927164430.GB365513@cmpxchg.org>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
 <20230926221414.GD348484@cmpxchg.org>
 <ZRQlAgDs5W/Lct4k@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQlAgDs5W/Lct4k@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 02:50:10PM +0200, Michal Hocko wrote:
> On Tue 26-09-23 18:14:14, Johannes Weiner wrote:
> [...]
> > The fact that memory consumed by hugetlb is currently not considered
> > inside memcg (host memory accounting and control) is inconsistent. It
> > has been quite confusing to our service owners and complicating things
> > for our containers team.
> 
> I do understand how that is confusing and inconsistent as well. Hugetlb
> is bringing throughout its existence I am afraid.
> 
> As noted in other reply though I am not sure hugeltb pool can be
> reasonably incorporated with a sane semantic. Neither of the regular
> allocation nor the hugetlb reservation/actual use can fallback to the
> pool of the other. This makes them 2 different things each hitting their
> own failure cases that require a dedicated handling.
> 
> Just from top of my head these are cases I do not see easy way out from:
> 	- hugetlb charge failure has two failure modes - pool empty
> 	  or memcg limit reached. The former is not recoverable and
> 	  should fail without any further intervention the latter might
> 	  benefit from reclaiming.
> 	- !hugetlb memory charge failure cannot consider any hugetlb
> 	  pages - they are implicit memory.min protection so it is
>           impossible to manage reclaim protection without having a
>           knowledge of the hugetlb use.
> 	- there is no way to control the hugetlb pool distribution by
> 	  memcg limits. How do we distinguish reservations from actual
> 	  use?
> 	- pre-allocated pool is consuming memory without any actual
> 	  owner until it is actually used and even that has two stages
> 	  (reserved and really used). This makes it really hard to
> 	  manage memory as whole when there is a considerable amount of
> 	  hugetlb memore preallocated.

It's important to distinguish hugetlb access policy from memory use
policy. This patch isn't about hugetlb access, it's about general
memory use.

Hugetlb access policy is a separate domain with separate
answers. Preallocating is a privileged operation, for access control
there is the hugetlb cgroup controller etc.

What's missing is that once you get past the access restrictions and
legitimately get your hands on huge pages, that memory use gets
reflected in memory.current and exerts pressure on *other* memory
inside the group, such as anon or optimistic cache allocations.

Note that hugetlb *can* be allocated on demand. It's unexpected that
when an application optimistically allocates a couple of 2M hugetlb
pages those aren't reflected in its memory.current. The same is true
for hugetlb_cma. If the gigantic pages aren't currently allocated to a
cgroup, that CMA memory can be used for movable memory elsewhere.

The points you and Frank raise are reasons and scenarios where
additional hugetlb access control is necessary - preallocation,
limited availability of 1G pages etc. But they're not reasons against
charging faulted in hugetlb to the memcg *as well*.

My point is we need both. One to manage competition over hugetlb,
because it has unique limitations. The other to manage competition
over host memory which hugetlb is a part of.

Here is a usecase from our fleet.

Imagine a configuration with two 32G containers. The machine is booted
with hugetlb_cma=6G, and each container may or may not use up to 3
gigantic page, depending on the workload within it. The rest is anon,
cache, slab, etc. You set the hugetlb cgroup limit of each cgroup to
3G to enforce hugetlb fairness. But how do you configure memory.max to
keep *overall* consumption, including anon, cache, slab etc. fair?

If used hugetlb is charged, you can just set memory.max=32G regardless
of the workload inside.

Without it, you'd have to constantly poll hugetlb usage and readjust
memory.max!
