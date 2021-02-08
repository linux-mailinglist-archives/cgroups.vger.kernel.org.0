Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7812E314134
	for <lists+cgroups@lfdr.de>; Mon,  8 Feb 2021 22:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhBHVD5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Feb 2021 16:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhBHVDk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Feb 2021 16:03:40 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCADDC061786;
        Mon,  8 Feb 2021 13:02:59 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c1so11443746qtc.1;
        Mon, 08 Feb 2021 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTVAlNOZNa/h2RjRt2M5Ou305u4ysb6/0EoJiOGY+8o=;
        b=op/01oUWlbCNAjdOj9gvkl0CtDftRT2/UisLx184sVL4C3qbV910sFUhFliXU6Xlr/
         99ybdviATLOoTaI2/HYBZButNPjGV/7zorb0GMeWgiKyQCCNkj/HwJl9JHnbjKWnEj8D
         fEHHfrkI/p5qlxaAUU/ye6S37z0eYy/2Kvi2PEXrrM/zFjaUMfBGPziYIqwl/jDYqdtj
         FtBAda3OmOQA5IYdGqZeZS4wCT3ONWsDMmCeWaPAjqSYgC+uUynQ8i7cBx2LaW0E35nc
         7OmFZLGKQsjphqv+IpuHlIcDsqHmDGh+M12+y2W/WeO8vruOOpJRz3A5YrAJP09kxKJA
         +XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yTVAlNOZNa/h2RjRt2M5Ou305u4ysb6/0EoJiOGY+8o=;
        b=aHvt8j19+TZ0WpIRx7c6YtP3C3p02CmdHv1zyzo7HNeCoPwbzq2HrUXe/5+tT9Y1oK
         oDKpef2W8ELvg1XVPMpG4MMOlW2rhZmLzsJ+krC/xdRvKm1FKUOdPIt69FoM0xTdZfe8
         /cgBRpiAxJrP9OdK6dLSm4FLv63mUy883dhFSawrm2iKlQuBsY3c9vLo8RX4GdSydCQh
         /VNgCFH0Puszw3X8sCcktf3g+Ap+JwVDiPiapSWf5UHTHoXKWGx3/YzD+f3QdcVM9MtD
         laT2SkQCb8CYmdxA/Oa5/atKt6UpZzboKAFm0VlmcJ4PsAel60hs9I0vvhTyM5EiKQ70
         ypnQ==
X-Gm-Message-State: AOAM530YOomMpjHFiP+YJMuDXPdVfMaLfouUVdW32HGZLuEkCKpjub8F
        zHQNLvn9wBk+fdhMGkl/FuFg5Lgme0A=
X-Google-Smtp-Source: ABdhPJzqWPbUEfdwA1oDEwxPI/kFbYC2A5s4TGF2TWHi5gP7IQdLWMODVYgDsugYf/YH+jFsepi1Gw==
X-Received: by 2002:aed:33c4:: with SMTP id v62mr15598048qtd.377.1612818178911;
        Mon, 08 Feb 2021 13:02:58 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id h63sm15407645qtd.14.2021.02.08.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:02:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 Feb 2021 11:02:55 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 7/8] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <YCFgr300eRiEZwpL@slm.duckdns.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
 <20210205182806.17220-8-hannes@cmpxchg.org>
 <CALvZod4ex5V2Xs_6YHmmLJw91rjKTSZ9XobXiRx4ftj=L=A6MA@mail.gmail.com>
 <YCGk9ksAU8+tBv5y@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCGk9ksAU8+tBv5y@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Feb 08, 2021 at 03:54:14PM -0500, Johannes Weiner wrote:
> We probably do need a better solution for the lruvecs as well, but in
> this case it just started holding up fixing the memory.stat issue for
> no reason and so I tabled it for another patch series.

rstat doesn't currently have a flush throttling mechanism cuz it doens't
expect readers to be super hot but adding one should be pretty easy - e.g.
it can just keep track of the number of updates on this cpu since the last
flush and then flush iff the it's above a certain threshold. Shouldn't be
too difficult to match or exceed the performance and error characteristics
of the existing code.

Thanks.

-- 
tejun
