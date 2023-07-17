Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B4756C73
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGQStI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjGQStG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:49:06 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637499;
        Mon, 17 Jul 2023 11:49:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-783698a37beso285029739f.0;
        Mon, 17 Jul 2023 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619744; x=1692211744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pup51R7CH2ewXgPiiOoeKchEJYQ5CnfcD4TroSAHdfw=;
        b=HbtHz8LpTaLbUyiGKVmkJ3yx78q/6EOH/BHoCgVNYefT47cfEiX4eFj5RLZ3FU01gz
         H2iPj3N8WFS+D742JGqnELJtE1A6i1+T4VMNihUqrzcMr2ytbFpCGsT1JT7pNgXqxLyd
         dP6AIjxWfAhib7dl9V2oGhir76M7Z7VT1uiu19AahY4+Ve1rP8un56rBniEvGk6GFf7L
         Q9LRqBfUKdzfxyz87WOdZKYZvgxpkMNkY/8l7wvtJCep/JEMcKQ3om+flvX9mIECNk4i
         sxdaOWT0boghIB/XRn7bu3J4Zsy5gnuLR2xnuTyVKhmpFUTpza143v9d6XD6x8UNprtZ
         RixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619744; x=1692211744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pup51R7CH2ewXgPiiOoeKchEJYQ5CnfcD4TroSAHdfw=;
        b=ZtU9lsM4oifldrxC+hPrYd3HeHvCKUi3ZOR4da+/4pMpS96CQ4aLCW72CC5Tw1m+3s
         ZOKg4lybXPfzF2qV7mzYB8sK2KlK7zI+/cbRP2SZzcSfeBTPsYUaTvSjI4Ix5t6KAu7k
         JkKwQVvROjR4GZzoPFH26XCFD26xPrXp+cquJIMlR1snJNvug9hELk8tgel+99cSq1sp
         Be0tGeQVTALpT6KxlALiLbEYSNCN2G2LT9FSuNspM8V/X62YsZ/FkqEQ4lRQI8yIogjk
         YR3/JN2YWhyApPk09JeaXO7rO0rGQgmo/1tqIZVxLT7b3RKfWu8i8BA1mc8YqM4MXVw0
         AnGw==
X-Gm-Message-State: ABy/qLagT58Ye51daLpq79gh6VALxPFcu+5R7v/jcnbH+3F3xRUZbW+a
        mC60T7DOgjozKYCenDItRJo=
X-Google-Smtp-Source: APBJJlFmSDDkJdfs3wbDfi2KzEcqLIt0VONezBNx2D/EgTao9rbKdEV+NE0fcA8w50CwiaA5OodZwQ==
X-Received: by 2002:a6b:dd0b:0:b0:787:8f3:65e7 with SMTP id f11-20020a6bdd0b000000b0078708f365e7mr450415ioc.10.1689619744260;
        Mon, 17 Jul 2023 11:49:04 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d948c000000b00786450bb4edsm35098ioj.35.2023.07.17.11.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:49:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 08:49:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd <amd@localhost.localdomain>
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Message-ID: <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717141852.153965-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 17, 2023 at 09:18:52AM -0500, Carlos Bilbao wrote:
> From: amd <amd@localhost.localdomain>
> 
> Fix two type mismatch errors encountered while compiling blk-iocost.c with
> GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> result of the division operation to (unsigned int) to match the expected
> format specifier %u in two seq_printf invocations.

Can you detail the warnings? Was that on 32bit compiles?

Thanks.

-- 
tejun
