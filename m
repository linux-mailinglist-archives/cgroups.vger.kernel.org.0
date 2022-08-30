Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A356D5A66B1
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH3Ox5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH3Ox4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 10:53:56 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 07:53:55 PDT
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97911B60E;
        Tue, 30 Aug 2022 07:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661870308; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=YccQlM0YpBZa8BEArecQTA/6YF3Z9UEqrKSzACVcZD2uKnsF9OoZFjYibUi5Yuh2P7nIGWDL+8uAYTJlzygMm07JQmQhprUKxyiMthxbaIdNKyjFbmzjnWxQT2ilYjtpMUzvVocrbjUcdwEKz8ifN5vI23KliK0U8vfO8sgNpuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1661870308; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=bDHqoi1ggUNw44SWIfwig+ES6dxTzwOKO9MpudL0Flc=; 
        b=nhFmY+FTBOjVNmgnBSKkRto17smjv/TOaAIyAvdiRK8vq7/N3t1s3NUoAV6zmZrFAWDPxYY6exMcrE+nhCQtUsxCW2nY/dir5vXI0jidR2ryD4KYM9ibMM8v2ecYHmMbqNVT6kFkrzagVIsxqC9/TQf2D6xHjYzTPV0BHnmEtJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1661870307439465.9202214426898; Tue, 30 Aug 2022 07:38:27 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:38:27 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "axboe" <axboe@kernel.dk>
Cc:     "linux-block" <linux-block@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "cgroups" <cgroups@vger.kernel.org>,
        "josef" <josef@toxicpanda.com>,
        "asmlsilence" <asml.silence@gmail.com>,
        "minglei" <ming.lei@redhat.com>, "bvanassche" <bvanassche@acm.org>
Message-ID: <182ef30785e.c6f6f47035469.3423320276766255135@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH] iocost_monitor: reorder BlkgIterator
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In order to comply with PEP 8, the first parameter of a class should be
__init__.

Signed-off-by: Elijah Conners <business@elijahpepe.com> 
---
 tools/cgroup/iocost_monitor.py                |  10 +-
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index c4ff907c078b..0dbbc67400fc 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -61,6 +61,11 @@ autop_names = {
 }

 class BlkgIterator:
+    def __init__(self, root_blkcg, q_id, include_dying=False):
+        self.include_dying = include_dying
+        self.blkgs = []
+        self.walk(root_blkcg, q_id, '')
+
     def blkcg_name(blkcg):
         return blkcg.css.cgroup.kn.name.string_().decode('utf-8')

@@ -82,11 +87,6 @@ class BlkgIterator:
                                      blkcg.css.children.address_of_(), 'css.sibling'):
             self.walk(c, q_id, path)

-    def __init__(self, root_blkcg, q_id, include_dying=False):
-        self.include_dying = include_dying
-        self.blkgs = []
-        self.walk(root_blkcg, q_id, '')
-
     def __iter__(self):
         return iter(self.blkgs)

--
2.25.1
