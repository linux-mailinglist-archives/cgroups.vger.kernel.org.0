Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD95FC19E
	for <lists+cgroups@lfdr.de>; Wed, 12 Oct 2022 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJLIGR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Oct 2022 04:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJLIGR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Oct 2022 04:06:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5A76544;
        Wed, 12 Oct 2022 01:06:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so1324028pjg.1;
        Wed, 12 Oct 2022 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBrtNGgiKc64ZJ37zUKu7nEMj/WdDGr4Yyp+sxihhTY=;
        b=K/T1u6SXP48sf76E+Em0jrB8E2jrFWVkXe5K4LWyyfdjCJGnBFHi9HpGgcAkW0dY26
         epUvWm7/I/Ec5Z4SIadzKcUySRzlhdF0e5pNtAwvEtt054Y1ZK8W/x1C/Z3rNoygrrii
         3gyEMWZ54SwI/DDueHBXXJkw1GkqDSZVmFGNtvhFBAuBPpO1oi+X/gvBFH2YeEDgpOaO
         XwrA3NhdNK1EBYcsU8vPCB83nkTlBVW+y/ADuBGG+HeZVzKwGdzbn8X8bQW3QqoC/Srd
         um5pWBqHwAN9O5lqa8bMOZiwHBuaa8qWKp5oO1CmbUoqB4F1Kq24Bvtnnvcg4K5mLREz
         WIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBrtNGgiKc64ZJ37zUKu7nEMj/WdDGr4Yyp+sxihhTY=;
        b=07ZbMwM7u0rBhQHWCUk7mS1GY/5B8enEGtunWZWSZGEo57PD3QT8N4Tdoy8lIwXXBN
         PtrUAfICZGcEF2JA9wAPW/bQ8Y4HIp7pP5FS8PWDXpUsgNEgOLz4iugIrV3yRrshQl6c
         mDZ8mgCxml3oNARf+hCWXpjuoAWVyot4IylcFdfD/p38OQ+48GREj6MAlYD/tvljl9mJ
         KY9FnemF1iub5kt0d1LY7qMx4qlugzUtorq3fIgkRSVNHfRMbhNUEU5uPqmO0QvwU0bt
         ooqINVq5upzGSihmuCfJlN/jvlUI87x9lXHpXabgqFPH1IHTAZTF7zi4cBTcjUMzDbtn
         hvGA==
X-Gm-Message-State: ACrzQf2gTL7WrN0HSf0srGvhax+VPn0FKUkhTq5Z0sMIpAjQJ3mYm62Z
        UL/3H06056tqkgtmTz4MX9Y=
X-Google-Smtp-Source: AMsMyM5pgh/DksMxWIN3NvTA/VmtDd0ii9THpnjPJ8bQFtS3F0wVWDrWEgm53Se+ipcx8tgPtJ0fjw==
X-Received: by 2002:a17:90b:4f8e:b0:20c:c3a8:38b with SMTP id qe14-20020a17090b4f8e00b0020cc3a8038bmr3854889pjb.10.1665561975786;
        Wed, 12 Oct 2022 01:06:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b0017f7d7e95d3sm9863168ple.167.2022.10.12.01.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:06:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 22:06:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH cgroup/for-6.1-fixes] mm: cgroup: fix comments for get
 from fd/file helpers
Message-ID: <Y0Z1deLeePrNmdeu@slm.duckdns.org>
References: <20221011225155.4055415-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011225155.4055415-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 11, 2022 at 10:51:55PM +0000, Yosry Ahmed wrote:
> Fix the documentation comments for cgroup_[v1v2_]get_from_[fd/file]().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> I cannot reproduce the warning so I cannot make sure it's fixed by this.
> 
> Again, apologies for missing updating the comment in the first place.

No worries at all. Thanks for fixing it. Applied to cgroup/for-6.1-fixes.

-- 
tejun
