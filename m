Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CB0183AFF
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCLVD6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 17:03:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44206 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLVD6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 17:03:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id d62so7014188oia.11
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGC2JJk9vuAk10qDqdB2GLLddE8al5n+2YMC135z7/8=;
        b=MFTyMtEC8VknjT1M8lTiyfKxTFtMZJGkKIC0Q3oqOBDGa3g7UxELEJgqZr7dTBhnIG
         ixxjSyj0q8phoYnlMZJjGME2GUQgh5pAAf63BjeJByJJ4nZMO2g6msnLMwkVnTSld628
         vXs1tw38JrliwAzoTQUwm3ZeVer/mVXmouFDIIUPlCeQb2Nnr2ECpnwVzd8Jffnq847L
         QiNrse6GGv2M8iuU1adL+6yqgUds3KlBE9zfU7rjhCZkAWZ684caGPSNeM+QM5CCAgI5
         LkUHNmV2YZhICiXf1Xvd3CowoD/bfyFvW7OM0jlAFTbwuSoxJyiwC8MhcFET48g1KhFy
         su1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGC2JJk9vuAk10qDqdB2GLLddE8al5n+2YMC135z7/8=;
        b=CkbfYiSkLYtQD3ZJe1hP9krgBKbOSTnbRxeJyQJ9g8SPSLLy/vPpmoY4PS0SQwEdHb
         gHzoGb2gynPEz4Oh11zhK7arDSdwLA6AypQ4epFNfYUgDMI0b4nH2t1xGyUuDy0VJKca
         cFfSxRFgyJY+SyF+6bMao/5GuN0socXvogSy8RQCJ59mOOiEv2w+ge5+HrZM0ctI2nG1
         ZB6aB9MwNZpET6r5eQFsSiS1KPXau5RwvKNsdZ5lU2jdWCuIIygi7IVTNjHsjC81eXu7
         XFYsfu/glgtNInaJTcegwkTUPnhB0symKjKwYkeNxEwoUYtiXoR7BtrxeIcLbHNJmTUe
         JRiQ==
X-Gm-Message-State: ANhLgQ0uyjacrJFZiX3fMsd8+DqGO5VuhLYqy8A0JxjQTcusN/BDCKih
        YhqQXKkmc9NtaEw1SgBB23kM7B3MRbjt9qfNAOIjGA==
X-Google-Smtp-Source: ADFU+vsc3vO05FGfi/ND84Ilaqg41EiWNNRIsnEqcq/qsjLaZwPkhAcV8pix0fNnG+HiTSuwtbRWD5cE0PfcNmiU3Bg=
X-Received: by 2002:aca:4b56:: with SMTP id y83mr4412506oia.142.1584047036932;
 Thu, 12 Mar 2020 14:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200312200317.31736-1-dxu@dxuuu.xyz> <20200312200317.31736-2-dxu@dxuuu.xyz>
In-Reply-To: <20200312200317.31736-2-dxu@dxuuu.xyz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 12 Mar 2020 14:03:46 -0700
Message-ID: <CALvZod6TxCGiJbPo-4R_qXC7OqWS0LgRRWZwvbaPbWMDRyt0Zg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kernfs: kvmalloc xattr value instead of kmalloc
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 12, 2020 at 1:03 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> xattr values have a 64k maximum size. This can result in an order 4
> kmalloc request which can be difficult to fulfill. Since xattrs do not
> need physically contiguous memory, we can switch to kvmalloc and not
> have to worry about higher order allocations failing.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
