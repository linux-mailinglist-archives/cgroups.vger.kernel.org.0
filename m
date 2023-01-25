Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79267BBDF
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 21:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjAYUEr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 15:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjAYUEq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 15:04:46 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127E4614F
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 12:04:44 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id b1so19231567ybn.11
        for <cgroups@vger.kernel.org>; Wed, 25 Jan 2023 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MtZUdD+8O7hxMGTcR1DMvNk+cmrcvsJPjaaxCUIim34=;
        b=fOjBWO27z2DRRtGxPdgxFPgp37eKG2B9PVK/K0KiaXIloz+AuZ38tULN6fcXWxzCXe
         tU2hdkFiNRDubvDFYYKIraSWMsmgZB5TrENA6ESEOPBjPR/dQpPpkMJl5TsP7oaNQBaU
         TxPNiWcr87ZC110sXUh6RSZVcOchas4NTyfHWTxoFZ1DzEOO9gAxP0Yd2EzEp0fULRzI
         KH11tad7CESbeI0SS36cVhoreBuXewlt8xttyfZyHJv8HTgUAkB8genFUrpEvMtBNPp0
         +Cp+2h8ohoZFxIl3/0g98E+3IWq3CPHCxOoXQqQtkHA1Zm+a4/B25A6qnkeflqA4pUuK
         /J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtZUdD+8O7hxMGTcR1DMvNk+cmrcvsJPjaaxCUIim34=;
        b=AfqCH+Yai/tbiuC5h3Zh2r/hanGQFKKsuxu1KapkxEQfVjF6kpyeoNM89D0G0bxVDM
         1IGcH2Yc/mE2urzg1l/F8jZxcsEqgj2DHIah04hjRryUr/e+bevNcvzUhEhLyNIp1Jcq
         3pnwrYr7/ZhN32eFUo2EhhEKsDoMr6byAH+Akw0GoFRqPKtjZhj/X/4hermkH4UXT/Cp
         PJ8edK7lEqubtOE9nYtC1Tao88VQvfwa/7Yp9PHKa3FLG8Mc8oDP9AvsqycvuXEmpcaJ
         N+cbNdP0y5Ileped2fm1gUeR2xE9Sn8euW2Q+Dab/Yk04/moERZDrbOKAA9v7izBwUOH
         xv/w==
X-Gm-Message-State: AO0yUKVpKja5M/NKGSDbFgeD5XWBhClciGInaO7f/GY8Xd1EkL1FeM7G
        PGRvtEHGrsaa7igRpR0FBvKmSGN6R7DIOvSxyN3qog==
X-Google-Smtp-Source: AK7set/0yo0srPljd82kRg54UhHAn9kAcoGNmLhg0Ao5vhrkKbvYpqMk0gx/CzAceT8L+J/HB1ohTrPmB4dI55xwr6c=
X-Received: by 2002:a25:341:0:b0:80b:96cc:310d with SMTP id
 62-20020a250341000000b0080b96cc310dmr522771ybd.117.1674677083118; Wed, 25 Jan
 2023 12:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
 <20230123191728.2928839-2-tjmercier@google.com> <Y8/ybgp2FW+e3bjc@dhcp22.suse.cz>
 <CABdmKX1c_8LdJJboENnZhwGjrszDWOOVt-Do93-sJW46mZMD6A@mail.gmail.com> <Y9EbHW84ydBzpTTO@dhcp22.suse.cz>
In-Reply-To: <Y9EbHW84ydBzpTTO@dhcp22.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 25 Jan 2023 12:04:32 -0800
Message-ID: <CABdmKX0TEf_18UC0_pt1BumB9vDdJW2Ntv5bo0wh_CMOEcAEdA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 25, 2023 at 4:05 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 24-01-23 10:55:21, T.J. Mercier wrote:
> > On Tue, Jan 24, 2023 at 7:00 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 23-01-23 19:17:23, T.J. Mercier wrote:
> > > > When a buffer is exported to userspace, use memcg to attribute the
> > > > buffer to the allocating cgroup until all buffer references are
> > > > released.
> > >
> > > Is there any reason why this memory cannot be charged during the
> > > allocation (__GFP_ACCOUNT used)?
> >
> > My main motivation was to keep code changes away from exporters and
> > implement the accounting in one common spot for all of them. This is a
> > bit of a carryover from a previous approach [1] where there was some
> > objection to pushing off this work onto exporters and forcing them to
> > adapt, but __GFP_ACCOUNT does seem like a smaller burden than before
> > at least initially. However in order to support charge transfer
> > between cgroups with __GFP_ACCOUNT we'd need to be able to get at the
> > pages backing dmabuf objects, and the exporters are the ones with that
> > access. Meaning I think we'd have to add some additional dma_buf_ops
> > to achieve that, which was the objection from [1].
> >
> > [1] https://lore.kernel.org/lkml/5cc27a05-8131-ce9b-dea1-5c75e994216d@amd.com/
> >
> > >
> > > Also you do charge and account the memory but underlying pages do not
> > > know about their memcg (this is normally done with commit_charge for
> > > user mapped pages). This would become a problem if the memory is
> > > migrated for example.
> >
> > Hmm, what problem do you see in this situation? If the backing pages
> > are to be migrated that requires the cooperation of the exporter,
> > which currently has no influence on how the cgroup charging is done
> > and that seems fine. (Unless you mean migrating the charge across
> > cgroups? In which case that's the next patch.)
>
> My main concern was that page migration could lose the external tracking
> without some additional steps on the dmabuf front.
>
I see, yes that would be true if an exporter moves data around between
system memory and VRAM for example. (I think TTM does this sort of
thing, but not sure if that's actually within a single dma buffer.)
VRAM feels like it maybe doesn't belong in memcg, yet it would still
be charged there under this series right now. I don't really see a way
around this except to involve the exporters directly in the accounting
(or don't attempt to distinguish between types of memory).

> > > This also means that you have to maintain memcg
> > > reference outside of the memcg proper which is not really nice either.
> > > This mimicks tcp kmem limit implementation which I really have to say I
> > > am not a great fan of and this pattern shouldn't be coppied.
> > >
> > Ah, what can I say. This way looked simple to me. I think otherwise
> > we're back to making all exporters do more stuff for the accounting.
> >
> > > Also you are not really saying anything about the oom behavior. With
> > > this implementation the kernel will try to reclaim the memory and even
> > > trigger the memcg oom killer if the request size is <= 8 pages. Is this
> > > a desirable behavior?
> >
> > It will try to reclaim some memory, but not the dmabuf pages right?
> > Not *yet* anyway. This behavior sounds expected to me.
>
> Yes, we have discussed that shrinkers will follow up later which is
> fine. The question is how much reclaim actually makes sense at this
> stage. Charging interface usually copes with sizes resulting from
> allocation requests (so usually 1<<order based). I can imagine that a
> batch charge like implemented here could easily be 100s of MBs and it is
> much harder to define reclaim targets for. At least that is something
> the memcg charging hasn't really considered yet.  Maybe the existing
> try_charge implementation can cope with that just fine but it would be
> really great to have the expected behavior described.
>
> E.g. should be memcg OOM killer be invoked? Should reclaim really target
> regular memory at all costs or just a lightweight memory reclaim is
> preferred (is the dmabuf charge failure an expensive operation wrt.
> memory refault due to reclaim).

Ah, in my experience very large individual buffers like that are rare.
Cumulative system-wide usage might reach 100s of megs or more spread
across many buffers. On my phone the majority of buffer sizes are 4
pages or less, but there are a few that reach into the tens of megs.
But now I see your point. I still think that where a memcg limit is
exceeded and we can't reclaim enough as a result of a new dmabuf
allocation, we should see a memcg OOM kill. Sounds like you are
looking for that to be written down, so I'll try to find a place for
that.

Part of the motivation for this accounting is to eventually have a
well defined limit for applications to know how much more they can
allocate. So where buffer size or number of buffers is a flexible
variable, I'd like to see an application checking this limit before
making a large request in an effort to avoid reclaim in the first
place. Where there is heavy memory pressure and multiple competing
apps, the status-quo today is a kill for us anyways (typically LMKD).




> --
> Michal Hocko
> SUSE Labs
