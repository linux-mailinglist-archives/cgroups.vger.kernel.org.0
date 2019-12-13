Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1DD11EBF4
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2019 21:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMUks (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Dec 2019 15:40:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46426 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLMUks (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Dec 2019 15:40:48 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDKeSkf014539;
        Fri, 13 Dec 2019 12:40:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xmhSo78XG/Xh/3Beki0lQpTIQHBa0peK1JipYU3Zz9o=;
 b=ecWral3DjDCBZbn9g66ixPrC3ajoxhAv4kOacNlPnzng346HpehKv9B7y2sYE3kA8g2q
 wnUY5gAZcsiKGWNet0QZA/0NMI2m6MyxJXwrd4UwfkhsFZr7uUvQ1P/+5DRyDnLG2+cQ
 a4PsVgu6fsbLV1T9/H/KJ5j4xF60RZgv6xI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wv2mekrmc-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 12:40:37 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 13 Dec 2019 12:40:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Dec 2019 12:40:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK8xT4tujbyrEYcZ4v+1a2Cw9vJl8NeWTzYeGQNN5CaoIO8HGkxQmRa+fHnv2ntRyfT1cCN+GlRnnYJiHq5SQc9hAyHOsNBSjDPxXHgyhCDBbR1Gq8TuX2Rb9H3kJgQZT/It7iKNIBTipAcvl/AK1i3+sRgDoD6PNFff9jTX/0yUOm59ZVxXIpbS1vnfcTVEQ3iQLxoypa4FAoHxwNYIiOzFFTIzFDS8aw0wDNkBTEl3MhOk+Q8yClyXk4wnaLRPUySNzXruS3sMPxjHnq9RCh3yWi+/rFp5LTkARqaINbBcpaclhNU9gEseWpYpOFj/SRJ8cq/rE0/Uuki18DOg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmhSo78XG/Xh/3Beki0lQpTIQHBa0peK1JipYU3Zz9o=;
 b=R98HGWeP9mQGU5fQSf5WjVgG/udANl6dFxovN/c5Uv0mC13a/QCQpBQYxkc6VCgj8fzCBPQr+8BV7w7szESGJx+fMqmwx/CdfvJlxujd4HmGC2MSoQ+iYopvhpH7BuzDvbmWvgOj356qNG+by5dBiRjHT5k5sYaoNzx+EUCz6yFEFIpaKwQJDxqprn6ARPK5NTQmB64vB2SB+hHbTcC99B+ZSFejrFTG2WLK2oLptFxDpN4uj5TN8e+Qa5JMrkuhYZBT7GFRlSr2Lz6SEwAbsYQz5bGStXR1gjZYGsEbHqQySbGThUJ0WkfDrSXuN1bFwT8YtgCiKnTq3uNwDrcekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmhSo78XG/Xh/3Beki0lQpTIQHBa0peK1JipYU3Zz9o=;
 b=ECWM3DJ2pEfZxWLuhSE09uOp8iQQu+FAHM7v9GD2PgSJ3OC/JfqwKyPKFiphVEcSFSPTIDUs5yk/xpeECMb+iDeJc8J3YhqH+kiRQYCATy9gI7YvODkwkTmvFfXOw9Y5P3VHcBSOk2ed1Bap5UomDQpXjpqsLhoFybLEJCj7kYM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3432.namprd15.prod.outlook.com (20.179.59.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 13 Dec 2019 20:40:31 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 20:40:31 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] mm: memcontrol: fix memory.low proportional
 distribution
Thread-Topic: [PATCH 1/3] mm: memcontrol: fix memory.low proportional
 distribution
Thread-Index: AQHVserY3s483dI4qU6ldrdPHHXyO6e4h0MA
Date:   Fri, 13 Dec 2019 20:40:31 +0000
Message-ID: <20191213204026.GA6830@localhost.localdomain>
References: <20191213192158.188939-1-hannes@cmpxchg.org>
 <20191213192158.188939-2-hannes@cmpxchg.org>
In-Reply-To: <20191213192158.188939-2-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:300:12a::32) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::c4c4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93310a76-f699-484c-5fdb-08d7800cb1e3
x-ms-traffictypediagnostic: BYAPR15MB3432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB34324D3A52C1F2FD922415DBBE540@BYAPR15MB3432.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(54906003)(6486002)(6512007)(9686003)(81156014)(8676002)(316002)(8936002)(6916009)(81166006)(186003)(33656002)(66446008)(6506007)(52116002)(1076003)(86362001)(66556008)(71200400001)(2906002)(478600001)(64756008)(66946007)(66476007)(4326008)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3432;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gspUfuUvtfPJTiKxraToS6PMGMsNvoBjECHpi1vKQUW1u9MpPh4LM+i8U1zoSO88o2bHiMZ1mU6ze/NPQN5Z5VOtuiM2sasy8W8a7oA30hxT3+p6CC2KNoHo6S40qmOz2R8PZ5pCg8zZtpDVv0WG5bEw7YsGFeHqF5KrztEcyQN8pFBncV4xVdxIN+ZFguVTjc52FgIbpggUJPeYEO8O1qQKNXURtDTh457oPx/WWEgyxfZf9D4GMA0IwqXGgkUW2PALpXWvgJlYy+e3GXc3A0eRyJTqeq2cHXF88fyKoXDgrkaLl7Tl/IdHVuvBF8PSJf/e5O8EvIvyocjoMwY2gNgPfA2KwicWpxG+m0NCU+BHOoWW3XEeBIw46LbuyW0aehKRDz25fx1A2EWAs2ftUp9aOjeklc5se4a1DGOUaoMoq6DBVGV7vNZAn9Qcorts
Content-Type: text/plain; charset="us-ascii"
Content-ID: <026E6C99126A814AA2697837C6CF363B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 93310a76-f699-484c-5fdb-08d7800cb1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 20:40:31.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIdTawk70wwfgE5hX0NY2nvhbp3PVW+fJAMsJLsgrUCn5HSCRd9JyyZR+frSvqi4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3432
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_07:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130152
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 13, 2019 at 02:21:56PM -0500, Johannes Weiner wrote:
> When memory.low is overcommitted - i.e. the children claim more
> protection than their shared ancestor grants them - the allowance is
> distributed in proportion to each siblings's utilized protection:
>=20
> 	low_usage =3D min(low, usage)
> 	elow =3D parent_elow * (low_usage / siblings_low_usage)
>=20
> However, siblings_low_usage is not the sum of all low_usages. It sums
> up the usages of *only those cgroups that are within their memory.low*
> That means that low_usage can be *bigger* than siblings_low_usage, and
> consequently the total protection afforded to the children can be
> bigger than what the ancestor grants the subtree.
>=20
> Consider three groups where two are in excess of their protection:
>=20
>   A/memory.low =3D 10G
>   A/A1/memory.low =3D 10G, A/memory.current =3D 20G
>   A/A2/memory.low =3D 10G, B/memory.current =3D 20G
>   A/A3/memory.low =3D 10G, C/memory.current =3D  8G
>=20
>   siblings_low_usage =3D 8G (only A3 contributes)
>   A1/elow =3D parent_elow(10G) * low_usage(20G) / siblings_low_usage(8G) =
=3D 25G
>=20
> The 25G are then capped to A1's own memory.low setting, i.e. 10G. The
> same is true for A2. And A3 would also receive 10G. The combined
> protection of A1, A2 and A3 is 30G, when A limits the tree to 10G.
>=20
> What does this mean in practice? A1 and A2 would still be in excess of
> their 10G allowance and would be reclaimed, whereas A3 would not. As
> they eventually drop below their protection setting, they would be
> counted in siblings_low_usage again and the error would right itself.
>=20
> When reclaim is applied in a binary fashion - cgroup is reclaimed when
> it's above its protection, otherwise it's skipped - this could work
> actually work out just fine - although it's not quite clear to me why
> we'd introduce this error in the first place.

This complication is not simple an error, it protects cgroups under
their low limits if there is unprotected memory.

So, here is an example:

      A      A/memory.low =3D 2G, A/memory.current =3D 4G
     / \
    B   C    B/memory.low =3D 3G  B/memory.current =3D 2G
             C/memory.low =3D 1G  C/memory.current =3D 2G

as now:

B/elow =3D 2G * 2G / 2G =3D 2G =3D=3D B/memory.current
C/elow =3D 2G * 1G / 2G =3D 1G < C/memory.current

with this fix:

B/elow =3D 2G * 2G / 3G =3D 4/3 G < B/memory.current
C/elow =3D 2G * 1G / 3G =3D 2/3 G < C/memory.current

So in other words, currently B won't be scanned at all, because
there is 1G of unprotected memory in C. With your patch both B and C
will be scanned.

> However, since
> 1bc63fb1272b ("mm, memcg: make scan aggression always exclude
> protection"), reclaim pressure is scaled to how much a cgroup is above
> its protection. As a result this calculation error unduly skews
> pressure away from A1 and A2 toward the rest of the system.

It could be that with 1bc63fb1272b the target memory distribution
will be fine. However the patch will change the memory pressure in B and C
(in the example above). Maybe it's ok, but at least it should be discussed
and documented.

>=20
> Fix this by by making siblings_low_usage the sum of all protected
> memory among siblings, including those that are in excess of their
> protection.

So I'm afraid the fix need to be more complex. I need to think a bit more a=
bout
it.

Thanks!
