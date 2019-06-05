Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67E435F0F
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfFEOUH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 10:20:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727893AbfFEOUG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 Jun 2019 10:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18EDEAF03;
        Wed,  5 Jun 2019 14:20:05 +0000 (UTC)
Date:   Wed, 5 Jun 2019 16:20:03 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        lizefan@huawei.com, tj@kernel.org, bristot@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Message-ID: <20190605142003.GD4255@blackbody.suse.cz>
References: <20190605114935.7683-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605114935.7683-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 05, 2019 at 01:49:35PM +0200, Juri Lelli <juri.lelli@redhat.com> wrote:
> Existing code comes with a comment saying the "we don't support RT-tasks
> being in separate groups".
I'm also inclined to this check not being completely correct.

This guard also prevents enabling cpu controller on unified hierarchy
with !CONFIG_RT_GROUP_SCHED. (If there are any kernel RT threads in root
cgroup, they can't be migrated to the newly create cpu controller's root
in cgroup_update_dfl_csses().)

I considered relaxing the check to non-root cgroups only, however, as
your example shows, it doesn't prevent reaching the avoided state by
other paths. I'm not that familiar with RT sched to tell whether
RT-priority tasks in different task_groups break any assumptions.

Michal
