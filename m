Return-Path: <cgroups+bounces-11676-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49745C41E54
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 23:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C083A3A7676
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6A033CE82;
	Fri,  7 Nov 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q08QAoxW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3680339B28
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555830; cv=none; b=RklDs6bgj/9PGSICFDOpEWmTzEheYb5xGopuTqsua0SkHoWjopY2G+V1pmf8IHQS4wU9F9cGaUIAOWWwBaVswgF1OXT3CgPVldknEdGxxBiWkQYV7xyrP0CV5H1tag93NEDZf7LL/8NPX5I2Vy44DewFhKza1mhvfjZwVTu2+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555830; c=relaxed/simple;
	bh=CNVKe4UoF4HjKWlrvxf/qnyhxQc08gfgs8nx9Dft3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p36XHsMRX60unagfaL62yjWPWxX0DgLtonWkhJppy50vArWuB1FRc8SoVA8vZAsTucYqqqXjhIWIKMcUz3ZZMVCGpY//6V69xdpyQRTCu8eUaogTWmS28jaHacs0lRE7jNR+pcub0Ugll7/CsWrkPumposX0HTbOgwpFEHn/BnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q08QAoxW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed82ee9e57so17142181cf.0
        for <cgroups@vger.kernel.org>; Fri, 07 Nov 2025 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555827; x=1763160627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raBRVFIoxXfgYF0FkwrcuU6SyEb+VTf3BUeepNhNHyc=;
        b=q08QAoxWVJj69JFbkhxxapbBs4S8dpPKapCmH9sXwTVst1MP8fcWCHDuZgzdljL88L
         H5vIVF/Ov67nCjUb+ldFEdIqq8PXzqV83sB3DKsUKdtmo6ocPd2nVi2cHA9lFp6BT373
         +02gnhC1M6NSAKbGOuh9RcEVEWpyN4nrzaRGvdBl2ZKJwXPONSLHO6wk0fRrBj6ARh0F
         odZqvQAs9wAgYFxUCZYqGhjFCRnLQKeg9k06osxeFnKA9a7GH8BRSdrpVJLK922lC7Ca
         Fj2gO0yCKwQ1tYGZq0b0uH8PPrTQ1AJnch2Vv9ZWRZgItpiXtaSKa/GQk8mlrSNr8gsW
         TJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555827; x=1763160627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raBRVFIoxXfgYF0FkwrcuU6SyEb+VTf3BUeepNhNHyc=;
        b=ED5jzxz7Ov5waEqpEFoUG93gnIT6e9MGRklvoNTrVI2mOpLq9knczr4pHKADhoXWrR
         x/fsnKslJbeTGR3pnQRa9154ORJB4yF2f8sFBkBlBnxR2EfyVk/G/Lz3USrjWIJwmYZz
         GHiI6YqQquda5+8C1Gf5bcFtRz9g5cz75QYcGsFFydCFhkX644lmL2zFcmZJ2knpLOLM
         udaZvFu5/Vej5C3e4vvG+g8ZErx97rrB7Guucsx5zBY/bsOYpXjg4gWm71kl3hZvJtn3
         oKLJqTGnojRTaQopoEnfcui0X2h58+f5qDhV/zZK6vy0NvZUWJHrRTAHog+6yTJSAee7
         xeeg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+kXgl6xaj3zcbMlbosI2URAX0i9y25hsiNswin5a9WmBROFuXhTRU/yPAtp6Hdo3ZDf48s1U@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlo+uFeMdkjDXLJtf4hvDTcTflAD44IXt0e+WBPgSdIb5qxwH
	TNkidkZxGH1Sat9GDu++Unrf7p3joQl5wGEZb0y3dnIJ0/uJla1ahfGq95MgEg0nmZY=
X-Gm-Gg: ASbGncs+IZTyoomaQxe4wHGmDKmNMQvW/rLIOLpTfyWD71P52HEOMm434RbHzCjF4jY
	D7GFKSV7/g8upNHus8ZUkIgKaAeKxIWgIsM4ZNlKhOm2uR7R6JFm90DY6wOhnTo/oWkenB3Vv6r
	+yCJ1qy2HGm8zUKRyFk0BiJLLDfMm8DJEf8jFYMUytaoU5fglZlaLi1ocPJbNrt2jMgFcvB9spO
	JNA9Q1KBqO32sRL5fITAWkEA+kAIU1Ich6kqQGgnBfOD+qluL4ARuUeKxVQJkh4mPSVEHBzrQj/
	VIWrnVX5zBtSYv8rRZcno1KY6gITr38/yjAFETl4TqqgVMMKxGn80MKApqYBYUsdtB9mBFS2SGw
	jUK9DDcdRlaEk1Fbw5YYhlwIQOLuOdyO0bnREwXSej1Q6EbfZgnaRefu7Q/zH1ZJbzWoRRfvr7v
	9q3OCFUoy7W99iDkrezmtuCt+OVh+c39uPj9/rPNP/Z04XtdF62Y7IH4eisI8fVJSJ
X-Google-Smtp-Source: AGHT+IFm7+5mwYzM+NrPR3r2lO2/HN8TDlNByi59dSrMG4CDuhQ9TLgCeHpdJXuwA3iY2H9OGim97w==
X-Received: by 2002:ac8:5751:0:b0:4e8:a0bf:f5b5 with SMTP id d75a77b69052e-4eda4fd4dd3mr9303801cf.73.1762555827556;
        Fri, 07 Nov 2025 14:50:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:27 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 8/9] drivers/cxl: add protected_memory bit to cxl region
Date: Fri,  7 Nov 2025 17:49:53 -0500
Message-ID: <20251107224956.477056-9-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add protected_memory bit to cxl region.  The setting is subsequently
forwarded to the dax device it creates. This allows the auto-hotplug
process to occur without an intermediate step requiring udev to poke
the DAX device protected memory bit explicitly before onlining.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/dax/cxl.c         |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..a0e28821961c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -754,6 +754,35 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t protected_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->protected_memory);
+}
+
+static ssize_t protected_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return rc;
+
+	cxlr->protected_memory = val;
+	return len;
+}
+static DEVICE_ATTR_RW(protected_memory);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -762,6 +791,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_protected_memory.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..0ff4898224ba 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -530,6 +530,7 @@ enum cxl_partition_mode {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @protected_memory: mark region memory as protected from kernel allocation
  */
 struct cxl_region {
 	struct device dev;
@@ -543,6 +544,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	bool protected_memory;
 };
 
 struct cxl_nvdimm_bridge {
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..a4232a5507b5 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -27,6 +27,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
+		.protected_memory = cxlr->protected_memory,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
-- 
2.51.1


