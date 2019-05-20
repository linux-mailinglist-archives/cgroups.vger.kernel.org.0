Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D031E240F8
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2019 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfETTN2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 May 2019 15:13:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54668 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfETTN2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 May 2019 15:13:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KJ7fBY032654;
        Mon, 20 May 2019 12:11:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CJozRhYRJqB6SxHsJ0jlMD+Zc5JvMXKijcauIXAP260=;
 b=AYsZlAwvw0B7O1T7uh6/FMnNo45EBKE0pF0X5civI77aycPiDegw3jWm3jVlL7hbaApU
 ugJ36jU245o29JaXg3BoSPSJoMxDdiiol1S5d9+EhB00t/WatTcCDHGSknXSG4NLqm76
 L7TTy5QFEa0nEZjyYVaEMG1OKyxdEVr8uPw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2skvds1c62-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 May 2019 12:11:53 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 May 2019 12:11:41 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 12:11:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJozRhYRJqB6SxHsJ0jlMD+Zc5JvMXKijcauIXAP260=;
 b=Xa6du1cE2+Ql7cjClJ5hD6ZFF+X+KiguBKat170CXToFtD3Dxy1HZVOcUJWgzx0fbzVMz+BufWmwhmNBd1GiWIgzRkjTuBUCTFf6jK7CBG1I8l3+P7ZcVwngTdvaY58i6L4/tGb2KgeRWqaivcIStWRJ1WO1APUnSJCfntLkdjA=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2759.namprd15.prod.outlook.com (20.179.157.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 19:11:39 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 19:11:39 +0000
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
Thread-Index: AQHVC9OmgOU0Jmtzzk+sDHdbgUmMIKZtaVaAgAB38QD//6deAIAAeIMAgAEZW4CAAIFxAIAEHAMAgACwEIA=
Date:   Mon, 20 May 2019 19:11:39 +0000
Message-ID: <20190520191135.GB24204@tower.DHCP.thefacebook.com>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516153144.GC19737@antique-laptop>
 <20190516171427.GA8058@castle.DHCP.thefacebook.com>
 <CAADnVQ+c4HW+1jrurHDX0M4-yn13fmU=TYhF+8wPrxNZZRcjTw@mail.gmail.com>
 <20190517101222.GF1981@antique-laptop>
 <20190518005606.GA3431@tower.DHCP.thefacebook.com>
 <20190520084126.GM1981@antique-laptop>
In-Reply-To: <20190520084126.GM1981@antique-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0087.namprd19.prod.outlook.com
 (2603:10b6:320:1f::25) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:21ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712175ff-5f0f-4a76-2c7c-08d6dd56fc6d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2759;
x-ms-traffictypediagnostic: BYAPR15MB2759:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB27597DF383951499C82B7913BE060@BYAPR15MB2759.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(6506007)(14444005)(53936002)(478600001)(5024004)(46003)(256004)(186003)(53546011)(8676002)(76176011)(54906003)(25786009)(6246003)(386003)(476003)(11346002)(486006)(81156014)(102836004)(446003)(66476007)(66556008)(64756008)(66446008)(8936002)(33656002)(66946007)(52116002)(73956011)(81166006)(68736007)(6486002)(5660300002)(7736002)(966005)(99286004)(2906002)(229853002)(305945005)(1076003)(6916009)(6306002)(9686003)(6512007)(6116002)(4326008)(7416002)(6436002)(14454004)(86362001)(71190400001)(316002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2759;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: smzMrXwo2XqTh/wOOsyQeftL4KhkF7MFRMYIkyLUlvT216vRHORwsOU4oeFm3vAE8Q+W6MuZjbXpfdptKzuko4CVThbyLGlBRaCif9ybvbxFLoZoLv0kam6kpnl/l/zPFshcdK3Wj5bfTO0YREoIwW7m9fEhDkzOQxsNlbRYivl+BOA6LNfUQchOIlFOTd27D1asaJ7SOzppIdp8mlfJD4L+s7UcTJi6RLhul47jDV0XN2YKTWk4luBiQjuEBco6qzw1sEBaD8fH80CZ/DvPgaAvWHvPMYCCsPqjHvAxRZcSHTdn05Q8UDwFyq6r210pVlDm6EstBdUQaMbkDzUjSPT1uyZG2q/d0n5Rqosp4N/xn7YMS79rsNtnX7yz9lneBNlsa7BCleQImvTl2ku+Nv3mlcpxP558wJkneyZ3LPA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F4ED903DEEFC74F9138FA8710F91C8F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 712175ff-5f0f-4a76-2c7c-08d6dd56fc6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 19:11:39.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200119
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 20, 2019 at 10:41:26AM +0200, Pavel Hrdina wrote:
> On Sat, May 18, 2019 at 12:56:12AM +0000, Roman Gushchin wrote:
> > On Fri, May 17, 2019 at 12:12:51PM +0200, Pavel Hrdina wrote:
> > > On Thu, May 16, 2019 at 10:25:50AM -0700, Alexei Starovoitov wrote:
> > > > On Thu, May 16, 2019 at 10:15 AM Roman Gushchin <guro@fb.com> wrote=
:
> > > > >
> > > > > On Thu, May 16, 2019 at 05:31:44PM +0200, Pavel Hrdina wrote:
> > > > > > On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> > > > > > > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > > > > > > hi,
> > > > > > > > Pavel reported an issue with bpf programs (attached to cgro=
up)
> > > > > > > > not being released at the time when the cgroup is removed a=
nd
> > > > > > > > are still visible in 'bpftool prog' list afterwards.
> > > > > > >
> > > > > > > Hi Jiri!
> > > > > > >
> > > > > > > Can you, please, try the patch from
> > > > > > > https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6=
c4872d342bf6721e148e2 ?
> > > > > > >
> > > > > > > It should solve the problem, and I'm about to post it upstrea=
m.
> > > > > >
> > > > > > Perfect, I'll give it a try with full libvirt setup as well.
> > > > > >
> > > > > > Can we have this somehow detectable from user-space so libvirt =
can
> > > > > > decide when to use BPF or not?  I would like to avoid using BPF=
 with
> > > > > > libvirt if this issue is not fixed and we cannot simply workaro=
und it
> > > > > > as systemd automatically removes cgroups for us.
> > > > >
> > > > > Hm, I don't think there is a good way to detect it from userspace=
.
> > > > > At least I have no good ideas. Alexei? Daniel?
> > > > >
> > > > > If you're interested in a particular stable version, we can proba=
bly
> > > > > treat it as a "fix", and backport.
> > > >=20
> > > > right.
> > > > also user space workaround is trivial.
> > > > Just detach before rmdir.
> > >=20
> > > Well yes, it's trivial but not if you are using machined from systemd=
.
> > > Once libvirt kills QEMU process systemd automatically removes the
> > > cgroup so we don't have any chance to remove the BPF program.
> > >=20
> > > Would it be too ugly to put something into
> > > '/sys/kernel/cgroup/features'?
> >=20
> > I thought about it, but it seems that /sys/kernel/cgroup/features is al=
so
> > relatively new. So if we're not going to backport it (I mean auto-detac=
hing),
> > than we can simple look at the kernel version, right?
>=20
> If you think only about upstream then the version check is in most cases
> good enough, but usually that's not the case and patches are backported
> to downstream distributions as well.
>=20
> Yes, that file was introduced in kernel 4.15 so there are some
> limitations where the fix would be introspectable.
>=20
> > If we're going to backport it, the question is which stable version we'=
re
> > looking at.
> >=20
> > In general, I don't see any reasons why cgroup/features can't be used.
>=20
> Perfect, in that case I would prefer if we could export it in
> cgroup/features as it will be easier for user-space to figure out
> whether it's safe to relay on proper cleanup behavior or not and
> it will make downstream distributions life easier.

Hello, Pavel!

Tejun noticed that cgroup features are supposed to match cgroupfs mount opt=
ions,
so it can't be used here. And this >=3D 4.15 limitation is also a significa=
nt
constraint.

Thanks!
