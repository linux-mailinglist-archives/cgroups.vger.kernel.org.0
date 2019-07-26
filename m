Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2C77222
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2019 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfGZT3U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Jul 2019 15:29:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfGZT3U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Jul 2019 15:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ns01a/+dJBOEjeT/1CWh/+CD7/ir0pFGY6xdTOQcPbo=; b=IHzfhfoSB3RigJZKXgA69tpIeY
        uJU4NTCegW0XVP4J9jLhGvyOVRNehr61tOVVCQJ7JIzfoetv3U29Z+ipmcEcI/HIGufUzderBSp8Y
        nr2XwQ6oVIdWZGg3h3ppChnhLa/TP7+t6B/4CvN91rFN7IWqgQdV/3hmbeCEVMIBAgK5QMbQaK2mi
        wPNdNxFaNzD9TaSygnBTiI7DZphoA0g9/1XBVI9dRwyKoPg6Rny/0YpN8g7NI11Et/tDrVba+P10P
        pfK0fHEpeglcz/LBuNgBwcrKVczR1rvTlH3j7B3xpR5AY3ZnpPsEathZ1LH5OGQidg14Ckb7fmMx2
        6bveAY0Q==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5u2-00046y-Ud; Fri, 26 Jul 2019 19:29:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr5tz-0004ym-Lg; Fri, 26 Jul 2019 16:29:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 4/5] docs: cgroup-v1/blkio-controller.rst: remove a CFQ left over
Date:   Fri, 26 Jul 2019 16:29:13 -0300
Message-Id: <553b460b2352f7ed741c0f71ee777ae9c9c5ff5c.1564169297.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
References: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

