Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63C67243C
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 17:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjARQzH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 11:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjARQzG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 11:55:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA0A5D3;
        Wed, 18 Jan 2023 08:55:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h192so24959550pgc.7;
        Wed, 18 Jan 2023 08:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7F6VPbhMnzjimtiCShZ77ZvG/bSXxm/Jis8nNrNKeM=;
        b=XuT/m/jKqKU3pK9KFC1rR7pyI+ajP9HGz+9CmIHpgh9GlUoRUpIPOtc0TZvnqpZeyr
         Ba3IlJooRL4qJQ3msXeozWveqt8Mcrz6dGVGKYWbzSDJ1UQCLQ+ws1lYXWPsIon2u4J9
         lbFzmO0dVPXbG0hO2DHEJi/m9XEnW3NXwdDlu+62sjYnKx3N7prYNncVKORJG6bZ41UV
         0lGBxSy1NHQ9hmvIlI/dFom49BtT0+7K3i2/vlrDyT2rV5g7bakA1oJe/3dcZ0yip8J2
         ounssrODrQORokHwzX3OmhLnodUuQtZ1dAMe6Ii4bdqQ6lxlbD7WrllvZ0TnnMjRQAPq
         BGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7F6VPbhMnzjimtiCShZ77ZvG/bSXxm/Jis8nNrNKeM=;
        b=u6ENIEgpszcObogAeZcptc9DEXjADvwY2Hl0Px9O8QEt/WqTC6ulbndkqIB5A5u9I6
         Ap8DeFY//NzOhtbdZUbeBGzcSyINb/3gja9h4M50osLWBkpsnuQiuSR4d7ImSpffWumY
         n5EjBTOLohJo6la0nukJXY+8+pAGQgkfhD/JW2/Nxgk31mIPSS2JMW8N1soiUOpPkFPi
         eteNM0GBerFzWRlpifJBth6FLOD/47ZRhYUvNREQRusdvZHy+Dv4h34Z5aVBrrVdGX/E
         Ide5URQsDgavCmCR5MuvC/UIkgojKuEmYvug2WWd0tbAdFV1ZTaNKP3e9EMW5wk6Y79z
         dG1A==
X-Gm-Message-State: AFqh2kpqsD61dIfcUsyoiYWhYGVL/WqYddfAiDYdUSTGLnqB4NNEU/q8
        45/RmTM1MvLe/sFZrZJW7PU=
X-Google-Smtp-Source: AMrXdXs+OGZOmO9WlvaK+EhpkQaJZ6PalT95dARKAiUuR0XU75S0X40jmfEn0vKjeCb8nlVbTsm1kA==
X-Received: by 2002:aa7:8bd6:0:b0:588:e132:a2f8 with SMTP id s22-20020aa78bd6000000b00588e132a2f8mr7610180pfd.23.1674060904743;
        Wed, 18 Jan 2023 08:55:04 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h28-20020a056a00001c00b0058bba6f06c5sm9837853pfk.8.2023.01.18.08.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:55:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 06:55:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 2/3] blk-cgroup: support to track if policy is
 online
Message-ID: <Y8gkZzvhnL6+0YQz@slm.duckdns.org>
References: <20230118123152.1926314-1-yukuai1@huaweicloud.com>
 <20230118123152.1926314-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118123152.1926314-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 18, 2023 at 08:31:51PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> A new field 'online' is added to blkg_policy_date to fix following
                                                  ^
                                                  a
> 2 problem:
> 
> 1) In blkcg_activate_policy(), if pd_alloc_fn() with 'GFP_NOWAIT'
>    failed, 'queue_lock' will be dropped and pd_alloc_fn() will try again
>    without 'GFP_NOWAIT'. In the meantime, remove cgroup can race with
>    it, and pd_offline_fn() will be called without pd_init_fn() and
>    pd_online_fn(). This way null-ptr-deference can be triggered.
> 
> 2) In order to synchronize pd_free_fn() from blkg_free_workfn() and
>    blkcg_deactivate_policy(), 'list_del_init(&blkg->q_node)' will be
>    delayed to blkg_free_workfn(), hence pd_offline_fn() can be called
>    first in blkg_destroy(), and then blkcg_deactivate_policy() will
>    call it again, we must prevent it.
> 
> The new field 'online' will be set after pd_online_fn() and will be
> cleared after pd_offline_fn(), in the meantime pd_offline_fn() will only
> be called if 'online' is set.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
