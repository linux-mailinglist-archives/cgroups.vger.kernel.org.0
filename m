Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0567E12491C
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2019 15:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLROJ4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Dec 2019 09:09:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33964 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLROJz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Dec 2019 09:09:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so2474444wrr.1
        for <cgroups@vger.kernel.org>; Wed, 18 Dec 2019 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dxjsGjatY6ZbcTCcZP76IfB6Z3ogOgfOc4zopQ9KHZw=;
        b=PNyhx+AOrNKPg3eDV8ybExNCbharLbfTnb/QPJsivs4Drc+dFrkWLrZiSpJzm/dOol
         5cwzbkNc0l3rz6AIjkIRe7L/lvDQUdnn4yZCYUv6VZJkKbn7U9Nyh7g83AWJylEcGA3W
         d4ZLDHApZ7hFNqnvcOOIs2oZSjbuNQKWIlnAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dxjsGjatY6ZbcTCcZP76IfB6Z3ogOgfOc4zopQ9KHZw=;
        b=BneK2/busZop3qtHS9J+NwKvMnvL6D5P7VYlSWR0iER23y3GYxNeF4jHSnbxC5ykL5
         vRawlC4ka0uwdyQYSF2UiYlt6Fiymqcr2SIETefweSjtOaMy7QBhRGj6N/5i5AmTODSj
         0nhri8MeFuS5I+pvN/o6KUCktvv96DegvHerj7lMThP2Jd9OXXkWFgl8N0woHpJj7oaD
         PdPP8WbHoAtKy6QWwP1SsdOBVXGV2xJF3NmWNcVt5vQS0eQkMW/CxlitZIPvnk94lwQ8
         SvN1iriRrJv4VFCoFPlF8QltifCtDnAaVI4z5NHINIbdji4FqxRM2+SYmcblaKMfZjL1
         vDJg==
X-Gm-Message-State: APjAAAWaHMW2f6X7mj8MqH69mkIIcwDKE7QI2P6zmhqTfna8r8oJ1U+n
        HOeGQnrpmsyNPEzngsz4q7LI7Q==
X-Google-Smtp-Source: APXvYqxbgaqnKp6+tHcSJR0Hg+KDMISaNFHSKVH0qfn81gYVnqcpO9RInQXrM6+/f4otf0uySVZMdA==
X-Received: by 2002:adf:b591:: with SMTP id c17mr3068382wre.108.1576678193639;
        Wed, 18 Dec 2019 06:09:53 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id o194sm2641065wme.45.2019.12.18.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:09:53 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:09:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com,
        yang.shi@linux.alibaba.com, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
Message-ID: <20191218140952.GA255739@chrisdown.name>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hui,

In general cgroup v1 is in maintenance mode -- that is, excepting specific 
bugfixes, we don't plan to add new features.

Hui Zhu writes:
>Currently, memcg has some config to limit memory usage and config
>the shrink behavior.
>In the memory-constrained environment, put different priority tasks
>into different cgroups with different memory limits to protect the
>performance of the high priority tasks.  Because the global memory
>shrink will affect the performance of all tasks.  The memory limit
>cgroup can make shrink happen inside the cgroup.  Then it can decrease
>the memory shrink of the high priority task to protect its performance.
>
>But the memory footprint of the task is not static.  It will change as
>the working pressure changes.  And the version changes will affect it too.
>Then set the appropriate memory limit to decrease the global memory shrink
>is a difficult job and lead to wasted memory or performance loss sometimes.
>
>This commit adds global shrink priority to memcg to try to handle this
>problem.

I have significant concerns with exposing scan priority to userspace. This is 
an incredibly difficult metric for users to reason about since it's a reclaim 
implementation feature and would add to an already confusing and fragmented API 
in v1.

Have you considered using memory protection (memory.low, memory.min) for this 
instead? It sounds like it can achieve the results you want, in that it allows 
you to direct and prioritise reclaim in a way that allows for ballparking (ie. 
it is compatible with applications with variable memory footprints).

Thanks,

Chris
