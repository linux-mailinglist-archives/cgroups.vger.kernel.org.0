Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8D628D34
	for <lists+cgroups@lfdr.de>; Tue, 15 Nov 2022 00:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiKNXLk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 18:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiKNXLh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 18:11:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8788A22C;
        Mon, 14 Nov 2022 15:11:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s196so11616600pgs.3;
        Mon, 14 Nov 2022 15:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odpYU+Z5Izh+YHmos1vrgNoom8ekbwoJE8YvWsljqKw=;
        b=bx3cCmBrKBUoh+0kQwPoowY4cSqbreKadVtsFwrVH+COOjVGRnKnHVGpPqhTVj511F
         /FdrjdB1vLPzt+WsmB96m4uW65K5c/GorCcjiUVX4tPPrhXuIowIVzdnqpWHRP2JUjka
         DPtRHI3/byuPmYgQ0NlrmDc/BVD2EO5PvLdOdTsuPL64nLIv+6yUraqBsWXvs8W/uaHO
         AnEJz5iuRNEYU+AziFZnaQvZVXamOr1vRUdTLv1l4/53FgXSXvocr5OviBotIOXgJTQ3
         0xnjV23Xp9aWmqcWHmpPItLrvKE4qaLFFUWShIydcJ3EXINIHQgkI/XSUV65/uX0TFb0
         ZqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odpYU+Z5Izh+YHmos1vrgNoom8ekbwoJE8YvWsljqKw=;
        b=oj9/vCXmW7u5Bj1QL8m6E69ennNKB+PDMZ1vrvz8ElCDmslwo5HsVsQIZUsVJzbpT0
         EFjzhfTjWcs0I/It0I8XUKSqoth751+05ZDwm2/NVonifCfm9wCNhaMcDhwlMDMJkrZ1
         Z30xupTjzfX4t+G5prsCHovlLuWAufQRrGYY70Xd9wHyKSobTSZjWBL4XIzTYtYUHcOz
         EO247tiiaF4Kuv6VFCMB8UZVMelRmoqqfiVYpMuudOm1pN5fHq/yHsyu5Cm1pBOw67tG
         GrQWYcrDczKdshQZy1ChneFSYAiXKCktpJ1QpicYIoTfsh3Z0PHkPvCw0UkSe2hP3PDn
         /h/Q==
X-Gm-Message-State: ANoB5pllR0YmOyyFm/tut79bOMXMy43dLbPZ3xrXeUWgJs9XHwZNSbst
        aP7Q5o9CG0ANL2CFFuQrKcI=
X-Google-Smtp-Source: AA0mqf75TV6KBo7mArf/WuWipGqDnyz1OhpL44/37i8BeYx2KL/BAqTO9oGV6Gwjn2/ulFqY1wCRWQ==
X-Received: by 2002:a63:f718:0:b0:44f:7d7:89be with SMTP id x24-20020a63f718000000b0044f07d789bemr13784965pgh.573.1668467496853;
        Mon, 14 Nov 2022 15:11:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s15-20020aa78bcf000000b0056b3c863950sm7279888pfd.8.2022.11.14.15.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:11:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 13:11:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH 17/26] cgroup/misc: Add notifier block list support for
 css events
Message-ID: <Y3LLJypIUOSGKujT@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-18-kristen@linux.intel.com>
 <Y3LES3rUIZ/PtwzV@slm.duckdns.org>
 <6f7afaa6811cbda30d12c38d73d4b261ab733a9f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7afaa6811cbda30d12c38d73d4b261ab733a9f.camel@linux.intel.com>
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

On Mon, Nov 14, 2022 at 03:10:05PM -0800, Kristen Carlson Accardi wrote:
> Makes no difference to me TBH - I believe they will be functionally
> equivalent and from a downstream user perspective equally as easy to
> use, so whatever you think is easiest for you to maintain.

Yeah, functionally they should be equivalent. Hmm... Let's go with the ops
table so that it's more explicit.

Thanks.

-- 
tejun
