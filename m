Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94B83BEA76
	for <lists+cgroups@lfdr.de>; Wed,  7 Jul 2021 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhGGPOX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jul 2021 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhGGPOV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jul 2021 11:14:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50086C061574;
        Wed,  7 Jul 2021 08:11:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x16so359013plg.3;
        Wed, 07 Jul 2021 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GNDXNaZYGbMBdcYFq4ONE/0GjhVExMKqksA5/1NNflY=;
        b=LvrF+NLV2Gy3fvh0Cp5ddJeIkz+lg/q2D1FlVmFj5Jkxj1g5kvXlTZcePJo7FPdLbj
         lKFaGXeMxMwc73KD9WtJOg4I85I1QqKZCGrTyvBk5Y2evPdtYBrS2jOp4pf/t8d6f1K6
         ddi7qZM+7PlvZ9QU2nzr0XnVim+klirwv4P58eNHr4INOxvVfBWrAmSzoNqvZldGgPcX
         cJ2ox2pYtvFIXXAqsy7C3regM90zc2o1hZ2pLNxIJoRHcnP/6D4UM5U0uXE+OMk4CSR7
         TS00FHzfDMcY8/hOaBnDEbjpA7X2iEBODNaGG15YDGU2xPnzW4GfvNAGYhHnvJCYiyyc
         TuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GNDXNaZYGbMBdcYFq4ONE/0GjhVExMKqksA5/1NNflY=;
        b=oA47QWWrtL4XUS2MiNUCF+J0I/w3THCZXwzX+ZsdnZy6+0BKHeQQjJjSCCXBlqZ7h+
         +FgPnOa+l+mMqZW+BqlKMXZZ214xbkHlzvQeP6WXc4UDn5hTrDUH57+3VpX0oIS77HHH
         6+4BGjdme9ytp5P2GdlTRI4AUg/3aprz2SH9kSbodtjaLLCvnglSYbphKpiFECy/18sK
         HtATRoCeyuOvM6K0lGb+sCKVt0QctNmL8r+Ar+y9RB9RNFkWO3OFTdMrZTe7fVocs8Vp
         Ylc2w/a2tNolgyQ8Bq6gJgjHduyXf/yqyzG/EhXlzR9txdlbLP4UTiXLWLuBjgRilhmm
         5wPw==
X-Gm-Message-State: AOAM5339WNRv/OHsDT/R1n0j3WGty/YWEdEhpFfPG9mHFJ2pwUxn8b74
        gjdlITiLiRUWDxWS0iFhxkw=
X-Google-Smtp-Source: ABdhPJwfPq97U1rGRYVrYZ1fgykOXnND9H35Tl077Tp8RuyyoPLyZr9lYn5FFTpa7OVSrObVm3rylQ==
X-Received: by 2002:a17:90a:c595:: with SMTP id l21mr89869pjt.200.1625670698675;
        Wed, 07 Jul 2021 08:11:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:da0b])
        by smtp.gmail.com with ESMTPSA id c10sm19784889pfo.129.2021.07.07.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 08:11:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 7 Jul 2021 05:11:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH V2] blk-cgroup: prevent rcu_sched detected stalls
 warnings while iterating blkgs
Message-ID: <YOXEJTI7qOY6QBjy@mtj.duckdns.org>
References: <20210707015649.1929797-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707015649.1929797-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 07, 2021 at 09:56:49AM +0800, Yu Kuai wrote:
> We run a test that create millions of cgroups and blkgs, and then trigger
> blkg_destroy_all(). blkg_destroy_all() will hold spin lock for a long
> time in such situation. Thus release the lock when a batch of blkgs are
> destroyed.
> 
> blkcg_activate_policy() and blkcg_deactivate_policy() might have the
> same problem, however, as they are basically only called from module
> init/exit paths, let's leave them alone for now.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
