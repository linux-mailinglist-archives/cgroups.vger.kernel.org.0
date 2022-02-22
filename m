Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F034C0263
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 20:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiBVTvC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 14:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBVTvC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 14:51:02 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B994CBA75A;
        Tue, 22 Feb 2022 11:50:36 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id d16so17885656pgd.9;
        Tue, 22 Feb 2022 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UXjqKNRIgAxMkX6Cqpc/qXekDEWeVq9e93BE44DZgy8=;
        b=bzNy2OQYqoF9fgSgZMFDD5DbAtgYNYLa2UZkmn8QOEBGt9Ddtu+Xm0gVwHi5NeBRLw
         Xanu1t2DcPXG0uuFeBVnkrZ5Xux/TYpApMgXLVHeNHAHNL//JZEQdgImpgwjuRR0U6pV
         9soDMPSrXsY1fjBNig2HWKxELREeNFI1I0Mj/hsX2erYiDcGUnLHDwJz3WXlGJQ1zUrd
         IwfAFtDasYah/dnF5DrT+KqRe9JPoX+z9vYIz6mvfVY88As2x80YUcXiD6OpuLEp38uX
         5UH+96wV1uLjy3PBjdqhvFOQsHaCBKqKihcj9VZWXAFEnNgsNY43d/+N8Y+vaG+dYOam
         Z8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UXjqKNRIgAxMkX6Cqpc/qXekDEWeVq9e93BE44DZgy8=;
        b=mH9dlkbYK7Q1zYwLZosuQxvrr/KjbqWfMX2qXIM/tbvzuvG2VWPzeNtLAWH0cclu/7
         pk6W8taTk4yUiCKVaZuchaf3L3JZDtfpyzhyfaBdDCIQ0Hkk32BMcA0psD35fpbrnQxT
         5Mmk4i3utX5eifCBlGshkWQaQdbu5QbqxfX2tJ84JChGGDYSfz9jnh0a9yjE4cArnRCL
         j4Hm1m+LDX5XeELhcVimSzxbX6Ol9CrbZvwV++MbusE8kKvU6IqZ3+bnvoPml5sIH+tX
         devOEl715uashx/M2Rb8aAQPmEfr6Vljxij7/AGX58zWxLNqSSmW7r7cB+MTZIHzlbm4
         kbHQ==
X-Gm-Message-State: AOAM532BxkA0J50D43d+EI7gcJgcunBgy/1Rvc7VhM2yr/aerV6xnW12
        xS9VpxEu97dpTwslwVHcvns=
X-Google-Smtp-Source: ABdhPJyTOKkCrJShCu5+Ro+v3Di/q1CAk6Xek47BOOTpf1EsNabtf1X1LNcMfc/wnAoXdkJV5Qk/cg==
X-Received: by 2002:a63:894a:0:b0:365:8dbf:cd0d with SMTP id v71-20020a63894a000000b003658dbfcd0dmr20710224pgd.5.1645559436052;
        Tue, 22 Feb 2022 11:50:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ep5-20020a17090ae64500b001bc56af507dsm333344pjb.47.2022.02.22.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:50:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 09:50:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] cpuset: Fix kernel-doc
Message-ID: <YhU+iQ8GdN9JKjgs@slm.duckdns.org>
References: <20220216031753.8298-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216031753.8298-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 16, 2022 at 11:17:53AM +0800, Jiapeng Chong wrote:
> Fix the following W=1 kernel warnings:
> 
> kernel/cgroup/cpuset.c:3718: warning: expecting prototype for
> cpuset_memory_pressure_bump(). Prototype was for
> __cpuset_memory_pressure_bump() instead.
> 
> kernel/cgroup/cpuset.c:3568: warning: expecting prototype for
> cpuset_node_allowed(). Prototype was for __cpuset_node_allowed()
> instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to cgroup/for-5.17-fixes.

Thanks.

-- 
tejun
