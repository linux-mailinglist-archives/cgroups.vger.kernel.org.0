Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B59B3FFD
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbfIPSF7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 14:05:59 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:51195
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389732AbfIPSF7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 16 Sep 2019 14:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvffLxyoJ3kyfL6svspZNt9PVhKZLLH+kzyfFwsJQ+HmNxqKqw/M6NM6kUCwtnHaQwupHLTfo4QgsCn9RvR/xt0RNrbN1NtDVCSfwdU3R1jXGcl7bbhd7Lc0jdpiHjlNX7EiAw88mk6LpNbPEabKK0FVO40w8mA97X9yaGqHtEWTMRgGo+1/JQYB8WQU6ALPW2RUe/jL93Ps4C1J/ZkQOtcr/z9bdnO86iTSNyfsLAZpU/g3P1aXYuBJB/cxNqVXp33doRkpEL5B7D/5Tkf35qs5cRJvDLc4hpXn/k2mohGZP/wVGiKajse3kjlJCSqrlZ/ETep2zj1U+KbtnvHFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaV3tmIkmDPNM4ertYAP7SG+Vzv6SiJ4HnDgMllXyCA=;
 b=BwXCgcnwLZu/pgltjfDVOJ0+TS/UIv16RfNbznRfIO4D8rTrU6n52mTUgsC1mWu2Bbf3dTnSpJcXNpgRERc6tCvnRlmsnpNYxm8hByHH6/aS/AektLL+bgnCuHFtmsKLcT6JfdGxzJgxw9Fak1T0GmF9jV5FUhT2PAun92IBwQwpLEhqNV1166+O8Udovpxn0FgPRT9ncrgIEonWcezg/nLMMvL4oFF2JOBexGQ4VnAwyksLZvCZhph0891d6yEiu9YoZMXLglJzPuV8jaC1oxuipZR8aZhcAlCWLjNBRoJMlpNXtsLqDUI1nY0qdHR/LfLve0cfTbd3vEcAHfBkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaV3tmIkmDPNM4ertYAP7SG+Vzv6SiJ4HnDgMllXyCA=;
 b=t3vXtlBpC7Wh7AjeKpm2UAyBx2cYQ6GRCf3Xy9s65c6aBrdsR+Rusc28oNMYAHpq8FhbxKFckEueMLAuqcPsRbL8jqpvtlVr+QkPeLlLiYkKAxgtRs/0nT6RdWqnuKNAtIq1NuNaKaHnzHsVWYiyGBgb05DAAfXZZWoXY5TjCHI=
Received: from MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.237.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 18:05:56 +0000
Received: from MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee]) by MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 18:05:56 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Topic: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Index: AQHVbLlix8wpR6fijka6GKZIrnMmXA==
Date:   Mon, 16 Sep 2019 18:05:56 +0000
Message-ID: <20190916180523.27341-4-Harish.Kasiviswanathan@amd.com>
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
x-ms-office365-filtering-correlation-id: 13bbf530-e682-437f-8dbe-08d73ad0853f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3871;
x-ms-traffictypediagnostic: MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38716BC5B3CED3C412C5D8A58C8C0@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(50226002)(5660300002)(2906002)(486006)(76176011)(53936002)(36756003)(66946007)(6512007)(1076003)(66556008)(66476007)(64756008)(52116002)(81156014)(8676002)(66446008)(6436002)(14454004)(86362001)(478600001)(446003)(11346002)(81166006)(71190400001)(2501003)(2616005)(4326008)(476003)(71200400001)(25786009)(3846002)(14444005)(8936002)(6486002)(6116002)(256004)(54906003)(110136005)(99286004)(6506007)(66066001)(7736002)(386003)(305945005)(26005)(186003)(316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3871;H:MN2PR12MB2911.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gyQIE8zWzFi+hbRD/fyJIf30WOcBtH1BhSBT9qPeG1W+Oxp43es5b+S/H9rDyPuSnqu7HGSdh+zSSsjbl+25gAovaoDoPzjTIul6VVsg3oyEeKjd/How1rugVTn8bg4S/cNTHERESOd9jVwGIgpKCO6d2/kb7zo4mth2NiMkMMgxRq76ls/U3KrmY+5ybrTA0GvKBEtU/7rpLPBXa48Or61pSTgkgQX+opYSeMxDKKPKwtKQ4G8VJmDZZ9yXXvnxlCNfu7pPlmCllouHPN3b8ErBVzKseGseZ0WJJiyPt0K0e0E+rFDbCo2GaN56w2qHq/ebi7Ngl/69s/ujbimKdIUa+D57Ix6lbEr5HTtbFjzS32VkA+NNS1QfS9wZXnl393m9Y3ZTse0O0izuukAEuBds1hdZtLKAcp2xPrOiYJc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bbf530-e682-437f-8dbe-08d73ad0853f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 18:05:56.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vd+PNMSdIeCCLWHmybOsoj+hLXfWsDM0Jn0yeTbjhNe7BQAWri851MJFlvbk+/a0fCi51GDN6xNOm5aADR41Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

