Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B301B2A9EFD
	for <lists+cgroups@lfdr.de>; Fri,  6 Nov 2020 22:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKFVWU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Nov 2020 16:22:20 -0500
Received: from m12-13.163.com ([220.181.12.13]:47245 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFVWU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 6 Nov 2020 16:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=lcBJi
        p8ZNNvvSPADxy2tq0eOE8BhPbgY2uyruI3Bgms=; b=JWk5wGPQXlpX8nNKA/ARa
        vBuaMqLarm1G1WPJdbB9RJAgWydHW5CR3Tm/QZo3G/Tv67ogyLSyNpKckp8M10WG
        TQAViSZDY9fW0Xm4j2LXN1Bn+i/OZuAqP3ISd9QJ+Nyz3ZaNNwTzzz4b2tlTXZiF
        lQbu3sT5RkIOVx68MtMyKc=
Received: from localhost (unknown [101.86.208.122])
        by smtp9 (Coremail) with SMTP id DcCowAB3v2sMYqVf2GK5PA--.44977S2;
        Fri, 06 Nov 2020 22:47:40 +0800 (CST)
Date:   Fri, 6 Nov 2020 22:47:40 +0800
From:   Hui Su <sh_def@163.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] cgroup/cgroup.c: replace 'of->kn->priv' with of_cft()
Message-ID: <20201106144740.GA9692@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowAB3v2sMYqVf2GK5PA--.44977S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1rGrWfGFy8XFy3Jw13Arb_yoW8WFy3pF
        Z8A3yYkw45KF1DCr1qyFWq93WfKw4ftry7JF9rA34rtr129r1qqF1UCryjv3WYyF93Kr4a
        qrZ09ryUKw4rtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjiiDUUUUU=
X-Originating-IP: [101.86.208.122]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbipAzUX1r7rQdvUAAAsX
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

we have supplied the inline function: of_cft() in cgroup.h.

So replace the direct use 'of->kn->priv' with inline func
of_cft(), which is more readable.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/cgroup/cgroup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e41c21819ba0..078d7f167890 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3657,7 +3657,7 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
 
 static int cgroup_file_open(struct kernfs_open_file *of)
 {
-	struct cftype *cft = of->kn->priv;
+	struct cftype *cft = of_cft(of);
 
 	if (cft->open)
 		return cft->open(of);
@@ -3666,7 +3666,7 @@ static int cgroup_file_open(struct kernfs_open_file *of)
 
 static void cgroup_file_release(struct kernfs_open_file *of)
 {
-	struct cftype *cft = of->kn->priv;
+	struct cftype *cft = of_cft(of);
 
 	if (cft->release)
 		cft->release(of);
@@ -3677,7 +3677,7 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup *cgrp = of->kn->parent->priv;
-	struct cftype *cft = of->kn->priv;
+	struct cftype *cft = of_cft(of);
 	struct cgroup_subsys_state *css;
 	int ret;
 
@@ -3727,7 +3727,7 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 
 static __poll_t cgroup_file_poll(struct kernfs_open_file *of, poll_table *pt)
 {
-	struct cftype *cft = of->kn->priv;
+	struct cftype *cft = of_cft(of);
 
 	if (cft->poll)
 		return cft->poll(of, pt);
-- 
2.29.0


