Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A124B1A6079
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2020 22:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgDLUZq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Apr 2020 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUZp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Apr 2020 16:25:45 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41C9C0A3BF0
        for <cgroups@vger.kernel.org>; Sun, 12 Apr 2020 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586723144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7C3D22+bfcyONw5l0dvYrkLR9HBNKhS92euE1BouTaU=;
        b=hFzSbQYZ9xcu/+suXp8oXlH9uQ5qnYI6BNpuJdeiYVg1EAvXJ2876us3aKw9s+JjAVd3UW
        Tdy3FkW7edV/A+3iPe8s4/nNp6K6yFJhZboFdfTFDkrwXaZgm7ET9bOXXFgdA9n/ljl7ek
        v7AKqcjCAHQ4l9x3OLyFTrVtCQvWlnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-U4fa6Hs1NyOaO2w4RMeAcQ-1; Sun, 12 Apr 2020 16:25:42 -0400
X-MC-Unique: U4fa6Hs1NyOaO2w4RMeAcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7D01005509;
        Sun, 12 Apr 2020 20:25:40 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FC75D9C9;
        Sun, 12 Apr 2020 20:25:34 +0000 (UTC)
Date:   Sun, 12 Apr 2020 22:25:33 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] clone3: fix cgroup argument sanity check
Message-ID: <20200412202533.GA29554@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Checking that cgroup field value of struct clone_args is less than 0
is useless, as it is defined as unsigned 64-bit integer.  Moreover,
it doesn't catch the situations where its higher bits are lost during
the assignment to the cgroup field of the cgroup field of the internal
struct kernel_clone_args (where it is declared as signed 32-bit
integer), so it is still possible to pass garbage there.  A check
against INT_MAX solves both these issues.

Fixes: ef2c41cf38a7559b ("clone3: allow spawning processes into cgroups")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4385f3d..b4f7775 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2631,7 +2631,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     !valid_signal(args.exit_signal)))
 		return -EINVAL;
 
-	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
+	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup > INT_MAX)
 		return -EINVAL;
 
 	*kargs = (struct kernel_clone_args){
-- 
2.1.4

