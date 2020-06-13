Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9BD1F801D
	for <lists+cgroups@lfdr.de>; Sat, 13 Jun 2020 03:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFMBI7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 21:08:59 -0400
Received: from m12-18.163.com ([220.181.12.18]:49567 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgFMBI6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 12 Jun 2020 21:08:58 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 21:08:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Kz/7X
        sIp5vi6UQF9WmOwilNhRidydQLpthW7IODNcgs=; b=ARwD0woT59rUntfmArYjg
        Zy7q5hAeeOd7TGZi9HMD0CI7ZoWn+7ai5MAb7A4uDoBLwct25tAZXe0UtswM4GEg
        Xi3wWybnIXg1/ZqMTK8seP3SFbGkaxvFGRC8AeyoA+ABx9TPcU4fSTwFytgYBZWI
        M8+8m+2BsIC3o8TNNl+CK0=
Received: from localhost.localdomain (unknown [111.202.190.28])
        by smtp14 (Coremail) with SMTP id EsCowADX3U1_I+Re+nFdFw--.10099S2;
        Sat, 13 Jun 2020 08:53:19 +0800 (CST)
From:   zzuedu2000@163.com
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        weifenghai <zzuedu2000@163.com>
Subject: [PATCH v2] Fix code style same in one function
Date:   Sat, 13 Jun 2020 08:53:06 +0800
Message-Id: <20200613005306.29988-1-zzuedu2000@163.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADX3U1_I+Re+nFdFw--.10099S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4fAF1Dur4xKryUtw1rXrb_yoWxZwc_Z3
        s3Xw1xKrySyw1qkrZ8Zws3Xa97KayrKrWv9r17KrWUAF1UJrs8JwnxKFn8JrsruFn3Cr90
        9r93KF93KFsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1VWlJUUUUU==
X-Originating-IP: [111.202.190.28]
X-CM-SenderInfo: p22xvvbxsqiii6rwjhhfrp/1tbiRx9CQlc7PsK9XAAAsp
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: weifenghai <zzuedu2000@163.com>

Combine two assignments for the variable “l” into one statement.

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


