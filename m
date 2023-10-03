Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3C7B71D0
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjJCTeI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 15:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTeF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 15:34:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC33F9;
        Tue,  3 Oct 2023 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696361642; x=1727897642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=szhDA6GXJkITCPgEakIKPoF1NQSgvAe7QmSiarHAZ8I=;
  b=QxTDj8/5BgGVYgUOiDfXDMglrac1CHj/LJmLjh40T5e0DnCPiv3T9AoK
   mKe2zU/2KwCWhe6RIE/JMOIe5O19iUg3eENxwAlJK0yXMh76rMBAqlgwT
   rh8h3W4Ms/iSZV4mx0/LfrPuPCFjz5323FywbNszpx0RO6UvtSE5510A3
   mT8gXw+Jx9Sw9OBX6+GqPwm2cz2K6KnppXzjLf9CJO3QrGulpSq1EW1Ar
   mEh5tnF2akkVOAlyurfLZw83L0/mf3kDlv7s2rT6e6KT2Z/Z827XGAONH
   EtD32aM9KkXcUTeXU3XiRNMrVvgKbrKrfBSfDA+PyjQJhyS62QyYE7rxP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380236940"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="380236940"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 12:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727736185"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="727736185"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 12:33:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 12:33:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 12:33:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 12:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3pX86t3rw/JCDTHLagaRAgLNrXMR8GID8mIB5e22YXNVEMgw9nFPMo7DJZWPLvR9lo2sWEBxGxc8Lq4ht+KQ857ptGPLfufkMpKKohcP34cGvyzhzop3xNfAvg3GmDhdzE74DhHLkKk4D2L9n+emyqRXcLVBaGwz9YzBY9rgm5T4Sx3AqQlAysmtutpQure7+SBhw6cqI2l6jf9rD28+YhqGHShkPk6eEmOaPvvfld3nudqsINCUq2nl5E0wo3bocSD4/Ttcjz9Q4ycJb+kmgrUYo3Vyo7CFrP0725cJKNlF/4Blk3SAHup4FOypSyH2RV/q8YlcQi7gSROUc7xBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szhDA6GXJkITCPgEakIKPoF1NQSgvAe7QmSiarHAZ8I=;
 b=Xf3PSIWUS7EbyIBe2Hjou7Uy3hsHY60SVboj46WRbeEyEA0P2pd48v5aRMkSdcAnu/OOkMmK2OKTIzhNQGv2Fgr5fshA4WX1+9+vWGvn3fUNrqFymvw1o4urOqyovimumEFNffjebPSvsbeCo/toOHTM9xswBWeurnA1xkJ8y9M8fmsvtYnj3h04OIHkt7DMMgVb/6AwCZuDKz7xvAPkFglXcf0/XKoWABVZ9cNZuZ+1PTcEhiV6lOr7zpL/33/ukKjOXB4MrMxf4IlbNKbC4GrTAndNZdiYR8FQLDYdByuiS9wqISfQTOvYMIM8mfHZqHpL2rxW0YlroMY8X/hqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Tue, 3 Oct
 2023 19:33:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 19:33:56 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhang, Bo" <zhanb@microsoft.com>
Subject: Re: [PATCH v5 02/18] cgroup/misc: Add SGX EPC resource type and
 export APIs for SGX driver
Thread-Topic: [PATCH v5 02/18] cgroup/misc: Add SGX EPC resource type and
 export APIs for SGX driver
Thread-Index: AQHZ7csQsuJTu1fSxUmEbr/lUT6MDLAvpK2AgAgONQCAANKYgA==
Date:   Tue, 3 Oct 2023 19:33:56 +0000
Message-ID: <dc441e64f0bf1ef02b7e86956edf95b767a02ca0.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-3-haitao.huang@linux.intel.com>
         <0b24d7ad4de129681a8783f930f48962e572b653.camel@intel.com>
         <op.2b78ee0awjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2b78ee0awjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB5161:EE_
x-ms-office365-filtering-correlation-id: 5e19706b-e513-4a59-765d-08dbc447af1d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e3tiZqQ38suBdp89llRgHlSF+smM8WdI2pC9kqmGgzRpaMKBoqGVK9OrTTeeWIqz8yiBXPdXXv1L4tyjKWiUIOxOS6DiXrJ72pwGZHjQU1dWq/HLhxAKxVHfiEoT2zq7i9HraBVn78biizeHlEuLFWUPHUH0kSS7LjnAP8QuTx24hebvunOFUtYz0LtgUnAqrUhKDaVf5nAIoQkx9qjuNG7fsIWFWQPdXa4PqH0SYAAlICuO+DCtk6BZisABNYg7a16wCDc5IB6/nxtx5yoNZIrjNnEpKjRwqALpGizRTMiJmbqtm6kKj+/Waog88i+MeTfONQNcm4u5DHCpcSQXeZ+77d5zbmW5fmKqH14D1EhkApzrJgOOt6Su2bjgzNiuCME/b37Ocakxv27m5JKjNfQmWiQi8oxW3ZwtoUqohxa7WYkIXc/Mnmc4fQcraFo6lBZgzXdHB1+J0jlYgIZ99SyXhDDGJFPmFQFRX9zEXMIGsTtOh6iW/JapUKc7jciq2b4HgLIwd/6/GyiqgXN1lgiJQapMUvmc2mrJiVqX/zeUPgnM1p8PX58/fTm57KOofdmtGN6QHxI+ODoZn/Xw2TGY6Lo8zOB+Am4sTEIL92LcjfTg73oS/zLU+eI+b4sZAdtfrQ2gU+NtE2CXwhBB4UmSdjZvJHAt4M0xD/FWH0U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6512007)(6486002)(478600001)(966005)(6506007)(38070700005)(921005)(86362001)(82960400001)(38100700002)(122000001)(2906002)(6636002)(91956017)(83380400001)(2616005)(26005)(71200400001)(110136005)(64756008)(7416002)(36756003)(66446008)(66476007)(66946007)(66556008)(8676002)(316002)(54906003)(8936002)(76116006)(5660300002)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHZSM2RyQzVTOW9CY1IrR2Y2Z0t3d2V3bXdEOGJTSisyWDVNM3l1WFcrSUdr?=
 =?utf-8?B?S2NLR1p0clJLWUFIVk5CTE1kSmcwMzNISDR4WHQ4YkRlcDB1b0Nyc0NvZ3FC?=
 =?utf-8?B?WVlUTU81QThCelFKb1gza0ZTaHN2cis2VzhDNmtBK29uRDlTQnE0bXMyQ0Zx?=
 =?utf-8?B?M1JodWpmYlliSmZsemJFc2tuRlIwZnB4QWdZdXdnaWhRekZPSUVwTEwwdVhS?=
 =?utf-8?B?V2IrMnczVldnc2lHVVhSNG93RHhicWNib05ZWFpNc2wwOXE5WGp2V0I2R2hr?=
 =?utf-8?B?cEpObUZJWW1LdzdFT2VwQklmM0J5N0dSa0xpRDZmakFjZWZ5M2RkNERIc2oy?=
 =?utf-8?B?Sml0RHoxVTJQU1RtV1JyYmpQeTd0VWErRkJkVFlEL3pOSzZFNXMveU4rNHdo?=
 =?utf-8?B?MGI1dkdPK1lSOVNaRWM5L3ZUUTU2cDVTRmRLMlpwVXpyNmJucVZueVphTG9i?=
 =?utf-8?B?blVyZnMyaC9lVFVIYmZaN0Z2ZnhyUkI0clM1NVpjbENGaVJNYlBXZHJsNTFF?=
 =?utf-8?B?MXFqRmZjME10WFFXOTJUR2dOUHdaYnAzZE01SHNtMWZTSUExQlg5NFRxc01n?=
 =?utf-8?B?MzBiSG1kd210QU9JRHI0VGlnWnFzZmpQaFB5N3p2MWNUMlYybzh4ZElacGxx?=
 =?utf-8?B?R3h2S0R2WHkvak5FMXlXM20xN1NtRmdwUldNY3ZpblQwU1Qvd1RRdTdnY09p?=
 =?utf-8?B?TFA2RVUvbThjWFVneVFOa0NBSndFRGlBRTNYVmt0Q0NJUFdHU29wMkN6cDNl?=
 =?utf-8?B?SjZaNm1DL1ZuUVZUTWFwQ2d0Z0VHaWxTamxrd2g4eDE2NkNOaW9IQUZBdmxo?=
 =?utf-8?B?UldzNUV5eFpSVy85MEpqaXg3U3BOclpVMDlNbmlGcG5kRzdCWFd2UVczQW9I?=
 =?utf-8?B?SjkzTHhlN3VRblltb2ZwNENvYVY3b2VaZDlhbVFRS0Z5RTVoczlYSXhpUkhL?=
 =?utf-8?B?UDVac09QZFZrUlVWQzl2M0pKS1hyOU9Hb3dDNWpwdXdNSTY5bFh1M2NJcWtu?=
 =?utf-8?B?Nmx4YUk2Z3g4cHQycjU0elJqZ1MwRXlqKzNGOVFxNEZzSUhJOUxqVVRGeU9j?=
 =?utf-8?B?RjZYb1paNFJ0NWdFQmdiWVVpT2lEN2ZMc01FTVFhYVdYQkY1VGppRW10N2Fu?=
 =?utf-8?B?MFRQL1BGRndCbG1GTUZHUDNhSEZKMWY3aUdJNTVaQmdBa05Qd1ZQYXl2V3Np?=
 =?utf-8?B?WkI3K3V0YWZMVHcwY0hML0hTeUhkTmRpQUoxUjhlTHBneElpbmdxVWFCYmxS?=
 =?utf-8?B?SVJPR1R2RjJpTk96b0I2QVdXeUFmZndiMUU4YTMwaVFlYkpWS2pRV0UxWTFB?=
 =?utf-8?B?M2MrbEFsQ2R3SlIvT0dlcGRTRnh0NngrR2x0NktDcHVPelpTcFo3bXM1YUJD?=
 =?utf-8?B?RWYxS1VMMXV5VWttaWVvUjdTbEtDZFo4RFFlRDhtcXhSRmtsd2d1aEU3MjBu?=
 =?utf-8?B?Z1UwSUJ6K0t3V29kUGs0QXhmVEpNSU53SGhad3pFa3h3QmxFNll4YWpNT1ll?=
 =?utf-8?B?SkoxZEVDWHM1RWhyZ0JUZDZpWlFSd0R6bVc5MGJ2dlBmT3VPS1hodlppa0I0?=
 =?utf-8?B?WEthY0U2SjQ4VVlvN201S1BlNUpSNTZVM2YwUXFCZFBRYmFIWlp1d1hJWXRI?=
 =?utf-8?B?bU4rYlpCZmU0aXdJeW5ibFBBamltdEEyaHA1TzVKY3hlOEtyUHdVeEhMT2t2?=
 =?utf-8?B?NEM0TlF3b3NlT2p4NnphMjVqeWY3Z3AzQkZsb3BSTnhJTkpaQlZEZGxycDJW?=
 =?utf-8?B?dmJ1Q3N0Z2toTjU0dlczZlZtejFMK2cySk1xejhPWDk2d0JhWUt6SGozdzN4?=
 =?utf-8?B?Q3VMQ0NrcXB1b1lJdDEzQUlQNmhiNjh1VGw1RnVPVzk4RG1KRnRDNExvWFEw?=
 =?utf-8?B?am5LTXp0UnFGaHFLOEx2bTFIMG9BdkZQMlUydjFTZ1VRZnYwczMwdWt2NzQ5?=
 =?utf-8?B?OU43SzU3WG5hTSsxN29vMjI5L25YQTRjSWdDeWFWVnlGQ2R4Wlg4cjF4L0I5?=
 =?utf-8?B?K2hTblV0Ym1rc3dwWHlxaVVLZ2ZKK0hTdnZNeDZJNVRxOWlrTVpLSXVjT2dG?=
 =?utf-8?B?QS9HdVNBbzNGMEwrZ2UwY3dzOVpqdCt1MFJhT2x6UzNQdG51UU5GeTI5RnFt?=
 =?utf-8?B?UldMN0x2UEpqdWwxcmZDWldFRVU4UW1pdG1mMEhXTVpRZlZ3SW93dk5QZFVX?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73C9C15E27DBAE4C94F7F038B0832C87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e19706b-e513-4a59-765d-08dbc447af1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 19:33:56.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPH+W0Ovime667p0sp7AUKWlNFaM6M/zwb5x+D2In0cF8llGkhAtJJcjBFBJdYZW/l9x5GM0gf3Wolsgl/hWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTAzIGF0IDAyOjAwIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFdlZCwgMjcgU2VwIDIwMjMgMjI6NTk6MTIgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBGcmksIDIwMjMtMDktMjIgYXQgMjA6MDYg
LTA3MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBB
Y2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IA0KPiA+ID4gQWRkIFNHWCBF
UEMgbWVtb3J5LCBNSVNDX0NHX1JFU19TR1hfRVBDLCB0byBiZSBhIHZhbGlkIHJlc291cmNlIHR5
cGUNCj4gPiA+IGZvciB0aGUgbWlzYyBjb250cm9sbGVyLg0KPiA+ID4gDQo+ID4gPiBBZGQgcGVy
IHJlc291cmNlIHR5cGUgcHJpdmF0ZSBkYXRhIHNvIHRoYXQgU0dYIGNhbiBzdG9yZSBhZGRpdGlv
bmFsIHBlcg0KPiA+ID4gY2dyb3VwIGRhdGEgaW4gbWlzY19jZy0+bWlzY19jZ19yZXNbTUlTQ19D
R19SRVNfU0dYX0VQQ10uDQo+ID4gDQo+ID4gVG8gYmUgaG9uZXN0IEkgZG9uJ3QgcXVpdGUgdW5k
ZXJzdGFuZCB3aHkgcHV0dGluZyB0aGUgYWJvdmUgdHdvIGNoYW5nZXMgIA0KPiA+IGluIHRoaXMN
Cj4gPiBwYXRjaCB0b2dldGhlciB3aXRoIGV4cG9ydGluZyBtaXNjX2NnX3Jvb3QvcGFyZW50KCkg
YmVsb3cuDQo+ID4gDQo+ID4gQW55IHJlYXNvbiB3aHkgdGhlIGFib3ZlIHR3byBjYW5ub3QgYmUg
ZG9uZSB0b2dldGhlciB3aXRoIHBhdGNoICgiICANCj4gPiB4ODYvc2d4Og0KPiA+IExpbWl0IHBy
b2Nlc3MgRVBDIHVzYWdlIHdpdGggbWlzYyBjZ3JvdXAgY29udHJvbGxlciIpLCB3aGVyZSB0aGVz
ZSAgDQo+ID4gY2hhbmdlcyBhcmUNCj4gPiBhY3R1YWxseSByZWxhdGVkPw0KPiA+IA0KPiA+IFdl
IGFsbCBhbHJlYWR5IGtub3cgdGhhdCBhIG5ldyBFUEMgbWlzYyBjZ3JvdXAgd2lsbCBiZSBhZGRl
ZC4gIFRoZXJlJ3MgIA0KPiA+IG5vIG5lZWQNCj4gPiB0byBhY3R1YWxseSBpbnRyb2R1Y2UgdGhl
IG5ldyB0eXBlIGhlcmUgb25seSB0byBqdXN0aWZ5IGV4cG9ydGluZyBzb21lICANCj4gPiBoZWxw
ZXINCj4gPiBmdW5jdGlvbnMuDQo+ID4gDQo+IA0KPiBJIHRoaW5rIHByZXZpb3VzIGF1dGhvcnMg
aW50ZW5kZWQgdG8gc2VwYXJhdGUgYWxsIHByZXJlcXVpc2l0ZSBtaXNjICANCj4gY2hhbmdlcyBm
cm9tIFNHWCBjaGFuZ2VzLg0KPiBJIGNhbiBjb21iaW5lIHRoZW0gaWYgbWFpbnRhaW5lcnMgYXJl
IGZpbmUgd2l0aCBpdC4NCg0KVGhhdCdzIGZpbmUuICBCdXQgSU1ITyBmb3IgdGhpcyBwYXJ0aWN1
bGFyIG9uZSBJIHRoaW5rIHlvdSBhcmUgbWl4aW5nIHRoaW5ncw0KdG9nZXRoZXI6ICBBZGRpbmcg
U0dYIEVQQyByZXNvdXJjZSB0eXBlIGFuZCBleHBvcnRpbmcgQVBJcyBkb24ndCBoYXZlIGRlcGVu
ZGVuY3kNCm9uIHRoZSBjb2RlLg0KDQpJdCB3aWxsIGJlIGVhc2llciB0byByZXZpZXcgaWYgeW91
IHNlcGFyYXRlIHRoaXMgdHdvIHBhcnRzIG91dC4gIEZvciBpbnN0YW5jZSwNCmF0IGxlYXN0IGl0
J3Mgbm90IHN1cGVyIGNsZWFyIHdoZXRoZXIgYWRkaW5nIGEgJ3ByaXYnIGlzIGEgcmlnaHQgbW92
ZSBoZXJlIHcvbw0KbG9va2luZyBhdCB0aGUgbGF0ZXIgcGF0Y2hlcy4NCg0KQWxzbyBpZiB5b3Ug
dGFrZSBhIGxvb2sgYXQ6DQoNCjdhZWYyN2YwYjJhOCAoInN2bS9zZXY6IFJlZ2lzdGVyIFNFViBh
bmQgU0VWLUVTIEFTSURzIHRvIHRoZSBtaXNjIGNvbnRyb2xsZXIiKQ0KDQpBZGRpbmcgdGhlIHJl
c291cmNlIHR5cGUgaXMgYWRkZWQgdG9nZXRoZXIgd2l0aCB0aGUgaW1wbGVtZW50YXRpb24uDQoN
ClNvIEkgaGF2ZSBubyBwcm9ibGVtIGlmIHlvdSB3YW50IHRvIHNwbGl0IG91dCAiYWRkaW5nIFNH
WCBFUEMgcmVzb3VyY2UgdHlwZSIgb3V0DQphcyBhIHNlcGFyYXRlIHBhdGNoLCBidXQgdGhpcyBw
YXRjaCBsb29rcyBzaG91bGQgYmUgc3BsaXQuIA0KDQo+IA0KPiA+ID4gDQo+ID4gPiBFeHBvcnQg
bWlzY19jZ19yb290KCkgc28gdGhlIFNHWCBkcml2ZXIgY2FuIGluaXRpYWxpemUgYW5kIGFkZCB0
aG9zZQ0KPiA+ID4gYWRkaXRpb25hbCBzdHJ1Y3R1cmVzIHRvIHRoZSByb290IG1pc2MgY2dyb3Vw
IGFzIHBhcnQgb2YgaW5pdGlhbGl6YXRpb24NCj4gPiA+IGZvciBFUEMgY2dyb3VwIHN1cHBvcnQu
IFRoaXMgYm9vdHN0cmFwcyB0aGUgc2FtZSBhZGRpdGlvbmFsDQo+ID4gPiBpbml0aWFsaXphdGlv
biBmb3Igbm9uLXJvb3QgY2dyb3VwcyBpbiB0aGUgJ2FsbG9jKCknIGNhbGxiYWNrIGFkZGVkIGlu
ICANCj4gPiA+IHRoZQ0KPiA+ID4gcHJldmlvdXMgcGF0Y2guDQo+ID4gPiANCj4gPiA+IFRoZSBT
R1ggZHJpdmVyLCBhcyB0aGUgRVBDIG1lbW9yeSBwcm92aWRlciwgd2lsbCBoYXZlIGEgYmFja2dy
b3VuZA0KPiA+ID4gd29ya2VyIHRvIHJlY2xhaW0gRVBDIHBhZ2VzIHRvIG1ha2Ugcm9vbSBmb3Ig
bmV3IGFsbG9jYXRpb25zIGluIHRoZSBzYW1lDQo+ID4gPiBjZ3JvdXAgd2hlbiBpdHMgdXNhZ2Ug
Y291bnRlciByZWFjaGVzIG5lYXIgdGhlIGxpbWl0IGNvbnRyb2xsZWQgYnkgdGhlDQo+ID4gPiBj
Z3JvdXAgYW5kIGl0cyBhbmNlc3RvcnMuIFRoZXJlZm9yZSBpdCBuZWVkcyB0byBkbyBhIHdhbGsg
ZnJvbSB0aGUNCj4gPiA+IGN1cnJlbnQgY2dyb3VwIHVwIHRvIHRoZSByb290LiBUbyBlbmFibGUg
dGhpcyB3YWxrLCBtb3ZlIHBhcmVudF9taXNjKCkNCj4gPiA+IGludG8gbWlzY19jZ3JvdXAuaCBh
bmQgbWFrZSBpbmxpbmUgdG8gbWFrZSB0aGlzIGZ1bmN0aW9uIGF2YWlsYWJsZSB0bw0KPiA+ID4g
U0dYLCByZW5hbWUgaXQgdG8gbWlzY19jZ19wYXJlbnQoKSwgYW5kIHVwZGF0ZSBrZXJuZWwvY2dy
b3VwL21pc2MuYyB0bw0KPiA+ID4gdXNlIHRoZSBuZXcgbmFtZS4NCj4gPiANCj4gPiBMb29rcyB0
b28gbWFueSBkZXRhaWxzIGluIHRoZSBhYm92ZSB0d28gcGFyYWdyYXBocy4gIENvdWxkIHdlIGhh
dmUgYSBtb3JlDQo+ID4gY29uY2lzZSBqdXN0aWZpY2F0aW9uIGZvciBleHBvcnRpbmcgdGhlc2Ug
dHdvIGZ1bmN0aW9ucz8NCj4gPiANCj4gDQo+IFRoaXMgd2FzIGFkZGVkIHRvIGFkZHJlc3MgSmFy
a2tvJ3MgcXVlc3Rpb24sICJ3aHkgZG9lcyBTR1ggZHJpdmVyIG5lZWQgdG8gIA0KPiBkbyBpdGVy
YXRpdmUgd2Fsa3M/Ig0KPiBTZWU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DVkhPVTVH
MVNDVVQuUkNCVlozVzhHMk5KQHN1cHBpbG92YWh2ZXJvLw0KDQpBZ3JlZSB3aXRoIEphcmtrbyB3
ZSBuZWVkIGEganVzdGlmaWNhdGlvbiAodGhhdCB3aGF0IEkgc2FpZCBhYm92ZSB0b28pLiAgV2hh
dCBJDQphbSBzYXlpbmcgaXMgeW91IGNhbiBtYWtlIGl0IG1vcmUgY29uY2lzZS4gIEkgY2FuIHRy
eSB0byBkbyBpZiB5b3Ugd2FudCBtZSB0by4NCg0KPiANCj4gPiBBbmQgaWYgaXQgd2VyZSBtZSwg
SSB3b3VsZCBwdXQgaXQgYXQgYSByZWxhdGl2ZWx5IGxhdGVyIHBvc2l0aW9uIChlLmcuLCAgDQo+
ID4gYmVmb3JlDQo+ID4gdGhlIHBhdGNoIGFjdHVhbGx5IGltcGxlbWVudHMgRVBDIGNncm91cCkg
Zm9yIGJldHRlciByZXZpZXcuICBUaGlzIGFsc28gIA0KPiA+IGFwcGxpZXMNCj4gPiB0byB0aGUg
Zmlyc3QgcGF0Y2guDQo+ID4gDQo+IA0KPiBJIHdhcyB0b2xkIHRvIG1vdmUgYWxsIHByZXJlcXVp
c2l0ZXMgdG8gdGhlIGZyb250IG9yIHNlcGFyYXRlIG91dC4NCj4gDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXNneC9DVTRINDNQM0gzNVguMUJDQTNDRTREMTI1MEBzZWl0aWtraS8N
Cj4gDQo+IA0KDQpJIGRvbid0IHNlZSBhbnkgY29uZmxpY3QuICBQbGVhc2Ugc2VlIHRoZSBmaXJz
dCByZXBseS4NCg0K
