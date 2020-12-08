Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9892D264E
	for <lists+cgroups@lfdr.de>; Tue,  8 Dec 2020 09:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgLHIf5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Dec 2020 03:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHIf4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Dec 2020 03:35:56 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D0C061794
        for <cgroups@vger.kernel.org>; Tue,  8 Dec 2020 00:35:16 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id m19so2077445lfb.1
        for <cgroups@vger.kernel.org>; Tue, 08 Dec 2020 00:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVjmHtFolxRAfV2C2U9GLiRolrXJrnLIEB5X5ihubDs=;
        b=qAmjandBuTe8qafIuAhL+TRlTjWYdwJtv4pxvO3A91BFSWYQ2m5Dhc5xXfQ86i45P4
         E3fIfNW8Zyzttr/rUcthF0L0R46DB055NYg4IpBbRNoHX8L+c6pT9AlSyhHwt6L5MEGK
         IrcIIo7NM2/irS7jnXbifBZN+fNdTFHhYIKvh7/ychq6B8PNveguCXhAVaXvWRqSAFJm
         f4nOYltGvJKemURDUDlTLofhy8UHwaVdDv1ttvzDvudAGIwAy1Wzpz+oBT0P52Gqw7tz
         0b3B0QChyVPVQ0uyTybj0ii9Zisy884SfXaCGt7AK8RnwZHNPfF3P+L+T4pkausUhqXG
         JkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVjmHtFolxRAfV2C2U9GLiRolrXJrnLIEB5X5ihubDs=;
        b=ZrWiFiCb6pbt9jc1h0sNaJ6achJwsAz6Ys4EIKaYCACA3MS0Mtzf+MfgILS1PkHmy+
         tbf2r2+W1bW2KEH3xeTJ3n0jRQaPeHDcvBL6S5IfnFrf/L3cM4/vcPjnz/tSKQJkrVPo
         HNYfdUyURAMpRUJOsqgoNo0fWT2gonV7z6CIwNFNg7dQPO7i+2dptGe+uvzrco7a7aLu
         pSY0SK3qdXD3oZriLy1Csm9dNy7dWenCSvltSUjGpO0uf284dp2Vfp4j1yBRH7Q5VQRH
         SARfhz4hh6tjSgpCvYHGmANB1pBzN/cowoFXP2NIJTbIB7k5q9I+tCzuRGNjIoYnHlxs
         /wXQ==
X-Gm-Message-State: AOAM533woI5gk1QUCs1HcHhJD9fYQOLkxkMEjmYrkJt4X2fYZqnkUrc1
        ANM1rHR4Ues+Mc1kspEPbLMpbg==
X-Google-Smtp-Source: ABdhPJweXmdUgq866HbNtBJnk4sIansmklc9WtBrgzNRjHm8Hp7jANUcTSLJHhuMyl54GcEiRakEHQ==
X-Received: by 2002:ac2:5984:: with SMTP id w4mr1349317lfn.379.1607416514833;
        Tue, 08 Dec 2020 00:35:14 -0800 (PST)
Received: from xps.lan (238.89-10-169.nextgentel.com. [89.10.169.238])
        by smtp.gmail.com with ESMTPSA id f1sm3277720ljp.65.2020.12.08.00.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:35:14 -0800 (PST)
From:   Odin Ugedal <odin@uged.al>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        dschatzberg@fb.com, surenb@google.com
Cc:     Odin Ugedal <odin@uged.al>
Subject: [PATCH] psi: fix monitor for root cgroup
Date:   Tue,  8 Dec 2020 09:35:10 +0100
Message-Id: <20201208083510.14344-1-odin@uged.al>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix NULL pointer dereference when adding new psi monitor to the root
cgroup. PSI files for root cgroup was introduced in df5ba5be742 by using
system wide psi struct when reading, but file write/monitor was not
properly fixed. Since the PSI config for the root cgroup isn't
initialized, the current implementation tries to lock a NULL ptr,
resulting in a crash.

Can be triggered by running this as root:
$ tee /sys/fs/cgroup/cpu.pressure <<< "some 10000 1000000"


Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/cgroup/cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e41c21819ba0..5d1fdf7c3ec6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3567,6 +3567,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 {
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
+	struct psi_group *psi;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
@@ -3575,7 +3576,8 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 	cgroup_get(cgrp);
 	cgroup_kn_unlock(of->kn);
 
-	new = psi_trigger_create(&cgrp->psi, buf, nbytes, res);
+	psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	new = psi_trigger_create(psi, buf, nbytes, res);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
-- 
2.29.2

