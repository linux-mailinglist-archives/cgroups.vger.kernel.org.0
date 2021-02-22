Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7857F321AEF
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhBVPNf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 10:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBVPN0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Feb 2021 10:13:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB9C06178A;
        Mon, 22 Feb 2021 07:12:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c7so2705727wru.8;
        Mon, 22 Feb 2021 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+jxf/c6aKxBtKoS9ZDFkjl+nA7mB7wt86sqHcoIgnU=;
        b=Igj+NEPkPWJoijrkRrH/caY1E5NfYkZDCZBhzVHmscEXfl+nAU78Fds4ChKT5iDrNC
         3Re67QcqVO7PVhLnnkmbHNIeb4QyzO5LpMQ4CZh3L5ljZOXZ9UxWRynfgTwVM+sUAJz5
         klfGDgvY+/fw5TX3ymZqTbgFogQvObV/nXFCkcasHwi372vovAHjSr/7Kasiuj3uHNm+
         jYyltTXRnnMePNacdNKWXGIGVEiOdKvLF5ZfEGDiQsT7/511k9S7wlrFXMT5o10kLEz1
         AUdPF2xJqw9I/8FJ1VAcA1OHMF/rlP127zcAuRQ/pTd7Nj+AR1jK/ld7mx5nqdHC6ElF
         QPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+jxf/c6aKxBtKoS9ZDFkjl+nA7mB7wt86sqHcoIgnU=;
        b=asz1iIMgbPaQslLNEVbiZ+SoF8+gy/cSFUri+K6sjXjpFuGEsGHxobYj3XRoPyYl2y
         /D0KGVCeDZrsRaVw1iDT/TbtPYxlhGm4ExxOH0hk3KjxwoL6u1d4kZxuFNs8HpDuFb5Z
         7yp4vnh/ZP98Ubahg4zwSI3kcmo0EGx2MrAq9DpUCjeke5Bk10Ys9FHnUsm08pc7rifL
         ulnsvOinKj0zzeKJ6Dpahbc3To8XV+QnipQ/Tki5C0Bo5qrBrtRyQ2C56V776wr0CcWH
         qrDEG5BSxVjKOerhANRJmO1Lj4DGOxmcQhrsMbZcLI+jnfZFNT4Cqnih9lrcGBE5Ic4E
         RbcA==
X-Gm-Message-State: AOAM530zGj7O3mrz7Xatyjr+y11xEbN+QJ1r5nIYQ9ebtSbwxiaHCFll
        lRNEuPqN1Dr2VcK/1HyfLS7K962nUhgvEV/uML8=
X-Google-Smtp-Source: ABdhPJxSlaj/wGXQlhqcVSW+B87GwGWyLb3NE7717uuSVwOWnbMB2HGUqdE8D01xTcPB39n3ZpB3HQ==
X-Received: by 2002:a05:6000:10c5:: with SMTP id b5mr22235769wrx.284.1614006762869;
        Mon, 22 Feb 2021 07:12:42 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id 7sm17129326wmi.27.2021.02.22.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:42 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Romain Perier <romain.perier@gmail.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] cgroup: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:12 +0100
Message-Id: <20210222151231.22572-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 kernel/cgroup/cgroup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1ea995f801ec..bac0dc2ff8ad 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2265,7 +2265,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 		ret = cgroup_path_ns_locked(cgrp, buf, buflen, &init_cgroup_ns);
 	} else {
 		/* if no hierarchy exists, everyone is in "/" */
-		ret = strlcpy(buf, "/", buflen);
+		ret = strscpy(buf, "/", buflen);
 	}
 
 	spin_unlock_irq(&css_set_lock);

