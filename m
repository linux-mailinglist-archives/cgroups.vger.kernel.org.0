Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CFC50C026
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiDVTFq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 15:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiDVTFo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 15:05:44 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230313A4F3;
        Fri, 22 Apr 2022 11:55:03 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kj29so2106971qvb.8;
        Fri, 22 Apr 2022 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KgLoqACed/YZWsVbHrClZlNdD0m+rkp/BoBwdt4BJaE=;
        b=jjHDbpnHX6rMI9T8KFgLNp0ENDWYQzw2OnvkKfT9UQOI2yRq8Asp37du911P0uT51a
         W7bwMqKe5m4asxDiJP8/o2e5ghbCMtpvCswT/CZGdG8P847ssbbl0dQ3CJ0LFxfw47sr
         rVg/ipMn6ayl+b7lnPIceFAu3Phcsa6npmUORP1tKu0VEVYLu0F3NscVbL9JUQccqpkN
         UhePV2nn/P6+nKszndoc/eX5WqOSCST9zZsvh34SIzrCvgFeyDSgwO6nAe45qwDNx0Ik
         BELEuUDiscQ4ITnHg8DqExxZSnFdjjjM1ViRPTwtjGY255O1GtjRGFmUwJdrdAYtB+4J
         mG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KgLoqACed/YZWsVbHrClZlNdD0m+rkp/BoBwdt4BJaE=;
        b=j7+tkz48NzV/CklJr1Cy0WTe+vHn2VTascitPpVBbgZKJM1Gq5Alh29xvUlZD6jg+i
         FoWlI4YmDNUiNs8MSQQWmWGwjK48LEmy5sAZSLRcWpd/XJ04cd3GuoAIJRhFVInfzdpQ
         z29oTKMccmsETNv8e1PhEez8CUYIJiVhgz9RT/L4Ews6hf15uUs1SLLaB9CUdj23VY5y
         N+7e7s3AjEJUsWulHrL2aS6qmRKKfzfM2gn8ZahxjcpQIGZojUBIhsBuzwUf8o9LAjK5
         IruAye9t7pQmGh6qJWUk2aANdTmc0ekuZmx/KolF1hwU8HkCgg98i0BnXxDy1+VFjp8d
         FnMQ==
X-Gm-Message-State: AOAM533EY5uPvWX+XY6VLbEs8AD4sxNLtlV8dgru0P0rBl6avnDfUgSV
        d7EEqArtJOx0/XR+vktsV1RT5SMwahI=
X-Google-Smtp-Source: ABdhPJxWVl2l8DYQzxch81sdEC9TG6v2086Rq07jZXEeUku1wQ7R9u27bewitGRVWxzGn9seNnzwfQ==
X-Received: by 2002:aa7:888c:0:b0:505:7832:98fc with SMTP id z12-20020aa7888c000000b00505783298fcmr6184078pfe.0.1650652849174;
        Fri, 22 Apr 2022 11:40:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id js14-20020a17090b148e00b001cd4989fedbsm2205392pjb.39.2022.04.22.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:40:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 08:40:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Vernet <void@manifault.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] cgroup: Introduce cpu controller test suite
Message-ID: <YmL2rt7A6qfiv1X4@slm.duckdns.org>
References: <20220422173349.3394844-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422173349.3394844-1-void@manifault.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 22, 2022 at 10:33:47AM -0700, David Vernet wrote:
> This patchset introduces a new test_cpu.c test suite as part of
> tools/testing/selftests/cgroup. test_cpu.c will contain testcases that
> validate the cgroup v2 cpu controller.
> 
> This patchset only contains testcases that validate cpu.stat and
> cpu.weight, but I'm expecting to send further patchsets after this that
> also include testcases that validate other knobs such as cpu.max.
> 
> Note that checkpatch complains about a missing MAINTAINERS file entry for
> [PATCH 1/4], but Roman Gushchin added that entry in a separate patchset:
> https://lore.kernel.org/all/20220415000133.3955987-4-roman.gushchin@linux.dev/.

Applied to cgroup/for-5.19.

Thanks.

-- 
tejun
