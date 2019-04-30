Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362F3F97B
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2019 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfD3NEZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Apr 2019 09:04:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbfD3NEZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Apr 2019 09:04:25 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UCtTlT029651;
        Tue, 30 Apr 2019 06:03:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Y8+R+HZqyGDXdpneI62k0sLr+qseUs5YSq+oA2oBzhA=;
 b=dzRpn4oBEZyZHMjuKaKZbuYaYKbKg56vF5mEgIlyUY4bDVsuCoZtJhvLnmwQZOFGi7Db
 L6SsEbwJdu7fMkVoZIMy3JhEP1zGQN4c0aSNfJQChVBHRWO9oxLXKpU49PQbb1yYC/pw
 dU4mLcpsWEdDbVIF1ZBo2MYl2LDKpgwGf1M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s6dtwsehy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Apr 2019 06:03:29 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 30 Apr 2019 06:03:28 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 30 Apr 2019 06:03:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8+R+HZqyGDXdpneI62k0sLr+qseUs5YSq+oA2oBzhA=;
 b=B8gv3natlQvBZvOyz6HJj6NxqdJ2nMPR4+SSZifKlGA8hYNkRCIivTci/nHUWLUNA+apOzXXvkxVmYhklkMA3sNY0NMFRdvCcsDXZJdje6HNvwmXm+FEnp5Tl4DU1dEkp+udbICv3JQOB/7AEy8TKXqgyxy76rX+MOWHk0/9O+o=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2421.namprd15.prod.outlook.com (52.135.198.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 13:03:26 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1835.010; Tue, 30 Apr 2019
 13:03:26 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] cgroup: Remove unused cgrp variable
Thread-Topic: [PATCH -next] cgroup: Remove unused cgrp variable
Thread-Index: AQHU/ztY6K6bxp4Ah06bYKBqj+CtdaZULz4AgAB8dYA=
Date:   Tue, 30 Apr 2019 13:03:26 +0000
Message-ID: <20190430130313.GA5221@castle.dhcp.thefacebook.com>
References: <1556618249-56304-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190430123749.GA6300@castle.DHCP.thefacebook.com>
In-Reply-To: <20190430123749.GA6300@castle.DHCP.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:208:134::28) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::45d3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceaca93e-3978-487d-ef7e-08d6cd6c3b7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2421;
x-ms-traffictypediagnostic: BYAPR15MB2421:
x-microsoft-antispam-prvs: <BYAPR15MB2421B638AB20276C7B949DEDBE3A0@BYAPR15MB2421.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(6506007)(46003)(446003)(229853002)(102836004)(6486002)(71190400001)(71200400001)(6436002)(2906002)(256004)(14444005)(486006)(33656002)(4744005)(8676002)(476003)(99286004)(53936002)(25786009)(97736004)(76176011)(6246003)(68736007)(186003)(66556008)(66446008)(66476007)(64756008)(73956011)(6512007)(66946007)(8936002)(81166006)(6116002)(4326008)(54906003)(5660300002)(9686003)(11346002)(52116002)(6916009)(1076003)(7736002)(305945005)(86362001)(14454004)(81156014)(478600001)(386003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2421;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gFy9bLOrs1YocLqoywqEC+3KFBdDJ3bC8M4F0tEuA+L1KTf3636aC+ag2FzSo11EQYqmzEPGGRheLEVoDqbudmrDVPHDZ5cKijJcxIodJqovEXe4Z8FuPTFbrf1PGLCX1MCeVicryaHQTDTNLtbGKHQawRsFFo/Fo1QP/9DhuYCC6+UBdG4dEDPRC2mzTea0v57Bd2JPeA6DpgzO/nLzEAwpdoyJiWRITgz60PVHVEQgI4XJK9OwY4ja7l+wV93YKJ1VEoXXo0cJMeF7Eo7uZGcjmd/ONUXNdm8w9YWmKjoO1THSfP822ANNwwJt4ciFvACB8H9lOD/GvZRABvNJ4TYIe3QEJn5uLelxTDjKViOCxxjRhL1aVgzOl+Qj4QWOua51jNae4eaoDqFa+l5NRmh3AZ7bLoZMHvsb6TEEMq8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <661F0704A9A9CF4AA2BFC5397D2F5F56@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaca93e-3978-487d-ef7e-08d6cd6c3b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 13:03:26.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300084
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 30, 2019 at 12:37:58PM +0000, Roman Gushchin wrote:
> On Tue, Apr 30, 2019 at 05:57:29PM +0800, Shaokun Zhang wrote:
> > The 'cgrp' is set but not used in commit <76f969e8948d8>
> > ("cgroup: cgroup v2 freezer").
> > Remove it to avoid [-Wunused-but-set-variable] warning.
> >=20
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>=20
> Hi Shaokun!
>=20
> There is a cgroup_update_frozen(cgrp) call just below,
> so the variable is in use.

Ah, I'm sorry, I did look at the old version. The call I mention
has been removed in the latest one, so you're right, the variable
isn't used anymore.

Acked-by: Roman Gushchin <guro@fb.com>

Thank you!
