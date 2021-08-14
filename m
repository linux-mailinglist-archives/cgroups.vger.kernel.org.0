Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11C83EC60D
	for <lists+cgroups@lfdr.de>; Sun, 15 Aug 2021 01:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhHNXxk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Aug 2021 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhHNXxk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Aug 2021 19:53:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ED7C061764;
        Sat, 14 Aug 2021 16:53:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n5so423115pjt.4;
        Sat, 14 Aug 2021 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ieV+NzFBwSkcV+dUMdH1Zwl99MJbYbRKj6zgzR3HYo8=;
        b=fw2wAsjVNzwOXlztdlYhKMmryILu560cBP1n1eH1E7aNbT75pBui01fq4RdxbFfy6O
         4X+hk8Du9XGkpszCNLHSaKIRL85MFDBDOmB6WRixaLMNPxFEmhI+cwExRoiOjkktHPzy
         qKRgf/J15GqAlMmi8/MFo8IPGgj3JCnjLeYCTcRL5gQ1Z9LY04wKApcl0jTRTEoXU3Vp
         L0R2iWJmAgY3BW+sJ3U4F50kIuWE5Odxw2XOdyY5ekowFJV/VCS5CFmTdLnpeQUP1lZ8
         zkkPoBsy6LTuWu6ByZrUMPxsEJmPSBUIiKNkFtPbABERuOFVHpngZ52xDrmn2F0lu4r/
         UDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ieV+NzFBwSkcV+dUMdH1Zwl99MJbYbRKj6zgzR3HYo8=;
        b=YUhUFl8jK1J42HFcMEqbpSpNGzU0/rv/MWIPJckSE4odCJ3pubygdaivvyZ4GX4s2P
         keUiSNvpkahoCGqxymXvIqoRr2eAraIGkyZfTiXhIfj6AMDtEc11xnYNb6lDuIO2Lcva
         zFE5K+asS7YbH389SFsgRV+IosCQ98N7BXTQelSknfY+fMSHq2iwPZEDfWi+tb8GrhhH
         Lt0Mvg0JnLeCAm7kk6QTv6+fWx5qjXLjjiZc5I/ZQW3Uj+mkpy5A3C8xlIWtuRYcuXQ/
         7pFDlUJcua8LoU3pD6T8lH/rqorJraqz63k/qNvCU0aITOhq3A+amt8AFTnPVCiCGDsT
         zrbg==
X-Gm-Message-State: AOAM531fGddN2m2Fsjoze+1E7bFI8wATwUm+5vwknn5iOwUVAYf6+eC/
        6cHasJ3dp3loogeO04O98kQ=
X-Google-Smtp-Source: ABdhPJzi7PWieEMc/eyz+VFweMge+uC+jyrMu5EICWwignPRXHUbiwHQ9je+q4eX4SVG9F/8twbhCw==
X-Received: by 2002:a17:90a:7aca:: with SMTP id b10mr9241895pjl.172.1628985190829;
        Sat, 14 Aug 2021 16:53:10 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id w5sm1272085pgp.79.2021.08.14.16.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 16:53:09 -0700 (PDT)
Subject: Re: [PATCH v3] blk-throtl: optimize IOPS throttle for large IO
 scenarios
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <65869aaad05475797d63b4c3fed4f529febe3c26.1627876014.git.brookxu@tencent.com>
 <YRGumHUfK5sJc4A/@mtj.duckdns.org>
From:   "brookxu.cn" <brookxu.cn@gmail.com>
Message-ID: <98864178-cf4d-b86e-81e1-70713a0f1d06@gmail.com>
Date:   Sun, 15 Aug 2021 07:53:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRGumHUfK5sJc4A/@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jens:

Should we apply this patch for new and older kernel ?

Thanks.

On 2021/8/10 6:39 AM, Tejun Heo wrote:
> On Mon, Aug 02, 2021 at 11:51:56AM +0800, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> After patch 54efd50 (block: make generic_make_request handle
>> arbitrarily sized bios), the IO through io-throttle may be larger,
>> and these IOs may be further split into more small IOs. However,
>> IOPS throttle does not seem to be aware of this change, which
>> makes the calculation of IOPS of large IOs incomplete, resulting
>> in disk-side IOPS that does not meet expectations. Maybe we should
>> fix this problem.
>>
>> We can reproduce it by set max_sectors_kb of disk to 128, set
>> blkio.write_iops_throttle to 100, run a dd instance inside blkio
>> and use iostat to watch IOPS:
>>
>> dd if=/dev/zero of=/dev/sdb bs=1M count=1000 oflag=direct
>>
>> As a result, without this change the average IOPS is 1995, with
>> this change the IOPS is 98.
>>
>> v3: Optimize the use of atomic variables.
>> v2: Use atomic variables to solve synchronization problems.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.
>
