Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43374264933
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgIJP5v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgIJP5H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 11:57:07 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F8AC061757
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 08:56:59 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id u126so7594110iod.12
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=bITux9EFWpfNdlM5j2+5LAzN74905Ih29yvwShF2RYD0rdrq4WVzARSbVJuvSmQPWY
         j+to5gM/LtwviynJuV6Xw/wsJke0MBYGFTvqAsfHMn62ENDQNHKZLFd0IqeGy/YXQAkv
         VzQea9i8kja5dzDE6N1RmEiA7mq7G6VZefYJanQOq9PYYyXW+7SVTKtT7DLY3JQQ6Yaf
         +LznXIrys7f2IeFYvBnmS1Ki0TO452S54+EFTgcsHoySCF2Om2MslpGe1shaUybTvJ4Z
         NYXD4pbGxmghN4rFbQnUMh+SSZHjhXFnidMaDDjLyfrIe/7fFBBzJAix6vpXnIjh1sFh
         cB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=hGEiECX5MiKtSCGYe+QLS9sdI6c1yVUB8lbgFFK/aJkH1spREzFEQmEoAi709vMhgd
         8s8ABi0T2hgJrp0aEOx596AswTXds3KUV1KKJjgPFwgc+NWD103lvPURpoiiaQyWGpqp
         gTYJr3aQ/zF5TgCaIxPUa/1WcNdinVuwXzBUwUhtiLLRcmdLICSOxCKJzdjpCtlZ3pQC
         BGH1b4GttzqHe/928kVeMeIGpvHsN+6GnRW76q1sMK6PXI9qYBtwoms3sEVRR6Vkvho1
         Th+BTixsGRzE4YXnvSUxQ15VOML+Ngh2I4PouKez8nzKyJgZv03xo5EnNGwvNb65d7iO
         n3Sw==
X-Gm-Message-State: AOAM531PrvRSRTHs2tBtL9/Nktkd9KVlGNNU7K9F+WXH3b43Y1MpLlQw
        KoZQ1pgmGgjX5UmfeXqnpPvR4g==
X-Google-Smtp-Source: ABdhPJwLFvlr74/NHaaMQeIpR+L/bjIZVmaEteWtsH6Bm9x6kvp/ngajFsz8dvwqEASUe60lfJ+Ljw==
X-Received: by 2002:a05:6638:1448:: with SMTP id l8mr9177707jad.83.1599753418617;
        Thu, 10 Sep 2020 08:56:58 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m12sm3225470ilg.55.2020.09.10.08.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:56:58 -0700 (PDT)
Subject: Re: [PATCH] [v2] blkcg: add plugging support for punt bio
To:     Xianting Tian <tian.xianting@h3c.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200910061506.45704-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2bf5a5c3-1f1f-6ed1-8871-6e9d3e7b80d4@kernel.dk>
Date:   Thu, 10 Sep 2020 09:56:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910061506.45704-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

