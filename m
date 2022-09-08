Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3855B157C
	for <lists+cgroups@lfdr.de>; Thu,  8 Sep 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIHHT3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 03:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIHHT1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 03:19:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64639215;
        Thu,  8 Sep 2022 00:19:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E390A1F6E6;
        Thu,  8 Sep 2022 07:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662621560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yklmv2ux9aHaYIhutjyFigStqNyf61xsI5qM8T+Pp2M=;
        b=XsPHwzskZaYb147v91HjRFvXSb84ItKrVKY4TdypktvPUCZ2ermxWVd6wuWWBL62hWeknq
        6NcmpS4lfkIA6SlBKqpvEw22impF8ik4Ke/ZnscUqU7zWcM3fgHpS+TuB6ok1QrNv/Ppp5
        kt5N85b5OZvoxs/3u369Z0s2CX7Fv+g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4FC813A6D;
        Thu,  8 Sep 2022 07:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hn80LXiXGWOJDwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 08 Sep 2022 07:19:20 +0000
Date:   Thu, 8 Sep 2022 09:19:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
Message-ID: <YxmXeC7te2HAi4dX@dhcp22.suse.cz>
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
 <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
 <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
 <ca5e57fd-4699-2cec-b328-3d6bac43c8ef@bytedance.com>
 <Yxc+HZ6rjcR535oN@dhcp22.suse.cz>
 <93d76370-6c43-5560-9a5f-f76a8cc979e0@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93d76370-6c43-5560-9a5f-f76a8cc979e0@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 07-09-22 21:50:24, Zhongkun He wrote:
[...]
> > Do you really need to change the policy itself or only the effective
> > nodemask? Do you need any other policy than bind and preferred?
> 
> Yes, we need to change the policy, not only his nodemask. we really want
> policy is interleave, and extend it to weight-interleave.
> Say something like the following
> 			node       weight
>     interleave:		 0-3       1:1:1:1  default one by one
>     weight-interleave:   0-3       1:2:4:6  alloc pages by weight
> 					    (User set weight.)
> In the actual usecase, the remaining resources of each node are different,
> and the use of interleave cannot maximize the use of resources.

OK, this seems a separate topic. It would be good to start by proposing
that new policy in isolation with the semantic description.

> Back to the previous question.
> >The question is how to implement that with a sensible semantic.
> 
> Thanks for your analysis and suggestions.It is really difficult to add
> policy directly to cgroup for the hierarchical enforcement. It would be a
> good idea to add pidfd_set_mempolicy.

Are you going to pursue that path?
 
> Also, there is a new idea.
> We can try to separate the elements of mempolicy and use them independently.
> Mempolicy has two meanings:
>     nodes:which nodes to use(nodes,0-3), we can use cpuset's effective_mems
> directly.
>     mode:how to use them(bind,prefer,etc). change the mode to a
> cpuset->flags,such as CS_INTERLEAVE。
> task_struct->mems_allowed is equal to cpuset->effective_mems,which is
> hierarchical enforcement。CS_INTERLEAVE can also be updated into tasks，
> just like other flags(CS_SPREAD_PAGE).
> When a process needs to allocate memory, it can find the appropriate node to
> allocate pages according to the flag and mems_allowed.

I am not sure I see the advantage as the mode and nodes are always
closely coupled. You cannot really have one wihtout the other.

-- 
Michal Hocko
SUSE Labs
