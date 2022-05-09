Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489EE51F98E
	for <lists+cgroups@lfdr.de>; Mon,  9 May 2022 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiEIKUr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiEIKUj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 06:20:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FADF2B;
        Mon,  9 May 2022 03:16:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B098321C1C;
        Mon,  9 May 2022 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652090433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnVbGbF3CiTcycSBZO/loerdaCBwAlV6olMPMO9R0Qs=;
        b=crXHB0LGP0sk30wzd0kWaM5SpjARbCCh70lfRoTsVFXEIuaZcoMvyMb1tID3C62z31gqYe
        yQ7D8QfaK+pJpNbEPL+K5d78N02gEkqfCsXBVAgUwGGbsSMibVYHliBh+Lr3X45ftFpA+w
        keJFS3J/goZuc+Z0vjcFJEU3EQEGDXE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0B1902C141;
        Mon,  9 May 2022 10:00:31 +0000 (UTC)
Date:   Mon, 9 May 2022 12:00:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
Message-ID: <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 07-05-22 02:05:25, CGEL wrote:
[...]
> If there are many containers to run on one host, and some of them have high
> performance requirements, administrator could turn on thp for them:
> # docker run -it --thp-enabled=always
> Then all the processes in those containers will always use thp.
> While other containers turn off thp by:
> # docker run -it --thp-enabled=never

I do not know. The THP config space is already too confusing and complex
and this just adds on top. E.g. is the behavior of the knob
hierarchical? What is the policy if parent memcg says madivise while
child says always? How does the per-application configuration aligns
with all that (e.g. memcg policy madivise but application says never via
prctl while still uses some madvised - e.g. via library).

> By doing this we could promote important containers's performance with less
> footprint of thp.

Do we really want to provide something like THP based QoS? To me it
sounds like a bad idea and if the justification is "it might be useful"
then I would say no. So you really need to come with a very good usecase
to promote this further.
-- 
Michal Hocko
SUSE Labs
