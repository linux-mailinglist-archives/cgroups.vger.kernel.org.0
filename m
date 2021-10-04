Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F6A420792
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJDIvY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhJDIvX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 04:51:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421DC061745;
        Mon,  4 Oct 2021 01:49:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so61764070edv.12;
        Mon, 04 Oct 2021 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=mmeALFBSPw0ccXZyVUb3H3QtIHQV9aFgUitnFK9ucbw=;
        b=aHIWKedFODKrrTaJmBh4aOi/2LrXkyffWQb4L//E58fQFjBxgGnLl1ZR3xMzUMrGsp
         IINsD7Va/yh1OeAcM0Hv8dhy1f8zx6RwM4jg8oQd3H8d2ayx4kKD04dSuW4hrRR5Psav
         uVS/OI0IUD296TDCRqEFWLocB7DOp4ANoK/eABRwTpklFc5op/fopgWjEAvRQOSuFSj7
         uiOzRX5EEHruPKVUPtMquNZM0PuUbb0Qxt8rfSrAunjw0FQicKuogGlHD8Yn9okOcDFh
         J40nrYO+O6BHfT1Nl6jxO2kVwuYBvIBCGuMP1EDMTSAP8BkaYBhwJ2kgMBKkz01zrseZ
         2W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mmeALFBSPw0ccXZyVUb3H3QtIHQV9aFgUitnFK9ucbw=;
        b=Inl47k2P7Q4kSeGcTRPorU9bQnfEpCCB8IM8MERFx6KWC9aGz6OaFeN6BK2LuKzq8H
         rCEnzKNTRXz2HXtLDFrgoRxZqdDxZfnL251GBUojy0E/HihfS/n7upZg4Eh3sK7jmyK8
         j0ILAwYZo04/+6giXTtCOAhxqs2RcBO34ARmSr3jHTbyYAD1VfHhAfC+ewGckir51Kas
         NYeZs943898ERJBhVQwoXD/kD2Rppu2vGyzLXhgZZDeZqkoyeqxLxPYIUWlZTHUN2K+O
         7kRxwDb6c20RdosjqL3tCR55EQct0XldhEt6MvaiU7gsT5ox/Efpd9WRL9Qxxz/a101D
         TO0A==
X-Gm-Message-State: AOAM531c7ru2p9YsvmRV7zjtWlF2diEvyvCF58qRlBsBOzvHhWlB5xLH
        tZo/qrjeDaZyS9iyMiuqv38=
X-Google-Smtp-Source: ABdhPJx1yDrwI+YFYSE0jr9dxyi179ppRDBcBro/3zRfQeFhVr9qKyuL+pTuUOq6kXf31YN+T/gK8Q==
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr16752684edu.144.1633337372936;
        Mon, 04 Oct 2021 01:49:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s3sm6317427ejm.49.2021.10.04.01.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Oct 2021 01:49:32 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/4] cgroup: a u16 is enough for cgroup_subsys.depends_on
Date:   Mon,  4 Oct 2021 08:49:25 +0000
Message-Id: <20211004084928.17622-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After commit 6e5c830770f9 ("cgroup: make cgroup subsystem masks u16"),
we limit the number of subsystem to be less then 16. This applies to
cgroup_subsys.depends_on too.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/cgroup-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index db2e147e069f..f6d80896daab 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -705,7 +705,7 @@ struct cgroup_subsys {
 	 * not visible to userland until explicitly enabled.  The following
 	 * specifies the mask of subsystems that this one depends on.
 	 */
-	unsigned int depends_on;
+	u16 depends_on;
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
-- 
2.23.0

