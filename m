Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4559234FA8F
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhCaHmC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 03:42:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:63889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234204AbhCaHlt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 03:41:49 -0400
IronPort-SDR: 1I+nNnDj1vvHdFJNDrlBAO/oCfdZW+KKOyRNHY2I/sDNWb8tgzRvlF5z8owNa8fRE+3gR2ASc1
 8I7RinsXAaTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191965279"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="191965279"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 00:41:48 -0700
IronPort-SDR: zfol9DRZP92tOwWj/zd6z10UgeUtW/TCoi5wih3U5WaA2B2N8JG+sK9lV7RtjwwEttVbl4/x0s
 Ke1rpu1PUKsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="393926090"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 31 Mar 2021 00:41:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 00:41:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 00:41:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 31 Mar 2021 00:41:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 31 Mar 2021 00:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePuTJz5SjKG6ATxZdboxt2dQwX6VuXN6Zfw6LLGED/TbKb9IQ/E9LaVYsEjSJ59TzhlQWqczIyPIzLmnWksVp1LnZYIKbhr3TEZSeDiPatgC6ZUg68aGouYlA4+YaORCC17nfD05FpHbCltq/mw+1WIScPWMLshQbdgF4ZL2Sq8IRC2guybUKZRT9FyXaI0uYIxb5NzmII3Wztu6sTK1ccxt61JKTGb6x7o+tb+agIxpNJRywuCfkEGYONDsyTLsJ/egX7gA6WSa8/2SVH5BQ6ZBNEAbfbzh68y00TQsAZN9PDL+VM39mBtDzDaavxA6AuJxnYlXipLq3l2TDZzupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOkqz6lqE47ySlxAsZxRsqNibYWh89Q0/sIPEdNlFu4=;
 b=HAhnRz0+oDIZqqVKAZb+u1RAgcTu9DBcFXxTC+Lp8qXzCuvBSw1XlRO03GbAnGpWvyn4UUA6afkFm+gg5TGmHwPWtoGPNHqDB+AOgxO2uwc39URVsmFjp92b9a4GLL/5fqcfAfZx5XtpPIaPYV+Ixekk2P1WP5d0J0P0ktdHnvj8bfckBAHKfUQ1zMW/4bJFmKXAbAKCw3VGqE2A4IVUQoqypXL9GGwlO5b5ySndPXm4uo89ESX1e5MX7ZAXg0GLfzTKCO1rln5J9BHpFebcEJxwWYcz6p6pqeMjytFNjTVG+TyGRjny2GT4RBnJCpWInxZO60MqQLE9k1iE1slzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOkqz6lqE47ySlxAsZxRsqNibYWh89Q0/sIPEdNlFu4=;
 b=e9fxKnRlElJA0gyMfNtVaphxvraWoC5Cki9uvUhB4nqRfejxtmsMwe9yf/dEQJIuzMigCA3yilLi+t/g2GuR8L5qkEdqjGnKFM+CtRHij3dpuJD0Xlqiy2YqICeOpohR9gi9ECYu+4LQuFI04p1G6o9rBARIpvWKr8HefiTPDIE=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN7PR11MB2754.namprd11.prod.outlook.com (2603:10b6:406:b3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 07:41:41 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 07:41:41 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAoO8AgAAZ0eCAAKQkAIABEobg
Date:   Wed, 31 Mar 2021 07:41:40 +0000
Message-ID: <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132740.GB1403691@nvidia.com>
In-Reply-To: <20210330132740.GB1403691@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f24efe2-68b9-4d79-0bd4-08d8f4186ca1
x-ms-traffictypediagnostic: BN7PR11MB2754:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2754726076F47229DC888E67C37C9@BN7PR11MB2754.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mOgBxAcEpXhRJlPgRLV1DQZWAlveTJfVESk7tdEEyYjFy03E5n0UgYsYlX99kGjYGYE5el0XYPy15aSlOPKTTk+QIhNabrjqOp+OhlCWqN4fVLMaD34sHNxEc+VtQSogYIjKPG9KHNJ/dga28/fWF/GlH+qYpZEcIxHLl9bGGS/fo1s92QI6FBEUhMWSHk9RbhWyiEMtquSbTLHZQjIIn9n2blHQySXETRdDc/TgeE5f4K64/KQUGLUioYbryCLi4+go3XHGLxcbQWoYPlBw6H/UlCsOWB7EXGWz4FiTMOFD8mvt2/XjRve35kMUxMScOxSrlRXkHHl3AKMvK10YUDZt02M3mwKuZKB/6Vzt3qAX0FHgZIff+15BhOvzcH+/6CYGMU299KxCcirf7LMv/M0Kr8njcgAmgTcJii4RX7UhYZlwiL/q6Nn1g4KwKCKRWWyIy7+1aKuhOEZtvxfaMF6Aq1sybtAGyjwCmhLI/hwhzSf3WP6BCf43pNC+w88Iy5IElykbTtYOpllgFx40KL/20JCzaCn6jJKV4yIUjv2zGMwyP+rRtba3H7IQd/znfQaz7HRskPWoCkbYVpSF4DjhBR06mgetLvlqOVVZxmIZN+/8wVLAkIF19u79X66HURvTb3JZxMYI3BqA2MscFE8168547CCsHsp/FNjbfE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(6506007)(186003)(26005)(4326008)(71200400001)(66556008)(9686003)(33656002)(478600001)(316002)(66476007)(86362001)(64756008)(55016002)(66446008)(38100700001)(110136005)(5660300002)(83380400001)(52536014)(6636002)(8676002)(66946007)(7416002)(7696005)(54906003)(2906002)(8936002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r3hbVgp9gpAh7VoNkFAOxYs+CqQUovp8ACs7TgRJChsWQowMNmEIPsW2JjqK?=
 =?us-ascii?Q?pr/ENAdaFvg4YPckxXGvCUXYYJqOUyLCfQ5hwMYcQA2GanBEa283XPp1o6Ze?=
 =?us-ascii?Q?Hu172vrc8P2gQdywZ/UJeG7bInz4GiCKtk+ZoP4qNYdBz08qku3Xg9M8L8Yt?=
 =?us-ascii?Q?E2gb34UGzGCv6PXhOs3WEVrCCswu6zylTjzurYBkllkren44d9eTZhLqMXYb?=
 =?us-ascii?Q?91/n3Un9IYHWqjrjNPoBZJQ9R/czbd3Dt/YKdV9uztv6pNTDfRf4yEP3it/I?=
 =?us-ascii?Q?Gfrvk4PUOKCr6RfqR0zgUxa3z3lzxNxpLJS+dCTuaMjOM1CJA8xxDC3TKUbx?=
 =?us-ascii?Q?NHx9TXqoJ+JnzLXuwc+RWC+srbpUWt8v8jM3Bc9a1SYDJMItKaJtVLwHKX0V?=
 =?us-ascii?Q?mzZA8J4vwotGMLTFAFC58ygrbTAy6/iX7f5mMPQ163ceNbrRSNprPvW5MWDE?=
 =?us-ascii?Q?ghHV7u2Y2OS6TBGLn4/dMXRebg+Ql7PVQEmrHXAK51SOsZL2REo4oEkqmGaK?=
 =?us-ascii?Q?Kw979AjM0iJ2HtKln2ioYok7S6FmDsezas5yTmQ5mqv6ePegnA66+riygXxI?=
 =?us-ascii?Q?gBcyktwDOo2lgcV1G97nrx8KQAe+RU3xyHmpjqiwq4Xao3PI/7iNUaO8IDnr?=
 =?us-ascii?Q?A6LwXsCnYihOzaJp05GxOfOhi7PSKaVdzVZZERrUJm+ff9aAfX7BCpM+9anQ?=
 =?us-ascii?Q?xPts6ioUH1QPs1j6xhf/17ggIIiIKJC3EuNTycmoi2SujrF/uY+VZBuXrXa9?=
 =?us-ascii?Q?+dpcwpMNkh8C6DEzH+fE/1DPafMX8B7knhczOevVOg67w7WWIkR1HLDxtoUi?=
 =?us-ascii?Q?XwEKyeP4k46q4WXVExhbccw+Y9pBEDO9T1ByY4S+yxn3QC9ZTKoZhlDPdjMm?=
 =?us-ascii?Q?b6UhhJKM4TTWP6BoxTPnUlEdi0QL+25GAqScvmU23srOXeeNZF0F8sUQWmwB?=
 =?us-ascii?Q?EXoITpGJipbbjWR19vvRzr5ny9LjgtgxGzdKQMBg+I9hjURTOLVXcRP5WqE8?=
 =?us-ascii?Q?N+lEllFBZqM82Mq495dmuM8J1lzVpipFOBVKZzM027Veqjx6WN/z1ILoydDd?=
 =?us-ascii?Q?RqAbIf9YODzS6ZaQz7Iw0tU5GtaYUj0S8sF/SNQPOXzMnr/5ICPtBt0ea7q2?=
 =?us-ascii?Q?PQiUIO+zECWTsvdONmLROQnNSea4wp0pEQrt4s7QRbnZ9JiuJvn/dizwjSnI?=
 =?us-ascii?Q?tIlI0PJVCZ/8YWd9BmehwcGxUSc76p94ff9DjU7BzVZIWlvzq1RhlDJsbCzY?=
 =?us-ascii?Q?2JgpB3t42L/Plq5IwK+wxGA5AyeDHRYO5WkRUPOXyQmmo8+NEISwCXFQhRma?=
 =?us-ascii?Q?Snh9Tjukj0POkyfBgruo4DC4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f24efe2-68b9-4d79-0bd4-08d8f4186ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 07:41:41.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paz4JX33A5MMrjMzqcFDKsILjQsl0AozVAY0ZzIsVxmM+LFCivoC1ry2z8c0XcHSgKBtb0kNA3/AyBaTz0hx6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2754
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 30, 2021 9:28 PM
>=20
> On Tue, Mar 30, 2021 at 04:14:58AM +0000, Tian, Kevin wrote:
>=20
> > One correction. The mdev should still construct the list of allowed PAS=
ID's
> as
> > you said (by listening to IOASID_BIND/UNBIND event), in addition to the
> ioasid
> > set maintained per VM (updated when a PASID is allocated/freed). The
> per-VM
> > set is required for inter-VM isolation (verified when a pgtable is boun=
d to
> the
> > mdev/PASID), while the mdev's own list is necessary for intra-VM isolat=
ion
> when
> > multiple mdevs are assigned to the same VM (verified before loading a
> PASID
> > to the mdev). This series just handles the general part i.e. per-VM ioa=
sid
> set and
> > leaves the mdev's own list to be managed by specific mdev driver which
> listens
> > to various IOASID events).
>=20
> This is better, but I don't understand why we need such a convoluted
> design.
>=20
> Get rid of the ioasid set.
>
> Each driver has its own list of allowed ioasids.

First, I agree with you it's necessary to have a per-device allowed ioasid
list. But besides it, I think we still need to ensure the ioasid used by a
VM is really allocated to this VM. A VM should not use an ioasid allocated
to another VM. right? Actually, this is the major intention for introducing
ioasid_set.

> Register a ioasid in the driver's list by passing the fd and ioasid #

The fd here is a device fd. Am I right? If yes, your idea is ioasid is
allocated via /dev/ioasid and associated with device fd via either VFIO
or vDPA ioctl. right? sorry I may be asking silly questions but really
need to ensure we are talking in the same page.

> No listening to events. A simple understandable security model.

For this suggestion, I have a little bit concern if we may have A-B/B-A
lock sequence issue since it requires the /dev/ioasid (if it supports)
to call back into VFIO/VDPA to check if the ioasid has been registered to
device FD and record it in the per-device list. right? Let's have more
discussion based on the skeleton sent by Kevin.

Regards,
Yi Liu
