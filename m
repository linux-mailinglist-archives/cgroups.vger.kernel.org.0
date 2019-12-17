Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D8122FC5
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLQPJZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:09:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43753 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfLQPJY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:09:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so11690485wre.10
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRifrYHkApcXnKzKR9sZGrhWwRmDmhE0ikbPGadvDHM=;
        b=crKI2MrdTHir1/QxP/Gc2TF/K5LQOSpYr8URTRvZSMKKZd2IgIojFD0O83S/Bq7wBT
         yjLxMTafYMdzf3fF/MvlxezrtHOD813wOAA/PfVag2ndv+LWndeMEvvqrBl174t8ahcL
         v1msU5U/qfNvNJUvqwR/V3PDAfi2JdKH0xG5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRifrYHkApcXnKzKR9sZGrhWwRmDmhE0ikbPGadvDHM=;
        b=YNt2cgAGFcjdrP2Im7jlBEjJcGefER1xSBiuEjTzol2+Yf9t3TKrKcABMzZH4RdeUt
         xzv4sgvFruZ2AeAFdODnLaHcKXcdFcoyMzOEwZ6VoNytbfqQB6tzAHxvwy8Kjv1giFMP
         CAqhlcTty16hhUWKOwbFVvRGRWANHgtCMPeWLZDwpBf5nTyJSiJoopPy3oTXkEdhcmxf
         lCyrL91FaFGFB+8P2lSI3JTTSSJizcM6lUT86BKTwUYxeJQvbDYLKznly6Bi7jXoeHwN
         8x9nUR6bHRAE2wool7jJG5rybqG7eaTFmSTxm97SrgiWZjMQ1vrerBy41JLgbsAIm3BK
         EXFw==
X-Gm-Message-State: APjAAAVPVxGRfg08M11gz5epce1lhor/IzWUgOCAN53HZLcOE29pYmmf
        bel+nKiRhydLDD73jDKsjn4PCQ==
X-Google-Smtp-Source: APXvYqzeUsLeKJ7XhryK7P6j9t84VV3/9Mp+BIfZchRwfo5wRv+dxszHt3anMOTe1fiYJf76De6TAA==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr36184936wrs.376.1576595362242;
        Tue, 17 Dec 2019 07:09:22 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id u18sm25429092wrt.26.2019.12.17.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:09:21 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:09:21 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217150921.GA136178@chrisdown.name>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217144652.GA7272@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>yes, I would just ignore this warning. Btw. it seems that this is
>enabled by default for -Wall. Is this useful for kernel builds at
>all? Does it realistically help discovering real issues? If not then
>can we simply blacklist it?

There's no way we're the first people to encounter these problems, so what did 
we do in the past when situations like this (adding a generic API which is not 
yet used by non-configurable code) came up, and in retrospect did they work 
well?

As far as I know -Wunused-function also guards against other errors, like when 
a function is prototyped but not actually defined, which might be more useful 
to know about.

(Side note: I'm moderately baffled that a tightly scoped __maybe_unused is 
considered sinister but somehow disabling -Wunused-function is on the table 
:-))
