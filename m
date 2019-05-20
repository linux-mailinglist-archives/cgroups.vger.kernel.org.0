Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF223E00
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2019 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390441AbfETRFc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 May 2019 13:05:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38767 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390329AbfETRFb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 May 2019 13:05:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7083814pgl.5
        for <cgroups@vger.kernel.org>; Mon, 20 May 2019 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ZOI+jnwXBptD9UIpostnVMZFPCwcvxnpKvL3qurL40=;
        b=Rg3JGm7cAcDM+AZNutQuRwGkJ3ubXbt1UCwOCgZnkJntyOzhCrWnunCiEjWY7ROSIZ
         kVmBbyBsGGB57A5oVMp546xpWJgwU/oSoyDYqohN31no/hHulLW0cV3TFXQxHRGm3Arh
         oZI0B0sNElaQefwHOOurYmhojHza1z+7f0MdJSYwJgf0UX78I0BFmHNhkkyTJP+ysJgA
         1oq4KvyqLM9FGoFmGF0bhA3gzuw3Xcn/MOZUKRVRWJpoiE+3D/NOeDKnUVfhlEhq8tFr
         ACelj15Q04D4dmGoY8dB6fOkc4qS2Hmb9f4IVHnDWYoNGwTJItV3oZNqdJ6Lf+b5E2oC
         /1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZOI+jnwXBptD9UIpostnVMZFPCwcvxnpKvL3qurL40=;
        b=a/gafZynMs6PXG9S8abpuSlwDlB/Qk67yD5MANXnuziiWO3u5MKc3gLT832U6NA2pA
         G+HcVogMFEMfLbDu516JPlcx7v9TDVtUia1Mik7KzvGiCmI2/wWTP/yUsZLd6pXV1JEy
         AQQ79n71tP+C3dGEEqtRGo+kZTyFXt5elzud7D6ZAGCCuvgTTV/BCSyieDqpK9fcso6O
         rxcuBy/Fik4j6EcAHDT5fVPLuiptLsEDdLaiN1XFmdvSAIrXmKS4Dca6bdjsnYp8IO+9
         CQeU+tvWIAmeyx+DT/rVtiEh3hYzZVBHoEyQ/akgaesnyzjg2PiY54MEU+L5Pfj6dOwr
         67vQ==
X-Gm-Message-State: APjAAAWJunj4HltNKTPUn+6CUVNmpJmQpGr9kgTs3+F+p0GYT75wUFzL
        qlTtRITb2zjjeb3izcQH7lW0vNgrrYs=
X-Google-Smtp-Source: APXvYqwYUPMF0FEJQ8SH6f6V9L+pAAf6oW7lozkMuesu1RZqnBX5kL/J9WlcSj5ZD7fx0NEgV+if8A==
X-Received: by 2002:a63:1045:: with SMTP id 5mr32327108pgq.55.1558371931150;
        Mon, 20 May 2019 10:05:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:df5f])
        by smtp.gmail.com with ESMTPSA id u76sm21219972pgc.84.2019.05.20.10.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:05:30 -0700 (PDT)
Date:   Mon, 20 May 2019 13:05:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, memcg: introduce memory.events.local
Message-ID: <20190520170528.GC11665@cmpxchg.org>
References: <20190518001818.193336-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518001818.193336-1-shakeelb@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 05:18:18PM -0700, Shakeel Butt wrote:
> The memory controller in cgroup v2 exposes memory.events file for each
> memcg which shows the number of times events like low, high, max, oom
> and oom_kill have happened for the whole tree rooted at that memcg.
> Users can also poll or register notification to monitor the changes in
> that file. Any event at any level of the tree rooted at memcg will
> notify all the listeners along the path till root_mem_cgroup. There are
> existing users which depend on this behavior.
> 
> However there are users which are only interested in the events
> happening at a specific level of the memcg tree and not in the events in
> the underlying tree rooted at that memcg. One such use-case is a
> centralized resource monitor which can dynamically adjust the limits of
> the jobs running on a system. The jobs can create their sub-hierarchy
> for their own sub-tasks. The centralized monitor is only interested in
> the events at the top level memcgs of the jobs as it can then act and
> adjust the limits of the jobs. Using the current memory.events for such
> centralized monitor is very inconvenient. The monitor will keep
> receiving events which it is not interested and to find if the received
> event is interesting, it has to read memory.event files of the next
> level and compare it with the top level one. So, let's introduce
> memory.events.local to the memcg which shows and notify for the events
> at the memcg level.
> 
> Now, does memory.stat and memory.pressure need their local versions.
> IMHO no due to the no internal process contraint of the cgroup v2. The
> memory.stat file of the top level memcg of a job shows the stats and
> vmevents of the whole tree. The local stats or vmevents of the top level
> memcg will only change if there is a process running in that memcg but
> v2 does not allow that. Similarly for memory.pressure there will not be
> any process in the internal nodes and thus no chance of local pressure.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

This looks reasonable to me. Thanks for working out a clear use case
and also addressing how it compares to the stats and pressure files.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
