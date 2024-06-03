Return-Path: <cgroups+bounces-3066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3598D7E2A
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D021C20D54
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470E76F17;
	Mon,  3 Jun 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iwdt8afL"
X-Original-To: cgroups@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3835EE80;
	Mon,  3 Jun 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405850; cv=fail; b=Ee4BDxvzvyrZ5ybsjuxxikG0aWiQITGePJlc+1lLpZW3L5iI1BZYDvQUtJtpq5/aPj6Ebrnc1EUwCsWyOEObqB5/do24q4hh1IFMK+Mc9x6cItJoOa/5F1y0We4ejLPM7CiPG2Y9nN5PCJY54YYvWn49k3Ne4sQo1FnuZOIcbJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405850; c=relaxed/simple;
	bh=D36ygDVmN4AeH9XqX1kfCDTkpJKb6mEowSanajJiYBk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZwKmFrthrguaF16lQE8Cfpoguw/Dw7ykZPBxlkaqECsfUW/Em38fG8d4+iQ6PbfdY4LAlU+aMrl79f0CIZrcXlUvxB4jKh4WbcEpx0uxdzby2rNqpO/GK3FXO9wEJwNVfpJbQao9lA7NmVvjG3X5OeI6Ec0kLqR9RAC4YDDgV6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iwdt8afL; arc=fail smtp.client-ip=40.107.7.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoGEW4dofVDyYZwXZlDjb8mIFkknWtfUnY8n78t3CE2mFzWTO4B6bFApAuz7M+ADJf8FmZuqmT5+TYSMIwELxEWDeTO+FvZnaKH6NdNjEKKsQ8g9CAnLw81u+bU5R6z/8gkdGsubIzrI9096c1ma6//McQdvEbTi6BJGjeql9edMYJrOuXTSfyzPzJkyBrPp/G4N/VT0KfYSRqXv+GIqHGUPQfvJZWyLaBLEAJXM30ZKdWmrEnZ8+45Wrd2LNWln/1fPYU+tkuAYhgxGEISZigcMEDbNfpG5o+27IspykdaLYErzG5n2km1E+TSdTFnWiYURb3XmzOXsHNT/S3bjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsXGi8LHjr9EuQJhNkbW5FoGyfpuo9vKYz4Xo9Vt79M=;
 b=KmcmpFNPsIsJr4QPWDjDMLnEU+BJTX4HJ+H5AJ3NlAprAyyq2SyxtCiVyGGWLJrj+u4wPAaKMxQKJ6JHYciyNYtdhe5rTQ/nyX0WToUpcO2gTp6Jx9wOouiSFVrgeP12VHQDXao572XnJQM3B0xz6UNWqEOQ9qGdP9ot9ZHn2+qDgx97+Ofp546Qfwn2IaysyjJ3hd0VqwAPqoPyTgnQxBqfK/eRHGzOqr7QwjiPL18HHw9yvWq7vsMUwSAQw5vE8TPxLUXoYdpqJJ1wdn0vJND1kPiaYacRRmR15/9i/hOsvoXONjdbRKPJPudTtyjRxuXDGxOVA5TY8HjcBfL8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsXGi8LHjr9EuQJhNkbW5FoGyfpuo9vKYz4Xo9Vt79M=;
 b=Iwdt8afLqqb/gdVxatTemVR/LRypoaCHobZHzx9QqQBjcs+SIzud3L24ntuJgYohto8vtz0RHfufa/83/xRTcUINJ5SKuc3CHD+DGfUpDZOVu3I6aU4k4ZC9c29C6VUxImeWTwMyYDqpYu58A+3HzfpOotb7huIYgmQa2E91FSo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8074.eurprd04.prod.outlook.com (2603:10a6:10:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 09:10:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:10:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"ast@kernel.org" <ast@kernel.org>, "zlim.lnx@gmail.com" <zlim.lnx@gmail.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>, "shakeelb@google.com"
	<shakeelb@google.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>
Subject: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xffff
Thread-Topic: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xffff
Thread-Index: Adq1lSXxP1MKnpdwTLWYSVpJsSrmhg==
Date: Mon, 3 Jun 2024 09:10:43 +0000
Message-ID:
 <DU0PR04MB941765BD4422D30FBDCFC1C388FF2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8074:EE_
x-ms-office365-filtering-correlation-id: ad0e7150-5647-4758-d13c-08dc83ad0c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HAFkpU7yh0rs7FwbR/GFs2VNJaqOV0CgEgsR0gHKAbhYjxn6WQCh4Spzfx5s?=
 =?us-ascii?Q?p8xV852F4jhM7hHpFpgU72lq5z9LCtpewv25Vx86VuIPVZN2fImbIzm9naEw?=
 =?us-ascii?Q?GZ9o/UV88NUkv3w4FzQSnVKg0pn9SMgMjKh1/TkRySdaknpR611lgTwriLqm?=
 =?us-ascii?Q?fvIHRtWEJ69j4E9lbul0rwnzE8P+VLZw05iYMcLSmuvhea2b347Dw/GlLkDK?=
 =?us-ascii?Q?aV2u/YDtsuV1zgVhHvA1T71jBnpSyTWwl8hrI9a8+KZtcJtN4DbpqLLYuLnj?=
 =?us-ascii?Q?gJFOyq618YETevqvCD+Xc3XBYGyquhEhfkAjtlGiTrvUbPDvDqcZBU0mswKb?=
 =?us-ascii?Q?cu5DVMQ8K44Im0bWXcsITHJoA5UjSBpRloRMOvnkOEryQZx+6/vwhfn75IYX?=
 =?us-ascii?Q?rCQdr1XtFLuDi7wzsz/BQGoJV8UEJV9pEiVmgY/rfVV3gL1wO66JEXe5rUzo?=
 =?us-ascii?Q?dhKl/ss50w6wZOSH1NeDmq/HBnl7hH8oSLLXnI/K7i3yaJA3mcHPp69FHva0?=
 =?us-ascii?Q?izCIuVzAOm+1DB/i7jfIiFcCUj/jFMEs+bG6ERfVFZcOIMc8g75aFFfXcTj9?=
 =?us-ascii?Q?Ci5dleFZpF8fWzJXlRa26tapVSn6lbvqhH7lQT2NtkWbIujTaO07r4c90vEr?=
 =?us-ascii?Q?ogKUYP/FnEtjxj6S0ci3yfOe7GzpyCu7Oq81a+JCF3GXb/foeO1kv+3vdonT?=
 =?us-ascii?Q?urtBfGNjRv4N/OT+9IgRaqRtuzGZz5Flg2Py25kLSrok2d8WRT0ByFu5k0J8?=
 =?us-ascii?Q?XvbmMcUL0qElsaZIGFJ2SFTSs9HWSbcS01wjqNB/QCXcPUHxyAgt3MgBP1V2?=
 =?us-ascii?Q?lZP4sBr1quys4n2SxjUvsHWVIhUIeTGwSG0kL0amRAlSyeUY0dV/TWDgavJ8?=
 =?us-ascii?Q?lhfOX7LTgoFLjLeBKJYrgm8a4veYE1umvLrsl20aKgbCZxBvhQLY7AaTyl1D?=
 =?us-ascii?Q?7QfotN8fqeRdYVvMgQqvh8ILtczW6ubJggxAgLq2DayKhtzEdVW0yiKv/qRI?=
 =?us-ascii?Q?wRh6mrFEMG7pX1vHRMR74EvkJIwNCqwkzTMtLfQx9yLXpsNceTsU6aXUZHN6?=
 =?us-ascii?Q?oL54vlSqgKicMPx2bRZ4dxP/QKrPVwQqSPe0fuoDlQK8TBrSprLmToT4RK3H?=
 =?us-ascii?Q?Zk22mRvmdhJ3efbxvPSx9/ejN4lkUb+1e9VNm8nlTgKiDoAF8Np/+BUHq3AW?=
 =?us-ascii?Q?y+qX92tqXEdmMU5TGNQ8lTLfevPwSzsJ2LWe0qoHADPLIKAQ+Nspz8/xYLf3?=
 =?us-ascii?Q?Kntt23Lulb2MNJYvjz4AObZXOchn1KHB5H64SnJKLpL7BW2UevW3cImLhL7J?=
 =?us-ascii?Q?RAziGt3x61gJ9L203D5CfXlzhmORt2SpYqUYgUgQIH3WczrbLG7vrTimwWQx?=
 =?us-ascii?Q?geWZCgo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I/lbR2stt2mFsqd8yBogLeZ0vfiAWxsF28a8xqzZy6bjEwDaMP/w2F+pDImg?=
 =?us-ascii?Q?Hu0SfSSoJi1sjUO3rCbvWVomGu/xIYktZZXX2j69nb5AMUMhaAw/+uK8bV7Z?=
 =?us-ascii?Q?mLePaITtHzds7vsf7CiGgfRezyR5aqCoroBTKPAO/Afvp606vMZHS/W/LWsq?=
 =?us-ascii?Q?GVaey4akDaZsr/iZmHdJoiF9EcjH/NVAKR/Ckve/XVxouWHKpDBJ2+F5P0H0?=
 =?us-ascii?Q?u0eMwtPON/nAqJjGdnuirTLvtVibS+4Udxv9lE12H7kj9JLIeIBTkULR1sfw?=
 =?us-ascii?Q?gjO14X4RWKAT1NNk1If50igJ8SXMXox1dAlwDnyVbkPgpw/ArWrc9Hkj8GpC?=
 =?us-ascii?Q?CZcyMpkiAqbrJ+VC0jYH/uoR0EVAUm/1+qY7DYFvvJD93xBHly15W7DYRPqE?=
 =?us-ascii?Q?V+mwUVcZeu5RKtFIG7CXk/zbmdhANr26KsVqYmsxZRAAJ+rPbmiSygKhFvlK?=
 =?us-ascii?Q?IILIimY3r6WYG5pQezUiyOsQGTOdfx2kyYY4ywlQJaqeDPo92jMKPnkraNwb?=
 =?us-ascii?Q?O5N8Uh6I+sOtq5AHhkwtEOgIoih5+u+tKuh6yPZioD6dktnYbo74QwbDDdRx?=
 =?us-ascii?Q?aTFWM+LT7rLR6WT16gjMQYXn7ZhSHKu6NSYPFJNeH3GPNrG8VCr0gG9RiVRm?=
 =?us-ascii?Q?zZrbVeO7XlGJQN0mMPr4CnBhi0+5FilbCurGXbrD+ivqFHQB2F+j7Fr1+yG7?=
 =?us-ascii?Q?3+S1JbXMUjgPvifWNdbAEojGs+q10vq85gQcRdIDAib+zyD/mGNY3ngwsqpj?=
 =?us-ascii?Q?vhWlTJGsZN/J8glfvC08DXl4GTBbtnonMRPYi2kSFeTlcmvxRO2H37Xtrfdl?=
 =?us-ascii?Q?T8MtXGgBQa4jvdFlGrdttQWt0lenMhGZDlQ+mG8U725Rsc3fWcU+xy3pl8g7?=
 =?us-ascii?Q?jkTQrPoxrsEahqZ+mir3lUzX3zGmoRRLvCmJ7Zj20Ry4QTL3VXQYtQQbMQeM?=
 =?us-ascii?Q?7nc6fjst60wsp593kW2EAaRR8DfLZ0R6rONOI6LsLH1PtIXBwfPI+YuTZIyC?=
 =?us-ascii?Q?hZE3BZlr3jr1czlr31RaANT70dfd3b6WkeNwe4k1Hb3FY3PPIHl8sdtcRhjT?=
 =?us-ascii?Q?Uw9uBwwG68V/Ip9bTKPUxptCMY5SWtAmif/eXMxFehf6J010d2UHFNH4IV4U?=
 =?us-ascii?Q?v5djl5xx7IYgGIRLkaQdw0xMlpWWktYGhLjPUR68qVPlG90IaAse72vuBBQB?=
 =?us-ascii?Q?qwQku7M5Ugg4GDzVLNFP9clDhvc4CoF1ndPp/NknktysrhKY9rB//F7Ol3aH?=
 =?us-ascii?Q?EbKcvKII37nTJ614C4CpBKtqZMXkjbtO8C0Ci484pLUdeUHvatNbeRMYq7TI?=
 =?us-ascii?Q?/wI/fVfGKxIKpf9qYYpHdoYTtHvi5dHJGN+p4iQbmQRo8Cw81HXOWLO7WLqi?=
 =?us-ascii?Q?+SRR2gj01MTjE7FZxvk0AoBCTtE4+IVkdfLFVUs2Rii5zOYlTu+8CQywFaRX?=
 =?us-ascii?Q?2fMWxJOLK/z/JoRFDLjH/kXFmLxubWZTXWOhOb9jxlwoBsX+omqwi4n8cI/h?=
 =?us-ascii?Q?w0AB1qzWmhJdR5kLN1kle9AsqlvitCN7oDjSSW8D2jlqRzN59IMfFS4fofrm?=
 =?us-ascii?Q?dH3zwSmQJTLF++SAlKg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0e7150-5647-4758-d13c-08dc83ad0c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:10:43.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKEGCi8rDukILHnCYN4yORFeVcbD+p/G62afjb1lZNkavZNH2oyqzbHHHDgsLgAAyXbDqknB1xe1LrC6U53vfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8074

Hi All,

We are running 6.6 kernel on NXP i.MX95 platform, and meet an issue very
hard to reproduce. Panic log in the end. I check the registers and source c=
ode.

static inline struct obj_cgroup *__folio_objcg(struct folio *folio)        =
                        =20
{                                                                          =
                        =20
        unsigned long memcg_data =3D folio->memcg_data;                    =
                          =20
                                                                           =
                        =20
        VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);                    =
                        =20
        VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);            =
                        =20
        VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);           =
                        =20
                                                                           =
                        =20
        return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK); =
                        =20
} =20

the memcg_data is 0xffff in register x1. This seems a invalid value.
Register x0 is x1 & ~3.
The panic happens in the PC: ffff800080305894, which is 'ldr     x0, [x0, #=
16]'
I not have an good idea on how to fix the issue, please suggest if you have=
 time
to give a look.

[   12.843675] Unable to handle kernel paging request at virtual address 00=
0000000001000c
[   12.849981] audit: type=3D1334 audit(1709988536.322:30): prog-id=3D3 op=
=3DUNLOAD
[   12.857888] Mem abort info:
[   12.867630]   ESR =3D 0x0000000096000004
[   12.871368]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   12.876675]   SET =3D 0, FnV =3D 0
[   12.879732]   EA =3D 0, S1PTW =3D 0
[   12.882860]   FSC =3D 0x04: level 0 translation fault
[   12.887730] Data abort info:
[   12.890599]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[   12.896076]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   12.901120]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   12.906424] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000001008de000
[   12.912854] [000000000001000c] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[   12.919642] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   12.925900] Modules linked in:
[   12.928942] CPU: 4 PID: 131 Comm: kworker/4:2 Not tainted 6.6.23-06226-g=
41e0f501b547-dirty #248
[   12.937625] Hardware name: NXP i.MX95 19X19 board (DT)
[   12.942748] Workqueue: events bpf_prog_free_deferred
[   12.947713] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   12.954663] pc : vfree+0x114/0x2e0
[   12.958060] lr : vfree+0x78/0x2e0
[   12.961362] sp : ffff80008459bd10
[   12.964664] x29: ffff80008459bd10 x28: 0000000000000000 x27: 00000000000=
00000
[   12.969128] watchdog: watchdog0: watchdog did not stop!
[   12.971788] x26: 0000000000000000 x25: ffff0000808b5a00 x24: ffff0000800=
90805
[   12.971795] x23: ffff000084bcdc08 x22: 0000000000000000 x21: ffff0000849=
3c6c0
[   12.971802] x20: fffffc000100005e x19: 0000000000000000 x18: 00000000000=
00000
[   12.971808] x17: ffff800084ec1000 x16: ffff00008465f208
[   12.991063] systemd-shutdown[1]: Using hardware watchdog 'i.MX7ULP watch=
dog timer', version 0, device /dev/watchdog0
[   12.991246]  x15: 0000000000000000
[   13.017453] x14: 0000000000000000 x13: ffff80008f001000 x12: ffff0000846=
47a00
[   13.024577] x11: ffff000080b9d1f8 x10: ffff0000846479d8 x9 : ffff8000803=
057f8
[   13.031701] x8 : ffff80008459bcf0 x7 : 0000000000000001 x6 : ffff800082b=
84d38
[   13.038825] x5 : 0000000000000000 x4 : 0000000080000000 x3 : ffff8000837=
7d000
[   13.045949] x2 : 0000000000000001 x1 : 000000000000ffff x0 : 00000000000=
0fffc
[   13.047210] systemd-shutdown[1]: Watchdog running with a timeout of 1min=
.
[   13.053073] Call trace:
[   13.053076]  vfree+0x114/0x2e0
[   13.053083]  bpf_jit_free+0x54/0xb8
[   13.068804]  bpf_prog_free_deferred+0x16c/0x1a0
[   13.073328]  process_one_work+0x148/0x3b8
[   13.077332]  worker_thread+0x32c/0x450
[   13.081076]  kthread+0x11c/0x128
[   13.084300]  ret_from_fork+0x10/0x20
[   13.087874] Code: a9425bf5 a8c57bfd d50323bf d65f03c0 (f9400800)


Part of the objdump code:
ffff8000803057f4:       97f8c73d        bl      ffff8000801374e8 <__rcu_rea=
d_lock>                 =20
ffff8000803057f8:       f9400681        ldr     x1, [x20, #8]              =
                        =20
ffff8000803057fc:       d1000420        sub     x0, x1, #0x1               =
                        =20
ffff800080305800:       f240003f        tst     x1, #0x1                   =
                        =20
ffff800080305804:       9a941000        csel    x0, x0, x20, ne  // ne =3D =
any                       =20
ffff800080305808:       f9401c01        ldr     x1, [x0, #56]              =
                        =20
ffff80008030580c:       927ef420        and     x0, x1, #0xfffffffffffffffc=
                        =20
ffff800080305810:       37080421        tbnz    w1, #1, ffff800080305894 <v=
free+0x114>             =20
ffff800080305814:       b40000e0        cbz     x0, ffff800080305830 <vfree=
+0xb0>                  =20
ffff800080305818:       d53b4236        mrs     x22, daif                  =
                        =20
ffff80008030581c:       d50343df        msr     daifset, #0x3              =
                        =20
ffff800080305820:       12800002        mov     w2, #0xffffffff            =
     // #-1             =20
ffff800080305824:       528005c1        mov     w1, #0x2e                  =
     // #46             =20
ffff800080305828:       94015eac        bl      ffff80008035d2d8 <__mod_mem=
cg_state>               =20
ffff80008030582c:       d51b4236        msr     daif, x22                  =
                        =20
ffff800080305830:       97f8eafa        bl      ffff800080140418 <__rcu_rea=
d_unlock>               =20
ffff800080305834:       aa1403e0        mov     x0, x20                    =
                        =20
ffff800080305838:       52800001        mov     w1, #0x0                   =
     // #0              =20
ffff80008030583c:       94001847        bl      ffff80008030b958 <__free_pa=
ges>                    =20
ffff800080305840:       11000673        add     w19, w19, #0x1             =
                        =20
ffff800080305844:       b9402ea0        ldr     w0, [x21, #44]             =
                        =20
ffff800080305848:       f94012a1        ldr     x1, [x21, #32]             =
       =20
......
ffff80008030588c:       d50323bf        autiasp                            =
                        =20
ffff800080305890:       d65f03c0        ret                                =
                        =20
ffff800080305894:       f9400800        ldr     x0, [x0, #16]              =
                        =20
ffff800080305898:       17ffffdf        b       ffff800080305814 <vfree+0x9=
4>                      =20
ffff80008030589c:       a90363f7        stp     x23, x24, [sp, #48]   =20

Thanks
Peng.      =20

