Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5265F2DC
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 18:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjAERgQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 12:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjAERgE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 12:36:04 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C3BC87;
        Thu,  5 Jan 2023 09:36:02 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p24so17532234plw.11;
        Thu, 05 Jan 2023 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkjsNq+41nhz5t6YNHufJptj0TXGHPydjE1ADy7+6FM=;
        b=F7AETA8YmQngoALJiwWtbL0ff8RtVbY4EEr53C6FVlL+DjvgCS7aideTdCWmxjFESd
         SeiRq631vXOAX++cF5PyZgvg1K66m5yYZ1/kNZWXsC6IwAeKeSZd5dJI25JEOakb5hTn
         koOxsxdTnhPtdbZa50u70QRWGBbgPhkudNr+UVeZO49V+rJahQKqkZ1pZR+sqjplBze3
         q35Wqugk6MwBc7S+ubvDZFqhYjXGVsB/XPQOU15imjrES3mE+4jS6D5EO6hub0FHZxAT
         +zCaPPlxhFluLFItLj3F5QdevNoFUcoaXuo+CM0bND1qvelEblmhqLuD8fraDS1YHsIn
         MT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkjsNq+41nhz5t6YNHufJptj0TXGHPydjE1ADy7+6FM=;
        b=p5e2ZMMoptC1P2yTbIajKKg4yBAKQL0trXTiN8O3nAcR3IttqcE7EBNDrBqJG8pRSC
         MzUzQUSdwWa+E9J2tZE9DhPMOrn0r20wq6vWSIcbrizoN0A5HTDJVSkQls07Q/jdj690
         a046HU1Ce4w5NS7j712wX1DZBgplC8yXXPjxkwCmUmvTDK1fPRL0UkVC2PbSjiLP1N63
         ExSaEbzLX+MoTZEfooswVkVl6ofiq8q1mtGOAbCFK4NMju34vnEDO88lDmjg7qdz+Uac
         nzRnGs0jF1TgwVWuLRPVXJAhYU24FFw66mFT9F8FL+UD/SAGPzdXNnGGqvw9lZeK8zND
         iRAw==
X-Gm-Message-State: AFqh2kqdDKJP09Xqx9r7rpuWoLvsByQA+9t1/fJl1DP/SYaCrbsFPjOc
        jya8L+A5m9bprZyxzbpZrlwL/mCI7Fs=
X-Google-Smtp-Source: AMrXdXsYDWP5shGMiAXXVQkIfz7JzRr2YwOxVFcN+ZqNqk6WEmOWE6UE2GTNjP8E23+8A9XtfuGZfQ==
X-Received: by 2002:a17:90a:f309:b0:219:9e19:8259 with SMTP id ca9-20020a17090af30900b002199e198259mr55174897pjb.46.1672940161933;
        Thu, 05 Jan 2023 09:36:01 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id mz4-20020a17090b378400b0020aacde1964sm1623674pjb.32.2023.01.05.09.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:36:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 07:35:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jinke Han <hanjinke.666@bytedance.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jack@suse.cz
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <Y7cKf7IH+FJ/6IyV@slm.duckdns.org>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105161854.GA1259@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jan 05, 2023 at 05:18:54PM +0100, Michal Koutný wrote:
> I guess similar problem would arise for devices that are "naturally"
> slow.
> Then:
> a) it must have been solved elsewhere in the block layer (but it's
>    broken),
> b) it should be solved generically in the block layer (thus this is only
>    a partial solution).

Hard limits tend to make this sort of problems a lot more pronounced because
the existing mechanisms tend to break down for the users which are severely
throttled down even while the device as a whole is fairly idle. cpu.max
often triggers severe priority inversions too, so it isn't too surprising
that people hit severe priority inversion issues w/ io.max.

Another problem with blk-throttle is that it doesn't prioritize shared IOs
identified by bio_issue_as_root_blkg() like iolatency and iocost do, so
there can be very severe priority inversions when e.g. journal commit gets
trapped in a low priority cgroup further exacerbating issues like this.

Thanks.

-- 
tejun
