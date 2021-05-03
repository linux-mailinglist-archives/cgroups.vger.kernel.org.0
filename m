Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C23716CB
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhECOlS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 10:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhECOlO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 10:41:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4A45611C2;
        Mon,  3 May 2021 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620052821;
        bh=M4EXOTfvJcdiJj/6VcTRH46aBcRh/Z514kkpJDLLnpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOPUaVmV7dXMqP/eXQfQruUy5nZLWkamI+xh/KER6jdUiKF/sqT9lllnwmkeoV99M
         PjmuSrZWIJTLqLxXJQqSWFFFS9fnxxxLKwMctaFLO1fp0WKGZ2POLtaRvv0D1tKtu0
         mN4uKC1qlWbrgEff0Jy44ov8s2h0ETyBa4eDIxewN41dlcqLtMFpXDCYkClHLBK8d4
         d4VwNQxcllqyiHuMStQ7BnuC30KKuPhUWQy9343Qg1zlV5WJU5/gmA8L+rDY9/v/st
         915nJx+S2U4m0o7O3scjrR8Ut44itZCsspnpp6Nkd58p2ZAy2LPpKMuOWXC8xtKuPS
         HWdw7AwC5GdLA==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/5] docs/cgroup: add entry for cgroup.kill
Date:   Mon,  3 May 2021 16:39:20 +0200
Message-Id: <20210503143922.3093755-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210503143922.3093755-1-brauner@kernel.org>
References: <20210503143922.3093755-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=zdu4cmCLHejWfxLXMelts0rSpFC8qk9wZuoiNeHiin8=; m=SRUO7ECCJdmyQqtIGwezbQYBmVqDy58ZZVeuAj3zKFE=; p=y57GkHCBx4K2DRLBiMddNPtk4ONjJhS+uFuQ+wSoBJI=; g=f66b8ed84f77326338a4318eeab17fe419bdcba3
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJAK7wAKCRCRxhvAZXjcoiHWAQCmjxf FXQESMYGXErTmSaI8KvkvCl38Lqwp4M0bAXjsUgD+K3SFcFgD3YeTxNB7LbJtbp+WY2Qq+7BYsZQq l2pFSAc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Give a brief overview of the cgroup.kill functionality.

Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Roman Gushchin <guro@fb.com>:
  - Drop sentence that mentions combined useage of cgroup.kill and
    cgroup.freezer.
---
 Documentation/admin-guide/cgroup-v2.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 64c62b979f2f..6adc749d863e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -949,6 +949,21 @@ All cgroup core files are prefixed with "cgroup."
 	it's possible to delete a frozen (and empty) cgroup, as well as
 	create new sub-cgroups.
 
+  cgroup.kill
+	A write-only single value file which exists in non-root cgroups.
+	The only allowed value is "1".
+
+	Writing "1" to the file causes the cgroup and all descendant cgroups to
+	be killed. This means that all processes located in the affected cgroup
+	tree will be killed via SIGKILL.
+
+	Killing a cgroup tree will deal with concurrent forks appropriately and
+	is protected against migrations.
+
+	In a threaded cgroup, writing this file fails with EOPNOTSUPP as
+	killing cgroups is a process directed operation, i.e. it affects
+	the whole thread-group.
+
 Controllers
 ===========
 
-- 
2.27.0

