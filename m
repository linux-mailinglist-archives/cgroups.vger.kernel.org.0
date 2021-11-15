Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829B4504B3
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 13:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKOMux (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 07:50:53 -0500
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:8257
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230313AbhKOMut (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Nov 2021 07:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf3yOYDoJ6AtPCi7sRK2aQDRQfGulr0yQ6mByNrPBWl/y6z5iabCbu/tjlurFhTdKvKH5Hyg6/tKHx1Qp4U0q5zDkP2yMvht7s2GesMeYRAhR96+wzaH5CoS6A2etypDikZahfuFJIvDI86by504w8lJ5fzVI0Ox6RnSCeCku+K/sthgIyb0bJzBEYQxcH5OIy11kc7wxK25GEyyU3OroxIh6rNec+UhsG5giyti9CQjZzomUIEdkQiG1uNiOXXnsoVGrm9aBOabROrRrQyYKFunTWKHNsdmONOYQyvr+txW7cgUtcJcYRvhOC7VON6nVrTXPRJLQbAPM0QBtF9Svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NHNiNd4CxBhMyKgrrjEkUgJTnEt3+AEx75Rw6EIktw=;
 b=WFPDi/FQnjDVsE5I6Af9IbLX4ODLMiWiP/olR2azLGKNnXMkwHGv+wOgaPoGBxTbRKlWMn396AI3MjyaE0kNwAwJjZbEoS6rtUX6lrCA1FYeG9l7nU0nML9h5sNQzyhv0VQ+CCwZAJCyFdEzdserq0h9OIDU8sjT4WYBTLQDZ/unyy10ndrFXNl5LoGeUtCWq63sz8ByajM1woqs/0L99RWHcyeSFzHWxAw0rkt0cErgrmOb7c2Gme8c3kY/tsJTDlGd6uzpMTGVYeuXTy+inxKmWGlX28PzDEy4beYogw/kBcOD6r37EMUMtciVsHNT/KjwJ/ywzXz++ICkbSydYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NHNiNd4CxBhMyKgrrjEkUgJTnEt3+AEx75Rw6EIktw=;
 b=gGSG1CxHVY6XxiyU4hSfdUcbA+aymS5i+lgneMjBPxJ3iZ+xub+jfQYk8YbmlZJO+XmrjYMR9UFTLvzuJoUL7Mu7B8663phu+5PwaNaOTZjazF+fSE7T0IkNggNya2urAwF3dbe9idQSCujXahitCtgUTs9breODtrd1EiqmAC/eCSsD3A1bqaStFXsk3/CqcKFRFQpy6Zeu4JEcqSPUIMtna4mmcGMabCHmQUktxGagEtMW4mC0BCi22tofacXwJDP1EerHE+RzduXg/j+/PZRGPAPxXEPxUSv20CkrtOCzBZesmzOz8Z0JjHC/xN+/WHDcc+28LoAbAAAtc8SSdw==
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:418::19)
 by AM9PR10MB4578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:266::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 12:47:51 +0000
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb]) by AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb%8]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 12:47:51 +0000
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Subject: RE: Questions about replacing isolcpus by cgroup-v2
Thread-Topic: Questions about replacing isolcpus by cgroup-v2
Thread-Index: AdfRoQau9QpbKiacQpSAjNJcfArMZQGOhj8AAAIaFYAAjk4/oA==
Content-Class: 
Date:   Mon, 15 Nov 2021 12:47:51 +0000
Message-ID: <AM9PR10MB486954284391B62D03B9976989989@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
References: <AM9PR10MB48692A964E3106D11AC0FDEE898D9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211112153656.qkwyvdmb42ze25iw@linutronix.de>
 <20211112163707.GA315388@lothringen>
In-Reply-To: <20211112163707.GA315388@lothringen>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-11-15T12:47:49Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=f5303250-578e-4c10-8e30-17300d4942ce;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8b795bb-8cb4-4d33-7878-08d9a836230e
x-ms-traffictypediagnostic: AM9PR10MB4578:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: <AM9PR10MB45786000B035C4380215DA0E89989@AM9PR10MB4578.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCkz6hyHUk7CxjKLrRPbMERBtG9U9nM4FU9p543PStARw+Jjltqmep5qu7veg7TM+X3vTH8AFt0SWYDKHDNzO9iWwx+ktt+JtNPVaGpGlV1yaqJASHEL9IZO7eB97v6xmTUMVSqdj3DMx3u+Xgvzdtin7VAcBGdwEmAzAebIjlKuvEoUlm2dpjeZfeQhfpPnDwXGKcsRIqpx3wiWpY2eFeDm+HcieBxNvAU6loaaLjUkyWgqRRL+M8uDLCukyeqTf7CS8XdUpiY8pJ9lsDduSIBjnLn/LwQvao4H9U5ws3figZ4sV80SMBBm6+i+iAlX5WY1QqsktZNa/91uJD+t8lbxJgHpcWeDYM1zp7plpnAg2MkN/TO+MZP0MGN8lxGZpvQuSbxpUbhONmmLk72ycimcesxa2lPM5nOLQD5cZNxgZWxlVRRcIZYvnrswKN0mPws3c6rRjKXjFJiysxiSf118YkwuUUJ8ijxyRHHpugkneTl8klzjUNbwE7MIGQ5H+tKl1zEi93ODJ9lOn+BWgNX+IyM+R1tZMNgqy7BLDICV5JG9LC1Sb3Bbo9r1rpuMSVxwTWfX1sQSbNPA79d9jeEAouH3TA/q4nhXl+apUcd52F7B3shPWhCKhsa5jf60uuPhK5tD+PT4h+ZIbdqdGbO+Cus2ngFsPP5NK++zkidgdUedVq6ffEds/lL9faxaPamRDe5+Rj1+rWe30vQnY0G4QTY00Gm6drpqCV9Y9vSpLOmyvwF51lDnh5h9wgfHO78A2pSdxk2JcuYjnZpqwb/8DKB/cytCCfAwbKdUFnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(26005)(53546011)(38070700005)(86362001)(110136005)(508600001)(66446008)(6506007)(83380400001)(4326008)(71200400001)(64756008)(55016002)(52536014)(8936002)(66556008)(66476007)(2906002)(7696005)(5660300002)(76116006)(316002)(66946007)(8676002)(38100700002)(54906003)(33656002)(82960400001)(122000001)(45080400002)(966005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xsAVRdbGgg9ugo95b9QOTP8KV0CSOyvAOPSiO2ITLRNdrzxY09nnSWQe4wjQ?=
 =?us-ascii?Q?jod+toHHMPVNk/ig6I4ScoLEpH7QWsP/hO9nMLdwfyvimeZ4bYYHxjlpxuBA?=
 =?us-ascii?Q?Qz7oHgqbI0c4s2jJwXWVFZC9remA5MqygJQhKofmE5XXh3HJ7i9OrW4B6Q8S?=
 =?us-ascii?Q?D3ouOuoOtyMWYsJdPKbZH7XqBtH4lLm2U3IEn4uiGRzkdz1HlCeokmiIfqoS?=
 =?us-ascii?Q?z/xRyio0lADvYXgD8nCT/z/IfYZC1Ci5WZdjO5Ro1kw1iqxg3iXGt9ZpIhxj?=
 =?us-ascii?Q?/6yE+y3JiN63wtJiZX7wExpy5LQNwKQ1hyKSJRk73JgW7kJ8s16PrJrvyOZs?=
 =?us-ascii?Q?Q1pdN5CIS0+6BPxXnG74RsVrNuwmRpHxwqOx+4UIBPjvG+aupclvfd6GanTM?=
 =?us-ascii?Q?QxhBYb+IQyS/Km/ZTXXfmCh6Mpl+9DwnFALCXo5OCQgs0NxHV72tC6yVzuuY?=
 =?us-ascii?Q?w3FJno7ynOUJwXGeczIXxnsrgTqw+7WVivzwUsHPPUodJQMNMZAuKQiv1JSh?=
 =?us-ascii?Q?cUtYMj65Pl8M4M9smtorGlN8GImBB27n2SUU4Gk1DKluaDgqk6Jlv1jqp9Fk?=
 =?us-ascii?Q?VKpxINOu1PPBvjahSRN1bTJf59e9kAadjl30ts3UybnYvqf+pU0VuBdXUD0L?=
 =?us-ascii?Q?G39N2dbH+GwoS45NL8Mer3o6D65CY5UkMWVGlbGu1vsLkmyGmma7xJ5DFDfF?=
 =?us-ascii?Q?mx3SHIlHOq0yzknCN/EH7xrgao1MnU3FUoBVH2icoZ0LxViXQPQpOy7w4xPA?=
 =?us-ascii?Q?kFe/o4FZgPmN7/QnfK9SE5hp3rp/fpdiHyIgLZc9iK5mosTydbR5gSnmYTs1?=
 =?us-ascii?Q?Ehd9Hq6cmyRblxaA/R945rznNUakjiw1xC0Vfg4tWi0kTLR0JrW9JRVOfmDn?=
 =?us-ascii?Q?Tu7S9E6qZZuOiwmhRPZRNL1tIRbLkxYfz8Df0UdIKHCoJdVX8pQRlXTCyz5/?=
 =?us-ascii?Q?sMD5NXJzUM3/sEqiX2Jj7kSeJ1Fn6wFa3bDhkvnrfNwXesCT00PDwM7vGVz+?=
 =?us-ascii?Q?v6K0fGpnUCBeENamCR80kPQ8y/7WS5/3OxYGZxCehaIJKKAQoLr5NlTSbSfe?=
 =?us-ascii?Q?dt3WmMU8jiDM2vWLRz/djuN+9QYO/NcWlGEK7r+03HvHGGqOTeD0OG7ErF9c?=
 =?us-ascii?Q?AL/Jlz7QHmko9EYGuHSW7C7coOhltwMNr118xyv0KidC2V7TLUziYNyH22gj?=
 =?us-ascii?Q?mFzp8HO5IgrFMG0O7xBYR2x1YOQRK9vDCGnP66jTYUUgxB8QixYKnXspBnfP?=
 =?us-ascii?Q?pjNDZsVOTvAMekL95j/wIm+fXhtmY49oXc7GCXXoa2lnVp/M3+ns8ku+KncC?=
 =?us-ascii?Q?1I6v/bVNFQwftQQvypDdRipJnVSMX2Y9pQpZDlaBCX8qQKtCBouIbLMvr1VL?=
 =?us-ascii?Q?xJ7PUmMU4QDBxwlLhLxh6GlYP6+aMbCOAn7JAqBIQrvdrTOgiQ5Mn6+TfM7F?=
 =?us-ascii?Q?yTfJewC9CKAbO+3KFWHbj7h/R+PpgoMcxzzHxrXcsawuEGDWS1UCrNzetBr3?=
 =?us-ascii?Q?nsryYeJ0h9WK+Pun0bgUHLk4/y4Iod29MbxbdJYrlSudK1i+HKtl5UbtJgBc?=
 =?us-ascii?Q?h6o55Zysjbhq8GCz5Oo/C8sUcLlAC4oXzFrz3A1hJ6iaS593Ikr8gClwJa6D?=
 =?us-ascii?Q?8CeGBS1RL+D3zgss1hc9NeqjeRC46pNW3WYhXQAWOAvacQBltk05wVqofA3j?=
 =?us-ascii?Q?ETOGuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b795bb-8cb4-4d33-7878-08d9a836230e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 12:47:51.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HewcDbONOgymOwKasNQwPYzfGbLovA+Y0VLRw+lQvUX9AuLmFun7DT5ejvy+2lAIusOHnxe//BdKbFgNMnab1MH7mEVVFCa+9orni015y7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4578
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Sebastian,

> -----Original Message-----
> From: Frederic Weisbecker <frederic@kernel.org>
> Sent: Friday, November 12, 2021 5:37 PM
> To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Moessbauer, Felix (T RDA IOT SES-DE) <felix.moessbauer@siemens.com>;
> cgroups@vger.kernel.org; linux-rt-users@vger.kernel.org; Schild, Henning =
(T
> RDA IOT SES-DE) <henning.schild@siemens.com>; Kiszka, Jan (T RDA IOT)
> <jan.kiszka@siemens.com>; Schmidt, Adriaan (T RDA IOT SES-DE)
> <adriaan.schmidt@siemens.com>; Zefan Li <lizefan.x@bytedance.com>; Tejun
> Heo <tj@kernel.org>; Johannes Weiner <hannes@cmpxchg.org>; Waiman Long
> <longman@redhat.com>
> Subject: Re: Questions about replacing isolcpus by cgroup-v2
>=20
> On Fri, Nov 12, 2021 at 04:36:56PM +0100, Sebastian Andrzej Siewior wrote=
:
> > On 2021-11-04 17:29:08 [+0000], Moessbauer, Felix wrote:
> > > Dear subscribers,
> > Hi,
> >
> > I Cced cgroups@vger since thus question fits there better.
> > I Cced Frederic in case he has come clues regarding isolcpus and
> > cgroups.
> >
> > > we are currently evaluating how to rework realtime tuning to use cgro=
up-v2
> cpusets instead of the isolcpus kernel parameter.
> > > Our use-case are realtime applications with rt and non-rt threads. He=
reby,
> the non-rt thread might create additional non-rt threads:
> > >
> > > Example (RT CPU=3D1, 4 CPUs):
> > > - Non-RT Thread (A) with default affinity 0xD (1101b)
> > > - RT Thread (B) with Affinity 0x2 (0010b, via set_affinity)
> > >
> > > When using pure isolcpus and cgroup-v1, just setting isolcpus=3D1 per=
fectly
> works:
> > > Thread A gets affinity 0xD, Thread B gets 0x2 and additional threads =
get a
> default affinity of 0xD.
> > > By that, independent of the threads' priorities, we can ensure that n=
othing is
> scheduled on our RT cpu (except from kernel threads, etc...).
> > >
> > > During this journey, we discovered the following:
> > >
> > > Using cgroup-v2 cpusets and isolcpus together seems to be incompatibl=
e:
> > > When activating the cpuset controller on a cgroup (for the first time=
), all
> default CPU affinities are reset.
> > > By that, also the default affinity is set to 0xFFFF..., while with is=
olcpus we
> expect it to be (0xFFFF - isolcpus).
> > > This breaks the example from above, as now the non-RT thread can
> > > also be scheduled on the RT CPU.
>=20
> That sounds buggy from the cpuset-v2 side (adding the maintainers in Cc).
>=20
> Also please have a look into "[PATCH v8 0/6] cgroup/cpuset: Add new cpuse=
t
> partition type & empty effecitve cpus":
>=20
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2F20211018143619.205065-1-
> longman%40redhat.com%2F&amp;data=3D04%7C01%7Cfelix.moessbauer%40sie
> mens.com%7C1a74cbf4e3d140a9031808d9a5faad3c%7C38ae3bcd95794fd4add
> ab42e1495d55a%7C1%7C0%7C637723318334809165%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C1000&amp;sdata=3DJm3j2vDvOOtikU5ZpusupQ6d6koPII9oYZZhpDUkvY
> c%3D&amp;reserved=3D0
>=20
> This stuff adds support for a new "isolated" partition type on cpuset/cgr=
oup-v2
> which should behave just like isolcpus.

I already tested the patch and reported back on the ML.
However, it only covers load-balancing aspects, not isolcpu like default af=
finities.
When setting cpusets.cpus.partition=3Disolated, you get similar behavior as=
 with =3Droot
(cpus are removed from all other groups), but the schedulers load-balancing=
 is disabled
for this domain.
For details, please have a look in the other thread.=20

>=20
> > >
> > > When only using cgroup-v2, we can isolate our RT process by placing i=
t in a
> cgroup with CPUs=3D0,1 and remove CPU=3D1 from all other cgroups.
> > > However, we do not know of a strategy to set a default affinity:
> > > Given the example above, we have no way to ensure that newly created
> threads are born with an affinity of just 0x2 (without changing the appli=
cation).
> > >
> > > Finally, isolcpus itself is deprecated since kernel 5.4.
> >
> > Where is this the deprecation of isolcpus announced/ written?
>=20
> We tried to deprecate it but too many people are still using it. Better p=
ick an
> interface that allows you to change the isolated set at runtime like
> cpuset.sched_load_balance on cpuset/cgroup-v1 or the above patchset on v2=
.
>=20

Currently, the only workaround we know of to get isolcpu semantics on syste=
ms where
other tools like container runtimes or libvirt fiddle around with the cpuse=
t controller, is to simply enforce the cgroups-v1.
But maybe we are just running into the bug from above.

Felix

> Thanks.
