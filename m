Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B33314F2
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2019 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEaSwb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 May 2019 14:52:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42316 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfEaSwb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 May 2019 14:52:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so2120461qtk.9
        for <cgroups@vger.kernel.org>; Fri, 31 May 2019 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5IWuOvRy3W8IAMMjrN6EW+AHDQ5SNAvFQ0qqlutlcTA=;
        b=k32f1U1UrwqrGTTwJR+dlxTc6zyT0JvUl1qEK0bG4/F0QlsA9gQlDssjOJ6SHrmxD3
         MgPy55FAaIq4mQhXrHwE/17vtQvVtUCEJp/127o2///cjIKpjhMe1mMFj87LDESqUBbs
         u7EuN0frncl4niarvXJyjxVq5pRX+PjuDrajtfMISeYOEMxBa6GfvZxObb0MBa4s/n97
         Onoj555Ei/uHaEZRzTMqbHPs2Uvc7vpVztLyO5lsOaUt9KL5TT8zcOW+01Juv1SpqW52
         URygFm+HP1omwV+b+fD4+cOSf5QXKpviqdp2uyl4kEh+mhb9wgXrYQ/5bQwEnvLKp5S8
         6h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=5IWuOvRy3W8IAMMjrN6EW+AHDQ5SNAvFQ0qqlutlcTA=;
        b=ofW5PpNKwUgRq2ZQqFcoFSUgxnrdJxTlT0Pn5snKHr1uwmzxo8kLYklg/0znyQfnVQ
         8giUGIMSgNQo9WEBBX6odz0rkL6M/z5/FY8sdgTku2x5O6wrRJ1s7l/Q7Z1/tH94eQ2s
         +/VjT1fc/TjQDHQ4Uw2CjI77o13bDua41APzJNQd3zztGjWZiQUeKLqPCxRMXKJG32wh
         w8xnv6yYFWf8pJ9/r/bXzHEDFg5XhiCKx/aG1U9eX1t5+ity2WZmiCvTZFa8ZStsZNou
         984+qcx1qMsvESMRf8C8Aa9qdY8XtR47EMcDeXK9JZEyBqzHs/TfiqOicggrZMQftF1h
         jEHQ==
X-Gm-Message-State: APjAAAVl6FPt5d7qT7ia1DGNVco3vzTQ5xLlD1BE+ivLEpgosNnwdvTE
        SHMzcVHjQccHq28lXhWJ5/Y=
X-Google-Smtp-Source: APXvYqxdxc9Npu9wsw5cS8vmM6CTEYwNEObhJ27Bv+wwQKX53KUPtx7A/zFUd16G9fb7Z+GwDyn24A==
X-Received: by 2002:ac8:2a46:: with SMTP id l6mr10464802qtl.309.1559328750075;
        Fri, 31 May 2019 11:52:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4513])
        by smtp.gmail.com with ESMTPSA id b66sm3264403qkd.37.2019.05.31.11.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 11:52:29 -0700 (PDT)
Date:   Fri, 31 May 2019 11:52:27 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH cgroup/for-5.3] cgroup: add cgroup_parse_float()
Message-ID: <20190531185212.GH374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From a5e112e6424adb77d953eac20e6936b952fd6b32 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 13 May 2019 12:37:17 -0700

cgroup already uses floating point for percent[ile] numbers and there
are several controllers which want to take them as input.  Add a
generic parse helper to handle inputs.

Update the interface convention documentation about the use of
percentage numbers.  While at it, also clarify the default time unit.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to cgroup/for-5.3.

 Documentation/admin-guide/cgroup-v2.rst |  6 ++++
 include/linux/cgroup.h                  |  2 ++
 kernel/cgroup/cgroup.c                  | 43 +++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 88e746074252..73b0c0d8df31 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -696,6 +696,12 @@ Conventions
   informational files on the root cgroup which end up showing global
   information available elsewhere shouldn't exist.
 
+- The default time unit is microseconds.  If a different unit is ever
+  used, an explicit unit suffix must be present.
+
+- A parts-per quantity should use a percentage decimal with at least
+  two digit fractional part - e.g. 13.40.
+
 - If a controller implements weight based resource distribution, its
   interface file should be named "weight" and have the range [1,
   10000] with 100 as the default.  The values are chosen to allow
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0297f930a56e..3745ecdad925 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -131,6 +131,8 @@ void cgroup_free(struct task_struct *p);
 int cgroup_init_early(void);
 int cgroup_init(void);
 
+int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v);
+
 /*
  * Iteration helpers and macros.
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a7df319c2e9a..7dffcfe17441 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6387,4 +6387,47 @@ static int __init cgroup_sysfs_init(void)
 	return sysfs_create_group(kernel_kobj, &cgroup_sysfs_attr_group);
 }
 subsys_initcall(cgroup_sysfs_init);
+
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
 #endif /* CONFIG_SYSFS */
-- 
2.17.1

