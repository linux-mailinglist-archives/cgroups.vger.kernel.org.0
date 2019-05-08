Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BB17F77
	for <lists+cgroups@lfdr.de>; Wed,  8 May 2019 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfEHSEZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 May 2019 14:04:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51594 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbfEHSEY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 May 2019 14:04:24 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48Hvl8c000352;
        Wed, 8 May 2019 11:03:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5Pvqd9AFIVjCFfG5s63rkla6Tj4DPV/b5/s/sPs/rHY=;
 b=p8DbHIUOazGolxZyeasMMbcaXJtJA0PHW9glC7dJvVSOo5q/F6BMDz090El/VnQj68LZ
 kR/zPxN2e6HNOGu/Tpd1DEm0AYxH9r8sPlgqc4rEBE/gGW1f+u5XV0ZZZTlXmeljoKvt
 gwiycTj7AUS68EGk11F7t8FpPuTiOMNzGkQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sbyyxgyyv-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 May 2019 11:03:28 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 May 2019 11:03:15 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 8 May 2019 11:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pvqd9AFIVjCFfG5s63rkla6Tj4DPV/b5/s/sPs/rHY=;
 b=RUfn8/OzwB3S2QCJ5TcRFeCB31mqe+/dtmhYPkML2gh+R+bgRwYY6mtM4Cu7x5RXo4oz0GkjJZRBZP0SO2PQ7m0Bywr/RNWtp20da7EMQDfoV1wZlqiiuZ6XZfeNtt/a1SMByLzCrN29WVYuLT0cHbfuEkiKKjIzq+Ng60FSbio=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2392.namprd15.prod.outlook.com (52.135.198.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 18:03:13 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ddd2:172e:d688:b5b7]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ddd2:172e:d688:b5b7%3]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 18:03:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Qian Cai <cai@lca.pw>, "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ptrace warning due to "cgroup: get rid of
 cgroup_freezer_frozen_exit()"
Thread-Topic: ptrace warning due to "cgroup: get rid of
 cgroup_freezer_frozen_exit()"
Thread-Index: AQHVBRAdiRV9e0TuJUe+IcFJ/bKLuqZfusgAgAGfqQCAACwFgA==
Date:   Wed, 8 May 2019 18:03:12 +0000
Message-ID: <20190508180307.GA25433@tower.DHCP.thefacebook.com>
References: <1557259462.6132.20.camel@lca.pw>
 <20190507213752.GA24308@tower.DHCP.thefacebook.com>
 <20190508152536.GA17058@redhat.com>
In-Reply-To: <20190508152536.GA17058@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::f251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de57a2a2-5eb1-471e-863a-08d6d3df6fcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2392;
x-ms-traffictypediagnostic: BYAPR15MB2392:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB239269F670B1F8A15105B464BE320@BYAPR15MB2392.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(6246003)(25786009)(64756008)(66446008)(66556008)(66476007)(316002)(5660300002)(6486002)(6116002)(66946007)(6916009)(6306002)(86362001)(6512007)(9686003)(71200400001)(71190400001)(256004)(52116002)(14444005)(14454004)(1076003)(2906002)(76176011)(6506007)(386003)(6436002)(54906003)(73956011)(99286004)(478600001)(486006)(8676002)(81166006)(229853002)(966005)(476003)(33656002)(4326008)(186003)(81156014)(8936002)(7736002)(53936002)(305945005)(11346002)(446003)(102836004)(68736007)(46003)(26583001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2392;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wPVGkpVbd6RRPTvNgKa9kBhrU4R3dB7vRihdnRzBG5ImC+ekeubWh4akWAXCYBUhpnTliAXbrxqX6TxAQMU9K1ZHnZ/O61w45wt1XwBjs4N1Gffi0JDy9vkKGh7o/cMnxJezLlwjWTkacsxAnoibN/AHfE6njih+XTJCdEWexrG31XcCG4zX4gia4azBCp6UwEW59YJ2ge+F7Qo0cBm6klBW/JL3lmw0AZwRLUjNWxZpRhIeREh3+7ILhPvaGlUARja5L9fMMAIk/NGu2JfO4t2f2S1emQRXQQKH83nskGOwrJbJBBEUok/ZvJAoRne+/WMqRWD2RO+IFjSyP1sR4bv22NMODxQHg9wInburKuxKRQ1mvSmDD/PcAb5gjYOAOjsuwmQH5kBMMcY5L/wG2zpwPF9lfFN6GCiOoj03IpY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EFE5CF94ED0C649A5834C40271345C7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de57a2a2-5eb1-471e-863a-08d6d3df6fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 18:03:12.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2392
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=526 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080110
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Oleg!

On Wed, May 08, 2019 at 05:25:36PM +0200, Oleg Nesterov wrote:
> On 05/07, Roman Gushchin wrote:
> >
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2484,9 +2484,6 @@ bool get_signal(struct ksignal *ksig)
> >                 sigdelset(&current->pending.signal, SIGKILL);
> >                 recalc_sigpending();
> >                 current->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
>=20
> just noticed... perhaps it makes more sense to clear JOBCTL_TRAP_FREEZE
> before recalc_sigpending(). Or simply not clear it at all, see below.

Agree, we don't need to clear it, because there is no way back for the task
at this moment, only exiting. I'm dropping this line.

>=20
> > -               spin_unlock_irq(&sighand->siglock);
> > -               if (unlikely(cgroup_task_frozen(current)))
> > -                       cgroup_leave_frozen(true);
> >                 goto fatal;
> >         }
> > =20
> > @@ -2608,8 +2605,10 @@ bool get_signal(struct ksignal *ksig)
> >                         continue;
> >                 }
> > =20
> > -               spin_unlock_irq(&sighand->siglock);
> >         fatal:
> > +               spin_unlock_irq(&sighand->siglock);
> > +               if (unlikely(cgroup_task_frozen(current)))
> > +                       cgroup_leave_frozen(true);
>=20
> Yes, ptrace_signal() can return a fatal signal... and in this case we do =
not
> clear JOBCTL_TRAP_FREEZE. This doesn't look consistent with the code abov=
e.

The same here.

>=20
>=20
>=20
> I can only repeat that somehow we need to cleanup/improve the whole logic=
.
>=20
> Say, a traced task reports syscall-enter. ptrace_stop() does enter_frozen=
().
> The cgroup can become CGRP_FROZEN after that. Now the debugger does PTRAC=
E_CONT,
> the frozen task actually starts the syscall. Obviously not good.
>=20
> Heh, and if this syscall is sys_exit or sys_exit_group we can hit the sam=
e
> warning.

Ok, I totally agree, but let's fix this noisy WARN_ON() for now,
to have some time to think about the rest.

I believe this will fix it for now:
https://github.com/rgushchin/linux/commit/3f65507e407c81d3cdf4a9145f36a8d0f=
755ca04

Please, let me know if you have any concerns here, otherwise I'll ask Tejun=
 to
pull it asap.

Thank you for looking into it!

Roman
