Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0F5AD095
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiIEKu7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Sep 2022 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbiIEKu5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Sep 2022 06:50:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C94E631;
        Mon,  5 Sep 2022 03:50:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1563338825;
        Mon,  5 Sep 2022 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662375055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLtoVNiBT2iSspfGxmncgOVgViwjY/ew1M2VzEnJohU=;
        b=tuZx0thWhdDNLQb2iOtjt5nsAi8tSL9CQTYd6aMVNNn7Jqg9oia58Jq/f1/Sms2d4R34gW
        QbXNq3fv1IdAre7JAEgFELRSnd5gXYW7luDDTsw/ZANRbuHIjBY0zx6/uqDFGbNI7gKJ+O
        /yk03N/hMavkJrXpvO5kxs2pZgVdcUQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB231139C7;
        Mon,  5 Sep 2022 10:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A2UwN47UFWOIUQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Sep 2022 10:50:54 +0000
Date:   Mon, 5 Sep 2022 12:50:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
Message-ID: <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
 <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 05-09-22 18:30:55, Zhongkun He wrote:
> Hi Michal, thanks for your reply.
> 
> The current 'mempolicy' is hierarchically independent. The default value of
> the child is to inherit from the parent. The modification of the child
> policy will not be restricted by the parent.

This breaks cgroup fundamental property of hierarchical enforcement of
each property. And as such it is a no go.

> Of course, there are other options, such as the child's policy mode must be
> the same as the parent's. node can be the subset of parent's, but the
> interleave type will be complicated, that's why hierarchy independence is
> used. It would be better if you have other suggestions?

Honestly, I am not really sure cgroup cpusets is a great fit for this
usecase. It would be probably better to elaborate some more what are the
existing shortcomings and what you would like to achieve. Just stating
the syscall is a hard to use interface is not quite clear on its own.

Btw. have you noticed this question?

> > What is the hierarchical behavior of the policy? Say parent has a
> > stronger requirement (say bind) than a child (prefer)?
> > > How to use the mempolicy interface:
> > > 	echo prefer:2 > /sys/fs/cgroup/zz/cpuset.mems.policy
> > > 	echo bind:1-3 > /sys/fs/cgroup/zz/cpuset.mems.policy
> > >          echo interleave:0,1,2,3 >/sys/fs/cgroup/zz/cpuset.mems.policy
> > 
> > Am I just confused or did you really mean to combine all these
> > together?

-- 
Michal Hocko
SUSE Labs
