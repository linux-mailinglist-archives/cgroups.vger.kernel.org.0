Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D467B8A8A
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbjJDSgx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbjJDSgZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 14:36:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B998
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 11:36:21 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65b07651b97so446456d6.1
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696444581; x=1697049381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Gg36uRD0XHPP/bgzDkVeR+D5UCkWGxmhXx93AK3qDw=;
        b=uiZg8eGR2JYnRrNpTeiX1SxG5V3MxG6R0zBF5Fh9HHZWVdVvWiuydwW3b3+MWswiOh
         Fis8ranlgGYQ7c3scp6bCWI95MO4NbaQxCffBDTj4GiMwH6QJXMC82U72UDKSRyAI3d7
         13RxE2oer/NFjsDJDp03zzqCFA/7Rcjijg9ARV3QbWB6K326T4nmlPku9nfTNq9tch1j
         zVuxwqBziBqmLbyFmhI/F3uuvdTZytDekw4ewQMfbtwsukrR7JCUV9eyByQM7gqYYEcq
         C25KhmJAkeaHSwqfsQHU01UsMr5RpN1K5+iMN+bavLSgi+YEpYNQ+UeZWVftYc6JqBn8
         yhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444581; x=1697049381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gg36uRD0XHPP/bgzDkVeR+D5UCkWGxmhXx93AK3qDw=;
        b=N4HaN7mTmFxt+yqqXTD6pzqkPW4xUYj5cx6ierQuHFau2oY+Z3EpTXay0S60sP6bHv
         A3R/YkeNxDkEIl8G7OptfwmBjigCEz7st+A5iHQ1b4lVQK5K8sm96BGEdPneFiAvza/e
         VVV8DjHF+9Nyi5ns3uo/k+JyEvgfnRdOUU8oyYUOotde9oPY7eXxV5zgaCWTcKGPrDDK
         EqLi53lvXiuAvdV2RYoA72hLnyrbFhmxURz0lPDJxHC53axLtjlxEHR1ecvxCH7nh4pp
         1yArzr/0Cn9A415ajXAK9NjqdnD8sbhAQf6KNcMjNdfseqBKN2hzGGlp9cK4YQ9xEpjm
         8FcQ==
X-Gm-Message-State: AOJu0Yz4vH1pxOyj03k8uEli6VXN39VV+qP0En4/iAlMvUUnA8VsrNMl
        Ivb4tyTd7vonVeHtnR4kM63Vcw==
X-Google-Smtp-Source: AGHT+IHBQhGA0082BD+A/OuAL3iNiOKc/nQ86GYtwhzU4PWCIRG8d0zxwveiQpHXLI6ZtN/kQcaDNA==
X-Received: by 2002:a05:6214:14f2:b0:65b:2660:f58d with SMTP id k18-20020a05621414f200b0065b2660f58dmr2491151qvw.2.1696444581068;
        Wed, 04 Oct 2023 11:36:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id w10-20020a0cb54a000000b006655cc8f872sm1531785qvd.99.2023.10.04.11.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:36:20 -0700 (PDT)
Date:   Wed, 4 Oct 2023 14:36:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
Message-ID: <20231004183619.GB39112@cmpxchg.org>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com>
 <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
 <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
 <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 04, 2023 at 11:02:11AM +0200, Michal Koutný wrote:
> On Tue, Oct 03, 2023 at 12:47:25PM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> > Those constants are shared with code outside of memcg, namely enum
> > node_stat_item and enum vm_event_item, and IIUC they are used
> > differently outside of memcg. Did I miss something?
> 
> The difference is not big, e.g.
>   mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
> could be
>   __count_memcg_events(
>     container_of(lruvec, struct mem_cgroup_per_node, lruvec)->memcg,
>     WORKINGSET_ACTIVATE_BASE + type, delta
>   );
> 
> Yes, it would mean transferring WORKINGSET_* items from enum
> node_stat_item to enum vm_event_item.
> IOW, I don't know what is the effective difference between
> mod_memcg_lruvec_state() and count_memcg_events().
> Is it per-memcg vs per-memcg-per-node resolution?

Yes, it's because of node resolution which event counters generally
don't have. Some of the refault events influence node-local reclaim
decisions, see mm/vmscan.c::snapshot_refaults().

There are a few other event counters in the stat array that people
thought would be useful to have split out in
/sys/devices/system/node/nodeN/vmstat to understand numa behavior
better.

It's a bit messy.

Some events would be useful to move to 'stats' for the numa awareness,
such as the allocator stats and reclaim activity.

Some events would be useful to move to 'stats' for the numa awareness,
but don't have the zone resolution required by them, such as
kswapd/kcompactd wakeups.

Some events aren't numa specific, such as oom kills, drop_pagecache.
