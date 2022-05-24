Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF945532816
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiEXKrc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEXKrb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 06:47:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A35F276;
        Tue, 24 May 2022 03:47:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A43C61F8B8;
        Tue, 24 May 2022 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653389249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/JkmIrb3U0V/yu8PhyV+N8XrbjKAUo7AoBVKzx+G8o=;
        b=Rb3brHeSayt8ozGawjFpwJcpvr999BpR3pDQSkTLuEcz3hN1uVvTRiwpyoqnj5WBbqdbfP
        /TQRnq2orPaNUKVKgZnKJ3ryV4w0E7kHBeTVB+jZF4GkIEu7LsnZuQ7uoEYsdoPSKyWcFL
        gpRbufrymhC1QhjhY7nO7Vta82G2XVw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 360582C141;
        Tue, 24 May 2022 10:47:28 +0000 (UTC)
Date:   Tue, 24 May 2022 12:47:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     hezhongkun <hezhongkun.hzk@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com
Subject: Re: [PATCH] mm: memcontrol: add the mempolicy interface for cgroup
 v2.
Message-ID: <Yoy3wDh0cvziWGHJ@dhcp22.suse.cz>
References: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 24-05-22 18:36:38, hezhongkun wrote:
> From: Hezhongkun <hezhongkun.hzk@bytedance.com>
> 
> Mempolicy is difficult to use because it is set in-process
> via a system call. We want to make it easier to use mempolicy
> in cgroups, so that we can control low-priority cgroups to
> allocate memory in specified nodes. So this patch want to
> adds the mempolicy interface.
> 
> the mempolicy priority of memcgroup is higher than the priority
> of task. The order of getting the policy is,
> memcgroup->policy,task->policy or vma policy, default policy.
> memcgroup's policy is owned by itself, so descendants will
> not inherit it.

Why cannot you use cpuset cgroup?
-- 
Michal Hocko
SUSE Labs
