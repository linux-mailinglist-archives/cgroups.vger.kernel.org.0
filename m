Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2BF433CE8
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 19:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhJSRDF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJSRDF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 13:03:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D5C06161C;
        Tue, 19 Oct 2021 10:00:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso382404pjw.2;
        Tue, 19 Oct 2021 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oDh6wY5mxgjBgRFmj6OpdKqeAcazi57fngXpPsPLWE=;
        b=lRts9Q2QN5BocnpFjJPqpBK3Fxaxv4kEBoF/rHLBeWaGIYwAxlKsPIhkQCB7sNAmRj
         UERoxRYtgRGMzur8k2GM5Y/uFfigfGYqd1hcqOryGHOglz1dxWtZNVUYhgx0tD+hilKq
         V8/oWKqn3J2sTUprRMG/t7pLpLgbMEIoyy/+Yyr6FKU3FUd/0I1Urd0FLCulQCkhKyz8
         4TLlu7kFoFyRAEOHLSuV4dkq9oUAiIfZuvxmu4RCbRc28MpW7etPuuxUZLeetNOmIejx
         9MpRHH231nr3EYgiUBiOpX+2Z1SpFRYcJy86zemrDgVuzLz5/JQWebAYxJqNe4SaNEB/
         rBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5oDh6wY5mxgjBgRFmj6OpdKqeAcazi57fngXpPsPLWE=;
        b=j+/sT10d7Kmyk1NLXKKnjsj1T7gQ/gSjhAEZOG/oNP/KWILgAsbWR+8hmypzvQGScz
         0nDq6oQfxT1r/qkz34+jqTk1IGaL0ActKV5pYnYdjMQhFUeFP9C50WEav3jDvzPetlSw
         z4OiwZ6xY0v6fGZ+sHEtcDj6fU8Uhrp4bnbCIbcvihoOOs45KTlYvRLynlMtezOuYp/w
         r1bjoCiE13EX68qggPPqC0qO2DBw4mxldSQD1mAUxszaI+n0kziYJP9FIsURqBzil/Z4
         0GWaU2N3/o4C3tG8ceZ55X4W0HMOA1W0maI9DxSwjPd3LpY7ELJw5MR+NLiA4nHqUTo+
         m5qg==
X-Gm-Message-State: AOAM532A4F/NOZujYTYIdskqkXkb1HYdN4grMr+PRWvyvcKFHh4cuoT6
        F9LEjn4Pa1IwADd1Q9NsSvRtdy27rn4BYw==
X-Google-Smtp-Source: ABdhPJz2Txw4Iyq0OpTfOKDWQ5EPgZrJEgJ5wmiLGj6rOynX5rPquD2dOQEYI7PZZR0bLUwKgFAVJg==
X-Received: by 2002:a17:902:c942:b0:13f:d1c:819a with SMTP id i2-20020a170902c94200b0013f0d1c819amr34461656pla.64.1634662851444;
        Tue, 19 Oct 2021 10:00:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id i123sm16894060pfg.157.2021.10.19.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:00:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 07:00:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org,
        avanzini.arianna@gmail.com, fchecconi@gmail.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v3 -next 1/2] blk-cgroup: don't call
 blk_mq_freeze_queue() in blkcg_deactivate_policy()
Message-ID: <YW75wUcf9CcmqdD5@slm.duckdns.org>
References: <20211019024132.432458-1-yukuai3@huawei.com>
 <20211019024132.432458-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019024132.432458-2-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Oct 19, 2021 at 10:41:31AM +0800, Yu Kuai wrote:
> blkcg_deactivate_policy() can be called from either
> blk_cleanup_queue() for all policies or elevator_switch() for bfq
> policy. Thus there is no need to freeze queue in
> blkcg_deactivate_policy() since the caller freeze the queue aready.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I would just keep the calls. The operation requires the q to be frozen and
there isn't a good way to annotate that the caller must be holding a usage
count, so it's useful even just as documentation.

Thanks.

-- 
tejun
