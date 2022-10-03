Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08F5F33C3
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJCQlk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 12:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJCQlL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 12:41:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1227FF2;
        Mon,  3 Oct 2022 09:40:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 10so6555981pli.0;
        Mon, 03 Oct 2022 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=UYsFd23cSQZ/m2EDH2nwy0Fjt0240/Cw81WucrFzjOo=;
        b=OpLEDrCbywNIL/ySOOKrHxYnz0Ag0oweJ1c1VjO/l8v033KF570Ve4lrOvea3d3XlR
         a5PVvvWOYInxay4tnEdqJ5EOdpjNIgyNOoYCwwimZ2GcE7fNfgIYdOr4yEv4nEUUQ8qJ
         6rjqeZNse4yyoF+uYGETD9Nt+bv6IjbYkaOapGnSKPuSxy4i5aWN4ZhafDJDaBe5oKMt
         BbavpV9VCEr1jGMNVYShhqvtAicaSQx8rKUwQYDUo4P9ZQdTv/IUvtHaq2XQcfZtfXhk
         DVCbUydYeZ/hzgzCY84Mbcd+paD7Hmy4d+js7tYYM9FFnpEDxX3FCAzy1VZC5vDIAn2/
         FFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UYsFd23cSQZ/m2EDH2nwy0Fjt0240/Cw81WucrFzjOo=;
        b=do/bTJzdasFxSPqff3/GfZQpPwWg5fLM68AUPB4fDmCBPOu1TJv7RkOk1cbGHkI8On
         Np/tc04LgVmhs16aHNxxfRVMgFUD4iBhi9mLWa9dmun7/I592Iw5nPnXaDu2UrAmlCv9
         xhrkCf4CpVfocnO9WMJ96TWh2wX4sj+zjNHez7w1K/lE0mcsDGoY/F5hVXm/9kVoKZxq
         uLmsS16gT4NfUk29NXfpvKtmNE9Fvq3f2luQxWN/KyJvqoo8UUQFGowZtAJBaAilb6N/
         bnWg+oJavcrcEaFtMUg/jT9g2IKFvZCEHz4T8ZdA/HHbTnzs02visWl8Ji69J7oFhRmw
         8Iew==
X-Gm-Message-State: ACrzQf0OZAXPV9K0/mSj9isTQhPDLBimVI6gypELrv5EMB2nBEKQ/XI1
        xzs5D9NtiP3HfGMbylH8c/s=
X-Google-Smtp-Source: AMsMyM4pM8kLH0wxENG04X8RP+AMyNMrpji8YiORIu1bkOaSMeQ+HrqG1t7qFqfgvk3xWMK8aC+rbQ==
X-Received: by 2002:a17:902:d508:b0:178:b7b1:beb3 with SMTP id b8-20020a170902d50800b00178b7b1beb3mr23204816plg.102.1664815252342;
        Mon, 03 Oct 2022 09:40:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h15-20020aa79f4f000000b0053e75395705sm7563860pfr.127.2022.10.03.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:40:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Oct 2022 06:40:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7 2/3] blk-cgroup: Return -ENOMEM directly in
 blkcg_css_alloc() error path
Message-ID: <YzsQkpYOeIfDSA03@slm.duckdns.org>
References: <20221003154459.207538-1-longman@redhat.com>
 <20221003154459.207538-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003154459.207538-3-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 03, 2022 at 11:44:58AM -0400, Waiman Long wrote:
> For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
> Simplify error handling code by returning this error directly instead
> of setting an intermediate "ret" variable.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
