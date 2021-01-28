Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61051306BAD
	for <lists+cgroups@lfdr.de>; Thu, 28 Jan 2021 04:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhA1DcC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jan 2021 22:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhA1DcA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jan 2021 22:32:00 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E0C061573;
        Wed, 27 Jan 2021 19:31:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id v3so3199955qtw.4;
        Wed, 27 Jan 2021 19:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VOw4mJ4y43ELleH9R6vau/EgvTWH40V/X9BffSOccpQ=;
        b=JRELr5pJ/BHYdN461dpHR9FbEXmyaPZ8n28FutnjSzyXAQ9PhSgQP/kt8xKM8gi7qP
         3MOY8cwEC0iCFfb7aCC1GbD1AjF16oMDTFJdt0ii8dJgmTugQn3g/D/8mUY7vZep5chy
         NQsA7BNIhfvs4TuB7gwJCLYJflgU43lFBxvVCbWGXk8ROXBkOfw3cXHw/wpdq0qPy0I4
         uIq8EUOHgwagyl1w8wl+zkUehJblW+qiGs3+BYGaOARMQvyhn+Jusx+FQ6h0zR9KKuHU
         CsiZVj5j+gjPPCMRdmaGkmNdk9hv1BFIKPZZBF54QIBlTfvB4naW6nkA6eelg9jN1Hc1
         jWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=VOw4mJ4y43ELleH9R6vau/EgvTWH40V/X9BffSOccpQ=;
        b=ba13vkIDnwGhcHNe1k5unmqb6Wz2gpZf+14svhgt+x4TiIp7oh0wtUopyEaUsmX9j+
         Q2gtqGNiXWv9GFBhXs8jXBDYj3q0PeS2n1u3sOddqPpzb0PEfdVYfuWzDMYZyguZxKQw
         iUFF87/5DCnpZa98zHSdJk4ioIiX7L5zZXrKl5BJQwK7V4HbHtbzemJINMiJIaW5ZZEJ
         GzJWaC1PWl/LI40BHJ1SgEuk8mX3rBu+AWLEe1hriGh2x8qEOyZBifgknLO+d4LDkSSu
         0rxsw4SNkn3De7lscajEWuXKYnEMLE/U/z/oSTEYEEtT78T3H28CcWIING/CWguAIZ9f
         uIYQ==
X-Gm-Message-State: AOAM5312z/U6HTX3Q8zr4NDackzQbvPZTdX5cV/U5/86dZuvO8MiXizr
        wkhUWeDhiqYPabsxCX3GN1BqUaAcEYw=
X-Google-Smtp-Source: ABdhPJxfo/qHEKGK9edZWfVE+b8jJEBU5mSEhGBSikskdl6KBcBbZTlhO/Ifpk32Id1cSo8skzx+AA==
X-Received: by 2002:ac8:6b10:: with SMTP id w16mr12721215qts.354.1611804678911;
        Wed, 27 Jan 2021 19:31:18 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id i18sm2581275qkg.66.2021.01.27.19.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 19:31:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jan 2021 22:31:05 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-cgroup: Use cond_resched() when destroy blkgs
Message-ID: <YBIv+fG6jleTxOTh@slm.duckdns.org>
References: <8e8a0c4644d5eb01b7f79ec9b67c2b240f4a6434.1611798287.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e8a0c4644d5eb01b7f79ec9b67c2b240f4a6434.1611798287.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 28, 2021 at 11:22:00AM +0800, Baolin Wang wrote:
> On !PREEMPT kernel, we can get below softlockup when doing stress
> testing with creating and destroying block cgroup repeatly. The
> reason is it may take a long time to acquire the queue's lock in
> the loop of blkcg_destroy_blkgs(), or the system can accumulate a
> huge number of blkgs in pathological cases. We can add a need_resched()
> check on each loop and release locks and do cond_resched() if true
> to avoid this issue, since the blkcg_destroy_blkgs() is not called
> from atomic contexts.
> 
> [ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
> [ 4757.010698] Call trace:
> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
> [ 4757.010702]  process_one_work+0x1bc/0x3f0
> [ 4757.010704]  worker_thread+0x164/0x468
> [ 4757.010705]  kthread+0x108/0x138
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
