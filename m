Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EC81CE23
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfENRiC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 13:38:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56888 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbfENRiB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 13:38:01 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EHZY9L003642;
        Tue, 14 May 2019 10:37:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UiKD4eIBRQlORSYHHk9+E29AxWlzzgFhNYxpF2gL9Q4=;
 b=grX6znigpdJulaBpqZYlrwuib+rKkSB90Qmrs9C9DAatuLIOmodBaaNvHIZSYeHNDiwe
 tjpiaSET/m9Vn9TCp0zvhlB/iPDOHFAP4WKDulI4NS+0Dt+260EpoZjDcgNKvx6XfPBe
 JhdCuwalQ+NIbtkA0mzkNYqF3zI82DXWycg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sfy23rvac-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 May 2019 10:37:57 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 May 2019 10:37:56 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 May 2019 10:37:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiKD4eIBRQlORSYHHk9+E29AxWlzzgFhNYxpF2gL9Q4=;
 b=Auba8Tg96eF/qoE8w3sLU70R0LwQ//KO8U9WVTq/hzwNuKaWAYFRPIBHY4mU2OpNHQnQCN+YjsTzljtwFn+oybX2f99/JYY+QsoT0B/HJ7ccHuNlGgMf3ZkMyFmrKooJZkfuJ3uBqDKHJBdOZxsrE8xz+pCxPSjWheKX2zU+lLQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3208.namprd15.prod.outlook.com (20.179.56.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Tue, 14 May 2019 17:37:54 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 17:37:54 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdkfd: Check against device cgroup
Thread-Topic: [PATCH 4/4] drm/amdkfd: Check against device cgroup
Thread-Index: AQHVAC55koEwRnit7kyr2zcr6OGdM6Zpe10AgAF7x4A=
Date:   Tue, 14 May 2019 17:37:54 +0000
Message-ID: <20190514173749.GA12629@tower.DHCP.thefacebook.com>
References: <20190501145904.27505-1-Harish.Kasiviswanathan@amd.com>
 <20190501145904.27505-5-Harish.Kasiviswanathan@amd.com>
 <20190514015832.GA14741@tower.DHCP.thefacebook.com>
In-Reply-To: <20190514015832.GA14741@tower.DHCP.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:300:ae::28) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::298]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c4d9b55-db37-4a7c-f1d7-08d6d892e528
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3208;
x-ms-traffictypediagnostic: BYAPR15MB3208:
x-microsoft-antispam-prvs: <BYAPR15MB3208539FCFDB1BDB1FCA3CDDBE080@BYAPR15MB3208.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(6436002)(4326008)(25786009)(305945005)(68736007)(73956011)(53936002)(71190400001)(6246003)(7736002)(33656002)(6486002)(66446008)(81156014)(81166006)(14454004)(8936002)(229853002)(186003)(66476007)(66556008)(64756008)(66946007)(52116002)(446003)(478600001)(8676002)(6916009)(316002)(99286004)(1076003)(6116002)(54906003)(6512007)(9686003)(46003)(2906002)(71200400001)(76176011)(14444005)(102836004)(256004)(86362001)(486006)(6506007)(386003)(476003)(11346002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3208;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xm5H8VI7fwaWhGKRqvG7ENl+FZnaZtOyTg0sDMBJhhloGAHmNbkzYg4soB+MvtPYCJfIw9OQjaFre1IpfYnZ816ctUAbmR3kmjoyLB39JFgvN7LmZUaUJ6djUh3rRp1R9+RwaCGsKNEFwaJ5DuzTCsANHqdroE8OAsqGW891XtiBagYrXuSzNbtPoWCeLRBJSgWoVmUPxMG9lp6ywlpYr6OM1s1jtwv6Mn6LUybtl8cqqvmRkCyXSN2Liffr7a+s/Rl/gQk8ODwUDfwOamxBAjbgTaIYxAKdEXPBOZ2PUwqb8bGipFE4vHs6WlRFecUme4+EMMpkpyhfwtxv6kD/2y8WbPLEq0nZKY0Vwy8ENUf3p1XIvs4CGD7KpSctbuDaxjIKP6zbVxutQZZP00fCykakp4ZRCNJxwp9Rt+WMgFo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <606A94B7321FCC45AB99DA08D0D9361D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4d9b55-db37-4a7c-f1d7-08d6d892e528
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 17:37:54.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140120
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 14, 2019 at 01:58:40AM +0000, Roman Gushchin wrote:
> On Wed, May 01, 2019 at 02:59:29PM +0000, Kasiviswanathan, Harish wrote:
> > Participate in device cgroup. All kfd devices are exposed via /dev/kfd.
> > So use /dev/dri/renderN node.
> >=20
> > Before exposing the device to a task check if it has permission to
> > access it. If the task (based on its cgroup) can access /dev/dri/render=
N
> > then expose the device via kfd node.
> >=20
> > If the task cannot access /dev/dri/renderN then process device data
> > (pdd) is not created. This will ensure that task cannot use the device.
> >=20
> > In sysfs topology, all device nodes are visible irrespective of the tas=
k
> > cgroup. The sysfs node directories are created at driver load time and
> > cannot be changed dynamically. However, access to information inside
> > nodes is controlled based on the task's cgroup permissions.
> >=20
> > Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>=20
> Hello, Harish!
>=20
> Cgroup/device controller part looks good to me.
> Please, feel free to use my acks for patches 3 and 4:
> Acked-by: Roman Gushchin <guro@fb.com>

Hello!

After the second look at the patchset I came to an understanding that
exporting cgroup_v1-only __devcgroup_check_permission() isn't the best idea=
.

Instead it would be better to export devcgroup_check_permission(), which
provides an universal interface for both cgroup v1 and v2 device controller=
s.
It  require some refactorings, but should be not hard.

Does it makes sense to you? Can you, please, rework this part?

Thanks!
