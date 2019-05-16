Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 359E820DC0
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEPRQB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 13:16:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58428 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbfEPRQA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 13:16:00 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GH8aDK024467;
        Thu, 16 May 2019 10:14:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CccH9s7sEq3JoNfORo8uVlXV7wwCWe+3wwwATZAZUnI=;
 b=METr9YJMQMRD6NktlIrnnrtpudKEUzPEPRS6vMOgnSU/AX0eJAQaG2dOTY8hd82MON83
 41PJe2XhzzS/aSli0C+edoggrERla48ifA+xgaQvhBc82W3jhTPfhwQkY5Njfa0EB0V4
 vR0jfd1UUwW+TY6DGixiKw/MCBHu8PoYN/w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2shb4pr7vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 May 2019 10:14:39 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 May 2019 10:14:38 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 May 2019 10:14:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CccH9s7sEq3JoNfORo8uVlXV7wwCWe+3wwwATZAZUnI=;
 b=tPSEyhVWqbKP/bzXRLq3OPBS/+86DrBZPWLoM6tYbqgURBX4ejihc8Lw9tJw6EASbeYc/wYtA1lWlWNv6RcA50bVwxcB9QHePQ+PFFFPQFoFai+Ymo1/BY02oLp4JmWz55qq+VM7e7H2RpYmPp2CSM7n2EJLfbNb2Zwpq5S+WeI=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3318.namprd15.prod.outlook.com (20.179.58.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 17:14:36 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 17:14:36 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Pavel Hrdina <phrdina@redhat.com>
CC:     Jiri Olsa <jolsa@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "hange-folder>?" <toggle-mailboxes@castle.dhcp.thefacebook.com>
Subject: Re: [RFC] cgroup gets release after long time
Thread-Topic: [RFC] cgroup gets release after long time
Thread-Index: AQHVC9OmgOU0Jmtzzk+sDHdbgUmMIKZtaVaAgAB38QCAABy2AA==
Date:   Thu, 16 May 2019 17:14:36 +0000
Message-ID: <20190516171427.GA8058@castle.DHCP.thefacebook.com>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516153144.GC19737@antique-laptop>
In-Reply-To: <20190516153144.GC19737@antique-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:3b0e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5991e8f-0878-4084-b1b6-08d6da21f88a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3318;
x-ms-traffictypediagnostic: BYAPR15MB3318:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB33182D671D02EB5D9390B084BE0A0@BYAPR15MB3318.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(8936002)(86362001)(478600001)(6486002)(81156014)(8676002)(71190400001)(71200400001)(99286004)(81166006)(966005)(186003)(305945005)(6436002)(7736002)(316002)(476003)(5660300002)(11346002)(2906002)(68736007)(46003)(14454004)(1076003)(446003)(486006)(6916009)(229853002)(53936002)(52116002)(256004)(5024004)(14444005)(6306002)(4326008)(25786009)(7416002)(9686003)(6246003)(54906003)(6116002)(33656002)(66556008)(386003)(102836004)(76176011)(6506007)(6512007)(64756008)(66446008)(66476007)(73956011)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3318;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 06uV3XkiItaDANPoMNxotuW41QonT9ID4rM5/OfPb8UDXy+XK/cF6GybfYgbBvMhyG+U8Yb/xZ+F9zXpTWaKiAp0dXvyEKMZl7S/2w7OPQbgF5eoOxNugyFlsgagqbM5YjXMKiWBasBwoIDNPC8m0Y+2Cf3qFrVNwnL8rNikcQY0Cfo0U1ZRiW60jROXoX1aafq4d/xk6n7rW7FTBxfgZeBKZ/pf6GhHru5dsD8qrsJYr8JyEbZx+bXUfPtYnsZZi1N78AK5N1kN3iGvhKRfWWnlACopXFyH0cYz3VkHsD+oWNMwOYqZcO4Ha/oUNyQrjcQNmCXnMM+JgppD290W2fI3xA+U2QqeAXAu5Pyc8WQigCtLNZYDsfexpz3mTw0o9suA8R48nVtyh6PRY0g6qgebn/c0ZVAQzQYMWb+ehP0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1388E6D9A0A9C4EB527119357E48708@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5991e8f-0878-4084-b1b6-08d6da21f88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 17:14:36.0487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3318
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=772 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160109
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 05:31:44PM +0200, Pavel Hrdina wrote:
> On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > hi,
> > > Pavel reported an issue with bpf programs (attached to cgroup)
> > > not being released at the time when the cgroup is removed and
> > > are still visible in 'bpftool prog' list afterwards.
> >=20
> > Hi Jiri!
> >=20
> > Can you, please, try the patch from
> > https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4872d342b=
f6721e148e2 ?
> >=20
> > It should solve the problem, and I'm about to post it upstream.
>=20
> Perfect, I'll give it a try with full libvirt setup as well.
>=20
> Can we have this somehow detectable from user-space so libvirt can
> decide when to use BPF or not?  I would like to avoid using BPF with
> libvirt if this issue is not fixed and we cannot simply workaround it
> as systemd automatically removes cgroups for us.

Hm, I don't think there is a good way to detect it from userspace.
At least I have no good ideas. Alexei? Daniel?

If you're interested in a particular stable version, we can probably
treat it as a "fix", and backport.

Thanks!
