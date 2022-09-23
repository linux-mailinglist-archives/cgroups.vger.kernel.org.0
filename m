Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC965E74DE
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIWH3I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 03:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIWH3H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 03:29:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AF12B5C4;
        Fri, 23 Sep 2022 00:29:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CD44218FA;
        Fri, 23 Sep 2022 07:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663918144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOM18LotnWoAueDS7CKAxKNZg+usqMDivdcE9JRJPBE=;
        b=dVnRMWYNhplQavDtc54h2Ex/j2jYR77RBKGgq9v2Rjc1hmm4joAkkKC8VCpEp/rjz3GJ3D
        E2XRU17CR4X2WBeCgaI2Yt3Emris/lMgFiGkurmrvA65OOPU02Kjg7PUOixpnvsGhUOrLK
        X1I7y+0RI28a/Znu5Spp2d+yb3u9Xq0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C79913A00;
        Fri, 23 Sep 2022 07:29:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JIcMCkBgLWM9bAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 23 Sep 2022 07:29:04 +0000
Date:   Fri, 23 Sep 2022 09:29:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
Message-ID: <Yy1gP7wcoCqzRa0B@dhcp22.suse.cz>
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
 <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
 <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
 <ca5e57fd-4699-2cec-b328-3d6bac43c8ef@bytedance.com>
 <Yxc+HZ6rjcR535oN@dhcp22.suse.cz>
 <93d76370-6c43-5560-9a5f-f76a8cc979e0@bytedance.com>
 <YxmXeC7te2HAi4dX@dhcp22.suse.cz>
 <fa5e5a79-aa1a-a009-d0c8-0a39380a71b6@bytedance.com>
 <120cb50d-d617-a60a-ec24-915f826318f1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120cb50d-d617-a60a-ec24-915f826318f1@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 14-09-22 23:10:47, Zhongkun He wrote:
> > > 
> > > > Back to the previous question.
> > > > > The question is how to implement that with a sensible semantic.
> > > > 
> > > > Thanks for your analysis and suggestions.It is really difficult to add
> > > > policy directly to cgroup for the hierarchical enforcement. It
> > > > would be a good idea to add pidfd_set_mempolicy.
> > > 
> > > Are you going to pursue that path?
> 
> > Hi Michal, thanks for your suggestion and reply.
> > 
> >  > Are you going to pursue that path?
> > 
> > Yes，I'll give it a try as it makes sense to modify the policy dynamically.
> > 
> > Thanks.
> 
> Hi Michal, i have a question about pidfd_set_mempolicy, it would be better
> if you have some suggestions.
> 
> The task_struct of processes and threads are independent. If we change the
> mempolicy of the process through pidfd_set_mempolicy, the mempolicy of its
> thread will not change. Of course users can set the mempolicy of all threads
> by iterating through /proc/tgid/task.
> 
> The question is whether we should override the thread's mempolicy when
> setting the process's mempolicy.
> 
> There are two options:
> A:Change the process's mempolicy and set that mempolicy to all it's threads.
> B:Only change the process's mempolicy in kernel. The mempolicy of the thread
> needs to be modified by the user through pidfd_set_mempolicy in
> userspace, if necessary.

set_mempolicy is a per task_struct operation and so should be pidfd
based API as well. If somebody requires a per-thread-group setting then
the whole group should be iterated. I do not think we have any
precendence where pidfd operation on the thread group leader has side
effects on other threads as well.
-- 
Michal Hocko
SUSE Labs
