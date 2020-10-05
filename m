Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510EB2834DF
	for <lists+cgroups@lfdr.de>; Mon,  5 Oct 2020 13:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJEL0E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Oct 2020 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJEL0C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Oct 2020 07:26:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2249C0613A9
        for <cgroups@vger.kernel.org>; Mon,  5 Oct 2020 04:25:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so6124262eds.6
        for <cgroups@vger.kernel.org>; Mon, 05 Oct 2020 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dPmPVQgoIn6sm4yJEL6Gt5bZe3D8XUPMyhu5lemsH1w=;
        b=JosLptL0NIYq+WTt2D0GcnMU8aGMTGaKjauLfSJh/SVg8Fre3RjwOL+f/2Qg5zcYBt
         yycq3AmSW1jW+/cKoAFeJBtiQ2pPJYKD7TsXrW+AvAeW/VThIIijdDj3eD7cuBZOKPpE
         FEeXT4yrqri3+HgiZxDuKbeQZwMpctrogyfI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dPmPVQgoIn6sm4yJEL6Gt5bZe3D8XUPMyhu5lemsH1w=;
        b=d9mOUQxqRHt97RpgWz5ATKKd8LVOpGXRfZonYuE8Lw1tkQ0f67ZqbPpybLQxijUoku
         6iSjJ8G17lSpMZnzLlfZ7lW6d5j6ItG4GSh23qkni2hcSnnDrv19NXTEszep0+PN0egU
         vLMOlR37+XHZXEcKDz2zgkbz3/7JJeVBys9jO5+HmDMTb79R+fzBT3YILrCCZAA/l/sL
         RBw8iZVYcpidA5FGK0JsVaw3HfqhAmMp98M74+h8H+er4zvbi25I8LhXLKJYhrdorCHv
         yRxHox0Yv2mgNP3rLyWPdT1sNwtZa5p1OGgrYl21kpJ6Giatj+JGPwLKZmPRrqqF7CuL
         U6wA==
X-Gm-Message-State: AOAM530pJofpXb8xuqPdG7rZQyvOWh1ylD8OrZvRfJQLQFNe13L3lHbF
        tPJ/QUhVgV3PnVToKE+veLLDYg==
X-Google-Smtp-Source: ABdhPJwEUfB3faVj/+aqL4T2iZayUJerxEobuZPlfEhjF4pUatcxjdChp6vol2nisp1EgAYCOwThVw==
X-Received: by 2002:a50:9a86:: with SMTP id p6mr16361020edb.96.1601897156284;
        Mon, 05 Oct 2020 04:25:56 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:b1f1])
        by smtp.gmail.com with ESMTPSA id p17sm8712908edw.10.2020.10.05.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 04:25:55 -0700 (PDT)
Date:   Mon, 5 Oct 2020 12:25:55 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Semenzato <semenzato@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2] Opportunistic memory reclaim
Message-ID: <20201005112555.GA108347@chrisdown.name>
References: <20201005081313.732745-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201005081313.732745-1-andrea.righi@canonical.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Andrea Righi writes:
>This feature has been successfully used to improve hibernation time of
>cloud computing instances.
>
>Certain cloud providers allow to run "spot instances": low-priority
>instances that run when there are spare resources available and can be
>stopped at any time to prioritize other more privileged instances [2].
>
>Hibernation can be used to stop these low-priority instances nicely,
>rather than losing state when the instance is shut down. Being able to
>quickly stop low-priority instances can be critical to provide a better
>quality of service in the overall cloud infrastructure [1].
>
>The main bottleneck of hibernation is represented by the I/O generated
>to write all the main memory (hibernation image) to a persistent
>storage.
>
>Opportunistic memory reclaimed can be used to reduce the size of the
>hibernation image in advance, for example if the system is idle for a
>certain amount of time, so if an hibernation request happens, the kernel
>has already saved most of the memory to the swap device (caches have
>been dropped, etc.) and hibernation can complete quickly.

Hmm, why does this need to be implemented in kernelspace? We already have 
userspace shrinkers using memory pressure information as part of PID control 
already (eg. senpai). Using memory.high and pressure information looks a lot 
easier to reason about than having to choose an absolute number ahead of time 
and hoping it works.
