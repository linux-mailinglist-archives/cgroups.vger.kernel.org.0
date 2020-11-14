Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E022B2F8B
	for <lists+cgroups@lfdr.de>; Sat, 14 Nov 2020 19:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKNSRt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Nov 2020 13:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSRs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Nov 2020 13:17:48 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77228C0613D1
        for <cgroups@vger.kernel.org>; Sat, 14 Nov 2020 10:17:48 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j5so6056156plk.7
        for <cgroups@vger.kernel.org>; Sat, 14 Nov 2020 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i0e3E64zBwid1kl9TRb62r7Kg+IomqRl8tjiUk7Bh9c=;
        b=ar5yYtE92kZ+9hKIQlmSdM6HKuoBgt3Lu8f0HxdrUrOiHZqm2UzBum26yliHtmn1+r
         mxSVE6PlJr/itb28rrNlbHsB2BZInkJuTLUUzDMap0sizj7IZ88LVD7xHv3929rOBD/0
         FRV1WZgZotmwOyHRXExpS4gz3qif6if5xK3amwypNu/hNKL98W4eW+y9hFqTcW/N345X
         lsYxw9QiHSiMZWUepK03fL8kbrAor/JLE5zyGABb127CO8UI19U9Rs/QqII7w4fvc10N
         gM4AA85DRqKlvHu06SMj9QPliMHjIS/LH13uqlsK4shI9951+5EKiIPpx2HSVWr1FxCv
         65Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i0e3E64zBwid1kl9TRb62r7Kg+IomqRl8tjiUk7Bh9c=;
        b=s8UjQBpwR0PTgJBD1W5hYOc2m2XTFq9weoZvs2B/i78YWgFFXgl0rBpmHiEbyy021p
         QeHAbiuBHo8khakAX6Hvku2yk3apvZdSZTMA9gqYdBf4kNMAtKCH2N1LIUToZs98gGlR
         9RCEvbW/LvDu6irbuJ4fb9twkZyjfrhzFwxnGYQJhjM/dsDWaz9oxf6fB9evcXOLpSsR
         BOxA9VHCIlE2oqvyXjhgPRKlhejvbR0BpSmSQ+8FHwcPssVy4jpYE0Awl+69lL/8NQ7H
         b6Eg9IcifJedA3yi/CH0cMIW55jphz+G2LM3ETSO2MqhFt2vd33qpX5qj1gF/HeLvrXd
         o69Q==
X-Gm-Message-State: AOAM530twYhzeYTSUmz9V6Ln8FUoswV/XOXtbWDcQQ4yaHXW8qIXvGms
        jNXMeSQEysbwN/OD39wqcB/zFg==
X-Google-Smtp-Source: ABdhPJxdiozu1knCYASESveHYO4oSpGkq0H4nlByReLIuPAxWDkMxmBDoW1Jiylj6bOobSCuT3wbuQ==
X-Received: by 2002:a17:902:8691:b029:d7:e0f9:b1b with SMTP id g17-20020a1709028691b02900d7e0f90b1bmr6834076plo.37.1605377867947;
        Sat, 14 Nov 2020 10:17:47 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p4sm13819649pjo.6.2020.11.14.10.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 10:17:47 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: fix a hd_struct leak in
 blkcg_fill_root_iostats
To:     Christoph Hellwig <hch@lst.de>, tj@kernel.org
Cc:     boris@bur.io, cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20201114181246.107007-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3dd068d9-8dd6-ea2f-e600-f8007516cd1d@kernel.dk>
Date:   Sat, 14 Nov 2020 11:17:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201114181246.107007-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/14/20 11:12 AM, Christoph Hellwig wrote:
> disk_get_part needs to be paired with a disk_put_part.

Applied, thanks.

-- 
Jens Axboe

