Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F826A96EB
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 01:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfIDXO1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 19:14:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728286AbfIDXO1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 19:14:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x84NALdV018693;
        Wed, 4 Sep 2019 16:13:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4Ul75V30fqg4tJL6AUehuDGJapCIoB5ZrB+HTS8LLpk=;
 b=pJ2gHKdGifN8CNjgU7HV5nuCIIzfX11XJlKcHZM1ax6ypV1uSDfZ0+MCD639VYr9SaI5
 Q8ffYW1o3OYG1MEZx+arnhT12sHPGBLXg9+H6e7nya15X2AORb+HugoAUORjVRJedbLm
 gPixdCfnK5QjfNCWIvchAjgFmqoMj4Jcy0E= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2utkkxrw3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 16:13:57 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 4 Sep 2019 16:13:56 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Sep 2019 16:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP8Vy9gCfe6jVZlVq3h2laL28bShAkcIYnoVtqg/m1O+UCYb+B6JYFUpRkfrWVwIjm5Fn3kp/J1j4jpI6mWdK6xvhcs3qoowR5ylEqIrDC7jsahr9wv362rLY428iNR5KOpeMSnYPUKnu7Ny/i3ZIPa4h8pRp+Ff5i2+AK7pHZW16mzzXAwqja9leMP88ezYqlxRfJg2BWIHo0JIA+YQ23ZqHIptp3wOSlly1Yn632/DOChiXIq0UiQkbzk6EoshqiVUg6I6QonuUolU7NrvsDUgG0KP8Phi9Td0JdWdaFA5X9SaC2OtAaOzEUx5uufeMCBnYG3eYTOUiuEzAvG+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ul75V30fqg4tJL6AUehuDGJapCIoB5ZrB+HTS8LLpk=;
 b=k64lqFJhVnpK/yOl9Sk4XijnRsWwPiZDI2HXxr7HPNAfSiYrwniyHibGTwKFODuxs7eCIvoE55O4TFnr2AQ2Dqb5wz1dcQSqij1Mk56kAEKys6Qr/yf37ilJNsLZE6ogK+YamRtqFu2Z4tcmFpiMsVbZEYN9uZ23IspzhjPJQcSmxaSFe1tzjg+sibVYX9Z1LomNCEBwJ27rf+1y7IpeXvTc3zL3HkCnVlDzYs9XS4AWYi0BQT9pPJsZdn+eM2m+V9nkHhjlnVKoFCh4ts/pmLp5iQxdjCOVDx/UNGSJtTGwe1UHhmW1risYtZuaA01xEqtYcMXZzCLwWZdWWK2JtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ul75V30fqg4tJL6AUehuDGJapCIoB5ZrB+HTS8LLpk=;
 b=ijbRmKJisfWxcyzK5Y351mYbicHFxusReORY87YCZb366NVHVOckZpGPneVHegf1M9DI0Y/cRefOlTKhb8SxOd6oWeuAhy6q/O9at8kBTDNpwmZcRQUM4Y5UmyHY4ySvJeKFe27cuZcI6vNYqmgUpBJGQYiVt1+MgZtFzWULsNQ=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3468.namprd15.prod.outlook.com (20.179.48.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 23:13:54 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::d1fc:b5c5:59a1:bd7e]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::d1fc:b5c5:59a1:bd7e%3]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 23:13:54 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 0/7] mm/memcontrol: recharge mlocked pages
Thread-Topic: [PATCH v1 0/7] mm/memcontrol: recharge mlocked pages
Thread-Index: AQHVYygb4ML2nlRWy0qljqLE4Dgc06ccJoIA
Date:   Wed, 4 Sep 2019 23:13:54 +0000
Message-ID: <20190904231350.GA5246@tower.dhcp.thefacebook.com>
References: <156760509382.6560.17364256340940314860.stgit@buzz>
In-Reply-To: <156760509382.6560.17364256340940314860.stgit@buzz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0035.namprd22.prod.outlook.com
 (2603:10b6:300:69::21) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:9261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ec29334-f3db-4bb4-1fe2-08d7318d8e46
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR15MB3468;
x-ms-traffictypediagnostic: DM6PR15MB3468:
x-microsoft-antispam-prvs: <DM6PR15MB34688EC908D5FCCDA9F14471BEB80@DM6PR15MB3468.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(476003)(486006)(446003)(11346002)(46003)(256004)(8676002)(81156014)(316002)(102836004)(386003)(6506007)(186003)(33656002)(6512007)(53936002)(6486002)(54906003)(9686003)(8936002)(14444005)(4326008)(71200400001)(71190400001)(6246003)(86362001)(229853002)(25786009)(6916009)(6116002)(76176011)(52116002)(6436002)(2906002)(99286004)(66946007)(64756008)(66446008)(14454004)(478600001)(1076003)(7736002)(5660300002)(81166006)(66556008)(66476007)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3468;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C2e56HbFY+/a8mHr765490FuHJJ2s6Rg/WIqdFaLJGPqkAAId9mNruXp2154h2G7ASXfM6BW03IDOGadXMmUocYAka42ER1X7KNOMFwee2rjvPy0v9CCB4VeRLvTQ00Ji7rrZWkfzldeDj/P2VJfAoQMD6MYJWBRfuLSKwU2/B6MZunWuMgc15+1XWBZamTMlMqrcnl2NZ1YX6U6DREOmXuHclJSK3ys23r7sEdkWSO86lrDQDV7J8AL+QJ0X44zRRSDfc+OJKXvnSUd4YgIzXOc7jdnAlRw4hTOtzF9I97IhLPqO5xV1sAvz0ZtDGEPL0sMVuywMDlgMO9f1P+14jz7PIAqrlwXSFuHKE++AzrPW2XeOlbDMMUZHZJZlHeHO8kPEWed92OSl55IxJUhFRkT+GBdsNiR+4XC7+tfNmw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59294D3005729C4181703E55A0E5DA85@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec29334-f3db-4bb4-1fe2-08d7318d8e46
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 23:13:54.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/wqnvY0MdP4D4+gNgsu4mazdmv7rS8soYR/HeOiNtyTeZgukuQL4gmDN0NY94Ae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3468
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_06:2019-09-04,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909040225
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 04, 2019 at 04:53:08PM +0300, Konstantin Khlebnikov wrote:
> Currently mlock keeps pages in cgroups where they were accounted.
> This way one container could affect another if they share file cache.
> Typical case is writing (downloading) file in one container and then
> locking in another. After that first container cannot get rid of cache.

Yeah, it's a valid problem, and it's not about mlocked pages only,
the same thing is true for generic pagecache. The only difference is that
in theory memory pressure should fix everything. But in reality
pagecache used by the second container can be very hot, so the first
once can't really get rid of it.
In other words, there is no way to pass a pagecache page between cgroups
without evicting it and re-reading from a storage, which is sub-optimal
in many cases.

We thought about new madvise(), which will uncharge pagecache but set
a new page flag, which will mean something like "whoever first starts using
the page, should be charged for it". But it never materialized in a patchse=
t.

> Also removed cgroup stays pinned by these mlocked pages.

Tbh, I don't think it's a big issue here. If only there is a huge number
of 1-page sized mlock areas, but this seems to be unlikely.

>=20
> This patchset implements recharging pages to cgroup of mlock user.
>=20
> There are three cases:
> * recharging at first mlock
> * recharging at munlock to any remaining mlock
> * recharging at 'culling' in reclaimer to any existing mlock
>=20
> To keep things simple recharging ignores memory limit. After that memory
> usage temporary could be higher than limit but cgroup will reclaim memory
> later or trigger oom, which is valid outcome when somebody mlock too much=
.

OOM is a concern here. If quitting an application will cause an immediate O=
OM
in an other cgroup, that's not so good. Ideally it should work like
memory.high, forcing all threads in the second cgroup into direct reclaim.

Thanks!
