Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2A63ED4F
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 11:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLAKLy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 05:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiLAKLt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 05:11:49 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF4C54;
        Thu,  1 Dec 2022 02:11:49 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id h28so1401805pfq.9;
        Thu, 01 Dec 2022 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pA5rgpRQHTSCN/GLM21EYU5Er0xU1UvmWyDaPEdq2Cw=;
        b=RHcGwSDXkjYbxA3YKl/rWeJUxYDAKLu2ymAgPasW2ObnBdRmEjmx4rW0oHKOgzu0vu
         DuKQhKP2dPrR7IHG8jv0kbMntMuAQ/rGgf4LqEJ/0yjFbLR2XtUb0NofTtdiJuqbPpBy
         Ka01w82uJUw4f2u3FwIdycBDfoiTgfXfMzBKM0R841WEG00s1FHlvS4St9Hf0UTnv+Mw
         kDXQ9dl0RRMJz+a8Rqm2MOOW1wZHU/s8uPNTJDcF7AmvorD0MtMGCTUyY/0YQNSf5isi
         jxE00CfvVD6QWtlKsUbjBb/YUEGRUUzTSzXZuzGjILxC+U3FpaUidhTb14Fe8ydR40Ug
         NqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA5rgpRQHTSCN/GLM21EYU5Er0xU1UvmWyDaPEdq2Cw=;
        b=1XwaZu6MnDAkBMqlxFXO54Ofxg90YbCli36smuKhcKRfDCzaMFvS97P3wG9Alk0Mfy
         b6ATQXapQ0NdkSasWZG4Xi1BcTT22hMcsUVwe/ypW5TSEJmjLvSCoqnMU0X5/uyuD8tR
         B0dzN9Ogg4tytWdwEVyjxpKkedjz8aZO9VgcAYC8q2rxzDG27XXfiTkheUCdyokkWEeV
         76c36aUe8ZMII1g53vHDTB1CwxaS62Yu41aTzb8MsRkCDlw26wQL6sw7hDBY4+AZCSOC
         eUs9R3N6R3xHH6BJfByEvPKZxt0UsU4D9NCoJZ6Vq5iWjA+IBW8FEx26ijrOtnPtJ/Xp
         2tjQ==
X-Gm-Message-State: ANoB5pmPgxikQdkCZePvcNHGqrIvVB48OnC3tUfg7fRQnY3O0FveUf5k
        uOn62ZdYYF8C/fnplHA6MDA=
X-Google-Smtp-Source: AA0mqf7fyUFmkWu6L7Wq0l7ea0Ocbqf/pGFR541CsRzmeJo3o4ws8me2H3CYFqFM9kr/XBx9CM0BFQ==
X-Received: by 2002:a62:f211:0:b0:574:7931:98a2 with SMTP id m17-20020a62f211000000b00574793198a2mr37918466pfh.17.1669889508402;
        Thu, 01 Dec 2022 02:11:48 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id pj7-20020a17090b4f4700b001fde655225fsm4626901pjb.2.2022.12.01.02.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:11:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Dec 2022 00:11:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 8/9] block: fix null-pointer dereference in
 ioc_pd_init
Message-ID: <Y4h94m8QMPtS4xJV@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-9-linan122@huawei.com>
 <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
 <9ca2b7ab-7fd3-a9a3-12a6-021a78886b54@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca2b7ab-7fd3-a9a3-12a6-021a78886b54@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 01, 2022 at 10:12:13AM +0800, Yu Kuai wrote:
> 1) By mentioning that "del_gendisk() is quiescing the queue", do you
> suggest to add rcu_read_lock()? This seems wrong because blk_iocost_init
> requires memory allocation.

Quiescing uses SRCU so that should be fine but I'm not sure whether this is
the right one to piggyback on. Jens should have a better idea.

Thanks.

-- 
tejun
