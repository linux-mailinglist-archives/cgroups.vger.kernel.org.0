Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82934BD05E
	for <lists+cgroups@lfdr.de>; Tue, 24 Sep 2019 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394984AbfIXRNR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Sep 2019 13:13:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1722 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391323AbfIXRNR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Sep 2019 13:13:17 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OH3tHp020099;
        Tue, 24 Sep 2019 10:13:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=oaNLN/OoQg0jn5YFYC9SRGx0oWJ1YJaT+a/tzQHnD+U=;
 b=KLwDOAL2ZomwKGcWmle97dLICfTildSZLmsHZfsDdwDkCq6W3usOe9Jl7rEaaT5KDhiX
 hvxGfKLleRNs1i7761JEjy8PFbBAtAFOPBkOUOShptPay6sjY46MilwJdqw9Se5mX/Kg
 0EnQAPClaaH0A/EOZykvuV0BQVcsLH+C+HY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v7q7481tr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Sep 2019 10:13:10 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 10:13:09 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 10:13:09 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Sep 2019 10:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/oNt7asAPvxNzYDbc4Shocw/tZXipSVtpWmJKFh6oxcAtHvqqbC5UzCFMf+JwcAoR74kfcKRK80CEfftVYIgk2s/Kx13HyXo1Ebl+zwUBv/CWTP5Y6XUhjzS6pEv3h1Br8tseeFD5nnSCv4EBGc3EXKeYZlSrGWwAy0ekIs2siydsUUrp/CAbIfnacBQsd1UBb7mxQwxt+besJ1+h3syGlSn78oq3JjC4zenez3iNmAM+Sj8enwGQAmjj9TK5Q+GQgk9KNKi/LZZCCEiEyORUMzi0RYWS1Hpnmch+JMp6ldHNfPKzJjxiB1Ti8aQu4DeVFYbvN07q+JTJpViNeJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaNLN/OoQg0jn5YFYC9SRGx0oWJ1YJaT+a/tzQHnD+U=;
 b=hGeEfnw0Lu7k0PoGQwHiCGj1z6ouj/wGHXuuDBX1BI8xhkEzgosfO0scUtiexdTJYzjmwOP2PqOM10D3BVQbgytfhoxzS5u1ZHoJ9qxTIuNQo0fAnFV5yh06N18+ZL6RANadxJzUp9WEhJLkXBd+x2Y9a8dZRwnV63lI3mTyny2RIkqmax78PgMfWXJak7TwjnMf0BOOJozwzrjQ7T+P9iI1fSrCJGFlntKI+CbRLRQPAlRH7d1KvUmywFtkAO3HIIQ5fNx/n34XsWdfwGyr1Vkpjnv0TH21JL+WgqJHLpY+cTy3Ey0b4z66Amz1u0ix3X3mQ+30CXjkqz/F0KG/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaNLN/OoQg0jn5YFYC9SRGx0oWJ1YJaT+a/tzQHnD+U=;
 b=kmeKRuJrCBlmYZM1r5o/P/WEAIK44GU5vbbE8cc2TY853SAJbpmFKxMAJ/JpglsamhbcCH6TUJVzvdbPEo8NKhMYKrwHE7Oecmai9tFH2lh+36TlW5wXERlqPao1lcsmHrr4+sZJx2cEE273n38jKffKKR+HgSIMZwvCEc5XMIE=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2947.namprd15.prod.outlook.com (20.178.219.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 17:13:07 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 17:13:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Topic: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Index: AQHVbLlsnLqAQxP6tk+8o6W7mImx6qc7B1SAgAAV3oA=
Date:   Tue, 24 Sep 2019 17:13:07 +0000
Message-ID: <20190924171303.GA1978@tower.DHCP.thefacebook.com>
References: <20190916180523.27341-1-Harish.Kasiviswanathan@amd.com>
 <20190916180523.27341-4-Harish.Kasiviswanathan@amd.com>
 <MN2PR12MB2911F59E9B91AAD349B4E40F8C840@MN2PR12MB2911.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB2911F59E9B91AAD349B4E40F8C840@MN2PR12MB2911.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:7406]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82c7fe62-6b34-462b-09f1-08d7411277e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR15MB2947;
x-ms-traffictypediagnostic: BN8PR15MB2947:
x-microsoft-antispam-prvs: <BN8PR15MB2947EB010434743900C4E633BE840@BN8PR15MB2947.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(366004)(39860400002)(376002)(199004)(189003)(13464003)(486006)(256004)(33656002)(186003)(14444005)(71190400001)(14454004)(86362001)(8936002)(8676002)(305945005)(6246003)(71200400001)(6486002)(7736002)(316002)(229853002)(25786009)(81156014)(11346002)(46003)(6512007)(81166006)(476003)(6916009)(9686003)(5660300002)(53546011)(52116002)(446003)(66556008)(66446008)(66476007)(6436002)(64756008)(99286004)(102836004)(76176011)(66946007)(54906003)(2906002)(1076003)(478600001)(386003)(4326008)(6116002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2947;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sbULqnyE8xwT7VH1xDgLVLOZL5kf5GfLomgZ7kDDFgoVjhRMZuAAW37eNuqfGWGwsQ5vDl+XCgWyZZ6w+LyPjjrKDyNj+WYSaZ9hjdvV2Zz3EeMLsyl9eqnw1ZvDYui2WOSB7A8xsswGPBZzabFh7YFoar/xrv4u/lQgTGE4sB/ONHxk8Bl2balhvMaiWNrd5Q06/ESI9uhaNbDV+7bK4Ic9oQWo0Xeq6/Ct2QlvkL87YRxZKUshVNNeooemT8zWlPMd9+6HOiOPQBIKGwrqfKo/2glaZYtPB0aUokypsvol4nZ+LtPEBVGi0b8KDXcMRfzT8pnwOKkn7ISXeuIHCQlaLab/krsiANxTiePuRZHsaWtdrAY32NZqXoErGH7UUS/Z2pnmvvxKtUb46DaJ0A6+n7AvN/vs1YbDzHNanQY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C5BA7C636460D4186CFC4B1FC662A53@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c7fe62-6b34-462b-09f1-08d7411277e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 17:13:07.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsiX5T32weTSms5ceOgaaL52iZO2EkX10FgnZPZxFt2DbSXYk9l6QXW5VbO9pKlk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2947
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_07:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909240150
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 24, 2019 at 03:54:47PM +0000, Kasiviswanathan, Harish wrote:
> Hi Tejun,
>=20
> Can you please review this? You and Roman acked this patch before. It wil=
l be great if I can Reviewed-by, so that I can upstream this through Alex D=
eucher's amd-staging-drm-next and Dave Airlie's drm-next trees
>=20
> Thanks,
> Harish

Hello, Harish!

If it can help, please, feel free to use
Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!

>=20
>=20
> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>=20
> Sent: Monday, September 16, 2019 2:06 PM
> To: tj@kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; airlie=
d@redhat.com
> Cc: cgroups@vger.kernel.org; amd-gfx@lists.freedesktop.org; Kasiviswanath=
an, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
>=20
> For AMD compute (amdkfd) driver.
>=20
> All AMD compute devices are exported via single device node /dev/kfd. As
> a result devices cannot be controlled individually using device cgroup.
>=20
> AMD compute devices will rely on its graphics counterpart that exposes
> /dev/dri/renderN node for each device. For each task (based on its
> cgroup), KFD driver will check if /dev/dri/renderN node is accessible
> before exposing it.
>=20
> Change-Id: I9ae283df550b2c122d67870b0cfa316bfbf3b614
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  include/linux/device_cgroup.h | 19 ++++---------------
>  security/device_cgroup.c      | 15 +++++++++++++--
>  2 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.=
h
> index 8557efe096dc..fa35b52e0002 100644
> --- a/include/linux/device_cgroup.h
> +++ b/include/linux/device_cgroup.h
> @@ -12,26 +12,15 @@
>  #define DEVCG_DEV_ALL   4  /* this represents all devices */
> =20
>  #ifdef CONFIG_CGROUP_DEVICE
> -extern int __devcgroup_check_permission(short type, u32 major, u32 minor=
,
> -					short access);
> +int devcgroup_check_permission(short type, u32 major, u32 minor,
> +			       short access);
>  #else
> -static inline int __devcgroup_check_permission(short type, u32 major, u3=
2 minor,
> -					       short access)
> +static inline int devcgroup_check_permission(short type, u32 major, u32 =
minor,
> +					     short access)
>  { return 0; }
>  #endif
> =20
>  #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
> -static inline int devcgroup_check_permission(short type, u32 major, u32 =
minor,
> -					     short access)
> -{
> -	int rc =3D BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access=
);
> -
> -	if (rc)
> -		return -EPERM;
> -
> -	return __devcgroup_check_permission(type, major, minor, access);
> -}
> -
>  static inline int devcgroup_inode_permission(struct inode *inode, int ma=
sk)
>  {
>  	short type, access =3D 0;
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index dc28914fa72e..04dd29bf7f06 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -801,8 +801,8 @@ struct cgroup_subsys devices_cgrp_subsys =3D {
>   *
>   * returns 0 on success, -EPERM case the operation is not permitted
>   */
> -int __devcgroup_check_permission(short type, u32 major, u32 minor,
> -				 short access)
> +static int __devcgroup_check_permission(short type, u32 major, u32 minor=
,
> +					short access)
>  {
>  	struct dev_cgroup *dev_cgroup;
>  	bool rc;
> @@ -824,3 +824,14 @@ int __devcgroup_check_permission(short type, u32 maj=
or, u32 minor,
> =20
>  	return 0;
>  }
> +
> +int devcgroup_check_permission(short type, u32 major, u32 minor, short a=
ccess)
> +{
> +	int rc =3D BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access=
);
> +
> +	if (rc)
> +		return -EPERM;
> +
> +	return __devcgroup_check_permission(type, major, minor, access);
> +}
> +EXPORT_SYMBOL(devcgroup_check_permission);
> --=20
> 2.17.1
>=20
