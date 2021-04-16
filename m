Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B383629A4
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhDPUuR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhDPUuQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Apr 2021 16:50:16 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC8FC061574
        for <cgroups@vger.kernel.org>; Fri, 16 Apr 2021 13:49:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d15so17277408qkc.9
        for <cgroups@vger.kernel.org>; Fri, 16 Apr 2021 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DexHDhL9tcMwui87pn8whVm0iHnYGKNPOz+fZd4UKq0=;
        b=ZHYlqzjKQo+Kf3LZ9lccJtG0B9f4KjhrWnl90sg0iUobj4YCXpTt9TmJp/ASfF2cnh
         tQqTjcR7IfEnUIdM5WfF+XFkS9m0ti/SRTKzfNzdYsA5kCkFhToO2z1SiLIVJ0oxzUsW
         LvMOXRMqQangaKL6AvDOCXU/UenN4wSmrg2Q1OtZvspeTfPgRU3EbHxjH0hlgfgEYUjn
         wkACiS3NUWYlPY8pCI0PhjHSm+Dw6Lml22r+BIdgbqOdp8yENG124sHZ4aR6gwDHUMNC
         oggMzSM0hDaXGI7lggG1ltlMxML6lbgkPI35zakvgksUHQvLvwHtSjD/CH5Va6yeMAos
         Z0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DexHDhL9tcMwui87pn8whVm0iHnYGKNPOz+fZd4UKq0=;
        b=BFGikAHOPJuMMmO1m/lEb62psDk/o3h8Hi3DL0jLxKfWiq3tae7sn3uO1Go8sDYmUz
         +MoUxeuK0Cpjz7yOxwffJ+oJPj3+iBl/kOfsaRaeWrFgueYt72TqbWL/s4VsR/k+cztL
         UnGrpHIncV69BEvmLTY/o9cQXB30g5z6BbWXVIxOyMlf0AgFMN3TSpv37l3L4Mlt7vCn
         wGXgG9AxXZkeKkS+59ZRCHX31cZ17w/FCgqzhlQUy9gE7Ilke8cpRK4pAO18Uk+1IToh
         YxftVjMqu/AtstLZ91uTtms5x2Y1R3GODn45qZDbASjMYc/DMibGDTceyGfp1r8C7gH8
         oUyQ==
X-Gm-Message-State: AOAM533OUTUKFaK6R6ziJtZtZw5Yqo3Ybf9yFebM//xpDXyacyLffCYY
        8sky3PanofQagHQrTkXKmM4=
X-Google-Smtp-Source: ABdhPJynxCDNfza0k4abotFiGXBI4fd0MDdFgfd9vFEVj4T54Vbt1TSPRVhERGtDPkV6h4rjXTqzqA==
X-Received: by 2002:a05:620a:4155:: with SMTP id k21mr1173754qko.266.1618606189634;
        Fri, 16 Apr 2021 13:49:49 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id c27sm4979212qko.71.2021.04.16.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:49:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Apr 2021 16:49:47 -0400
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH] cgroup: use tsk->in_iowait instead of
 delayacct_is_task_waiting_on_io()
Message-ID: <YHn4a4Xdtm6212Wy@slm.duckdns.org>
References: <7fee39d482a783254379f2419a00b9a9f32d7f2e.1618275776.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fee39d482a783254379f2419a00b9a9f32d7f2e.1618275776.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:39:05AM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> If delayacct is disabled, then delayacct_is_task_waiting_on_io()
> always returns false, which causes the statistical value to be
> wrong. Perhaps tsk->in_iowait is better.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Applied to cgroup/for-5.13.

Thanks.

-- 
tejun
