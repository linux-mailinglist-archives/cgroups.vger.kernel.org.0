Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1D565F5EB
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 22:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjAEVje (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 16:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjAEVjd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 16:39:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E51676C6;
        Thu,  5 Jan 2023 13:39:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso3434960pjf.1;
        Thu, 05 Jan 2023 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2B/6xg54aJ7idENEindVKE0XwrAKLTxScGdP8EUbfT4=;
        b=ZkNdyUzEpnyBd0OlCkttYyZAG/3I+W6QG3eMejUnJp8CrNHDsyjvOt9clDf0vayE2i
         r6lkarY5scvvcjm/rCs+97/cb8gqnaQAyMmK3VSY0WyGE8IlHrmP+m2hv6sg2w9Hc7Fj
         oYJ+KVy30yL4L97vccgDToFnVKpG2sQ9Ip0kAUHayWMzIMzCVKcCkw/30gSAWKVx/ibj
         VQPPP3O/BeKowqjHlsVjOEGUI1eb+l6qP37gQQoSu+PFjSgNwn7pF8Nk2hVOW4m+375W
         JFPztt3e6nOUrCAXynvNsPVdzbNfSJw4YG57GZ8mO8YbvQ343sLQ7vMFYumsPmD5GZfz
         ZXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2B/6xg54aJ7idENEindVKE0XwrAKLTxScGdP8EUbfT4=;
        b=EZNx0srpG5vSZRg1JsK8/gd6qHWOvnz15IYzZkcsPSHqKf+EAvLATZoWz6o1qTPna9
         0l52ybsN18UfzdHA5srBUEOLhfo6M4uvJM9fbMZzsXWXUqx3pihpHDD+x5y9MTm14mbK
         QmhYLLvlXMIh1hHmvtg777rYHL9pLAPJDeR4OlXIDyrBNrR7JiIE4UZkKkEMmrw4Sgza
         CXUmVFi+fEKVvbIx3PFo4YrHvfVOOv9/lt9qNF9eZmivf/7tb5Tga2zbNhnrQB6S2hxN
         rlu+q6nW9HXyE6zwUTnSV9CMT+Bywcsja6O6+kFuD3Ey2LyWWvBbgOFQJ42UXY/PucOF
         HI8Q==
X-Gm-Message-State: AFqh2krCGTZcNef4OH+FhoD9GAOAm80ifwwlTbdEXc+Qn5QlQRExTc8L
        40hVddHlckCQZJPM1Jn7nzwVZmPIY+M=
X-Google-Smtp-Source: AMrXdXvOKSzzM60MzcrxrGTOI1KuEb5c6Cr23VJevx4+hCvku1p09/yos5Tpv8O6ZF7fXbWnpFdzgw==
X-Received: by 2002:a05:6a21:999d:b0:9e:9685:f15e with SMTP id ve29-20020a056a21999d00b0009e9685f15emr81430335pzb.0.1672954769421;
        Thu, 05 Jan 2023 13:39:29 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 128-20020a630086000000b004a099a12937sm9627542pga.84.2023.01.05.13.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:39:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 11:39:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jinke Han <hanjinke.666@bytedance.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jack@suse.cz
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <Y7dDjyT1Gl5Mt3fl@slm.duckdns.org>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <Y7cKf7IH+FJ/6IyV@slm.duckdns.org>
 <20230105192247.GB16920@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105192247.GB16920@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Michal.

On Thu, Jan 05, 2023 at 08:22:47PM +0100, Michal Koutný wrote:
> On Thu, Jan 05, 2023 at 07:35:59AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > Hard limits tend to make this sort of problems a lot more pronounced because
> > the existing mechanisms tend to break down for the users which are severely
> > throttled down even while the device as a whole is fairly idle. cpu.max
> > often triggers severe priority inversions too, so it isn't too surprising
> > that people hit severe priority inversion issues w/ io.max.
> 
> To be on the same page:
> 1) severe PI == priority inversion across cgroups (progated e.g. via
>    global locks (as with cpu.max) or FS journal (as with io.max)),

Another important inversion vector is memory reclaim as writeback operations
get trapped in blk-throttle and the system can pile on waiting for clean
pages.

> 2) ordinary PI == priority inversion contained within a single cgroup,
>    i.e. no different from an under-provisioned system.

I didn't use the term in a precise manner but yeah both can be problematic.
The former a lot more so.

> The reported issue sounds like 2) but even with the separated queues 1)
> is still possible :-/

Yeah, definitely.

> > Another problem with blk-throttle is that it doesn't prioritize shared IOs
> > identified by bio_issue_as_root_blkg() like iolatency and iocost do, so
> > there can be very severe priority inversions when e.g. journal commit gets
> > trapped in a low priority cgroup further exacerbating issues like this.
> 
> Thanks for the broader view. So the separated queues are certainly an
> improvement but ultimately a mechanism based on bio_issue_as_root_blkg()
> predicate and deferred throttling would be better? Or is permanent limit
> enforcement more important?

Generally true but the specific scenario raised by Jinke is rather unusual
and isn't covered by issue_as_root mechanism as it doesn't promote REQ_SYNC
data writes. Then again, this usually isn't a problem as in most cases dirty
throttling through writeback should stave off severe starvations.

blk-throttle is pretty outdated and kinda broken and separating out sync
writes isn't gonna solve most of its problems. However, it will help in some
cases like the one described by Jinke and can sometimes lessen wider scope
inversions too. Given the partial nature, I don't feel too enthusiastic but
at the same time can't find good reasons to reject either. I don't know. I
don't feel too strong either way.

On a tangential note, I've been thinking about implementing io.max on top of
iocost so that each cgroup can just configure the max % of total device IO
capacity that's allowed for it, which should be a lot easier to use and has
many of the problems already solved.

Thanks.

-- 
tejun
