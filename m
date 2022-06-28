Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37B55D36C
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiF1BLi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 21:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiF1BLh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 21:11:37 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7922252C;
        Mon, 27 Jun 2022 18:11:36 -0700 (PDT)
Date:   Mon, 27 Jun 2022 18:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656378694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbAB+AoVXroNpmpQFJ1qGl0KAbzmB7jFbqYqTflBFEw=;
        b=pv5TxXqtLD0K6CpbRL57lY3eKgfQ9sx4fBnWSf/YrOj9CeZLJyHnNZtHHtnnYuua9GW8JU
        sWKoqyZvKK7A0mzMw7Xh1pT6tb29Ywaa+hW5U6BM4DBqRzCf80ylUYigpLiqnNUINEBBzl
        0BMWVmWtCU/jT/KKf5iR8WDVSLkm2es=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH mm v2] memcg: notify about global mem_cgroup_id space
 depletion
Message-ID: <YrpVP6rpYGFsl3jj@castle>
References: <Yre8tNUY8vBrO0yl@castle>
 <97bed1fd-f230-c2ea-1cb6-8230825a9a64@openvz.org>
 <CAMZfGtWQEFmyuDngPfg59D-+b9sf58m9qhGoVPSQ_jAGmgT+sg@mail.gmail.com>
 <f3e4059c-69ea-eccd-a22f-9f6c6780f33a@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e4059c-69ea-eccd-a22f-9f6c6780f33a@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 09:49:18AM +0300, Vasily Averin wrote:
> On 6/27/22 06:23, Muchun Song wrote:
> > If the caller can know -ENOSPC is returned by mkdir(), then I
> > think the user (perhaps systemd) is the best place to throw out the
> > error message instead of in the kernel log. Right?
> 
> Such an incident may occur inside the container.
> OpenVZ nodes can host 300-400 containers, and the host admin cannot
> monitor guest logs. the dmesg message is necessary to inform the host
> owner that the global limit has been reached, otherwise he can
> continue to believe that there are no problems on the node.

Why this is happening? It's hard to believe someone really needs that
many cgroups. Is this when somebody fails to delete old cgroups?

I wanted to say that it's better to introduce a memcg event, but then
I realized it's probably not worth the wasted space. Is this a common
scenario?

I think a better approach will be to add a cgroup event (displayed via
cgroup.events) about reaching the maximum limit of cgroups. E.g.
cgroups.events::max_nr_reached. Then you can set cgroup.max.descendants
to some value below memcg_id space size. It's more work, but IMO it's
a better way to communicate this event. As a bonus, you can easily
get an idea which cgroup depletes the limit.

Thanks!
