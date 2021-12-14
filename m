Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426C474402
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhLNN6Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhLNN6X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 08:58:23 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9DEC061574
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 05:58:22 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id s11so17557803ilv.3
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=IeJEDuwrHuRaa+Ik/SvG/4JB6lqbm2wKrnNt11uuG4A=;
        b=wMb1zuONQwHdeid8S1mJv4yX2A2Yx3Z/jQ3x4ORQDBB7GS1EzW2Fmb33wZTbX8v2H7
         vlHWBrKTa1fuyiHpwFLEwGL4ByT9HaNvQNinFzQlphTwm/GTRuFGTP0nZEtPedwOJC4s
         AlTZTc01fPcj+twJQ5FmKV0qBKTeGPyCVEg46rJ3Whua4tLY2av7mihgHt/8RyrQ5C4Z
         nGeM3Pqadn4UvSal3UTyBkY+8qXs4RVhEnku3LPJfF52pbvKyzkPKLTYmTMnauD+asfC
         vzeOe7HKQJIacSFtyKrCc9WWAzxumDw5Ad4/u9iklppC9Fv5nJ398Igz/W1wjr8iUdbT
         5joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=IeJEDuwrHuRaa+Ik/SvG/4JB6lqbm2wKrnNt11uuG4A=;
        b=CZx25GYJpbOsfD9YuKYFJmgRLPz9a1Frr3kWMJ8Sy2QQKHl1QN/5lfwtkiSUEEts8S
         DHw564Tn3UScQKthHnqVqQANvaONhQfHjfsqB7rkKaNpKVKVL3jOengh3Q/1zQeBChkg
         8JyKwsEqvO/tqq5IveT1+Fc9xzLNCrTZrNl/CGDG+JnTpXLmtfGahi7r23wSOfhWi6/B
         azEysvsEM/qeF/uZdrdu9qWwN5vCe3wmozsf2R1f97MUjPnx5WO87dI9Qet7qmtYEdAN
         IuWTqz/i4TnaZxc356YoASnrcawzYTQg/i8GhW410fKVbM+VcIUD9/fJzXFnoPoBtmX8
         npGw==
X-Gm-Message-State: AOAM532XSiqCMmByXUtJJWwiFASAwIdnv6ir8o+7SkZEuRW02txtnTSl
        HVahoZMaqvKsV/duzaZwgi7bAQ==
X-Google-Smtp-Source: ABdhPJzS0xykloyo4HnzZbLCGjWJWacfLqAlkteSfczA+XZFmqRhXAa8qf2/F3kXzIhTSCgWu/URgQ==
X-Received: by 2002:a05:6e02:1789:: with SMTP id y9mr3400069ilu.321.1639490302145;
        Tue, 14 Dec 2021 05:58:22 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q8sm9533638iow.47.2021.12.14.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:58:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
In-Reply-To: <Ybfh86iSvpWKxhVM@slm.duckdns.org>
References: <Ybfh86iSvpWKxhVM@slm.duckdns.org>
Subject: Re: [PATCH for-5.16/block] iocost: Fix divide-by-zero on donation from low hweight cgroup
Message-Id: <163949030003.173863.14081933851643062205.b4-ty@kernel.dk>
Date:   Tue, 14 Dec 2021 06:58:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 13 Dec 2021 14:14:43 -1000, Tejun Heo wrote:
> The donation calculation logic assumes that the donor has non-zero
> after-donation hweight, so the lowest active hweight a donating cgroup can
> have is 2 so that it can donate 1 while keeping the other 1 for itself.
> Earlier, we only donated from cgroups with sizable surpluses so this
> condition was always true. However, with the precise donation algorithm
> implemented, f1de2439ec43 ("blk-iocost: revamp donation amount
> determination") made the donation amount calculation exact enabling even low
> hweight cgroups to donate.
> 
> [...]

Applied, thanks!

[1/1] iocost: Fix divide-by-zero on donation from low hweight cgroup
      commit: edaa26334c117a584add6053f48d63a988d25a6e

Best regards,
-- 
Jens Axboe


