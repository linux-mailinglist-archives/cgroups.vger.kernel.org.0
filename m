Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A507367965
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 07:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhDVFpA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 01:45:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:33780 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232783AbhDVFo7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 01:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=JRp6H7IPfoU4D8K87emG7TmGRk0/tu3o/Uod9peVFD0=; b=mM9hGPjSYiPNoNsKUuV
        AjkCi4SdfWsvTqyjNi3IVBabZ28feDEaEO/p13wzqAZ5vQtd0LeMCkxctPCFV2kLomCX5O97rBtPl
        X0PJGMTgIyTQDbtIkgvJ1Vta8mySG73Q7EYIkeBEfTvqj4XcNstPVBc/8h4hVnCyNWmLsRvdDoE=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZS8O-0019Op-NN; Thu, 22 Apr 2021 08:44:16 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] memcg: enable accounting for pids in nested pid namespaces
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, Roman Gushchin <guro@fb.com>
Message-ID: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
Date:   Thu, 22 Apr 2021 08:44:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

init_pid_ns.pid_cachep have enabled memcg accounting, though this
setting was disabled for nested pid namespaces.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/pid_namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 6cd6715..a46a372 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -51,7 +51,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 	mutex_lock(&pid_caches_mutex);
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)
-		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
+		*pkc = kmem_cache_create(name, len, 0,
+					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
 	mutex_unlock(&pid_caches_mutex);
 	/* current can fail, but someone else can succeed. */
 	return READ_ONCE(*pkc);
-- 
1.8.3.1

