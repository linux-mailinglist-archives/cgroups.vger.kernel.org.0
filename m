Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF04035E4
	for <lists+cgroups@lfdr.de>; Wed,  8 Sep 2021 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347469AbhIHIJx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Sep 2021 04:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhIHIJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Sep 2021 04:09:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488A2C061575;
        Wed,  8 Sep 2021 01:08:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso860179wmb.2;
        Wed, 08 Sep 2021 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+Q+aEeekHfF1o1bJCRwVNKDlh1bJxhJjIkMXUIhHF8=;
        b=VpWYEJ2o4h481bAFIQ5qyBeYNfgFYaJLk+dCVV0gzxsAsUFZtIphsslnx9UiWQiAFu
         1FjXww2jU/tAdltUiT83KbiCXks5DsJgVc8aOS4Uit2qf774Np8ZHOJIn9cFc+aeZgOL
         VzHyAPqtEM0eKlZztGvC5JxEPZIAQqurzu06+/THFGdXluUo+goGHbgptXxFBaiHM7rx
         MLSpMngYM9VDUUaBX4zK0N0ni0EU7TXXHfa/9EeNhmM1LOPkPjNex0FtOcaHRRM8a5FM
         65+UyXxeel4G9bOwbNpujyP3R8G20vTYLKcXEqwaNAilpmPK6jlaIyMSC/5gInI2T3SJ
         AmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+Q+aEeekHfF1o1bJCRwVNKDlh1bJxhJjIkMXUIhHF8=;
        b=Ceh8gZ0ryasYh8GLeWIGHBd5ZTQ4Jsy7muQ7qpH5IKIB9izsHOKft8F/Q9FoA6pOVg
         hKxYUhtSiE68IakCZxyLdGiTgRqfqZr7kLfUbNmEccQw2VEdAN3noF/4RPd0bEaQZhQg
         nokpo1cqZEUIFZmkeAK45cMmowe0fAqm2+wBmXHXhd60+Et1FGeRNKCXV4MRdsru62OC
         3Wrn6AJXhyDaQnhJx8Ru0yTToOzRWCd9X/Usg+kyBCkOQBEkb3bfGkTWb/UG2QGN8cMs
         rfXN7q2nxxNbzJSsOdtPplMdaurGVkQQhEUcC3TpWbaIZERLf/Nq07O93P+DvdcCy1Rs
         +zew==
X-Gm-Message-State: AOAM531vSxLc5c5vT8I3hVKfzsD6ryTBoGnIUAkpYem+A+1WRiTjNOxd
        Kzufjwr1c6tupKmVzx3e4cAHIflQ1wyzlbLZ
X-Google-Smtp-Source: ABdhPJwdt0QosFeR1ZRVauFFD2WNLUQ4nlHUVghZiHRZ+TPdDL3xecyeUKQ9nqfdwwpJ976DOqAPtg==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr2167325wmq.39.1631088522722;
        Wed, 08 Sep 2021 01:08:42 -0700 (PDT)
Received: from localhost.localdomain ([45.251.105.183])
        by smtp.gmail.com with ESMTPSA id i5sm1191566wmq.17.2021.09.08.01.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:08:42 -0700 (PDT)
From:   ArthurChiao <sjtuyananzhao@gmail.com>
X-Google-Original-From: ArthurChiao <arthurchiao@hotmail.com>
To:     cgroups@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, ArthurChiao <arthurchiao@hotmail.com>
Subject: [PATCH RESEND] cgroupv2, docs: fix misinformation in "device controller" section
Date:   Wed,  8 Sep 2021 16:08:15 +0800
Message-Id: <20210908080815.130952-1-arthurchiao@hotmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hotmail was rejected by the mailing list, switched to gmail to resend.

1. Clarify cgroup BPF program type and attach type;
2. Fix file path broken.

Signed-off-by: ArthurChiao <arthurchiao@hotmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5c7377b5bd3e..ad83f87a042c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2159,19 +2159,19 @@ existing device files.
 
 Cgroup v2 device controller has no interface files and is implemented
 on top of cgroup BPF. To control access to device files, a user may
-create bpf programs of the BPF_CGROUP_DEVICE type and attach them
-to cgroups. On an attempt to access a device file, corresponding
-BPF programs will be executed, and depending on the return value
-the attempt will succeed or fail with -EPERM.
-
-A BPF_CGROUP_DEVICE program takes a pointer to the bpf_cgroup_dev_ctx
-structure, which describes the device access attempt: access type
-(mknod/read/write) and device (type, major and minor numbers).
-If the program returns 0, the attempt fails with -EPERM, otherwise
-it succeeds.
-
-An example of BPF_CGROUP_DEVICE program may be found in the kernel
-source tree in the tools/testing/selftests/bpf/progs/dev_cgroup.c file.
+create bpf programs of type BPF_PROG_TYPE_CGROUP_DEVICE and attach
+them to cgroups with BPF_CGROUP_DEVICE flag. On an attempt to access a
+device file, corresponding BPF programs will be executed, and depending
+on the return value the attempt will succeed or fail with -EPERM.
+
+A BPF_PROG_TYPE_CGROUP_DEVICE program takes a pointer to the
+bpf_cgroup_dev_ctx structure, which describes the device access attempt:
+access type (mknod/read/write) and device (type, major and minor numbers).
+If the program returns 0, the attempt fails with -EPERM, otherwise it
+succeeds.
+
+An example of BPF_PROG_TYPE_CGROUP_DEVICE program may be found in
+tools/testing/selftests/bpf/progs/dev_cgroup.c in the kernel source tree.
 
 
 RDMA
-- 
2.25.1

