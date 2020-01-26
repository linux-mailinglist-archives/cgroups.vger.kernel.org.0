Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25D0149A32
	for <lists+cgroups@lfdr.de>; Sun, 26 Jan 2020 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAZKqD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jan 2020 05:46:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:37977 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbgAZKqC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 26 Jan 2020 05:46:02 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ivfQS-0007U6-35; Sun, 26 Jan 2020 13:45:56 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/2] cgroup_pidlist_next should update position index
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Message-ID: <5c226d54-cd14-4fb1-c76f-4b4ca5d83476@virtuozzo.com>
Date:   Sun, 26 Jan 2020 13:45:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/cgroup/cgroup-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 09f3a41..84bedb8 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -473,6 +473,7 @@ static void *cgroup_pidlist_next(struct seq_file *s, void *v, loff_t *pos)
 	 */
 	p++;
 	if (p >= end) {
+		(*pos)++;
 		return NULL;
 	} else {
 		*pos = *p;
-- 
1.8.3.1

