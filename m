Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71991D01D
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfENTnt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 15:43:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfENTns (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 15:43:48 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EJY1gm014959;
        Tue, 14 May 2019 12:42:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=x2HFRFfSV1QxX6NnMPuTXEkpxhm1CN1+DRXTpJBPqzY=;
 b=qf+YY+9tkLof8ft9297xPNc8GsFJugEcUFgvSB2SBe58rr0LhhuB9VXKMg1Bz7RJ37pv
 7osKi7pPJbrmI4RKmxJvj0jYdJ0b5pcfIbVn5sG0rmKwcgUYqX7e8xIJ084MHS6zd0Gc
 ktT4OJUV/DnICQYll/X90BvJ8O2Li6H6B+A= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sg3k1g3kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 May 2019 12:42:56 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 14 May 2019 12:42:56 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 14 May 2019 12:42:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2HFRFfSV1QxX6NnMPuTXEkpxhm1CN1+DRXTpJBPqzY=;
 b=E60x6FJhQCjW2rBDumKABRYv4tXauNZoQSzyWbo3uRBZP3Cz+QAe1tn+M+/oLloUyowf2BWf1FGlTedLX3wNDGNZgsJBZgLeVEX1f+IYDKubB1hPVvpX1WYtyodxiTSRmIJG6vaUJQvaXlAWvhBFklYwHbILO2yxRh8aSHo6H9M=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2421.namprd15.prod.outlook.com (52.135.198.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Tue, 14 May 2019 19:42:54 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 19:42:54 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Matteo Croce <mcroce@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: WARNING: CPU: 1 PID: 228 at kernel/cgroup/cgroup.c:5929
Thread-Topic: WARNING: CPU: 1 PID: 228 at kernel/cgroup/cgroup.c:5929
Thread-Index: AQHVCoqk1mZJtzvIAk+xNbeMmTPUdKZrBVaA
Date:   Tue, 14 May 2019 19:42:53 +0000
Message-ID: <20190514194249.GD12629@tower.DHCP.thefacebook.com>
References: <CAGnkfhwMSNm4uSkcGtqaGmYanfNK9rx6m2a3TqJh08YitbGAUg@mail.gmail.com>
In-Reply-To: <CAGnkfhwMSNm4uSkcGtqaGmYanfNK9rx6m2a3TqJh08YitbGAUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:301:1::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::298]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a3f4192-a490-4210-e035-08d6d8a45b2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2421;
x-ms-traffictypediagnostic: BYAPR15MB2421:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB24217C0A945FE6B0DB5B0BADBE080@BYAPR15MB2421.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(6486002)(186003)(76176011)(4326008)(305945005)(5660300002)(25786009)(6436002)(476003)(73956011)(11346002)(478600001)(229853002)(14454004)(66946007)(66556008)(966005)(66446008)(64756008)(66476007)(446003)(7736002)(71190400001)(71200400001)(1076003)(8676002)(81166006)(81156014)(486006)(8936002)(46003)(14444005)(316002)(256004)(2906002)(6506007)(102836004)(386003)(68736007)(33656002)(99286004)(6916009)(52116002)(54906003)(6116002)(86362001)(9686003)(53936002)(6306002)(6512007)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2421;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D4vxK8sKhOJioN+3DCtITHJDQOGmcoNW99o+hKwtgW+FJcqDhiivnFlXftBNCSi8JSMWFLVaUHD0WDGd6QNn147b9EhT0YRgokz4Qn7tSAvIFzv/SD0iyl7+ngjwCCO8+szthHMpLOTLcQ5uXv84dL85peYyHcJJ/HEVWCJCp2a9dz5Sg4b17/H9g1CAcah5uiqB3UzhSSq22nAF0zqM3epM24iLRxmCj+yK6v9LszekYMY8R3r3myFJzqw/83tHADEGKY5DIma9ITEsrhFz0zgXHjgaIGsFe9//HutizuXhL5laHV5IihBWgdcWLhIZj3M2A34XFnbZwTK4fodNfj6wYAzVFXN1zXmMuQwuWukMwqhlYOGXpXVoS9KkypkCwXptAnL3AdHDbYRpwNIqYOBHMaCCa77LyMM8KC0Adbo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BC2166E8518164EAC9F7F902EC5908D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3f4192-a490-4210-e035-08d6d8a45b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 19:42:53.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Matteo!

Thank you for the report!

Can you, please, try the patch from this mail:
https://lkml.org/lkml/2019/5/14/639 ?

Thanks!

Roman

On Tue, May 14, 2019 at 09:23:48PM +0200, Matteo Croce wrote:
> Hi,
>=20
> I have the following splat when a ptraced process exits:
>=20
> root@debian64:~# strace true
> execve("/bin/true", ["true"], 0x7ffd444fdfb0 /* 18 vars */) =3D 0
> [..]
> exit_group(0)                           =3D ?
> [    5.394349] WARNING: CPU: 1 PID: 228 at kernel/cgroup/cgroup.c:5929 cg=
roup_exit+0xed/0x100
> [    5.394606] CPU: 1 PID: 228 Comm: true Not tainted 5.1.0-rc3-kvm+ #86
> [    5.394819] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.12.0-2.fc30 04/01/2014
> [    5.395091] RIP: 0010:cgroup_exit+0xed/0x100
> [    5.395269] Code: 04 89 c3 7e d5 48 83 c4 08 5b 5d c3 f0 ff 43 28 0f 8=
8 8e 4d 34 00 eb a3 48 8b 85 78 06 00 00 48 8b 78 38 e8 e5 25 00 00 eb 82 <=
0f> 0b e9 5f ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 55 be 05
> [    5.395827] RSP: 0018:ffffc9000037be38 EFLAGS: 00010002
> [    5.396009] RAX: ffff88807be8bc40 RBX: ffff888078f62400 RCX: ffff88807=
8f62468
> [    5.396236] RDX: ffff888078f62448 RSI: ffff888078f62400 RDI: ffff88807=
8f62408
> [    5.396463] RBP: ffff888078f89580 R08: ffff888078f89c60 R09: 000000000=
0000000
> [    5.396692] R10: ffff88807adc1100 R11: 0000000000000001 R12: ffff88807=
8f89580
> [    5.396919] R13: ffff888078f89b80 R14: 0000000000000000 R15: ffff88807=
8ed4060
> [    5.397169] FS:  0000000000000000(0000) GS:ffff88807da80000(0000) knlG=
S:0000000000000000
> [    5.397425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.397614] CR2: 00007f017ea1d9a0 CR3: 0000000001a0c000 CR4: 000000000=
00006a0
> [    5.397846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    5.398097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    5.398324] Call Trace:
> [    5.398408]  do_exit+0x27f/0xa10
> [    5.398550]  ? ptrace_do_notify+0x6c/0x80
> [    5.398694]  do_group_exit+0x35/0xa0
> [    5.398838]  __x64_sys_exit_group+0xf/0x10
> [    5.398983]  do_syscall_64+0x48/0x340
> [    5.399127]  ? __do_page_fault+0x1aa/0x3f0
> [    5.399272]  ? __put_user_4+0x19/0x20
> [    5.399418]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    5.399598] RIP: 0033:0x7f017ea1d9d6
> [    5.399745] Code: Bad RIP value.
> [    5.399885] RSP: 002b:00007ffc187f7aa8 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000e7
> [    5.400144] RAX: ffffffffffffffda RBX: 00007f017eb0e760 RCX: 00007f017=
ea1d9d6
> [    5.400370] RDX: 0000000000000000 RSI: 000000000000003c RDI: 000000000=
0000000
> [    5.400601] RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffffff=
fffff80
> [    5.400858] R10: 00007ffc187f7974 R11: 0000000000000246 R12: 00007f017=
eb0e760
> [    5.401105] R13: 0000000000000001 R14: 00007f017eb17428 R15: 000000000=
0000000
> [    5.401337] ---[ end trace 6bf3ae0d5396cf27 ]---
>=20
> I found the offending commit bisecting, and seems to be this one.
>=20
> commit 96b9c592def5d7203bdad1337d9c92a2183de5cb
> Author: Roman Gushchin <guro@fb.com>
> Date:   Fri Apr 26 10:59:45 2019 -0700
>=20
>     cgroup: get rid of cgroup_freezer_frozen_exit()
>=20
>=20
> Regards,
> --=20
> Matteo Croce
> per aspera ad upstream
