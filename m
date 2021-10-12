Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39E142A3BF
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 14:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhJLMEK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLMEJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Oct 2021 08:04:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BAEC061570
        for <cgroups@vger.kernel.org>; Tue, 12 Oct 2021 05:02:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so64290511edx.8
        for <cgroups@vger.kernel.org>; Tue, 12 Oct 2021 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAcPXDzhn5XqOaTwDcEtw2GqEA7kUJwUT0gZY1JmW2E=;
        b=DPbfSiPVobJV2Q4NaUz4Zx8nPPKhVu6lJzZlNHK5+NGhnm7VVxJM15ZtYtoouecq+T
         I2rMiguacPD+JNJXmaQYRwqmIh90Lz06EG2Go8VBTHdd2K2Co3HcWaaBp2EMy/kY7cEy
         f1i0P0hEAeI6wW+/WCP3FKhW8YU873ZrRuk5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAcPXDzhn5XqOaTwDcEtw2GqEA7kUJwUT0gZY1JmW2E=;
        b=cqlbRuLLs9AeeE3bioEOcIJ2/XNV9PaPouW2gUHAt5QrI53tgMzi4kE3Kp9zej++/3
         8U3XaoULVjjeLvvhkXG45LdQz4DhNR4T480XrkkBFOE5nDweby6c1MET7kjra91GYgeL
         E/zhxpAwsIohxhGFnf4ZFCijYIKTf6bGWnAU9sWVnqc35ZzSAX76zGOuqirdpAUzD14L
         PKBPa42Z7JxbU5znVu5ZZKDiGox1wLKLDVdH8/KkmFYVIi14pHq4SjcpQGmc/Uqfwb/T
         kGJCDuW6Qsm0V76VnbDziHhw4zfs/eIPWoh9XMwjtk5hydbKVmqV+JFLNSNfTusGnI6Q
         4ZTw==
X-Gm-Message-State: AOAM5304VjPiMw/8Yd7dTXecygenb5qAmbpclwJ21HCTry87sIsRHc4v
        l1uYVBEn0kT3Fz8wcV78szJKyg==
X-Google-Smtp-Source: ABdhPJxVaLcLFS1DQQkiZKIzmjq2hDClhDm1yvv4cdEua6mm59xty7Y5iVaFq2dyZFA3yDIYa/Hxfw==
X-Received: by 2002:a05:6402:1e88:: with SMTP id f8mr37837821edf.346.1634040122488;
        Tue, 12 Oct 2021 05:02:02 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:928c])
        by smtp.gmail.com with ESMTPSA id l23sm4859401ejn.15.2021.10.12.05.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 05:02:02 -0700 (PDT)
Date:   Tue, 12 Oct 2021 13:02:01 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH memcg] mm/page_alloc.c: avoid statistic update with 0
Message-ID: <YWV5OY5I0MhTtsn1@chrisdown.name>
References: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
 <29155011-f884-b0e5-218e-911039568acb@suse.cz>
 <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Vasily Averin writes:
>Yes, it's not a bug, it just makes the kernel a bit more efficient in a very unlikely case.
>However, it looks strange and makes uninformed code reviewers like me worry about possible
>problems inside the affected functions. No one else calls these functions from 0.

This statement is meaningless without data. If you have proof that it makes the 
kernel more efficient, then please provide the profiles.

As it is I'd be surprised if this improved things. Either the code is hot 
enough that the additional branch is cumbersome, or it's cold enough that it 
doesn't even matter.
