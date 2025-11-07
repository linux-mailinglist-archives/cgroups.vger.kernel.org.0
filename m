Return-Path: <cgroups+bounces-11675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF464C41E45
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 23:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 327C1342177
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 22:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C4337106;
	Fri,  7 Nov 2025 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aw/wI5v/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A3332EAE
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555829; cv=none; b=X41bY4KQTw1i8284EUGvJNV2SEA7Mzam2+DrC9f76FRY8pvrt//Zu16SzsdZeOL+xMvXLKOMGWsuPGYt/z85hmaCXrl4WcpVWAwX/BtIg8dvMJ5sqk4r0JFw+N4AmCA2rRlgYLOcjjXQxDBZUqAGUhrfCYd43JJDE9RuodupCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555829; c=relaxed/simple;
	bh=tSh2k/90dL3dI0zpcxARGhUF4rlq7O4vW4BNP7CcNwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biBvxQ5CXITXKLFV5bMAUqEEAsbU+LBjsMsdDCeyRyYmqf0F9Ovl7rGVaQBYk+d1RtpogRZBM8HOJtUeOeYvYBdMFyt0SXMOr4YJhBdh3aTMjAsrKBfKTtwK4KvPrsXDIy8pG/CozmbysYacDIFLRgOflPw0yoeUaW+ebUUwbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aw/wI5v/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed82e82f0fso12047571cf.1
        for <cgroups@vger.kernel.org>; Fri, 07 Nov 2025 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555825; x=1763160625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwxO6b4UaIu9W6F2d/g8AaHHPWCBsuMNbHYfAmKzKTo=;
        b=aw/wI5v/V2pViajSJfvh9FZwnNq2bke5v3pCCvw4+1MFAWWlbyy5dMJb9BbAT5WREB
         XYy3pSNb9cIqn6dMHKZpZDYGT983Lkj3YKmUmOYAy61x+0YpNv+EdW6/jT83NPy1jOv/
         6QBsQmauykNg57zqXlmL8c1i+FD/4m+stgxYBy17VfDUcJjGdxddNl/U3C6xF1YQTgFF
         qZi7S3+uuFQEFG1PHk8nzYDMQPAy2CZF0gYAJuAN5uKY9rALhABlNjetKYcpOIGldt0Y
         UGfUV5eXPrQaPoRIGo+Ir6OTKynN4HkBL7xrKK75VheHIs6VQbu3CQKOsEZTPvaTCRIK
         jjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555825; x=1763160625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwxO6b4UaIu9W6F2d/g8AaHHPWCBsuMNbHYfAmKzKTo=;
        b=JZU8P7dt+k8dqvHkZd5QP2Nvg6ewLz4uQ6CRtsE4ksJ4vUQ2DUr7NHg/E6PlR1BwfO
         ntJxPb+cYwsE5HcS3yJQ1MiI03ByB2wLg8rFGBfHCt20RKuwIMZ9nvbzDQYuiRFhzUG/
         +WMxyb1tfXG6jzSoC5rT5UQtk7fFnLCUUiRwkRnEg4y6f60x6F1HxzW26VRlP6OXB3zY
         eJipHQQV5WGrTHm1isyXgBqzpUvbK8Qm5gNiI0e8rb9nI477L9QtEWehQtU7Xi5y1Yly
         Ehmru1gJZAX4dwr5SjVRrQvwofYz8jATSc1QKIEiRyxRNM/kCyuZK2c0vRQ1MKj5cNrR
         KkqA==
X-Forwarded-Encrypted: i=1; AJvYcCUHiKFuE4sXQX7E7+YIFdeZ9lOc+YQptAuIaFLvkcxse+TXIzTxOUi0IwV+x+ftuVKlIQZRRELm@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrAmpRmG3DuOyKaf1xAcHOLccBNkWSaL6nrOfZ4y/SjZh6eXK
	NIZK992Z2wpD4x9k182jM/k2FP2o3H/AFDK9p0Q2dI0QPhBuzu0/2OaIrCUGRX0WiME=
X-Gm-Gg: ASbGnctB59Hj33HOMg733hWilaX0yrc54BOCRknt9nEzO94YBVJs67f78A2b/1p5X62
	11oZrRVSgUwnH4PHf2nO5X3tDocmPqS3QxyG+GZnb2s0MJQA17lC8TrfdR2gbVKzmOfVnFmxetk
	ANVmELBhqZlqqXM087QN5wMe0ryNCDwa39bBURC0avwY+7bk/9SnqgiRDLvM1rUoq/Ixd7j9Kr6
	k7kOa8WP5UhS3y8ttLPsfR5hpa6T4vhlRnazYs7Jeoui/JbTbdjm6NZG9HxWEHQIq3XEz2zDvxc
	hHomji/H4IH2L/TEpYFsAEht1d78K1EhLN0DRinW1aIEujHrVyI39DZj11jRscjkLfip56TsENs
	6GyW8UrPoUE3dAFP0nCQUKj+iScn9dR+9MPEWiFN5mNwuhsSb2jb/vPuWJqnNUBtLbGLgeFKW1F
	JbM78F6FwKRn04EVnLli/PG9tTV3t/GkoQgZcDRqkoD/YKs8H5Yk8pW7uvnlRsaBgEhW4mpYsSk
	WM=
X-Google-Smtp-Source: AGHT+IGGUkY/hMvQZUDcDXSyhiDaml+qPtZeSmCY7fYoXMiela3sPEpJdPQ5lN6VWEde9PlUke632Q==
X-Received: by 2002:a05:622a:1ba9:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4eda4f8ffb3mr10117651cf.39.1762555824542;
        Fri, 07 Nov 2025 14:50:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:24 -0800 (PST)
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
Subject: [RFC PATCH 7/9] drivers/dax: add protected memory bit to dev_dax
Date: Fri,  7 Nov 2025 17:49:52 -0500
Message-ID: <20251107224956.477056-8-gourry@gourry.net>
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

This bit is used by dax/kmem to determine whether to set the
MHP_PROTECTED_MEMORY flags, which will make whether hotplug memory
should be restricted to a protected memory NUMA node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/bus.c         | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/dax/bus.h         |  1 +
 drivers/dax/dax-private.h |  1 +
 drivers/dax/kmem.c        |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..4321e80276f0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1361,6 +1361,43 @@ static ssize_t memmap_on_memory_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(memmap_on_memory);
 
+static ssize_t protected_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sysfs_emit(buf, "%d\n", dev_dax->protected_memory);
+}
+
+static ssize_t protected_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	rc = down_write_killable(&dax_dev_rwsem);
+	if (rc)
+		return rc;
+
+	if (dev_dax->protected_memory != val && dev->driver &&
+	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE) {
+		up_write(&dax_dev_rwsem);
+		return -EBUSY;
+	}
+
+	dev_dax->protected_memory = val;
+	up_write(&dax_dev_rwsem);
+
+	return len;
+}
+static DEVICE_ATTR_RW(protected_memory);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1388,6 +1425,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_memmap_on_memory.attr,
+	&dev_attr_protected_memory.attr,
 	NULL,
 };
 
@@ -1494,6 +1532,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->protected_memory = data->protected_memory;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..0a885bf9839f 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -24,6 +24,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	bool protected_memory;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..605b7ed87ffe 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -89,6 +89,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	bool protected_memory;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..140c6cb0ac88 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -169,6 +169,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		mhp_flags = MHP_NID_IS_MGID;
 		if (dev_dax->memmap_on_memory)
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+		if (dev_dax->protected_memory)
+			mhp_flags |= MHP_PROTECTED_MEMORY;
 
 		/*
 		 * Ensure that future kexec'd kernels will not treat
-- 
2.51.1


