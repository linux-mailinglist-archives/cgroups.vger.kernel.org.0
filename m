Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2CF4B4EA
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2019 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfFSJ3J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jun 2019 05:29:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731267AbfFSJ3J (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 19 Jun 2019 05:29:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28762ADCF;
        Wed, 19 Jun 2019 09:29:07 +0000 (UTC)
Date:   Wed, 19 Jun 2019 11:29:05 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        lizefan@huawei.com, tj@kernel.org, bristot@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Message-ID: <20190619092904.GB28937@blackbody.suse.cz>
References: <20190605114935.7683-1-juri.lelli@redhat.com>
 <20190605142003.GD4255@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605142003.GD4255@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 05, 2019 at 04:20:03PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> I considered relaxing the check to non-root cgroups only, however, as
> your example shows, it doesn't prevent reaching the avoided state by
> other paths. I'm not that familiar with RT sched to tell whether
> RT-priority tasks in different task_groups break any assumptions.
So I had another look and the check is bogus.

The RT sched with !CONFIG_RT_GROUP_SCHED works only with the struct
rt_rq embedded in the generic struct rq -- regardless of the task's
membership in the cpu controller hierarchy.

Perhaps, the commit message may mention this also prevents enabling cpu
controller on unified hierarchy (if there are any (kernel) RT tasks to
migrate).

Reviewed-by: Michal Koutný <mkoutny@suse.com>
