Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D7ECF6F
	for <lists+cgroups@lfdr.de>; Sat,  2 Nov 2019 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfKBPQh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Nov 2019 11:16:37 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42376 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbfKBPQh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Nov 2019 11:16:37 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 941382E099D;
        Sat,  2 Nov 2019 18:16:34 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id UjI6F08SWn-GXjiaB0J;
        Sat, 02 Nov 2019 18:16:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572707794; bh=AR0posdeGGjRMOUjYp9dgJq5OCpwQBAAcmepPzGDKWg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=X9dFktO77Na/G0mtC2+xSzpD1cMLgWOkM1P9fpb+ypv5Obc9xW91WTB8Mc1xm15fI
         f+vjegUUhK0i7hnoRfJ+Na/UVVXYuRet+Jx2AzVkMEQdB23FUCLveNYbe34Rajfqob
         WnSYBjjQfRvF4wy/a3HK7oM0Cf0Nz8wpJRNk4zps=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by vla1-5826f599457c.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id kxXcRS1iUB-GXVOVCeE;
        Sat, 02 Nov 2019 18:16:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Date:   Sat, 02 Nov 2019 18:16:33 +0300
Message-ID: <157270779336.1961.6528158720593572480.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
charge path") memcg invokes oom killer not only for user page-faults.
This means 0-order allocation will either succeed or task get killed.

Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5361ebec3361..eb47815e137b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
 
 		Failed allocation in its turn could be returned into
 		userspace as -ENOMEM or silently ignored in cases like
-		disk readahead.  For now OOM in memory cgroup kills
-		tasks iff shortage has happened inside page fault.
+		disk readahead.
+
+		Before 4.19 OOM in memory cgroup killed tasks iff
+		shortage has happened inside page fault, random
+		syscall may fail with ENOMEM or EFAULT. Since 4.19
+		failed memory cgroup allocation invokes oom killer and
+		keeps retrying until it succeeds.
 
 		This event is not raised if the OOM killer is not
 		considered as an option, e.g. for failed high-order

