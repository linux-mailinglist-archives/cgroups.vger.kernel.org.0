Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987C140B46A
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhINQV2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhINQV1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 12:21:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2BAC061574;
        Tue, 14 Sep 2021 09:20:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b7so280049pfo.11;
        Tue, 14 Sep 2021 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1FvZRHk3SBPfHYet08WVNMbl9U9iubGfahKVS5kswgA=;
        b=jc4VIL8AuuvPriT9n13HDBh5j6ZGD7KA06UejblD3JhzLbO5fAnpivCvtJQ2E37qHo
         jUQwIYB23+YszX35Yk3eoM8QSBlZUFfpdQgPflf528djjT7wwouIiSERkL78Chl1UXcN
         g+QqwKq2pRC+SGgCbnl/HwPF7q5FScmOqEhIBLgtiBm/rspHX2g3SKI/FAMPooYMfoTb
         0lgosZAGSu2CrpN93F4J+d5UqiABgG6FE0dwOIg2dFhmlOxW2krtwQ0Vd/Uoio3dbx3W
         zYD8MsBZwc0rp9/FetxAIjvq0xbr5Jc2xuDyNDlplDip0VgzIySG2AGYfmqhVUNx8hs5
         UhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1FvZRHk3SBPfHYet08WVNMbl9U9iubGfahKVS5kswgA=;
        b=IgsfBpHOLY5XhlC2JCmLUMUcmFaRbzS7lpG62B+OZFqvXq5N9+FBFUWuRUTfOKme7k
         m5LdikxWy0Zot9SyGuc7yBGGjZw9b1vxI0t4bZcs5J69pAXoycAo/mbP4ww73wtmCC/6
         RLOpDU+mVA993grPNNI30NukNd42vQtM2Mo1YZvTmvKwqP69ID3P07wtyZJrkoHEQNVS
         wlKlfhalgN2UbdYEKbr1s8crs3aw49u92jhxA5agR04JjrV79QM0HIy4gF544A0wmj/W
         X6aN+ixyByYotM23agjVmhzmvHGIEhTS+YSz5fX94aPnIHexdxBFmHZhDJTXDBXI9oFk
         Lq7w==
X-Gm-Message-State: AOAM531HxgpoqAp90HeMCd6AQ58YnL0Qvtet+hQPYnuAd0UWrDgkvxF5
        ezPCMla4YFt9b0PpISDkrnWd3gih8LA=
X-Google-Smtp-Source: ABdhPJze5MUrZlClXZZEq1gMjyyzUOftInWdHvOkqr6XpnbpGK3SMsoz5I98t8wW3sasO/4LYWfQHg==
X-Received: by 2002:a62:ee11:0:b029:3e0:88dc:193f with SMTP id e17-20020a62ee110000b02903e088dc193fmr5514807pfi.78.1631636409520;
        Tue, 14 Sep 2021 09:20:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x15sm11839238pgt.34.2021.09.14.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:20:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Sep 2021 06:20:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, louhongxiang@huawei.com
Subject: Re: [PATCH v3] blk-cgroup: fix UAF by grabbing blkcg lock before
 destroying blkg pd
Message-ID: <YUDLt9uBNLhWL6Gt@slm.duckdns.org>
References: <20210914042605.3260596-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914042605.3260596-1-lijinlin3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 14, 2021 at 12:26:05PM +0800, Li Jinlin wrote:
...
> Fix by garbbing the matching blkcg lock before trying to
> destroy blkg policy data.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Li Jinlin <lijinlin3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
