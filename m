Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF2214CC52
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2020 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgA2OXA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jan 2020 09:23:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgA2OW7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 Jan 2020 09:22:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F6EEB1A6;
        Wed, 29 Jan 2020 14:22:57 +0000 (UTC)
Date:   Wed, 29 Jan 2020 15:22:55 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, frextrite@gmail.com
Subject: Re: [PATCH] cgroup.c: Use built-in RCU list checking
Message-ID: <20200129142255.GE11384@blackbody.suse.cz>
References: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Sat, Jan 18, 2020 at 08:40:51AM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when  CONFIG_PROVE_RCU_LIST is enabled
> by default.
I assume if you've seen the RCU warning, you haven't seen the warning
from cgroup_assert_mutex_or_rcu_locked() above. 

The patch makes sense to me from the consistency POV.

Acked-by: Michal Koutný <mkoutny@suse.com>

Michal
