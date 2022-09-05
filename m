Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9288D5ACB4D
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiIEGp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Sep 2022 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiIEGp2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Sep 2022 02:45:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCA11BE9B;
        Sun,  4 Sep 2022 23:45:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C926D5D8D4;
        Mon,  5 Sep 2022 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662360325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPt2cENEN10WmmgHREJgk8hsqDksK88YmLcQYRTdLds=;
        b=CEJnFxSe55CXW/6IMWShpBBfRLm1buiiB2ggpdNYYoBCOu0aMDuAed1Xd5WMZm32NhtNYZ
        XJe8aqLvx3S4TOVWUOzw2N13lVuCDbBUuKwoLKkgnhyxbLXBwtcB2TLtmk+mxCIFFsTptM
        WJN/ylYgngESJjmvw+4/KkBAt6x9SPM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A697F139C7;
        Mon,  5 Sep 2022 06:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F6o4JgWbFWMCXwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Sep 2022 06:45:25 +0000
Date:   Mon, 5 Sep 2022 08:45:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     hezhongkun <hezhongkun.hzk@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
Subject: Re: [PATCH] cgroup/cpuset: Add a new isolated mems.policy type.
Message-ID: <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 04-09-22 12:02:41, hezhongkun wrote:
> From: Zhongkun He <hezhongkun.hzk@bytedance.com>
> 
> Mempolicy is difficult to use because it is set in-process
> via a system call. We want to make it easier to use mempolicy
> in cpuset, and  we can control low-priority cgroups to
> allocate memory in specified nodes. So this patch want to
> adds the mempolicy interface in cpuset.
> 
> The mempolicy priority of cpuset is lower than the task.
> The order of getting the policy is:
> 	1) vma mempolicy
> 	2) task->mempolicy
> 	3) cpuset->mempolicy
> 	4) default policy.
> 
> cpuset's policy is owned by itself, but descendants will
> get the default mempolicy from parent.

What is the hierarchical behavior of the policy? Say parent has a
stronger requirement (say bind) than a child (prefer)?
 
> How to use the mempolicy interface:
> 	echo prefer:2 > /sys/fs/cgroup/zz/cpuset.mems.policy
> 	echo bind:1-3 > /sys/fs/cgroup/zz/cpuset.mems.policy
>         echo interleave:0,1,2,3 >/sys/fs/cgroup/zz/cpuset.mems.policy

Am I just confused or did you really mean to combine all these
together?
-- 
Michal Hocko
SUSE Labs
