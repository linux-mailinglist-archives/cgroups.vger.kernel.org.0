Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10854764C7
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2019 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfGZLrf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Jul 2019 07:47:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfGZLre (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Jul 2019 07:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ns01a/+dJBOEjeT/1CWh/+CD7/ir0pFGY6xdTOQcPbo=; b=UP9N99OCHIHEjE6YNaXL68byYU
        T9OJh95quUUTHJmwl1TlhrNz3vPuPsRL/wcHureyhjtx5cqyF5XtXCwM6My/a2IaX/vVEUGlLAlO3
        tccfZ5isggOwEGTdT6AOhuXMTLPlhENjcDg5T+DxsqsofwgGP8JzQ/XKnUl9EP9tx0dqglHSrS2Ww
        ezZ6hkOBtGKC8sZ208lIhOiNGGIqQLhhp65h+1Zcsb9nzvCs2Vttku+Za3kWcsGeTlYn+bLwAnoCI
        kMJymY+XshcL8KCiZDeMtN6R7Y3+9D/BAISo0T1XS5qy4chqi/mR24cmui7/zDBhgQKrqm0HIZz9p
        8nlVayPQ==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqyh9-0003Bb-4m; Fri, 26 Jul 2019 11:47:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hqyh7-0000u9-3J; Fri, 26 Jul 2019 08:47:29 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 5/7] docs: cgroup-v1/blkio-controller.rst: remove a CFQ left over
Date:   Fri, 26 Jul 2019 08:47:25 -0300
Message-Id: <21b9281684395202d815d574121df89fa0c7ac62.1564140865.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564140865.git.mchehab+samsung@kernel.org>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

changeset fb5772cbfe48 ("blkio-controller.txt: Remove references to CFQ")
removed cgroup references to CFQ, but it kept one left. Get rid of
it.

Fixes: fb5772cbfe48 ("blkio-controller.txt: Remove references to CFQ")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/cgroup-v1/blkio-controller.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
index 1d7d962933be..36d43ae7dc13 100644
--- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+++ b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
@@ -130,12 +130,6 @@ Proportional weight policy files
 	    dev     weight
 	    8:16    300
 
-- blkio.leaf_weight[_device]
-	- Equivalents of blkio.weight[_device] for the purpose of
-          deciding how much weight tasks in the given cgroup has while
-          competing with the cgroup's child cgroups. For details,
-          please refer to Documentation/block/cfq-iosched.txt.
-
 - blkio.time
 	- disk time allocated to cgroup per device in milliseconds. First
 	  two fields specify the major and minor number of the device and
-- 
2.21.0

