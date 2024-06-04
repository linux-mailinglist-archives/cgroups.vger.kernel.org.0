Return-Path: <cgroups+bounces-3094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D18FB63F
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 16:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5491F21EF3
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1713CA9A;
	Tue,  4 Jun 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cM9cZw1V"
X-Original-To: cgroups@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5E2AEFE;
	Tue,  4 Jun 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512747; cv=fail; b=ciGKo5KrEWLRR2TpgNExEv9FyIz+zG8+gpCB3F2oEq84u88Fjx7/MTo9mGA0uOGVs+3RX+U07iq/b7F+wWBLlvInwyeqMblJGN1uUXaun55dTXtNQ2KPeeW0YN6lDPYO/0qRvI/qDYSbN/Dhh4PgdHNNmHjKNdr6lV3lxXgrnMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512747; c=relaxed/simple;
	bh=fkE/81HkFF1aniCVAjGRDqfjRJXovDq4Eebygetkkjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y11uKKjxSziITKfPULlKBR26ekuHLU2r83TTbtzNvBCWJbDnBM+hVsOAcI6hHtZj8AjzmrXkXzOadRmwirTfU+JFaOGO543/8zXYRZY5tsiFqAsLwmx9pcN1FJzFUrUkfmKNZFxSlD3ikTbXayahdJBwBcL/3mtu913bL1fR9Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cM9cZw1V; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0E2SVk5vt3XGFXKrIMJsJotCej4+2luXJlPJUkA5hWcx2An+g4GjiaFn/R3beNmSbeguxexncuLe0j7YOhkXOiTTDhnB/cFqly081Rjxp2UrQIzPjc1S6OJQA4A6vOYNcK1U2XksVZ78UrGoz0YqIcQV15W4goasS57FWCHlT9hjMNGRhyHykJJWSpcbzu0OwY2EKhYDO3aV+VJwTh6LVVVLmuya9anzRGwYkBBObYO6Lazw+zl9tDMTMF8YSlBq4XJ36Dwgf77dytqAR/5ozowy4i73N4j+RQgqzFSuomvO2jVssNM2DsIn8cl/ivfIKZzgr2jJu4EmeqAj+LQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMzU00sXnd7dIadmY/dt7wjI3HCKLZFGPbs3K/eKf0E=;
 b=AYD2SEoOidlXJngRg3uC9zqqWdjRmQs+pcbYm3UkSzrURljt7VvZJr+eQkfsSoMB7aA0fFJovjn/YJD6K+dCSiUgCwfsk5+Fs9e/lv3ZGIy5dUSxBbQxqwRQAYSVqf8Rs4+purN5mpcW7Nzfduree+CWD+YyxRM1fV5+hjNewtux7YC8+acvZeplDRMQsRGOEAo1SayfsWWiFRnyeluHUZbhZ+93eCPjmFHnD/a4hQQVOLMkln80r4Fc5JiPZgAvINCyLmgFejV9cPfm7VbZqZrRbl/7HrVYOxlRXUIolwQnOumjVnxDpUCpRUnvAa4KxQsnEe05XmCjkvYdfdwTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMzU00sXnd7dIadmY/dt7wjI3HCKLZFGPbs3K/eKf0E=;
 b=cM9cZw1Vfb9wrVNYpUP4TR9IkO+QV69vZ1vpp9BWALvSmZTgMDz2kvg6wgLYmJtIqbCEVxyNUtEYqrafATgc9MT++x/CekL50FIj6uxVtqNBAFDAKQ9/ibV6H4Ohf9t0HrxUIEZH2q3PwlIqBuOk0WUeCtGf1L2Lyi2prQsYbWE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8705.eurprd04.prod.outlook.com (2603:10a6:20b:428::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:52:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:52:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Roman Gushchin <roman.gushchin@linux.dev>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"ast@kernel.org" <ast@kernel.org>, "zlim.lnx@gmail.com" <zlim.lnx@gmail.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"shakeelb@google.com" <shakeelb@google.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>
Subject: RE: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xffff
Thread-Topic: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xffff
Thread-Index: Adq1lSXxP1MKnpdwTLWYSVpJsSrmhgAhBYsAAAL/UTAAGlR7UA==
Date: Tue, 4 Jun 2024 14:52:22 +0000
Message-ID:
 <DU0PR04MB94175107A302C23A99F28D8388F82@DU0PR04MB9417.eurprd04.prod.outlook.com>
References:
 <DU0PR04MB941765BD4422D30FBDCFC1C388FF2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zl5k5ky1b6XFaPD9@P9FQF9L96D>
 <DU0PR04MB9417DEFCECEC13149ACAEB0B88F82@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB9417DEFCECEC13149ACAEB0B88F82@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8705:EE_
x-ms-office365-filtering-correlation-id: 8b17c206-f4b1-4807-3e7e-08dc84a5f0b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fWXZnigzvNoh+/kK1X0U0hrOkwDGfbMF0AhccEHwUT5eutb5aH6mth5H2+s5?=
 =?us-ascii?Q?L16cCdbwVKmGfTal6Nz4rBPuabjs/3Im9dk5C2b1K4iNYkLqUwVRL223FN/E?=
 =?us-ascii?Q?GlqQAchYNhF1+dcs5+7d3xGc5zBY2d8d/42/vckYS5aQEJmyinQrM7fe+jyZ?=
 =?us-ascii?Q?XjLe0a5R1DWQtzShol6yt3SUBfT9JRvOUfruUMIUCK9Ln/UIOKlWj3bXv64r?=
 =?us-ascii?Q?EAVh2jjV1uEDdCv9pAh9brf3Ya8Isj7sEt44zcSAni2780+6aPwUrrsSd1XX?=
 =?us-ascii?Q?YlGKfTTvFQZQicmvZPVcU/mvVsRkXptkriliaYLlihuJaaUM8E8LBpJi1hyW?=
 =?us-ascii?Q?W/hXMl9D1vZQKV9d9NNiMEx49qIjEznHn0CxcIZDDoE2bLCflaQRXUiOoeAu?=
 =?us-ascii?Q?qTm52yZy1k0Fh6x9edb9sG/BAzxtFEYZD7+VPFv+dVwvtBCILB38duofLKFB?=
 =?us-ascii?Q?w6W5foQCuqyMucvGdkTO4JCGywdbTgJeUOYywWuQp+AY9RjsCNKmuG5CHuTR?=
 =?us-ascii?Q?nCxl3dwgLQAJZpzaQUcpjIJlau6ebKSnFrfrE24QMLWs6pIstlTCWxhpqpPn?=
 =?us-ascii?Q?gmSZYpc6WytHQR0jR2dpe6MZw/8AQB5nOy/LSIuZC831N1eOC+Sr00kghuIr?=
 =?us-ascii?Q?n5GoTGEGkvn0roXx4YfdVKf86bCqUXewNt5ZaeTIlvSXqX5xVH++NVf3cjr5?=
 =?us-ascii?Q?nCeQ+HVNQg4Ef0bHjb/8K8sjWFVP4PjuzCZJn/dsO0/KziSy8cPaEMqlmzQr?=
 =?us-ascii?Q?QgTu7OWqkyvWlJzu1RwHm/6CPa3ZE+cnvNz6wxtWI/ghQsv8QDMigz4seiq1?=
 =?us-ascii?Q?3o65sf5+M44DAmA4WRYS5J+sgIAm/aeK5elFznlWDaipNQsn0SJPsyr4xf8A?=
 =?us-ascii?Q?fSsR49490wTEFBDxiGQKeE+qH6YoE2mXkNboXytHQzsv2thzwIXFOY4oh5UK?=
 =?us-ascii?Q?lNZpQmxhct8IR+POeHGJmRoPYMKwdr3k2IdO+nZUqFW+svWjTvt7BchD0Hbi?=
 =?us-ascii?Q?llaTJLWCnrokc6MzyEEeDWQDf6E7t6lJgE0ZmJKd8en8BAT9uR1rD5zKzqHk?=
 =?us-ascii?Q?/lwtNiV6HEMbZ5H8PTwpQv15CcBskf0zJUshso14H7MUaQDnWs39N/XUmy6A?=
 =?us-ascii?Q?SBN8CXkKvQiPB+pdTCZS2crrPsgJMYoNhm+20AlhAji/DUJCjyiJxgbmTFGt?=
 =?us-ascii?Q?Lm2LUXEh+0Ni8bDMAy/Ef4/h2uD73Sl9Vg3DhLukF4UmzsQ4G0DQo56Fct/6?=
 =?us-ascii?Q?2NENpveagulZp6w10jLIlFSB6Rc0tT4fy4/8Ruh5QTYmw84t7LL0vLoLU64N?=
 =?us-ascii?Q?k/PYmhDc/ht7DUo7sA01zZn0M8FFsY8UsOAkyoa6CEb1Hg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QkE3lN7PVLYDYfdQjp2d9DEYKoK3npbJeE4/trFTyqfKEpbPXyD8uWUMG+fb?=
 =?us-ascii?Q?ePpZzzSvN+oF0TUxnpDDA7+cD/assWP6kSQFL1yBUWKg0JKLCN0RjHLQoBD/?=
 =?us-ascii?Q?tgqdc0oyvs1Z1no7rq471oMo1YXpx0J5Rmj8t6uLBlE6Qeg5GHVFSp5C1Akh?=
 =?us-ascii?Q?322+2ieFAunxGwq1/iOuSclZrmjsak+sSUekTQk+i31a9GZmH2bAd6yLsJHB?=
 =?us-ascii?Q?BNsQ+QBWfGn7KYmZ4AdnzRQebIZFrubkGvV3RNZK0U4rYRCBK2oFN+QQj2Ma?=
 =?us-ascii?Q?TWsfygCiS8AwULqQB6pjtyAI1PCV6NZIQjczk/giYaklX/aCWxBujm0PdhC+?=
 =?us-ascii?Q?ovn8BsHMcY2ztI5txQsUDqw0dNavSN4ktfBCjMFNEJSTJqZ8TibdnYVvzU01?=
 =?us-ascii?Q?J9p15H6X5PO8dT8F1nTk97CxxSwslf75Jg0/64EUt+CiDfAllyilwIvMbruv?=
 =?us-ascii?Q?ILh/BdsC0t8JVSsBvqBxK/IcVJTdLybXPs6YrhbkJ/M8DnPI+VvSXZjJ/mxB?=
 =?us-ascii?Q?awxTWbx8Y2ThOTKpWb+PWF7QsNHfqOKZNr+9oAnb8GnqQZbVXd8o/UJsnrBV?=
 =?us-ascii?Q?mNPa3pL7npLg3I3orbpBYAp6qwBciUNlzx51Fufcdu2mgs3bMmH3/Yjg33t0?=
 =?us-ascii?Q?khMOSQaVXlGnPp1Qo5wYdOfoowdBE/8tej57mnA+k4K+9gEk0ABTEhyvcM93?=
 =?us-ascii?Q?WTfY9u50ThZPTcd7nW6V9kLtmLX9XRPNZE6RiPhp2RPRfPcgpuKCPhl2rgyT?=
 =?us-ascii?Q?vu36aFCa8CxvuvvEaGssIN3Q9kKQBc7ezPwi1Oj/JhJNyFansx5r4B/rC4LO?=
 =?us-ascii?Q?wUWm554S1ntO99HSLj0eGWjGlceOP+7xiq3QEe+HorK8t83xO87GTIwo+mPm?=
 =?us-ascii?Q?Dx5C6cx3bW6IkQP/PQmyTWP3SKuO83lHEEPq3owT76uiscDaAVf9Ec30mHRq?=
 =?us-ascii?Q?MAk/xKCoc302eDZ42rEEK/eOkNWSvBPfbZgp4Fw0wjo+1cF9oa40g8IgG7UH?=
 =?us-ascii?Q?8obRaQ5KbgRCS/T8eSFvg3MJhQUY/GN1LHs8SKPviWtWIrWjLoyn6VnBy11j?=
 =?us-ascii?Q?Im3WZpC/ZvZIoYjulhe9x6+64phle2YR5LTycBYis69wBewDKXQWbN1up9Y6?=
 =?us-ascii?Q?/GDUjg8bdVnNNonx7ClzUqCmsFtwISjjSBsQujsDWTi9pZ7oazEq0B93bq9q?=
 =?us-ascii?Q?NX5J3dAw38AT90fZJPO7tdCcrfgZYkoOKcFLCIC//RmmSbnzoBBDQW3TDTnq?=
 =?us-ascii?Q?9nIMqHxKdxbFg3cXU8wghBXxSjNrz/OTotLncaPdg5+3ybdEaJTiaNpLr2Mr?=
 =?us-ascii?Q?4TLZCRLCbQ9x5C+yr4ACZ751GiAwJT5EFnhU9A+qOAaD8rKVbwiuOAMG9t0c?=
 =?us-ascii?Q?tLAYmXRvvKTka49teuPJfEbRzDYZo3FnB25s7kBPoqS3jYX/UnflX0Zee0VT?=
 =?us-ascii?Q?Jxj9VatGmLaFh1gehFbIro+TlpfsfDHnB99KFeBXD450te+2vVTNuRKFbUqO?=
 =?us-ascii?Q?3ZLgMuLD0/5PQ73D8mptYWo35VwYRt97C2XXLCN4y54rCS6yJDYI6h41uGq4?=
 =?us-ascii?Q?R7NOkol8wJ3iyVUmRxs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b17c206-f4b1-4807-3e7e-08dc84a5f0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 14:52:22.1745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /se/VNqT2oPOHMlVTHVfqFYI9GCpUuQmCVQOqHNVng1CnFvfyCVugTSYeCkPJxmIjilROCu2UX+sHCanAVIhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8705

> Subject: RE: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xf=
fff
>=20
> Hi Roman,
>=20
> > Subject: Re: [Oops] vfree abort in bpf_jit_free with memcg_data value
> > 0xffff
> >
> > On Mon, Jun 03, 2024 at 09:10:43AM +0000, Peng Fan wrote:
> > > Hi All,
> > >
> > > We are running 6.6 kernel on NXP i.MX95 platform, and meet an issue
> > > very hard to reproduce. Panic log in the end. I check the registers
> > > and
> > source code.
> >
> > Hi!
> >
> > Do you know by a chance if the issue is reproducible on newer kernels?
> >
> > From a very first glance, I doubt it's a generic memory accounting
> > issue, otherwise we'd see a lot more instances of it. So my guess it
> > something related to bpf jit code. It seems like there were heavy
> > changes since 6.6, this is why I'm asking about newer kernels.
>=20
> I not have a full test environment with newer kernel, the i.MX95 platform=
 has
> not been landed in upstream repo.
>=20
> After I enable DEBUG_VM, I have a new dump in virt_to_phys: I am thinking
> whether the dma corrupt memory. And with disabling DPU, I am redoing the
> test, and see how it goes.

After address the virt_to_phys issue, I could still see bpt_jit_free trigge=
r
kernel panic.=20

Is there any suggestion that how I could reproduce this issue sooner?
Currently I am doing linux reboot test, but needs several hours or more
to reproduce this issue.

Thanks,
Peng.
>=20
> [    2.992655] ------------[ cut here ]------------
> [    3.003764] virt_to_phys used for non-linear address: 00000000897eac93
> (0xffff800086001000)
> [    3.004944] sysctr_timer_read_write:10024 retry: 1
> [    3.012196] WARNING: CPU: 0 PID: 11 at arch/arm64/mm/physaddr.c:12
> __virt_to_phys+0x68/0x98
> [    3.025243] Modules linked in:
> [    3.028312] CPU: 0 PID: 11 Comm: kworker/u12:0 Not tainted 6.6.23-
> 06226-g4986cc3e1b75-dirty #251
> [    3.037098] Hardware name: NXP i.MX95 19X19 board (DT)
> [    3.042239] Workqueue: events_unbound deferred_probe_work_func
> [    3.044953] sysctr_timer_read_write:10024 retry: 1
> [    3.048079] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [    3.059796] pc : __virt_to_phys+0x68/0x98
> [    3.063809] lr : __virt_to_phys+0x68/0x98
> [    3.067839] sp : ffff800082de3990
> [    3.071141] x29: ffff800082de3990 x28: 0000000000000000 x27:
> 0000000034325258
> [    3.078282] x26: ffff000084748000 x25: ffff0000818ba800 x24:
> ffff00008471dc00
> [    3.084954] sysctr_timer_read_write:10024 retry: 1
> [    3.085423] x23: 0000000000000000 x22: ffff0000818ba200 x21:
> ffff00008080bc00
> [    3.097323] x20: ffff0000847345c0 x19: ffff800086001000 x18:
> 0000000000000006
> [    3.104447] x17: 6666783028203339 x16: 6361653739383030 x15:
> 303030303030203a
> [    3.111588] x14: 7373657264646120 x13: 2930303031303036 x12:
> 3830303038666666
> [    3.118712] x11: 6678302820333963 x10: 0000000000000a90 x9 :
> ffff8000800e04a0
> [    3.120954] sysctr_timer_read_write:10024 retry: 1
> [    3.125836] x8 : ffff0000803d28f0 x7 : 000000006273d88e x6 :
> 0000000000000400
> [    3.137736] x5 : 00000000410fd050 x4 : 0000000000f0000f x3 :
> 0000000000200000
> [    3.144894] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff0000803d1e00
> [    3.152036] Call trace:
> [    3.154489]  __virt_to_phys+0x68/0x98
> [    3.158163]  drm_fbdev_dma_helper_fb_probe+0x138/0x238
> [    3.163294]  __drm_fb_helper_initial_config_and_unlock+0x2b0/0x4c0
> [    3.169012] sysctr_timer_read_write:10024 retry: 1
> [    3.169498]  drm_fb_helper_initial_config+0x4c/0x68
> [    3.177000] sysctr_timer_read_write:10024 retry: 1
> [    3.179136]  drm_fbdev_dma_client_hotplug+0x8c/0xe0
> [    3.188773]  drm_client_register+0x60/0xb0
> [    3.192881]  drm_fbdev_dma_setup+0x94/0x148
> [    3.197059]  dpu95_probe+0xc4/0x130
> [    3.200577]  platform_probe+0x70/0xd0
> [    3.204252]  really_probe+0x150/0x2c0
>=20
> Thanks
> Peng
> >
> > Thanks!


