Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7F7390F5
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjFUUnx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUUnw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 16:43:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5B10EC;
        Wed, 21 Jun 2023 13:43:52 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77e35128efdso169422439f.1;
        Wed, 21 Jun 2023 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687380231; x=1689972231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+49NAgEqOiDg9ErZI4UsnhhSCDSXIrp5gIeiK/rsvQ=;
        b=Zsng8D4rHRjYU5Uyeat02PAAU5+4Y03qlINFGH1nNpCkpG3UffejdbXXtJgvDxhiL7
         xk9wATuj8Iksx0cxXhcjf1G/2GRSUam/mlT8cpz2d6A23ny4SErw/WFyiRmMikKUyfmR
         x25pFP2IuuEWh7bOrbB6TN7zX3Ie0iqWif42H71vy1uMCa4em3944tg8MjRTvNo3E+Dg
         jG+pvmvmEbAAb1APfmFo/7tlBp63pjsEBXN+E2d0T5t/5W6ZFDZfYZD4SgxnZadsGhEm
         sOHPRl3x9CXRxNt65S+HMuwyICQumqozNEro8ezqkNvyQHXnHHVLm7tCvelbKu+F+lOx
         qvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380231; x=1689972231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+49NAgEqOiDg9ErZI4UsnhhSCDSXIrp5gIeiK/rsvQ=;
        b=NzBwdBTy2gHxPcJ2+6htKM0O6v9d/BLyB1jNUGBmQvive6W9zsvbcHRcoqqvU0/VS/
         4uCw2BOThOUTNMMLElYiVkXS2KbRHB/jFtv5IdOUu/7awk72LjXxZsS1coLXYUgMaDC0
         Q8nRQean2wGwY3cH/sYd/U0h4GBUCBt5BrLG2chMhJZiNwBHjSUdZc7vJKChH3Qqxy88
         Zdoa4+qLSgfH7XfbgbulM3YTorah0008EBrE4jQf0bmaNOkDn/NL19ISnDNzUI6byYt1
         IFxQsWY+IL72DRMKFEPqgYDhBMao5WFsPXPpI4AjtVHTwte6stc5y48x6VRQtvlAS71V
         8oWA==
X-Gm-Message-State: AC+VfDw4O4tir8hbBp5cg9xM+rtiyjeTwVoMv6Rg0ciraltFd/PB3Yvl
        q6We3ydjiEzwLUpEOQu9SS4=
X-Google-Smtp-Source: ACHHUZ6SDv8lDKo0uPdsd3xV7xEAspGPIQDFpym32CplsdXyWCfz8NrZWj/lJQZr9kS/pT7HTtAJPQ==
X-Received: by 2002:a6b:dc09:0:b0:77a:c494:b4b9 with SMTP id s9-20020a6bdc09000000b0077ac494b4b9mr8226058ioc.20.1687380231230;
        Wed, 21 Jun 2023 13:43:51 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id l5-20020a02cce5000000b0041f5ff08660sm1557122jaq.141.2023.06.21.13.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:43:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 10:43:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     LeiZhou-97 <lei.zhou@intel.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/misc: Expose misc.current on cgroup v2 root
Message-ID: <ZJNhBSAn6qhOLRK0@slm.duckdns.org>
References: <20230613105929.269318-1-lei.zhou@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613105929.269318-1-lei.zhou@intel.com>
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

On Tue, Jun 13, 2023 at 06:59:29PM +0800, LeiZhou-97 wrote:
> Hello,
> 
> This patch is to expose misc.current on cgroup v2 root for tracking
> how much of the resource has been consumed in total on the system.
> 
> Most of the cloud infrastucture use cgroup to fetch the host
> information for scheduling purpose.
> 
> Currently, the misc controller can be used by Intel TDX HKIDs and
> AMD SEV ASIDs, which are both used for creating encrypted VMs.
> Intel TDX and AMD SEV are mostly be used by the cloud providers
> for providing confidential VMs.
> 
> In actual use of a server, these confidential VMs may be launched
> in different ways. For the cloud solution, there are kubvirt and
> coco (tracked by kubepods.slice); on host, they can be booted
> directly through qemu by end user (tracked by user.slice), etc.
> 
> In this complex environment, when wanting to know how many resource
> is used in total it has to iterate through all existing slices to
> get the value of each misc.current and add them up to calculate
> the total number of consumed keys.
> 
> So exposing misc.current to root cgroup tends to give much easier
> when calculates how much resource has been used in total, which
> helps to schedule and count resources for the cloud infrastucture.
> 
> Signed-off-by: LeiZhou-97 <lei.zhou@intel.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
