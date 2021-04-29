Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E189A36E9E9
	for <lists+cgroups@lfdr.de>; Thu, 29 Apr 2021 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhD2MCd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 08:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhD2MCc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Apr 2021 08:02:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A861B61419;
        Thu, 29 Apr 2021 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619697706;
        bh=oPVrQiSH4gJIxWe/7Tc1T6o/zmAuBj23mR9CFaPe9Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/Rdo/fHTGnVIBbJz0jV8Xe2zbhkNwR9FsQ2+YHjQ+7djeQd0OSGTeYDr0Hyt12Tg
         Ol/URpqxTpjc39VJS6FwwaFoSLdWhwunRvF4iuiKFG4b1SoM0PLaLED4dYy8bog06d
         aNWyc41AuDorgahEE1kNWQUzQfSZ8yKoNUg1sBGDMXNs/IzJYZxv7dlq4kVbFhgbAO
         dF+y6vCHMJKfux3+X3lPM3P8EecWB2HJM0SkFdLO2WKQWcOL/MkKG3sV4YW3ocAfll
         IzgpgrWk1D5KOdYFcF1pU663y+6nOFAIo/96qKA5WZ/fy/ostj31PLMvgNqmZutgt9
         nByaTNrt+aOCg==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/5] docs/cgroup: add entry for cgroup.kill
Date:   Thu, 29 Apr 2021 14:01:10 +0200
Message-Id: <20210429120113.2238065-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429120113.2238065-1-brauner@kernel.org>
References: <20210429120113.2238065-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=zdu4cmCLHejWfxLXMelts0rSpFC8qk9wZuoiNeHiin8=; m=SRUO7ECCJdmyQqtIGwezbQYBmVqDy58ZZVeuAj3zKFE=; p=0ci6uDrNMNAHyuiWphLFOjQxb2XU8g/0765TlJFNxys=; g=654f7db5e48154e47022c1f4f7ff4a3492ea73b8
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIqfXAAKCRCRxhvAZXjcog0JAQD3hDb 5zfKHddDSb68cADwDRJ8rXFDSambeMnxGE8H+RQD+NyjPFqRbvCUojq3mgnqI0XUojNXcWMcwqx/m OMdnrg8=
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
 Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 64c62b979f2f..c9f656a84590 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -949,6 +949,23 @@ All cgroup core files are prefixed with "cgroup."
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
+	is protected against migrations. If callers require strict guarantees
+	they can issue the cgroup.kill request after a freezing the cgroup via
+	cgroup.freeze.
+
+	In a threaded cgroup, writing this file fails with EOPNOTSUPP as
+	killing cgroups is a process directed operation, i.e. it affects
+	the whole thread-group.
+
 Controllers
 ===========
 
-- 
2.27.0

