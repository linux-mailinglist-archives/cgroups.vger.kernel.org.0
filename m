Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66095122D91
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 14:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfLQNyo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 08:54:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36346 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbfLQNyn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 08:54:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3282029wma.1
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 05:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tDf420l6OJe0Bwhn9GE+pW7tyo0iSFruHkLYhzOzAo=;
        b=NBYb0wmeeE28IfoeJrHNR1nDrO2AHN8CdVfPvDeRfkbZeQiKbRNDWRDE53oyz1Qvin
         1Z7E0QX1fhIgd7ApaTelr4wPdPP3JqfQJRxyV4VIziwJGIJr6WzgZDPtcapqvqlqReR7
         Ylo8CwcB1K3wbYJWKBlqC8Kc8tQAW16Bt76kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tDf420l6OJe0Bwhn9GE+pW7tyo0iSFruHkLYhzOzAo=;
        b=HRGV+zJejGhcNVNumqcaEH/92PzEYwFyrmeBntKvXjqnzkhK1HmZea5YmeRT6yfXZg
         848OempuPPgToabe8V73ihNFrm3ey3bhtwFg1FLs8tUO5sEhXbESnTpJxSbMsHx/2GQS
         8HZuXeMhnwoT6pvOqSeRoV7ztEffP/IRgYvDujr48db3M9/lr0vtM2W4KzZ66S0/am5j
         L2k6+jDba+6nELB9qE7n84KI8q1Vk9Nc6pS6XubWCW/NMOjUaErq7gWjkDlxwzfmL5GU
         z87SoogyJCwY5Im1jTt0DhgludV0rvAtVGsrZ9F/bl5H8Fa0cRzlsvUI0WPxv8XCluaC
         ttWg==
X-Gm-Message-State: APjAAAVJMdDhylI7jRB/7CT3wIyaKllYmIGtAy39qJODiLrAecTodxKG
        Q6o+yQSAoalvZ4v4Cyx8Su6oTg==
X-Google-Smtp-Source: APXvYqymxQF288/hhyASLUrJbI0GnBe6CY2DqQcMtrvEJHtVaNq5Y+tyGlDwmL1e5t1aoJrxF06sxw==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr5703560wmb.47.1576590881556;
        Tue, 17 Dec 2019 05:54:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id z6sm26950594wrw.36.2019.12.17.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:54:40 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:54:40 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217135440.GB58496@chrisdown.name>
References: <87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com>
 <20191217095329.GD31063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217095329.GD31063@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Kuninori,

Michal Hocko writes:
>On Tue 17-12-19 15:47:40, Kuninori Morimoto wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> mem_cgroup_id_get_many() is used under CONFIG_MMU.
>
>Not really. It is used when SWAP is enabled currently. But it is not
>really bound to the swap functionality by any means. It just happens
>that we do not have other users currently. We might put it under
>CONFIG_SWAP but I do not really think it is a big improvement.

Agreed, I think we shouldn't wrap this in preprocessor conditionals it since 
it's entirely possible it will end up used elsewhere and we'll end up with a 
mess of #ifdefs.

>> This patch moves it to under CONFIG_MMU.
>> We will get below warning without this patch
>> if .config doesn't have CONFIG_MMU.
>>
>> 	LINUX/mm/memcontrol.c:4814:13: warning: 'mem_cgroup_id_get_many'\
>> 		defined but not used [-Wunused-function]
>> 	static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>> 	^~~~~~~~~~~~~~~~~~~~~~
>
>Is this warning really a big deal? The function is not used, alright,
>and the compiler will likely just drop it.

Let's just add __maybe_unused, since it seems like what we want in this 
scenario -- it avoids new users having to enter preprocessor madness, while 
also not polluting the build output.

Once you've done that, I'll send over my ack. :-)

Thanks.
