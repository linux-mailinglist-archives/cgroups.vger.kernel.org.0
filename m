Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC0662C58
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 18:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjAIRMW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 12:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjAIRMC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 12:12:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFB03AB24;
        Mon,  9 Jan 2023 09:10:25 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b17so2704313pld.7;
        Mon, 09 Jan 2023 09:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2F7MnQjWUM2mz3fa62EsZ0QXZ22HhpfAIEPFOeLt3g=;
        b=NUhh4xIZ+AOJcgsbU0xvlzbsJbVG+9T3Se2OyuTTwY9bT6lLSXeiL/gqBhuZRqP3gk
         DcSVyYGX4HnFUgLJH2s4TxhsSe2evRnc6dYpBgAWjfnWyvzIJcdOSYmZYjTh0z6n7dS5
         IDPQdCNb6odXMeAbi0edwjLaLnBRrvUSSKuDZ8KHQkTzhPmCuXO4iqDYkoDJ9gECFfyX
         ElnMf/H5FC3HCww5Zd8pZUVzLTH19cA5dXo+zTlZkxrTTwZs4Kn/yWlUz0OTbjIEi4Vd
         Oizt0ucUcD7hftQewLu/5aC2S9piZMYt0TUDDcyv3Ix1xigSYrBMFxSXTWg8QSXqjtFa
         zSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2F7MnQjWUM2mz3fa62EsZ0QXZ22HhpfAIEPFOeLt3g=;
        b=ZeVqhYvALKllCSOmdT6L50lZb/3pa0FK68YQMIUhk/ULtL0lVxYNCOBhv1tlC4puVw
         l6171FKPbKNUE0iY2APo13B9bHQxhba6az+leaIBMVG0pj1MrPENrnLp3XbRBuCS3mvc
         XfblZpSDMxXws4YDS51TDvvqAA+QqQ/xoWpruFGWdsWLEKMAYl1ZZ29SFt9M0VlPW86o
         YvdGH0cHeNHe5oNv/CG18R4jkXtsqkXi7ETaFVDaoIoCtSnYNYflo7vc0xK+xLEslb00
         phy1zTLSzayEsNtM173dAcbnLja5SF8iXLvBVLRMdfIoaNKtXIs0d/XbJ+aTxwjXu3jG
         NgOA==
X-Gm-Message-State: AFqh2koB5UPlP9eYagRQyed8KaXfzhqODp8/fZgKatts/ukKHUtebufN
        f3zkFcDoHUC+4ifhZOaUaZA=
X-Google-Smtp-Source: AMrXdXuP4f5mFQ4/HE2YXlElOb2g+3Jrsg8Ro+CRnWQAfTXMHh/IP6Qvmy+W0FVCFR/ArXdFHluUTg==
X-Received: by 2002:a17:90a:ead2:b0:226:f8dc:b237 with SMTP id ev18-20020a17090aead200b00226f8dcb237mr7360327pjb.31.1673284224688;
        Mon, 09 Jan 2023 09:10:24 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k15-20020a17090a3ccf00b002195819d541sm7612899pjd.8.2023.01.09.09.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:10:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Jan 2023 07:10:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jinke Han <hanjinke.666@bytedance.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <Y7xKfl7gGt+wb/I2@slm.duckdns.org>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3>
 <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <20230109105916.jvnhjdseqkwejmws@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109105916.jvnhjdseqkwejmws@quack3>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Jan.

On Mon, Jan 09, 2023 at 11:59:16AM +0100, Jan Kara wrote:
> Yeah, I agree there's no way back :). But actually I think a lot of the
> functionality of IO schedulers is not needed (by you ;)) only because the
> HW got performant enough and so some issues became less visible. And that
> is all fine but if you end up in a configuration where your cgroup's IO
> limits and IO demands are similar to how the old rotational disks were
> underprovisioned for the amount of IO needed to be done by the system
> (i.e., you can easily generate amount of IO that then takes minutes or tens
> of minutes for your IO subsystem to crunch through), you hit all the same
> problems IO schedulers were trying to solve again. And maybe these days we
> incline more towards the answer "buy more appropriate HW / buy higher
> limits from your infrastructure provider" but it is not like the original
> issues in such configurations disappeared.

Yeah, but I think there's a better way out as there's still a difference
between the two situations. W/ hard disks, you're actually out of bandwidth.
With SSDs, we know that there are capacity that we can borrow to get out of
the tough spot. e.g. w/ iocost, you can constrain a cgroup to a point where
its throughput gets to a simliar level of hard disks; however, that still
doesn't (or at least shouldn't) cause noticeable priority inversions outside
of that cgroup because issue_as_root promotes the IOs which can be waited
upon by other cgroups to root charging the cost to the cgroup as debts and
further slowing it down afterwards.

There's a lot to be improved - e.g. the debt accounting and payback, and
propagation to originator throttling isn't very accurate leading to usually
over-throttling and under-utilization in some cases. The coupling between IO
control and dirty throttling is there and kinda works but it seems like it's
pretty easy to make it misbehave under heavy control and so on. But, even
with all those shortcomings, at least iocost is feature complete and already
works (not perfectly but still) in most cases - it can actually distribute
IO bandwidth across the cgroups with arbitrary weights without causing
noticeable priority inversions across cgroups.

blk-throttle unfortunately doesn't have issue_as_root and the issuer delay
mechanism hooked up and we found that it's near impossible to configure
properly in any scalable manner. Raw bw and iops limits just can't capture
application behavior variances well enough. Often, the valid parameter space
becomes null when trying to cover varied behaviors. Given the problem is
pretty fundamental for the control scheme, I largely gave up on it with the
long term goal of implementing io.max on top of iocost down the line.

> > Another layering problem w/ controlling from elevators is that that's after
> > request allocation and the issuer has already moved on. We used to have
> > per-cgroup rq pools but ripped that out, so it's pretty easy to cause severe
> > priority inversions by depleting the shared request pool, and the fact that
> > throttling takes place after the issuing task returned from issue path makes
> > propagating the throttling operation upwards more challenging too.
> 
> Well, we do have .limit_depth IO scheduler callback these days so BFQ uses
> that to solve the problem of exhaustion of shared request pool but I agree
> it's a bit of a hack on the side.

Ah didn't know about that. Yeah, that'd help the situation to some degree.

> > My bet is that inversion issues are a lot more severe with blk-throttle
> > because it's not work-conserving and not doing things like issue-as-root or
> > other measures to alleviate issues which can arise from inversions.
> 
> Yes, I agree these features of blk-throttle make the problems much more
> likely to happen in practice.

As I wrote above, I largely gave up on blk-throttle and things like tweaking
sync write priority doesn't address most of its problems (e.g. it's still
gonna be super easy to stall the whole system with a heavily throttled
cgroup). However, it can still be useful for some use cases and if it can be
tweaked to become a bit better, I don't see a reason to not do that.

Thanks.

-- 
tejun
