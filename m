Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273E1B3FF9
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfIPSFz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 14:05:55 -0400
Received: from mail-eopbgr700076.outbound.protection.outlook.com ([40.107.70.76]:21537
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389732AbfIPSFz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 16 Sep 2019 14:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfBQPdt7OmR+HaUYOBEO8XXQRcRo4x9hEM+vFBQvCMFXb7ANq/KIr6SidNB7+biBCbCcWnwbMWgD5BFmOz9oDwZaCHf/xrirsE8I0CC/VS0IO2WYDm2E0SuJMXmw7ozFjQ9t/CpfaO/YaBEuDRkpXIoHbUX2A9HbqGXCYFnHW4dgLGQnIlYCm+OvLEewzlCxEUZIfsEd52ri3QJDigu5UxeaQgRcxmiFHb2pY3qnc+a/zaEMXfa5MVRuBQpmHd471JeQzuisb4VJnaneD7ieafvCdZKkWwK+wUpTZ/czp0nbt9mbQ4ldZHkGtKnSi88nPum0had6eABalICYEBhHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fajRHZR9Uxxlavl7AQXFoyVQ0HAJI/LR9jwmOtqirTE=;
 b=lOuDemmqkhxK3cdyWkzZo5uKKZqJ0qVz8uEAfePGJsuUZQ196qqQaFXFifO82QeUhWp4iODVZ4+AFDBX3AFI3IucgfBI57IaF62rSTUevWW+x42A9J5YHgi0Ci9fkbHL40XssGqGMlrfzfBQefvTuFHnIZTlQtmQFM/aSuO78tJ2bbdptur8JZk9kveLsPIMeeENRm8B2SVvsc3B5BMuCZhpAcYkHiE8BTXPD4CTJjoc6ZaKUITnLk4N1VaC63J6WLkycpUvRi7F4TJ9O2Pefjjs/NuODL7ZxoxhjgzyNEV6yJZOOnXix1w5Rpskn4RtCtzOY3imtGncdLWoSjSIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fajRHZR9Uxxlavl7AQXFoyVQ0HAJI/LR9jwmOtqirTE=;
 b=1bkjun6iOCaDGfyce5pjyvd0jWk31H9nQTr5qmZG7/9ea0p7Y1nIcSA7l6H4rxvRlHEP6GucrUmpW55Dm7Xyx4i+xMGnY8rxoyTtkJyL3G/cZqo+8fAWRvgkIr9t7BLEXZ7DhZsKepfBeEVJptCANkqQQfBFEgUi3iXyOl5fpTw=
Received: from MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.237.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 18:05:53 +0000
Received: from MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee]) by MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 18:05:53 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 1/4] drm/amdkfd: Store kfd_dev in iolink and cache
 properties
Thread-Topic: [PATCH v2 1/4] drm/amdkfd: Store kfd_dev in iolink and cache
 properties
Thread-Index: AQHVbLlhJ3vLLBE/zUS3ZBbJUPNIGQ==
Date:   Mon, 16 Sep 2019 18:05:53 +0000
Message-ID: <20190916180523.27341-2-Harish.Kasiviswanathan@amd.com>
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
x-ms-office365-filtering-correlation-id: b83dfb1f-3631-4d02-ca6d-08d73ad083be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3871;
x-ms-traffictypediagnostic: MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3871C46F633A00E1E90D0AD38C8C0@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(50226002)(5660300002)(2906002)(486006)(76176011)(53936002)(36756003)(66946007)(6512007)(1076003)(66556008)(66476007)(64756008)(52116002)(81156014)(8676002)(66446008)(6436002)(14454004)(86362001)(478600001)(446003)(11346002)(81166006)(71190400001)(2501003)(2616005)(4326008)(476003)(71200400001)(25786009)(3846002)(14444005)(8936002)(6486002)(6116002)(256004)(54906003)(110136005)(99286004)(6506007)(66066001)(7736002)(386003)(305945005)(26005)(186003)(316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3871;H:MN2PR12MB2911.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YRRwoZRV4eWU+iS4GLWRWB3aHoOTnl3t3KBepzRe0bLMiPchxraY+v2ciUytL66dp4JXecG5c3li2KcSAcLwyap/x4mPY6YHEagIzpwoZcZY0Xm5l8P5e3FauUc2k8YviC3w0g9t+Rz7tq1lJkZyzn5KCQmJJ1u9jEry+jeGDhv0M+Oag3CQLVUEppBfwBJCjCXe19TSRgEfmb18mvQOVRS23s6muERWBCqJAJFjEYC/JZNjJG6+iSuHbp4dROMJ+SDYmyuo7+8OFq5Dp3gLeBiDHVE6jKYgZHvsDClWGvo7Pcui2kcptVxuP6GyZHIdo8kGvrPrWSIEPBagorvflSe9WCEv6ZYEncB9p/QjcPHrPslcZmPHt0mGLGrKMT2AkNAFRP+5n7pk91dY63sX4/fgqEGR3WGpNPd/y89i8W8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83dfb1f-3631-4d02-ca6d-08d73ad083be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 18:05:53.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kd+bo5Crelok+tnblNwmZLnQv0WfAMMrkQInyL9epI2lk+1vdZ/4/W502tBAGSC2Zjp3w4Cr0V0bobPuzr3ueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is required to check against cgroup permissions.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index f2170f0e4334..8d0cfd391d67 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1098,6 +1098,9 @@ static struct kfd_topology_device *kfd_assign_gpu(str=
uct kfd_dev *gpu)
 {
 	struct kfd_topology_device *dev;
 	struct kfd_topology_device *out_dev =3D NULL;
+	struct kfd_mem_properties *mem;
+	struct kfd_cache_properties *cache;
+	struct kfd_iolink_properties *iolink;
=20
 	down_write(&topology_lock);
 	list_for_each_entry(dev, &topology_device_list, list) {
@@ -1111,6 +1114,13 @@ static struct kfd_topology_device *kfd_assign_gpu(st=
ruct kfd_dev *gpu)
 		if (!dev->gpu && (dev->node_props.simd_count > 0)) {
 			dev->gpu =3D gpu;
 			out_dev =3D dev;
+
+			list_for_each_entry(mem, &dev->mem_props, list)
+				mem->gpu =3D dev->gpu;
+			list_for_each_entry(cache, &dev->cache_props, list)
+				cache->gpu =3D dev->gpu;
+			list_for_each_entry(iolink, &dev->io_link_props, list)
+				iolink->gpu =3D dev->gpu;
 			break;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.h
index d4718d58d0f2..15843e0fc756 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -102,6 +102,7 @@ struct kfd_mem_properties {
 	uint32_t		flags;
 	uint32_t		width;
 	uint32_t		mem_clk_max;
+	struct kfd_dev		*gpu;
 	struct kobject		*kobj;
 	struct attribute	attr;
 };
@@ -123,6 +124,7 @@ struct kfd_cache_properties {
 	uint32_t		cache_latency;
 	uint32_t		cache_type;
 	uint8_t			sibling_map[CRAT_SIBLINGMAP_SIZE];
+	struct kfd_dev		*gpu;
 	struct kobject		*kobj;
 	struct attribute	attr;
 };
@@ -141,6 +143,7 @@ struct kfd_iolink_properties {
 	uint32_t		max_bandwidth;
 	uint32_t		rec_transfer_size;
 	uint32_t		flags;
+	struct kfd_dev		*gpu;
 	struct kobject		*kobj;
 	struct attribute	attr;
 };
--=20
2.17.1

