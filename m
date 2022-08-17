Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12686597544
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbiHQRul (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 13:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiHQRuk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 13:50:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B757753AF;
        Wed, 17 Aug 2022 10:50:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso1749440pjj.4;
        Wed, 17 Aug 2022 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=pY3XHrB+Wi3bKxfBpJp50GFS99FF73DUvD5Y05CzuoI=;
        b=IHO0SHseMzeS46BS8DB8qYHNx/9K9Po2jDjannSsFW2u2SxIKIlUWdtLYliYqIwuAL
         RSHh9vvEhqVGPqkSk96CH9Z26mDMkYksVRag3woPYyGSI+AWvc/XeeEFsznYNqhTWPjx
         G01h0D/sR6Mz1fDC0eIZM4N4oID0PT/CS75Rg0jXj+Bjl8W8J6ymnhozLu9BdIVnZkKN
         tBZzWaKRxMnu22tL6TNYFspubTCbaM1VaVMEqhw4pw6LNCKtq6x4kaL7MP3PTw72htYo
         Y6XS0hjYg6M/LBS/V4fMQ56/tQdgJPS3WiGpXVgPZDFn4EAsjB0kXxKt8UAK0mQ5uxlk
         12PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=pY3XHrB+Wi3bKxfBpJp50GFS99FF73DUvD5Y05CzuoI=;
        b=qdgtlgrunqtDZg6c5Q/vr2nkyJdn8A7AECNC/ZUxZ2RmAh0DiqKkZOWMxrLJqywtZG
         E4ABNKpzcKmCUtORHBoTGCK5q3lVpM+Ph+knP5Bib/BmxCEtxpdWlXl4kjiZjTS4L5My
         CRey2U4CfW50M35rrTxyRZ0nicwVwcKxik3rc4DIAYb28hyPV/7I7PTgYwxvQDP7rqbG
         h/kPxBoO/VIWlnsY7tOFEXbgncWFs0LEkzjykip4BHBJGbwWL5t//4NzseIh6j/NE/uF
         4F3vxOHeEflQj7rUOJHbSh4UHumbCo1yKqavkAOYBwTQEQMD11hs/+EYCVLiFIk/m3Ih
         sqPw==
X-Gm-Message-State: ACgBeo1Hsm/5qmEMFyaMxtDlOGBeTDaFzn1jgmHVvGA31Vgkl28m1d5I
        0L8b/JzXlUw0YgEHi1dAfLs=
X-Google-Smtp-Source: AA6agR4+whOY9at0+aQfc/dS0mvg9VzlKcW5nL0s0xJQQvrKjh4vVhnmhl+pG9saQRZ8IoUiJzuTJg==
X-Received: by 2002:a17:903:41c6:b0:16f:3d1:f63 with SMTP id u6-20020a17090341c600b0016f03d10f63mr27029611ple.50.1660758638451;
        Wed, 17 Aug 2022 10:50:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001729ca3306dsm184782plh.228.2022.08.17.10.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:50:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 Aug 2022 07:50:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v7 1/9] blk-throttle: fix that io throttle can only work
 for single bio
Message-ID: <Yv0qbDR+cxKeZ3nD@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-2-yukuai1@huaweicloud.com>
 <Yvvx+/d2+OMROUOe@slm.duckdns.org>
 <712e0f29-94ba-d3d3-ce21-cba4d6092008@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712e0f29-94ba-d3d3-ce21-cba4d6092008@huaweicloud.com>
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

Hello,

On Wed, Aug 17, 2022 at 09:13:38AM +0800, Yu Kuai wrote:
> > So, as a fix for the immediate problem, I guess this might do but this feels
> > really fragile. How can we be certain that re-entering only happens because
> > of splitting? What if future core development changes that? It seems to be
> > solving the problem in the wrong place. Shouldn't we flag the bio indicating
> > that it's split when we're splitting the bio so that we only limit them for
> > iops in the first place?
>
> Splited bio is tracked in __bio_clone:

As the word is used in commit messages and comments, the past perfect form
of the verb "split" is "split". It looks like "splitted" is used in rare
cases but dictionary says it's an archaic form.

> if (bio_flagged(bio_src, BIO_THROTTLED))
> 	bio_set_flag(bio, BIO_THROTTLED);
> 
> And currenty, the iops limit and bps limit are treated differently,
> however there are only one flag 'BIO_THROTTLED' and they can't be
> distinguished.
> 
> Perhaps I can use two flags, for example BIO_IOPS_THROTTLED and
> BIO_BPS_THROTTLED, this way only iops limit can be handled and bps
> limit can be skipped for splited bio.
> 
> What do you think?

I think the code would be a lot more intuitive and less fragile if we used
two flags but the bits in the bi_flags field are a scarce resource
unfortunately. Even then, I think the right thing to do here is using two
flags.

Thanks.

-- 
tejun
