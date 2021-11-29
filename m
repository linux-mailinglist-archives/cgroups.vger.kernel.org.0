Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57146224A
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 21:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhK2UlE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 15:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbhK2UjE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 15:39:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB435C09676A;
        Mon, 29 Nov 2021 09:12:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h24so13240043pjq.2;
        Mon, 29 Nov 2021 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iqv7qLF7uITwuXt3oWFITR3Bhp8jkUr/nLRX6jeUX60=;
        b=a/KS+rJo29zRyxgYOvHGrL87E6B0Jp7PSbf4q3c/bWycMj3+nFZUi+0XhTm3kpyFAP
         HY/nHWdT2dD7ii1e97qDpyUAcc1mREhYZIZi6kVEV0R1TZ/AEQBBMfufIMjyuKRcBWr5
         v3vFEw2cS6Ste1nsNiuin6pHy1Har2CYuWKvIpDljCU5dynoRivA3fGU++i+bUZ6Ic3H
         GEx7q7zVlIZN0y2iJlnbird+UjPoe8NiH4GwzWKpd2u5paTLgj5ZhnLlbSrAe1pVSDRs
         wu7fEOpCiYOI36yu7wSAdgcMY7PhgCmJiahM3bnwhwYng1wGYDzQnX6qRPSf0qDpDAAA
         Aiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=iqv7qLF7uITwuXt3oWFITR3Bhp8jkUr/nLRX6jeUX60=;
        b=24CfGOEkZQRBQMCClaR8dCM7XXkhMFlyOPuV9angr+gbvUyVhQOXIC7qSBhQVrNs5E
         wuivOd6hlhVjtt3nOKHbaAtQHY1CbJzphSbSe/xQV47FczBo0iOUo0h7LoZdDeBaTXP5
         hfAMwu9iO2eX+WrJ8a2c6Bk/cunDrwGNMu1pClCyhapM+a9WSSSoJozkKZZVmbgB0zfG
         rbkHLmTMupYnlPf+Jl9TOO0A41pqIv9V6A64+ftkrPXwxWwnoLWdeWsu3sJXPHXUk/f7
         UL6nrwWQZupcfRilYVgKO98OgsR4vm5oR/2fg1/jwx89fXA53+v63RRiNzojMhoQ0jkW
         P8IQ==
X-Gm-Message-State: AOAM532wgzQFlpFU48PwosNJfqzRYbASucHmKh3T4wx6T2u0x9LsMxuO
        5vLmX7HxAh5qD5AaNFeK6lb5pyM8Uge7WQ==
X-Google-Smtp-Source: ABdhPJxyga872tjXhXhVpv+Njn21q0CoRhk10IfH2+OI+GQZLSwcm+GODJ2/o+c1BB487FSEpS0dUg==
X-Received: by 2002:a17:90b:390f:: with SMTP id ob15mr40589872pjb.32.1638205964336;
        Mon, 29 Nov 2021 09:12:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nv17sm20997862pjb.55.2021.11.29.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 09:12:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 29 Nov 2021 07:12:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogdt@suse.de,
        cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <YaUKCoK39FlZK9m5@slm.duckdns.org>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126144724.GA31093@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 26, 2021 at 03:47:24PM +0100, Michal Koutný wrote:
> The question here is how long would stay the offlined blkcgs around if
> they were directly pinned upon the IO submission. If it's unbound, then
> reparenting makes more sense.

It should be fine to pin whatever's necessary while related IOs are in
flight and percpu_ref used for css refcnting isn't gonna make any noticeable
difference in terms of overhead.

Thanks.

-- 
tejun
