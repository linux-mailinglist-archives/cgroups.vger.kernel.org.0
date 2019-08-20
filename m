Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6E95C7D
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfHTKpe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 06:45:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:38624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbfHTKpe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 20 Aug 2019 06:45:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69F2AADD9;
        Tue, 20 Aug 2019 10:45:33 +0000 (UTC)
Date:   Tue, 20 Aug 2019 12:45:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 00/14] per memcg lru_lock
Message-ID: <20190820104532.GP3111@dhcp22.suse.cz>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 20-08-19 17:48:23, Alex Shi wrote:
> This patchset move lru_lock into lruvec, give a lru_lock for each of
> lruvec, thus bring a lru_lock for each of memcg.
> 
> Per memcg lru_lock would ease the lru_lock contention a lot in
> this patch series.
> 
> In some data center, containers are used widely to deploy different kind
> of services, then multiple memcgs share per node pgdat->lru_lock which
> cause heavy lock contentions when doing lru operation.

Having some real world workloads numbers would be more than useful
for a non trivial change like this. I believe googlers have tried
something like this in the past but then didn't have really a good
example of workloads that benefit. I might misremember though. Cc Hugh.

-- 
Michal Hocko
SUSE Labs
