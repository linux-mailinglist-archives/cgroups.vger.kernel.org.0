Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361E12FC5A3
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbhATAUZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbhATAT7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:59 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03045C061794;
        Tue, 19 Jan 2021 16:18:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j12so6219676pfj.12;
        Tue, 19 Jan 2021 16:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwtSrnSYMVvS4qlas+fFjqkRS4JIs0P9IHv9gWu1OEM=;
        b=bDJtoahsaS1KxAdHsDXc1idqxnR6tE0o47LbSzTp5jc1sm8Dbu9Zn88FjPxjLoEvWM
         1qN0QLKZwCvHsXdEShRVOjCFy/2pXIwMv6nFYQ/sEq4T6ZRG6xEIC1RWOkKe957cldIn
         eos1TEWZPNMgNRQM8EgBbwgtGKZwvHS0GBeLCGadWosrirRlllo/XFqTC2o+4O8SwqwG
         1KoMdZW+gH5NyJT+OymTG8hq0NfCO4qJlS73XmSBDPEQalWJCmCH/8vJ/GauRTwTMmDA
         J3a2SkdW+dUTZKiTwe8v3kkd+wWUPUhpyjIoyy07LovKWE15RTYWSPU8hO1lrx6rbV5Y
         +lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwtSrnSYMVvS4qlas+fFjqkRS4JIs0P9IHv9gWu1OEM=;
        b=oE83A+RPvPjqgRwLq8HkStQXRtsGxMBj2PxcNMsZVW+O2a31dqB6HqJuoDAHHKYfW7
         ZwtGMW1bkDTBnsigbuxh/pm1CmGt5B6Nm89yG39jANmCnVkaXjZK7N3UunFg+WCdLEJN
         kbgvJha+0M07SQT81D56Z/D3GMEE67A87iHjvZEhOAQahzWFvl9NYLYjFm8SS60Dc9mD
         l1D+oFlUWiGniIbnEdRcKAKrWp/WCcbNFGizzpY2vxt5IwDJyX4DNs3mdVSt48wJjUiQ
         yD7AlBgIGT9hrS52L1xClwYZ43VOuf3+xmRZt5/eZxYKDIY3mHJpfxfoauCCs1N+8PF4
         uwpg==
X-Gm-Message-State: AOAM533DdL0neCUBlVACP8m6Z+CBRkjiN3xguN2tbtWDN4an7tKm0K2W
        IQk9V9N08WaxkahWogLeg+8=
X-Google-Smtp-Source: ABdhPJyPSof47RUM62dgKFkvuwECJclnV8XYewOdbo7qnoAfSRCq/W9jw5qEY/nLNLlGq+xx8YeGjw==
X-Received: by 2002:a63:703:: with SMTP id 3mr6714834pgh.272.1611101917566;
        Tue, 19 Jan 2021 16:18:37 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:37 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 09/10] docs/admin-guide/cgroup-v2: nit
Date:   Tue, 19 Jan 2021 16:18:23 -0800
Message-Id: <20210120001824.385168-10-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Improper Capitalization.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6f59f13f28d0..136902cd0e98 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2226,7 +2226,7 @@ Without cgroup namespace, the "/proc/$PID/cgroup" file shows the
 complete path of the cgroup of a process.  In a container setup where
 a set of cgroups and namespaces are intended to isolate processes the
 "/proc/$PID/cgroup" file may leak potential system level information
-to the isolated processes.  For Example::
+to the isolated processes.  For example::
 
   # cat /proc/self/cgroup
   0::/batchjobs/container_id1
-- 
2.29.2

