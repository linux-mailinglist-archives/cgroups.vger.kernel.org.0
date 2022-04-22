Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CBC50B764
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447559AbiDVMf0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447563AbiDVMfZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 08:35:25 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7341F57151;
        Fri, 22 Apr 2022 05:32:32 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id a186so5656140qkc.10;
        Fri, 22 Apr 2022 05:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iA+jGKClUvGezMDT1VSqteR5fgKxe0MYow2rzFPqCCc=;
        b=oO8pckqikathwL0cJwEOjVERO0Mm9ID6Nvgs+0z2sDLlWvUnZcbkpLCv2AWddXMckn
         iF//lPYc/6XOoipoPnz5/jTbc9tTgOYeohiCubo/DX25CRDEH7ypZyMnL6F31OwuUU6Q
         1Xv+B/I/ucz8+ZDEkf3DZi00luoovfFwTNLmZ2oE1sibw8IUO4EX1u2Wfu7WicCVXO3p
         s+ccKDbdwB43B2z5sRt5eze5e6mHExkCknGdGuSDzCoanzLloCVzzblri0N3OwLaN/R6
         j3ss8IZQAvw1HRG5F8ibarZyL1tFQLMPGYtHGojjD8ttatN70Hi0L8DTtAxqU7pogPeV
         0F9w==
X-Gm-Message-State: AOAM530yuBTejDIau8qXT/isAjHCJySeaObGN/lULcgcEXcplSSQlD0w
        NZ8EtE+w34G88u/bVM9pO1w=
X-Google-Smtp-Source: ABdhPJxz2EzkmgXo1bxDzIkswTIGKZYOQ5brrzmme7XskdngORdpFT6zaNYmyBgz7C2eZewuT4hf2Q==
X-Received: by 2002:a05:620a:469e:b0:69e:d1d8:6294 with SMTP id bq30-20020a05620a469e00b0069ed1d86294mr2521165qkb.36.1650630751116;
        Fri, 22 Apr 2022 05:32:31 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-008.fbsv.net. [2a03:2880:20ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id s136-20020a37a98e000000b0069f0c30c0d3sm858000qke.21.2022.04.22.05.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:32:30 -0700 (PDT)
Date:   Fri, 22 Apr 2022 05:32:27 -0700
From:   David Vernet <void@manifault.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/4] cgroup: Introduce cpu controller test suite
Message-ID: <20220422123227.gtirbsygpjek3iss@dev0025.ash9.facebook.com>
References: <20220419213244.2104972-1-void@manifault.com>
 <YmHY3t9UC2/zDyMz@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmHY3t9UC2/zDyMz@slm.duckdns.org>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Thu, Apr 21, 2022 at 12:21:18PM -1000, Tejun Heo wrote:
> * Can you please repost w/ Ingo and Peterz cc'd?

Will do, I'll cc them on v2.

> * Maybe cpucg instead of cgcpu?

Agreed, that seems more intuitive. I'll change it in v2.

> * Single level testing is great but extending the case to cover deeper
>   nesting level would be great. ie. a test case with multi level tree w/
>   both under and over provisioned parts in the tree.

This sounds like a great idea. I have another patch set that I was planning
to send out which adds a few more testcases. I can include some testcases
in that set which validate more complicated nesting setups.

Thanks,
David
