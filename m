Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2F65469
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2019 12:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfGKKTv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jul 2019 06:19:51 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:52810 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727680AbfGKKTv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jul 2019 06:19:51 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id AB3742E1481;
        Thu, 11 Jul 2019 13:19:47 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id b0auxpRfBi-Jlta1N2Q;
        Thu, 11 Jul 2019 13:19:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1562840387; bh=Ys/8HwYgsYPGqfQr/FHJcIRKRrAYML5U69Kc2WYjDvw=;
        h=Message-ID:Date:To:From:Subject;
        b=KvoWyHT9WLqdhruSCfWOW/9NrniMBswJbPhJkmkMoI/vVJeKOmJXo1FEDgeIQ75oy
         L9rc06kE1tvrVw0vxT32b+rShXsM2E4kqa2lvIf3YuL4ooTJ3uU3Hvd8jrVdrFNTYM
         qy1RbiYRz4kixZ4D5cPi+Y+aMO8Dvx1Kn32xZ1R0=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fce8:911:2fe8:4dfb])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id vadUe64BOT-JlwmFrYr;
        Thu, 11 Jul 2019 13:19:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] MAINTAINERS: add entry for block io cgroup
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Date:   Thu, 11 Jul 2019 13:19:47 +0300
Message-ID: <156284038698.3851.6531328622774377848.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This links mailing list cgroups@vger.kernel.org with related files.

$ ./scripts/get_maintainer.pl -f block/blk-cgroup.c
Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
cgroups@vger.kernel.org (open list:CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO))
linux-block@vger.kernel.org (open list:BLOCK LAYER)
linux-kernel@vger.kernel.org (open list)

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43ca94856944..906ba9ca015a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4148,6 +4148,15 @@ S:	Maintained
 F:	mm/memcontrol.c
 F:	mm/swap_cgroup.c
 
+CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
+L:	cgroups@vger.kernel.org
+F:	Documentation/cgroup-v1/blkio-controller.rst
+F:	block/blk-cgroup.c
+F:	include/linux/blk-cgroup.h
+F:	block/blk-throttle.c
+F:	block/blk-iolatency.c
+F:	block/bfq-cgroup.c
+
 CORETEMP HARDWARE MONITORING DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
 L:	linux-hwmon@vger.kernel.org

