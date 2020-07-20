Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F32258B6
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 09:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGTHhT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 03:37:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52210 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTHhT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 03:37:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so21234922wmg.1
        for <cgroups@vger.kernel.org>; Mon, 20 Jul 2020 00:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3+cG4dlbvOXxi0Np/998Id6Ue/YJ51oIXoz1t5uzjEE=;
        b=nKhrhWZbc2gwr8hPWnW6pIenpfhSRq2TE1UW2bOGCN36cixc3ERW9Jygz2f8/qlTbt
         VMeHXyj7muBiNLd9Cq/lvkgOp5p+PiMCmp0wN/hXZJym6MtggwIKpAxfRLcqCSrMN1u5
         itYXZ4s8JnZApzfgrZ8LUXcq0BYT45AK/2rBtBx8FJGej7ZAJPtna9ADoXp7aYPozGBC
         AE6USA/XVppBih0bRTVQoZI9NoA9jnRqHHbiwDgyxUsSl9UF7cfPqQR8Buq5OQriFoB6
         JbrlFrbXvaLkj+AHEB1kYFFf1Qtqh/5jYMytpa1g3x8wFLTAZa6pSgGh1oBR9Pi4WuEh
         3EVg==
X-Gm-Message-State: AOAM532UFMZlvNEJjsRMqsWCfYpXYLiMGUPGioG1iTtpvBXCX99VsoGC
        ohkCU/PQpHmwwoSFE0xiyZI=
X-Google-Smtp-Source: ABdhPJw0egh+vZOpf+3Q1sE4MGaAhEuhbo9dtC8o+ihIP20N5BB4q51xtPRvHWzAipyqdcTdnmOtOw==
X-Received: by 2002:a05:600c:2949:: with SMTP id n9mr19440283wmd.69.1595230637370;
        Mon, 20 Jul 2020 00:37:17 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id p29sm32231242wmi.43.2020.07.20.00.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:37:16 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:37:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, memcg: provide a stat to describe reclaimable memory
Message-ID: <20200720073715.GB18535@dhcp22.suse.cz>
References: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com>
 <20200715131048.GA176092@chrisdown.name>
 <alpine.DEB.2.23.453.2007151046320.2788464@chino.kir.corp.google.com>
 <20200717121750.GA367633@chrisdown.name>
 <alpine.DEB.2.23.453.2007171226310.3398972@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2007171226310.3398972@chino.kir.corp.google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 17-07-20 12:37:57, David Rientjes wrote:
[...]
> On a 4.3 kernel, for example, memory.current for the heap segment is now 
> (64MB / 2MB) * 4KB = 128KB because we have synchronous splitting and 
> uncharging of the underlying hugepage.  On a 4.15 kernel, for example, 
> memory.current is still 64MB because the underlying hugepages are still 
> charged to the memcg due to deferred split queues.

Deferred THP split should be a kernel internal implementation
optimization and a detail that userspace shouldn't really be worrying
about. If there are user visible effects that are standing in the way
then we should reconsider how much is the optimization worth. I do not
really remember any actual numbers that would strongly justify its
existence while I do remember several problems that this has introduced.

So I am really wondering whether exporting subtle metrics to the
userspace which can lead to confusion is the right approach to the
problem you have at hands.

Also could you be more specific about the numbers we are talking here?
E.g. what is the overal percentage of the "mis-accounted" split THPs
wrt. to the high/max limit? Is the userspace relying on very precise
numbers?
-- 
Michal Hocko
SUSE Labs
