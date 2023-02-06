Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D868C93D
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 23:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBFWSR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 17:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBFWSQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 17:18:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745DEE388
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675721895; x=1707257895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vBkQGh6/0VEmRsJ8IheNAahzdjWtx0a6BuO2ZvFhNzo=;
  b=cvNhiU6Trd0heMrLpmnbJ5sVbazUoq4ECCQDhEbmbzmktgrVeg/5u8xD
   9HqHHZQ1QGq+GDxGjUE/ru4YVdnQSuRZOyuYhvyWgXx/vCZiGe8lqqXUX
   RqjG1BfHXMs6WeYAIeg37+fZUPvHx3QFBIB66SeeWP+0jKxg/dAQf+mbV
   AZLejG9lWKGPAcVPVXFUTC3VrrAtOiHCM0FrlgFaZHEpcXT5Je3MhmSzP
   JoN9DrnlLGrBfwsZfvk11Pr1DRIfkPlYTcdTpp60yr97OdS8lq/7q3PNW
   hj7Bzhcrj2DmLyyGegxNawPdW1YmGYcQfJgcABoIZLrQgatWjGTkii2lq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309663113"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309663113"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616585507"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616585507"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 14:18:14 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 14:18:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 14:18:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 14:18:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cauwqda6r1LmW8qf907pWdSH/POnlgPVfGzr212WfL8Pyy28/v7sHBITMGNipFLAnxYH9TqfCLdfNaRMrXLm54uVJ021EKbp6e3pw89vEOkxZU9NQuLNEMb35/9Eg5iZV7j46y7zibfinXGSIDSjtrYxq5bT02ktK79+i+qchYqaYV/kuyoYkLMqeikDVIrA3SvYk83jxv5O0oX/z0MKJQG4Rq6Hja9Nc02xYqBFOzV/FnVn2hfQPm+MJgX47mNG2yPlkSxibPLDzUb3A2TInitehmdoglkA4gN9VtZRPnn3etrbfE+uAqX1PuRSMtBhTXgqPnKrmO9gU1sdDu1aEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBkQGh6/0VEmRsJ8IheNAahzdjWtx0a6BuO2ZvFhNzo=;
 b=PmNC4E4GNLiSujfQBsj/oRq7vaKVD+9H1vDgWYQj321DTmbn09itR2NFFTrOgsHNxe/3OTlF6evWs9z4uDpWCB7pOqHY+bl1pf9cE+kiwejJnTow+FUmmJ60PnCqTHs0ha6wSzvOv16Gg/19h5XFAknreHGlwLtvcfQyXPQbmKgkBEcdE//nbAQaUi0ix+c8f3GhpIVgMWDZHH/MhN2LWyORIyUXHTBuwgMkuqjDoUjpn7UdSi3grHdlnKVl7XX9pyp1EPetoboTTv/OEII4H0mqDSDte73M2mrPgwsS6D2r4KR3hsRuLFYCF/60EA6LD9MBBd8byhkp3R79/IgzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Mon, 6 Feb
 2023 22:18:11 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 22:18:11 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>
Subject: RE: Using cgroup membership for resource access control?
Thread-Topic: Using cgroup membership for resource access control?
Thread-Index: AQHZOnPnbooDlMFe40SoGw64NHt7aa7Cc06AgAADK8A=
Date:   Mon, 6 Feb 2023 22:18:11 +0000
Message-ID: <SJ1PR11MB6083C61BCA70A31F8C0F12ECFCDA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Y+FvQbfTdcTe9GVu@agluck-desk3.sc.intel.com>
 <Y+F0NA9iI0zlONz7@slm.duckdns.org> <Y+F0mXS9z0flDhf7@slm.duckdns.org>
In-Reply-To: <Y+F0mXS9z0flDhf7@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8053:EE_
x-ms-office365-filtering-correlation-id: 8eb8e224-4c54-4e45-0ccb-08db08900890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGV9N7zN5DfrQ4AiG9FcjWSUDegPQwASY/LqEvg6N09D4r5Z2e2Y9ppmg9toBaspsynecRFk6kYSA28jPSklWl3ALJ1q68vz6nm9H2lmd3iwKKOXHC+nABvs2vhqESbdQ5+3PryUuKu0DbhvDOK0fDCoWkqJwZnDf1uSGuo4eOzP+xd3EI8mgGsrgz1272oZldDgakpdrna5tFBs5rQghRRGseuSfn1KDmu+0NFGBDqmJIJhdmZ67Jrte1CTcMtmvjYIclIOb6Bkno6DprYPUJcAtYGnFvtN0yrdpTYhdtuw5bg8Xql+1BOLsAoGUNsL3zG/SA1320n/VhOJEILlmY22TUkD6p1LwhZLyATlUJR4RzCPi/Tj/ceUzfWknqYNHN4TAgc9tyDLmkd59O+NwTCxW4bViYFOeNQ+JS1uoHHd2+hQXMFgcIWqGFnQFvfRvh6upI/1g5DQgKee/G41aZRW+dua3tr93docoot/O+sP8a1qIZwiH6ZIoYgb9rlEyPSbNZRFwrKJolKVN4FYBb5atr06/kpXn0iACeR/M560lBpxRy5F4G/+PTOfxKmtYYp2/FbfYJTStbdHrdLvqd0pReHlgxlMnvtX+IvxeMd73wr4ZL9jP5Q5ekGJAfqJtASAmC9+gqGl294jdf0/M+QBZfoh70Nq/EMhJyd8Kq1coJcrC3Cf1R5lrpaQukOec+6INpd2ylRCXWij3M1kzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199018)(41300700001)(83380400001)(54906003)(8676002)(66446008)(6916009)(66946007)(4326008)(66556008)(76116006)(66476007)(64756008)(8936002)(52536014)(82960400001)(7696005)(38070700005)(55016003)(5660300002)(9686003)(316002)(2906002)(478600001)(33656002)(38100700002)(107886003)(26005)(122000001)(71200400001)(186003)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aUCW1QWYaw2avXpeSD5ooz/pIDYMu8DOdu3nvcphaXoegxgJjFj1Dul0JG+S?=
 =?us-ascii?Q?lNkJ8gUs9rnViijyJ2D9S96QZZEOOAHMaIp6kWB31tzULMJFIPvT9piB6p3D?=
 =?us-ascii?Q?8YRK9oCe0ndZA3jfO68BRnUI9zdjfioWikn9yGMES3ISjD9L2JUMVMe2nz2H?=
 =?us-ascii?Q?ubIyTnMIimudScYP1mrQUP9yuPkiiTha465f9sTtuTZkXPLacOKiu0HBif7Q?=
 =?us-ascii?Q?z9dvSHCxI2po3TG+xK1II+CogC/cXHBKMHFg9qhTUlOhJjrIXvp2LnWDmAqJ?=
 =?us-ascii?Q?wmxBOPd6xsS71WFhCUJVoYeCUCh31ig+7LXC4V74i0QDUvYyFzfg8pm/ru5h?=
 =?us-ascii?Q?AKP/EWTASzHkczElpBhEkW2PiRF/8G37GD96tN7OQDt3KsV4Y/Oh+v0ngQKo?=
 =?us-ascii?Q?SzCFGhuRFH7DWMWvOkWGRewOPbQAvSDIisIJw380Ks8rnfy022Tjyyb+cD/K?=
 =?us-ascii?Q?LiNcpH2u4esLtD/jaoiGz963vEvjz32MrxoCHjKTrDdUzrmZwkVuEkyw8DUe?=
 =?us-ascii?Q?3s8grAy4VqIFObaJ8gJ/A6SjQpQ+6IHeowjpNhLYe+UgGAPfBLQ5I2/CQ3gG?=
 =?us-ascii?Q?jPbxxuYa1N7lh9gjvLewtMjlORuFJb2DmS1uNeVqi/JqsUVTSmqu6Ym+xNog?=
 =?us-ascii?Q?0MPSuOu1BRDVONuQnZv6Xlw9NXiiatsNaqwfcmMN5Q5+IFI5aQ2tYHjYKERI?=
 =?us-ascii?Q?EoLqPq4X84OLfsR9BHwwtbnxY9sYhd1qDhaq022ZHGvg5jwuEzRqsicUFtbK?=
 =?us-ascii?Q?ngML25b27hINID4/zDSPXZo/KspiW2ZHWWHcxpR/F76Upilt7rJnh0k7pa5J?=
 =?us-ascii?Q?QcVefzKa8+sZB0CTt4k8TWbtoK9wJrdsT9tabrOnUgbXMtlQw8Fw54R2UdH/?=
 =?us-ascii?Q?iBzTmeaghkTJtRjqBZSRJtkP7iQqJnT2TpijXvRpgJCYmnbkAFwrEL6j/BaM?=
 =?us-ascii?Q?Z0/lU3c0tt+dYbzVkjxVBFcGoef3CMjtKEb9KTLfze/qllL4Fw4EW+17ky6G?=
 =?us-ascii?Q?aOVW/QWEJ7vhRGtfjDSnMV45Drh7LrLfOBgRgtVb6eBh5JR8q+b2VzWqJQX3?=
 =?us-ascii?Q?lhy0d7zIUgqZKAaLaRNbA01bbhNFZBV56uLZLb5JGISBew2TN6S5/oQ70YQF?=
 =?us-ascii?Q?WLypOEUds2p0MTJ9sPGC4BB4Ut5QloBrudGe1NYb4QqmHr1Yz8H5fxrhspyY?=
 =?us-ascii?Q?ARJFbJC+3qXWUuk1ioBVDWN5hWyZ1MJlQC0EWMwxknBGBVZBz/Uzo5U41g73?=
 =?us-ascii?Q?zY9mf75m9bQ5a1RZLz8zG779JJjqf6c7EiLfSm265b4mlOiVvzRe3oKeTdDu?=
 =?us-ascii?Q?QzO7IYWtAeDHIxAlCSHteUsAOVuY2U6jXoctPIvbNGCeAai32QShE21kotBm?=
 =?us-ascii?Q?ha94elTr/LmAY+c06tr7TxKH+fCAsyhpoVkPWPXYnaJLv2ZTnJ/C2sFj8lyP?=
 =?us-ascii?Q?yaoTB0pEpST91PWgwbsnaPtRQJhpzVviChZ5Ad5eCXOOo9wpzY2RYQLkNm0S?=
 =?us-ascii?Q?q/i3fszHthRhqZxaqgJYCdE6i7Lq/n65C94urZZL4stFWrWbhRX5Y5xNoRxH?=
 =?us-ascii?Q?gqF3P5shT8y9VJdNR1LstzfZhb8UOTQfORNRU/dc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb8e224-4c54-4e45-0ccb-08db08900890
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 22:18:11.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZqf+lQxT1q/syl7ObVZKOzBzJxmx7lW1jhyrm5kAnH8s8RMn50L/ud2zSoe/a6ZJSWyI4/RaEljD10o7UYRqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Tejun,

Thanks for the quick response.

> In case it wasn't clear - use the misc controller to restrict which cgrou=
ps
> can get how many but as for sharing domain, use more traditional mechanis=
ms
> whether that's sharing through cloning, fd passing, shared path with perm
> checks or whatever.

That's always an option. But feels like a lot of complexity during setup th=
at
I'd like to explore ways to avoid.

Some extra details of a workload that will use these shared virtual windows=
.

Imagine some AI training application with one process running per core on
a server with a hundred or so cores. Each of these processes wants periodic=
ally
to share work so far on a subset of the problem with one or more other proc=
esses.
The "virtual windows" allow an accelerator device to copy data between a re=
gion
in the source process (the owner of the virtual window) and another process=
 that
needs to access/supply updates.

Process tree is easy if the test is just "do these two tasks have the same =
getppid()?"
Seems harder if the process tree is more complex and I want "Are these two =
processes
both descended from a particular common ancestor?"

Using fd passing would involve an O(N^2) step where each process talks to e=
ach
other process in turn to complete a link in the mesh of connections. This w=
ould need
to be repeated if additional processes are started.

It would be much nicer to have an operation that matches what the applicati=
ons
want to do, namely "I want to broadcast-share this with all my peers".

[N.B. I've suggested that these folks should just re-write their applicatio=
ns to
simply attach to a giant blob of shared memory, and thus avoid all of this.=
 But
that doesn't fit for various reasons]

-Tony
