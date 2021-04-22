Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E90F367ED3
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 12:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhDVKi2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 06:38:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:33740 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235097AbhDVKi2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 06:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=qAU9YX3Sw8E0MYtMB0gH0qiMpEWaFW5TOOeksZRhni0=; b=sPiP+8WPjNXo7HhQ5GR
        0mROpfdtq8E3bWLRf5Kv9c7tp/874x+TynqruTDgcx3re8Ggnpc0vrY9oVd6/PClxm+OP/F3h6ghK
        JDgRCT70mTVo9mMdiRgsVUibVPaqNDZeBeIZ3OYcJ5wKu+Q9Jc1WK8Rs9xBe2P7AqsMrXbwp5KY=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZWiR-001ANC-FI; Thu, 22 Apr 2021 13:37:47 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v3 14/16] memcg: enable accounting for fasync_cache
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
Message-ID: <72930380-bf7e-c022-7869-2cc3ed8db5f5@virtuozzo.com>
Date:   Thu, 22 Apr 2021 13:37:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

fasync_struct is used by almost all character device drivers to set up
the fasync queue, and for regular files by the file lease code.
This structure is quite small but long-living and it can be assigned
for any open file.

It makes sense to account for its allocations to restrict the host's
memory consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fcntl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index dfc72f1..7941559 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1049,7 +1049,8 @@ static int __init fcntl_init(void)
 			__FMODE_EXEC | __FMODE_NONOTIFY));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
-		sizeof(struct fasync_struct), 0, SLAB_PANIC, NULL);
+					 sizeof(struct fasync_struct), 0,
+					 SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	return 0;
 }
 
-- 
1.8.3.1

