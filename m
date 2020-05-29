Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF21E8B5F
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2020 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgE2Wb1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 May 2020 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgE2Wb1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 May 2020 18:31:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E46C03E969
        for <cgroups@vger.kernel.org>; Fri, 29 May 2020 15:31:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so1152891pje.4
        for <cgroups@vger.kernel.org>; Fri, 29 May 2020 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qjRinKG47cv+WRJraubcFr3U+Lvq7r9h5cI3It3kttE=;
        b=UfpPyJERqsDe0JeKh9kSCBp1UTomNGawgMihS00FGfwEgSzyJ5mY48/zDioK7R+d15
         Ishc4RUMdsNXqZ49Vsh3SO4RypCg+aIGZEGAIkCehakLilDYiaghS0LnbRpBlkinlq4t
         ZoOYxy1+qkq2efTePIweOqdQVcHT9vZ6T0VHB7AaNEB/hir1hZEpAvQywakJyiK0ZfiG
         JbYT8CAfVcy3FMa4KSAKsvO8K9ZQqpMu9m/TABzjE7Dkk+cwLqVCRjbl6TPQCEtf6S20
         RGxElV0oXP9F6ZuvnT08yozs+NAl5Rjh4ZPylzE0ao5Kn27kLcZS6VhfeDkpH2fDpPdo
         Hdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjRinKG47cv+WRJraubcFr3U+Lvq7r9h5cI3It3kttE=;
        b=pLSxRlVRs36u1jkBIAJIGG1FsXQ2RwkY+Qo4wEmnS/i2fD0MisSPBIBfhErUHxALDJ
         z9u9JYeioMnTR3n39NZNNMTV+bxcRub34I6TVVttf9xVULaIketCzBKQrTicPTbWESwb
         5b4zVBo/QiF/uMwsqei2ppxjD66z4Fmn/k2qqZ/t/EA5Jl/7aoEez0RDNPqcHHfsXXIY
         q1EM9f6rvVtuA6YSkElZ9rIuDHaDCLzwJAp/Zd20fisX9rIZE6qC3LmCfC7VnbRfbg0r
         89BW8Xja3x0wSQhLxv0OVp0KaBaOicd7fF/tiHV/iHjc8AcdtooKNYXWVyFkiT5U/Xf2
         iSig==
X-Gm-Message-State: AOAM531Fs56w4MM3Neyt7U20GmlgcUFtfdQ9BVy9AEORQOlDrit4j6kY
        HeB3eGsYwIqQm9+Tk4yDYx0nrg==
X-Google-Smtp-Source: ABdhPJx+LDltheLujHCj6OjRNHFrDJs2kyFM5F0DpaJNY7XAidtunKk7hpeBbIqw3CYI2WKBpkIkJw==
X-Received: by 2002:a17:902:7618:: with SMTP id k24mr10843832pll.167.1590791486481;
        Fri, 29 May 2020 15:31:26 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b5sm349612pju.50.2020.05.29.15.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 15:31:25 -0700 (PDT)
Subject: Re: [PATCH 0/4] cleanup for blk-wbt and blk-throttle
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97c85845-e678-e9f3-87e3-7cd9d5b66d17@kernel.dk>
Date:   Fri, 29 May 2020 16:31:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/8/20 4:00 PM, Guoqing Jiang wrote:
> Hi,
> 
> Find some functions can be removed since there is no caller of them when
> read the code.
> 
> Thanks,
> Guoqing   
> 
> Guoqing Jiang (4):
>   blk-throttle: remove blk_throtl_drain
>   blk-throttle: remove tg_drain_bios
>   blk-wbt: remove wbt_update_limits
>   blk-wbt: rename __wbt_update_limits to wbt_update_limits
> 
>  block/blk-throttle.c | 63 --------------------------------------------
>  block/blk-wbt.c      | 16 +++--------
>  block/blk-wbt.h      |  4 ---
>  block/blk.h          |  2 --
>  4 files changed, 4 insertions(+), 81 deletions(-)

Thanks applied, missed this originally. Nice diffstat!

-- 
Jens Axboe

