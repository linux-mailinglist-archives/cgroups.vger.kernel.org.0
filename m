Return-Path: <cgroups+bounces-11888-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B061EC5443E
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 20:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8E93B8829
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522E83546E0;
	Wed, 12 Nov 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ipZjo2jl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD83538A4
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975822; cv=none; b=PH82oH2bekjS0nLoIA3okiJ13fE+WIAwtCimNa0tE/YcwTiFLVYj74EDU9WOK+eDV5/ohSgnybqonYPmGApVoxBkYL5xcsLpZxB3tW+UHKjPFbtwJAzsSnd0iYQxUDRp1qcuW6Pf619AxpfUM+VWzV9wWeaO4oWr0b/HcC1b+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975822; c=relaxed/simple;
	bh=xWEyjgvu6RU6fuiMig9vWVi/ppozqErZlNQJst8wywk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV6n+L/k+MkD4ZTRCXrJBoMbYNYw5/wLJr7tvccg8qWF8xnzTf1E0C56dJY+hDcbl9rJzdee8eRqRlsrMUHS9oVYxkgLialf38JnTFfh4raekFa8xDWX/B+wn7s46zJV+AS9+jJMRmyt3OgEeA3PjRWnmCl10s4EYaAKG+/AQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ipZjo2jl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-891667bcd82so3560585a.1
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975819; x=1763580619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkWGDFkxsYcV2vUuZc9I0ZRX3P3sH+nyS9DR2ZbJTF8=;
        b=ipZjo2jl/Dch0d04gT1tjuiNbKIaQvCSX7LpVMMbbuinhKix3MwaREbBnqCMD1m+FQ
         DFg9FrSCOqtuTwlddeHXjaWuFLlCfCv+4p8vyI7A4OhZCIhVJhaa+xghbWDRM7P2iSYN
         e6Yd8q/wKZUx/i5zDXpbLF/ArMvm7AYPZO4bxcAd5qPpDSlGu3Hs6McSwDRGDjoIHlf1
         pWGNF+XWZYhF7IuYCHOKYGvZrpJkjFDbSn1XsQD+//ZH/5agNq9iWky0g10RKnlmf4Dn
         e4A+PB6ShPyZGe5q8y1Y0BKT4BRCsWvQ5FwTpo8/r56a3Stnpkie+Aaqtgu8ZETdoRnP
         vUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975819; x=1763580619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UkWGDFkxsYcV2vUuZc9I0ZRX3P3sH+nyS9DR2ZbJTF8=;
        b=tnWyce58MjxH+t/hMTa99/haKkOmywqZRHB4OA1KGRmvM4zEv/i6IhMjKak+vwLdM3
         3kAFFQg6QefA1quNVb9zMgzSHnnLJcuDIMfwwoLxTfwGHvWbJ9/lCReW5F7O+JucIuQC
         iYGoNkR+nXELvuyx2Xg0JsiIjfphHtp+IaYy+Llb2DQli45gprwYFwiFncMgtA6dWw64
         O77l10eBOiCyGEON0PX9kGwMjvp0js+zPUw6gIA1tSsmKXOzpeMRMRbQ3UF16XtIPFim
         ZIN41i80qGMHjcqsUh+GbBACOAA5O7iioLs5Lw2OPx1E2WD7tPaD87/2M6wk1PBPIAit
         ZOVw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZ8DHvvMIQud+f3re4lBVY+8yjkZNSfKQy2r9XHznXGNjevnrVXJganvPIS/P98fEb7lpBAfB@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfBOulVSs6TfDGDfUSoUGHh2882Z2BJ6l3T+/96TMD+F1ujtR
	8vZ4TLCDr9ni+1LT8syZHT42gXE/WmGD8C+C1/8YpRRmdLYoGMQPfw9z5F/wiDG8EtM=
X-Gm-Gg: ASbGnctGQ1bh/+tBltw2bhcJ323hz/SipDip+iFvLDDMbZ+htA4QmzDwFXuTCbpkmiy
	0qMg8kE0ecVCLB2Qr95+dZ/FQSRtkt9lIs4pGJIFnSyUzVYLhTwGaQIqss4oxZIqHrJgTywEolb
	A4JhsEQW2+xfcJOPrPdoQIvRzQiX7qABpYJPLcZgayO1Nu/vL0GQ9nkSexrwgw8Q6NbeTThI8mn
	akbfYOa5ESc4/1W6X0aqlUbi5PuXmG15zpLLX3TyY61CBfps8GLhfwAfJJLA8smYGJ1Bl1shA7i
	PAPp7uE6NeFvtAZWG+oYxlOya/eE7iDDOr72YH67oHJ01CiNzZ6dDz2aMkHpPaP8Q4gQ0T8YiPG
	03To39SmJVpX7TxDxpwH/F12wbFRLk4GjWaq7X+7l310JwIy7vUysLzYAkEV+/eGSeJG6JGCkNE
	/mFXsbyGE6/LBgt1KiqE3B/yhK/XgICxsbykvZkpnQ2U7AjpQHDTUgDdc+e8YFRCtZ
X-Google-Smtp-Source: AGHT+IHnA96vKIbRbEVDdRL2YlwlXqxXxNpoq+1tyGBGVESiKZZsfFfpRROUBFK0hifrTyISq2ufZA==
X-Received: by 2002:a05:620a:f01:b0:89d:b480:309f with SMTP id af79cd13be357-8b2ac08bd6amr88119885a.7.1762975819003;
        Wed, 12 Nov 2025 11:30:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:18 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
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
Subject: [RFC PATCH v2 10/11] drivers/cxl: add spm_node bit to cxl region
Date: Wed, 12 Nov 2025 14:29:26 -0500
Message-ID: <20251112192936.2574429-11-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spm_node bit to cxl region, forward it to the dax device.

This allows auto-hotplug to occur without an intermediate udev
step to poke the DAX device spm_node bit.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/dax/cxl.c         |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..3348b09dfe9a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -754,6 +754,35 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t spm_node_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->spm_node);
+}
+
+static ssize_t spm_node_store(struct device *dev,
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
+	cxlr->spm_node = val;
+	return len;
+}
+static DEVICE_ATTR_RW(spm_node);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -762,6 +791,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_spm_node.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..ba7cde06dfd3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -530,6 +530,7 @@ enum cxl_partition_mode {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @spm_node: memory can only be added to specific purpose NUMA nodes
  */
 struct cxl_region {
 	struct device dev;
@@ -543,6 +544,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	bool spm_node;
 };
 
 struct cxl_nvdimm_bridge {
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..968d23fc19ed 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -27,6 +27,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
+		.spm_node = cxlr->spm_node,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
-- 
2.51.1


