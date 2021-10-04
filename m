Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75342144B
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhJDQmF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbhJDQmF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 12:42:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D2C061745
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 09:40:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h3so6450906pgb.7
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=augfsTXb1EqvWcbD8kMG8Mmo1E+4/qJhNfszNseO99c=;
        b=hsSNN+UJ6NnGshSkpom3FjtmdE+DbH8x9DAgnM1PuqqlMQrpzGIdTtoIPKr940w9Nr
         PcEtV+ka2MnEV19RdJ4Hhn4xvp4EI1ggXEKh0vKP/V48uTCf4Ybg6OcsE3Jad5ViaBQw
         7Zpdw7pd+PrAIct7CcloJQnlX4sE9JMGM3Th1ZdhDNqdxXkxUgbHY2pTWHI/HB56GpeE
         sUg0X0NwLREDGoaflyojm8yN6hrwpmzOWsX8HvKK9QEvhOy9PCQgNDFw79mFbLaCaBlB
         fSeUWa6jYdveegPdcucCE9C2YoWT6cExHjsq4czsR40QDqO3sJxXYzkxj3UYMDH1ip5Q
         7V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=augfsTXb1EqvWcbD8kMG8Mmo1E+4/qJhNfszNseO99c=;
        b=74f7Fj91zVZHhdgjPSyKoT2HWZz6GM+hX/71rG7HpmzLSQ4U/zJsWsJfs1oC6L4wA5
         AurBk1IFqP5AkHR4s7p70tlPBICNJOzy4KeJeCYNhtFCFcntSbW10G9NSFfTzqqT9Q4B
         rH7h46+2nA4Zvq7hJ80hrEul79yWBpfoqM03AiF5bAqU6NUX1a6+BWJ+pca/cIj/r+jK
         1gvgvEEQr62DXdGqvD4iCNiEVft+M+XY6oY5OeOOIcbjQIwgiNPc1dWnUTbAY31kY0rO
         VLqMYoNofauSa82O7z5Bkl+xdzCwlq6e/UTpJeLKFqaC42L4tlBAbs6riUYwJyHDrxhi
         a1Tw==
X-Gm-Message-State: AOAM530L+N8FLRhw/6NYopOzDFFetc2vlzVBpdOQ5cvbR77b+mBCTElB
        kqROFTpjT4cad/u4zmqsGfs=
X-Google-Smtp-Source: ABdhPJzYsn/B14xsBlk5FdFDPPCfQVYGtyKeyIBxLE5JHPQTntGfTCL+0J0eKQrKIDMatLMkZSzHXw==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr11679715pgv.370.1633365615392;
        Mon, 04 Oct 2021 09:40:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o16sm14584921pgv.29.2021.10.04.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:40:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Oct 2021 06:40:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Odin Hultgren van der Horst <odin@digitalgarden.no>
Cc:     cgroups@vger.kernel.org
Subject: Re: [Question] io cgroup subsystem threaded support
Message-ID: <YVsubc0I4tBmnudM@slm.duckdns.org>
References: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 01, 2021 at 01:06:45PM +0200, Odin Hultgren van der Horst wrote:
> Posted to both cgroups and linux-block
> 
> Hi i read though some of the source code for cgroups, and from my understanding
> the io cgroup subsystem does not support threaded cgroups. So i had some questions
> regarding this.
> 
>  - Is there any future plans for supporting threaded?

Not at the moment.

>  - What are the main hurdles in adding threaded support to the io cgroup subsystem?

The biggest is the fact that page cache pagse are owned by processes not
threads. A related issue is that writeback tracks ownership per inode with a
mechanism for transferring ownership when majority writer changes. Splitting
IO control per-thread would increase friction there. So, the summary is that
the kernel doesn't track related resource consumptions at thread
granularity.

Thanks.

-- 
tejun
