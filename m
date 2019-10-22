Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BDFE0E5B
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 00:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfJVWrF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 18:47:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40982 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731185AbfJVWrF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 18:47:05 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MMhL0W024864;
        Tue, 22 Oct 2019 15:47:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WbsnqqUSzdFKRHlzwTEhlV4yqA2I4HU8EJNeRCKLVGU=;
 b=FNd7529pP+8Vc55F/Q9t/i876mWGMjannldvKhoVy5c+gRwDnHRemZerooy91prT3/d8
 AoYn98kCsuoRkoixPldSYEmE80SZu63wKeMLZ3b+BZiKEBWeZ/zRTnXocy8Lj76vwFd/
 Zfcdd7HyUaz0vN2dJKA91sKyFzVEb7QWFjE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vt9tc890k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Oct 2019 15:46:59 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 15:46:59 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 15:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MndvvgPpya+G95EW3Bc8gvXS1b8JlwrPcXyORhQ54VbM7fnWySDpvJ228uw0+E9W1epzgcwIKXcnHWugV2+zu9CrqnN2M0FfqKLJ+AV8M8t6oGVYmweLgnSuqTXBwDeWzOQs115yJG+aoXyQVIUp9uhB3QutKtWHOKtyQKGvBncupUs9FM6de8Y7UinYuLveuiG+Kfc3gV1x8PrKCfMtwveJwC4AEecuOWu3a7gkiwqBn9biyGE2Dl1l0Xu/GSYUgJGTiEIldpXm8Bi0qFL7hZT7r8xBq1QoKvoty395rqRZLtvjBVQgHJiwKiTVxJZZARG0/jsG6UndVvbJ2hWGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbsnqqUSzdFKRHlzwTEhlV4yqA2I4HU8EJNeRCKLVGU=;
 b=EVhOtp7G1/vbdeHkelJCBjWz30PT65aPe+PFQOyGODHWzqB3GujsnfVTsvOC+XHznPWL9iBDLO1EzjIxdVUp2Wx8XmznCGq5ssErQPdXy8eNgqIw5T5xI4oTB7Gkoanlsmxaij7ckLomMkx4ErghHuw4tAp6N14uDTeLhsFlPRgxABXVq9B3jw42013SJ70zX75LAuhud3FUnUyUI1hyIP646ieab+hFcXtkNYXZoQZFgHfaVrEpMi9PwgnKbxTNXecJNHDN6qZDfmZN6ks+fWSNdNzWrOIcR5S3vCBcO6pD9Zh/Iipw/UxX0THMUX2Bxo3ZlJ9z0dmpMUx3bNaWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbsnqqUSzdFKRHlzwTEhlV4yqA2I4HU8EJNeRCKLVGU=;
 b=f8Th9P1EuAhNG9oni7Tkov9s0ECYlNmlHDL4GFIivrcAUJcrxSo0RYHeMpDmJv6i6sFMBe0f7QVOdjCbVUMXcQAAH+oFHziBKv303otj5im4zpl0iMOq4sZOSkR+Fd66mbYFcrgqk8/llk9Sy1WgO4XZJeSDn++rhe84L7eIM0o=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2818.namprd15.prod.outlook.com (20.179.138.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 22:46:58 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 22:46:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Thread-Topic: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Thread-Index: AQHViOfIg7Ukgv6lUkWvXEXYWe2LvqdmnnOAgACTCYCAABHlAA==
Date:   Tue, 22 Oct 2019 22:46:57 +0000
Message-ID: <20191022224652.GA22777@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-6-hannes@cmpxchg.org>
 <20191022195629.GA24142@tower.DHCP.thefacebook.com>
 <20191022214249.GB361040@cmpxchg.org>
In-Reply-To: <20191022214249.GB361040@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:300:4b::15) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37200b8e-1fce-4a33-001b-08d75741be67
x-ms-traffictypediagnostic: BN8PR15MB2818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB28180C300AF186255CD768C0BE680@BN8PR15MB2818.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(366004)(346002)(51914003)(189003)(199004)(478600001)(305945005)(6436002)(316002)(7736002)(4326008)(54906003)(6486002)(102836004)(6246003)(76176011)(52116002)(6916009)(229853002)(386003)(6506007)(14454004)(81166006)(11346002)(71190400001)(186003)(8676002)(446003)(256004)(71200400001)(81156014)(25786009)(486006)(476003)(86362001)(8936002)(5660300002)(99286004)(64756008)(6512007)(46003)(9686003)(66446008)(2906002)(66476007)(66556008)(6116002)(33656002)(1076003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2818;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JY7ygeHwFjT9wJKR/Tecc6XlIXzRcD07Bgv5c8fXPh4Ed4VibMKXhyxNOi+Pzr031kjV2ZtIZRYLqR/Hd8GoENYsm7lPvkIhNUZRKIlQcuBLItr3Kq2FX1A1AdyriC1FKtlB2o7Klx0MSP/cIjzvhDekK3FJHY0R6ZByF7lCpH1vWeene+k5fUqUvWcM8QUd7CE01TiV2x71lkHI1kD9xIFknkr1R9gug1AOmOUc6zL7Y+zNHX+rerf/D+m27S/2Odztr7D3Wdh0b96r4vaurMufu34B6jHHctPz0ZdDgY8g81fAIQ8YcrwUv70qZ0wYz9u+YjSZxwIF3jybYeAxmbotDAtk6dKpzvP4Skr2O1ERGWFtg1XndJ3l7CIJ/zhvypX1JMsH2VXJ9s9r+WsHF9nL2235eY9HW1rqtLh44rUmeitJapjjKHUq79/lxD3N
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55484D1ED615434F824251448E8DE299@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37200b8e-1fce-4a33-001b-08d75741be67
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 22:46:57.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPN/DG7Pr8IQThSQMEwFJdSG29TEoXdFZZxUXoY8CH0l1s7+d2b3Qxjj2ZP7wgYk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2818
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220196
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 05:42:49PM -0400, Johannes Weiner wrote:
> On Tue, Oct 22, 2019 at 07:56:33PM +0000, Roman Gushchin wrote:
> > On Tue, Oct 22, 2019 at 10:48:00AM -0400, Johannes Weiner wrote:
> > > -			/* Record the group's reclaim efficiency */
> > > -			vmpressure(sc->gfp_mask, memcg, false,
> > > -				   sc->nr_scanned - scanned,
> > > -				   sc->nr_reclaimed - reclaimed);
> > > -
> > > -		} while ((memcg =3D mem_cgroup_iter(root, memcg, NULL)));
> > > +		reclaimed =3D sc->nr_reclaimed;
> > > +		scanned =3D sc->nr_scanned;
> > > +		shrink_node_memcg(pgdat, memcg, sc);
> > > =20
> > > -		if (reclaim_state) {
> > > -			sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> > > -			reclaim_state->reclaimed_slab =3D 0;
> > > -		}
> > > +		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> > > +			    sc->priority);
> > > =20
> > > -		/* Record the subtree's reclaim efficiency */
> > > -		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > > -			   sc->nr_scanned - nr_scanned,
> > > -			   sc->nr_reclaimed - nr_reclaimed);
> > > +		/* Record the group's reclaim efficiency */
> > > +		vmpressure(sc->gfp_mask, memcg, false,
> > > +			   sc->nr_scanned - scanned,
> > > +			   sc->nr_reclaimed - reclaimed);
> >=20
> > It doesn't look as a trivial change. I'd add some comments to the commi=
t message
> > why it's safe to do.
>=20
> It's an equivalent change - it's just really misleading because the
> +++ lines are not the counter-part of the --- lines here!
>=20
> There are two vmpressure calls in this function: one against the
> individual cgroups, and one against the tree. The diff puts them
> adjacent here, but the counter-part for the --- lines is here:
>=20
> > > +	/* Record the subtree's reclaim efficiency */
> > > +	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > > +		   sc->nr_scanned - nr_scanned,
> > > +		   sc->nr_reclaimed - nr_reclaimed);
>=20
> And the counter-part to the +++ lines is further up (beginning of the
> quoted diff).
>=20

Ah, ok, got it. You were right in the foreword, indentation change
diffs are hard to read.

Thanks for the explanation!

Reviewed-by: Roman Gushchin <guro@fb.com>
