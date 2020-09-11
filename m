Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85612267613
	for <lists+cgroups@lfdr.de>; Sat, 12 Sep 2020 00:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgIKWnb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 18:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgIKWnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 18:43:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB59BC0613ED
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 15:43:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so8380984pfa.10
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V4dnIXk3uASFKmAsRylpgs6PaxAQ2I8kA/uiE395NMo=;
        b=xKBpO0c7GRfYDlEvLIcuNo7cRQKOSRBWiJnlgrExH6GawCClKntMGl+YgUGmo44diD
         hVelwgwdl8uGB6WpaSdNINPmC+FAW+U5a8iu9cXUDZ64bb7PgTxsVdn0EVVo5jzk8sTL
         p0ethGOksPgsdk/nQTW+OAR+zST8OuXiaWDh856pqqP+RQsPxz/U2veX7DhRRRUDpikB
         2fmlhmtzOOSamIyWoTaqagyl76oQZuf5XRaDm/gsI3gppuiS5MvVp4YHjMRpBEOlTw4k
         +DEkeaQNS2WeLJ6OLV9t1UFRRxPRfSv6ZFwnnulpSP8Yy3TOCl+kyeJLFvQUXrKrFfae
         d78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4dnIXk3uASFKmAsRylpgs6PaxAQ2I8kA/uiE395NMo=;
        b=E8lB01Eezg+KsvQ6LogMwWa19eUeVbeMfYeVqGF1bfgu8ZyXOfnfA7ROpnIdVFFX9l
         V8FoH2pRBujVLusVfGCDRbUjkgo0Dwk9ByhYbufjU2ZHZ3Gos+DLUQtdjYvlSVv14uAA
         H5V4wD3WWbzptOwDv6aWeXO7cdrBesYDX8fEep6XVjNAlKxJrCN3W9XT5XcfWvAGcvma
         tbeWI355Rx1dmjNu7iR+3p6JDD/DxHy09hz/T63Ie5i/zDYt8Id3zfmA0pCIyc981n9Q
         JK9F15ETHip0VqhSqJtpewYiDD6GA9dU9aHgZWzEVVZpkznYfNkXT9w2L4vgeM0YOKCv
         tr+Q==
X-Gm-Message-State: AOAM531nu0rbLaqHK8zrfjmR55RGaqw+5eUu5CyOB4CzWyIGlO04Wsyh
        3Z3rspfguh3ZccM9O/pr8XGSMy8HddJ6HHrY
X-Google-Smtp-Source: ABdhPJyFM5VCvQ9wgag86nKFAph92fcH4OJjuMFJOFcQihZDKQd0xTwdWGH6BphZfULMmmBWq14Cbg==
X-Received: by 2002:a63:2250:: with SMTP id t16mr3185165pgm.303.1599864202018;
        Fri, 11 Sep 2020 15:43:22 -0700 (PDT)
Received: from ?IPv6:2600:380:4955:1abc:b8c:928e:5fe6:fb78? ([2600:380:4955:1abc:b8c:928e:5fe6:fb78])
        by smtp.gmail.com with ESMTPSA id l7sm2500221pjz.56.2020.09.11.15.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:43:21 -0700 (PDT)
Subject: Re: [PATCH v2 block/for-next] blk-iocost: fix divide-by-zero in
 transfer_surpluses()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20200911170746.GG4295@mtj.thefacebook.com>
 <ff46ca79-433e-3279-a8eb-35156639be7b@kernel.dk>
 <20200911224049.GA865564@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59987f54-47fc-766f-0667-5a90daca0b1a@kernel.dk>
Date:   Fri, 11 Sep 2020 16:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911224049.GA865564@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/11/20 4:40 PM, Tejun Heo wrote:
> Conceptually, root_iocg->hweight_donating must be less than WEIGHT_ONE but
> all hweight calculations round up and thus it may end up >= WEIGHT_ONE
> triggering divide-by-zero and other issues. Bound the value to avoid
> surprises.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: e08d02aa5fc9 ("blk-iocost: implement Andy's method for donation weight updates")
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Jens, I was flipping between doing max_t(, 1) over the whole divider and
> doing min_t(, WEIGHT_ONE - 1) for hweight_donating. I thought that I as
> testing after the last change but it obviously wasn't and the previous patch
> doesn't compile due to missing type argument. Can you please apply this
> patch instead? I can send an incremental patch if that'd be better. My
> apologies.

Sure, I replaced it. BTW, you had two signed-off-by's in there.

-- 
Jens Axboe

