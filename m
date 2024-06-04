Return-Path: <cgroups+bounces-3084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FC8FA840
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 04:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC21F26A8E
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 02:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BBB1386B9;
	Tue,  4 Jun 2024 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ilaPIATg"
X-Original-To: cgroups@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED753BE;
	Tue,  4 Jun 2024 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467667; cv=fail; b=jnTMUhMNibZPs14wWbDvkKgcKVju7xCWb/FCUjn3z3kbqxFHsQIDaSP47g8j9Rctdw/XV4B1EWdluMS3D8Ca60RcMwjn9baXEwDto4TZ/lN/vQ3J8GQXiy4Bg74Q9C6BAjBC2+asWwTQAzjlZrnTSzOgsnTz/q1KtRFWicETkHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467667; c=relaxed/simple;
	bh=DD0zQjiMjzT/Nb7UKwer6WT+2xfA2Dd1iY2QQnwQQOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fRb/yzryrW4LW/7D+7wNAbbkTLQXy1q0Y5JDC1YnlFK2i39wkp9Zub1DzaVxMlYATrXhokdY4OYJ+2DOsJ51dNm8UVWgx+fqnJVSCGGnMFWFLpHke3Y9wwO8ebnLVwnnVimW+BfTy+Y2XoQi78ybZAqBlV4xlkbBuLwn7qVPMH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ilaPIATg; arc=fail smtp.client-ip=40.107.241.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxdYzuwyAAJ2bFk0gL44lt5Ffb+OIeNr/7HY/3jo33pdewZa3zSLmfqt0dyrE/pmYfPfIKBNBhjsTcNlGYRyhnHzzp3YCyFXWJB9D1tsNQg0DVkplnXoFQuNHE3ns9/i81Om33nW0g/9IXiuaOUKqbBSXNHvwfy4xi+iIaYR7pMlh3HTu0XNyDm/IcqzpS7YUu7C2LMHr/puM7F2U1scrkvFEQQ/evk78idCky1WrHt1mqtQeM8YaIgrP9+mcTtVv1ZureDBJ2qwEiPVX8IA/qJuK3I6BLFbzEXC7bJQJ7t0TmkW+grSZOGYGvTwxM2ysA+FXlS0a3nft7u9jnv62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duEyIfmS2RZVGut/L/Q9qcFsvqhSmbUDUE1vacZ2JtI=;
 b=lrfKI24jJ1DLwhsmIlEezBhxGgwbQEFIOPxrdlXjA9PyS+eFKesEjDsUQmYeBWi7/O2nNcAYTUQpo9kUns4ibz+GPnL2FQtolAOBQmgZXyCRAjIbl607cmb9/k5ED2xv1lAevPLicwQK695jMw+XQOPCQD4cM6eZoJsM09mJ9uc4f4jtydtO7M1GrY93OYSLU1af1H2R7taQMcXzWf6jVb6311x9FS4+pmuSrasCD+hICY8PqqSGTP/DTfjaaYL4LLDzPdCmvcTbn03bXG1ayaNtJvKeLPXXhBYU8RKoG2pvNA31F3A0ouWFNvJPXR+Ke1QmLYUuRtVDHUpbHHwMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duEyIfmS2RZVGut/L/Q9qcFsvqhSmbUDUE1vacZ2JtI=;
 b=ilaPIATgdUZpiC5/uerkgXCM7kzE1Py/KY8IpY9cdi74u+oupwPax63gspjxLTbJ5kzzVC5m7UjLqlVmMf1OCgrUvqRTQY6NUlyUzRSeidHT0/9OZu57T7agH9/U28dPVR0JnXI3RLs/vDicCDGTKPMDDqQkMqpQ1EGMW8fYb6I=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6988.eurprd04.prod.outlook.com (2603:10a6:10:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 02:20:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 02:20:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"ast@kernel.org" <ast@kernel.org>, "zlim.lnx@gmail.com" <zlim.lnx@gmail.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"shakeelb@google.com" <shakeelb@google.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>
Subject: RE: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xffff
Thread-Topic: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xffff
Thread-Index: Adq1lSXxP1MKnpdwTLWYSVpJsSrmhgAhBYsAAAL/UTA=
Date: Tue, 4 Jun 2024 02:20:59 +0000
Message-ID:
 <DU0PR04MB9417DEFCECEC13149ACAEB0B88F82@DU0PR04MB9417.eurprd04.prod.outlook.com>
References:
 <DU0PR04MB941765BD4422D30FBDCFC1C388FF2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zl5k5ky1b6XFaPD9@P9FQF9L96D>
In-Reply-To: <Zl5k5ky1b6XFaPD9@P9FQF9L96D>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB6988:EE_
x-ms-office365-filtering-correlation-id: 9f3383b0-b381-4248-ab1e-08dc843cf976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wVcNx85TzCs7bUXovJELqIpsMVaiPJoBFx8F8MTaJbLXxRCCLnNR8+opKI7q?=
 =?us-ascii?Q?wjLdTKeJbZnNvjZbx0fBXvCFYcF3B2q2kY+ixwNUG2VzokGqiWXmEJNFpyC1?=
 =?us-ascii?Q?/WVMg9L8E6r1b64z2S0p5iUMaFmK4U4gzegZwofEVZnEvRWwmIcg9Qtcwfpu?=
 =?us-ascii?Q?nHFEZPZFpC7O3QGG3dG4qRQAKAP2SFiYHgY4wJzoeCIVrNsk1top1eB7ApVj?=
 =?us-ascii?Q?msrwWdUYYadxNKDYnkJ7qRM1Se3ypo5nLmhMIEu8rwWuJtzPtTB2tJSu/CwQ?=
 =?us-ascii?Q?NxQw2vyPSN4VG+IUpE+fC//a7R7yyYB7joFd5aOZLxwAAbTfDPrn89mePa4z?=
 =?us-ascii?Q?S6UlF9vmG0v+Owm2hW8ump6y9e1GUW6+VKJu9Kt2jMfaFUu1O3cqfQqGVlWu?=
 =?us-ascii?Q?mb0iDp2SWF4+C+D7pVgIq7xNB/+mc92I4HLxg0ZbjFk96N4G7J0cf4+LReQZ?=
 =?us-ascii?Q?BqjSeBFxElu+70oteiNLLanNy36Afs07Cxe/ykVpYpHJIewsj1TUTrnPOSxQ?=
 =?us-ascii?Q?At5p8UacR7YKWC0n0D35MB2S0Hz07zW0u+bZJ+VkFoRzE1Ptpto/cnAqOkKi?=
 =?us-ascii?Q?v2iqgexWAENZKeNY2f3v7Hl6Ch1/i8jkf2x2lfYkKHtxAKQePKQvm9qhsJ1s?=
 =?us-ascii?Q?qDi7KcQtELnW1kM1zMOA7+MubUhnEHEBA9b14JdRAMIzbT6XjNMUZILroRBv?=
 =?us-ascii?Q?rgH4Jc4kOE5ScURPT13PmDU6HD2aIFGqWSNS/xC2Gyqft+KtA0hsVOfIZL4F?=
 =?us-ascii?Q?3B80qdW0qxgcTne813wLVHQ7+PQmwD+VCj+USdp9cS3NItchQB1oXGnVHSPl?=
 =?us-ascii?Q?Pk03UVzS6OtQXhsahM7fJ+uN+JvllVOWJfXwvshutIz5nKgnlwOTWdHrlvyW?=
 =?us-ascii?Q?qSomp35hpvcA2QmO0apNADhFxMONA46NyJ+ZULmFeCYfrFvdS4rCKqTrfMfM?=
 =?us-ascii?Q?knNZ41ehc++ie0QqRKEB1KkvAgyi+0epM8/wt++cs81Z5iEFm8f3RYDV8ud1?=
 =?us-ascii?Q?kcDTPWo0m+pFTismzE0eteLPw8Cmue318k+SujSWcFuoOfDaPWlEvXR8dFd2?=
 =?us-ascii?Q?/hfs9JYuPZCs34Zwnq1Nk1EPadCbFTCc6NhcpzDd/OeVPbNL3hsdLrmh4nhW?=
 =?us-ascii?Q?3w3Qbcp1gLe1G/tZF6wnCqdlsLc2q06QD2GkSti0dxaoMfgoU8CO2NQ38Xyg?=
 =?us-ascii?Q?CGP+XfqEY9BKBzEnsHvHqf+3NS4XhLkFr5+ntGmAyDqPhiXucCrmdNU8jjuN?=
 =?us-ascii?Q?RRsv8JizSGcox2KG1T1DYmezicOR9b03TFVHzjVMoEUvaWHzZ5iswIn+c26z?=
 =?us-ascii?Q?vFZiRO6+Xv6UUA50wY6mB+kYxgrv0ufZZ+/AnvUu7DbbJw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RRE8vNprOBVkDKSGOk+DQJLL+ARNsthpCNmG+cjs/MHTGFZOTrgYO5Lx5BG8?=
 =?us-ascii?Q?caH6hyeQFX7rh7uGnQ916GaVYZPdkLGyWyiV3688ggO+kjyfqFMyrujQJjZx?=
 =?us-ascii?Q?gWk+UdawAEHCQD4q5XEKCZ8vNMmTI3pdmHzKPoRRRCrv1O4RqV1/xWVtOfmE?=
 =?us-ascii?Q?cP6Fnm+KdjcHOc2veUw5/6INuiNpe9568P3C/hDvdh2waBS+Mhr3vjuqK2bk?=
 =?us-ascii?Q?oSgAbwsCkCJtY4pgOQZZm190eCPOsL7HYnl1G7hAP66O33AKRXhZYm/Sc1hJ?=
 =?us-ascii?Q?WIjfRdqvCFP76rkwGuBlMB0RZP77CQ++HVlxYOfQzwB6nhUD2Gz7qoPWpvZy?=
 =?us-ascii?Q?byA9/t6sbn3C40QfeRep0iycI90Kkf/i5S8fRxdIi+V4Pcs8LFi7DHha6qZy?=
 =?us-ascii?Q?p/udEEhCNGWAFVzrpYVSlfGTnUUI92MGWpCu97CFSQZw6GHI+HX9ZkGyEbC6?=
 =?us-ascii?Q?2JDaYUQdd2f0S1pAqiXvD8RjOLnywRxNk7r/yGYp/Ax5KxKV/4ffaPg6oCki?=
 =?us-ascii?Q?Undj+ZcIUm8E1AH4rB4C/kdkFryieEPcU7JG260w/xUEbp1fxYEhY12wT0e1?=
 =?us-ascii?Q?GmoSB3lTBdYsmYqqR6HmBptkpFWMZYRr60TKFJ+Kz9ryisbF21NaOral25z3?=
 =?us-ascii?Q?tcIBRiWeLTg9ADsucZhohL8LgbMw6tT66v1slsbcmi1PVDa2kRzW9y0S7qbp?=
 =?us-ascii?Q?qJtiEJudyX7omvyrtFGHqgfuBwXmJiNk+HE/MQz0JShnzraORNa/GwNf/srn?=
 =?us-ascii?Q?WxWVOZ1S4kzuBrZqyNdulI1jcrRVuMVMRe3TewENuZ6Tpl5KbmQ1sci7KBBi?=
 =?us-ascii?Q?vhv3ZkflkF3n3tLqrEG8DWk9PzxFrqaHKTRUF71vN0sH+Pw3dzjfMuurDNyo?=
 =?us-ascii?Q?0VvyNJxzVXc5LzBymaTQ1MtxCLVfMxRCAdflUwuqdVJIkIkPmyCjfXJeg7/Q?=
 =?us-ascii?Q?aQtJA7kVq2HVNJsiiRs5WQkmSnet18A+eawi79uM1wOlAZNp5zHqqfwO8hMi?=
 =?us-ascii?Q?/uds4GV7pcL4x+PQIG+hvPyIwsnvJ9sVcntq85Xd3cDsN0EFOObNSffF943Y?=
 =?us-ascii?Q?C/OdROC4PwdXl70pNhm39Gd7UiTMmmBuJMKYcSDb2YClpTG7myvdE+Qd1Uvc?=
 =?us-ascii?Q?ypf5lw3bPTMxh/sebNKSUcKpft9PuWQUq30Y9j4YzYmV/bBG2QpvWV4yPz42?=
 =?us-ascii?Q?JKXlohYXx3fj/wLcrenCTfAWwuQIXzpRLyfBT1RKF3ddftaV7qvsx8DkUnAP?=
 =?us-ascii?Q?Hy2HuMbePV04ze2sTFFpnY7xJ2lP0nY6gPEeiUwNU/JVq6PMEzanA3NbhARp?=
 =?us-ascii?Q?JG1oeyn0xSeMDmXWwhsCW7ckUcTUfKp0AtAsSUXMjyTDahsOK9zGlklnbJ0g?=
 =?us-ascii?Q?WOG2avYQnsIFuvkfZucW+grA9hsZP3E63hcbtCxdi//+UlpyUC9Oy6Q86nYT?=
 =?us-ascii?Q?FG3ir6oqXBkGSIRFztB+rz5eu01paETM6hnaJtTnA9Hcr7zMbmWfsPy+InyM?=
 =?us-ascii?Q?TLBgkj3E2zYlsduvEmpt7surkp2OHiRA5Gjf3E65rHBHiQUrGaLHOJAaQjCC?=
 =?us-ascii?Q?DKC1qeYmBAgnNsmq1aE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3383b0-b381-4248-ab1e-08dc843cf976
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 02:20:59.7546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQNNirkpRnkdF5hzkreP9XxCV7VxzaCjuMLIAZ+khScdHMs4257FSaD3PcpsDwhc0p+yZfSwmd+rVAWyduQ1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6988

Hi Roman,

> Subject: Re: [Oops] vfree abort in bpf_jit_free with memcg_data value 0xf=
fff
>=20
> On Mon, Jun 03, 2024 at 09:10:43AM +0000, Peng Fan wrote:
> > Hi All,
> >
> > We are running 6.6 kernel on NXP i.MX95 platform, and meet an issue
> > very hard to reproduce. Panic log in the end. I check the registers and
> source code.
>=20
> Hi!
>=20
> Do you know by a chance if the issue is reproducible on newer kernels?
>=20
> From a very first glance, I doubt it's a generic memory accounting issue,
> otherwise we'd see a lot more instances of it. So my guess it something
> related to bpf jit code. It seems like there were heavy changes since 6.6=
, this
> is why I'm asking about newer kernels.

I not have a full test environment with newer kernel, the i.MX95 platform
has not been landed in upstream repo.

After I enable DEBUG_VM, I have a new dump in virt_to_phys: I am thinking
whether the dma corrupt memory. And with disabling DPU, I am redoing
the test, and see how it goes.

[    2.992655] ------------[ cut here ]------------                        =
                        =20
[    3.003764] virt_to_phys used for non-linear address: 00000000897eac93 (=
0xffff800086001000)     =20
[    3.004944] sysctr_timer_read_write:10024 retry: 1                      =
                         =20
[    3.012196] WARNING: CPU: 0 PID: 11 at arch/arm64/mm/physaddr.c:12 __vir=
t_to_phys+0x68/0x98     =20
[    3.025243] Modules linked in:                                          =
                        =20
[    3.028312] CPU: 0 PID: 11 Comm: kworker/u12:0 Not tainted 6.6.23-06226-=
g4986cc3e1b75-dirty #251=20
[    3.037098] Hardware name: NXP i.MX95 19X19 board (DT)                  =
                           =20
[    3.042239] Workqueue: events_unbound deferred_probe_work_func          =
                        =20
[    3.044953] sysctr_timer_read_write:10024 retry: 1                      =
                        =20
[    3.048079] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)                     =20
[    3.059796] pc : __virt_to_phys+0x68/0x98                               =
                        =20
[    3.063809] lr : __virt_to_phys+0x68/0x98                               =
                        =20
[    3.067839] sp : ffff800082de3990                                       =
                        =20
[    3.071141] x29: ffff800082de3990 x28: 0000000000000000 x27: 00000000343=
25258                          =20
[    3.078282] x26: ffff000084748000 x25: ffff0000818ba800 x24: ffff0000847=
1dc00                   =20
[    3.084954] sysctr_timer_read_write:10024 retry: 1                      =
                               =20
[    3.085423] x23: 0000000000000000 x22: ffff0000818ba200 x21: ffff0000808=
0bc00                   =20
[    3.097323] x20: ffff0000847345c0 x19: ffff800086001000 x18: 00000000000=
00006                   =20
[    3.104447] x17: 6666783028203339 x16: 6361653739383030 x15: 30303030303=
0203a                   =20
[    3.111588] x14: 7373657264646120 x13: 2930303031303036 x12: 38303030386=
66666                   =20
[    3.118712] x11: 6678302820333963 x10: 0000000000000a90 x9 : ffff8000800=
e04a0                   =20
[    3.120954] sysctr_timer_read_write:10024 retry: 1                      =
                        =20
[    3.125836] x8 : ffff0000803d28f0 x7 : 000000006273d88e x6 : 00000000000=
00400                   =20
[    3.137736] x5 : 00000000410fd050 x4 : 0000000000f0000f x3 : 00000000002=
00000                   =20
[    3.144894] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000803=
d1e00                   =20
[    3.152036] Call trace:                                                 =
                        =20
[    3.154489]  __virt_to_phys+0x68/0x98                                   =
                        =20
[    3.158163]  drm_fbdev_dma_helper_fb_probe+0x138/0x238                  =
                        =20
[    3.163294]  __drm_fb_helper_initial_config_and_unlock+0x2b0/0x4c0      =
                        =20
[    3.169012] sysctr_timer_read_write:10024 retry: 1                      =
                        =20
[    3.169498]  drm_fb_helper_initial_config+0x4c/0x68                     =
                        =20
[    3.177000] sysctr_timer_read_write:10024 retry: 1                      =
                        =20
[    3.179136]  drm_fbdev_dma_client_hotplug+0x8c/0xe0                     =
                        =20
[    3.188773]  drm_client_register+0x60/0xb0                              =
                        =20
[    3.192881]  drm_fbdev_dma_setup+0x94/0x148                             =
                        =20
[    3.197059]  dpu95_probe+0xc4/0x130                                     =
                        =20
[    3.200577]  platform_probe+0x70/0xd0                                   =
                        =20
[    3.204252]  really_probe+0x150/0x2c0  =20

Thanks
Peng
>=20
> Thanks!

