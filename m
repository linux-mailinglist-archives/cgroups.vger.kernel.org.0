Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5E69E4E2
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 17:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjBUQiX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjBUQiD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 11:38:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1432DE46;
        Tue, 21 Feb 2023 08:37:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s5so5586327plg.0;
        Tue, 21 Feb 2023 08:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqDVJNwWIwNFunXvEtWTSAzOUCVvEWbOZPflEYS3dBY=;
        b=V7Wqb5Q5j7csLQ+YeuJvsKd+kFbhRRHjX+GPXEP0Wc0CpmU2vK4TCu6jCTMzg9fjxn
         Uj+/7bqoyR2OMrFjmxMpoZA+KbnY8u9Hy9hItNDI/EVMOABnsHYqSlMzf3nJX0/rIwzB
         FhOYPASmRQFqT9cS91YklOMDNf/LGwsp/+fTP6Hn0K/Dh1M+ILAzNaOPXmiW9W6UUueR
         sYMa/ZBBXn2uviNq8bUZKDD7owk5NQYzbiFB5OWHbLp4FUKs+o8ifNy9qt472KE+mTuc
         0XHE2zo5sRqGNHL1KueXlH2hgb8L5Td7CjJjRnTNklbmcPwh+hbXh8PXTe1dxO7vLj0C
         km7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqDVJNwWIwNFunXvEtWTSAzOUCVvEWbOZPflEYS3dBY=;
        b=DvDfeaiJM5JrZADQ6wFupfo5uEIDinYVYn9U8OR87XluLn4/H6QrElUZlem/dLyW0M
         wWVJOx86CJtsdJmC2lEIAphOrPvdtX4VwxUmOjzRRsYfV9E7lxXBsjTuoPLSlK2fWauP
         XJNZMy1O0SJmwgrjTkhaLAmO8iduPzsz9N31LofVBb1pwybfHjskuBrQpe4GitZ/9NHk
         CpT0T4nRvCAYaoiSRjlAKrdFR1SMqum+C+GSfIxGiWOxXOR2UlpAi9XossN++NjaZb8u
         xhJSpwqamRbVJ5NyVQlxm7DzT4N8EW2YgfTsIdcsqPnv8IKDFJNsvZmTZ2dBTowipfRw
         AQGg==
X-Gm-Message-State: AO0yUKWVv61f8V3O0KRY5MWbmF+pJG0ZOakfvNHZkIShZ2z284OVfwUd
        xmLYRa+4JXMH3p8hqoZfkuE=
X-Google-Smtp-Source: AK7set+FL4iaLqYNvulbE2F4fY0EVsxaZ2Q2fYgot2Ig08W5ePJxQH0cmXMqX8+UP4S9gwIM2Z5SGA==
X-Received: by 2002:a17:902:c94f:b0:196:88b8:8616 with SMTP id i15-20020a170902c94f00b0019688b88616mr6663359pla.5.1676997459661;
        Tue, 21 Feb 2023 08:37:39 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bi12-20020a170902bf0c00b00194c1281ca9sm10096419plb.166.2023.02.21.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:37:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Feb 2023 06:37:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jan Kara <jack@suse.cz>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
Message-ID: <Y/TzUKbsa6D7+Ui1@slm.duckdns.org>
References: <20230220135428.2632906-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220135428.2632906-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 20, 2023 at 09:54:28PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit a78418e6a04c ("block: Always initialize bio IO priority on
> submit"), bio->bi_ioprio will never be IOPRIO_CLASS_NONE when calling
> blkcg_set_ioprio(), so there will be no way to promote the io-priority
> of one cgroup to IOPRIO_CLASS_RT, because bi_ioprio will always be
> greater than or equals to IOPRIO_CLASS_RT.
> 
> It seems possible to call blkcg_set_ioprio() first then try to
> initialize bi_ioprio later in bio_set_ioprio(), but this doesn't work
> for bio in which bi_ioprio is already initialized (e.g., direct-io), so
> introduce a new ioprio policy to promote the iopriority of bio to
> IOPRIO_CLASS_RT if the ioprio is not already RT.
> 
> So introduce a new promote-to-rt policy to achieve this. For none-to-rt
> policy, although it doesn't work now, but considering that its purpose
> was also to override the io-priority to RT and allow for a smoother
> transition, just keep it and treat it as an alias of the promote-to-rt
> policy.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
