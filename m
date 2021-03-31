Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D842534FBCB
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhCaIip (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 04:38:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:15219 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234486AbhCaIib (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 04:38:31 -0400
IronPort-SDR: 1CTV3rpkkH8tBPcAgmxSVofoVCT4gqmbdeibiEuMeVTL/SU//JHWFY7A2HDs7gCvzSByUAKtAS
 6Q3SQP5vo/NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="171359162"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="171359162"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 01:38:30 -0700
IronPort-SDR: 3K6iFnLkYU+Q+CbcG6nWXcfTmq+zbCBpzcEwxSoH1ttibiCdC+Mn1eiJlSSLE2ab1o0kXMTfM2
 7OiHXDaoIjBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="412043546"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 31 Mar 2021 01:38:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 01:38:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 31 Mar 2021 01:38:30 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 31 Mar 2021 01:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNtDRfafbWsX+Mj96I7/dohdjOAJGG752UU+nP5k0Y3RwfjiuNFqu6MfPch+EWJLNaDh9YnFtjLPyWTcBxRUtKvSXJgh76PtIaEhCC9oIMM1NcgQ+juzy2efEBd1YKw0uFKFrPK2TXNYGc/gGKmMVru0xwpMdIkO2VmwtLIo+bJ6VRXX6J0r4ZhT3yz6b6nvuFDNUOuuJwWr3yKFreykjopPOhYorxLNqOtk3WDJzY2DJ+E3F4wvy+JgYPnlp1+o68WebHUZWaBakcozW3JSTNSN4e2lkBFm3N8P0AZ1ETsPwWhZZEP/tVTT1dUWEoc17yB3Tim2URGy0A9FcT0zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM8w/3FsqqEE1VkG1hfNqLaubgDecvlCquUKF1ecBsc=;
 b=SfzAKQdoq98rrYdTgY9/9HJSBjvIdAlUrEQA544If94JUiHOLm9yyRGrhGFIgd+Z4/0d41cqhl6y1Mr/sASpXNA1MU5doEBP4g3Ujjf4xvax4dbrCV8gwVJwbxKM8FJf+z8t1Bimd0u/rje6l6eGDdUuu5ZGnWLq9anQ6Vtc2VmUVjYUsWUpFQBQhoiImoS8u6faTmGbbAZOaP43thFKv2z4c75dhrvGjlgoLAnQFtv27EYfMj7gY8+eR8Aod3oxlyE3L86wRsI8QluVJZgFpgqMJwfieet1506nqO1BH2SahV9H/324jMPnykPj6gzjSbhOSfpG3WxFXZr5s+w6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM8w/3FsqqEE1VkG1hfNqLaubgDecvlCquUKF1ecBsc=;
 b=uhRpjVIn0+ZApSf7ZN+2JAuYhgISlkwNGFm7e2ch6V7o8YnGOX5SdLepUtL5205RDPe8BqVZo0qY+PDBtCdd/4tzIAiVvK9lpzYXc4eJouGF4yNEHRFSpX29W0r9L/qEG0sIkQ7NXPl5jONWHpTEtDbpBMSsHE6r+iIQELcLOTo=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR11MB1762.namprd11.prod.outlook.com (2603:10b6:404:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 08:38:28 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 08:38:28 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAazEAgAD4C4CAATwSMA==
Date:   Wed, 31 Mar 2021 08:38:28 +0000
Message-ID: <BN6PR11MB4068E9356ED64369B49C3B59C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com> <20210329155526.2ad791a9@jacob-builder>
 <20210330134313.GP2356281@nvidia.com>
In-Reply-To: <20210330134313.GP2356281@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 72575751-35e5-4a1a-8f9d-08d8f4205b68
x-ms-traffictypediagnostic: BN6PR11MB1762:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1762D196AE7DE69C337F8C51C37C9@BN6PR11MB1762.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyxbzKueEZl6CCVkflkexRxPiujWvCiFgkA94oid6OovZnWghx3rw0MPUXhScy6KQ2jtN2D+38j/6yerxAfUbEg6FSt66pDufcoagcudMgsKfFQ4Nx3Yzpf6qXm3JHb9+7EiBS8nRhYWotWx7q8o4K6XXpe5NnmUeUmv9i5XbIxrTjYyfNrnms6fAz2pvxBC9ypShLOca7i+ESKcwtOWoKN8ilWl042laWoTCtoPl/XPMpMgH00Ewp21ggjWbbXgYosiQtspUHIVVs/3FMR8kXoLwUgyD8sRzixuAUpwFggxCoex6Aa455gL8W7Q6c7a0UFM8q69KwZ9xJhJXtX/wqu2Mx8rIsmrYkV5T4IO3aEeqCMXaMk+2KDeDi7JUE5zYyLpNu5TTIhbdyyCxbKKRzZNWUmgzR+IE3G+cMKVtVYHRqAIZzM/CuorVAs6BGQKB950m/XmLlYDzaZbOXXCbSclVpYCcEL0Du9SRPzoUWJSJTlz8rpXN5Ud4H3B1ra4BFRUra3TndR+K/YfYaJCfHkZqjDpMHSfKihlKcJXPkA6HOVQNlMZMTwrn/cc5uKwZgKkqT8Fho/kLyUwGcpss/c+St/nUONIvEVjdQ9YiZOmowypUfsUwxO+dDnLcMrZYsLjuX+MBVNMXA8xLHKFwJAzcqOw1rlC9RDqAYAVmng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(366004)(39860400002)(66476007)(110136005)(66446008)(64756008)(38100700001)(66556008)(8936002)(5660300002)(9686003)(8676002)(55016002)(7696005)(54906003)(66946007)(76116006)(4744005)(316002)(478600001)(2906002)(6506007)(7416002)(33656002)(186003)(71200400001)(4326008)(86362001)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9eazYY9Ip9+Qb7OQcbAXm4s+mIR63i15Y0OlG1mEyrCP4ooLd45uTBldhseo?=
 =?us-ascii?Q?T8jjGEuJmGOR7o7cULv+aEo6MC+9Hlz0UXnLmeKZyPKC/6u4NfF8HgZ5bjB+?=
 =?us-ascii?Q?ru366FXfunxC3V22YzOhat6X66cDYZQ9kJFwlDUw6Vk331AVTmX5anBXqGUd?=
 =?us-ascii?Q?kc2pWoyGclsW3JHBpVA2+fmT7MDLV1DB8ASUTVMt2qZNJV4eajx0umyNgha2?=
 =?us-ascii?Q?GXo1315SGj4cfsPQZNZJPkYirJ3iHBbcTRwp/h0KHcHtCKtkXaEqoWzvT9Iq?=
 =?us-ascii?Q?2qHf2U3cif/NiNCSR3Pmo6vqxjF6FMy/lyGuA3mfPs9rnOAmGXJZpZt2EnAh?=
 =?us-ascii?Q?hUjPiAhzJvnlr3G+IPVDGAy/HFoQTc0TzF4J5/dAc5XI8qP7NnWoOvc6nqds?=
 =?us-ascii?Q?HPEV4INl6A2DvJ6YW/uDOWm3ogRwPG/UwVDphD9ztXMvLi9YnsR/4KKpxEw1?=
 =?us-ascii?Q?5NI74eoLELnJKNoatUaf8ZrA1V6vAxCmrWcRAc2F20drYHr6tRRwokk+3h0D?=
 =?us-ascii?Q?bJtzJtyqsei3j5DVclrhxlLtjp/cokpiRjQv9dUg4EG0k1axgTwncBYBeVFd?=
 =?us-ascii?Q?vo75H2ai0sns05xL1s879VI8CRGS78pwOSAIYZO5hoshK8bgrs1QJOrfF4p2?=
 =?us-ascii?Q?0S6l/JXIO/Q0aL7WZ8dnO3txMmYYchyS5G45MBgrArxTh934ZDPyGDrP1YdP?=
 =?us-ascii?Q?6YzQBqpq/4DjmPLUXwxODVkWtG+oTKcX8tIYZxQNlqelQKQhqGdLDJJPWknN?=
 =?us-ascii?Q?j8EWm1rY1ybSH8tyqhD6pikKNTTX9VbVvx+qg30W4CXODRd+cdaVKkqfiLgr?=
 =?us-ascii?Q?y1HVbj/CrC2+XvO/3H5tD49bYSJ4aIe5mjtXL2VXVuXlaUvOVcSUApK4IHI/?=
 =?us-ascii?Q?qXCCYkA+bIqqeb7slud3iH+NNMxggIsC5mZMDl+TarNORsZlzQavG1cQ0zRQ?=
 =?us-ascii?Q?QQ7hvDg+i2dp9/wA/LSQyzHstSGD6iCifoos4vbNc/YPlPvYIuiqHdRs5BJo?=
 =?us-ascii?Q?HTKx/EVi5wwhAuEUJwqQIkG2oordqN1TiF9NyWojWzcs2zPqpZRG+WyzWlpj?=
 =?us-ascii?Q?woyBVjXefrE921mHn8YX85C3WRXnDI+UtxzjDH/BDjQlPK3kAhhqZlvMb49K?=
 =?us-ascii?Q?DnBoXjmipke7F6iqEV8psqJ97d2O5bzcFmjGIQmURNndH24Z1HXKEuqERiRR?=
 =?us-ascii?Q?WSOJTOoBp8+i/9VqvMzU2MY5mXghAGtUGYQXE2cYCq5dw079u6kc0fywuysI?=
 =?us-ascii?Q?XxDIA1lub5oK5Q7TvHQpUnhV+RkeIgoTp9rf+6xiXRWtgAhJqJnVPakNbiyW?=
 =?us-ascii?Q?MnnVYkK6bWQHm3p9dlAL59XH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72575751-35e5-4a1a-8f9d-08d8f4205b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 08:38:28.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDuIOyskY8Yy0L37vLFSRY7PVG6BpXT/OWP844/FcRiHceUN1l6E+uflCl0Y/Ni8Y/QD63aRr0iPHIo95hWcLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1762
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 30, 2021 9:43 PM
[..]
> No, the mdev device driver must enforce this directly. It is the one
> that programms the physical shared HW, it is the one that needs a list
> of PASID's it is allowed to program *for each mdev*
>=20
> ioasid_set doesn't seem to help at all, certainly not as a concept
> tied to /dev/ioasid.
>=20

As replied in another thread. We introduced ioasid_set based on the
motivation to have per-VM ioasid track, which is required when user
space tries to bind an ioasid with a device. Should ensure the ioasid
it is using was allocated to it. otherwise, we may suffer inter-VM ioasid
problem. It may not necessaty to be ioasid_set but a per-VM ioasid track
is necessary.

Regards,
Yi Liu
