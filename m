Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF00F5854
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2019 21:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKHUSi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Nov 2019 15:18:38 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40015 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfKHUSi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Nov 2019 15:18:38 -0500
Received: by mail-qv1-f66.google.com with SMTP id i3so2525801qvv.7;
        Fri, 08 Nov 2019 12:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mmHw+HY13PqaN29edxW0jwM2upsZtKFfvy8blwuk5EA=;
        b=F/5JnOvRGR/owkxb4DztW+n7zGs189sEAWV39eXQk4xzNvkpizwtMmcepgldOnsXFs
         qDFk5wXMcC8oWq3/SZyeKhKf7ORtoyQppwrN1ZUPPhIfRFMxiwnkf3BhbAVqhgVgye4E
         GC0Y9LKpCNhnogVndaF7C1N5xjW0q4rvEqNjTKmCTYuV7zFnBCLtuuYlbQCIY4zCt0vK
         Vjry24hVxg+/3uHsGWWdGZwVxpJJlQhYy/6ZCVMtl409wgagTAVlIGMMmKknR8kquCPu
         EM0d9NnGEo6neLMdgHRI5PuhwaHt3qoHlOZQAyBiD7BxCNRTxy7iLhnvgpGO2Ps5A4VN
         u9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=mmHw+HY13PqaN29edxW0jwM2upsZtKFfvy8blwuk5EA=;
        b=joSJFhl1jadaYXGYxtvfz1YE7KvfbVAkyy9944m/krnMMOTEoq9iA3zptS05e6MS7E
         yCiqJkapHuwYNtoQySI/AhIiWv+j4MHW214UTTqltf6C7sJsqJOqNXa0IpC+FBS207f3
         BU+NhiWwKsy+ckwa4oQEh+OkxdE2msKNQA8o0lSGDNo5+sQxq6t9/mxN38pELyeRIlEe
         KyOoNeABHxiMw87rGdy2rl6V+TT81kAtRNFI9w91aFfUKdMrUo+NVrcj+qdqU8PrH8ud
         nIj0xdetoAxR9iQE6D5V00qWrecViuRR7FJle4lz/yqi7qOJ6Y+ThcHiMWtltXLKi4Dv
         8AZw==
X-Gm-Message-State: APjAAAUmSnHmojx0OKdpNMbRrD5nijuzWL0ai+LkQgBvNrA6wXi7h8Wf
        pgocrAGJBqgLRrng075+bvRb40eO
X-Google-Smtp-Source: APXvYqzHAramOoIzArIz/hiJ4LYuXFm+d83auENadtdOGznr2Ex3AST9b0WFgXmCLrK9+Mr+fvtX5w==
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr11442997qvb.8.1573244315130;
        Fri, 08 Nov 2019 12:18:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:a811])
        by smtp.gmail.com with ESMTPSA id l62sm3514612qkc.9.2019.11.08.12.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:18:33 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:18:29 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH block/for-linus] cgroup,writeback: don't switch wbs
 immediately on dead wbs if the memcg is dead
Message-ID: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup writeback tries to refresh the associated wb immediately if the
current wb is dead.  This is to avoid keeping issuing IOs on the stale
wb after memcg - blkcg association has changed (ie. when blkcg got
disabled / enabled higher up in the hierarchy).

Unfortunately, the logic gets triggered spuriously on inodes which are
associated with dead cgroups.  When the logic is triggered on dead
cgroups, the attempt fails only after doing quite a bit of work
allocating and initializing a new wb.

While c3aab9a0bd91 ("mm/filemap.c: don't initiate writeback if mapping
has no dirty pages") alleviated the issue significantly as it now only
triggers when the inode has dirty pages.  However, the condition can
still be triggered before the inode is switched to a different cgroup
and the logic simply doesn't make sense.

Skip the immediate switching if the associated memcg is dying.

This is a simplified version of the following two patches:

 * https://lore.kernel.org/linux-mm/20190513183053.GA73423@dennisz-mbp/
 * http://lkml.kernel.org/r/156355839560.2063.5265687291430814589.stgit@buzz

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: e8a7abf5a5bd ("writeback: disassociate inodes from dying bdi_writebacks")
---
 fs/fs-writeback.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8461a6322039..335607b8c5c0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -576,10 +576,13 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 	spin_unlock(&inode->i_lock);
 
 	/*
-	 * A dying wb indicates that the memcg-blkcg mapping has changed
-	 * and a new wb is already serving the memcg.  Switch immediately.
+	 * A dying wb indicates that either the blkcg associated with the
+	 * memcg changed or the associated memcg is dying.  In the first
+	 * case, a replacement wb should already be available and we should
+	 * refresh the wb immediately.  In the second case, trying to
+	 * refresh will keep failing.
 	 */
-	if (unlikely(wb_dying(wbc->wb)))
+	if (unlikely(wb_dying(wbc->wb) && !css_is_dying(wbc->wb->memcg_css)))
 		inode_switch_wbs(inode, wbc->wb_id);
 }
 EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
