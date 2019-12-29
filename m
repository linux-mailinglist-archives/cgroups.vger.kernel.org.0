Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848DE12C29B
	for <lists+cgroups@lfdr.de>; Sun, 29 Dec 2019 15:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfL2OCo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Dec 2019 09:02:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35503 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2OCo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Dec 2019 09:02:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so12278191wmb.0
        for <cgroups@vger.kernel.org>; Sun, 29 Dec 2019 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVdSh5eigGfpfZbcGPOwFmTu1bT8ccSTdspsY1KsgDw=;
        b=QYExPAlecIZL1gnZxQC2xAYNOQMYgcCITRyrl9YRy7vqXB90bkcdXQ0PNNPKj+EfIY
         XbxHnw6z/MYyt8nlFYs49bKYSGMGMdpvYQ4QZkCFEDPLndQdvuyJElvqaxMHi909zBA1
         Yn5uZ2Ws6avDpxFA76+O6cfBw5jIPVmBer4XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVdSh5eigGfpfZbcGPOwFmTu1bT8ccSTdspsY1KsgDw=;
        b=qpuhlkGAfWu1sEZIeHm+IqeWIBwVKGI8cvCxKpxY3CGZc8AHdI9HLwio5WMLjqfH8L
         JRrPbz4HcvV2sWNLo9XynXmOfSkOTOn9xjGua8Cp8yqIJLEVBBd5E9r4AjOjpxp2zA+p
         fHsGkZw/W6ji5mFwYgYK+GhMPO6LCazCwZ1P43iDurescCocU+jFaba3aNM3T/VWhSLg
         UBmYS9ODkMlaJrQsBTyTl8HE9lB40v2batuHsUdn1XxOcT++duqLfg750A23K6pR9vsc
         wA003kjJP0o5rq6JIfIa+IxrLM0vNftQvEt759X+BiF09wQdj5Jnz9DrAzIQ9Mp7s0+U
         bloA==
X-Gm-Message-State: APjAAAVIvYhmn1eB1yrh5R3La0XFitclYsSNj52y13LPmeaMBe8EZ8mS
        lvPgOtEWRTC5abZT+3v18ffPNw==
X-Google-Smtp-Source: APXvYqzNnjbex6gASub1IyimjZc4FxGDCLJz7YROfS76oah0trC8AF8rFLAB3RLixdYFxjp7xmhazg==
X-Received: by 2002:a1c:5444:: with SMTP id p4mr28918356wmi.33.1577628162525;
        Sun, 29 Dec 2019 06:02:42 -0800 (PST)
Received: from localhost ([185.69.145.27])
        by smtp.gmail.com with ESMTPSA id d16sm44864362wrg.27.2019.12.29.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:02:41 -0800 (PST)
Date:   Sun, 29 Dec 2019 14:02:40 +0000
From:   Chris Down <chris@chrisdown.name>
To:     teawater <teawaterz@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
Message-ID: <20191229140240.GB612003@chrisdown.name>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
 <20191218140952.GA255739@chrisdown.name>
 <25AA9500-B249-42C2-B162-2B8D4EE83BB0@linux.alibaba.com>
 <20191219112618.GA72828@chrisdown.name>
 <1E6A7BC4-A983-4C65-9DA9-4D3A26D4D31D@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1E6A7BC4-A983-4C65-9DA9-4D3A26D4D31D@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hui,

teawater writes:
>In the memory-constrained and complex multitasking environment such as an Android system may require more complex performance priority.
>For example, the tasks of app in the font, they need high priority because low priority will affect the user experience at once.
>The tasks of app in background should have lower priority than the first one.  And sometime, each app should have different priority.  Because some apps are frequently used.  They should have high priority than other background apps.
>The daemons should have lower priority than background apps.  Because most of them will not affect the user experience.

In general I don't think it's meaningful to speculate about whether it would 
help or not without data and evidence gathering. It would really depend on how 
the system is composed overall. Is this a real problem you're seeing, or just 
something hypothetical?

If there is a real case to discuss, we can certainly discuss it. That said, at 
the very least I think the API needs to be easier to reason about rather than 
just exposing mm internals, and there needs to be a demonstration that it 
solves a real problem and existing controls are insufficient :-)

Thanks,

Chris
