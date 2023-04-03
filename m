Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1C6D537A
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjDCV0u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjDCV0o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 17:26:44 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020020.outbound.protection.outlook.com [52.101.56.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3471997;
        Mon,  3 Apr 2023 14:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhCMyQr5xuP6OtD3jp6NJY2djEzIca2vr6vz29axAR/HJj/5n9vfl/Li/nHr/9dFngjKnyvkWbXKatdj00TLeKVwN2suDF3aTypQlE9HZLyWj0fiZoY4uCziyxLYYgoa+KJiBFeTFNvBOrI/Vtqobz9OMSTYyvuiUbER1IkxCROmleBI7v/9j/LQ5Go1o9IvisixbOW/7/YHHqoNlp/ptVJ6MTuXzoQTLBdU7ueE0P0IU0nDzLdOJerxQ5Gk6XnPkIONKleQnRrHVMqip1kIzKlSsHD12/tJgfAG9HKZ9pcSb0OcIlotjnDS18v4zu5gUddzYkjrirTcc1+hbEatjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpDm2UMhLYE21j3CnCQkaJQgKP4U2zgaLFOXtrgPKbg=;
 b=SrMcCaFqY3gIgcct4zOGegZuPGvSme9vSwpUTQPn8L9/Quut482kJfESEZVI/t0bcyH1KpiETYj0k6sblJ4r3gs0iS660mypzYAz2mdIDy0FQS+nqIuqCaNHiQiSdwU2IoRNVJ+bNBU6u8R9JRWaGbG1buT9aO9DjYL+RxvKv1iCzzn/kbf0HtHWcBaX8+Cw2XY5owT/SUVFDpejErixP3CrtzZk5NxJppgquZCaIarhNrX5ySSyyEjMfySHhPyZf+LHc9GZ68Q9vQMlSkVyRwjmL6nhk7K2YNUAkXVe9eF2bT7RHQwH+SL3Yr77hIPLDs7QePPn/V8p0tlbe13r0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpDm2UMhLYE21j3CnCQkaJQgKP4U2zgaLFOXtrgPKbg=;
 b=PIjqasJ45USSFg9BeODqeh0nBfxkVSKZC4s9HALsRxAQcRXm1ogMhuaI44c1VDRnG/5db5+aHFijY5aXnughCkLXLrBKF2iytYnOY9d6SzwnZjsSTPxMPd8HpBUAy9Ums5feMj1RuSL8r5q1cRjRdb3TbzuG7+ybDQDOC0gfqVQ=
Received: from DM6PR21MB1177.namprd21.prod.outlook.com (2603:10b6:5:161::25)
 by PH7PR21MB3119.namprd21.prod.outlook.com (2603:10b6:510:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.8; Mon, 3 Apr
 2023 21:26:36 +0000
Received: from DM6PR21MB1177.namprd21.prod.outlook.com
 ([fe80::959c:6563:efae:29e4]) by DM6PR21MB1177.namprd21.prod.outlook.com
 ([fe80::959c:6563:efae:29e4%7]) with mapi id 15.20.6298.008; Mon, 3 Apr 2023
 21:26:35 +0000
From:   Anand Krishnamoorthi <anakrish@microsoft.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Bo Zhang (ACC)" <zhanb@microsoft.com>
CC:     "zhiquan1.li@intel.com" <zhiquan1.li@intel.com>
Subject: Re: [EXTERNAL] [PATCH v2 00/18]  Add Cgroup support for SGX EPC
 memory
Thread-Topic: [EXTERNAL] [PATCH v2 00/18]  Add Cgroup support for SGX EPC
 memory
Thread-Index: AQHZBn0ZUYTbjHaiT0mTf4KgoZqzI68a1mCq
Date:   Mon, 3 Apr 2023 21:26:35 +0000
Message-ID: <DM6PR21MB11778ABA54CD33A5822D5B24C4929@DM6PR21MB1177.namprd21.prod.outlook.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
In-Reply-To: <20221202183655.3767674-1-kristen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-03T21:26:34.842Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1177:EE_|PH7PR21MB3119:EE_
x-ms-office365-filtering-correlation-id: cb29864e-6c09-4852-dcd0-08db348a1a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTChk0J106Vh0wCJVDhh43a/BQNlNw7XLMhzERd49cWhahhCWJRwiFwUbVSfv7I4P0Pn2zJM3b4w3CZZpGyORHkuyAIh0adH6rGEUYZ5nr8z5IgYbUFsxzalq3h/imZe9J6f+6VJT+jMA1Rrdf442EE6qvxEB6JMjYbdDoiAu8psg9jk0Nj9BIT2z1GM7crDQoPIdV7g2RjY6RWA9gEzK19vSInioDNg5odC8fdCkk9P+sMzRfEaalcL6FhAsYqwSZiqgQ6e3cQ0WN9s2J77G/g99rLf9h+lgJvZ9OtbLIukWM6+nqKebkxLvmrTO+OyMwuHKOISxakMS8g+oMDOPTkrxODvRBom4dsK4SXRtKaV3A/EI9JtuKSUby+dqnL8hWrDRFFaYVyXFpkHHBFlmyXJ6HUqyAFM85t/+g9vQjeAcan068dAKnKIUzRxsTa8HZ5Wb8m+he9sCFiBtubDWNDCBknOrA2B0o1aKCBPCIUdC7+1hOh2dgj7ku9N8Hi0bHgT150wp18nB2ZHG1eouQf1PEXHgLPbLWw/zy8eR3HtmMI2+B6x9KNt6zn/HQ5uLqbHagF/3Ue2Gc3nnb9uDaJUNxCpVV2LY/Rq38GERsrppkm1A+v187oWGRsOisPRsWW/OemxSG8LY3croXplzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1177.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(55016003)(66476007)(76116006)(316002)(91956017)(4326008)(8676002)(66556008)(64756008)(66946007)(66446008)(478600001)(110136005)(6636002)(8936002)(786003)(52536014)(122000001)(41300700001)(82960400001)(82950400001)(38100700002)(5660300002)(53546011)(186003)(83380400001)(71200400001)(10290500003)(6506007)(9686003)(86362001)(33656002)(2906002)(8990500004)(38070700005)(7696005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ph9WwFcYqVYQ/PihrOYR16NBeaT+IFACjs3vOljyRR7DOhXzUaVUhpU6Zf?=
 =?iso-8859-1?Q?LLer18ZJb7B7S/erVQw+5yMIp+cb47UUeK0UDEUontIxgoxq2pYggJ9cu2?=
 =?iso-8859-1?Q?Oi+Vi1xb6W3FH25WM+ki9zjCkO9EHVI6gcZ52uP6+iEhlV4yMYy2rkkYK5?=
 =?iso-8859-1?Q?KhX/cpxGkvJtwSMODTMkkgGCjicdH2rLM6JrK/uqTw+pJLWGLcX+s9qS2N?=
 =?iso-8859-1?Q?ooSF5OvOzXfCmm4ze4nYx+1fYPOTeBgEOfiI7NbELDi2wPIxLLtX5qKZFS?=
 =?iso-8859-1?Q?gJ6T2wDh9mhG1QfByYdTbiG3hFOKKCVbMGNge1WPJpNdgrmgz30QkaVWEB?=
 =?iso-8859-1?Q?kNLXT++Iz1mMiNaQ6T9TYIfmaM8nu/VouDSu/gRkUN9VjKl5E57mwtocy6?=
 =?iso-8859-1?Q?N4IQeSEMZgjpBKoEOQyJ91KwgcSS4HZ7jYu23CVtgGMs0peGr/Mv17NAcI?=
 =?iso-8859-1?Q?Zm8m8w8iqkcdoFholP62OvykOd0Q70BBxEV7KCPWQMd5mS1BuDHIoemViN?=
 =?iso-8859-1?Q?z9nMJKcunbEwogRmZQDtCrtA6aPCIznAMpohnU7VD5tM8zg6K9OZeIZuy+?=
 =?iso-8859-1?Q?uP586RHkW8iNeCwneeiYB71wALfp0uMnQR8/0to33rRXkZNyXfgvdyqflq?=
 =?iso-8859-1?Q?vjOiL4ivvPVfmV96J9JzMMnTwDi3cZ8p9fRGzSoHK1GpQoeYBD/FQL57N4?=
 =?iso-8859-1?Q?k4dL+0cDHief9nb9DVr3sehiUhHY69GSmU6BPEOSPXwS3ovbCnIhKOQw2j?=
 =?iso-8859-1?Q?PbPWrJMtMdppiHqyvxDFV8EnEZcuvWOsoTnbC1gKRuDfNcwkILULkKpLS4?=
 =?iso-8859-1?Q?AEOv4Czbs3zU3D8xRiFeknNYZNC8XllCaihLYIeQq5WeTEWVe7vKgvn40F?=
 =?iso-8859-1?Q?zgqHJ9i8MKIMGqNsrLulmguvj8n2lgv7Jgs0/+lOKpWcz3mupbA3Pv80sF?=
 =?iso-8859-1?Q?+Zm8g7dIavhDx6EM27v3b7KGrGPrBcO3s0ddgOyUUVjJLpj8yn+i6Xzvt/?=
 =?iso-8859-1?Q?nyAB54DkAYGBj61P/x4kxz/5UvTgDSHy3GxMDNI9w6IgkJLc7kXadJAHjz?=
 =?iso-8859-1?Q?yhzQBc7IZK2bWwEN+ifes5MHjjcEdbPYXyALrxdPDzPDJCeKh0tW7W7hpe?=
 =?iso-8859-1?Q?7rDRBdc8dV4t9UdUz7pYrJmnXOD+ZuprylUZm81sdBgCj8idA2y94XGAG8?=
 =?iso-8859-1?Q?nDWcEASFVcalid3RPx/duwiau00Osd4BGHPDp4zP401BFzM8W+JaDmIGOS?=
 =?iso-8859-1?Q?fb9CJa7//IBX1s7P/J77/Zk6iAAMi4EadIq469RYqpMhw6LPrOcQ+Nmz6I?=
 =?iso-8859-1?Q?M8DRUYUfTTCSadtx/4mLUMjjLlKw2vS+uo9uEDt8MkQlYTZGv9LDhJnqSU?=
 =?iso-8859-1?Q?a7vAeKjHf4mr7bfDlLTlhDarXy1NqmTEoOXOIgd1cB3sF+4IhSGIBkj7Dc?=
 =?iso-8859-1?Q?X22u+jYH1IKjJQqEM6z22HzdnaFwldBqmprDGxLrkNs/hV4/IqJ2ssGhQk?=
 =?iso-8859-1?Q?78LAm50UL7bHEVrIN9cROZpHkUCVP+odAyxoJWHOu7YZ1ifccLuhxLC3ED?=
 =?iso-8859-1?Q?55FCaXYMtSQkLgKMn/B1x6LqabWkdUGYoULbLuclKw0RtMAmIjlD56XmT3?=
 =?iso-8859-1?Q?X4YApRX5h+N1xVe+U+kXac3hyIgS1GoBiO7ikHZkJLxb8dfR/WeRYSo3bf?=
 =?iso-8859-1?Q?MSEiHG3QtCoyZ8KCqmAy28qsqhLEYc9lwYTwczAl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1177.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb29864e-6c09-4852-dcd0-08db348a1a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 21:26:35.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfpgSiqG0CS67XYmMBv9uj660GcayB6zmMc8pCQHtrZ7TOEWe5OZZtAnyYwtKYNk5F3IvyMxcCiP0umHswwx3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3119
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Adding Bo Zhang to thread.

-Anand


From: Kristen Carlson Accardi <kristen@linux.intel.com>
Sent: Friday, December 2, 2022 10:36 AM
To: jarkko@kernel.org <jarkko@kernel.org>; dave.hansen@linux.intel.com <dav=
e.hansen@linux.intel.com>; tj@kernel.org <tj@kernel.org>; linux-kernel@vger=
.kernel.org <linux-kernel@vger.kernel.org>; linux-sgx@vger.kernel.org <linu=
x-sgx@vger.kernel.org>; cgroups@vger.kernel.org <cgroups@vger.kernel.org>
Cc: zhiquan1.li@intel.com <zhiquan1.li@intel.com>
Subject: [EXTERNAL] [PATCH v2 00/18] Add Cgroup support for SGX EPC memory

Utilize the Miscellaneous cgroup controller to regulate the distribution
of SGX EPC memory, which is a subset of system RAM that is used to provide
SGX-enabled applications with protected memory, and is otherwise inaccessib=
le.

SGX EPC memory allocations are separate from normal RAM allocations,
and is managed solely by the SGX subsystem. The existing cgroup memory
controller cannot be used to limit or account for SGX EPC memory.

This patchset implements the support for sgx_epc memory within the
misc cgroup controller, and then utilizes the misc cgroup controller
to provide support for setting the total system capacity, max limit
per cgroup, and events.

This work was originally authored by Sean Christopherson a few years ago,
and was modified to work with more recent kernels, and to utilize the
misc cgroup controller rather than a custom controller. It is currently
based on top of the MCA patches.

Here's the MCA patchset for reference.
https://lore.kernel.org/linux-sgx/2d52c8c4-8ed0-6df2-2911-da5b9fcc9ae4@inte=
l.com/T/#t

The patchset adds support for multiple LRUs to track both reclaimable
EPC pages (i.e. pages the reclaimer knows about), as well as unreclaimable
EPC pages (i.e. pages which the reclaimer isn't aware of, such as va pages)=
.
These pages are assigned to an LRU, as well as an enclave, so that an
enclave's full EPC usage can be tracked, and limited to a max value. During
OOM events, an enclave can be have its memory zapped, and all the EPC pages
not tracked by the reclaimer can be freed.

I appreciate your comments and feedback.

Changelog:

v2:
 * rename struct sgx_epc_lru to sgx_epc_lru_lists to be more clear
   that this struct contains 2 lists.
 * use inline functions rather than macros for sgx_epc_page_list*
   wrappers.
 * Remove flags macros and open code all flags.
 * Improve the commit message for RECLAIM_IN_PROGRESS patch to make
   it more clear what the patch does.
 * remove notifier_block from misc cgroup changes and use a set
   of ops for callbacks instead.
 * rename root_misc to misc_cg_root and parent_misc to misc_cg_parent
 * consolidate misc cgroup changes to 2 patches and remove most of
   the previous helper functions.

Kristen Carlson Accardi (7):
  x86/sgx: Add 'struct sgx_epc_lru_lists' to encapsulate lru list(s)
  x86/sgx: Use sgx_epc_lru_lists for existing active page list
  x86/sgx: Track epc pages on reclaimable or unreclaimable lists
  cgroup/misc: Add per resource callbacks for css events
  cgroup/misc: Prepare for SGX usage
  x86/sgx: Add support for misc cgroup controller
  Docs/x86/sgx: Add description for cgroup support

Sean Christopherson (11):
  x86/sgx: Call cond_resched() at the end of sgx_reclaim_pages()
  x86/sgx: Store struct sgx_encl when allocating new VA pages
  x86/sgx: Introduce RECLAIM_IN_PROGRESS flag for EPC pages
  x86/sgx: Use a list to track to-be-reclaimed pages during reclaim
  x86/sgx: Allow reclaiming up to 32 pages, but scan 16 by default
  x86/sgx: Return the number of EPC pages that were successfully
    reclaimed
  x86/sgx: Add option to ignore age of page during EPC reclaim
  x86/sgx: Prepare for multiple LRUs
  x86/sgx: Expose sgx_reclaim_pages() for use by EPC cgroup
  x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
  x86/sgx: Add EPC OOM path to forcefully reclaim EPC

 Documentation/x86/sgx.rst            |  77 ++++
 arch/x86/Kconfig                     |  13 +
 arch/x86/kernel/cpu/sgx/Makefile     |   1 +
 arch/x86/kernel/cpu/sgx/encl.c       |  90 ++++-
 arch/x86/kernel/cpu/sgx/encl.h       |   4 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 539 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  59 +++
 arch/x86/kernel/cpu/sgx/ioctl.c      |  14 +-
 arch/x86/kernel/cpu/sgx/main.c       | 412 ++++++++++++++++----
 arch/x86/kernel/cpu/sgx/sgx.h        | 122 +++++-
 arch/x86/kernel/cpu/sgx/virt.c       |  28 +-
 include/linux/misc_cgroup.h          |  35 ++
 kernel/cgroup/misc.c                 |  76 +++-
 13 files changed, 1341 insertions(+), 129 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
 create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h

--
2.38.1
