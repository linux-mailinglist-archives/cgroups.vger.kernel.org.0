Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263F221C32
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEQRGn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 13:06:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48288 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbfEQRGn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 13:06:43 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HH4doJ023895;
        Fri, 17 May 2019 10:06:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pnMrEG9vRZsFDJQ6gNjPxBugHwQOwy4CdNuaafAAmSc=;
 b=Z3eSJf0RaI77w7mYOpQRu/aKk+vMg6WQKrpEJrU/YSBnlw6WaEB46ZUa1DAttKiAlhEj
 X6euveiu2kcS4QOki7uWH/Bb7pME7ld/KDZhdxs76yIwTo9A/Ktcco2mR694/KfqjA/m
 aYkPlczg6pc2f//8fV2lPOiUbZPJmtLENoE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2shxhhrk7h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 10:06:38 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 10:06:37 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 10:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnMrEG9vRZsFDJQ6gNjPxBugHwQOwy4CdNuaafAAmSc=;
 b=Z78BCI5dGhDrFRq18yq3C/H7ezjOgHjZ2qcSgVFimvpOA1PqhTCz94V9ODS05niEgNhxSVguz64hwBN032f9yb1ST6GyCgG2PxVK0Z6j8/iWzdJT1uZwJ5oEXDi6TrsfCU7bGBTXd8qLlSbwG4wexS9G836+oWa4uKVoMbSUrl8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2821.namprd15.prod.outlook.com (20.179.158.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 17 May 2019 17:06:36 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 17:06:35 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Topic: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Index: AQHVDMuwlGxX/j2JnUSoSESRdhEwJaZvjCgA
Date:   Fri, 17 May 2019 17:06:35 +0000
Message-ID: <20190517170630.GA1646@tower.DHCP.thefacebook.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
 <20190517161435.14121-4-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20190517161435.14121-4-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:300:117::26) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:2e0d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c58dc14-5bdc-4407-5ebb-08d6daea04b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2821;
x-ms-traffictypediagnostic: BYAPR15MB2821:
x-microsoft-antispam-prvs: <BYAPR15MB2821BBCBDB96F6FE4B375ED0BE0B0@BYAPR15MB2821.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(256004)(14444005)(25786009)(1076003)(6916009)(14454004)(8936002)(81166006)(8676002)(6246003)(81156014)(476003)(4326008)(5660300002)(478600001)(11346002)(46003)(33656002)(446003)(229853002)(99286004)(186003)(6436002)(54906003)(64756008)(73956011)(66556008)(66476007)(66446008)(6512007)(9686003)(68736007)(386003)(66946007)(86362001)(6116002)(102836004)(305945005)(6506007)(2906002)(52116002)(71200400001)(71190400001)(6486002)(7736002)(486006)(53936002)(76176011)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2821;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LODF53f37dTqzs76v+gWepWnbTXq7v0FmhKS86lnHv+KXyqs9YOj+5Q57Vg1VXQZCFFyO0aVYKY53oujyRM2pJueoK3VLk8J7Eg3E61vVvCcTQvCKgJhmzbQPNBcyF25uFrovgKViGLZO32PpsN4czRpaPVw7GXWUWAHF/Jt0amV2rtzH87dtuOp6DnnZIcXlc/Wj0KZ85HliC/951kEjONfs+I3+ypwZykMCvnFchkWujnNwFXbpnBu89MKzRYw2Dvg+/fen2JTCiYzjtUR5WqfXK5rSFFYKP2G/cjp6FN3l1p29QhpOJn9LyR00hOMo3Zd9AQEK7fuvOpurFd0v5D0uv19lX/Ry1FEUyggFy7UOj/evPSptl/MbIRr3pdVl/+jeqgTH2HkgFaUoLJ3TJInKmjm8FD2CcM5k7LkHjQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC1F663BC871E54EB6797495E4A22492@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c58dc14-5bdc-4407-5ebb-08d6daea04b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 17:06:35.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2821
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 04:15:06PM +0000, Kasiviswanathan, Harish wrote:
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
> Change-Id: I1b9705b2c30622a27655f4f878980fa138dbf373
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  include/linux/device_cgroup.h | 19 ++++---------------
>  security/device_cgroup.c      | 15 +++++++++++++--
>  2 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.=
h
> index 8557efe096dc..bd19897bd582 100644
> --- a/include/linux/device_cgroup.h
> +++ b/include/linux/device_cgroup.h
> @@ -12,26 +12,15 @@
>  #define DEVCG_DEV_ALL   4  /* this represents all devices */
> =20
>  #ifdef CONFIG_CGROUP_DEVICE
> -extern int __devcgroup_check_permission(short type, u32 major, u32 minor=
,
> -					short access);
> +extern int devcgroup_check_permission(short type, u32 major, u32 minor,
> +				      short access);
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
> index cd97929fac66..3c57e05bf73b 100644
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

Perfect, now looks good to me!

Please, feel free to use my acks for patches 3 and 4:
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
