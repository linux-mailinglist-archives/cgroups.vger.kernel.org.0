Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3823A46584
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 19:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfFNRRm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 13:17:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35160 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfFNRRm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jun 2019 13:17:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so3360415qto.2
        for <cgroups@vger.kernel.org>; Fri, 14 Jun 2019 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r5jrrOAKtFXOvMcXiZJVsg4x13O1N6yko4DRi1SdibI=;
        b=YS7ZxW3wr66DB8Sde66jbglAwldG0NFJCxdjeIThxzSO1REEUd96sOPodBWibeiWHg
         soPCJliv81TA6/nAz0nruL/6A7iLBZOeBLw4QmD5eHRQ5G2YPV+OAbDkhsR/7DxtxbWD
         NPGJzNvhQCtzUTltUBhA22oK5xs2jeRFk0RYhxMa8rle+G0w+gUTqcnuYqLrWbyL1Uys
         kk5ao9oBsCF93WRXEIDul5/60oSKd/Uit4GdXCk+llSCCuEZnKySdF3rTeGi3e+yTCWc
         cUo7J33F1mPZvd9IPBfwKZs/LjuqEjaogw4XAAIIVm+G4Fa/2IqQVwELTzYFvJ5Du4XS
         hBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=r5jrrOAKtFXOvMcXiZJVsg4x13O1N6yko4DRi1SdibI=;
        b=An5kjqodtEs8ab8/9klRDsFsytsVhRhaNPe0ry6HuAb7fGgNdwKRCfhdSxARwe5jMC
         E+NVxRaeABhiwqw3q0X+L3F/zjskL6cwcODqT4fdgjkgjEVJbjScFDAT4KBZYUy7nZS9
         Z33QrLIju3fdhQRdcUhEC4RwiiH66yRSCJ7eNP2zvgUg39a62mXrsVfABzvlSTavoTOC
         GDzoYArXEflhrlJwsHGirL3muLRYgCWVA+1n9Nk62tyWmSMuMqenvRt09/cvb8RzxfKt
         iOslGpxNDhlau4INM61ujpFFhHGRjYb5fn//+MIkdaspC9d/lWFLky9BUVjJHiKr693R
         XcmQ==
X-Gm-Message-State: APjAAAWWyCTxhGP3A8IZKmBrmJpTnS/QZ2iBlSu20E3yowm+0XKIvLHG
        Pe2uJ2R06mxfyJP2R1I/BhQ=
X-Google-Smtp-Source: APXvYqyy+YlNtHJrhSWrEl2WQszIvB4nkMvYE+eEnt3D7kIM0IGAPeiofHsapYl0eD3YfKDAHnA0Qw==
X-Received: by 2002:a0c:b659:: with SMTP id q25mr8937955qvf.29.1560532660940;
        Fri, 14 Jun 2019 10:17:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6bab])
        by smtp.gmail.com with ESMTPSA id 5sm2135178qkr.68.2019.06.14.10.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 10:17:40 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:17:38 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org
Subject: [PATCH cgroup/for-5.3] cgroup: Move cgroup_parse_float()
 implementation out of CONFIG_SYSFS
Message-ID: <20190614171738.GG538958@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From 38cf3a687f5827fcfc81cbc433ef5822693a49c1 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 14 Jun 2019 10:12:45 -0700

a5e112e6424a ("cgroup: add cgroup_parse_float()") accidentally added
cgroup_parse_float() inside CONFIG_SYSFS block.  Move it outside so
that it doesn't cause failures on !CONFIG_SYSFS builds.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: a5e112e6424a ("cgroup: add cgroup_parse_float()")
---
Applied to cgroup/for-5.3.

 kernel/cgroup/cgroup.c | 84 +++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9e3dffb09489..f582414e15ba 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6229,6 +6229,48 @@ struct cgroup *cgroup_get_from_fd(int fd)
 }
 EXPORT_SYMBOL_GPL(cgroup_get_from_fd);
 
+static u64 power_of_ten(int power)
+{
+	u64 v = 1;
+	while (power--)
+		v *= 10;
+	return v;
+}
+
+/**
+ * cgroup_parse_float - parse a floating number
+ * @input: input string
+ * @dec_shift: number of decimal digits to shift
+ * @v: output
+ *
+ * Parse a decimal floating point number in @input and store the result in
+ * @v with decimal point right shifted @dec_shift times.  For example, if
+ * @input is "12.3456" and @dec_shift is 3, *@v will be set to 12345.
+ * Returns 0 on success, -errno otherwise.
+ *
+ * There's nothing cgroup specific about this function except that it's
+ * currently the only user.
+ */
+int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
+{
+	s64 whole, frac = 0;
+	int fstart = 0, fend = 0, flen;
+
+	if (!sscanf(input, "%lld.%n%lld%n", &whole, &fstart, &frac, &fend))
+		return -EINVAL;
+	if (frac < 0)
+		return -EINVAL;
+
+	flen = fend > fstart ? fend - fstart : 0;
+	if (flen < dec_shift)
+		frac *= power_of_ten(dec_shift - flen);
+	else
+		frac = DIV_ROUND_CLOSEST_ULL(frac, power_of_ten(flen - dec_shift));
+
+	*v = whole * power_of_ten(dec_shift) + frac;
+	return 0;
+}
+
 /*
  * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
  * definition in cgroup-defs.h.
@@ -6392,46 +6434,4 @@ static int __init cgroup_sysfs_init(void)
 }
 subsys_initcall(cgroup_sysfs_init);
 
-static u64 power_of_ten(int power)
-{
-	u64 v = 1;
-	while (power--)
-		v *= 10;
-	return v;
-}
-
-/**
- * cgroup_parse_float - parse a floating number
- * @input: input string
- * @dec_shift: number of decimal digits to shift
- * @v: output
- *
- * Parse a decimal floating point number in @input and store the result in
- * @v with decimal point right shifted @dec_shift times.  For example, if
- * @input is "12.3456" and @dec_shift is 3, *@v will be set to 12345.
- * Returns 0 on success, -errno otherwise.
- *
- * There's nothing cgroup specific about this function except that it's
- * currently the only user.
- */
-int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
-{
-	s64 whole, frac = 0;
-	int fstart = 0, fend = 0, flen;
-
-	if (!sscanf(input, "%lld.%n%lld%n", &whole, &fstart, &frac, &fend))
-		return -EINVAL;
-	if (frac < 0)
-		return -EINVAL;
-
-	flen = fend > fstart ? fend - fstart : 0;
-	if (flen < dec_shift)
-		frac *= power_of_ten(dec_shift - flen);
-	else
-		frac = DIV_ROUND_CLOSEST_ULL(frac, power_of_ten(flen - dec_shift));
-
-	*v = whole * power_of_ten(dec_shift) + frac;
-	return 0;
-}
-
 #endif /* CONFIG_SYSFS */
-- 
2.17.1

