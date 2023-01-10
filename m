Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1228066361C
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 01:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjAJAS2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 19:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbjAJAS0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 19:18:26 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB52DE4
        for <cgroups@vger.kernel.org>; Mon,  9 Jan 2023 16:18:24 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4c15c4fc8ccso135051957b3.4
        for <cgroups@vger.kernel.org>; Mon, 09 Jan 2023 16:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sgQCt0va7Fj5/9fGcldqaAxXWYK8cBxGZmP9xyPfdn4=;
        b=CjxZ1mdpIhqu8VGPVCMoqsbsDlIhqCjEmsPqq5qkb1qszkge1Jm7eoOuPAcP/ZV3bk
         wPP+sf8id+ynxeTBPKOWQaibXFQF9VkirxIevCIzpGAQ21ueiyMyljdoDpqBwv6iADhp
         JWDpspg8gxuUz/g8o8f3Q/TpOZXD4wUkStfMnP3bNMTdaoT8E8PrN4XpF0W1y5T9lIyj
         m9H9otSUCpmNvNlNujrmOWTRlgks+Pwp+EXc1GX8tr1KUVIqmZXacuPH98ZfnNVZNFn8
         /a3FCftCVuu8stwkCKaAOtd2Rf8qgv7JUkOT3SOOPfRdmX4H3QpcqFd3fI60DVZdrWVr
         exyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgQCt0va7Fj5/9fGcldqaAxXWYK8cBxGZmP9xyPfdn4=;
        b=SZH5ooOVnMefXM5cOCAMss5m8ItXUU1IBzFp2YwYA1Tgb7Zu+8/AlwXXx//W2SMqhU
         oT2JK9AXJTxe6paCjgKUazXXPot1QsctDEulZIYP0AFBl5kzloxNK4regCEKsiDjn8C/
         9LVYfvzbXWgIO/R0aRVHOHqNnHipubxGVT3MYwKwQyNgZ79xUfMInduELQjbvKu0x2eo
         btUo0iyirXIThZoDcuEUK27UGr62F5+d4JCgAX02IuoNIUqbwCY6121DCh88e404ktA+
         SIuyL4gLcj2UxSQr1TzJLRhkv83AwmdOrugk47HhU3De983qybSnkXqzAu1iVuJFdTH9
         ugIA==
X-Gm-Message-State: AFqh2koJTxvGTk3UIJbuXHSkHe0eAxGkb/2wCWDRzhKYYnEWZl2EGtkI
        Jy3k437mPO9PZnl94Pbrbz1C6bSAcTdRlO0IuEVPnw==
X-Google-Smtp-Source: AMrXdXvykUOk6Aq29zKPFweeZ5QLOqVr0VtGabuLWKsdUabDXPvAWtUyFW1w97fkSV+2AQTk/rtQ4CJ6GNWf2U6U44A=
X-Received: by 2002:a81:7386:0:b0:391:c415:f872 with SMTP id
 o128-20020a817386000000b00391c415f872mr1094430ywc.318.1673309903890; Mon, 09
 Jan 2023 16:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com>
In-Reply-To: <20230109213809.418135-1-tjmercier@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 9 Jan 2023 16:18:12 -0800
Message-ID: <CALvZod4ru7F38tAO-gM9ZFKaEhS0w3KqFbPwhwcTvgJs4xMUow@mail.gmail.com>
Subject: Re: [PATCH 0/4] Track exported dma-buffers with memcg
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, daniel.vetter@ffwll.ch,
        android-mm@google.com, jstultz@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi T.J.,

On Mon, Jan 9, 2023 at 1:38 PM T.J. Mercier <tjmercier@google.com> wrote:
>
> Based on discussions at LPC, this series adds a memory.stat counter for
> exported dmabufs. This counter allows us to continue tracking
> system-wide total exported buffer sizes which there is no longer any
> way to get without DMABUF_SYSFS_STATS, and adds a new capability to
> track per-cgroup exported buffer sizes. The total (root counter) is
> helpful for accounting in-kernel dmabuf use (by comparing with the sum
> of child nodes or with the sum of sizes of mapped buffers or FD
> references in procfs) in addition to helping identify driver memory
> leaks when in-kernel use continually increases over time. With
> per-application cgroups, the per-cgroup counter allows us to quickly
> see how much dma-buf memory an application has caused to be allocated.
> This avoids the need to read through all of procfs which can be a
> lengthy process, and causes the charge to "stick" to the allocating
> process/cgroup as long as the buffer is alive, regardless of how the
> buffer is shared (unless the charge is transferred).
>
> The first patch adds the counter to memcg. The next two patches allow
> the charge for a buffer to be transferred across cgroups which is
> necessary because of the way most dmabufs are allocated from a central
> process on Android. The fourth patch adds a SELinux hook to binder in
> order to control who is allowed to transfer buffer charges.
>
> [1] https://lore.kernel.org/all/20220617085702.4298-1-christian.koenig@amd.com/
>

I am a bit confused by the term "charge" used in this patch series.
From the patches, it seems like only a memcg stat is added and nothing
is charged to the memcg.

This leads me to the question: Why add this stat in memcg if the
underlying memory is not charged to the memcg and if we don't really
want to limit the usage?

I see two ways forward:

1. Instead of memcg, use bpf-rstat [1] infra to implement the
per-cgroup stat for dmabuf. (You may need an additional hook for the
stat transfer).

2. Charge the actual memory to the memcg. Since the size of dmabuf is
immutable across its lifetime, you will not need to do accounting at
page level and instead use something similar to the network memory
accounting interface/mechanism (or even more simple). However you
would need to handle the reclaim, OOM and charge context and failure
cases. However if you are not looking to limit the usage of dmabuf
then this option is an overkill.

Please let me know if I misunderstood something.

[1] https://lore.kernel.org/all/20220824233117.1312810-1-haoluo@google.com/

thanks,
Shakeel
