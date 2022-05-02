Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0BB5177AD
	for <lists+cgroups@lfdr.de>; Mon,  2 May 2022 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiEBUKb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 May 2022 16:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiEBUK3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 May 2022 16:10:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B766336
        for <cgroups@vger.kernel.org>; Mon,  2 May 2022 13:06:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o69so12207766pjo.3
        for <cgroups@vger.kernel.org>; Mon, 02 May 2022 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=UWLh0z6KqZeTYvB813th6xGMGi8VpMVzB8UY4c474cs=;
        b=uFZ3m09V2DNjuMRFG0vaMhvPIGbKSBxYWCK1xThA+zj5tr+aLVC8vCvly0DTtR5St1
         P6mO4YRDRHeFcacZxt2xmBTap3+S0637Xy4WMH8O0xVLo4RObXNYTQV9soDCLx+cOkDh
         Qnco/KqauwoftX9giN3bRxTm8KgnH/zr9/YA8PapStmToEnJG13xnF2Fyqs9DKcb13PD
         f76cgtag8rdE5Hj+vLRlndoSLcDitA45oR6Xzl7MOvagtyrL+Ur2J5ILVrAhSNEfRr5s
         IUnL/phQfbZMIO9BvYJeW+brbpC9A9Wpu7IdLnkQF+PlsEcRHgRMHDT2mNuVgLncn3cX
         5x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=UWLh0z6KqZeTYvB813th6xGMGi8VpMVzB8UY4c474cs=;
        b=MIOuyoRthTbmPhcHNMnpb27cO0QDFc2PvB1XqdTWHODMyWigIYAR416nbFqIi0sJzk
         pfwqTThPLoOCmxv0m3v6WR/0PimkZZdTt7Fm+yUeeeUA5Ghp3m0a3ncq2eDJSh0OoSOE
         13kzdx7dcXAFSVo0znGV4n0ZoX0TV2dJ0bZ6AZFRJPwOim2YFuwbdwy3gNILyTi71aT6
         fukMH9SESRgOabYr9TX8rme7Ie5OEHrMcRfyXqo6wjLrQ2LIwRDa7XXYcF4BpdylUc5B
         MEvjPQHkJxo5LUpKU1Y9HEBerTpcfy7I4NRlCBoAA1xga1+wpJdfkJKdyU+qzNrhyFKI
         BTlg==
X-Gm-Message-State: AOAM531yP2/PanITa+RdJckvYLPbvZYJr+yIrM7s6Fg84F8Im6w0P7wh
        x6B4oHfEeJqLlpLKBFNOGksBoziVqp9yuw==
X-Google-Smtp-Source: ABdhPJxNiO9Mi7wpl2iVkR3DmL1JNtpLX/f3/IzWB9+f3y904bkgPvPT6e6Ut3ClaexVwIwAZ1jiAA==
X-Received: by 2002:a17:902:a583:b0:15d:197b:9259 with SMTP id az3-20020a170902a58300b0015d197b9259mr13625813plb.51.1651522018557;
        Mon, 02 May 2022 13:06:58 -0700 (PDT)
Received: from [127.0.1.1] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id h2-20020aa786c2000000b0050dc762815dsm5082564pfo.55.2022.05.02.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:06:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     cgroups@vger.kernel.org, james.smart@broadcom.com, tj@kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, dick.kennedy@broadcom.com,
        linux-mm@kvack.org
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
Subject: Re: make the blkcg and blkcg structures private
Message-Id: <165152201746.5015.15962088646546569198.b4-ty@kernel.dk>
Date:   Mon, 02 May 2022 14:06:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 20 Apr 2022 06:27:08 +0200, Christoph Hellwig wrote:
> this series cleans up various lose end in the blk-cgroup code to make it
> easier to follow in preparation of reworking the blkcg assignment for
> bios.  The biggest change is that most of <linux/blk-cgroup.h> is now
> taken private into block/.
> 
> Diffstat:
>  block/Makefile                |    1
>  block/bfq-iosched.h           |    4
>  block/blk-cgroup-fc-appid.c   |   57 +++++++++
>  block/blk-cgroup.c            |  154 ++++++++++++++++++++-----
>  block/blk-cgroup.h            |  138 +++++++++++++++-------
>  block/blk-throttle.c          |    2
>  drivers/block/loop.c          |   12 +
>  drivers/nvme/host/fc.c        |   26 +---
>  drivers/scsi/lpfc/lpfc_scsi.c |    4
>  include/linux/backing-dev.h   |    6
>  include/linux/blk-cgroup.h    |  258 ++----------------------------------------
>  include/linux/blktrace_api.h  |   10 -
>  include/linux/kthread.h       |    4
>  kernel/kthread.c              |    1
>  kernel/trace/blktrace.c       |   26 ++--
>  mm/backing-dev.c              |   19 +--
>  mm/readahead.c                |    1
>  mm/swapfile.c                 |    1
>  18 files changed, 343 insertions(+), 381 deletions(-)
> 
> [...]

Applied, thanks!

[01/15] blk-cgroup: remove __bio_blkcg
        commit: 2524a5783e7d49e7cd936f582485a2bb4567edd1
[02/15] nvme-fc: don't support the appid attribute without CONFIG_BLK_CGROUP_FC_APPID
        commit: 55d7baa371ad90d297daf4250720af77449fdec0
[03/15] nvme-fc: fold t fc_update_appid into fc_appid_store
        commit: c814153c83a892dfd42026eaa661ae2c1f298792
[04/15] blk-cgroup: move blkcg_{get,set}_fc_appid out of line
        commit: db05628435aa761d30b4eae481a82befe7a8492a
[05/15] blk-cgroup: move blk_cgroup_congested out line
        commit: 216889aad362b5b7e998a5371348b5e95d485dd1
[06/15] blk-cgroup: move blkcg_{pin,unpin}_online out of line
        commit: 397c9f46ee4d99024c64954b007c1b5762d01cb4
[07/15] blk-cgroup: move struct blkcg to block/blk-cgroup.h
        commit: dec223c92a4688f6c9642d640cfe15a99d289dd4
[08/15] blktrace: cleanup the __trace_note_message interface
        commit: f4a6a61cb6d40d9ae63e47743d33200f3efe3fe7
[09/15] blk-cgroup: replace bio_blkcg with bio_blkcg_css
        commit: bbb1ebe7a909db4de49777fb7676d5bf293f34c9
[10/15] blk-cgroup: remove pointless CONFIG_BLOCK ifdefs
        commit: 7f20ba7c42fd899557cef7d001f48711c3066ba5
[11/15] blk-cgroup: remove unneeded includes from <linux/blk-cgroup.h>
        commit: c97ab271576dec2170e7b804cb05f7617b30fed9
[12/15] blk-cgroup: move blkcg_css to blk-cgroup.c
        commit: bc5fee91f26d8d1428fb744e5ad04b1417a85197
[13/15] blk-cgroup: cleanup blk_cgroup_congested
        commit: d200ca143ac6d0b4391b4e811e67e1a36461d501
[14/15] blk-cgroup: cleanup blkcg_maybe_throttle_current
        commit: 82778259eb201870d6d4f95ca4162de60a682343
[15/15] kthread: unexport kthread_blkcg
        commit: f624506f98b198e65b44da303f44974590fb16c0

Best regards,
-- 
Jens Axboe


