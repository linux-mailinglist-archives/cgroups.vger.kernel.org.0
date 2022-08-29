Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7635B5A41AF
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 06:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiH2EDf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 00:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiH2EDf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 00:03:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27D41D3B;
        Sun, 28 Aug 2022 21:03:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 72so6996998pfx.9;
        Sun, 28 Aug 2022 21:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=/d1aCoj8mwhQkz6vc1Xqxkc26Va3irgGJEolPmhseeg=;
        b=eA3WGcD66qm9XgvBqd9G9EtOdEfoYHifkvzr4Rv9RR9TaTlWa5iguQ358dJld+6CcS
         18d0rsmtgfs4GP2zSuvA+rVmVW0Yq5HNgRSZho/bL8WhgCID7zj2hiqsmGLDCbXnmXdK
         aGLk7xpU1S2zhVK23R1hovWs7brS5QzSQf1zLiGNwJdxifjiQ8NB4OCDHSwXiMmXS9iH
         jHZRPs7mgvLec4UwVTQCXj1sxyE6uEAQs1xxmmJMryXrGTKLw1vPeXpnB5XVlufPPWe0
         sHjVq82/FUQSPhwxVPoHce4G7XkmUeKg7BDuh7RA3bGNut9hTvDT3lzkbwIdvM/7mrIM
         T66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=/d1aCoj8mwhQkz6vc1Xqxkc26Va3irgGJEolPmhseeg=;
        b=xAwbYrV61X1uVIBZplptpudSRmSkTG3KsWjHMpQcd6B2a2ndczj+wYBVwqeW9i4lYV
         W0pgMv3Qh8QdHkxumtOxksH+HV+2fVzrwAy0/pIaAY7UIa3jMbhD8T8w+/A9eS3ioFvP
         uRK1sBhdN1z2Q9Ki97D4erWsmukvx2YcBPL7lKuEpG2F1taI1AtOSLtB22br6oM79DCH
         ntPHVXYSsTExYdxFpQ3fCjiPbKIM6JPUdPt19vT4Y61y9gsCb5bMcIvJhb6rJgV9ArDJ
         bHoVMIDg8Fj8UxG7phBZfooEEVLRf6TU2JfnVsJy1DXBl4tpbhhBNu19o5et5xN7sX9/
         SgLQ==
X-Gm-Message-State: ACgBeo212Eep1P1EeDWURy9CLFNmm+OEuIL1UgXwFcY9MJd9lxgr0EM/
        cCStf7TU1OnCbx1XQ1FAktg=
X-Google-Smtp-Source: AA6agR48/BdpEtyPznQaYdZaC5K7yfxYs+GsD7XuYijpwa6LlkPYYt7llOKdJuiyrlng0Qk5Ay7MpQ==
X-Received: by 2002:a63:8248:0:b0:42b:b607:f74f with SMTP id w69-20020a638248000000b0042bb607f74fmr6474993pgd.70.1661745813821;
        Sun, 28 Aug 2022 21:03:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b00538405dfe4asm965263pfk.111.2022.08.28.21.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 21:03:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 28 Aug 2022 18:03:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, mkoutny@suse.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v9 1/4] blk-throttle: fix that io throttle can only work
 for single bio
Message-ID: <Yww6lPQaz/Lk4lL6@slm.duckdns.org>
References: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
 <20220829022240.3348319-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829022240.3348319-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 29, 2022 at 10:22:37AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Test scripts:
> cd /sys/fs/cgroup/blkio/
> echo "8:0 1024" > blkio.throttle.write_bps_device
> echo $$ > cgroup.procs
> dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
> dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
> 
> Test result:
> 10240 bytes (10 kB, 10 KiB) copied, 10.0134 s, 1.0 kB/s
> 10240 bytes (10 kB, 10 KiB) copied, 10.0135 s, 1.0 kB/s
> 
> The problem is that the second bio is finished after 10s instead of 20s.
> 
> Root cause:
> 1) second bio will be flagged:
> 
> __blk_throtl_bio
>  while (true) {
>   ...
>   if (sq->nr_queued[rw]) -> some bio is throttled already
>    break
>  };
>  bio_set_flag(bio, BIO_THROTTLED); -> flag the bio
> 
> 2) flagged bio will be dispatched without waiting:
> 
> throtl_dispatch_tg
>  tg_may_dispatch
>   tg_with_in_bps_limit
>    if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED))
>     *wait = 0; -> wait time is zero
>     return true;
> 
> commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> support to count split bios for iops limit, thus it adds flagged bio
> checking in tg_with_in_bps_limit() so that split bios will only count
> once for bps limit, however, it introduce a new problem that io throttle
> won't work if multiple bios are throttled.
> 
> In order to fix the problem, handle iops/bps limit in different ways:
> 
> 1) for iops limit, there is no flag to record if the bio is throttled,
>    and iops is always applied.
> 2) for bps limit, original bio will be flagged with BIO_BPS_THROTTLED,
>    and io throttle will ignore bio with the flag.
> 
> Noted this patch also remove the code to set flag in __bio_clone(), it's
> introduced in commit 111be8839817 ("block-throttle: avoid double
> charge"), and author thinks split bio can be resubmited and throttled
> again, which is wrong because split bio will continue to dispatch from
> caller.
> 
> Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
