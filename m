Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6C67F121
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 23:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjA0Wdn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 17:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA0Wdn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 17:33:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EE67375D;
        Fri, 27 Jan 2023 14:33:41 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g68so4109728pgc.11;
        Fri, 27 Jan 2023 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSdAw5E+KQxTCwUtNIvKfHgNvmREZsFWtoKFr/X4fy8=;
        b=LEHvm5GH7a+hPuBabmJkDfk6RS0MfiLYbQszQTh1bik4tjbgiHIhqbbOx47udlnq7S
         qJCo4vSOeTQ1L8onby3CZ0gCiS+NemJhwGj4EVXyvRy8ro71sOkxfhc79cOmY69UM+x4
         Cohpz7ip1eNwpmz1IWseA8ax2zisxdEp1+brPvxf4s0q6bqKppxSEhGJZw4pMkis2rOA
         pmRkbJB/UnTy3oZBkt/9wDHhan6B4rDGMBEXZenVwMrYyvBYRBLqhssAug3ooPjG4OuU
         vl1jB+VLuZ/ZSJeWovFlzSn8NaKDTMAS5qlxE3ZFaizNX3kLdkUtdufjEfMVsfPuqUpi
         lwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSdAw5E+KQxTCwUtNIvKfHgNvmREZsFWtoKFr/X4fy8=;
        b=7pQexwhqUGbCe7P66iiC0HnjxRPvYCnZ1LNL3kDD3uyeb4FSz9zJ6IJGf3WdkCBY2o
         LKxMExfUf7zKP6Xi1A0RkD5E/5JF5kp7ogW8YX59Id8BtThpKsHgqqYnp0ozk6BjIg6C
         tqEWpFokiPfd88LMFnQEnpo/aiQUqHkQ+r1AV+R3jy2UczT8xpOqtKrl6Aqc8eA4bdcv
         yqQ9+xnXdGQMNGxZMXaIDhC3G0BtjJ7t+iovVGimC1Ykntlqcnaaq4Vh7SpxqEScAIpv
         hXNtP29GvL/r30dvEo8DRWgWGDNvGFLdCE/eZCA0aN2vlEM0SPsDgDzvKeRM/BYCm7ye
         1ROw==
X-Gm-Message-State: AO0yUKVhmllywqia8VDkvcKMRKoZDSL+TQJbtzdZGb8UXetSzQVuLGIc
        A7duX254pOw7aekidAc6DWmxhsoby1A=
X-Google-Smtp-Source: AK7set8ElX+1jXBZdDiX1xUaCUEAZWkkaryXsgVJkZ/qTuglmNTuW2OtWsMuLbZpon43TzXrnJOntA==
X-Received: by 2002:a05:6a00:a04:b0:593:3c37:fa75 with SMTP id p4-20020a056a000a0400b005933c37fa75mr2944177pfh.1.1674858821241;
        Fri, 27 Jan 2023 14:33:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w22-20020a056a0014d600b0058dbb5c5038sm3071805pfu.182.2023.01.27.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:33:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 12:33:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Message-ID: <Y9RRQ9Ct5mjuDKq0@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-2-hch@lst.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 07:57:01AM +0100, Christoph Hellwig wrote:
> Now that blk_put_queue can be called from process context, there is no
> need for the asynchronous execution.
> 
> This effectively reverts commit d578c770c85233af592e54537f93f3831bde7e9a.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
