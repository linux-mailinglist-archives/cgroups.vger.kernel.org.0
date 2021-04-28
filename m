Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F8336D29A
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 08:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhD1Gyn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 02:54:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:49164 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232712AbhD1Gyn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 02:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=eADjA01K+TnHHtyYlBexLquKc6awC9QEfz0Y5YJanY8=; b=c7lGiwLJahOa7skwa+A
        4pEUvtkYVVy47AszeRrmITfHSoNZWUS+EpjqTU7FCA145mtUxdRjHlTZ0j4CclhjsrPbXpTUb0oqZ
        LuLvqq8GdR//Aq4aLh4CYkVFnByuq0SpgQWAJvu89tr558idsHE/2zqX9pQESJSVNWlLTwiUW/4=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbe57-001VkO-V6; Wed, 28 Apr 2021 09:53:57 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v4 13/16] memcg: enable accounting for file lock caches
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
Message-ID: <a83231d4-07ff-0859-e16b-6b1fc96cad2c@virtuozzo.com>
Date:   Wed, 28 Apr 2021 09:53:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

User can create file locks for each open file and force kernel
to allocate small but long-living objects per each open file.

It makes sense to account for these objects to limit the host's memory
consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/locks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6125d2d..fb751f3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -3007,10 +3007,12 @@ static int __init filelock_init(void)
 	int i;
 
 	flctx_cache = kmem_cache_create("file_lock_ctx",
-			sizeof(struct file_lock_context), 0, SLAB_PANIC, NULL);
+			sizeof(struct file_lock_context), 0,
+			SLAB_PANIC | SLAB_ACCOUNT, NULL);
 
 	filelock_cache = kmem_cache_create("file_lock_cache",
-			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
+			sizeof(struct file_lock), 0,
+			SLAB_PANIC | SLAB_ACCOUNT, NULL);
 
 	for_each_possible_cpu(i) {
 		struct file_lock_list_struct *fll = per_cpu_ptr(&file_lock_list, i);
-- 
1.8.3.1

