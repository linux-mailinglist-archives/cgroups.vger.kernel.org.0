Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F9079A51A
	for <lists+cgroups@lfdr.de>; Mon, 11 Sep 2023 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjIKHzc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjIKHzb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 03:55:31 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F2100;
        Mon, 11 Sep 2023 00:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZF/PJRVYdOQ7r00wfOb14bKj93GnfcLS1g2121vGLf7x1EexgasbMzoau5DCchZ12ipztxLmr5cYckFaTyXfb1Kz0hAj/+CTwcRcc/eSFnqvaB7jhlSKMADN/TtdmRVcy9oK6iL2gbMRYcwXm+kUouzVHCMqDSHCAUhQiJ2ezMGY4hbu4dAtuVMowaqa9uN6AJ3dBKAySr2W75x30ig4I96jSxEqiQoq0y3tAfsq73YxzYY3xc1iRVwChH8LKL5pwT06l254xGeSU9Wt2nP2edKv+2Gyup2AKhj8Y9XytJ5CWdE99t+qGCf1oHk6O4A/r/9+cJQUaKvtgvRBpQbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCI1H6vMT0KBMX/H5V39gmSgTZSv9N0KOerpNWmPBQM=;
 b=D78tO/ClyvIUrb81kjjmcmDSlxcg4RyoSx/9r3I3766XWuBJoKSNWLV2bBhIDyupO8UDKTOMYr8JWP7HVze1GxyrVZoP3Gq1XGZl/3PLNiJkMNLgeMp4htRiG4fK4HYzk3FMHapl0KbBYYOCIVbRQLqM+cAhvaVItPIeV5WFGGdSl3uGQewygxS+G6sinkdHUT0qOVTQT+VUqXH9koSc/NM45G0EOBHOwuYh0riRF9CU0BUR1AO3/59/zrFMJg+RTaGEY3iEhShdRyvE+pTXu5aTRiNmQZu1EkNcwaFgJL05GM1nUKlrafP4PzYBlrAY0thYm7VQOTDSaAuPOq2A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCI1H6vMT0KBMX/H5V39gmSgTZSv9N0KOerpNWmPBQM=;
 b=HI/hnt3GWMfFJYCp5l2aSNd+QM2miP1r89KOAl/v1SjfB22RqQdjVjCqCeVM432EEcw7LKctZbETb7G8l9LkA4nc2BfYQQRSL/uR927efdU38zZ0XdbuGEPl/9f3u6aEnhifIHGacP8Xwk1SrOnc/njfocjrZaDKXFu97BfnMNnMb6Pnkz5KxOlfi29jaTy1OjYz2rN+xF3GrTFpWAG+8L2tZnOjieLPBRC06Ub3PoC5bzIh8ob1BDegjxFHRnjJramWi+UdC8/0JRs0jp5Yz1GMPI7bEOefNk5sntVuGMrnpFnd5Hug0Zh+OnK7yy9OUdnynm7jmOwJnlHDOZ2QHg==
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 DBAP190MB0840.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 07:55:09 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:55:09 +0000
From:   "Yakunin, Dmitry (Nebius)" <zeil@nebius.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     NB-Core Team <NB-CoreTeam@nebius.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "Yakunin, Dmitry (Nebius)" <zeil@nebius.com>
Subject: [RFC PATCH 0/3] Helpers for debugging dying cgroups
Thread-Topic: [RFC PATCH 0/3] Helpers for debugging dying cgroups
Thread-Index: AQHZ5IVIEdx/726aRkuL9qbz7MGe6g==
Date:   Mon, 11 Sep 2023 07:55:09 +0000
Message-ID: <20230911075437.74027-1-zeil@nebius.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB1860:EE_|DBAP190MB0840:EE_
x-ms-office365-filtering-correlation-id: c3ffe015-d441-4e04-bdd9-08dbb29c6b97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XIdAGIM4hacVbUN9GesR+8QvtOksAClMan353EmWrP0UdF70Bxoq3qEt0QPPVqNsg69geqYBA31nZwj9BKIIsBZ5BCJUilpkHx9Gdyi7OPDw9mioodNu3fOzeVgWcvWnz+YIKFKGcWfIlr57BHcdYhe1kMZ+YG1uTHNhoxD+eTxR1dKZT+PL6sQbSdcgJz+M1q4DQzsZRr6wejajleqbrfjP04gjzE0ADBWbKT45TZ+sirLw3rlq8d2dFR60OQzCREpAO8hBCSY4HRVjYd3MK/Bj+Q23FwdKbhG62fKfiH0pHhKScf4E8EPXm7RqsTj0gYpRCsW8v6RDkQ/RRC7SE7ben+j27Amx/D0qn8NjJFUhpz8MRngHgAbr4mDymw1GzEdhc9+lJVGp6feEKgVi442dj57qtvdHjU9lJeuby+hoCCxyw2uoQYsl6NhBtv9jQ2YINvrl8U2BZSBqdydvhahl9gHv4hLTYm8yOEN78FUnCql7fxJl+WmxtnLOIeGEllpyyOu5eunfCfjdWLPXE62+Ch49AM+dQ7qradAD0P8DzCT/2suSzlcrSHDm78pdqWDllKSgD+sUUqnswB79iP4z8lRSCeaLhqeWC6b2s0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39830400003)(451199024)(1800799009)(186009)(6486002)(71200400001)(6506007)(36756003)(86362001)(38100700002)(38070700005)(122000001)(107886003)(26005)(2616005)(1076003)(2906002)(966005)(6512007)(478600001)(83380400001)(5660300002)(41300700001)(4326008)(76116006)(316002)(110136005)(8676002)(8936002)(66446008)(64756008)(54906003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xC1ftVb5Kf9EweQaQEhiUSXrxqy3Ml+OZqpxNOrzhQZIVH7b2P90Ip7KGr?=
 =?iso-8859-1?Q?rxt8EpBsoH0h/d8onnVMpEXmtvbWsmZZfqln42QVNmTMbJfuyFGzHigcQp?=
 =?iso-8859-1?Q?EidtUuvwYmqictMNYvD+HK1q4e/FecP4YePHgRHaWOjwER8VjFFobaosTE?=
 =?iso-8859-1?Q?LrgMAcenuVqe5jVc9wEgcfOHqUXvA7Nn+bz6jdURVqPgM2fjJZFGPfAzYP?=
 =?iso-8859-1?Q?GM7t26BsiK26lrx1+ydAhxthR41Aafi4oTIZXxIN2ofs0i5rrBIhocPCID?=
 =?iso-8859-1?Q?svj9sM3oU/YpKaX+Dre1EY+i/MujlB+RY9p2iUgMMt/rHsuQsakAPfIEWn?=
 =?iso-8859-1?Q?4Is9dvEwJSlXGEmYcWJVjvxxypM1YpHH9qnk59v60Xrfq9FsCiY8JPg3x9?=
 =?iso-8859-1?Q?5oykspr0VqFGBCW0btG20aUtxPNPAtxLG62EtqtwBefPf868pfX74eXTyE?=
 =?iso-8859-1?Q?OTQkGHSDhd4NHrd36Ij1M5H49rrJOxf+mtmCqnxuCCX7p3h/9p7vDThJ9e?=
 =?iso-8859-1?Q?LiyKqH3a4WEd74GH9VlA7cwcO1nTaz9O5gXfpkg/OwmdiD3wNB6m1LepS8?=
 =?iso-8859-1?Q?MFq03VmzNyasSBJyyZyA89dYft4cabDnm5hwgfjajupvVG7PHerRzz95yu?=
 =?iso-8859-1?Q?FNar3KLcURfZpg0FKU1Kuh8laQS3V2ZfVcWp4wiW+DLF/94UUpzPgwykQv?=
 =?iso-8859-1?Q?3822kTXOwbhnrApLB0jAAaobP/3TdIOMkkijm1bG8YOxrpNoYjmm+k+40a?=
 =?iso-8859-1?Q?XBJDQR5VI4SUfalsgzHc9Wla5y5FgnfzLF/uruvDKOeiIMyVI/ubqR5YPP?=
 =?iso-8859-1?Q?KW8yGB8z3GT1YKStSXmpMkT9Q2ECl56lUsQjBBkuGPg6nQ0jLctW2WG1iL?=
 =?iso-8859-1?Q?eTuZ+ClGrt0tZk0dSWB8yqrt7ihuYc49JHMgdVsBbmKUtPQACv0rENcBxE?=
 =?iso-8859-1?Q?2R8cxEsfLl3+tJ1XKbcpmFqOobvV/BvT68WCzRE5L/fWQ4pOM5g/2Og7Ou?=
 =?iso-8859-1?Q?K0sFwG0V2h8ZXCSv4SdCzVITLXtey4MIxX1SSBR0g+kArY9iMcMv4yaTvA?=
 =?iso-8859-1?Q?6knxcCt8Qt/tprDVI0N5OAZVEuoGKKjb4NK1AM/h9ms6+JwDs0dZzMwl5q?=
 =?iso-8859-1?Q?WceLSw4MVdJRQwo8QlKpcDVT1vSz6XaJnV3x19n1nde9M4C3T4jvkE02/5?=
 =?iso-8859-1?Q?uj8K6crBxVGdjZ6LC0HVkwyiYSV5SIC7Y/PlOv3g5G1XgAa7zeQ8DZ3wHm?=
 =?iso-8859-1?Q?tJzfS7bHW9ShFEkvJsO3Shx3R19MRANXcJOBDFTKu/WckhkBWiEV/VHJ3M?=
 =?iso-8859-1?Q?rquXiyEgapVWMsnY/yqDYrJcieyi7fLEqLfrPnJZt6lvmDOVL0JijihsCv?=
 =?iso-8859-1?Q?qcMJT/bQyQ/gI0MthJtWgJj/zksnLS901HozlBQq5owUME+STdjj7ViG50?=
 =?iso-8859-1?Q?4qPa2fvRCgapVXX8C5dVvlNnNcx8ABON3GN797Q43t/11bt/GqCQAuW00I?=
 =?iso-8859-1?Q?z3pNzzz0kNChG4Xs8kDdJHwIeDbMS7/5N6uOeC4UuqTDYfVI6ghMzs8uCk?=
 =?iso-8859-1?Q?GXF4RacktYduqM713X3XG72xoKZRGaRmeOeT+KmqVi3yj4O66UYm+CbYXk?=
 =?iso-8859-1?Q?J/XRIK2EWb/io=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ffe015-d441-4e04-bdd9-08dbb29c6b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:55:09.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fno9nJfDQrqQAVZhcaMnanGVG1hMQ2D2Fc+DJlaI7vjRUnwYXJ4TRHHWi1YDP0Al
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series is mostly based on Konstantin's patches which he had sent=
=0A=
years ago [1].=0A=
=0A=
This functionality still seems very useful for debugging the difference=0A=
between entities in cgroupfs and counters in /proc/cgroups, e.g.=0A=
searching for files that have page cache which prevents destruction of memc=
g.=0A=
=0A=
I saw the comments in the original thread but didn't understand the Tejun's=
=0A=
comment about usage of filehandle instead of ino. Also I saved the original=
=0A=
output format in debugfs with extra counters. We can rework this format in=
=0A=
the future but now it seems straightforward for just filtering through=0A=
cmdline utilities.=0A=
=0A=
[1] https://lore.kernel.org/lkml/153414348591.737150.14229960913953276515.s=
tgit@buzz/=0A=
=0A=
Dmitry Yakunin (3):=0A=
  cgroup: list all subsystem states in debugfs files=0A=
  proc/kpagecgroup: report also inode numbers of offline cgroups=0A=
  tools/mm/page-types: add flag for showing inodes of offline cgroups=0A=
=0A=
 fs/proc/page.c              |  24 ++++++++-=0A=
 include/linux/cgroup-defs.h |   1 +=0A=
 include/linux/memcontrol.h  |   2 +-=0A=
 kernel/cgroup/cgroup.c      | 101 ++++++++++++++++++++++++++++++++++++=0A=
 mm/memcontrol.c             |  19 ++++++-=0A=
 mm/memory-failure.c         |   2 +-=0A=
 tools/mm/page-types.c       |  18 ++++++-=0A=
 7 files changed, 159 insertions(+), 8 deletions(-)=0A=
=0A=
-- =0A=
2.25.1=0A=
=0A=
