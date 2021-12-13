Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389314735A2
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 21:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbhLMUMe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 15:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbhLMUMc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 15:12:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB215C061574;
        Mon, 13 Dec 2021 12:12:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so11982043plf.3;
        Mon, 13 Dec 2021 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QM1WAkY5YIMPrYMzabdIsY5OA29nkvFhJSOPtvU2Xn4=;
        b=dmuBtYLm45LtIGeASk99mFXcNTg3IU1OAEVj+ztZ16POfo065yspmzZYp719mjjwjR
         W8NJNmcZBk38GNTNM/cDIGma0Wm8NtPjieMM8s1OQYrM4p+ilUBBKIYurAoTR9hftGLe
         i+wxLVip4lH7GPDPDuyCra0FojnE2D6785Lmg51eCKZLbLJZsH40fICz4R2Yx0ObCqKT
         S9MVHxechiSnwyhE4psgBlm6yLjWq5dFftHBaq+vKEJJ1wbm8P7VSy92NKk5lJyfr77i
         I7CKJqHvT5Z7mmCyXz6wgQ9FwNBc88556xtvHGwNh7MMDjaXA3nC/zIpi/4VVy2oo9PB
         4DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QM1WAkY5YIMPrYMzabdIsY5OA29nkvFhJSOPtvU2Xn4=;
        b=DB7+QLnlyCPIRPatynlIzh/Rb6VYFmucMLb0yBNbzBMK05FUxsV73ip6Ky7qay5wm8
         /xi1G1mtn/lvcL7VbhHesOg8mJJij6VtTSXSkwA5XunxcOVpX25zKKmB5pY9VwktVaXr
         jgrM9ZoPz/YiMdECT7cqaU5FJYuOXbmxCQ/HLclYGIx/WsCoY79Ug8u5oaS3xwthMq8S
         Yg29cVqEqK4u0wdTfw3IWlomw0/1mqa3cbvD8PKKzlZw9+jLZQYGW3rZccTjWbSuPeMB
         IlzcpXX5pK8EGu35B+6sf4mDZH8Hac/8r8RkSbEHqrT95Acu8dIOy8jwoMDazGDYuYom
         QY/A==
X-Gm-Message-State: AOAM5331qj5NY41zGvVzVKOHjrVJ+nnP3eCwoBVqfzlAGdVihIbuDgzw
        rcqKe6QUPxzQAIy4nlRjQOU=
X-Google-Smtp-Source: ABdhPJy9pVM03aRu9kD/6g6YZvOcHmdrRriYJQfZePN0FUjaBVM9d9KZWndJfNeD1kZukAUdxNlDUA==
X-Received: by 2002:a17:903:4053:b0:143:6d84:984c with SMTP id n19-20020a170903405300b001436d84984cmr252087pla.37.1639426352196;
        Mon, 13 Dec 2021 12:12:32 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id w20sm13905482pfu.146.2021.12.13.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:12:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Dec 2021 10:12:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     QiuLaibin <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] blk-throttle: Set BIO_THROTTLED when bio has been
 throttled
Message-ID: <YbepLpyMPqP2ao3J@slm.duckdns.org>
References: <20211118131551.810931-1-qiulaibin@huawei.com>
 <YaUZExR6v8IdZUeM@slm.duckdns.org>
 <03964258-10ff-7f19-10cb-ca4eccf72848@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03964258-10ff-7f19-10cb-ca4eccf72848@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 13, 2021 at 05:24:00PM +0800, QiuLaibin wrote:
> > * This function is called synchronously on the issue path. The bio isn't
> >    seen by the queue and device driver yet and nothing can race to issue it
> >    before this function returns.
> > 
> 
> The bio is under throttle here, this submit_bio return directly. And
> current process will queue a dispatch work by
> throtl_schedule_pending_timer() to submit this bio before BIO_THROTTLED flag
> set. If the bio is completed quickly after the dispatch work is queued, UAF
> of bio will happen.

You are right, the timer can get to it. Can't it be solved by just
reordering spin_unlock and setting BIO_THROTTLED?

> > * Now we're not setting BIO_THROTTLED when we're taking a different return
> >    path through the out_unlock label and risks calling back into blk_throtl
> >    again on the same bio.
> > 
> 
> In my opinion, This flag can prevent the request from being throttled
> multiple times. If the request itself does not need to be throttled, the
> result of repeated entry will be the same.
> If necessary, I think we can use other methods to achieve this effect for
> request does not need to be throttled.

So that we don't change anything regarding this?

Thanks.

-- 
tejun
