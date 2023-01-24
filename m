Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53E67A1F4
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjAXS41 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 13:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjAXS4W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 13:56:22 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F28311164
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 10:55:58 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4c24993965eso231595487b3.12
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iP8zaH4qhJm7u23Me24MfP0ksC5myih/koifVjd6bQ=;
        b=L97ftDdvRyPqQWji9bbudEKZD0LDLmKOVOT0VCiZU2LCV4qkff4lF/IdPTXrUURWIL
         ff9SdNebMBFiJK7tO0W11Q1G3UAXgTPUqwqhK5wAl6n35fMRrabPmvj7OKd4VEXabKNe
         fPfG1+wRSo+CGN8gb1ygCJ4/kEeW/hVXaBUNrg4mvfNQT/BKe7VDh8MR1pAOAXvVpeRH
         iSMTwWB8dLyPnn97HzVO9MptWE6TkOpSAkEtIzxtQqNOTsOqkk7JQsVXrGtclwnaZu3B
         HwIb13tYMPFn1tPWBxylMI8CnFv9i3PBeFrmGSlZCW+l6NJP5u3gl1vi0n9snU8rYOV/
         xPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iP8zaH4qhJm7u23Me24MfP0ksC5myih/koifVjd6bQ=;
        b=Qrf+nLZEVdlHY0zaDJDiWYmLM29ASF7jqUSi/dCyJlhFYZMENE7XzMk1MCVW4kob+8
         XfAZaH1uUKKr7QIeTZWjQZPrUdEnuYMclC0IGzAm8FCSQ3vgUEUFbLfQu/oahol+0BHR
         JkPNj8blapbO/yrPvhrTqUte6lkgt9SfYeRlb7xf/GaUNKe6vli8oDQ6MF+M9dqBCFeu
         k/gsljZH484tcch42WuWXqrNRgTgHDNG/4x+dzRjzbp6jYW5lRhXCKwuiLtPmD5NrOYr
         z/l/U+Et0/uVFjllwZKay135iNOELC3s4dQzIz4TFJkmf2seOo3MLIgu8qtyWntf7ov7
         8jhw==
X-Gm-Message-State: AFqh2koOTQLTgO5ognzJ7FXpOTw3fYuScs3JdptFokJBDo21SDmVJD+a
        bikev5SgCMo+erY0ljcpnXQ1fSVws6Ah5VdfBlBGJg==
X-Google-Smtp-Source: AMrXdXvYfqSwoaAvj+x6Y8rOABSC1o3UELoBjL8mxdEcOy8itZdY1Gyy4qtRJtS0OI19YGFM9lWbjo9sqQUT8b8rESs=
X-Received: by 2002:a81:ee03:0:b0:4ec:8f55:59f7 with SMTP id
 l3-20020a81ee03000000b004ec8f5559f7mr3333976ywm.317.1674586532265; Tue, 24
 Jan 2023 10:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
 <20230123191728.2928839-2-tjmercier@google.com> <Y8/ybgp2FW+e3bjc@dhcp22.suse.cz>
In-Reply-To: <Y8/ybgp2FW+e3bjc@dhcp22.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 24 Jan 2023 10:55:21 -0800
Message-ID: <CABdmKX1c_8LdJJboENnZhwGjrszDWOOVt-Do93-sJW46mZMD6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] memcg: Track exported dma-buffers
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        jeffv@google.com, cmllamas@google.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org
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

On Tue, Jan 24, 2023 at 7:00 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 23-01-23 19:17:23, T.J. Mercier wrote:
> > When a buffer is exported to userspace, use memcg to attribute the
> > buffer to the allocating cgroup until all buffer references are
> > released.
>
> Is there any reason why this memory cannot be charged during the
> allocation (__GFP_ACCOUNT used)?

My main motivation was to keep code changes away from exporters and
implement the accounting in one common spot for all of them. This is a
bit of a carryover from a previous approach [1] where there was some
objection to pushing off this work onto exporters and forcing them to
adapt, but __GFP_ACCOUNT does seem like a smaller burden than before
at least initially. However in order to support charge transfer
between cgroups with __GFP_ACCOUNT we'd need to be able to get at the
pages backing dmabuf objects, and the exporters are the ones with that
access. Meaning I think we'd have to add some additional dma_buf_ops
to achieve that, which was the objection from [1].

[1] https://lore.kernel.org/lkml/5cc27a05-8131-ce9b-dea1-5c75e994216d@amd.com/

>
> Also you do charge and account the memory but underlying pages do not
> know about their memcg (this is normally done with commit_charge for
> user mapped pages). This would become a problem if the memory is
> migrated for example.

Hmm, what problem do you see in this situation? If the backing pages
are to be migrated that requires the cooperation of the exporter,
which currently has no influence on how the cgroup charging is done
and that seems fine. (Unless you mean migrating the charge across
cgroups? In which case that's the next patch.)

> This also means that you have to maintain memcg
> reference outside of the memcg proper which is not really nice either.
> This mimicks tcp kmem limit implementation which I really have to say I
> am not a great fan of and this pattern shouldn't be coppied.
>
Ah, what can I say. This way looked simple to me. I think otherwise
we're back to making all exporters do more stuff for the accounting.

> Also you are not really saying anything about the oom behavior. With
> this implementation the kernel will try to reclaim the memory and even
> trigger the memcg oom killer if the request size is <= 8 pages. Is this
> a desirable behavior?

It will try to reclaim some memory, but not the dmabuf pages right?
Not *yet* anyway. This behavior sounds expected to me. I would only
expect it to be surprising for cgroups making heavy use of dmabufs
(that weren't accounted before) *and* with hard limits already very
close to actual usage. I remember Johannes mentioning that what counts
under memcg use is already a bit of a moving target.

> --
> Michal Hocko
> SUSE Labs
