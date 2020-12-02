Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5782CC64F
	for <lists+cgroups@lfdr.de>; Wed,  2 Dec 2020 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgLBTLv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Dec 2020 14:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387739AbgLBTLu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Dec 2020 14:11:50 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50EDC0613CF;
        Wed,  2 Dec 2020 11:11:10 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z188so2318816qke.9;
        Wed, 02 Dec 2020 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5D6PtLHVVQdV/ubjkOzdJ2GbL8TD6flP6rlB6RAW04=;
        b=cuyop+6GEYsJfkfCvrlT56PR6leruYXY5xPg4Fdmi14/OZPEhEcIUgeCsS0pTNj7Eh
         jzkIP1A/NrdAr19D53DRdBUsnOAOhlNewUybMARKFcP77devwmFS1CqYYaN7HC4m0lgi
         DFbVKFSeopvdwV5JccZt++HutFbOhhiVtFp3yMOsECMbScMuv1/v1XE6VDoPwzjAowuL
         75XHn4iGJsiobXi24yrPTzCNOk/Mzrp+2cWJ1wW0OBGhuX7sTcpU6W/a++z4rZypJnV5
         xWMyeP1DfqXvkJB4MZcZsY3WyzipNR0PEe7As0InJw/dJbEJ4S8+5F1Az9sEW9b7Vrnl
         Cwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=v5D6PtLHVVQdV/ubjkOzdJ2GbL8TD6flP6rlB6RAW04=;
        b=SWKH8gIAhDKovQ1+rWQaagnHk19acKM0NS1KfMjdhsqWczFJuv7bFIbeaR8GQu6okS
         qP2JseA0HKZLnaepv/qbxF0Rth24RyJTaatznHQHP1Qg8bi+KHDQg9l9G0MnIpxPlt0p
         ifC+f0j4OhgO1dOTlVl/UCuRacWKdneaS0bM9IARbvVuK4+38o/V8LWQPU7dHSEOaho6
         8bMGwM5tnKPPP/0kgpqRRzo+mVH47AuAd0wd3NUxsgMibQa9ohHqYg3KEMRncdfl59+z
         kO7CBn2LPqG3s6CDq1qfaFAoxeaNR7mXwdBqdnp9SI0U2bD2o2ht9hwhjGNS6QZcZRSB
         +53Q==
X-Gm-Message-State: AOAM530q9igWMPpqf3YpPPYMvqrdcqNl0qUvdv9u/abjjQ4Os8+TjJDN
        qPtXzgDC6yamOpaPOK8p03A=
X-Google-Smtp-Source: ABdhPJx6BRmRG4jxLpniauDUiQDUhRNB10J7uytRnFSA19h8R3Y8QAwNfA1bUo95Ef1gyghUhGvgKQ==
X-Received: by 2002:a37:9c82:: with SMTP id f124mr4221666qke.314.1606936269763;
        Wed, 02 Dec 2020 11:11:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id b4sm1765150qtb.33.2020.12.02.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:11:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 14:10:41 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] blk-throttle: don't check whether or not lower limit is
 valid if CONFIG_BLK_DEV_THROTTLING_LOW is off
Message-ID: <X8fmsbgvajlCvvLD@mtj.duckdns.org>
References: <20201126031834.40807-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126031834.40807-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 26, 2020 at 11:18:34AM +0800, Yu Kuai wrote:
> blk_throtl_update_limit_valid() will search for descendants to see if
> 'LIMIT_LOW' of bps/iops and READ/WRITE is nonzero. However, they're always
> zero if CONFIG_BLK_DEV_THROTTLING_LOW is not set, furthermore, a lot of
> time will be wasted to iterate descendants.
> 
> Thus do nothing in blk_throtl_update_limit_valid() in such situation.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
