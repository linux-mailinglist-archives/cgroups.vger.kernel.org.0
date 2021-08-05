Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B133E1A34
	for <lists+cgroups@lfdr.de>; Thu,  5 Aug 2021 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbhHERRp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Aug 2021 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHERRp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Aug 2021 13:17:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC15C061765;
        Thu,  5 Aug 2021 10:17:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso7404898pjb.5;
        Thu, 05 Aug 2021 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aeznxgD24jZUGLqeC6ba+2bQU799mhJW42UJ+HP+wes=;
        b=vdk72yFgYSJ1Mbr4WNf8h9/wyfm2yTsTlyxEzcqA3AGvLh34N8Zt0GGOTRLdP4PZi+
         Z+Pj7jUuADp4733zTRExd6Iwsu5QZVwvnygRTce7ppWowaM83Uh0aaNCdJZ+dzhvT63O
         sswiKUF5AOPR23+v70UdvD3Nb09LucbaIrofEonDWZ3a/fTvc5JR9U4i9R1bqQLmJey0
         X0iCa8RWRlFwxfl5kIlvIZbNFqGGWUzn236dYUpqenAzpSAUwIS0JLGPUxoTN57vqaSa
         N3xviedoW42ihel+eqTjEEp54OnfGeHnyog76XI/k+wf37GxkZQrlP5JSSXSz/bLWYQy
         UP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aeznxgD24jZUGLqeC6ba+2bQU799mhJW42UJ+HP+wes=;
        b=FJiPkbrrnPg2qlFtIM/MA05vAunjsCQ8cvP0QX8ZbGZdE78ZLQyU9XszulXWrcb2uf
         6Pt7NhNO+LBe1WcLrsXSi+oGjvPF/y2PhP3N/Rhqfr6++qACyUxW1F3DfHMRzNsuVmZR
         Q23EK9SbN3NtKlpEvtNpMzL+mVPUZQZO1dJ2ehdyz7iTnyw0DoQrZL3g+85xylHoAp44
         Yd9kUVkSax+6Kj3WNmxHgpGsPqaEbqyqDbn6JKwzWnqRwiTr1bFykVsSQO6oCow62zvn
         DFM9ECOWmIx0K/Q4u3i1W4/Z4u2L/vXGcypwNsKEfcrYSJ2qvhjs5gncDmDYj5G9mD33
         88lw==
X-Gm-Message-State: AOAM533xPEqSkvI6HyVYe7RtbfHoF/+N8oqu2tSI9qLFgCQ0SP7PrCSq
        herJWAfXZkBBn1MBxh+xmXA=
X-Google-Smtp-Source: ABdhPJzqZQth4MwCwC6WI3GMtufePZMGd4DROnQuMuCX6iioADqYBkjFRZHcTm7zKSMRdiXc+46FAg==
X-Received: by 2002:a17:902:9004:b029:f0:b40d:38d with SMTP id a4-20020a1709029004b02900f0b40d038dmr5116087plp.85.1628183849446;
        Thu, 05 Aug 2021 10:17:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:71c8])
        by smtp.gmail.com with ESMTPSA id u21sm7089509pfh.163.2021.08.05.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:17:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Aug 2021 07:17:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, bo.liu@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] blk-iolatency: error out if blk_get_queue() failed in
 iolatency_set_limit()
Message-ID: <YQwdJJGyfps4LOr2@mtj.duckdns.org>
References: <20210805124645.543797-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805124645.543797-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 05, 2021 at 08:46:45PM +0800, Yu Kuai wrote:
> If queue is dying while iolatency_set_limit() is in progress,
> blk_get_queue() won't increment the refcount of the queue. However,
> blk_put_queue() will still decrement the refcount later, which will
> cause the refcout to be unbalanced.
> 
> Thus error out in such case to fix the problem.
> 
> Fixes: 8c772a9bfc7c ("blk-iolatency: fix IO hang due to negative inflight counter")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
