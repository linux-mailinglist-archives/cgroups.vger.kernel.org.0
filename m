Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB71F7918
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 15:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFLN4Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 09:56:25 -0400
Received: from m12-15.163.com ([220.181.12.15]:37007 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgFLN4P (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 12 Jun 2020 09:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=L2UPa91bTaGr2nGxt5
        46epMlCxYbdwpTFHQ6idsU4S4=; b=DUtxQ+F39DdxT4/o5nwzw+dQRvWV6hXvsh
        cT+dsbwpbNQIrxYtZhf+JsJu7IGssukccNGHHleJPkYGyQmcDBM2Ki6cKLuwhgmj
        3BnWVewvWWhTvxJCDgX4EC9NL3hZe9qdxJRUAIio2uII9TsLxK1Yv4hVpxl291HM
        4Ye2IkZNA=
Received: from localhost.localdomain (unknown [111.202.190.28])
        by smtp11 (Coremail) with SMTP id D8CowABnbn5xieNeLmwJGg--.23390S2;
        Fri, 12 Jun 2020 21:56:02 +0800 (CST)
From:   zzuedu2000@163.com
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        weifenghai <zzuedu2000@163.com>
Subject: [PATCH] Fix code style same in one function
Date:   Fri, 12 Jun 2020 21:54:59 +0800
Message-Id: <20200612135459.28537-1-zzuedu2000@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowABnbn5xieNeLmwJGg--.23390S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW8JryrtFW5GrWfXFWfAFb_yoWxCrb_Z3
        s3Xw1xKryIyw1qyrZ8ZwsaqaykKayrKrWv9r17trW7AF1UJrs8JwnxKFn8JFsruwn3Cr98
        Ar93KF93tFsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjRVbtUUUUU==
X-Originating-IP: [111.202.190.28]
X-CM-SenderInfo: p22xvvbxsqiii6rwjhhfrp/1tbiJRJBQlUMYHoY5gAAsJ
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: weifenghai <zzuedu2000@163.com>

One line similar code before in this function

Signed-off-by: weifenghai <zzuedu2000@163.com>
---
 kernel/cgroup/cgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1ea181a58465..c3e6db6e44d8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4352,8 +4352,7 @@ static struct css_set *css_task_iter_next_css_set(struct css_task_iter *it)
 	}
 
 	/* find the next cset */
-	l = it->cset_pos;
-	l = l->next;
+	l = it->cset_pos->next;
 	if (l == it->cset_head) {
 		it->cset_pos = NULL;
 		return NULL;
-- 
2.17.1


