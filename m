Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4753265F197
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 17:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjAEQ7r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 11:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjAEQ7j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 11:59:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D325C938;
        Thu,  5 Jan 2023 08:59:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so3981769pjb.0;
        Thu, 05 Jan 2023 08:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6/pyn3vLiTu4LQPjq1YDQtDVZvW+kSX5YHBAxRyFO8=;
        b=pAjIbIyMHaELzfUibrA3v9W+sRKujPM33MXbNJU5pgHSE0PXYNtxJxzhKIuEhbYX2I
         //w0bNp5rM4kUuyqlJjg7UH2U6kdWagMOCFswiNMHO+MP5kKQmUJ0lnzwkYYNOWZOZVn
         EdugV+lRv0hIvf8c7FMNOtMle0x7h2E6Qnb049/E/YE/sTad3y00z5hxyx+IYbCfMZQc
         Peeez2SyIRJYa/Cj1o+eYfzKr7hFOa5Ue+JIcn3JJ8BHQ6F4lmQkn177ETZTiaIvddtn
         Kr2lAChV22biUhSCqdGzYEksLBQahie9+eCOp4KdEsgpyAzBOn9evh4V+o6ZsiU80js2
         jV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6/pyn3vLiTu4LQPjq1YDQtDVZvW+kSX5YHBAxRyFO8=;
        b=LNE++JbH4C6eqUwPggnyrlPOVGBXUM7uJZKpNQKKbnEeFL+rIE8hNnPEhT50JFaQz3
         qe8IxfPgy4MwRbt94Q5XhF0Pfsyd3c9jJAlofw3uwmT6hSMTza6gPhPRJjbKMDPTwyJS
         7oXpoApUK7nY0Rqq0I3js8tgrCHEI2DsUDAQ1CYaMl4lCHDSpjFZymFO3yQVsX8rluvV
         PoOZB2bRZesn1c1VMMYPq8lUf5zw59pj8vGcJAtAbOtweUesF2AfO7GWihFF1RUhVAVT
         a60rcqL5LhtDqA11BRTQgZD9jaG0kqZ4G3G1b/WS9lpyc2pXOcwG+E4sYSKCXKdd/phZ
         lPUg==
X-Gm-Message-State: AFqh2koDqV5jzRxALMUccAjw4bHPy2h77pCEIrpnwCZj4VvVbbNkwikd
        74UH62pzjT5tYLO3Bq8XCuIx2rmv0mc=
X-Google-Smtp-Source: AMrXdXuDyUGyV/XJrWFjFnkkcvkqRgsKtzwm6TwmyvBHXxb32lJHO9KtvdBYppQq8dRbKT93jTqqyQ==
X-Received: by 2002:a05:6a20:d819:b0:b2:3b40:32b1 with SMTP id iv25-20020a056a20d81900b000b23b4032b1mr60554726pzb.57.1672937967583;
        Thu, 05 Jan 2023 08:59:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g7-20020a625207000000b00573a9d13e9esm21345455pfb.36.2023.01.05.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:59:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 06:59:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while activating
 policy
Message-ID: <Y7cB7f98+PNdXUnj@slm.duckdns.org>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
 <20230104151241.GA13268@blackbody.suse.cz>
 <4b559d1d-31e4-6049-4548-451bf7afb4f4@huaweicloud.com>
 <20230105104241.GA16920@blackbody.suse.cz>
 <6f54c858-be91-0fd3-d377-1aabb8a70c6f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f54c858-be91-0fd3-d377-1aabb8a70c6f@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 05, 2023 at 09:52:29PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/01/05 18:45, Michal Koutný 写道:
> > On Thu, Jan 05, 2023 at 09:43:02AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > > This is based only on code review, currently the only negative effects
> > > is that root blkg from blk-throtl won't call pd_online_fn().
> > 
> > Good, that's a NOP and there are no other uses of pd_online_fn.
> > 
> > I wonder are the separate pd_init_fn and pd_online_fn callbacks
> > necessary today?
> 
> I think online can combine to init, consider that only blk-throttle
> implement pd_online_fn(), but I'm not sure...
> 
> It seems to me the policies(bfq, iocost...) seem don't honor how pd
> apis works: alloc->init->online->offline->free, bfq combines online to
> init, iocost combines offline to free, ...

So, the distinction between alloc and online is that a pd which gets
allocated may be freed without ever going online if later allocations fail.
This is following cgroup init/exit pattern. Maybe it's a bit too elaborate
but the distinction is meaningful, at least in principle.

What seems truly spurious is pd_init_fn(). All that pd_init_fn() can do
should be achievable between pd_alloc_fn() and pd_online_fn(). The overlap
seems at least partially historical and we used to have pd_exit_fn() too.
So, yeah, getting rid of pd_init_fn() would be a nice first step.

Thanks.

-- 
tejun
