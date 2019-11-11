Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD7F7496
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 14:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKKNPr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 08:15:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:44310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfKKNPq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 Nov 2019 08:15:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16B54ABE8;
        Mon, 11 Nov 2019 13:15:45 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:15:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH block/for-linus] cgroup,writeback: don't switch wbs
 immediately on dead wbs if the memcg is dead
Message-ID: <20191111131544.GJ1396@dhcp22.suse.cz>
References: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 08-11-19 12:18:29, Tejun Heo wrote:
> cgroup writeback tries to refresh the associated wb immediately if the
> current wb is dead.  This is to avoid keeping issuing IOs on the stale
> wb after memcg - blkcg association has changed (ie. when blkcg got
> disabled / enabled higher up in the hierarchy).
> 
> Unfortunately, the logic gets triggered spuriously on inodes which are
> associated with dead cgroups.  When the logic is triggered on dead
> cgroups, the attempt fails only after doing quite a bit of work
> allocating and initializing a new wb.
> 
> While c3aab9a0bd91 ("mm/filemap.c: don't initiate writeback if mapping
> has no dirty pages") alleviated the issue significantly as it now only
> triggers when the inode has dirty pages.  However, the condition can
> still be triggered before the inode is switched to a different cgroup
> and the logic simply doesn't make sense.
> 
> Skip the immediate switching if the associated memcg is dying.
> 
> This is a simplified version of the following two patches:
> 
>  * https://lore.kernel.org/linux-mm/20190513183053.GA73423@dennisz-mbp/
>  * http://lkml.kernel.org/r/156355839560.2063.5265687291430814589.stgit@buzz
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: e8a7abf5a5bd ("writeback: disassociate inodes from dying bdi_writebacks")

Is this a stable material?
-- 
Michal Hocko
SUSE Labs
