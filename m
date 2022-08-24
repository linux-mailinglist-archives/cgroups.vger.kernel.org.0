Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CEC59F4A2
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiHXH71 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHXH71 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 03:59:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0D857ED;
        Wed, 24 Aug 2022 00:59:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1FC033C7A;
        Wed, 24 Aug 2022 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661327964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V++k96zrKA+x4VrYQcjFRU0h85hnHFbQNXixpGjkrsQ=;
        b=IqZinnwQdu40DfoRGPFhFDObyG6y9HuBHOxzDQz57qkA5Ptk+105F7+HjvDaP6nShBO1X8
        78rRkHWteb/XdLdQX3NVO23OP1069frkqE96ClKy5FpdehLuOfo3Bh6L/ioROo3k8bQ/iz
        9IWCjnsbujxefljz69XX4KKm/cME1x0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C43DC13AC0;
        Wed, 24 Aug 2022 07:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yI+aLVzaBWO2WQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 Aug 2022 07:59:24 +0000
Date:   Wed, 24 Aug 2022 09:59:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Message-ID: <YwXaXHRhy51xH4rk@dhcp22.suse.cz>
References: <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org>
 <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
 <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
 <YwRjyx6wFLk8WTDe@dhcp22.suse.cz>
 <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz>
 <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
 <CAJuCfpH+T9+eOVYDfOv9yNSfAvq=pJtMp4ZaoYaM7iMY9XkaUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH+T9+eOVYDfOv9yNSfAvq=pJtMp4ZaoYaM7iMY9XkaUw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 23-08-22 09:21:16, Suren Baghdasaryan wrote:
> On Tue, Aug 23, 2022 at 4:51 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 23-08-22 17:20:59, Zhaoyang Huang wrote:
> > > On Tue, Aug 23, 2022 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Tue 23-08-22 14:03:04, Zhaoyang Huang wrote:
> > > > > On Tue, Aug 23, 2022 at 1:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Tue 23-08-22 10:31:57, Zhaoyang Huang wrote:
> > > > [...]
> > > > > > > I would like to quote the comments from google side for more details
> > > > > > > which can also be observed from different vendors.
> > > > > > > "Also be advised that when you enable memcg v2 you will be using
> > > > > > > per-app memcg configuration which implies noticeable overhead because
> > > > > > > every app will have its own group. For example pagefault path will
> > > > > > > regress by about 15%. And obviously there will be some memory overhead
> > > > > > > as well. That's the reason we don't enable them in Android by
> > > > > > > default."
> > > > > >
> > > > > > This should be reported and investigated. Because per-application memcg
> > > > > > vs. memcg in general shouldn't make much of a difference from the
> > > > > > performance side. I can see a potential performance impact for no-memcg
> > > > > > vs. memcg case but even then 15% is quite a lot.
> > > > > Less efficiency on memory reclaim caused by multi-LRU should be one of
> > > > > the reason, which has been proved by comparing per-app memcg on/off.
> > > > > Besides, theoretically workingset could also broken as LRU is too
> > > > > short to compose workingset.
> > > >
> > > > Do you have any data to back these claims? Is this something that could
> > > > be handled on the configuration level? E.g. by applying low limit
> > > > protection to keep the workingset in the memory?
> > > I don't think so. IMO, workingset works when there are pages evicted
> > > from LRU and then refault which provide refault distance for pages.
> > > Applying memcg's protection will have all LRU out of evicted which
> > > make the mechanism fail.
> >
> > It is really hard to help you out without any actual data. The idea was
> > though to use the low limit protection to adaptively configure
> > respective memcgs to reduce refaults. You already have data about
> > refaults ready so increasing the limit for often refaulting memcgs would
> > reduce the trashing.
> 
> Sorry for joining late.
> A couple years ago I tested root-memcg vs per-app memcg configurations
> on an Android phone. Here is a snapshot from my findings:
> 
> Problem
> =======
> We see tangible increase in major faults and workingset refaults when
> transitioning from root-only memory cgroup to per-application cgroups
> on Android.
> 
> Test results
> ============
> Results while running memory-demanding workload:
> root memcg     per-app memcg     delta
> workingset_refault 1771228 3874281 +118.73%
> workingset_nodereclaim 4543 13928 +206.58%
> pgpgin 13319208 20618944 +54.81%
> pgpgout 1739552 3080664 +77.1%
> pgpgoutclean 2616571 4805755 +83.67%
> pswpin 359211 3918716 +990.92%
> pswpout 1082238 5697463 +426.45%
> pgfree 28978393 32531010 +12.26%
> pgactivate 2586562 8731113 +237.56%
> pgdeactivate 3811074 11670051 +206.21%
> pgfault 38692510 46096963 +19.14%
> pgmajfault 441288 4100020 +829.1%
> pgrefill 4590451 12768165 +178.15%
> 
> Results while running application cycle test (20 apps, 20 cycles):
> root memcg     per-app memcg     delta
> workingset_refault 10634691 11429223 +7.47%
> workingset_nodereclaim 37477 59033 +57.52%
> pgpgin 70662840 69569516 -1.55%
> pgpgout 2605968 2695596 +3.44%
> pgpgoutclean 13514955 14980610 +10.84%
> pswpin 1489851 3780868 +153.77%
> pswpout 4125547 8050819 +95.15%
> pgfree 99823083 105104637 +5.29%
> pgactivate 7685275 11647913 +51.56%
> pgdeactivate 14193660 21459784 +51.19%
> pgfault 89173166 100598528 +12.81%
> pgmajfault 1856172 4227190 +127.74%
> pgrefill 16643554 23203927 +39.42%

Thanks! It would be interesting to see per memcg stats as well. Are
there any outliers? Are there any signs of over-reclaim (more pages
scanned & reclaimed by both kswapd and direct reclaim?

> Tests were conducted on an Android phone with 4GB RAM.
> Similar regression was reported a couple years ago here:
> https://www.spinics.net/lists/linux-mm/msg121665.html
> 
> I plan on checking the difference again on newer kernels (likely 5.15)
> after LPC this September.

Thanks, that would be useful!

-- 
Michal Hocko
SUSE Labs
