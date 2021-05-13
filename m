Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59EE37F33D
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhEMGx5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 May 2021 02:53:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:28990 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhEMGx4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 May 2021 02:53:56 -0400
IronPort-SDR: OcHoUxV0Wd6H7zflArNhZbn91eM5PrPYhohCsJz3O4ai6P5gpLSwfTYsxCShGN/Gjv7C+SB0+u
 QSJK4hzS/Kww==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199565804"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199565804"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 23:52:47 -0700
IronPort-SDR: FQg7HvmIHCOV+RTTwmMMgI1HrjgCBQ/CZJWikYaJacWOnc/DBYyT5ol1pF5KmxTyWNhUQYQAhJ
 4fJWhqxrROOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="610269489"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2021 23:52:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 23:52:46 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 23:52:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 12 May 2021 23:52:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 12 May 2021 23:52:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlmpPomPLIqLuV/osuTvFRzD9RNArQYW50d6SsWZIfRUBgd61zQwfC7wZDypkcBP6M1Mlcog7vdriPbbX0BrTC4AuMFjKoX9nugR6EZSIRArHNu/NBTZQtUe7XzTq0eBZR/XFD36/G2+6wb7fkVyh5hy7Nj/FoMyYo6hlbE79Gk2KTzNQQ/jNF1/Oi5gbXvf3BXEsFveVlJEbAUUAbyGcOLKjT9G+1LjKv+0PQvdIwRijqB4VyHmktvJR5dKq+sYit5HLZXz4AwtRFpzYzxxmNOuol1Ji/HE74UYfuLtjfPU1q5bkQgg5PSHeqeZioGhUz4R6KOCCAVea69cVsoG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOxG10YlcjhdLDqR+LeNIuApwba0FwwP6LcqPjTuLGk=;
 b=jGk83dYr7+as2wM0SAyELjHimA6XxkXTioWHLuViEUfVyYKj7HUnex5yBYi2i0BzGVdEleerPWrklCXLR5hd3YZocooh5RoGKGKQrvbhIjj1dfSYZkdQ2i3BWTHSNdwbqmOc5/dk2rlz6OXmDJpIdhyoP7VS3aHUG9NzKDIUoylTAA4sjYhwItLurqhBg3kwPNFS1v2gp0pQyZyW3XBaBHRxV67+4uEKOnzzLwaLhVxS+BJjdgy22NN0vqNqLMf/6+uacewyVqGveP3WnRthi3ca7FP3Rpt9L/RB62d6LzawKLQpeSDHkGP6VZELbund/xQ2Q9ZIRusQT/wqB6TgcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOxG10YlcjhdLDqR+LeNIuApwba0FwwP6LcqPjTuLGk=;
 b=MVgQ2DzC1AOPcKQ5zPaFn7LetXGCcpepufHDO0+utMNN0i9biBIb1a12iN5P8HXCCzdW7BMIY61cX641dQSsTInDRLLiiGFgk5fvdEUJo73HphYq65nRkylkSNYly6/MOQKE8ODmrCBU4qb7uIpnuP6rlEMOaYrlPthUBrpoPKs=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (10.175.54.9) by
 CO1PR11MB5153.namprd11.prod.outlook.com (20.182.137.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 13 May 2021 06:52:43 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4129.026; Thu, 13 May
 2021 06:52:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Alexey Kardashevskiy" <aik@ozlabs.ru>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIABMLWAgAcMG4CAANKaAIAAhd2AgAGBD4CAADHjAIAHHxkAgADGNoCAAPB6gIANV9MAgAAMdIA=
Date:   Thu, 13 May 2021 06:52:43 +0000
Message-ID: <MWHPR11MB18866CDB2F82A2E9285994998C519@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com> <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com> <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com> <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com> <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com> <YJzAsBNF1irJxRGg@yekko>
In-Reply-To: <YJzAsBNF1irJxRGg@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acc38c54-8998-45ae-0da1-08d915dbb573
x-ms-traffictypediagnostic: CO1PR11MB5153:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51530E32DAC737C733807B7D8C519@CO1PR11MB5153.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wi7waP/PKC7Im2zH8qVoqDQ9E99q91/0Rv5VisE1XQtyLNKJxie0ZCqpmqpw+oGfrLGKAwo6CklQmP9kc388uP4hBMuWA4hGLTRm4Bkm9QtIfxmyfwD9vP9SDrrjQ0dGRd61Xt3M4kfQNobu1ZCyjfohgUMxCHUD9gdpD7LOQt1fRg/N749pRfx+JIJpTPO6TrjxnKrDunSuNpCsr0cfki9fSQM86ZC3mquoUZL4fBlwXixIoF9leBV9C51C8PvSV0hn+n/m9Bz3CQ554qq4r5r1QZ4Ty0Pe4td1a+oniKEoVF7S7bFeyhAuzi3tQjUS28uuJBBBglByQk/Ssn+r9qvL41z5qnb1IJNR7GnN1E11iIDSNzECZhSE01JRmlpheq8hPBp7OgnAdpPQ5bQNuxhdcTiQGhQLEcQn7fX8mkaszpYdc5NX7qBuPoRFY1iKNq5AVUttq8TCYAL+QQubgVVLnIYz84R8sLqVB9I17emCyU+O6NQSprb8l5mgA9UK2FephEvRT0kHsohrE0G3ZOlCxI3k8XzaR0hgzTYAfJ+x1rz2FRK81qH8yZFMZeYP8j03Cvu8Og9GTSymk1P01JICgfEAYBL+KhudxmSXj8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(376002)(366004)(7696005)(4744005)(66446008)(64756008)(76116006)(4326008)(122000001)(478600001)(52536014)(71200400001)(2906002)(7416002)(38100700002)(66476007)(26005)(66946007)(66556008)(6506007)(186003)(9686003)(55016002)(5660300002)(316002)(54906003)(110136005)(33656002)(8676002)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VhO4/1dscOl9cdswVYrzwmkJ/srAZNTy6UWWoqC7vfPLczpOAlF8maT6mTaN?=
 =?us-ascii?Q?5i243gwtPsAt37DswRByoLcOU1CGBjeGGYKX8wsEsDGwzVH2yrVWHfEzIAyk?=
 =?us-ascii?Q?qDPXDsSrUWt2KIox17L1xLz5RDMbsjBWOrs1e0QgeugktzJNCrYiW5xmMhYM?=
 =?us-ascii?Q?le6wTIUBMqrVg7HwMUiR+vmQ3/pQLcdn8jxnnzZiofIMILKpm61wWKOywIQX?=
 =?us-ascii?Q?RIZbFOrX+KL6DJlpC9FXoHeko4ZEcIbHeiFMlRjdJwCeqBrh1aJY8XT+K83o?=
 =?us-ascii?Q?H1djmIvkyKrDfsj/+DpfkG3xeNWjkvw+8jyXcppuBmcS0QjeargjtBFdwhB5?=
 =?us-ascii?Q?HyRAay/1xv7uviQjSEoY50dF24q/p6D0CKdCeF3kJBhWZNHWUQhxNq5ZC2ji?=
 =?us-ascii?Q?JDGIcpPV9/957u/kAlZ0FbrA3D22AdW4MVSFfGz4oL3sBQDcCN0XvJCplrn1?=
 =?us-ascii?Q?WbvPCphqmk8h0Ths1EIJahXVoohvxdnNz8qQEn8wmTc5xv+YV/qx3S8u0yEd?=
 =?us-ascii?Q?4UpSLu4/f5BNrUP5VIds2GvftK93YQ5UVLfj8ZWRnKh9CYdRxDH2o4/IiNnC?=
 =?us-ascii?Q?BUFwTq7woMoOLUJ0gHJgH86o307yBX2ZSXhyqS30HnSkKp++EAB+EH6NgfnP?=
 =?us-ascii?Q?NO2twihwbWEZPHfVD1oDB2zLD4sSP5PeiWJ/7yeV53Yd+EuqcIWqM1paUhEO?=
 =?us-ascii?Q?IefOhs3aTwdkrXA8Tv01EoNrck6GYiEshPlONt7wNzEbkrTjUgi0rzJaa4dA?=
 =?us-ascii?Q?bNZRRWtftc12nAMGImOCggUgerbUEhkwwyMd6VNlvesPD6VPYdjYMc713fAL?=
 =?us-ascii?Q?W6FJuiQCf6ODIL/8zaU5xtgAuIEXlzL0SQTCgcKSJglJhiv1JPShoRVwjYtd?=
 =?us-ascii?Q?HPRU8jDjvTq3+UHvKht1y+J+EjX3woHsZmmdbhlGhCMG5+iTHjMbb9FWYqDc?=
 =?us-ascii?Q?MqVEWgS5m4wFBK92ohRwbawdn0ZuEqXegDbYBzzewxcEIWKI4yI4VBhcQplp?=
 =?us-ascii?Q?k4uZ82SmQqg5cR/NydmNbbHfRgovCPrKPdY+zq75NjJi3aqyBfTza8vNyHPn?=
 =?us-ascii?Q?jvRGXA5PYo32VY4TwsVjYcg8xP1YaowOJwDS3CY1mgaXDJDFJeET4pnpANnZ?=
 =?us-ascii?Q?NdrXRqLGQAOnpB52twvrGD086+sNQuXx55WpPjetdPhy7PvgoCX/lZoU2CMd?=
 =?us-ascii?Q?V1siWPkVbC0vrEV67aS2ohkFaU345BGC8BOofDjWQwh4RDdfdCAx0LrhJ/lc?=
 =?us-ascii?Q?EJJrRLhrEpBsdPWRgjsMjBocKwKlZkBuurvPrz99pp6XOJMXBRmiDaS0C3df?=
 =?us-ascii?Q?SJYl4SEQuyXJsRCydsWiHdJj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc38c54-8998-45ae-0da1-08d915dbb573
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 06:52:43.5423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 022A+rbHP6Hy9GIbG2V/wAHEZFYtRK5DQ5v1Xyxj83ekYoG9vMtZBrV5CrRnFvm8oMrzDNRcjRwOClC/ATPRkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5153
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: David Gibson <david@gibson.dropbear.id.au>
> Sent: Thursday, May 13, 2021 2:01 PM
> >
> > But this definitely all becomes HW specific.
> >
> > For instance I want to have an ARM vIOMMU driver it needs to do some
> >
> >  ret =3D ioctl(ioasid_fd, CREATE_NESTED_IOASID, [page table format is
> ARMvXXX])
> >  if (ret =3D=3D -EOPNOTSUPP)
> >      ret =3D ioctl(ioasid_fd, CREATE_NORMAL_IOASID, ..)
> >      // and do completely different and more expensive emulation
> >
> > I can get a little bit of generality, but at the end of the day the
> > IOMMU must create a specific HW layout of the nested page table, if it
> > can't, it can't.
>=20
> Erm.. I don't really know how your IOASID interface works here.  I'm
> thinking about the VFIO interface where maps and unmaps are via
> explicit ioctl()s, which provides an obvious point to do translation
> between page table formats.
>=20

We are working on a draft uAPI proposal based on the discussions in this
thread. expect to send it out next week.=20

Thanks
Kevin
