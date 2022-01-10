Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819F5489681
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 11:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244068AbiAJKiB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 05:38:01 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106]:13247 "EHLO
        proxmox-new.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244063AbiAJKh2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 05:37:28 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 94B3D45FC2;
        Mon, 10 Jan 2022 11:37:25 +0100 (CET)
From:   Wolfgang Bumiller <w.bumiller@proxmox.com>
To:     linux-block@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH linux] blk-cgroup: always terminate io.stat lines
Date:   Mon, 10 Jan 2022 11:37:24 +0100
Message-Id: <20220110103724.11743-1-w.bumiller@proxmox.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With the removal of seq_get_buf in blkcg_print_one_stat, we
cannot make adding the newline conditional on there being
relevant stats because the name has already been written
unconditionally.
Otherwise we may end up with multiple device names in one
line which is confusing and doesn't follow the nested-keyed
file format.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Fixes: 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")
---
I also switched to `seq_puts` as suggested by `checkpatch.pl`

This seemed like the simplest approach, so I thought I'd
send a patch.

On my physical machine, creating a new thin lv and starting
a container on it created lines such as

    253:10 253:5 rbytes=0 wbytes=0 rios=0 wios=1 dbytes=0 dios=0
    ^~~~~~ ^~~~~

This *looks* like the devices might just happen to have the
same stats, but that's not the case (and doesn't follow the
documented format).

With this patch this becomes:

    253:10
    253:5 rbytes=0 wbytes=0 rios=0 wios=1 dbytes=0 dios=0

Let me know if you prefer a different solution. I'm not sure
a temporary buffer that can be discarded would be much
better than the previous seq_get_buf() version. Otherwise
we'd need to change the `pd_stat_fn` interface to collect
the data separately and do the formatting afterwards I
suppose?

 block/blk-cgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 663aabfeba18..e3e3e826dff7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -937,8 +937,7 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 			has_stats = true;
 	}
 
-	if (has_stats)
-		seq_printf(s, "\n");
+	seq_puts(s, "\n");
 }
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
-- 
2.30.2


