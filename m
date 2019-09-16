Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF52B3FFB
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbfIPSF4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 14:05:56 -0400
Received: from mail-eopbgr700063.outbound.protection.outlook.com ([40.107.70.63]:12385
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389732AbfIPSF4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 16 Sep 2019 14:05:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw2N/UJiBdO5HD0NlguFh6xXAHm6cBZ7i0yHIMR8zLKwnYBcuoxyD7Id8XnOtG0XUlrID85RqwfDUjnBstxMgChimTfLZd8ehoamyrF3aUqdo1FtEytYqRnYJlGEHqI0lKPZyeIlo2vxzkKtAWcEzjTRDq5/eqBhlzK+/YTnr1geuSr1ZejSp5MOSvJoX671len4oMMHD5mgK6+VXTjj2rWX70JodII3ilbnQoNiQgF4l+rsdTIKTCqW6Hjz+qNsxtV55xCLWcj9/GglkoH+Y1S9YFQMNmwFxvEmT18mcVpAHCejPzyMeDz5QCr57gM3gcrhAvDEm5KKkCWSAzqe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=711Jd8G4QLnfXo8Geb9rDE+s6CJ27sbOe3weF+9imtc=;
 b=nHL0jxRaVC5vqzuSNKsIyYTTdfmWJMkPakxbtDnJDCANBiZmHdSdhgs10+GlOeYB6tDa0pEIL/SQV/osTv5ADZUEM68DZRoIgxKLlKzAW3lPLwIjF1CEe/epNzqsFamn91xl4mbuHZL1KWHJTLgKX8I5OVJIItYbv/MvXOY1Hri4YRsZEM1Wb2XKf7O1oEis+mKWPaNApnfFW8vPh6A99aIbCVaT8uitR4aK7wCSQpPqNDh+9hlK1tUUhjybGSHoP/ngi9dKBf2OuimaJXurfxQPFiwggFfPY4Qg3BMSfwFb0TUpNHuS8zkBM3328z2AIkXmIQzEd5N1WhkCdT5lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=711Jd8G4QLnfXo8Geb9rDE+s6CJ27sbOe3weF+9imtc=;
 b=r1grLvkXquuOEcDyspdLVl9/6rTLIrxjBP2AaeTOBywnBbbvn4b64RDRN3kAlx84v44VUbebD9bKwIcpGi6Rm6SSWar7KeDw9fTD1UQUqU98nvQhYd6SyqAJvLBmrmYxr4WdkG/7Ex6KY/mW9TJBdEZ2dUXN/IZxZIp09+Pu5QI=
Received: from MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.237.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 18:05:55 +0000
Received: from MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee]) by MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 18:05:55 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 2/4] drm/amd: Pass drm_device to kfd
Thread-Topic: [PATCH v2 2/4] drm/amd: Pass drm_device to kfd
Thread-Index: AQHVbLliAvK2ymwTg0el4vkyWPjMIQ==
Date:   Mon, 16 Sep 2019 18:05:54 +0000
Message-ID: <20190916180523.27341-3-Harish.Kasiviswanathan@amd.com>
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
x-ms-office365-filtering-correlation-id: aa1762c5-5e80-4318-e897-08d73ad08482
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3871;
x-ms-traffictypediagnostic: MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3871937F7DD0A1CA7E9154ED8C8C0@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(50226002)(5660300002)(2906002)(486006)(76176011)(53936002)(36756003)(66946007)(6512007)(1076003)(66556008)(66476007)(64756008)(52116002)(81156014)(8676002)(66446008)(6436002)(14454004)(86362001)(478600001)(446003)(11346002)(81166006)(71190400001)(2501003)(2616005)(4326008)(476003)(71200400001)(25786009)(3846002)(14444005)(8936002)(6486002)(6116002)(256004)(54906003)(110136005)(99286004)(6506007)(66066001)(7736002)(386003)(305945005)(26005)(186003)(316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3871;H:MN2PR12MB2911.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8to5owsAdcbQ/jYV9/YvCgpRV9ptSbWhiwRGnmhn/ICcgesRBihCZZ8/e6FspxkPgsOaJ6FDHPu/OjDzy3nWZ5ZaT+jsLHgXjdQ//+pjqCPk1NND8FdbfouZPtEDMfL8oENGHllljr9S0r5wZPG/HyCcMSIy2GealEnZquz4q07tCVTxB3Lkyc6DuyZSU/vH6b54xzqS/8RWUgwXPsdG/m23HyG8IxH49uYMcmRL+h2QJzEL6edr1+QCJJCM7w8quSw8kHG1t9psYMzR1LGt5yuNDdPX+VXiPTCsSsyLoTLCjoKDg2Eq5S/1F1EsTKH0mm3J+2Jgnm55lzxOvRds+9wFFY868+Hfww0PuP6dYGsXkaORn8bQSYFzf0stdqOEZD63AsIziHiodxrYOJC47U1ODzv6GzxXEecxo0DxOCc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1762c5-5e80-4318-e897-08d73ad08482
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 18:05:54.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoQX0yMzVtr0nVO0wncBL3BFnw1Q6lgHjPiF3BH3Dw4E/S2DOaUSSUdPFRnDp6D4RAk8aEpFzGFoacI2L1AiLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kfd needs drm_device to call into drm_cgroup functions

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 363005526d7b..681a4a9ff51c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -204,7 +204,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *ad=
ev)
 					adev->doorbell_index.last_non_cp;
 		}
=20
-		kgd2kfd_device_init(adev->kfd.dev, &gpu_resources);
+		kgd2kfd_device_init(adev->kfd.dev, adev->ddev, &gpu_resources);
 	}
 }
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index e39c106ac634..4eb2fb85de26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -251,6 +251,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, stru=
ct pci_dev *pdev,
 			      const struct kfd2kgd_calls *f2g,
 			      unsigned int asic_type, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
+			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index f329b82f11d9..06461ac730d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -514,10 +514,12 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 }
=20
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
+			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
 {
 	unsigned int size;
=20
+	kfd->ddev =3D ddev;
 	kfd->mec_fw_version =3D amdgpu_amdkfd_get_fw_version(kfd->kgd,
 			KGD_ENGINE_MEC1);
 	kfd->sdma_fw_version =3D amdgpu_amdkfd_get_fw_version(kfd->kgd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 06bb2d7a9b39..9c56ba6ec826 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -47,6 +47,8 @@
 /* GPU ID hash width in bits */
 #define KFD_GPU_ID_HASH_WIDTH 16
=20
+struct drm_device;
+
 /* Use upper bits of mmap offset to store KFD driver specific information.
  * BITS[63:62] - Encode MMAP type
  * BITS[61:46] - Encode gpu_id. To identify to which GPU the offset belong=
s to
@@ -230,6 +232,7 @@ struct kfd_dev {
=20
 	const struct kfd_device_info *device_info;
 	struct pci_dev *pdev;
+	struct drm_device *ddev;
=20
 	unsigned int id;		/* topology stub index */
=20
--=20
2.17.1

