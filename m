Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F41C06E
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 03:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfENB7G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 21:59:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfENB7G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 21:59:06 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E1oB36030425;
        Mon, 13 May 2019 18:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=i3Pkxf7VTf2IM0QTltjUJeV3OviV+aj+2NUhz7zBWuw=;
 b=AuFO/DlHcVDzd9CqPVz+ERSfyu/z8BUKNy0lNo9MOf+rDaG2xqQ+HAFzm1cA2zlv43ao
 oI1LoAWPGMpUTW4H9nbCXbPx2MccIM41cPuhV1l/gixIQEuQmQkLaRLTbx2EfJPyxLND
 BUaL8DHgOGv2DSFPZvX7Wimrkbw7hAC6QC0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sf9vh2cjx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 18:59:01 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 13 May 2019 18:59:01 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 13 May 2019 18:59:00 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 13 May 2019 18:59:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3Pkxf7VTf2IM0QTltjUJeV3OviV+aj+2NUhz7zBWuw=;
 b=gUdJwCB9lVehEqge/dww1jYByYlnasnAZ8f9F84HXnmveB+4jB2beFDl20cd/9n/F71Xy0u7m+lfCmAXVhv2dfPhkhoZDM5gMyo6ewpiEniab95II16Roy/8eZtWR2r97d0KQfiyQZDnhyfIqTVWeODemq4k67lD7BDGTD3zBFU=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2692.namprd15.prod.outlook.com (20.179.138.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Tue, 14 May 2019 01:58:40 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f%7]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 01:58:40 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdkfd: Check against device cgroup
Thread-Topic: [PATCH 4/4] drm/amdkfd: Check against device cgroup
Thread-Index: AQHVAC55koEwRnit7kyr2zcr6OGdM6Zp8LgA
Date:   Tue, 14 May 2019 01:58:40 +0000
Message-ID: <20190514015832.GA14741@tower.DHCP.thefacebook.com>
References: <20190501145904.27505-1-Harish.Kasiviswanathan@amd.com>
 <20190501145904.27505-5-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20190501145904.27505-5-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15)
 To BN8PR15MB2626.namprd15.prod.outlook.com (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3cb5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c89329c-60e5-4620-a799-08d6d80faf5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR15MB2692;
x-ms-traffictypediagnostic: BN8PR15MB2692:
x-microsoft-antispam-prvs: <BN8PR15MB26928D5C35302C17EDBFF5A4BE080@BN8PR15MB2692.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(6512007)(1076003)(229853002)(14444005)(9686003)(7736002)(81166006)(71200400001)(478600001)(71190400001)(186003)(81156014)(6486002)(256004)(6246003)(8936002)(8676002)(53936002)(33656002)(446003)(305945005)(46003)(64756008)(6916009)(5660300002)(66946007)(66446008)(73956011)(11346002)(66556008)(6436002)(54906003)(66476007)(4326008)(486006)(476003)(86362001)(14454004)(6116002)(316002)(25786009)(2906002)(6506007)(52116002)(99286004)(68736007)(76176011)(386003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2692;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2MDlAHQCOppJ5pKconq31DaNTjO9pcfH98tBjuaBtoflCYnkQo7Bcs5Rgzq+zWOmZZmQRZkxOAekuiR7PCQnup+/yub3ltlGlSuGwYVofgPaP92O1Erlq+FIIBTYpda3RwcwmkBSKE2xMLOhsDVD+GWJdJcF6hwD1BPP+XZ39WB3LVEd7WmMJIEBa7Cb1MQ1eN/VF8S9UjTTkOL2LCSTQMMKV+Z+0uJV57WditZ6O5bEq1KJ2XR/k65XXFjknDjsjaGlcDKx78MtXQUc+Sdg/mBg+eGD1ILb3z4o5DkkEjaBNraWKCVYqidtC8pC/UU5Pg2Y0+LN0JqTOWMYW6RHiH92xykCmqdKUng/nA2a2Q+acpMRsajRLB98+LG3dGJW+7SldUWpivIPHIp6azfFADbxjQccEAg9d5b1bWmrWuw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FF8CD02E98B004BBE547B3D3A239E33@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c89329c-60e5-4620-a799-08d6d80faf5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 01:58:40.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2692
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 01, 2019 at 02:59:29PM +0000, Kasiviswanathan, Harish wrote:
> Participate in device cgroup. All kfd devices are exposed via /dev/kfd.
> So use /dev/dri/renderN node.
>=20
> Before exposing the device to a task check if it has permission to
> access it. If the task (based on its cgroup) can access /dev/dri/renderN
> then expose the device via kfd node.
>=20
> If the task cannot access /dev/dri/renderN then process device data
> (pdd) is not created. This will ensure that task cannot use the device.
>=20
> In sysfs topology, all device nodes are visible irrespective of the task
> cgroup. The sysfs node directories are created at driver load time and
> cannot be changed dynamically. However, access to information inside
> nodes is controlled based on the task's cgroup permissions.
>=20
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Hello, Harish!

Cgroup/device controller part looks good to me.
Please, feel free to use my acks for patches 3 and 4:
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  9 +++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c    | 12 ++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_flat_memory.c
> index dc7339825b5c..3804edfb4ff7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -369,8 +369,13 @@ int kfd_init_apertures(struct kfd_process *process)
> =20
>  	/*Iterating over all devices*/
>  	while (kfd_topology_enum_kfd_devices(id, &dev) =3D=3D 0) {
> -		if (!dev) {
> -			id++; /* Skip non GPU devices */
> +		if (!dev || kfd_devcgroup_check_permission(dev)) {
> +			/* Skip non GPU devices and devices to which the
> +			 * current process have no access to. Access can be
> +			 * limited by placing the process in a specific
> +			 * cgroup hierarchy
                                           ^
				Probably, a missing dot here.
> +			 */
> +			id++;
>  			continue;
>  		}
> =20
