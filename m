Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564F86D9193
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 10:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjDFIak (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbjDFIaj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 04:30:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8061A5;
        Thu,  6 Apr 2023 01:30:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 612DB22826;
        Thu,  6 Apr 2023 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680769833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZeNqSzG1mQYY7oNWDAYbyb5M/J1jwCKa4/8IkPcpdUM=;
        b=OPlxBigt/AdMFlXcx2PJ6WGA+wGmXv+bmQ68bYLrqRs9qPOK7s+aRZanCqFOt6YaJT2TwF
        8aA6SU3YOAa/PyBql5sao/cuR4O6pegZ76h3FfogVS0l6vWiB0GDGaniQcocB1/x1ZYhoO
        8q88+KVJd6ZS/KTIGWmMGoiZ1jh/TGE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42585133E5;
        Thu,  6 Apr 2023 08:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d8TuDSmDLmSGZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 06 Apr 2023 08:30:33 +0000
Date:   Thu, 6 Apr 2023 10:30:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: Re: [PATCH v2] mm: oom: introduce cpuset oom
Message-ID: <ZC6DKM4LDOVgohpj@dhcp22.suse.cz>
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
 <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
 <e444e0ca-a2ff-37f2-1f1a-032b9fd63235@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e444e0ca-a2ff-37f2-1f1a-032b9fd63235@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 06-04-23 11:22:16, Gang Li wrote:
> 
> On 2023/4/4 22:31, Michal Hocko wrote:
> > [CC cpuset people]
> > 
> > The oom report should be explicit about this being CPUSET specific oom
> > handling so unexpected behavior could be nailed down to this change so I
> Yes, the oom message looks like this:
> 
> ```
> [   65.470256] oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0,global_oom,task_memcg=/user.slice/user-0.slice/session-4.scope,task=memkiller,pid=1968,uid=0
> Apr  4 09:08:53 debian kernel: [   65.481992] Out of memory: Killed process
> 1968 (memkiller) total-vm:2099436kB, anon-rss:1971712kB, file-rss:1024kB,
> shmem-rss:0kB, UID:0 pgtables:3904kB oom_score_adj:0
> ```
> 
> 
> > do not see a major concern from the oom POV. Nevertheless it would be
> > still good to consider whether this should be an opt-in behavior. I
> > personally do not see a major problem because most cpuset deployments I
> > have seen tend to be well partitioned so the new behavior makes more
> > sense.
> > 
> 
> Since memcgroup oom is mandatory, cpuset oom should preferably be mandatory
> as well. But we can still consider adding an option to user.
> 
> How about introduce `/proc/sys/vm/oom_in_cpuset`?

As I've said, I do not see any major concern having this behavior
implicit, the behavior makes semantic sense and it is also much more
likely that the selected oom victim will be a better choice than what we
do currently. Especially on properly partitioned systems with large
memory consumers in each partition (cpuset).

That being said, I would just not add any sysctl at this stage and
rather document the decision. If we ever encounter usecase(s) which
would regress based on this change we can introcuce the sysctl later.

-- 
Michal Hocko
SUSE Labs
