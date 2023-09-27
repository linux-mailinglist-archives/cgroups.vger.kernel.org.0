Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312077B0F93
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 01:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjI0XeP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 19:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0XeO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 19:34:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4E6F4;
        Wed, 27 Sep 2023 16:34:13 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3513dcd38ebso23185875ab.1;
        Wed, 27 Sep 2023 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695857652; x=1696462452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuiLzV6CGoqkNcJvWLJWVbKjSzC7FqUZFKmUnpswKQ8=;
        b=C3268e7bN9aOEMO7H0jXdQF/P1NjjXjeZmbw4E76oKkwDl3SC5GhIG9mcaAfwx9uBT
         nucMpVJNPBPqjeQlLTlcx0dz7w/WQ0IPu30uwa7diCpK2t805rzWUDIMGB6YBmU0mL0Q
         0UQWCuhRdOY69IgQiWFfhP0llOC97H38KsTpDdU4Wovyih58YmrrpCDnSvRaHWiJT2/f
         irGze5IsJpIka+E70FvScswcB3RvXtEG4qk6Diy7wBtiwvZj1T/mB5CkrXAZnQHiP/Qs
         MF5kTY1N7Ewprhz8FLNvf3xd/TWpYB48GZXav9F7MccRe/FPYtVmeqUPBesAFxvwn1Ez
         XIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695857652; x=1696462452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuiLzV6CGoqkNcJvWLJWVbKjSzC7FqUZFKmUnpswKQ8=;
        b=PTlrYh9WhEs9ZqvJuRij93+mW8syWiE+ROATDkTGsxfgqFG4G55Pyt+YRWPLjtH4vF
         DkBDAfN6XFIe+aNG8GOtGLndSPNKxqy2czlf3FVyyz8UTNGbyi8FrQP6z5H9XO8WvT4V
         uAIfnwzotDkhUNvD0CnqYy0snz6IHSEBrK5lK1qkYGr5vgxDIVdWeqDKeaCbRRzLmw1/
         TrSQW/sGbErx3FFLcH1dUnRsIm4F0lsgZx03V8Ljbdf3qoL8QNxP7FE8FPmrUSGpeXzP
         /QIfMa4kf99tPBp6qy6u9hSBvIxAH3JgqI5DqfU1T0nsou2fjKCqBZ+z8YHtC4Bs+8/U
         MZMw==
X-Gm-Message-State: AOJu0YyHZAWL4PnxufqDsN3brGdzDABNbH+AnT7eVNGHZhj7c7X8iiIR
        FkwUKWMwELdqy7R4EGU6lw3OD4lpbfvVU0blIwk=
X-Google-Smtp-Source: AGHT+IH240jOGmryB4DKmJdrSZ0sw76v69veXHjvxbIKdhdqV6ViGFilCGJvjsPnRuNvxUyXjajBAwH8Z5Q4GyT1Ep0=
X-Received: by 2002:a05:6e02:1a29:b0:351:a18:51be with SMTP id
 g9-20020a056e021a2900b003510a1851bemr4644664ile.15.1695857652609; Wed, 27 Sep
 2023 16:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194949.2637078-1-nphamcs@gmail.com> <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
In-Reply-To: <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 27 Sep 2023 16:33:59 -0700
Message-ID: <CAKEwX=MVcHSHRTzHMo7W6PCiWkTNdR8zp0c4UxR4xKDZCVbPQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 4:21=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
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
>
> There is no notion of memory reclaim and this makes a huge difference
> for the pool that might consume considerable amount of memory. While
> this is the case for many kernel allocations as well they usually do not
> consume considerable portions of the accounted memory. This makes it
> really tricky to handle limit enforcement gracefully.
>
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

While I believe all of these are true, I think they are not reasons not to
have memcg accounting. As everyone has pointed out, memcg
accounting by itself cannot handle all situations - it is not a fix-all.
Other mechanisms, such as the HugeTLB controller, could be the better
solution in these cases, and hugetlb memcg accounting is definitely not
an attempt to infringe upon these control domains.

However, memcg accounting is still necessary for certain memory limits
enforcement to work cleanly and properly - such as the use cases we have
(as Johannes has beautifully described). It will certainly help
administrators simplify their control workflow a lot (assuming we do not
surprise them with this change - a new mount option to opt-in should
help with the transition).

>
> Also I will also Nack involving hugetlb pages being accounted by
> default. This would break any setups which mix normal and hugetlb memory
> with memcg limits applied.

Got it! I'll introduce some opt-in mechanisms in the next version. This is
my oversight.


> --
> Michal Hocko
> SUSE Labs
