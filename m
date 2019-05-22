Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD827234
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2019 00:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEVWXP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 18:23:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbfEVWXO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 May 2019 18:23:14 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4MMBl7C022026;
        Wed, 22 May 2019 15:23:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dGmKexW93ziU4gaxGu2r8jazHHWX79RJa8vFWpgs9PA=;
 b=IAEjEkbK1fNS9QuZ5RtI4RWq2cpu9zKkLk4Rti/yV01QYV8kG1U3eIz5Rah4wzJUsQ91
 lSWbqIWGduow+/cXrlgLSYo97fZs4fRK21NSP3TJC+xqcBs4VdBs0o9nvHnGqZiba22o
 IqaKjwpzRVCF60QB4mRiNEpjyT+fqY3uqOc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2sn5ta28p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 May 2019 15:23:04 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 22 May 2019 15:23:03 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 22 May 2019 15:23:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGmKexW93ziU4gaxGu2r8jazHHWX79RJa8vFWpgs9PA=;
 b=r4T7y0il9x6ORmFiY+ATgUu27a5Q8elRA6V5CL9dgARrsp6Vv6YqHqQA57GRa5IZAjHFAYbw76PmE0c4fh8ahy2zDrKyWxs3f7au137fhrs5yg4vJZzTFKtioDF86B4DDVh/7n9ELX1UqbDAznWxbH8D44z06Ktz0XQ8rn5V1y8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2246.namprd15.prod.outlook.com (52.135.196.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 22:23:01 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 22:23:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/7] mm: reparent slab memory on cgroup removal
Thread-Topic: [PATCH v5 0/7] mm: reparent slab memory on cgroup removal
Thread-Index: AQHVEBPXzJHWaXaBI0+0EQ7he1b+7KZ3OWCAgAB5ngCAAAaqgA==
Date:   Wed, 22 May 2019 22:23:01 +0000
Message-ID: <20190522222254.GA5700@castle>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190522214347.GA10082@tower.DHCP.thefacebook.com>
 <20190522145906.60c9e70ac0ed7ee3918a124c@linux-foundation.org>
In-Reply-To: <20190522145906.60c9e70ac0ed7ee3918a124c@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:39a1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de318b47-c092-401b-4178-08d6df040cf7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2246;
x-ms-traffictypediagnostic: BYAPR15MB2246:
x-microsoft-antispam-prvs: <BYAPR15MB2246367CCCFC35A3F2B478F7BE000@BYAPR15MB2246.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(476003)(53936002)(66446008)(66946007)(5660300002)(99286004)(73956011)(66476007)(52116002)(186003)(81166006)(386003)(6506007)(81156014)(8936002)(76176011)(54906003)(316002)(86362001)(66556008)(64756008)(71190400001)(71200400001)(1076003)(6246003)(4326008)(25786009)(33716001)(7736002)(46003)(486006)(478600001)(7416002)(14454004)(14444005)(11346002)(256004)(446003)(305945005)(6916009)(33656002)(8676002)(2906002)(9686003)(6512007)(229853002)(102836004)(6436002)(68736007)(6486002)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2246;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fhZs5LKwhhGswexFbHlJlKTaGR8pmNZeyhMtDQgoclfVQT2GW26UxNzwMpTFiMeq5IRllRA4XGPFbAGfXxXodt9ROCKZpALcfrQ3jFC8fC8v/Glx4hxTp5G1+sYaNfJ0UnE35lGsy+0qmgGdpvbKZ3vUZJjWa1d5W3fLQx3m70rmG1wfSLx56VRQ3tuRqA57GNri0HLpG3P/gN1SXW+fdJoXcuRTJqGMPkQ9ks574d7QDhkDa2kbuOl+N3WAZJfJC8sdkRAUAPwWaKVN8Z9M85z9oNMeKPEJD3nrCOyiVU833QMjUYKclVgB7SfwEic+M7WYBY0iHDKH+z+BsnAHElJZCu5+JzttR5+Eg0/7v+rdDSCBhH/fQ3f1uFqHTN1HNyhHafnPeWOJXzJgDUOC8rPSvtBacLU7J0XMdqek7U0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65249C67D481204287EF3B3478D04766@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de318b47-c092-401b-4178-08d6df040cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 22:23:01.2975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2246
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=735 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220154
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 22, 2019 at 02:59:06PM -0700, Andrew Morton wrote:
> On Wed, 22 May 2019 21:43:54 +0000 Roman Gushchin <guro@fb.com> wrote:
>=20
> > Is this patchset good to go? Or do you have any remaining concerns?
> >=20
> > It has been carefully reviewed by Shakeel; and also Christoph and Waima=
n
> > gave some attention to it.
> >=20
> > Since commit 172b06c32b94 ("mm: slowly shrink slabs with a relatively")
> > has been reverted, the memcg "leak" problem is open again, and I've hea=
rd
> > from several independent people and companies that it's a real problem
> > for them. So it will be nice to close it asap.
> >=20
> > I suspect that the fix is too heavy for stable, unfortunately.
> >=20
> > Please, let me know if you have any issues that preventing you
> > from pulling it into the tree.
>=20
> I looked, and put it on ice for a while, hoping to hear from
> mhocko/hannes.  Did they look at the earlier versions?

Johannes has definitely looked at one of early versions of the patchset,
and one of the outcomes was his own patchset about pushing memcg stats
up by the tree, which eliminated the need to deal with memcg stats
on kmem_cache reparenting.

The problem and the proposed solution have been discussed on latest LSFMM,
and I didn't hear any opposition. So I assume that Michal is at least
not against the idea in general. A careful code review is always welcome,
of course.

Thanks!
