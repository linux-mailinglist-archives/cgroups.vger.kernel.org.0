Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46211192AD7
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2020 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCYOMk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Mar 2020 10:12:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35865 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgCYOMk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Mar 2020 10:12:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so2231269qtb.3;
        Wed, 25 Mar 2020 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N7nQ4ebz3lUmPEZItWMKhCh2iPFhfdeLlfUD+yoZmZE=;
        b=FXRWZ4idTS/9SmW/h6ukMHo4O1sk+A7oUGDB5LsZQ8TKlldyn0o8yk88kVp2+kcSJC
         lvfqLWPwknKK0boCQXOXvGH17M9KbmCpw+qMPU/AXfi4lJQSylRdzjjv1OKBrKM03K3L
         8LGV2prz6EVm47zu9u+8bJ7y/P8CJulaulx5BkB7mfTRcwa0cGi4R1/7u49roDrt2BU/
         VdLxEKJhSbSnALe6Vr1yEJRTQLxGWRICUVQOOfkQLA5ahpQka7smhjhAmLiB+I70lyZV
         Fob0h/ZhNg+DZx+y0rC801gEIeQArWhhCPUrPRd5QTlXXyfMhQYoi+AByvtSvPuVBd0B
         7eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=N7nQ4ebz3lUmPEZItWMKhCh2iPFhfdeLlfUD+yoZmZE=;
        b=Khpea25LXugMQf7iWs582/WM4q5DtDxRakM4rlNY4DNC9pLtzRCmeNyWwY9Rwbbvax
         c2ylOra5M5Yws7qVu6ZUm3cyMXQubmZfZUBgdr+LyiIVBas5i87lOcBBSabyLMChAcIO
         zkw/J/31dCs5NgnhstGgLKPu2IgZuYCPu6f3oMPpOwylfjGeSzd2yXtiDDV0bQobQzxJ
         sPLUUSCGC1+BJxWGxKxjb4dzXt4+3NCGOjLdUpWVo7AX1E533UpXV9UszEFNhKNMWboa
         SUHgT6T+67Ci1lG8xHkQ02ktROXkoHw+DGd7BvIvrCI7x/r8RvgjhjdH48hQ3SlDDSKH
         4fTw==
X-Gm-Message-State: ANhLgQ1X8A9iHGbCGPkQ6rWCJv09aDT2swyi0KkUa7RFlnuesiMy9aT3
        pxx1tX7qT3SVpB0p4rclfz29BLKOFd0=
X-Google-Smtp-Source: ADFU+vviwj5kbNzPI4MpcV6D+abNsFlE2SyiEgoJJw/slckG95vaO1pSwoQcUzPy2GwpsjzhItDUEw==
X-Received: by 2002:ac8:2911:: with SMTP id y17mr3065339qty.73.1585145558617;
        Wed, 25 Mar 2020 07:12:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d8d4])
        by smtp.gmail.com with ESMTPSA id e130sm15532213qkb.72.2020.03.25.07.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:12:37 -0700 (PDT)
Date:   Wed, 25 Mar 2020 10:12:36 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC 0/3] blkcg: add blk-iotrack
Message-ID: <20200325141236.GJ162390@mtj.duckdns.org>
References: <cover.1584728740.git.zhangweiping@didiglobal.com>
 <20200324182725.GG162390@mtj.duckdns.org>
 <CAA70yB7a7VjgPLObe-rzfV0dLAumeUVy0Dps+dY5r-Guq2Susg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB7a7VjgPLObe-rzfV0dLAumeUVy0Dps+dY5r-Guq2Susg@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 25, 2020 at 08:49:24PM +0800, Weiping Zhang wrote:
> For this patchset, iotrack can work well, I'm using it to monitor
> block cgroup for
> selecting a proper io isolation policy.

Yeah, I get that but monitoring needs tend to diverge quite a bit
depending on the use cases making detailed monitoring often need fair
bit of flexibility, so I'm a bit skeptical about adding a fixed
controller for that. I think a better approach may be implementing
features which can make dynamic monitoring whether that's through bpf,
drgn or plain tracepoints easier and more efficient.

Thanks.

-- 
tejun
