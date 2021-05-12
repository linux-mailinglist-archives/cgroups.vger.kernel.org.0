Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12D137B44B
	for <lists+cgroups@lfdr.de>; Wed, 12 May 2021 04:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELCwJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 22:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhELCwJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 May 2021 22:52:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D399C06174A
        for <cgroups@vger.kernel.org>; Tue, 11 May 2021 19:51:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso851311pjb.0
        for <cgroups@vger.kernel.org>; Tue, 11 May 2021 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wH9LtqZdrV82uryQNvQG57KCdHT182AjVpniYypTn5s=;
        b=ekZ2yF344cjQ1w+P7pdP5YE3qyPqszU1gfMoVhIghgGvBlVDotZUUdZKBm8p4LzN4K
         DQlYqB1DgsZqKX63DfWUjYaLmQQJOpKX8nTveCQaT23trBzrWevAXubvtKACRfXjPssx
         nPXp7rHUuGWKOBP86wHyAX7aMvHeyOu40NzEyQ2J5ctHygJK7Q/iXox3481w8aGd+fgi
         z4gw9VRikxgwoorJ2KscX857v09yyo/MUK+CC55zXB411rsMRtWI7Vs/xsK39UJRDB65
         kUGzyTt1Wp1mzE9S49sKC8irtXNB7PB5s/pDnvU7GevOkmx3bilmWkWsQa65/FcC0/qp
         yxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wH9LtqZdrV82uryQNvQG57KCdHT182AjVpniYypTn5s=;
        b=hGboJbP+g8QL1BlPkizsIIqHY2l026ycqp934hSdXYwsm2PgAJER0zio3uAKzo+1+Y
         r2EFU+lJ5UkFPwAFzC6U5mbkERzC3AiarxGNO9AD29/2e1Zpgx+FsqWVaNyd547e9txo
         w161TNHwZhS9KqpTEEvGuP2mOjY1o0uDnZUzMvkAvBPCcM0jZN+DfhFKxeWk1bEOeSDG
         ELF3L635T986tXDzf2qqHhToS0MWvcg+SP4di1V5Lcna2+C2QlSCOAP99HRozJUXMC0t
         ETXPgyUtWKljcdpICJqzCAfWc32+XA2Sx8mmq2DuLVhUhECHz64C7sEHyU07G+p1PWEO
         5k1Q==
X-Gm-Message-State: AOAM530znR2OJVb7Plu6K3aTogJt4fKcegeftA3uXkg0Q8QxFTe17Mog
        ltrpcBCXwSwDjwNjtHY7gBLfUA==
X-Google-Smtp-Source: ABdhPJyP52LdDjeTsjTDukmte0R2YcSNgj9ruhutJuuQT8j1AnFpiNXCNS+3tjtc2adP7M4NBPhhrw==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr36267424pjt.168.1620787860361;
        Tue, 11 May 2021 19:51:00 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t15sm1968672pja.51.2021.05.11.19.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 19:50:59 -0700 (PDT)
Subject: Re: [PATCH block-5.13] blk-iocost: fix weight updates of inner active
 iocgs
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, Dan Schatzberg <dschatzberg@fb.com>
References: <YJsxnLZV1MnBcqjj@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <204404df-1ef8-d31b-8d4b-21f77810b774@kernel.dk>
Date:   Tue, 11 May 2021 20:50:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJsxnLZV1MnBcqjj@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/11/21 7:38 PM, Tejun Heo wrote:
> When the weight of an active iocg is updated, weight_updated() is called
> which in turn calls __propagate_weights() to update the active and inuse
> weights so that the effective hierarchical weights are update accordingly.
> 
> The current implementation is incorrect for inner active nodes. For an
> active leaf iocg, inuse can be any value between 1 and active and the
> difference represents how much the iocg is donating. When weight is updated,
> as long as inuse is clamped between 1 and the new weight, we're alright and
> this is what __propagate_weights() currently implements.
> 
> However, that's not how an active inner node's inuse is set. An inner node's
> inuse is solely determined by the ratio between the sums of inuse's and
> active's of its children - ie. they're results of propagating the leaves'
> active and inuse weights upwards. __propagate_weights() incorrectly applies
> the same clamping as for a leaf when an active inner node's weight is
> updated. Consider a hierarchy which looks like the following with saturating
> workloads in AA and BB.
> 
>      R
>    /   \
>   A     B
>   |     |
>  AA     BB
> 
> 1. For both A and B, active=100, inuse=100, hwa=0.5, hwi=0.5.
> 
> 2. echo 200 > A/io.weight
> 
> 3. __propagate_weights() update A's active to 200 and leave inuse at 100 as
>    it's already between 1 and the new active, making A:active=200,
>    A:inuse=100. As R's active_sum is updated along with A's active,
>    A:hwa=2/3, B:hwa=1/3. However, because the inuses didn't change, the
>    hwi's remain unchanged at 0.5.
> 
> 4. The weight of A is now twice that of B but AA and BB still have the same
>    hwi of 0.5 and thus are doing the same amount of IOs.
> 
> Fix it by making __propgate_weights() always calculate the inuse of an
> active inner iocg based on the ratio of child_inuse_sum to child_active_sum.

Applied, thanks.

-- 
Jens Axboe

