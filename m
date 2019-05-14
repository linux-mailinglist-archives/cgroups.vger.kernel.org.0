Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF11D04C
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfENUG7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 16:06:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41540 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfENUG7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 16:06:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EJwJGb001902;
        Tue, 14 May 2019 13:05:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nAvEob6Kh3imkf/jkDHpX8X0Pv+7hR1jBzS4jh+zXhg=;
 b=AI5EJ0PjpAn0WpxTLN4yXat5kceFTVPe7QaKQSJeQLv8uUNNdNQZIJqVr6UZaWzI9dFm
 VxH/gcc6bONw8F2UGlH0D/sRTGu/aASdOcAcl/X/FnztKflroV2fvLst8udTFyLPoGLr
 LX79H+IScBBo8JyPglVk7qDPiQHfUrtNNSc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sfy23sdrj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 May 2019 13:05:59 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 May 2019 13:05:59 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 May 2019 13:05:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAvEob6Kh3imkf/jkDHpX8X0Pv+7hR1jBzS4jh+zXhg=;
 b=OFGnSFKLrl+vrJLTNfKuPeI79meaMHFTGvGreLRTu9AxVUvwFoqcqodm+DOU+YBLVviolmiKV1bCPNjqULA8HQtTR+uBKREv92/oRH4UlEL7E+SaDYUNumUA3u/mxw4fzyRnYHQ3QvzYID56b93g0K+Digjr33OcU6ryT3vIFCQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2791.namprd15.prod.outlook.com (20.179.158.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Tue, 14 May 2019 20:05:57 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 20:05:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Matteo Croce <mcroce@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: WARNING: CPU: 1 PID: 228 at kernel/cgroup/cgroup.c:5929
Thread-Topic: WARNING: CPU: 1 PID: 228 at kernel/cgroup/cgroup.c:5929
Thread-Index: AQHVCoqk1mZJtzvIAk+xNbeMmTPUdKZqj/2AgAB4sACAAAMbgA==
Date:   Tue, 14 May 2019 20:05:57 +0000
Message-ID: <20190514200553.GF12629@tower.DHCP.thefacebook.com>
References: <CAGnkfhwMSNm4uSkcGtqaGmYanfNK9rx6m2a3TqJh08YitbGAUg@mail.gmail.com>
 <20190514194249.GD12629@tower.DHCP.thefacebook.com>
 <CAGnkfhxwP1SwJLv2E-6Xd7ZXN8XUPRyXkM=tB0Z=jre8Rij6=A@mail.gmail.com>
In-Reply-To: <CAGnkfhxwP1SwJLv2E-6Xd7ZXN8XUPRyXkM=tB0Z=jre8Rij6=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::298]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc7612bc-db73-4f36-5152-08d6d8a793b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2791;
x-ms-traffictypediagnostic: BYAPR15MB2791:
x-microsoft-antispam-prvs: <BYAPR15MB2791F392A573A8431C33BA24BE080@BYAPR15MB2791.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(6486002)(486006)(54906003)(11346002)(446003)(7736002)(476003)(186003)(66946007)(33656002)(6916009)(2906002)(99286004)(9686003)(6512007)(46003)(6436002)(68736007)(316002)(73956011)(66476007)(66556008)(64756008)(66446008)(53936002)(229853002)(4326008)(81156014)(558084003)(14454004)(5660300002)(71190400001)(81166006)(305945005)(8676002)(478600001)(86362001)(76176011)(8936002)(25786009)(52116002)(1076003)(6116002)(386003)(14444005)(256004)(6506007)(71200400001)(102836004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2791;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ALoi8StZIjTHD5UY2dqCAyxYAkQSd6Qw7sdj6zDyxUfulTocho/+Aj2Swre35tyIgdVVWr6j7BABgETHS32Y6aPHdv66CWFEa5cpKAJf2U1M8xJYVf1dKSTZwE1OJFgzamrlWmVGLepztEQmbv/WLTGrLAFYett9jRvSiGiKpiPrJg6YF6FiQq0/+LjxPBA4IdHvkzbgqFJm4EVn6meQzKObOfG9qgJxVLke9pBEo/xD/wRPw3u6IGK+oN1oHeYzByjxLNTZy1ofXk0v81QSBlxSl1i2femz9HCwOGmQf6Aqrl/D2t7p0bX1raN1m9zAkec/GnL3GfuAGiEdk4kbwmMJ+O5929a9t+ufwDYUrB7VxzvkugE55VsOcdzbAfGDPRc8Q7sANkGJ8qsdlkoFe9uqMe9L2Hm0v9mzG+Ij1DQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84E68961D69B6B4FB14640807D9BDB97@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7612bc-db73-4f36-5152-08d6d8a793b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 20:05:57.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2791
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140134
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 14, 2019 at 09:54:46PM +0200, Matteo Croce wrote:
> Hi Roman,
>=20
> yes, this one fixes it.
>=20
> --=20
> Matteo Croce
> per aspera ad upstream

Thank you for the confirmation!

The patch will be merged upstream soon.

Thanks!
