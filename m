Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271F672438
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjARQzE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 11:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjARQyo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 11:54:44 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AB959DE;
        Wed, 18 Jan 2023 08:54:44 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 7so24966906pga.1;
        Wed, 18 Jan 2023 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9OP8oV65JxIUAfGtsGFxPR9aOpiL07LaKAZQ5LY4+8=;
        b=FMmwB5hmA/Th3ZFkKr78WupQ0I9Ky1YNdVlkyiJ7vyA3gwsXckPf4Llnr8mFrlAW+d
         MnUuagJq15CF2N4gvUdJMh8vL7aJREH8allAUTWEUp7NUV/I587rdeuR7c1JQ8YpR3Yk
         zUxdqkr46VnVTiwH7YUpbJXhVZWu59iWkWBh/lULZ8rl8RmZH/dgJnZXiP76gjrdeuX+
         Bk5Pd9ufG2BvWVFURawcDgu+DVrcuCPxeO04P83wI9MIIjQ5H0iDGgrdRV4Fe5rqOrDd
         TI4MlgnElMy1eCczsySheHNHs9ur+IwcfltR/jrns20VlYCSFxON2DD3Z0zb78IqLdG6
         BtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9OP8oV65JxIUAfGtsGFxPR9aOpiL07LaKAZQ5LY4+8=;
        b=xoFi+vAttnxKKfU+MqwJt/00l19CSZ4pWFcBZnjzVJEtBw12njIdivtJbvUvP1rk4y
         a1X2xyBT7XRAODRs8LodcD1ggDm627HRni12nlAmpnLQgXC+UwFg/+tBGAnKB+xU1LkQ
         BlOOgKXkrAmkUju0/RkmFiPCUDHHMuxWHALh4+wmOmZl1Hluy2qOwJOK1ltBCEKsA4nm
         4wF/bBwwpp9X6rFzZiAZGzNNkKpq+hIpNf/gh2jDga9RlXiD8oa1uuz0i2/+kDTD5Wta
         jvOjQ3bBb7lLr6qxOioXgBDjsHnR6Uu/uahJudXXMzHp6LXc1x56tlMxNw/a9DqLHQsU
         daCw==
X-Gm-Message-State: AFqh2kpJ9q6ezcrAg3Z4oCDB52c+KEcsTfmtHOx0xJeZNMqj4yhLKYrN
        3v9EtgWpPWYVRopu7IaTCGc=
X-Google-Smtp-Source: AMrXdXstQ6NwqPI7L10VopPjj2T7ROCoImBl+NMgpi1AN42V8aksYEYcP5kEJVUI8pXMbgJrc3LHSw==
X-Received: by 2002:aa7:9f1d:0:b0:585:64d2:54a0 with SMTP id g29-20020aa79f1d000000b0058564d254a0mr8227467pfr.24.1674060883559;
        Wed, 18 Jan 2023 08:54:43 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 5-20020a621505000000b005772d55df03sm22238553pfv.35.2023.01.18.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:54:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 06:54:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 1/3] blk-cgroup: dropping parent refcount after
 pd_free_fn() is done
Message-ID: <Y8gkUZtbWltG/vI3@slm.duckdns.org>
References: <20230118123152.1926314-1-yukuai1@huaweicloud.com>
 <20230118123152.1926314-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118123152.1926314-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 18, 2023 at 08:31:50PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Some cgroup policies will access parent pd through child pd even
> after pd_offline_fn() is done. If pd_free_fn() for parent is called
> before child, then UAF can be triggered. Hence it's better to guarantee
> the order of pd_free_fn().
> 
> Currently refcount of parent blkg is dropped in __blkg_release(), which
> is before pd_free_fn() is called in blkg_free_work_fn() while
> blkg_free_work_fn() is called asynchronously.
> 
> This patch make sure pd_free_fn() called from removing cgroup is ordered
> by delaying dropping parent refcount after calling pd_free_fn() for
> child.
> 
> BTW, pd_free_fn() will also be called from blkcg_deactivate_policy()
> from deleting device, and following patches will guarantee the order.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
