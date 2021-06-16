Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C72E3AA26C
	for <lists+cgroups@lfdr.de>; Wed, 16 Jun 2021 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFPRfE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Jun 2021 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRfD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Jun 2021 13:35:03 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00852C06175F
        for <cgroups@vger.kernel.org>; Wed, 16 Jun 2021 10:32:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso3272468otu.10
        for <cgroups@vger.kernel.org>; Wed, 16 Jun 2021 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q4gumIsyYAtBcDgBeiPSNtfPvFXvXc8mQGPj94mk7tU=;
        b=0/gByeCCO+jtXT10f358SOv5CX5VuTpPTBsWh15TdpdH0EE81yE6LKrzfDHqsQ31F8
         8Ob01KNdVt+lfSVo4nxcsYFLS6pUMbxntpBCXeA8bpdkhIp5cLJUD/RMwbCGAQxF0S4r
         PJMlL6XrLaBSt42KfMHRD/GEctTRbB7jhZPXRvqDB/uiyVRuLjyGP7ZTfzAl+/WwhPlr
         6x4K6G3tLrXQitckLUrzCMz3DyDi969BG2OHS0T0228CY3yEYX+s8cJWd85mbH7ZFA24
         wwtRvg0KMv4U8qg1mtfBjpEb7WryqWrVQJiRWk6BwOEO0i8rwY8VOaqnrBar84A7Kano
         /Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4gumIsyYAtBcDgBeiPSNtfPvFXvXc8mQGPj94mk7tU=;
        b=YpjyfKwO5/2NjWx9WJpDEXN947TWT/cduEpFEGSQ3jPo9R4Wyh8dujN6u9wBv541WT
         tktAP2eSgxZc+ujM9AfW7iyRPgjkfw/Fu8sIP6TzJ/wWQ4tVS9XT9yMEg0FMO5Nt39a0
         RQDboqgkj3vrwkutFX0PE6FjS1mkB1mzfSSD9GNR4kqSzp3ff9QfcJIURZXs64tE65m5
         rjm+RDDOiDhxZCh8Ib1pBUEB89CH67lPBFgh8ljT5o3iRCaki3nKKR3tZ5xS9EVdhpRX
         DViqKMFUhtpyBZ8oByptkLVRaatebk8SKKjZd2I/CEWMpxC7CH5f71WlU2HifU1CmpKe
         PUqg==
X-Gm-Message-State: AOAM533xGiWETq62dUaZ9aIghS2ysRKYGs4Ue+N1wJHmrAveljgd1mbE
        JR9kYCEKmwpamfe9EjXYtSzEF8HAa8F/NQ==
X-Google-Smtp-Source: ABdhPJwT3egGMHgPimidPdpu6xRLpuEcZUz6jCESt+aYA71rNUIpwBGV1tEHoan34PYS0dkH4sEB4g==
X-Received: by 2002:a9d:7acc:: with SMTP id m12mr911229otn.27.1623864770076;
        Wed, 16 Jun 2021 10:32:50 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id 26sm627828ooy.46.2021.06.16.10.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 10:32:49 -0700 (PDT)
Subject: Re: [PATCH 0/3] add/update/fix BFQ docs
To:     Kir Kolyshkin <kolyshkin@gmail.com>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, tj@kernel.org,
        paolo.valente@linaro.org, cgroups@vger.kernel.org
References: <20210611030737.1984343-1-kolyshkin@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <40174fe2-ef72-99bd-2c75-5f00641f064b@kernel.dk>
Date:   Wed, 16 Jun 2021 11:32:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210611030737.1984343-1-kolyshkin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/10/21 9:07 PM, Kir Kolyshkin wrote:
> Improve BFQ docs: fix formatting, adding a missing piece.
> 
> Fix cgroup v1 blkio docs which are not updated for CFQ -> BFQ.
> 
> Patches are on top of the latest docs-next (commit acda97acb2e98c97895).

Applied, thanks.

-- 
Jens Axboe

