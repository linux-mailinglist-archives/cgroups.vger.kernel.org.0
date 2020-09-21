Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E257F2728BE
	for <lists+cgroups@lfdr.de>; Mon, 21 Sep 2020 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgIUOph (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 10:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgIUOph (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 10:45:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126EC061755
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 07:45:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c18so12510777qtw.5
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7XeqDDDTvxoO0phl/l7TPArLS/GQrVR71HL2ig1yhj0=;
        b=hVlYdOp4benE9VRDbPc+x/gBMtmVxF8MFQ1JBc8Xwu/skl4abBBUJi+IMgsYipD0Nr
         Naq9BfXnqMIrqTKldyflN6hl7n13RXAop7nlnMWFNjCmThbupZx9QeSTXqcjSdNzPiDM
         6dnLuzqGi5Ov+Wai2qXOd1jEvAemHlFjY9eqmsZZaMAOYaMjpwOWisF73EaRBnOLbBR1
         /0MJFeh15yPvWUb25JjpzP1g21cJQAuU/EL+wxd6aiEaBCkVaMG4Bf81ItE+1kCJGl+j
         +bQd6ceNbzbA5XLu5vE1iIkTVcehr5KVQLFayWhXBXAzuU3ghLylVaLE7WH507YB6ZwV
         XXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7XeqDDDTvxoO0phl/l7TPArLS/GQrVR71HL2ig1yhj0=;
        b=ls5K9PUTHSYZdl323P0lUfs7ma3UcbSrqqbT5fUSPYVTU6RftaT8GUUgwSSoe7th4Z
         Y/2BxIsIJ3H2XidmYlDPTIlwLn0UHzMmcvSm3Xv9bQToYobmSirBeolC4Sdb9UlyIpc9
         0+NVW0H8Mks54dnbI+nKeHKZre7il7Cbdrx9T/6RDkAgOOtPb5O51gwjdRNvX9QbRp6b
         HZM1rgD7GsjttxEwNFL6NrryIivkL9sIw6aQZNsV/VPgmkmEa/DD0CdWaAg2q4CQTFAw
         +R7F+mMxQWdJP4SwbxzLJKsNtjloVv8rdcxxmVN7h96EB4QJoaYNtKoY8vLEKRiW9WlR
         OhYA==
X-Gm-Message-State: AOAM532kVvenymsV27Xfi3qvyqnVdCx2JsdwhwGM96Jdi0t0CZzCm/4L
        kVASPNu5wSLLX/fWKg6z6g8=
X-Google-Smtp-Source: ABdhPJzZf2/ethPc31pRyujPcNaF/aUvRxrTYoW8ynlUW+T0R/TEPygJtS0CpuKJspDjkt8XqLmgCQ==
X-Received: by 2002:aed:2963:: with SMTP id s90mr1195606qtd.381.1600699536089;
        Mon, 21 Sep 2020 07:45:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:54a6])
        by smtp.gmail.com with ESMTPSA id h199sm9114798qke.112.2020.09.21.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 07:45:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Sep 2020 10:45:32 -0400
From:   Tejun Heo <tj@kernel.org>
To:     chenxiang <chenxiang66@hisilicon.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, linuxarm@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix a comment in function cgroup_wq_init()
Message-ID: <20200921144532.GC4268@mtj.duckdns.org>
References: <1600419292-191248-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600419292-191248-1-git-send-email-chenxiang66@hisilicon.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 18, 2020 at 04:54:52PM +0800, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Use function workqueue_init() instead of init_workqueues() which
> is not used in kernel.
> 
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>

I don't have any other cgroup changes queued for this cycle and it's a bit
awkward to start one for this one. Do you mind re-sending your patch to
trivial@kernel.org? Please feel free to add my Acked-by.

Thanks.

-- 
tejun
