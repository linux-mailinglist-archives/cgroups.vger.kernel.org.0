Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6B444675
	for <lists+cgroups@lfdr.de>; Wed,  3 Nov 2021 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhKCRCd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Nov 2021 13:02:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35874 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhKCRCc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Nov 2021 13:02:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 69EFC1F782;
        Wed,  3 Nov 2021 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635958795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CZTso4db4Dar0whtzqs3akzB0bY3rGVZ6G9gzNMkSvI=;
        b=m+8PyeoG2r9EvepaoRjSnJhUauQo7s69RvD++FEIn8UMwIML+is4JVtNWHsifUCGI4EOAp
        EZK6n+P42yGr8EYHTRj3zKa6U16OmB6na3SLHMU4VAD69/2ptgtGqqG9d0n39liyYw68S0
        XMxf3jwmqkMCTZZFj4aNWh7KVmKR4j8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5070013E87;
        Wed,  3 Nov 2021 16:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DYL7EgvAgmHZaAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 03 Nov 2021 16:59:55 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: rstat: Mark benign data race to silence KCSAN
Date:   Wed,  3 Nov 2021 17:58:45 +0100
Message-Id: <20211103165845.38226-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is a race between updaters and flushers (flush can possibly miss
the latest update(s)). This is expected as explained in
cgroup_rstat_updated() comment, add also machine readable annotation so
that KCSAN results aren't noisy.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Link: https://lore.kernel.org/r/CACkBjsbPVdkub=e-E-p1WBOLxS515ith-53SFdmFHWV_QMo40w@mail.gmail.com
Suggested-by: Hao Sun <sunhao.th@gmail.com>

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/rstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hao was silent in the reporting mail thread, so I'm sending the
suggested annotating patch.

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1486768f2318..1abe74114527 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -35,7 +35,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
 	 */
-	if (cgroup_rstat_cpu(cgrp, cpu)->updated_next)
+	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
 		return;
 
 	raw_spin_lock_irqsave(cpu_lock, flags);
-- 
2.33.1

