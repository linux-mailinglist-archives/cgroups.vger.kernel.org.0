Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B5466668C
	for <lists+cgroups@lfdr.de>; Wed, 11 Jan 2023 23:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjAKW5A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 17:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjAKW45 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 17:56:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629EB62FC
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 14:56:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z11so24575976ede.1
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 14:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYVYmrm8qRKhdfjNxir61IMwTDz9ljMKT2wwPAIP+WQ=;
        b=Xhqr3JG2Kex0yJQiWOcc0PM+7tyhQNxjCcJ7T8wz62d+5YQPT9Rtd4nC10zyoXLoMT
         4/vmihyklfSrZDCiyctpeidBCrvuTcUZqgtWDQJyCNaXgm6+tkBSAvDANuhYpWOmJyom
         dC+q84M7rFuFBjEUHK9o1KYkMoO2Zcisjc0WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYVYmrm8qRKhdfjNxir61IMwTDz9ljMKT2wwPAIP+WQ=;
        b=JHL0tvfIZQbSB6q/YOsF1t/myjazM7jk27ApAUSpgCTcSyjd2gPuOnYkWs02zoumiF
         OSbjKWrsTxlvUri6bkc2bSvKCLduzauwJGdT2T4a8IMBvlXydu2FneKzUjr3hTLLOAEF
         Q3Z+qbLw6nXOo53iyVKbXkmdVJT1dMxHA/39p726gn4KbxdM/jSNsNIKAn8natmfvQEd
         trP23Ppbpk6pu0BW3MUvOPX57dyYySfM+TW5+7oeHnal99L4D3/k59ML+Kb6SUdB2ZHk
         sBuBbl9vmfDACoQEYsJZZEHI+HxNxzk62UiD7vkgk/FsBKSbYli9AhbWIBv6DNNLEcMo
         EC+Q==
X-Gm-Message-State: AFqh2kqlqRRsqyv0W3aTtQ3jcpsPkdfOp58tmPMAnWUl0inG/mHkmFMS
        zOKnTTL474U9+VHYJnBnlqTnsA==
X-Google-Smtp-Source: AMrXdXvtJyhkyJcdGojea7328ZHYfQqEgGWt5WiLp900ZLPEIaZSTCU8Uhtlcr1KkDcOMzby5I7CqA==
X-Received: by 2002:a05:6402:48c:b0:483:d49f:e26c with SMTP id k12-20020a056402048c00b00483d49fe26cmr54924068edv.15.1673477808940;
        Wed, 11 Jan 2023 14:56:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a3-20020aa7cf03000000b0049019b48373sm6549362edy.85.2023.01.11.14.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:56:48 -0800 (PST)
Date:   Wed, 11 Jan 2023 23:56:45 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH 0/4] Track exported dma-buffers with memcg
Message-ID: <Y78+rfzXPq5XGs9O@phenom.ffwll.local>
Mail-Followup-To: Shakeel Butt <shakeelb@google.com>,
        "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, android-mm@google.com,
        jstultz@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <20230109213809.418135-1-tjmercier@google.com>
 <CALvZod4ru7F38tAO-gM9ZFKaEhS0w3KqFbPwhwcTvgJs4xMUow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4ru7F38tAO-gM9ZFKaEhS0w3KqFbPwhwcTvgJs4xMUow@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 09, 2023 at 04:18:12PM -0800, Shakeel Butt wrote:
> Hi T.J.,
> 
> On Mon, Jan 9, 2023 at 1:38 PM T.J. Mercier <tjmercier@google.com> wrote:
> >
> > Based on discussions at LPC, this series adds a memory.stat counter for
> > exported dmabufs. This counter allows us to continue tracking
> > system-wide total exported buffer sizes which there is no longer any
> > way to get without DMABUF_SYSFS_STATS, and adds a new capability to
> > track per-cgroup exported buffer sizes. The total (root counter) is
> > helpful for accounting in-kernel dmabuf use (by comparing with the sum
> > of child nodes or with the sum of sizes of mapped buffers or FD
> > references in procfs) in addition to helping identify driver memory
> > leaks when in-kernel use continually increases over time. With
> > per-application cgroups, the per-cgroup counter allows us to quickly
> > see how much dma-buf memory an application has caused to be allocated.
> > This avoids the need to read through all of procfs which can be a
> > lengthy process, and causes the charge to "stick" to the allocating
> > process/cgroup as long as the buffer is alive, regardless of how the
> > buffer is shared (unless the charge is transferred).
> >
> > The first patch adds the counter to memcg. The next two patches allow
> > the charge for a buffer to be transferred across cgroups which is
> > necessary because of the way most dmabufs are allocated from a central
> > process on Android. The fourth patch adds a SELinux hook to binder in
> > order to control who is allowed to transfer buffer charges.
> >
> > [1] https://lore.kernel.org/all/20220617085702.4298-1-christian.koenig@amd.com/
> >
> 
> I am a bit confused by the term "charge" used in this patch series.
> From the patches, it seems like only a memcg stat is added and nothing
> is charged to the memcg.
> 
> This leads me to the question: Why add this stat in memcg if the
> underlying memory is not charged to the memcg and if we don't really
> want to limit the usage?
> 
> I see two ways forward:
> 
> 1. Instead of memcg, use bpf-rstat [1] infra to implement the
> per-cgroup stat for dmabuf. (You may need an additional hook for the
> stat transfer).
> 
> 2. Charge the actual memory to the memcg. Since the size of dmabuf is
> immutable across its lifetime, you will not need to do accounting at
> page level and instead use something similar to the network memory
> accounting interface/mechanism (or even more simple). However you
> would need to handle the reclaim, OOM and charge context and failure
> cases. However if you are not looking to limit the usage of dmabuf
> then this option is an overkill.

I think eventually, at least for other "account gpu stuff in cgroups" use
case we do want to actually charge the memory.

The problem is a bit that with gpu allocations reclaim is essentially "we
pass the error to userspace and they get to sort the mess out". There are
some exceptions (some gpu drivers to have shrinkers) would we need to make
sure these shrinkers are tied into the cgroup stuff before we could enable
charging for them?

Also note that at least from the gpu driver side this is all a huge
endeavour, so if we can split up the steps as much as possible (and get
something interim useable that doesn't break stuff ofc), that is
practically need to make headway here. TJ has been trying out various
approaches for quite some time now already :-/
-Daniel

> Please let me know if I misunderstood something.
> 
> [1] https://lore.kernel.org/all/20220824233117.1312810-1-haoluo@google.com/
> 
> thanks,
> Shakeel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
