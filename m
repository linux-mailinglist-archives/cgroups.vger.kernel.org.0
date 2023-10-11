Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296D67C4715
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbjJKBOg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 21:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344494AbjJKBOe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 21:14:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742BCB4;
        Tue, 10 Oct 2023 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986870; x=1728522870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+aWvYixK/QEnyhCdwsoE4bCdWWGSbo2ESAPZK4J61QY=;
  b=bB2e2GWAWOvW5lvj8yi1ygHQGogOXzHqvZkclTqGJRuoogACu1BRwB/s
   iGY6IUAd04RTqK0yYP38DtAzd+VBjsI9xWHjL5BuO4X1pQNIQhrZGie9G
   Hfb+3RWzGqc/nzKmUqKzWG875PapGFic/7dPwrucixE0uqy2W9aFoKH9r
   J0IuMnePg/KJqe9v6tGW7QJdTLStMQuUoAEGpgngb24rQ5gyiNUMzYAHy
   rzCHJoJm0hoq3mxmXTGdz/5wMmqXxBTeykoS6mkcWKx5DbyW0v1Vyu3JW
   JJdAqZR8dR5l6xSycU7WjVSPv4zlNaW7KAyEGEzeN7eBNqu8LYp6n8FL9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="470818528"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="470818528"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788793349"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788793349"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 18:14:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 18:14:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 18:14:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 18:14:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 18:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzx7tPGEPvSepJ2eUriFg7bR7AtPjM+4GBmWlZnp4Z3L3mcap11dPvIIqQI8oqQ94MM2f7by/MRm2Vx8TGWDsK2WybdU6FHSPseAk7irMIfe0KiO+h5ktZ5XDf74+NuWCEI9vYdvDE7Tys2sG64d2eYa7ohjcElxGHdnipcZ2DV6KTgiERSIla36cjglvHIV7fDhjocmOh8sDo4ph+GGZglb4v2DjGDN7Ubg/66gm5W6e07IoseDpUq1UTnAoNKcSuzbaYDQv3b+mvezvpAVgqtcSwCk8ob+m/x2ymhNY3c5UUA0O89qDe0wQAntnsNMu91fzbQkOXqsTywZDqKeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aWvYixK/QEnyhCdwsoE4bCdWWGSbo2ESAPZK4J61QY=;
 b=mTISxIxerICoWA7dRlV6qQINiIFxUhz7ebYU7+zegx+FrCiksgrzX9f0yOw6vT46LnZlusFGKiqQAxZg0sc3CG7gBxnOWcyy3DWkuLnz2psvKvOm8js2TLtF6hTJLe6Za0rUoXYKVO85qbGd5roKz/EU77sfOuqd6KMs0E8hZIdQ2MZrfEltACfHfttgBVzyNWpi8lKu43hv5zsjCUtdQ0ZTwa8z9wOWmdaQ79Iyb5pJleCYF9CW6HQ54lUx7FD0jLg4kwRbAMNV8flYCbpZ1GXR/7qI0wMunrABwEyWQ/g3kiy/APBzLtNwGlABIpYfbkp9bzqioF7ECxPW3SaWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB8272.namprd11.prod.outlook.com (2603:10b6:a03:47d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 01:14:22 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Wed, 11 Oct 2023
 01:14:22 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>
CC:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgIAADEaAgAD/w4CAAIz1AA==
Date:   Wed, 11 Oct 2023 01:14:22 +0000
Message-ID: <64147ac7d9f9946cf7e3bc78fc33d7e75864d9db.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
         <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
         <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
         <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB8272:EE_
x-ms-office365-filtering-correlation-id: 6e1fcf33-87ed-43e3-ab27-08dbc9f76740
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtPaUnEP3M/FhSj7ZkOQwk0R/8ehiwZB/Q7cp4yeyGrGKA0/i4efwhLrMlVpdbMdXZAunDa6SG4IWbhO1Dszglw+e+bv0Y5D6gr5TSG1v2TPx5M6tKACBR+ks/RM6hVQM4v+eG35iDKcxbngaE/ZF0JhOBqN8decTbutPLA6e49vAJYgYabL4ZWW3ZC1Di2avhhd9Sd88j6hOkHgw7V1EzsJx65NnyIODaImouddZqECUzJNAXTc/Sd8bVtpRIwaHgc0rYy9LyTKrBwdMy834oNI7uWMs0ObnOiBLGQsVZ09ChEjaWV3ayJpJxcJpDR2H6+3uszJhVOmlqJuu4Om61Hz/w2/w9s09ErzEmyrFBuP8cbIW/bCZmAR4lyUBLXjrI0YUyAIVE7MRflT4lvDjD3/ttcc03iDqWkWfhC0mYQTvtbgzT3B+b9TodMUj0nzZ73h3I8roJmBTf4JXVVQRaCV24fyTNp2WdRDE0XdMWyXveamI3QZjHwcehQ6jZijo6kBzpPKuBTlAjdkT5dW64c6DcwmEmTS8PunyWVF/WKFQF5GuEAShEST5kqC2J/q+PshE60rXNy5tBAIyQ7EEANQY7hmmOS0D7vHZecfqiQpy5TxtTD2a58XSHN+8jw8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(71200400001)(26005)(6506007)(558084003)(38100700002)(8936002)(86362001)(82960400001)(122000001)(36756003)(38070700005)(7416002)(4326008)(4001150100001)(478600001)(8676002)(2906002)(6512007)(41300700001)(5660300002)(6486002)(316002)(66476007)(91956017)(66556008)(66946007)(76116006)(64756008)(110136005)(66446008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JMNTNzOGs0Zk1hSzZSMm5kM3hBSTM3d1ByQ0lNZE9rQ1BFTjVnKzBZL2V5?=
 =?utf-8?B?ZkNlWVlqT1hhSHE3SmtNMEMwbVV5VkJiK2RZekM3RVJwZXByQ3NGbWgzSVRU?=
 =?utf-8?B?cFAwZ09jbVlQdTBjSTBrRHlkM0VQb20xV0N3QnQxOEt3RFFxRjZjQUZwRExM?=
 =?utf-8?B?dFJidTEvSUlWYlJ6Mm5zZUpsTURnZFBubXhRWTRDdzFYRVFiMU5lM3QvRFls?=
 =?utf-8?B?WUpWaFR1dDhldWZkU3pvSXhGLzkzQ1JkbGpKUjMwNjBla29GWEhManplY1JC?=
 =?utf-8?B?OWw1MjRJcUZWaUM3WVN3K1BxMjVJVVllYmM2eG5WSW55UTl5NUttdXhLbnll?=
 =?utf-8?B?MTVaRkZubkFiaXJDSmR4N01vOEhHaUVBcnkzSjI2ekVZMHc2VFZnVkZPRmVX?=
 =?utf-8?B?dWFOVkNBeG9DaE1hWkgxK3l1QllveHd0WDZMRkcwWE9nSTBRSUp4TzV0ZEZS?=
 =?utf-8?B?NlFjRnVMdlRXczRmU0EvRURmc3NSY1hOd3QrcnRZR1UvYldLNzJuUU9QZDFM?=
 =?utf-8?B?OUdORURrNk1DME56RFRaaE9qUDJ4UDVwTlFCWFdaZVZEVlh4ck5ncTNoeThs?=
 =?utf-8?B?S0tWUGNDZUxmeXdCVTZrTkgzMkluMWRmYXpsV1NtOWZiSjBLZEVHM3h1NzF2?=
 =?utf-8?B?M3Nqc1BDRTlIeWhqV1ZMWjlwOEllSXlGcWREQWdpanU1QzEyYzFrVTVkeDBa?=
 =?utf-8?B?Z2M0R3ovdi8vWU9PeEtZSVdxRmVIcERlRXZrSTFvSHJQWVlvVUtxQkFxdjdM?=
 =?utf-8?B?Z0p6aDNaZTRzb2YzU3Z1Uk43TytUeXBxNVh0dkNtbHByTkNUTlB0cGxIY2Q5?=
 =?utf-8?B?TlU1UmVldTU2dGNWNUhMTXVrbk02WWltay9jWTRoU1dydTFMa2F3WHNMZTNN?=
 =?utf-8?B?M1pjc1JudXhXK29vRlVIRytkVjBhUnZSd2kwVEpTbm9sa1dOdU5JV1JXejl2?=
 =?utf-8?B?bWNSZWo1aDhOZDVHTFVwS0xha0ozN0srdEJLL0NyWHdIcFVoYmlBYkhrdVBu?=
 =?utf-8?B?OE9jUkVtTWVSNHcxWHhLbHRBMTJpZ1NGTmwxcnhqc0dSL3VaUU8rR0FYQ1RH?=
 =?utf-8?B?WDhYbDlWczFtcVdvNjVidysrRnZGU1NPQ0FoUDZpQWp1VXV3VG9BOHRGRUQ1?=
 =?utf-8?B?WDJkNDJTeStpeVNYVjRBb1k3Q1dRQncyWi9GYUVZTmNMbTBZdU9YMWNOZ2Qw?=
 =?utf-8?B?QThYK2t0T3dpSGluWnZWL095Yk1jQXVpSGFJK3ZCMXRvTmtSS1A0ZTNmV3pE?=
 =?utf-8?B?UG9MUmlkSXZnNGNrQkF2REVvaDRyVW84MjlqU0FraHg4MnYycG01S3c3OGU4?=
 =?utf-8?B?TWM2TDFVczNlSnYxTm1xUmtDK1NFTHdzdWgrMzhmL1Q2ckV6VEY0cGZQRkpy?=
 =?utf-8?B?THY3aDYxQnlGejBTeHJTaXdvemZTNEprUnpadmgvYStmRXNMSmNNeHptUHRE?=
 =?utf-8?B?R3JkL2lXTWEyK0w2eWFvbDFDSEh2aDkrVVJCZ25YMjdqQVAvVzc3R3dDd1FH?=
 =?utf-8?B?VWJPVVVzR1JDWlg0ZlBWNEsyRUVDSzRxbExicVZid3RXaTJhNlF2ZzJvVjhr?=
 =?utf-8?B?K0diQWNXSnZ1b2NOcUI5UXVzaytVUEpVY3VWWklyOGNlRTlPVTByeXBIRTdp?=
 =?utf-8?B?cHNnczUxb2k0ODd5NjkxOGptTlIrUGJMRE1TN1lDV0VZYXZITXdzM2g0eWpK?=
 =?utf-8?B?VThqcHdmcXVnT2xIZUJKSWVnMTRLd0IyQVhZaE9HTDg5MTYvOWY0cWV5S1la?=
 =?utf-8?B?NE5INVRhNS8ra2lPK3FqUmdiekpaVVozQmM3WVBWMStWUThSTEFHdk9WTEJD?=
 =?utf-8?B?c01yTnBQdEc3NDVUOEYxMk1qTnRzVXlQdHRhcnBmb0pIT2RVa2FsajJTY3lr?=
 =?utf-8?B?c1ZUaCtJQnBFYkEvTnA5YkVtcG8zcmEwQ2FlOXNCSHZ2MFdLQXhDcXJmRWJL?=
 =?utf-8?B?cWJFZzg1UW9XcUVUMk9oMHdRL0pMeFNKRlg0YVNzVXJPbVp6cWN0dndkQ1FZ?=
 =?utf-8?B?VWxzTHdRdmJUaWQ5ODA2cm5OWFJDYVR2L08zaHU2Y0o5L0lGekdGWlJadlZL?=
 =?utf-8?B?bUMxK3kwQ0llMkEyZzEyRFRlb2w2MkdQMUw4cDd2V2MyMGlxUk1yRHJEYVJB?=
 =?utf-8?B?QU5KTWFzb2hZOGtJL2dCcm5xY2ZERUVYa3I2RHgyRVgzWTdTQXpmM1p6TUhR?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02723C3ACE247A40B7BF40479617C26F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1fcf33-87ed-43e3-ab27-08dbc9f76740
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 01:14:22.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VHc5O7QCd79tFNU88xLN6mnGoQ64AZZ/qeUWbENkPoITjCVAT/NQY1+KQcNB3CU5FPaPLE5/PZRuRudeJndlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8272
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDExOjQ5IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIFNHWF9FTkNMX05PX01FTU9SWS7CoCBJIGd1ZXNzIHdl
IGNhbiB1c2UgaXQgZm9yIHZpcnR1YWzCoCANCj4gPiBFUEMgdG9vPw0KPiA+IA0KPiANCj4gVGhh
dCBmbGFnIGlzIHNldCBmb3IgZW5jbGF2ZXMsIGRvIHlvdSBtZWFuIHdlIHNldCBzaW1pbGFyIGZs
YWcgaW4gdmVwY8KgIA0KPiBzdHJ1Y3Q/DQoNClllcy4NCg==
