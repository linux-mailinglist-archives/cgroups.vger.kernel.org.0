Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674F3B6FC6
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2019 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIRXsZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 19:48:25 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:50478 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfIRXsZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 19:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4335; q=dns/txt; s=iport;
  t=1568850504; x=1570060104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6T/S8DRkI8SSFWTzTex9OMF2XYEM0mksUA3ibM1czOE=;
  b=HUqsIdsojEEKxu9l1EqjHSxQ+dofnluuhjB+zQ05w9bQ2BYXkaKZdF1k
   w5dWhCP1+LDAGiR6jd5OLH8Uy/qwzsBZVjj/fy4qmT1WULVopM/YLJMAB
   TfBq5K3UkJA72FViFQeBWjRDX1nJqd/CHf10TgO90Vqk/m4XXa+I/KMUJ
   s=;
IronPort-PHdr: =?us-ascii?q?9a23=3A4U+aIhL0BkTFB5k+Y9mcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeBvKd2lFGcW4Ld5roEkOfQv636EU04qZea+DFnEtRXUg?=
 =?us-ascii?q?Mdz8AfngguGsmAXFb4JeTraiUwNM9DT1RiuXq8NBsdFQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BNAAABwYJd/4ENJK1iAxoBAQEBAQI?=
 =?us-ascii?q?BAQEBBwIBAQEBgVUDAQEBAQsBAYFDUANtViAECyoKh18DintNgg+JZo4NgS6?=
 =?us-ascii?q?BJANUCQEBAQwBASMKAgEBhD8CgwMjNgcOAgMJAQEEAQEBAgEFBG2FLQxCARA?=
 =?us-ascii?q?BhHYBAQEBAxIuAQE3AQsEAgEIDgMEAQEBLiERHQgBAQQOBQgagwGBagMdAQI?=
 =?us-ascii?q?MpEgCgTiIYYIlgn0BAQWBMwELAYNLDQuCFwMGFIEgAYwIGIFAP4FXgkw+ghp?=
 =?us-ascii?q?HAQECgTkoHyaCdoImjHOCLoYBXogfjgQdQQqCIocFiX+EG4I2h0uPIJYfggi?=
 =?us-ascii?q?OcwIEAgQFAg4BAQWBWQonN4EhcBU7gmwfMRAUgU4MF4NPQYJVgUOFenMBAYE?=
 =?us-ascii?q?ngnuJf4EwAYEiAQE?=
X-IronPort-AV: E=Sophos;i="5.64,522,1559520000"; 
   d="scan'208";a="636317425"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 18 Sep 2019 23:48:23 +0000
Received: from XCH-RCD-018.cisco.com (xch-rcd-018.cisco.com [173.37.102.28])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id x8INmN2b029017
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <cgroups@vger.kernel.org>; Wed, 18 Sep 2019 23:48:23 GMT
Received: from xhs-aln-001.cisco.com (173.37.135.118) by XCH-RCD-018.cisco.com
 (173.37.102.28) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 18:48:23 -0500
Received: from xhs-aln-003.cisco.com (173.37.135.120) by xhs-aln-001.cisco.com
 (173.37.135.118) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 18:48:22 -0500
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-003.cisco.com (173.37.135.120) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 18 Sep 2019 18:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM7N9pcNjEOUkbaePUkutoYuJUS2JVZlN4sQGmMNZJr8+ZK5t5/pivucYqxRNrk+K+Sqmp3zg1FgbggYASwoyCUeNe3ZTJdPjyPpApq0xXIAap2YrDhFclRRJFExvjDoSKfAZvvkqJPqaS7XxmP+pfRYLywtVlX+HT2WEJEVxmpZvbusd2gcUcA37CSLs0aiGWNOBZKp206UbK2WajWpfVh4zNSgmwU2j61RdjY8TEJWKr8XSOdMxUxiM1I/Wn5A3zijNmpdqIByfzJe9b/B6is+nt8aInmjoZDUlxqAxK6Iav/JvuLIAPvbX81d4nNyPBq7UriLD8ey9zg53p8fGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KTOFTPQ50Jr6AtCzX7MI/vKivut9FygqNQzMS03MsY=;
 b=aMSE6GLCHXddQICO2md40W3xp8Jw9YJH2Jvpah2P/sLRterPl/0zXJqb8yQvjN6XYRhvAIboh3wswL4+TFK8zu3B25WUevpE3hy6A/ubV1aku4rpI+sRl41rQ9bTKb/GasqgVqaB0gbHpYZcJuivNO/xYO0t01c/tDh7yFPsUrvINe/zd1ZxLT4eSCmPJL8NfeoSrnZockRoYLnKqE+73Lu/BzyDQVmmyq2y5PCrG54gt/3IiJz6TGXPvxhfECS3eFdChNdfkXVogDslefxCm5l0mpSQIw1fTgYbPmnYoQeRf3+Cf8xiQx4I5aSItBQ39KDl7z/jlv+voHhirGUfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KTOFTPQ50Jr6AtCzX7MI/vKivut9FygqNQzMS03MsY=;
 b=mGxXhb7D4j6nuyB704TTJOT+3mnTFDXsU/GZWtWdH5szPowJ3yZiAKA7jujCzgie63N2lE6V/KdiLQwqYUYjwr+pU6v4q5sr6jtjYRVEqcskR49ugsAuWrh9YxD/cJv+U2QjwYmW1ItUsU2n/3JHpEkASZcJ/jgcaqq+HbbRV+A=
Received: from BYAPR11MB2582.namprd11.prod.outlook.com (52.135.229.149) by
 BYAPR11MB3063.namprd11.prod.outlook.com (20.177.226.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:48:19 +0000
Received: from BYAPR11MB2582.namprd11.prod.outlook.com
 ([fe80::29b5:ea68:50:df31]) by BYAPR11MB2582.namprd11.prod.outlook.com
 ([fe80::29b5:ea68:50:df31%7]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 23:48:19 +0000
From:   "Saeed Karimabadi (skarimab)" <skarimab@cisco.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: RE: CGroup unused allocated slab objects will not get released
Thread-Topic: CGroup unused allocated slab objects will not get released
Thread-Index: AdVuYAXsyqrfLm5yRGqVq9iRkUoA5QAD6QWAAAJqdqA=
Date:   Wed, 18 Sep 2019 23:48:19 +0000
Message-ID: <BYAPR11MB2582B2C3246BFAA8D2130A63CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
References: <BYAPR11MB2582482E28ACA901B35AF777CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
 <20190918222315.GA16105@castle>
In-Reply-To: <20190918222315.GA16105@castle>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skarimab@cisco.com; 
x-originating-ip: [128.107.241.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f0cda0b-ca08-4915-2400-08d73c92aeea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR11MB3063;
x-ms-traffictypediagnostic: BYAPR11MB3063:
x-ms-exchange-purlcount: 3
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3063AD608B93FD2D8EF79AA8CC8E0@BYAPR11MB3063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(13464003)(14454004)(26005)(966005)(9686003)(478600001)(66066001)(229853002)(6862004)(4326008)(107886003)(55016002)(6306002)(14444005)(74316002)(7736002)(6436002)(25786009)(256004)(6246003)(71190400001)(71200400001)(305945005)(66556008)(33656002)(64756008)(66446008)(66476007)(66946007)(76116006)(476003)(11346002)(446003)(81156014)(81166006)(8676002)(8936002)(5660300002)(102836004)(6506007)(186003)(86362001)(76176011)(99286004)(7696005)(6116002)(54906003)(486006)(3846002)(52536014)(2906002)(316002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3063;H:BYAPR11MB2582.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fT1Su5lj70mxhNLrkf95lVM6OrogCipUFxXD94XIMDMigX1VtjiY2gHHy12bdtvQh8cc+1G2323YXzru6cAux9+iK4rAA1wWXgfBP6rC3U+cAGQvz/gmpqd+HDhKEY3n8q8eoX1a6YO5CN2/A6KGgor65SopIyEMFPwESh97SvOQSOM/ytJIxD0lNs7q7E4krQUlLM46L92bwkBRHrr3jGPAl1zY3a6+Cn6iow0JtXtiGLFp4k5XjjtqwuAIhCH1OM9VsVWmjRdjOC1ESHaKqiLx/it6CAkMXgpf4dkQg30Xj6V9Rqy/RtsQ9Gx1rUe7bN7mqdgfcYCaZtyrgto9g9/lyAARmeq+3isjOhphWLoXRftZkb+ImjojfeViQNqpqqVSpDpK//u2ZqIzz6csSaUvDXwAcI94XvkKmo6DdNI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0cda0b-ca08-4915-2400-08d73c92aeea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:48:19.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWEOpD+FuxWIepxPaXLSPgplbKtqXuO9cW6lB7HMN9jFGNBDSnIFGhEOo2GRMMmBxGAYMDsv60x+6AhLi6TT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3063
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.28, xch-rcd-018.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,

Thanks for your prompt reply and also sharing your patch.=20
I did build kernel 5.3.0 with your patch and I can confirm your patch fixes=
 the problem I was describing.=20
I used Qemu for this test and the script ran 1000 tasks concurrently in 100=
 different cgroups.
I'm wondering if your could has gone through any long term regression test?
Do you see any possible simple patch that can fix this excessive memory usa=
ge in older kernel code like 4.x versions?

Here are more detail information about the test results:

***************************************************************************=
***
Your proposed patche back-ported to Kernel 5.3.0 :
  https://github.com/rgushchin/linux/tree/new_slab.rfc.v5.3
------------- Before Running the script  -------------
Slab:                      42756 kB
SReclaimable:      25408 kB
SUnreclaim:          17348 kB
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesper=
slab> :=20
	            tunables <limit> <batchcount> <sharedfactor> : slabdata <activ=
e_slabs> <num_slabs> <sharedavail>
task_struct          102    200   3200   10    8 : tunables    0    0    0 =
: slabdata     20     20      0
------------- After running the script -------------
Slab:                      43736 kB
SReclaimable:      25484 kB
SUnreclaim:         18252 kB
task_struct          149    220   3200   10    8 : tunables    0    0    0 =
: slabdata     22     22      0

***************************************************************************=
***
Vanilla Kernel 5.3.0 :
------------- Before Running the script  -------------
Slab:                      34704 kB
SReclaimable:      19956 kB
SUnreclaim:          14748 kB
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesper=
slab> :=20
                           tunables <limit> <batchcount> <sharedfactor> : s=
labdata <active_slabs> <num_slabs> <sharedavail>
task_struct           99    130   3200   10    8 : tunables    0    0    0 =
: slabdata     13     13      0
------------- After running the script -------------
Slab:                      59388 kB
SReclaimable:      23580 kB
SUnreclaim:          35808 kB
task_struct         1174   1230   3200   10    8 : tunables    0    0    0 =
: slabdata    123    123      0

Regards,
Saeed


-----Original Message-----
From: Roman Gushchin <guro@fb.com>=20
Sent: Wednesday, September 18, 2019 3:23 PM
To: Saeed Karimabadi (skarimab) <skarimab@cisco.com>
Cc: Christoph Lameter <cl@linux.com>; Pekka Enberg <penberg@kernel.org>; Da=
vid Rientjes <rientjes@google.com>; Joonsoo Kim <iamjoonsoo.kim@lge.com>; A=
ndrew Morton <akpm@linux-foundation.org>; linux-mm@kvack.org; Tejun Heo <tj=
@kernel.org>; Li Zefan <lizefan@huawei.com>; Johannes Weiner <hannes@cmpxch=
g.org>; cgroups@vger.kernel.org; Michal Hocko <mhocko@kernel.org>; Vladimir=
 Davydov <vdavydov.dev@gmail.com>; xe-linux-external(mailer list) <xe-linux=
-external@cisco.com>
Subject: Re: CGroup unused allocated slab objects will not get released

On Wed, Sep 18, 2019 at 08:31:18PM +0000, Saeed Karimabadi (skarimab) wrote=
:
> Hi =A0Kernel Maintainers,
>=20
> We are chasing an issue where slab allocator is not releasing task_struct=
 slab objects allocated by cgroups=20
> and we are wondering if this is a known issue or an expected behavior ?
> If we stress test the system and spawn multiple tasks with different cgro=
ups, number of active allocated=20
> task_struct objects will increase but kernel will never release those mem=
ory later on, even though if system=20
> goes to the idle state with lower number of the running processes.

Hi Saeed!

I've recently proposed a new slab memory cgroup controller, which aims to s=
olve
the problem you're describing: https://lwn.net/Articles/798605/ . It also g=
enerally
reduces the amount of memory used by slabs.

I've been told that not all e-mails in the patchset reached lkml,
so, please, find the original patchset here:
  https://github.com/rgushchin/linux/tree/new_slab.rfc
and it's backport to the 5.3 release here:
  https://github.com/rgushchin/linux/tree/new_slab.rfc.v5.3

If you can try it on your setup, I'd appreciate it a lot, and it also can
help with merging it upstream soon.

Thank you!

Roman
