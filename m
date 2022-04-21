Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE3350AB6F
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442418AbiDUWYM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 18:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiDUWYM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 18:24:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A008940A0C;
        Thu, 21 Apr 2022 15:21:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q3so6796992plg.3;
        Thu, 21 Apr 2022 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y4d38YpC96MwNpVBxn+LoFiok0to/qtpUK4U97fO1MU=;
        b=IowvYSLsWnTxjBUdv+pWRlN3Y36o14LXqsvlMe2fleitn2tK/LKdmR7N9WVyXdUpxb
         SYsa+UYLGmwH31GN8Uy72FxeasxkNOFRcJ4RlFMyTAGPXBjyrlocbuEawV2z2M4pwIoD
         2fhn9E5/kwuOLTjits3s8RMOmxFyRz/rXDiigLAyBU1OcD+qg2WX3OizjnJknlNqkGh4
         c3nP4cHf0Rr3IjWNRNnJzfXESFrfbsSedVCgFkZ4FQglUZ3pLkEg+eo7+lZBn4TGJwC/
         EkDxVfpDNUheBE6KMBGy43t8skITwdWshrMrQAmQ0nAOKqFEKLscYpeoYgYRiO/ByMWP
         1CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Y4d38YpC96MwNpVBxn+LoFiok0to/qtpUK4U97fO1MU=;
        b=iczBUQJF3liw2/hT2CHNHnYExNzqMVrRKEfqaGzCj1yGhD9ZJRervn3uAvJrEoTehh
         iNG2SMnu2M+d5yRRpFlEr83ENdBzF56DPg3EqcoG1PhN8zdkaJEAFADnxYA6tT+so0J1
         0kzp+5KUoCIv99PjAGB/Uzu+kwQBaL5cR8a1TIDdWDo1gtO5fxdDJve5uxXTPGTXW9RZ
         4RrQm1wp6Jp1r/YPzMuazPMtOs6wPWhploI1nV6X7zI8/ZnjWYt4th+ZK7ufQQzIN9/C
         STpbk2toCsVg0r4GDZKD6f7jHkrmgohEtvoaRLJdJ4AKa10oushk5LNGN4IEcuZDHI48
         WduQ==
X-Gm-Message-State: AOAM533DieOgCUMno4erzDnr4r3Z9F3PVOJOeozhz7Tdl9bzlk+XYYPE
        3ybsrycvk90R7KpD61WoIsl6YrAyF7E=
X-Google-Smtp-Source: ABdhPJy+iHcHE6pyPNd91YUbYtk3AYDMbE5bYPvMCwusNdZ+M8123ZRyFjqx6uwaAi1JChvrDqKM7Q==
X-Received: by 2002:a17:90b:268b:b0:1cd:3f24:d52d with SMTP id pl11-20020a17090b268b00b001cd3f24d52dmr1901217pjb.174.1650579681060;
        Thu, 21 Apr 2022 15:21:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:15fa])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a4bc900b001d26f134e43sm3896290pjl.51.2022.04.21.15.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 15:21:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 12:21:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Vernet <void@manifault.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/4] cgroup: Introduce cpu controller test suite
Message-ID: <YmHY3t9UC2/zDyMz@slm.duckdns.org>
References: <20220419213244.2104972-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419213244.2104972-1-void@manifault.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Apr 19, 2022 at 02:32:40PM -0700, David Vernet wrote:
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

This looks great to me. A few small things:

* Can you please repost w/ Ingo and Peterz cc'd?

* Maybe cpucg instead of cgcpu?

* Single level testing is great but extending the case to cover deeper
  nesting level would be great. ie. a test case with multi level tree w/
  both under and over provisioned parts in the tree.

Thanks.

-- 
tejun
