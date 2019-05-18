Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74C22109
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2019 02:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfERA5j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 20:57:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfERA5j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 20:57:39 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4I0nXO9008657;
        Fri, 17 May 2019 17:56:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=V6yArMF6MnboNUFwErjt2T46ZErtVKS+M1WhmOlQJLU=;
 b=eZsKmNaWhEBYVbj05ZBzjuIttdrgYGC/aLAXvwf9uDLjK2fHtvRwBZ6IHNoT2KM60SKm
 NCJK+oAUiRUQ/F7VmLQXEBpq0re4h8JLkdy3ohukaw2VZHhnJVHiXyFUevpqKP+ZgKq8
 3VP5AxM7jNDX5eveWEgV1VqV44Ttc5wkZnk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sj0k71fp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 May 2019 17:56:16 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 May 2019 17:56:14 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 17:56:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6yArMF6MnboNUFwErjt2T46ZErtVKS+M1WhmOlQJLU=;
 b=PkmyQFhoObiYCZicT1E48XCcKWJ1BiFAJGnBYqbuZ9EPaS+9yxIeXKvoYNhkwHQ8B+TC2jgK+3WOfEoqlugwYiaGm7TrpLr2ZNHv8uJgDor9oP6xbJiXLHhR6ulQAGJwv6RQ5TKfdEqpgbRVD2NHu3/ZysEGs8niMQNKUJkZWIM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2805.namprd15.prod.outlook.com (20.179.158.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Sat, 18 May 2019 00:56:12 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.010; Sat, 18 May 2019
 00:56:12 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Pavel Hrdina <phrdina@redhat.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] cgroup gets release after long time
Thread-Topic: [RFC] cgroup gets release after long time
Thread-Index: AQHVC9OmgOU0Jmtzzk+sDHdbgUmMIKZtaVaAgAB38QD//6deAIAAeIMAgAEZW4CAAPbKAA==
Date:   Sat, 18 May 2019 00:56:12 +0000
Message-ID: <20190518005606.GA3431@tower.DHCP.thefacebook.com>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516153144.GC19737@antique-laptop>
 <20190516171427.GA8058@castle.DHCP.thefacebook.com>
 <CAADnVQ+c4HW+1jrurHDX0M4-yn13fmU=TYhF+8wPrxNZZRcjTw@mail.gmail.com>
 <20190517101222.GF1981@antique-laptop>
In-Reply-To: <20190517101222.GF1981@antique-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:300:ae::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:d7d0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 082426ff-5f12-4ea6-d625-08d6db2b9f20
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2805;
x-ms-traffictypediagnostic: BYAPR15MB2805:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB2805F7B853137C75C58D767EBE040@BYAPR15MB2805.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0041D46242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39850400004)(346002)(199004)(189003)(966005)(81156014)(81166006)(8676002)(99286004)(73956011)(186003)(6506007)(6116002)(386003)(68736007)(25786009)(5660300002)(53546011)(478600001)(229853002)(316002)(54906003)(66446008)(2906002)(64756008)(9686003)(6306002)(6512007)(4326008)(7416002)(66556008)(14454004)(6246003)(66946007)(86362001)(8936002)(66476007)(102836004)(486006)(6436002)(71190400001)(71200400001)(53936002)(52116002)(76176011)(7736002)(305945005)(33656002)(476003)(5024004)(14444005)(256004)(1076003)(6486002)(6916009)(46003)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2805;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +tgAgabm4sipLo3DzEqihn6Wp/5emdQjsLhdSCvaS7/oBbywK2GBCAkV/Hpa/g1YZ/6TNnAc68qgpknwL8YgEA1hwDoXC5PnqSvFGl9Ew9PuQ2VXzA0dpq/zdVKmFlfvimDJ2Qk9A+hiUbePLG7Yr1iFKgwS2zOTJqvhCBjaKWy7i8rESl6nT3pwk/Q9aFHCqsTpK9s4H0u47yu25tZS27vxPnHy90jLfMsIAKHVGb8k7N56pBH9T0JWeeBvbsKW7OlAF7k0qff0M+2c/TaCl0WMoEv+zX54YhgJq410A2q4cMdsEO3wtCEncDU9q9XdNBiwp7GcEF/KjRFPcfaWCSjDHwJbkbEgktr9Kg5cPfw3ywBzonAroPyFWCmst9uIb/Q3XuRrs/zdziqxkj7+cnRXqPaMywFIIZR9pD8/wNA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <456D39D10C28604B82BF7708F652C365@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 082426ff-5f12-4ea6-d625-08d6db2b9f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2019 00:56:12.2048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2805
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905180004
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 12:12:51PM +0200, Pavel Hrdina wrote:
> On Thu, May 16, 2019 at 10:25:50AM -0700, Alexei Starovoitov wrote:
> > On Thu, May 16, 2019 at 10:15 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Thu, May 16, 2019 at 05:31:44PM +0200, Pavel Hrdina wrote:
> > > > On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> > > > > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > > > > hi,
> > > > > > Pavel reported an issue with bpf programs (attached to cgroup)
> > > > > > not being released at the time when the cgroup is removed and
> > > > > > are still visible in 'bpftool prog' list afterwards.
> > > > >
> > > > > Hi Jiri!
> > > > >
> > > > > Can you, please, try the patch from
> > > > > https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c487=
2d342bf6721e148e2 ?
> > > > >
> > > > > It should solve the problem, and I'm about to post it upstream.
> > > >
> > > > Perfect, I'll give it a try with full libvirt setup as well.
> > > >
> > > > Can we have this somehow detectable from user-space so libvirt can
> > > > decide when to use BPF or not?  I would like to avoid using BPF wit=
h
> > > > libvirt if this issue is not fixed and we cannot simply workaround =
it
> > > > as systemd automatically removes cgroups for us.
> > >
> > > Hm, I don't think there is a good way to detect it from userspace.
> > > At least I have no good ideas. Alexei? Daniel?
> > >
> > > If you're interested in a particular stable version, we can probably
> > > treat it as a "fix", and backport.
> >=20
> > right.
> > also user space workaround is trivial.
> > Just detach before rmdir.
>=20
> Well yes, it's trivial but not if you are using machined from systemd.
> Once libvirt kills QEMU process systemd automatically removes the
> cgroup so we don't have any chance to remove the BPF program.
>=20
> Would it be too ugly to put something into
> '/sys/kernel/cgroup/features'?

I thought about it, but it seems that /sys/kernel/cgroup/features is also
relatively new. So if we're not going to backport it (I mean auto-detaching=
),
than we can simple look at the kernel version, right?

If we're going to backport it, the question is which stable version we're
looking at.

In general, I don't see any reasons why cgroup/features can't be used.

Thanks!
