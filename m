Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2205841767D
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346672AbhIXODa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 10:03:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44418 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346646AbhIXOD3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 10:03:29 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id A70D922441;
        Fri, 24 Sep 2021 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632492114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmtnQno5WAWYAwYyFrab1anhvWM53F0z0kxqT7Xw1k8=;
        b=nRbMdbYvkFc6B1k0PP9awPeMPmfeeTv3mNv/96g99J9pGTDnAplSR8wAChc7G9xWP98BoD
        gCteNo/1Cqk0O16O2ECCm4MqbJoI9lTh3LJINeTuulQtUUK0k+fNPQIAcU5EIOz6TGODVL
        LwxJX5IWJ/ZTtg+XuAvIrWloxnzE3jg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 9052025DA7;
        Fri, 24 Sep 2021 14:01:54 +0000 (UTC)
Date:   Fri, 24 Sep 2021 16:01:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] mem_cgroup: optimize the atomic count of
 wb_completion
Message-ID: <YU3aT7i2vBNxewam@dhcp22.suse.cz>
References: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
 <YU2boTZhfbo0h/Xi@dhcp22.suse.cz>
 <03145735-7764-4cd4-e15b-60402f4b447e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03145735-7764-4cd4-e15b-60402f4b447e@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 24-09-21 21:02:52, brookxu wrote:
> Thanks for your time.
> 
> Michal Hocko wrote on 2021/9/24 17:34:
> > On Fri 24-09-21 14:46:22, brookxu wrote:
> >> From: Chunguang Xu <brookxu@tencent.com>
> >>
> >> In order to track inflight foreign writeback, we init
> >> wb_completion.cnt to 1. For normal writeback, this cause
> >> wb_wait_for_completion() to perform meaningless atomic
> >> operations. Since foreign writebacks rarely occur in most
> >> scenarios, we can init wb_completion.cnt to 0 and set
> >> frn.done.cnt to 1. In this way we can avoid unnecessary
> >> atomic operations.
> > 
> > Does this lead to any measurable differences?
> 
> I created multiple cgroups that performed IO on multiple disks, 
> then flushed the cache with sync command, and no measurable
> differences have been observed so far.

OK, so why do we want to optimize this code?
-- 
Michal Hocko
SUSE Labs
