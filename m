Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9762721
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2019 19:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfGHRaq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Jul 2019 13:30:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45956 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728708AbfGHRaq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Jul 2019 13:30:46 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68HTDE5021381;
        Mon, 8 Jul 2019 10:29:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=x56FKSBgXOLvZMD+y3raguvfgHanfiop/tmf7yxKJYY=;
 b=YtjbrlQZ1KnjfbBOiHBpCkWxxlXu0WZ8e8LiV2iz/QSCTRBX4nOUMYB1ARsvrYmEaTRQ
 rohnfxxdCKGBlpzne6+IQ0oP6YNIxYdoOSWPtQn2yV5X4FDQcyXgr5Ht6XDT6Azpw+Fn
 x397Fd9PX3m85t6LqvHpus3MORRFLAId9l8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tm7e30r61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 10:29:53 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Jul 2019 10:29:51 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Jul 2019 10:29:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x56FKSBgXOLvZMD+y3raguvfgHanfiop/tmf7yxKJYY=;
 b=J72ID1e6yEPH/JQFvABF23eQcysYppP2uH5TKtl3nY3p/kNHZbyJ1ycd43oO93NckS3ZJNg1wu22xcpawtqMjlm2m+bS2jLv2Q+/k08LNz/ZukYuOO0FYMV/uiRygmzMJFLGYx6tOjwVzmeFOBlgwPfaPVSlEXyYU+tf7qXWcds=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3737.namprd15.prod.outlook.com (10.141.167.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 17:29:49 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 17:29:49 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Peng Wang <rocking@whu.edu.cn>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: minor tweak for logic to get cgroup css
Thread-Topic: [PATCH] cgroup: minor tweak for logic to get cgroup css
Thread-Index: AQHVMUV9d2o/bgH9tUqXCEtcJHSYqabA9ciAgAANIwA=
Date:   Mon, 8 Jul 2019 17:29:49 +0000
Message-ID: <20190708172944.GA24662@tower.DHCP.thefacebook.com>
References: <20190703020749.22988-1-rocking@whu.edu.cn>
 <20190708164243.GE657710@devbig004.ftw2.facebook.com>
In-Reply-To: <20190708164243.GE657710@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:301:5f::34) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3b5d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078aa51e-15cb-4730-33f4-08d703c9e0b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB3737;
x-ms-traffictypediagnostic: DM6PR15MB3737:
x-microsoft-antispam-prvs: <DM6PR15MB373708AC5F833844278F97B1BEF60@DM6PR15MB3737.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(81166006)(81156014)(54906003)(446003)(316002)(186003)(6246003)(476003)(76176011)(102836004)(4744005)(11346002)(99286004)(86362001)(68736007)(7736002)(53936002)(386003)(8936002)(305945005)(6116002)(6916009)(486006)(14454004)(46003)(8676002)(6506007)(256004)(73956011)(1076003)(4326008)(25786009)(6512007)(9686003)(71200400001)(64756008)(71190400001)(478600001)(66556008)(66446008)(66946007)(66476007)(5660300002)(2906002)(229853002)(6486002)(52116002)(33656002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3737;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZFZ7BDII4Bjyb4y5Tb8y/rFR7nl3tRchRCsKiuvfq2dtigaD/nsOtN9JjVvTkUmF0/opgNC7bTRUqV1WKdDJC1HLPdsm7v1TOrpA0jL3Y3JPK1XBr8zQxDF/O0kzN7w/laowc5V4+jCZbc01c23TlnBi/DuJcxBzyQm8VQ+o2uCiXt7D+RpTFDlhaxrn3zdrZqRaQjMNrcoSJyySMwT+SEBVJcCyUUU4DyJfl4tNpL6bW80Lj3sGlPLnBXUJHyn9bT5kNTZq5rUCk3No84prrOtJ/u0uzMQ2Bk2+1qFambPJC5StHvJfDs/rrtSa5uTJPI7X/2qTGkIo1zwgIYqzMGrJE7T0KlTMUk55cPccIUZKHf8YLPcdBDHYJBluni0UEh5jk30p0dgCicBeTlZZqHeIKL7q8hJ56QlCJB3EC7M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CF7146E8EDAE740858C66A1B5C99F4E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 078aa51e-15cb-4730-33f4-08d703c9e0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 17:29:49.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3737
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=793 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080215
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 08, 2019 at 09:42:43AM -0700, Tejun Heo wrote:
> On Wed, Jul 03, 2019 at 10:07:49AM +0800, Peng Wang wrote:
> > We could only handle the case that css exists
> > and css_try_get_online() fails.
>=20
> As css_tryget_online() can't handle NULL input, this is a bug fix.
> Can you please clarify that in the description?

-       if (!css || !css_tryget_online(css))
+       if (css && !css_tryget_online(css))

If css =3D=3D NULL, !css is true, and the second part of the || statement
will not be evaluated. So it's not a bug fix.

Thanks!
