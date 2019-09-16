Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F07B4000
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbfIPSGB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 14:06:01 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:51195
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389805AbfIPSGA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 16 Sep 2019 14:06:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edk+1vC1FlWpiCVNQIFwQwUeleBRYN2IbQXH3ftkWLQZrWO18OPmzDudZFPY00W/xvaYHmpAScit4znT/k0jZRxaA7Y0LjqG1KVJ8UyF0+i0ZUd8XW1Rwvjj6zKHBiXTMAes/3de7xJccQvsgYhXqzYDd6LzIKkP0QedgucxTYm7lauexqSyQOW+WAslfMObXcVxR15KvpBdtOl8y5gQLwFJg7NW/kFOkX3QvjSyXU3cN3JcwoyMgvuKSRnGqZbY2Sb+gc7mXIHDGEfbSijtBDZjaPeHi4AGyb+DNwLZgD0rVzvlWgoKntoqqVrCwZkZncg44Lqu/PGaA8MkZf6HAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0RpLv8WrRv//MRCBNlEyVQSbiN2dhnAOKxK7AfNp6U=;
 b=Xw6GuBV6BzRkbdGym4pnXljEVS4cGS4gjfFJ1YrKrqsTMVQ0HpG3978P2R+P9DUJzeGdZ4zt6taVj+2iyR6rM6eLhRFPJdx4czFb/bVkGrX38xgX6ioL50B4abXHX/1s+3l9I7mvUg4ZaTRZXnNoOcvOM6wATviJJYRVvGnbNLDRF8fCdlwBHc1jh+EDSwmlK3WRAiVEpipKowYubcKqz8j8yw1phZiyEvHtTbN/T0OYirMv6gwzy2V4O2Y9+YoRpDQWsGFhx72gVUGhwi1S/S5J9oOFP99/B4riBJ+Lu5Qp2b1+LsbkXvE9BsBIrirq8+MAg0a8n3hegli9p4aaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0RpLv8WrRv//MRCBNlEyVQSbiN2dhnAOKxK7AfNp6U=;
 b=xTQJy51wsR3FqpaBLyn6cL+JXyyW5wx0aCeW+uceNIsl7pEV7om3+e7ntuaDCc5zIc9TWwsHZ+Z4hbhNA323wJPtkDLjhlrlzo290J0PbVgG7nfJpQj8jXFtEUc5Ng+9R4U0DuIY1iGdfHEhv7jjYaYMuRCT5xFmZBmTgxInN6A=
Received: from MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.237.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 18:05:57 +0000
Received: from MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee]) by MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 18:05:57 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 4/4] drm/amdkfd: Check against device cgroup
Thread-Topic: [PATCH v2 4/4] drm/amdkfd: Check against device cgroup
Thread-Index: AQHVbLljHrKCWeF/okWN7OKWpSTxnA==
Date:   Mon, 16 Sep 2019 18:05:57 +0000
Message-ID: <20190916180523.27341-5-Harish.Kasiviswanathan@amd.com>
References: <20190916180523.27341-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20190916180523.27341-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To MN2PR12MB2911.namprd12.prod.outlook.com
 (2603:10b6:208:a9::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33e7b47d-fae0-4ecf-662d-08d73ad08608
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3871;
x-ms-traffictypediagnostic: MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38710C03BB282DA5A9F0E5998C8C0@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(50226002)(5660300002)(2906002)(486006)(76176011)(53936002)(36756003)(66946007)(6512007)(1076003)(66556008)(66476007)(64756008)(52116002)(81156014)(8676002)(66446008)(6436002)(14454004)(86362001)(478600001)(446003)(11346002)(81166006)(71190400001)(2501003)(2616005)(4326008)(476003)(71200400001)(25786009)(3846002)(14444005)(8936002)(6486002)(6116002)(256004)(54906003)(110136005)(99286004)(6506007)(66066001)(7736002)(386003)(305945005)(26005)(186003)(316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3871;H:MN2PR12MB2911.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iIS5v0wVu5zGPBvQowSwsITe025IUtSgNh8OBWLYKnOOpIkL1V5hhUgK0MXOy5S2X3YxHz/7vEi2W/0TZWZPy8UIwfH8mU+ZC29e7W9sdWpTpxfqgZRuObnL0h2jzXxsB+EHxfmYRNK/jjG4U+YW5YYiBfvDe4VAvidMdM51twqxIsf5d7OotDUrPWDhtVrQLMsVqWtQacibwE4MwOHcPKGbZymOC8mdf0ueNgaNH/Dq1+x0YvN4O/NNSFUs5gTp+VC4c98svBI/qXoacAbMhFgVJGPuOVkxGzPjnNBZ/f0ieYyGWi86cMACMLl4T/fdqMVKlF6Le4ZHgeL3NoyznQdZeRLDFKRUSUAEFK+JzdbyRJvEkxsEZwQEfMMZyMPCzUEBVFFvqHEl2sYVSk3Xc5YiNAU17C/f0BqL0cwECsQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e7b47d-fae0-4ecf-662d-08d73ad08608
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 18:05:57.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1rfxb1zTBvehKbgdUznA6QqfTN/aLmrC4zlD+1F6DZPrOMT8rPdG4KQtpJbd1knLabEeMFzqLuV5vYqXq4Kew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Participate in device cgroup. All kfd devices are exposed via /dev/kfd.
So use /dev/dri/renderN node.

Before exposing the device to a task check if it has permission to
access it. If the task (based on its cgroup) can access /dev/dri/renderN
then expose the device via kfd node.

If the task cannot access /dev/dri/renderN then process device data
(pdd) is not created. This will ensure that task cannot use the device.

In sysfs topology, all device nodes are visible irrespective of the task
cgroup. The sysfs node directories are created at driver load time and
cannot be changed dynamically. However, access to information inside
nodes is controlled based on the task's cgroup permissions.

Change-Id: Ic76d4d3c4e12e288033b8d22b08ffc5a2d784e5c
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  9 +++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c    | 12 ++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_flat_memory.c
index 481661499c9a..ae950633228c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -369,8 +369,13 @@ int kfd_init_apertures(struct kfd_process *process)
=20
 	/*Iterating over all devices*/
 	while (kfd_topology_enum_kfd_devices(id, &dev) =3D=3D 0) {
-		if (!dev) {
-			id++; /* Skip non GPU devices */
+		if (!dev || kfd_devcgroup_check_permission(dev)) {
+			/* Skip non GPU devices and devices to which the
+			 * current process have no access to. Access can be
+			 * limited by placing the process in a specific
+			 * cgroup hierarchy
+			 */
+			id++;
 			continue;
 		}
=20
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 9c56ba6ec826..a3023f932554 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -36,6 +36,8 @@
 #include <linux/seq_file.h>
 #include <linux/kref.h>
 #include <linux/sysfs.h>
+#include <linux/device_cgroup.h>
+#include <drm/drmP.h>
 #include <kgd_kfd_interface.h>
=20
 #include "amd_shared.h"
@@ -1048,6 +1050,21 @@ bool kfd_is_locked(void);
 void kfd_inc_compute_active(struct kfd_dev *dev);
 void kfd_dec_compute_active(struct kfd_dev *dev);
=20
+/* Cgroup Support */
+/* Check with device cgroup if @kfd device is accessible */
+static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
+{
+#if defined(CONFIG_CGROUP_DEVICE)
+	struct drm_device *ddev =3D kfd->ddev;
+
+	return devcgroup_check_permission(DEVCG_DEV_CHAR, ddev->driver->major,
+					  ddev->render->index,
+					  DEVCG_ACC_WRITE | DEVCG_ACC_READ);
+#else
+	return 0;
+#endif
+}
+
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
=20
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 8d0cfd391d67..92e5867aa990 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -269,6 +269,8 @@ static ssize_t iolink_show(struct kobject *kobj, struct=
 attribute *attr,
 	buffer[0] =3D 0;
=20
 	iolink =3D container_of(attr, struct kfd_iolink_properties, attr);
+	if (iolink->gpu && kfd_devcgroup_check_permission(iolink->gpu))
+		return -EPERM;
 	sysfs_show_32bit_prop(buffer, "type", iolink->iolink_type);
 	sysfs_show_32bit_prop(buffer, "version_major", iolink->ver_maj);
 	sysfs_show_32bit_prop(buffer, "version_minor", iolink->ver_min);
@@ -305,6 +307,8 @@ static ssize_t mem_show(struct kobject *kobj, struct at=
tribute *attr,
 	buffer[0] =3D 0;
=20
 	mem =3D container_of(attr, struct kfd_mem_properties, attr);
+	if (mem->gpu && kfd_devcgroup_check_permission(mem->gpu))
+		return -EPERM;
 	sysfs_show_32bit_prop(buffer, "heap_type", mem->heap_type);
 	sysfs_show_64bit_prop(buffer, "size_in_bytes", mem->size_in_bytes);
 	sysfs_show_32bit_prop(buffer, "flags", mem->flags);
@@ -334,6 +338,8 @@ static ssize_t kfd_cache_show(struct kobject *kobj, str=
uct attribute *attr,
 	buffer[0] =3D 0;
=20
 	cache =3D container_of(attr, struct kfd_cache_properties, attr);
+	if (cache->gpu && kfd_devcgroup_check_permission(cache->gpu))
+		return -EPERM;
 	sysfs_show_32bit_prop(buffer, "processor_id_low",
 			cache->processor_id_low);
 	sysfs_show_32bit_prop(buffer, "level", cache->cache_level);
@@ -414,6 +420,8 @@ static ssize_t node_show(struct kobject *kobj, struct a=
ttribute *attr,
 	if (strcmp(attr->name, "gpu_id") =3D=3D 0) {
 		dev =3D container_of(attr, struct kfd_topology_device,
 				attr_gpuid);
+		if (dev->gpu && kfd_devcgroup_check_permission(dev->gpu))
+			return -EPERM;
 		return sysfs_show_32bit_val(buffer, dev->gpu_id);
 	}
=20
@@ -421,11 +429,15 @@ static ssize_t node_show(struct kobject *kobj, struct=
 attribute *attr,
 		dev =3D container_of(attr, struct kfd_topology_device,
 				attr_name);
=20
+		if (dev->gpu && kfd_devcgroup_check_permission(dev->gpu))
+			return -EPERM;
 		return sysfs_show_str_val(buffer, dev->node_props.name);
 	}
=20
 	dev =3D container_of(attr, struct kfd_topology_device,
 			attr_props);
+	if (dev->gpu && kfd_devcgroup_check_permission(dev->gpu))
+		return -EPERM;
 	sysfs_show_32bit_prop(buffer, "cpu_cores_count",
 			dev->node_props.cpu_cores_count);
 	sysfs_show_32bit_prop(buffer, "simd_count",
--=20
2.17.1

