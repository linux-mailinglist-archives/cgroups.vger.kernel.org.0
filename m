Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BFE64DED7
	for <lists+cgroups@lfdr.de>; Thu, 15 Dec 2022 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiLOQmj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Dec 2022 11:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOQmh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Dec 2022 11:42:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6BDC9;
        Thu, 15 Dec 2022 08:42:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gt4so11084747pjb.1;
        Thu, 15 Dec 2022 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOgxA915+/U8If37/BdnD3/XyRRRxssxQl2Z8drtlFU=;
        b=ZHs0yZHmhddja5efzdbesgNr+m1zlfrN/YnHS6P0Z9lKUWafZeZemyjvbv59Df4vm4
         1H3d2fteVrh7ot92Y4AEg/5PaWOQjNcNvtm3ufmh+NZy+lEw8UQTqypTjW6Uba9HYdOC
         Adc5NJpWZnYgdy+Z18uk8a+TL+5SUFsmCS3enZ0ySxtDthzjCT7Soi493FLds+qPgyMO
         wrPjkAID2X7+1g3hCwbqrdASUGvcE2uXkRWN/B6GNtNGeUhjVzp56GfUhZtBQES8/e/h
         0OHDBVXAM+d5X06CKGVFFP06/2AFhOLlBF6PGksx+XmNVbSkp8GOnplhm5Gaxem3x4Yq
         RMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOgxA915+/U8If37/BdnD3/XyRRRxssxQl2Z8drtlFU=;
        b=TYb3ErbesVuX4BjnHwh224XjwDRwbhoB2/IAfye1pss0NlcqK4dwocFakFnVOk2fc6
         5dDPYggsolVqM67zYt7MxUawJ8X9BDdYJi4lYoBjCeNQVabLXBkOT56D7Y4QRDQNZ+Er
         PMBEl5Zq7uv5njHOL4FU94D9fgJEqWaneqXLMUoE/GXSNK6WdSQ/r8B8J5uc+HqTYqFg
         mizmlQ3r5QIPrbNiuYYTXH4Goe+wojPWf02IXw1I3l2lzcyZAbLYdgCBpCDiAbJDfoZd
         3erlJSk8YztSWVF7TY/JJNk+OiubdYWZgTwDV4qqYBZRjPvOWOAy8IzoaYp7QJbwzhPW
         OBlg==
X-Gm-Message-State: ANoB5pkyeOQcURSHbN70w3TXICT801xHkGLjUCtLJzggJYS+LVLetVOg
        wOXE5/X4iUiuqEfJOv6EPAU=
X-Google-Smtp-Source: AA0mqf4kdbHwbg++bGG7FdiFr2cls3H5dmAFo/sDDniIAMc2bbfL5XpzzLHPZsNz7Xom8amp2jjPQA==
X-Received: by 2002:a17:902:bb98:b0:188:6b9c:d17d with SMTP id m24-20020a170902bb9800b001886b9cd17dmr20204086pls.16.1671122556178;
        Thu, 15 Dec 2022 08:42:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902e19400b0018980f14ecfsm4074051pla.115.2022.12.15.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:42:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 15 Dec 2022 06:42:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH] blk-throtl: Introduce sync queue for
 write ios
Message-ID: <Y5tOejLZrpMzH8/w@slm.duckdns.org>
References: <20221206163826.10700-1-hanjinke.666@bytedance.com>
 <Y5et48VryiKgL/eD@slm.duckdns.org>
 <f42d81c1-47c8-e283-1259-8c554bf46c46@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f42d81c1-47c8-e283-1259-8c554bf46c46@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Sorry about the delay.

On Tue, Dec 13, 2022 at 11:55:16AM +0800, hanjinke wrote:
> If sq->queue[] were only classfied SYNC and ASYNC, some things may become a
> little difficult to handle。As we put sync write and read together into SYNC
> queue, the two may influence each other.
> Whit wbps=1M and rbps=100M configured, sync io likely be throtled while read
> ios after it may can be dispatched within the limit. In that case,
> maybe we should scan the whole SYNC queue to check read io.

Ah, yeah, you're right. The configuration per-rw so we have to split within.
Will review your latest patch.

Thanks.

-- 
tejun
