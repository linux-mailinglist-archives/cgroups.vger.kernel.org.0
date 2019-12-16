Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE21219B7
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfLPTMJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 14:12:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbfLPTMJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 14:12:09 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGJBntG028451;
        Mon, 16 Dec 2019 11:11:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DoO0l2psZNOhC8HxuixcokzTJJOPI9PvHeEkLcoSny0=;
 b=oLbpTEHFDy3rPtVaB8bd/l8p/Ewj+8vSrbjs7kHz0BTfiBos2/Xkmo6eIHpeh6v5PZ9L
 CryZT4Si7bgf9iurVaEJFW4ThZqHFBs5L1fon7QdMz8WewxHppyzRIuMiqRdHTWbabnR
 pXK3092f1wxOiCY5tIqKv0sRjCLOWMirQI0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wwgsmnmwc-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Dec 2019 11:11:59 -0800
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Dec 2019 11:11:38 -0800
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Dec 2019 11:11:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Dec 2019 11:11:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGlq8YKfLVRrE85SfT0rbpxwJps7vhIOLGGYGC0yeuLlZw1z2SXOwtGE2Psv46vIj0FDdxF43TbEi21YIaGWv5AwduNgIjXdHfKjfXZDaxVr/jjKh044Cw5KVSvUsKCRTIs7yx3lydYdc7Hmgugk5QgZjDVOvGT8uiuXzFe4TBJsBrbDLp8M+2CEqvHu7WWqqCbVEK3B/3MGIqPUT4voZ0vVZQ+oGdAcSy6LY/dRPUewSCM+xzdf/9kzz7EBSeiTptTZJXfoZ8GWHSgFN4+7mlGujnCuG25Cbh0E6WjUlcjm0G+IQpcrmZhhpglkXcz6Ws/9uBW2crhWHSei8v3VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoO0l2psZNOhC8HxuixcokzTJJOPI9PvHeEkLcoSny0=;
 b=MGzWLA/z4QlS0BsHRPRyuUAn9g5HogGrcq5JeahVbwwDACwCtQ+PP8cs2hgw8ATjZES+goCRRbIWEcTIZOceg7y5GzA0jPiKyD0RziqCRELkavEuPYiwveyL8wv20dRmqCoiFC8nqeFR7EoP8d7wwan3XzQoz2p3lw7NYe8SZT68SjiqcZnmHd0LDQapF23qIgchv6LZpnM8AzLzCZr65NdXtslyq8UeJtdaHymjtt2z4NS0B6YOnW8eyTXa1SzbT20/vZ4msT8fvD1T4yaEfiWxi5h+B8WKXpZW4YFL9hnaYJGb8SuaClz/xvo371EbYUDG/fxhXB1ynTh+mfuFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoO0l2psZNOhC8HxuixcokzTJJOPI9PvHeEkLcoSny0=;
 b=HuysLj5lx6wk4Oocgt957LX8/cV0rnDcvkqYndPaZniVSxMHyz25VJ3pM81Tkz7+u/zxwf1Sa1IPM7iIHNcHk4mphhdz6B/WPpYNIYE+4gPqvYz6hxHPQc8wfmVeUeGwjrTlVf+2K2/7U7ZSYb6Bykido6u3KKm6LmSFi2fAvW8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2535.namprd15.prod.outlook.com (20.179.155.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Mon, 16 Dec 2019 19:11:36 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 19:11:36 +0000
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
Thread-Index: AQHVserY3s483dI4qU6ldrdPHHXyO6e4h0MAgASRPQCAAAzqgA==
Date:   Mon, 16 Dec 2019 19:11:35 +0000
Message-ID: <20191216191131.GB3760@localhost.localdomain>
References: <20191213192158.188939-1-hannes@cmpxchg.org>
 <20191213192158.188939-2-hannes@cmpxchg.org>
 <20191213204026.GA6830@localhost.localdomain>
 <20191216182518.GA209920@cmpxchg.org>
In-Reply-To: <20191216182518.GA209920@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:104:3::23) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::a4ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b644bce-bedc-4acc-1155-08d7825bc505
x-ms-traffictypediagnostic: BYAPR15MB2535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB253589EC462368C707448880BE510@BYAPR15MB2535.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(54534003)(33656002)(52116002)(5660300002)(6486002)(86362001)(186003)(66946007)(66556008)(64756008)(66446008)(66476007)(6512007)(9686003)(54906003)(71200400001)(81156014)(4326008)(6506007)(6916009)(316002)(2906002)(1076003)(81166006)(478600001)(8936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2535;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObTgvm046fLU79K3er7gY1xG+22H+x3Lqv/k07KFW4HNjHcp0O8hoKCfaX+mse7NCTazH+OLgtsBONfNAn+6OtO8QibmtWZYv8OTBiT1jHdaSQf4tOjOZ1jTvUCk6ZUPmIPW5SKBzY0BVHuNDgoZMxb8+P1hqL5K8z7Qpecp8p+krXlfQZmYNxhxRZm/jU1ZZtFMfpmWD7UYDIE+zgftNEai6nkxBtjEDdLMqg+2jRfPKuYpjWHSs9T2WCQsU/9e5FbDXxinuF79CKCJjBTQUshrRTAyMj/FBnReegTifBkB6WOCXuJUUJQN+IDL9oqNAclj327tgA/RCM8ID7wY6z38gAAAMOyIEgQS4bVGH6MDz0iGDluYq2lQcywUvK0838EtV4yCLfeevDzyicjkIaE2maxpb0I0HHAsaNggBOOTF5FbkeeHioOqLUbiTQ9aDG0e3OoeOVxTDZqErpmQlayJqvkat/MeHS2Gi3RkB7B9HchNgFfNdvrbTRS+vTwJ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <080A4AC9D9F95A44A81CD56E29FE6C02@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b644bce-bedc-4acc-1155-08d7825bc505
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 19:11:36.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p04kvzpiK2UMzhh8enpX2DkJW3N1+dnnXL8GF84SJ1Gog0+9PN2/PyNQCEQcHwGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2535
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_07:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160162
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 16, 2019 at 01:25:18PM -0500, Johannes Weiner wrote:
> On Fri, Dec 13, 2019 at 08:40:31PM +0000, Roman Gushchin wrote:
> > On Fri, Dec 13, 2019 at 02:21:56PM -0500, Johannes Weiner wrote:
> > > When memory.low is overcommitted - i.e. the children claim more
> > > protection than their shared ancestor grants them - the allowance is
> > > distributed in proportion to each siblings's utilized protection:
> > >=20
> > > 	low_usage =3D min(low, usage)
> > > 	elow =3D parent_elow * (low_usage / siblings_low_usage)
> > >=20
> > > However, siblings_low_usage is not the sum of all low_usages. It sums
> > > up the usages of *only those cgroups that are within their memory.low=
*
> > > That means that low_usage can be *bigger* than siblings_low_usage, an=
d
> > > consequently the total protection afforded to the children can be
> > > bigger than what the ancestor grants the subtree.
> > >=20
> > > Consider three groups where two are in excess of their protection:
> > >=20
> > >   A/memory.low =3D 10G
> > >   A/A1/memory.low =3D 10G, A/memory.current =3D 20G
> > >   A/A2/memory.low =3D 10G, B/memory.current =3D 20G
> > >   A/A3/memory.low =3D 10G, C/memory.current =3D  8G
> > >=20
> > >   siblings_low_usage =3D 8G (only A3 contributes)
> > >   A1/elow =3D parent_elow(10G) * low_usage(20G) / siblings_low_usage(=
8G) =3D 25G
> > >=20
> > > The 25G are then capped to A1's own memory.low setting, i.e. 10G. The
> > > same is true for A2. And A3 would also receive 10G. The combined
> > > protection of A1, A2 and A3 is 30G, when A limits the tree to 10G.
> > >=20
> > > What does this mean in practice? A1 and A2 would still be in excess o=
f
> > > their 10G allowance and would be reclaimed, whereas A3 would not. As
> > > they eventually drop below their protection setting, they would be
> > > counted in siblings_low_usage again and the error would right itself.
> > >=20
> > > When reclaim is applied in a binary fashion - cgroup is reclaimed whe=
n
> > > it's above its protection, otherwise it's skipped - this could work
> > > actually work out just fine - although it's not quite clear to me why
> > > we'd introduce this error in the first place.
> >=20
> > This complication is not simple an error, it protects cgroups under
> > their low limits if there is unprotected memory.
> >=20
> > So, here is an example:
> >=20
> >       A      A/memory.low =3D 2G, A/memory.current =3D 4G
> >      / \
> >     B   C    B/memory.low =3D 3G  B/memory.current =3D 2G
> >              C/memory.low =3D 1G  C/memory.current =3D 2G
> >=20
> > as now:
> >=20
> > B/elow =3D 2G * 2G / 2G =3D 2G =3D=3D B/memory.current
> > C/elow =3D 2G * 1G / 2G =3D 1G < C/memory.current
> >=20
> > with this fix:
> >=20
> > B/elow =3D 2G * 2G / 3G =3D 4/3 G < B/memory.current
> > C/elow =3D 2G * 1G / 3G =3D 2/3 G < C/memory.current
> >=20
> > So in other words, currently B won't be scanned at all, because
> > there is 1G of unprotected memory in C. With your patch both B and C
> > will be scanned.
>=20
> Looking at the B and C numbers alone: C is bigger than what it claims
> for protection and B is smaller than what it claims for protection.
>=20
> However, A doesn't provide 4G to its children. It provides 2G to be
> distributed between the two. So how can B claim 3G and be exempted
> from reclaim?

First, what if the memory pressure comes from memory.high/max set on A?

Second, it's up to semantics we define. Looking at it from the other side:
there is clearly 1G of memory in C which is not protected no matter what.
B wants it's memory to be fully protected, but it's limited by the competit=
ion
on the parent level. Now we try to satisfy B's requirements until we can.
Should we treat B and C equally from scratch?

I think both approaches is acceptable, but if we're switching from one opti=
on
to another, let's make it clear.

>=20
> But more importantly, it isn't in either case! The end result is the
> same in both implementations. Because as soon as C is reclaimed down
> to below 1G, A is still in excess of its memory.low (because it's
> overcommitted!), and they both will be reclaimed proportionally.

I do not disagree: the introduction of the proportional reclaim
made this complication (partially?) obsolete. But originally it was
required to make target distribution correct.

>=20
> From the example in the current code:
>=20
>  * For example, if there are memcgs A, A/B, A/C, A/D and A/E:
>  *
>  *     A      A/memory.low =3D 2G, A/memory.current =3D 6G
>  *    //\\
>  *   BC  DE   B/memory.low =3D 3G  B/memory.current =3D 2G
>  *            C/memory.low =3D 1G  C/memory.current =3D 2G
>  *            D/memory.low =3D 0   D/memory.current =3D 2G
>  *            E/memory.low =3D 10G E/memory.current =3D 0
>  *
>  * and the memory pressure is applied, the following memory distribution
>  * is expected (approximately):
>  *
>  *     A/memory.current =3D 2G
>  *
>  *     B/memory.current =3D 1.3G
>  *     C/memory.current =3D 0.6G
>  *     D/memory.current =3D 0
>  *     E/memory.current =3D 0
>=20
> Even though B starts out within whatever it claims to be its
> protection, A is overcommitted and so B and C converge on their
> proportional share of the parent's allowance.
>=20
> So to go back to the example chosen above:
>=20
> >       A      A/memory.low =3D 2G, A/memory.current =3D 4G
> >      / \
> >     B   C    B/memory.low =3D 3G  B/memory.current =3D 2G
> >              C/memory.low =3D 1G  C/memory.current =3D 2G
>=20
> With either implementation we'd expect the distribution to be about
> 1.5G and 0.5G for B and C, respectively.
>=20
> And they'd have to be, too. Otherwise the semantics would be
> completely unpredictable to anyone trying to configure this.
>=20
> So I think mixing proportional distribution with absolute thresholds
> like this makes the implementation unnecessarily hard to reason
> about. It's also clearly buggy as pointed out in the changelog.
>=20
> > > However, since
> > > 1bc63fb1272b ("mm, memcg: make scan aggression always exclude
> > > protection"), reclaim pressure is scaled to how much a cgroup is abov=
e
> > > its protection. As a result this calculation error unduly skews
> > > pressure away from A1 and A2 toward the rest of the system.
> >=20
> > It could be that with 1bc63fb1272b the target memory distribution
> > will be fine. However the patch will change the memory pressure in B an=
d C
> > (in the example above). Maybe it's ok, but at least it should be discus=
sed
> > and documented.
>=20
> I'll try to improve the changelog based on this, thanks for filling in
> the original motivation. But I do think it's a change we want to make.

Absolutely, I'm not against the change. I just want to make sure we will
put all details into the changelog.

Thanks!
