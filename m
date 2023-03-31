Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD86D1537
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 03:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCaBpS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 21:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCaBpQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 21:45:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8318835;
        Thu, 30 Mar 2023 18:44:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x15so19004402pjk.2;
        Thu, 30 Mar 2023 18:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680227093; x=1682819093;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CS9Le6nsC17jU584Wp0Pdq9lmWcMPhHg9k+f1qFG9Ls=;
        b=jliIbNZkvX0tLViuNo+i79Ttgxeb9fED2/7a/M//MeXVK85etYsThHW7fGC1feC4vZ
         Go+yEPuxYOcaF5VBV6Ke0tTmio5hHs8DCIabQRCHVjtKLke5fe30pR1/67w3ny6t7cSe
         u5NPsdvN0XRvl04Wkq4Lma/qrhChh42F/OMxsGqMzgLezbHZJCHUBiU2Ku2KyqSTMMS4
         pnrGO76PL/yll+KWOG03l2uV3VYf8UD2PiWykpevBE6UMc/CV3anaSXdGkeAc4P7GG5M
         8D6jVFrnzJzuOXa/B3czUIVd0rUcMg/cUlELD955vSSCykHv6Nix3W7/9YD4sqGoodz3
         bZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680227093; x=1682819093;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS9Le6nsC17jU584Wp0Pdq9lmWcMPhHg9k+f1qFG9Ls=;
        b=DMuDl9Cjy/7fm+++Vw0HK1KMa5rD3nawaqSj2Nur8ER+5IG6dUuLIyL9YLytaPcrU5
         gscmjFpTeMfeuEVF/rOlPKIBmTqmkrUDFN2DfAiExShto4Auv0wRuW3c92CCKC9JTdr1
         STXeyf4TVzaAPy9WF4981H5mq7xQgCBodZ4J+pDcaf2ErcOAk0zoADE9ev0IejQN0kPF
         GzAgxR5B7KCGO2MrE8NqTpWijZ5zk/4Cem3DOmmSkBDf+YaPOeWniRFVltjtLWixM64l
         FdCwgDLG7e2m2aqfcWPtgcLAGRyBHIeyxCg0tVvdLUNWr+2uoE/CsOyOVOgjc/2a16R0
         tOhg==
X-Gm-Message-State: AAQBX9dW+Aa9hjFrqYVBrrdkuYGrUc3Bh7cXzOuzVcP9YgRw+bT8dQw9
        fFOplNp2C2uvWViCdmq5OeU=
X-Google-Smtp-Source: AKy350YSYOai8p1r07lV00Ep+Qm6Uvd1T8iRDgNw4I6PrADkxBBQ1h577al+Y2G+i2z8U+uuf9eZFQ==
X-Received: by 2002:a17:90a:19d8:b0:23f:ae99:3c94 with SMTP id 24-20020a17090a19d800b0023fae993c94mr7912795pjj.23.1680227092715;
        Thu, 30 Mar 2023 18:44:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001a053b7e892sm327541plk.195.2023.03.30.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 18:44:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 30 Mar 2023 15:44:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] blk-throttle: Fix io statistics for
 cgroup v1
Message-ID: <ZCY7EoAUqfB0ac8S@slm.duckdns.org>
References: <20230328142309.73413-1-hanjinke.666@bytedance.com>
 <ZCSJaBO8i5jQFC10@slm.duckdns.org>
 <1a858cce-4d87-5e0a-9274-52cffde7dea6@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a858cce-4d87-5e0a-9274-52cffde7dea6@bytedance.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Mar 30, 2023 at 11:44:04AM +0800, hanjinke wrote:
> 在 2023/3/30 上午2:54, Tejun Heo 写道:
> > On Tue, Mar 28, 2023 at 10:23:09PM +0800, Jinke Han wrote:
> > > From: Jinke Han <hanjinke.666@bytedance.com>
> > > 
> > > Now the io statistics of cgroup v1 are no longer accurate. Although
> > > in the long run it's best that rstat is a good implementation of
> > > cgroup v1 io statistics. But before that, we'd better fix this issue.
> > 
> > Can you please expand on how the stats are wrong on v1 and how the patch
> > fixes it?
> > 
> > Thanks.
> > 
> Now blkio.throttle.io_serviced and blkio.throttle.io_serviced become the

"now" might be a bit too vague. Can you point to the commit which made the
change?

> only stable io stats interface of cgroup v1, and these statistics are done
> in the blk-throttle code. But the current code only counts the bios that are

Ah, okay, so the stats are now updated by blk-throtl itself but

> actually throttled. When the user does not add the throttle limit, the io
> stats for cgroup v1 has nothing. I fix it according to the statistical
> method of v2, and made it count all ios accurately.

updated only when limits are configured which can be confusing. Makes sense
to me. Can you please update the patch description accordingly?

Also, the following change:

@@ -2033,6 +2033,9 @@ void blk_cgroup_bio_start(struct bio *bio)
        struct blkg_iostat_set *bis;
        unsigned long flags;

+       if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
+               return;
+
        /* Root-level stats are sourced from system-wide IO stats */
        if (!cgroup_parent(blkcg->css.cgroup))
                return;

seems incomplete as there's an additional
cgroup_subsys_on_dfl(io_cgrp_subsys) test in the function. We probably wanna
remove that?

Thanks.

-- 
tejun
