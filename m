Return-Path: <cgroups+bounces-6047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D056DA0188E
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E238C1883F67
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71D145B21;
	Sun,  5 Jan 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bzdvFp3x"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0679C4
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066102; cv=none; b=D036wgWsOxueE6StsIc/gXGI4ijaF+rPlhnesv7yqRBmgbQmiZ7sU0TP8k2hzc6fADh3K8WMXYd77KA1eoePycaeJ1sXxJSU67KCTw7/MA7pJjWLOzxYawhjIU1xY10jB3tG0SMW/V5QM+eFja+++gEzk5FR4FmzZSoNYIPnCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066102; c=relaxed/simple;
	bh=8mn6t+QHjDaf7J6kc9SMk308hna52jlveGFlyTvTj3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZK6KE+MZSb7+RDKWgt5/uo401Hr7cLs+Pvx26rBVMYNG8TL76LcrAoX3MlPrLwCs5JZWHQQSn8LF82YZF3+ctz/SdH4pxxcNlYfmNQM+QpoetiHcft0kYSTwJcjXcUri986iE0YUau8C3oxOLYu7sOEOhJxiVhlt/fq6ZP47fvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bzdvFp3x; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066099;
	bh=P8XwY4in8iMuG1/djQ6xOUQq3gJGLhNX0HGYx/Z+xcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=bzdvFp3xCqWY8Yf/alIXR2a5RlUyNeBDIUV11A2Io62XphNFZ0WKaKau6Qs2tgohI
	 VLg5EZYajlYFgWm3sVHRjii09acIYnDCtuK2QiiscAB5Ygl+OHYeZprMpsRX7q3CYH
	 z42Zk6wuGhicXp8JI4aY7UhwdxHHu871rvJ/yP2sagOqowdwffczEUlJs+vbSRNkLn
	 gfnO4YFCL6UotOD6HKDYaqtIPpib7TLSv03o6Empm5bxQV/niX7nn+9ATAPVvblA3w
	 IB0vxgoNtH/mr+zuQkaejS9UkkjSW63V9Xl9wAbn7wrukLVJW/zrCniMQbZt0NkJ7e
	 nG9cQGBv7Gz3Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 662BF4A046F;
	Sun,  5 Jan 2025 08:34:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:02 +0800
Subject: [PATCH v6 1/8] driver core: class: Fix wild pointer dereferences
 in API class_dev_iter_next()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-class_fix-v6-1-3a2f1768d4d4@quicinc.com>
References: <20250105-class_fix-v6-0-3a2f1768d4d4@quicinc.com>
In-Reply-To: <20250105-class_fix-v6-0-3a2f1768d4d4@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: lOP8nsuFbAq0B-ytUJPIZvF9wJO83EQR
X-Proofpoint-ORIG-GUID: lOP8nsuFbAq0B-ytUJPIZvF9wJO83EQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=951
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

There are a potential wild pointer dereferences issue regarding APIs
class_dev_iter_(init|next|exit)(), as explained by below typical usage:

// All members of @iter are wild pointers.
struct class_dev_iter iter;

// class_dev_iter_init(@iter, @class, ...) checks parameter @class for
// potential class_to_subsys() error, and it returns void type and does
// not initialize its output parameter @iter, so caller can not detect
// the error and continues to invoke class_dev_iter_next(@iter) even if
// @iter still contains wild pointers.
class_dev_iter_init(&iter, ...);

// Dereference these wild pointers in @iter here once suffer the error.
while (dev = class_dev_iter_next(&iter)) { ... };

// Also dereference these wild pointers here.
class_dev_iter_exit(&iter);

Actually, all callers of these APIs have such usage pattern in kernel tree.
Fix by:
- Initialize output parameter @iter by memset() in class_dev_iter_init()
  and give callers prompt by pr_crit() for the error.
- Check if @iter is valid in class_dev_iter_next().

Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Alternative fix solutions ever thought about:

1) Use BUG_ON(!sp) instead of error return in class_dev_iter_init().
2) Change class_dev_iter_init()'s type to int, lots of jobs to do.

This issue is APIs themself issues, and regardless of how various API
users use them, and silent wild pointer dereferences are not what API
users expect for the error absolutely.
---
 drivers/base/class.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 582b5a02a5c410113326601fe00eb6d7231f988f..d57f277978dc9033fba3484b4620bcf884a4029f 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -323,8 +323,12 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 	struct subsys_private *sp = class_to_subsys(class);
 	struct klist_node *start_knode = NULL;
 
-	if (!sp)
+	memset(iter, 0, sizeof(*iter));
+	if (!sp) {
+		pr_crit("%s: class %p was not registered yet\n",
+			__func__, class);
 		return;
+	}
 
 	if (start)
 		start_knode = &start->p->knode_class;
@@ -351,6 +355,9 @@ struct device *class_dev_iter_next(struct class_dev_iter *iter)
 	struct klist_node *knode;
 	struct device *dev;
 
+	if (!iter->sp)
+		return NULL;
+
 	while (1) {
 		knode = klist_next(&iter->ki);
 		if (!knode)

-- 
2.34.1


