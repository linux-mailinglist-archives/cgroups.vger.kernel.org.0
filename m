Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15E1BCBED
	for <lists+cgroups@lfdr.de>; Tue, 24 Sep 2019 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbfIXPyv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Sep 2019 11:54:51 -0400
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:63305
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390477AbfIXPyu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 24 Sep 2019 11:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT8ds78fn/vFPx7qAg7767nmY7rvRZ+YBnHM8fReCUkN3CvwvaEuXjAHtPFxKkOPtxm06QF6dQBf5ymTeQGSEH1UHD1gKdWoBcORSmfW8rpZFVOrGMGQ7iJ6xm9vUKBkKcfn+Q2LocVcTVOJe4T+SB73ptCQ2tlReEDGzXKjx3hAPdNnugDiHFclA2/R0aTQvM9I5W5V598blHO+6Eg1/ypGkGOY9VamDL0ca0/1gUKONlJ/iKq1sPkjJ+BqBARcIyl5G6e+WxRpiGOrfhUZs1ZiyqKI/CjH9DdkLLc5N+wDaFbJglpQR1GTux+mwKxCQmKribUvURsHgop/WFDxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4J/NmVXX5PWfofOcal7bDVRflzQD29HG9FHkGyhBDM=;
 b=IMo/6JtwPYKA+eRIfahgrhqzipAH5A3T0qImBKFKOABy5AMvyVOM9L1tE4iRelGyPasd2nDyAFqSSb6NaC/2MTRVpb84rthKktHhxmU/DjRTKoZMLZUsoCtotXX19UZHSjmD6X+RqpsgGfaQR7KRaWesxlYl+WA/7ZAqepoXUmszeyTR8n0SfQLYZRb+XTC7Ko4Iv8jjO7xxH05T+KRv3aCkEO1lJOxgqUcAPzKCBVgF0Od0M5bp4YBsc3oaNwOBuS66ENWLmE5scRJbaMXwsXCCk1dGS0Ve/fEg0R0uX9HyTnpooYkJzsREa58SW3VG2qF7T+pn7huwfncsmPQMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4J/NmVXX5PWfofOcal7bDVRflzQD29HG9FHkGyhBDM=;
 b=EM4LtK1XlhKGmF5viJ9Qzwc0AW7Nw/HgwQnZLWTWxR4M3D4iXMiyAUQo0erkD6EE0sikLQdMOP9XvLAb2NtBWgMxZ59jJ2Ja0Eo2uVIy7ZmV4VqVR3yxejbxRqdp8tHVnA2yjUFViSKAmEfvYmrchphL33As3TnFb7xTUrPRCW0=
Received: from MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) by
 MN2PR12MB3454.namprd12.prod.outlook.com (20.178.242.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Tue, 24 Sep 2019 15:54:47 +0000
Received: from MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee]) by MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 15:54:47 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Topic: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Index: AQHVbLlix8wpR6fijka6GKZIrnMmXKc7BmWA
Date:   Tue, 24 Sep 2019 15:54:47 +0000
Message-ID: <MN2PR12MB2911F59E9B91AAD349B4E40F8C840@MN2PR12MB2911.namprd12.prod.outlook.com>
References: <20190916180523.27341-1-Harish.Kasiviswanathan@amd.com>
 <20190916180523.27341-4-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20190916180523.27341-4-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b40770-4807-4e07-7c77-08d741078685
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3454;
x-ms-traffictypediagnostic: MN2PR12MB3454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34545A0A61BE72F6016363F58C840@MN2PR12MB3454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(13464003)(189003)(199004)(25786009)(86362001)(3846002)(6116002)(186003)(4326008)(81156014)(2501003)(33656002)(81166006)(478600001)(26005)(76176011)(14454004)(8676002)(8936002)(99286004)(7696005)(53546011)(110136005)(54906003)(102836004)(6506007)(316002)(476003)(7736002)(9686003)(55016002)(486006)(74316002)(76116006)(66446008)(66556008)(66476007)(6436002)(14444005)(52536014)(2906002)(64756008)(305945005)(229853002)(71190400001)(71200400001)(66946007)(66066001)(256004)(11346002)(5660300002)(6246003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3454;H:MN2PR12MB2911.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gn27aihubt4E0E8paVdK0E4NCwwTaTc3W3lv4AGvfECyJ3TLezwn5zvS0sIBuPAGJScxrXhNp73KG6uMA++w7+tbLVemVweRZ560ULjrgTnzACMc875RNYEmL53RQtU/yykvv7zcNVwXmSN30Q1mcAkwG0ih/ESOqRbRJ6iz6JpB8bncsn1rFl0i/9bevDxKXcWuH9ecpUpWubJizssytUXYcLWO2VLfFDaAddbdNdbWadlmxQUkcEbMhBMCVAZ0AyLZbkpteKypjhYu+dvgcYNJl4jmdiyMY7rtesPeOGrIvGt8JlbUs820GIUeAPmEJ+a6F3GMtTleQHEpZz3Zu2RiRKTJvrRio0OOnQA3cYgIFu6EdtHrB3goPm5JDB19VnlQ0i3ZUDQOl/XssZlINQX6SqlNmZNPRxJP9VzfweI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b40770-4807-4e07-7c77-08d741078685
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 15:54:47.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug3lEScd47osORLMSnRXHSoUxqvKmlQj5lWBbTQVsN/I5Cd4DtKS9neYkLkJSopqyCaRzyjtsTDEmRFf+CWV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3454
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

Can you please review this? You and Roman acked this patch before. It will =
be great if I can Reviewed-by, so that I can upstream this through Alex Deu=
cher's amd-staging-drm-next and Dave Airlie's drm-next trees

Thanks,
Harish


-----Original Message-----
From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>=20
Sent: Monday, September 16, 2019 2:06 PM
To: tj@kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; airlied@=
redhat.com
Cc: cgroups@vger.kernel.org; amd-gfx@lists.freedesktop.org; Kasiviswanathan=
, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission

For AMD compute (amdkfd) driver.

All AMD compute devices are exported via single device node /dev/kfd. As
a result devices cannot be controlled individually using device cgroup.

AMD compute devices will rely on its graphics counterpart that exposes
/dev/dri/renderN node for each device. For each task (based on its
cgroup), KFD driver will check if /dev/dri/renderN node is accessible
before exposing it.

Change-Id: I9ae283df550b2c122d67870b0cfa316bfbf3b614
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 include/linux/device_cgroup.h | 19 ++++---------------
 security/device_cgroup.c      | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index 8557efe096dc..fa35b52e0002 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -12,26 +12,15 @@
 #define DEVCG_DEV_ALL   4  /* this represents all devices */
=20
 #ifdef CONFIG_CGROUP_DEVICE
-extern int __devcgroup_check_permission(short type, u32 major, u32 minor,
-					short access);
+int devcgroup_check_permission(short type, u32 major, u32 minor,
+			       short access);
 #else
-static inline int __devcgroup_check_permission(short type, u32 major, u32 =
minor,
-					       short access)
+static inline int devcgroup_check_permission(short type, u32 major, u32 mi=
nor,
+					     short access)
 { return 0; }
 #endif
=20
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
-static inline int devcgroup_check_permission(short type, u32 major, u32 mi=
nor,
-					     short access)
-{
-	int rc =3D BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access);
-
-	if (rc)
-		return -EPERM;
-
-	return __devcgroup_check_permission(type, major, minor, access);
-}
-
 static inline int devcgroup_inode_permission(struct inode *inode, int mask=
)
 {
 	short type, access =3D 0;
diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index dc28914fa72e..04dd29bf7f06 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -801,8 +801,8 @@ struct cgroup_subsys devices_cgrp_subsys =3D {
  *
  * returns 0 on success, -EPERM case the operation is not permitted
  */
-int __devcgroup_check_permission(short type, u32 major, u32 minor,
-				 short access)
+static int __devcgroup_check_permission(short type, u32 major, u32 minor,
+					short access)
 {
 	struct dev_cgroup *dev_cgroup;
 	bool rc;
@@ -824,3 +824,14 @@ int __devcgroup_check_permission(short type, u32 major=
, u32 minor,
=20
 	return 0;
 }
+
+int devcgroup_check_permission(short type, u32 major, u32 minor, short acc=
ess)
+{
+	int rc =3D BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access);
+
+	if (rc)
+		return -EPERM;
+
+	return __devcgroup_check_permission(type, major, minor, access);
+}
+EXPORT_SYMBOL(devcgroup_check_permission);
--=20
2.17.1

