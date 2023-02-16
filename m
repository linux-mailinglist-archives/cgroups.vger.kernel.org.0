Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B989699F17
	for <lists+cgroups@lfdr.de>; Thu, 16 Feb 2023 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBPVoo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Feb 2023 16:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPVon (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Feb 2023 16:44:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8742528BD;
        Thu, 16 Feb 2023 13:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF8D4NB+z2ulgyRXyENetmAi79bmBZX7E4+dEZPVoUfzMlbGRxon3riz1hnIEKPR6O0Wb3+2VcKoAJgMvjpZP0NRPsic5TSBdI2mb7Cym2GVdgP8XLe3+OLmxaGNTxANb0ggXZztaiyEouUVsQ4Eh76u9m4UCNUNfdOlLHiYikk6Wl7LCxoQu6o1HFBhRSyxGd2wXbgi5p9CT5MKE5BuCWUaWsKBQGuLKU70lyRnsawFrHvYtL9EQ5VCfiC8qAINFaCthcImFbyF/UGRVfeyPDTKfLe24QnPuLj3DpZOCFtwVTuM9j6LYlsHo6ZwgWowte8MB2wbMYD2ryDVjgidtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RKI4B4peM8M4LPcDSPFvy7vUj5rWzLiyAh/iirVd/g=;
 b=FZ7Kz0VreAaLxgxmRxW1zG5cBA/3nL8FRPCGIqb3kXhGxy760YMgay4PtkkXqm9d96g5YC7W8UEIWVNOcFS8bVMCOzuBrNOWj4JADlCWnJiqqwYyHsTvM036sjSwORudxJCLhHhxaI+EHrUNBBfLBszkQiNOfvbI9E8JA0TUw/pCGrN3Mc1HoGHjJDWuUs9/t9g6JYblg6VUvfX7SDKvwlEMfwIDEePQtqObTR7U9JVBCo9gZNmg65E2EQ7F+gxoVQGZdJkxnicv8BneA5VfpIQ1epTuFeA6hh5gi1DRXaE8BZBdaGUSeRqkhyK72UH9z2OLDrtg0zBJwTCsOSvGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RKI4B4peM8M4LPcDSPFvy7vUj5rWzLiyAh/iirVd/g=;
 b=VrNCzWRVprAEamb0bvUHy26XkqSTWsRYfX3PaTgKnoh0ZvRYU7637zZgbLh4zy7ZEZ8gzU3OmO7gmEmm94js6TzWIEuXf0ECo35coulV1xvAJIvIhDAYaLp6uKvkMlK47wiyviEMmac5acYqEX/f4POXER6EOIiLqJpTPyeKsvE=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by PH0PR07MB8717.namprd07.prod.outlook.com (2603:10b6:510:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 21:44:34 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 21:44:34 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "tj@kernel.org" <tj@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: general protection fault in blkg_destroy_all
Thread-Topic: general protection fault in blkg_destroy_all
Thread-Index: AQHZQkzQG+qnG8+3Oki/SPFOHFO4AQ==
Date:   Thu, 16 Feb 2023 21:44:34 +0000
Message-ID: <IA1PR07MB98303634E615F4051D13A5F3ABA09@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|PH0PR07MB8717:EE_
x-ms-office365-filtering-correlation-id: 2634d35b-82f2-4ca8-9ac2-08db1066fe91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+2v4NVk8GhB8dJCHz0WPhCC46FiFbYcxAld0A4WxO7TQuYINOKsM8Ep7Vt5rjkI9keFNi0+o36JsdRJYiX8vXAjXcgrIEGkSPmsW/aSwlttgB4Z0FvWeQ+RnPd/WhBrtzWvKjj+z6CtbuiJpxADwzHZUvIZr+RclD/QM0aszYhEaOYfW/w0PC/JoXp2hhdizsXdybgIV+4yCl5FvsEnZAPumVgWCXtqGo+ShZqeUmEoV7Kc6qHleHnXcH0ANMjHhZTRb8TPW5HW251/lrD7pzHs5jZaKzHR0pcSTWnVzCBXGKjsy0gfCX/msDz55ibssBcQyUsAEiAv1eSdQkVcXU7ZBsCCxmcEo9cCCrlR6yxr0Wk1zEBGUVqKp3SNDknJ5mcu8gEEKAyBA4250xVyP7xkSWIhIzriGkf8dl76hb73nVJ3gxy5oEwOPo3um5Fi8syvWf83jg4cE8XJjC2M3mSlLoQJkWMHj00zmAeHvvkKHoVz6rgU/wWHnrLoPoxsKTsIKS/Sb0jpnT9ZMVKjDUAoisBe7ttcgLmZHuTbTQYjlJqUJZQmg9moTHzyeQoPmG26PqHMfoq/2JzzL2V/pmiod651GeMA0bKl86aX2PlpYkcALTAWUCf28o7kAZfzhFQIeOGatRcTZZtJpVYfuFS7tbMpJLpd5YOMRkDP6//Y69ZSczQ5ivhsvXezWJqo/c+xkCUIdf9kxg6Bs9wFx5RIJPam7NWulGApDFTuQhk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(5930299012)(966005)(55016003)(83380400001)(86362001)(2906002)(44832011)(45080400002)(478600001)(33656002)(7696005)(71200400001)(6506007)(186003)(26005)(9686003)(122000001)(38070700005)(75432002)(38100700002)(66446008)(8936002)(41300700001)(4326008)(5660300002)(52536014)(41320700001)(8676002)(786003)(66476007)(66556008)(64756008)(66946007)(76116006)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z3u3xLN2BgxfBPMSABEvUChO+rI1i8thxj6WBd38u20WcUetFOfVBhjdIY?=
 =?iso-8859-1?Q?fKkC7C1vSr3UQpBWkmJ7dbmSx3tNYDEixcAmp5/ea3Dta9Tw58sbNMm/hd?=
 =?iso-8859-1?Q?IGv0vVs3zoYBo+rrX4FHRvwUtlEQJpancNHnWifvnlB+oNbA8C+biA+vS7?=
 =?iso-8859-1?Q?yqFna1Nj67VlePBKniXRwH9nQi0Yyga+JMmdBxWQUbTJiz0uaemxeTPMUH?=
 =?iso-8859-1?Q?J3/gLggixvXVVhCfEcOUjToHl3syA8IPhqxBSz4yA2w6pkgTrO2f6BPqE5?=
 =?iso-8859-1?Q?pXGoU5k66LgP8wOfBKvYbWK2Ou2KVZMq/7xNixXHrBkpg0PU7BjCVsP15y?=
 =?iso-8859-1?Q?ew45+njXac0KvMqNUj378phVaOZtp+lsIGufr7kZqGbUKn4t5L45WTa10C?=
 =?iso-8859-1?Q?tR9lpA1Gm3xNNx35Kw87l3dGqhJa6ux5GhI/UAYxQ+FUyX/olZgFzmGgHF?=
 =?iso-8859-1?Q?oykyI0WQ+0ddE+8Ld+HYDqkaXJtxC7021rakQodl45NlBvCqGht+F5AIJ8?=
 =?iso-8859-1?Q?OIWXuLRrBdI+SR+vl5lDcyiGmkqN9oi8zxqq1IXA7CFIsT6xbUxipr9nsr?=
 =?iso-8859-1?Q?bMzK8roqgq0wG9JwVSiH8crO/VHQBdDoEdp5uNdEf7Wm47gjKv5KWv0QGB?=
 =?iso-8859-1?Q?Os7Ck1gVOcpHvjNqnWK3I1demMaj5eF99G5A4cNvPSKudv7Ed/M3R7vDjB?=
 =?iso-8859-1?Q?8Hy9D7hefBbxBxZZ01pesWVF9THH4QUvO06as7SKTpnCb0oa4z9odrZRCl?=
 =?iso-8859-1?Q?InSN9CSbRW3YlHMzGNhHnXXf25l946p1jBVcDxGJ016afKneahJuheePut?=
 =?iso-8859-1?Q?m8hE2MEGIRVk1Ajl/Cy+czeRXm8I4hUTOTBuJHGZg5tQQauEHPWu/mSvcB?=
 =?iso-8859-1?Q?ltbCi3mouWBO0vMUlj4Cxmmf5Zh4K4PCP3hxpAsLQLOJptd8rPLeJ8txqK?=
 =?iso-8859-1?Q?5Gu2Ufzm4u6CPmofxZd+YE723aEMUrtmWgyuQR0aoalg8uqEg+zJJNZaWS?=
 =?iso-8859-1?Q?E25Ai8OSk6ydo6D5M0CeMuS9KP2L6tRI0vGkT0ImUYHGvOZR6Gks+usKkx?=
 =?iso-8859-1?Q?cvQl+JX4sCqhSdlvF9QqLm4Op+fsHfHEQOpMCZEgkwD1BhHQZvjuTMWkP0?=
 =?iso-8859-1?Q?/Lj3ndXl5ZTSo3vY5hv6CDByqt5GBtfBdXnADKc9mYGyxwJRHlyLvkR9iF?=
 =?iso-8859-1?Q?1s+IZstxduDFliJ/C/EsmkrHM3Y0YeLCZg0Nm/Dow6u4AljSeUovzadgaZ?=
 =?iso-8859-1?Q?0SbQ7ReVRa9Uww9eEyhXdJcnHjbBIjXuW091ThtxHhYMnD62cYk1BM7nMB?=
 =?iso-8859-1?Q?/dpuZSSpV/kFw+/o6Ji9aejhAedZfpqlU8y6/kSxZcNCIxRJny8YG6W0yH?=
 =?iso-8859-1?Q?Sg4GbmtyxtzRY77H1wrGqwQ1difXm55mwQbuZGLJpWYOGDAopWjOywYyDh?=
 =?iso-8859-1?Q?bJ2/vpPshTHgN477GT/+q9NvLtMtsaFA4oZaNNhGdUHvsnzfToVsMoab1f?=
 =?iso-8859-1?Q?xeT3nkMMv4PGDjfnBxoUmIfX07U6z+rcqYcmtlJUQ2BJrqLCk4sk2a8GpQ?=
 =?iso-8859-1?Q?h0UYk4SZFVw+3k5x4WaFddLrx6WCvy8S2/KkJx+KOCo7CDu/cxt8jb1FRw?=
 =?iso-8859-1?Q?1li+8RU1vXkZkZzArrfV+wNPVG2h4NQeuo9F0TGm1qOsc7hVnf5sPu4g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2634d35b-82f2-4ca8-9ac2-08db1066fe91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 21:44:34.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RD6BmvNtcESxHtA9EZ6m1tFeUVNJcXQslaPgrnG/sybFVvoEUTRkBSBGNYP7Kq+OX4aHh341sE52Wqe16noRtqHahKg6CJ8CFgw92uERjN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8717
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch: 6.2.0-rc7-next-20230213=0A=
Kernel config:=A0https://drive.google.com/file/d/1yVvlPL4-MMdjARqrwJ0QoKuPv=
_3lFQIR/view?usp=3Dshare_link=0A=
Unfortunately, we do not have a reproducer yet.=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0000: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]=0A=
CPU: 1 PID: 10907 Comm: syz-executor.3 Not tainted 6.2.0-rc7-next-20230213+=
 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:blkg_destroy_all+0xa5/0x260=0A=
Code: 7d c0 e8 7e 65 27 06 48 8b 45 b8 80 38 00 0f 85 a8 01 00 00 48 8b 45 =
c8 48 8b 98 80 05 00 00 4c 8d 63 f8 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 0=
f 85 7a 01 00 00 48 8b 03 48 39 5d d0 4c 8d 78 f8=0A=
RSP: 0018:ffffc9001ca5fcb8 EFLAGS: 00010056=0A=
=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8168f15d=0A=
RDX: 1ffff11021b6cc29 RSI: 0000000000000004 RDI: ffffc9001ca5fc18=0A=
RBP: ffffc9001ca5fd08 R08: 0000000000000001 R09: 0000000000000003=0A=
R10: fffff5200394bf83 R11: 0000000000000001 R12: fffffffffffffff8=0A=
R13: dffffc0000000000 R14: ffffffff8ae21700 R15: ffff888080ff1090=0A=
FS:  00007f21d3837700(0000) GS:ffff88811a080000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fb7b4ffcbd8 CR3: 00000001118c3000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 blkcg_exit_disk+0x1a/0x60=0A=
 disk_release+0xec/0x4a0=0A=
 device_release+0xae/0x250=0A=
 kobject_put+0x1d8/0x2c0=0A=
 put_device+0x24/0x30=0A=
 put_disk+0x49/0x60=0A=
 loop_add+0x91f/0xb20=0A=
 loop_control_ioctl+0x13d/0x690=0A=
 __x64_sys_ioctl+0x1a9/0x220=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f21d268edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f21d3836bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 00007f21d27bbf80 RCX: 00007f21d268edcd=0A=
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000004=0A=
RBP: 00007f21d26fc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007ffc7837a81f R14: 00007ffc7837a9c0 R15: 00007f21d3836d80=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:blkg_destroy_all+0xa5/0x260=0A=
Code: 7d c0 e8 7e 65 27 06 48 8b 45 b8 80 38 00 0f 85 a8 01 00 00 48 8b 45 =
c8 48 8b 98 80 05 00 00 4c 8d 63 f8 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 0=
f 85 7a 01 00 00 48 8b 03 48 39 5d d0 4c 8d 78 f8=0A=
RSP: 0018:ffffc9001ca5fcb8 EFLAGS: 00010056=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8168f15d=0A=
RDX: 1ffff11021b6cc29 RSI: 0000000000000004 RDI: ffffc9001ca5fc18=0A=
RBP: ffffc9001ca5fd08 R08: 0000000000000001 R09: 0000000000000003=0A=
R10: fffff5200394bf83 R11: 0000000000000001 R12: fffffffffffffff8=0A=
R13: dffffc0000000000 R14: ffffffff8ae21700 R15: ffff888080ff1090=0A=
FS:  00007f21d3837700(0000) GS:ffff88811a080000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fb7b4ffcbd8 CR3: 00000001118c3000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0:	7d c0                	jge    0xffffffc2=0A=
   2:	e8 7e 65 27 06       	call   0x6276585=0A=
   7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax=0A=
   b:	80 38 00             	cmpb   $0x0,(%rax)=0A=
   e:	0f 85 a8 01 00 00    	jne    0x1bc=0A=
  14:	48 8b 45 c8          	mov    -0x38(%rbp),%rax=0A=
  18:	48 8b 98 80 05 00 00 	mov    0x580(%rax),%rbx=0A=
  1f:	4c 8d 63 f8          	lea    -0x8(%rbx),%r12=0A=
  23:	48 89 d8             	mov    %rbx,%rax=0A=
  26:	48 c1 e8 03          	shr    $0x3,%rax=0A=
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruct=
ion=0A=
  2f:	0f 85 7a 01 00 00    	jne    0x1af=0A=
  35:	48 8b 03             	mov    (%rbx),%rax=0A=
  38:	48 39 5d d0          	cmp    %rbx,-0x30(%rbp)=0A=
  3c:	4c 8d 78 f8          	lea    -0x8(%rax),%r15=0A=
