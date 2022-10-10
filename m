Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFD5FA61E
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 22:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJJU0M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJJUZw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 16:25:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CDD1408C;
        Mon, 10 Oct 2022 13:24:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d24so11346613pls.4;
        Mon, 10 Oct 2022 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWBKxcK5HE/3WshbW1q29xvyEiEvyFrYE2hY8YKFsLs=;
        b=KEYEbq/ly8DTkiYPCrGiR6KYBxqhyiZA26Fj+t0+nmZYWUozdenaY+VoU8pmLUc9ry
         OYmW4AJzZ9zZb9ACzz2x6+0Y+so2+IcnPsY5dEwJlHD9JFJQVEs2WbmLHhh4IcK3Ddy9
         QWqYnt/XqsFvRwGQ1tX2ZwRzLRJwB0C4xpMvYCaEG0ECzhQayHWXI6lDge1cYEHLDA/8
         ihOfFmF/w40sHx4RYXTIOrVRLItAuhUhgPUbQReNAD5AYi1eMzxK2HVFpdBK/eBJ3REV
         +1bDUqpz4l0lQsnB/1J3P+hNQ48giXMkuq6/1Y5ng0xXN8DgkEPIbNjsddWIK8blwo8Y
         hEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWBKxcK5HE/3WshbW1q29xvyEiEvyFrYE2hY8YKFsLs=;
        b=Gr1ebv/qEWnsz63E/q8wB7oPmMQB+9FSdp1hO/2rY78OsbhAjBw8x1AWAnFiYAuC49
         ydsp9kAd291zoLFccjL5bbQWOtw9jV0PHQ4eviOirramTq8/URfm6ohOuDu6CJdeuh9C
         P5zgbA9LFAiGhk8lObMN+O0nEedv5Irvm4mH0DXpiXvfMEOmlq0fcbtWP53ElCZxNv+N
         zSrcjFbCsuMmzCgXBzjEUkTpp0hLAsrXj/NVB6GhP1xbFOnKviz9eYlr+H1gAaS+TskJ
         ChBSXqUFOLdLQ2h6Qm0nR7a9VLYHxczAkRostD78eHM8SHlJlcPmdeQ0kuKChDgniqIG
         58lA==
X-Gm-Message-State: ACrzQf2ii2pL3kpjcRrZXSvTvZqpbJkqS+W+Oh/L/nhByWZpCM5oZ7if
        VPbpCfdjpaTnSUiRb2cN+o8=
X-Google-Smtp-Source: AMsMyM5rHJs/tXmnikDZoHEoGNtFEkqwFu4L6qBHwocDNhbXMW+CabS5gdq9L9A9hv30PsFIM/+Pqw==
X-Received: by 2002:a17:902:f78b:b0:17f:9c94:b247 with SMTP id q11-20020a170902f78b00b0017f9c94b247mr20115013pln.137.1665433445393;
        Mon, 10 Oct 2022 13:24:05 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b00174c0dd29f0sm7081535plh.144.2022.10.10.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:24:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 10:24:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, dan.carpenter@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com
Subject: Re: [PATCH v3] cgroup: Reorganize css_set_lock and kernfs path
 processing
Message-ID: <Y0R/Y/YlsynTla6m@slm.duckdns.org>
References: <Yz21I9UpXafWMU0K@slm.duckdns.org>
 <20221010082918.3821-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221010082918.3821-1-mkoutny@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 10:29:18AM +0200, Michal Koutný wrote:
> The commit 74e4b956eb1c incorrectly wrapped kernfs_walk_and_get
> (might_sleep) under css_set_lock (spinlock). css_set_lock is needed by
> __cset_cgroup_from_root to ensure stable cset->cgrp_links but not for
> kernfs_walk_and_get.
> 
> We only need to make sure that the returned root_cgrp won't be freed
> under us. This is given in the case of global root because it is static
> (cgrp_dfl_root.cgrp). When the root_cgrp is lower in the hierarchy, it
> is pinned by cgroup_ns->root_cset (and `current` task cannot switch
> namespace asynchronously so ns_proxy pins cgroup_ns).
> 
> Note this reasoning won't hold for root cgroups in v1 hierarchies,
> therefore create a special-cased helper function just for the default
> hierarchy.
> 
> Fixes: 74e4b956eb1c ("cgroup: Honor caller's cgroup NS when resolving path")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.1-fixes w/ trivial comment / line break adjustments.

Thanks.

-- 
tejun
