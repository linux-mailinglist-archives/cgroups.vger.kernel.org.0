Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6709D287593
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgJHOCJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Oct 2020 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgJHOCJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Oct 2020 10:02:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D780C0613D2
        for <cgroups@vger.kernel.org>; Thu,  8 Oct 2020 07:02:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 67so6249247iob.8
        for <cgroups@vger.kernel.org>; Thu, 08 Oct 2020 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+v0FBMBQHdikeISvOs9/H6RdJVjsvgJipGvlxdEATrw=;
        b=OtjKLWoNFnJwBG+iIBsnfGAFJ4zdt7leYN6+IZMnSqbHnvoXh5fOLZV1t5S4zHKUK+
         KlLNhwQDcsdOJ+V6LCgAsTRNBvCb+hz8mhghFlo0yiw4O2KRm4ZtDM9yfQnRV0uSBSer
         C9/7OPQObbekrl9Gh4aVoZUyL5YHShCtmwpHSrZO3WnByHNC2KioGmRAmwwGQnvmB2VT
         zZjChPKRCnH8sXBxdxwX+sVzpfg5961ZI6KZIqRSaKXhs2v0NxRWX9XSl4VdF3M1eOP6
         09lAFvYNw26lHxgYb/xSqunH/NmCfM9e73cUCb7zv4dadb8bBohqNr3EeFusZoM46jjQ
         DEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+v0FBMBQHdikeISvOs9/H6RdJVjsvgJipGvlxdEATrw=;
        b=Y4PDgX/oVWxtFVVj51qv7GdcAdwIWo7l9hQsBvr13SURjhJ8ppK7K6gmX8/rp8Qhwy
         Ja8/kaI8DmlZd5arSc9sED+usewANtwgK7xXtm/Xr1XJeZSbQmA9pTQKRgeLUHoAkdfc
         9rqdBnrSiitZ6qMiuC8is58aFXQwg23Y+tUWVIzjmBpH56jwbkR80dMd9kaGUtaytd+p
         nJrcFAs5Ety6cEgP8ITqHZ0i+BB/ZIz6EBteIA1f5ziMQJWTNPh8zjxrinnojriSGwsD
         XSS67ftcawdpDHerm3GN1J5ZNHOe37/c6GJ7GiSnCXNuFlIfHXR0uQtfJaOpNA++8r+9
         cmzQ==
X-Gm-Message-State: AOAM532MJ006HdBk4VNSRMcOEKm1/EBZrRYrDa3CKL0lYVWUPBDw/C+o
        Sk5gjxZLQtsxs5lh8b4BwVijBQ==
X-Google-Smtp-Source: ABdhPJy/LL8lIwlhJyCrinad2Oa+KhO+WtX+sKYdSYwFbXtVAptuvPI1GFZpqt98YjTtzz2k0dg+Lg==
X-Received: by 2002:a02:82c8:: with SMTP id u8mr6948237jag.61.1602165727444;
        Thu, 08 Oct 2020 07:02:07 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l4sm2695327ilk.14.2020.10.08.07.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:02:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] Some improvements for blk throttle
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b54c6741-10dc-2768-bc37-f1965672f039@kernel.dk>
Date:   Thu, 8 Oct 2020 08:02:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/7/20 9:52 PM, Baolin Wang wrote:
> Hi,
> 
> This patch set did some improvements for blk throttle, please
> help to review. Thanks.
> 
> Changes from v1:
>  - Add another 4 new patches in this patch set.
> 
> Baolin Wang (8):
>   blk-throttle: Remove a meaningless parameter for
>     throtl_downgrade_state()
>   blk-throttle: Avoid getting the current time if tg->last_finish_time
>     is 0
>   blk-throttle: Avoid tracking latency if low limit is invalid
>   blk-throttle: Fix IO hang for a corner case
>   blk-throttle: Move the list operation after list validation
>   blk-throttle: Move service tree validation out of the
>     throtl_rb_first()
>   blk-throttle: Open code __throtl_de/enqueue_tg()
>   blk-throttle: Re-use the throtl_set_slice_end()
> 
>  block/blk-throttle.c | 69 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 34 deletions(-)

LGTM, applied, thanks.

-- 
Jens Axboe

