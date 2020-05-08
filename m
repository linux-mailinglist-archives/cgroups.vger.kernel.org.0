Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4A1CB186
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHOQe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 10:16:34 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56418 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbgEHOQe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 10:16:34 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9C6732E0997;
        Fri,  8 May 2020 17:16:31 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id DzB0dpFFbi-GTXSjfvG;
        Fri, 08 May 2020 17:16:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588947391; bh=Kz8084Qd+ukMFtBduY70Wrn/hOXrye0GrRmcB96gXCQ=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=Dj8/u6gZYmMA/f3gA/Gqiy6C2yfCTKO//L+zyCsxYhibDXK2RnLGgmSAlaRXqqzlw
         Tq4x4ndeaEZyJGVAZxWLr/JJnElxICKB49ARgoON0n79PGht6cp9Htyk3J3iszXQle
         cbNDkAqPk/3XuNtXYZDXX5+C1gTBipR7wPmNTtdg=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id tvHw4hmnaj-GTWWnWM4;
        Fri, 08 May 2020 17:16:29 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH] doc: cgroup: update note about conditions when oom killer is
 invoked
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
Date:   Fri, 08 May 2020 17:16:29 +0300
Message-ID: <158894738928.208854.5244393925922074518.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Starting from v4.19 commit 29ef680ae7c2 ("memcg, oom: move out_of_memory
back to the charge path") cgroup oom killer is no longer invoked only from
page faults. Now it implements the same semantics as global OOM killer:
allocation context invokes OOM killer and keeps retrying until success.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/admin-guide/cgroup-v2.rst |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index bcc80269bb6a..1bb9a8f6ebe1 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1172,6 +1172,13 @@ PAGE_SIZE multiple when read back.
 	Under certain circumstances, the usage may go over the limit
 	temporarily.
 
+	In default configuration regular 0-order allocation always
+	succeed unless OOM killer choose current task as a victim.
+
+	Some kinds of allocations don't invoke the OOM killer.
+	Caller could retry them differently, return into userspace
+	as -ENOMEM or silently ignore in cases like disk readahead.
+
 	This is the ultimate protection mechanism.  As long as the
 	high limit is used and monitored properly, this limit's
 	utility is limited to providing the final safety net.
@@ -1228,17 +1235,9 @@ PAGE_SIZE multiple when read back.
 		The number of time the cgroup's memory usage was
 		reached the limit and allocation was about to fail.
 
-		Depending on context result could be invocation of OOM
-		killer and retrying allocation or failing allocation.
-
-		Failed allocation in its turn could be returned into
-		userspace as -ENOMEM or silently ignored in cases like
-		disk readahead.  For now OOM in memory cgroup kills
-		tasks iff shortage has happened inside page fault.
-
 		This event is not raised if the OOM killer is not
 		considered as an option, e.g. for failed high-order
-		allocations.
+		allocations or if caller asked to not retry attempts.
 
 	  oom_kill
 		The number of processes belonging to this cgroup

