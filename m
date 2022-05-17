Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433D552AC75
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiEQUGw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiEQUGu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 16:06:50 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86092B196
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 13:06:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 126so9682qkm.4
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qcMWVmYSlURTnutvjvuEW7rjU+P4VkwffWxfR8GtrEA=;
        b=LGie6wwZcbo09Ckj8tP/4otrxCtis9dRmDTD9qDyh3biKQ98yrbjUcuchEk8INxwFG
         8b6Tn3W3SJdpgx9i1SgzxcRmFafKytH/WTHsSwLOQmHs27J9KXp/vBkzHb+uWTjBTirT
         EfJwMOHmhj2dsvVunuSViW+twEuUEC4JB5mBUW7T2eYx67PHgrJSz6aiA6vhBE6UHGzg
         tlC5FC/eTVTfo08giVbYDiwZXDE1VXYaZQGAPwdMBEylGSzsA/Wn9+7J3TNiEYaBSS6c
         KjQPd3YJ6BgpCJHNxOlY4gU61In53Pwdr5Mmx2p8GZI4M/sIRwDpUmISWg6pgPneN/vu
         JnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcMWVmYSlURTnutvjvuEW7rjU+P4VkwffWxfR8GtrEA=;
        b=DeXhxMhMI5gEUXO9wpSka/DA+TOdwhS6C2N/6J4WGEmQlSbtTyTKSu7MP/a1bEFp+W
         GNpOhqXp9kAO5aF4TAvA2p4SioTtxsmcLZT/8jTilKKP1ub8YCX1Js/lP/sZud8VIFNn
         2RX/Aax+i4DejxDypylzSadgOt+4OP7kHiOU9B6z/ATey8TezWWEGXT7iakhKbe0NQnr
         /YT6oJviuB7p/1/neyXIoRUWXUsuwzZcS5GA0Z6p0+1Yc/N8QEcv35+0K7Jgzc2cEnpc
         NfSwbwGEhVDjUnMqnSB2XWeR/t4FiEp0+ipyhI/wW2BUS1R6Ax3yY1Vxg4Jcbx9bKAxX
         feTQ==
X-Gm-Message-State: AOAM533kQ6wuhemfl3amZTJcyFrg3M8ldlmTy6PJjBhtexIfjJ53mxsM
        FWiBvyHJqGlAv3THQFeDycPh2g==
X-Google-Smtp-Source: ABdhPJwqXDU+oSzLWJRpekyrFZ2G0BAHMUxLQFXsIT+bEr3FfHaKXjWjnSc6Jcevm0gZUP4cK84MdQ==
X-Received: by 2002:a05:620a:2909:b0:6a0:472b:a30d with SMTP id m9-20020a05620a290900b006a0472ba30dmr17493803qkp.258.1652818007815;
        Tue, 17 May 2022 13:06:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b35b])
        by smtp.gmail.com with ESMTPSA id a85-20020ae9e858000000b0069fc13ce254sm38138qkg.133.2022.05.17.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:06:47 -0700 (PDT)
Date:   Tue, 17 May 2022 16:06:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
Message-ID: <YoQAVeGj19YpSMDb@cmpxchg.org>
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz>
 <CAJD7tkYnBjuwQDzdeo6irHY=so-E8z=Kc_kZe52anMOmRL+8yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYnBjuwQDzdeo6irHY=so-E8z=Kc_kZe52anMOmRL+8yA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yosry,

On Tue, May 17, 2022 at 11:06:36AM -0700, Yosry Ahmed wrote:
> On Mon, May 16, 2022 at 11:56 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 16-05-22 15:29:42, Yosry Ahmed wrote:
> > > The discussions on the patch series [1] to add memory.reclaim has
> > > shown that it is desirable to add an argument to control the type of
> > > memory being reclaimed by invoked proactive reclaim using
> > > memory.reclaim.
> > >
> > > I am proposing adding a swappiness optional argument to the interface.
> > > If set, it overwrites vm.swappiness and per-memcg swappiness. This
> > > provides a way to enforce user policy on a stateless per-reclaim
> > > basis. We can make policy decisions to perform reclaim differently for
> > > tasks of different app classes based on their individual QoS needs. It
> > > also helps for use cases when particularly page cache is high and we
> > > want to mainly hit that without swapping out.
> >
> > Can you be more specific about the usecase please? Also how do you
> 
> For example for a class of applications it may be known that
> reclaiming one type of pages anon/file is more profitable or will
> incur an overhead, based on userspace knowledge of the nature of the
> app.

I want to make sure I understand what you're trying to correct for
with this bias. Could you expand some on what you mean by profitable?

The way the kernel thinks today is that importance of any given page
is its access frequency times the cost of paging it. swappiness exists
to recognize differences in the second part: the cost involved in
swapping a page vs the cost of a file cache miss.

For example, page A is accessed 10 times more frequently than B, but B
is 10 times more expensive to refault/swapin. Combining that, they
should be roughly equal reclaim candidates.

This is the same with the seek parameter of slab shrinkers: some
objects are more expensive to recreate than others. Once corrected for
that, presence of reference bits can be interpreted on an even level.

While access frequency is clearly a workload property, the cost of
refaulting is conventionally not - let alone a per-reclaim property!

If I understand you correctly, you're saying that the backing type of
a piece of memory can say something about the importance of the data
within. Something that goes beyond the work of recreating it.

Is that true or am I misreading this?

If that's your claim, isn't that, if it happens, mostly incidental?

For example, in our fleet we used to copy executable text into
anonymous memory to get THP backing. With file THP support in the
kernel, the text is back in cache. The importance of the memory
*contents* stayed the same. The backing storage changed, but beyond
that the anon/file distinction doesn't mean anything.

Another example. Probably one of the most common workload structures
is text, heap, logging/startup/error handling: hot file, warm anon,
cold file. How does prioritizing either file or anon apply to this?

Maybe I'm misunderstanding and this IS about per-workload backing
types? Maybe the per-cgroup swapfiles that you guys are using?

> If most of what an app use for example is anon/tmpfs then it might
> be better to explicitly ask the kernel to reclaim anon, and to avoid
> reclaiming file pages in order not to hurt the file cache
> performance.

Hm.

Reclaim ages those pools based on their size, so a dominant anon set
should receive more pressure than a small file set. I can see two
options why this doesn't produce the desired results:

1) Reclaim is broken and doesn't allocate scan rates right, or

2) Access frequency x refault cost alone is not a satisfactory
   predictor for the value of any given page.

Can you see another?

I can sort of see the argument for 2), because it can be workload
dependent: a 50ms refault in a single-threaded part of the program is
likely more disruptive than the same refault in an asynchronous worker
thread. This is a factor we're not really taking into account today.

But I don't think an anon/file bias will capture this coefficient?
