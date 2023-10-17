Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE657CB806
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 03:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjJQBfG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 21:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJQBfF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 21:35:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D7A2;
        Mon, 16 Oct 2023 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697506503; x=1729042503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oHa4SiANt1kaml88uFYqhB0NRWphxGEA4OzI06WLXUQ=;
  b=KYGw+0a7Qe6bPTUssQ88ZwKX3OuHBFSLuREWSfQOT7dD0gut8TwW3Dux
   wNAA6kfLjG6LEgIsNS0+rALwHZ1Xecl4Tz6xuCAouTble5poTO32Ze4tM
   iGlQD6wUMxrHP7PGMDqy0ModjYRmw1hagKAz4SXTsi26Ri/g1ov9f6c71
   1ma/JlkAu8DsvVsZUIquwUEvt9JmJK3Po0Mjpa8+0gEjvXCGvThvwGNH5
   4LCd5wTxIojoUgf5/GiVYKRbDQp6bQq5F85rDoEwYcHLAHEiKXMOQz4Ey
   b+lDbGKGARMGNfDPni4lMowd2IWsGdtnIYiKtlEN9yIOWqmuIITaUZZdc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365938819"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="365938819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 18:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="732526133"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="732526133"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 18:35:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 18:35:01 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 18:35:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 18:35:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 18:35:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdGY39rvyNM5qfahSa4A0sYHuwZQzFuuxhY7PCv0zPezqVywFC9uPCQd5BgAT/yM0JUomVwe9TwrM9YjzIGIgXtogICpRwTW8+IQ+NN/4+pBQwWRzGH5TyQyGKc87Pel0MFAfXHDocgA9pl31nHrMO5qx2US/NT+BNXMS7m8Irn7ckgx0H9AqS/a73AlvTcESL6uDnO0bmQ6FD2BTAjUUGi8oX9HTs/AW8ZVTJRkr9SSKPfk//X2HIqAnCPeBt+ukiEn28BWklf8QlZU9Nox4TBqA50LiKKh2AiTHCG74IoOVcFPfYNbkwYYbZE8du12PkWmGChnqgstT1hZntnhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHa4SiANt1kaml88uFYqhB0NRWphxGEA4OzI06WLXUQ=;
 b=GlQUmBICTxEWDS+LpHAcyeDUEv+eHPxrJXcggE9sTP5+vizRKgEruzW5iiWrHirR0XRH/KB0PueGAYoxNtB1mueHTTc69tauIeOOzwx69Zi/aIE/+oJH0wgnd7n0AbAKrbtnBCtYbzqwi4XPHWyFjMUN1QBJcCS3MWk95cHueGI+gvsmCiFpUjtjXiSzSIG9dexDTbt7eJIqIcTKTNUm0/mmWRmQB9qSKUNI7rsOVMhrZ+NbkEq6Zgh+AAAggAMzAhB9wgGhpOkUwiezvdN5W6iToYCJzy5sXl816BccnKL2Fh29hM0ktkinIon/6RAdqQQK/MxK4h0HNLLFWba2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM8PR11MB5672.namprd11.prod.outlook.com (2603:10b6:8:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 01:34:57 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 01:34:57 +0000
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
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgIAADEaAgAD/w4CAAIaBAIACZaqAgAYfZACAAJVwgIAAFaKAgAAyY4CAABetAA==
Date:   Tue, 17 Oct 2023 01:34:57 +0000
Message-ID: <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
         <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
         <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
         <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
         <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
         <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
         <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM8PR11MB5672:EE_
x-ms-office365-filtering-correlation-id: 4ef274b7-04d5-49ba-6350-08dbceb145bc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqsQR5SMv5DY1kvcAXLfwLr6Q5JJubSKH49Ppp9OszK5o5T6yvPed532Iahbfjx+OMNtvl8190vSmjMk5T/nA4dwZs6BGwDLPUQ2+xJxRkW4MLGhyX3LFzcXs/ugVfWfpjsNJF5/zcizTmavs7zpZfrbLOJXuK221PqPVwHU/FSeeeorq0K3Ez8MiFa97gviukLJ+nTd7Dy8Fsxf2USxQRmh9nInpS2l6TrA74014stzAO7pJbPBF8zIvoRS2meLND4IGp+9S39FQaovynpXvMF87c7xtpFYXFp0GTkf4jRHLwOEORiMJsL+rHWZ7nbOYtkJMyyeouHO5n+nb7EYGSnJUnTE5VMZxqluiSFAE6rkVBKHtBXIoCy39NwGVgymWSlEAnEXxBQA1LdL5nWeBzWR8CrHM4OtGvXOI9ZTRH95lOW3isgiECtsr2pc4sTN5DfL0j8CATnwdzUCNTxZ8v/kmknqI//qv/nOYvW4/7qGonWLsR1HgVTgY+BZQLMAKKElY8RNUPuQc/+hR59tKGa10p+nIqqa17V9OYBtJwiSZMHMk8Cb+Yu0sSQFI/wtSjVdrIUVVa1NW72ZFPkcm8wiGlKeWGTv4D2tiHHmxZqW4bpJ8JkvwkV6u1oCZb5q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(122000001)(38070700005)(86362001)(478600001)(83380400001)(82960400001)(71200400001)(76116006)(66946007)(54906003)(64756008)(316002)(91956017)(66446008)(110136005)(2906002)(66476007)(2616005)(6486002)(36756003)(6512007)(4001150100001)(41300700001)(8936002)(5660300002)(7416002)(4326008)(8676002)(6506007)(66556008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?USttcUQ1T2IwZEJTSC9hT2psTGhTeG5HVFI4dnh4anlsWThoL2pGdFJxUkVR?=
 =?utf-8?B?eFZubFJLb1ljWlBZUU9EcndtcmFwVEo1TmVCS080dFhVQmtjcFNPUlM4Wmxh?=
 =?utf-8?B?N3FwUG1iRjlReks2dVpCcDEwb1ZZcjJVK3hUZ05TTmJQUTZzOWp3K2FFNFNx?=
 =?utf-8?B?NkpNRjAzc2QvMm1HcG1ZazlLZE5BMzFZTms4bjZoNEVESCt0c0docVI2Zi81?=
 =?utf-8?B?UFNqTjdtenNPWkNtZ2JIZm5uRlg0QzZucjJDL3ZQUlhJdGpCdVRFS3RDbnpl?=
 =?utf-8?B?a3pwTnIwZ2pYb0VJeWErOU1qOTZpY1BzWEtNUUIyekFhTGQrSWhTb2o1MmNY?=
 =?utf-8?B?VTAwaWtTV2JXa1NpSFBOVTYreDVjTWJLcnkyUGNLVTg0MVdTT1JNRE1FdEpy?=
 =?utf-8?B?QTRkb3N6aEhkTjYrS3B5T2ZYZ1VNQmRUZXhIZXNTUXpya05DRmhqSlZTV2FZ?=
 =?utf-8?B?WmsyazYxaXZGMGNLMk1wSVZ6ekdEM3EyUXo4WkwzeGxNTTQwUFVXdFoxL0pC?=
 =?utf-8?B?SkF5Szc4TmhYR1BCZms2bjVhWmpKR0ozSDlYOGI2L3lJZUlIZXk1RmNKQjBI?=
 =?utf-8?B?dUw2NHBYSVlZUE5oY3ltbmljK25pbkxQQVgyRmdzdWMwV3oxQmlJbXFOWS8w?=
 =?utf-8?B?UHhDMUQyTFVJZWdIRFM5V1pCZXlEb0dOcEhPdFNmbWJNMW5FaVBUMTg0MU95?=
 =?utf-8?B?RFcwdldXWlpGQlBjMlZ0VlQ0UW82VHNYL3RrWlBhY0FhTW9ZN3d5NWNuZFgr?=
 =?utf-8?B?cW9jeDdGMHFhYzJRUHRaWjRRMGpUZEZOd0NEcE9zaEU0UElIWFhZQnY3TStz?=
 =?utf-8?B?LzFESzdnTlloZkowWGhSVjRjMGdOOUdJaUhVVXJPcnU1bWRBZEZ6V1MraWcr?=
 =?utf-8?B?NHZuczVKaWthS0d6bEM1TURUejZJY1hiTVlFQ2wrYUJSUVlYSTBRbHlnbEZF?=
 =?utf-8?B?TkF0YTBYTi9CSWdPdWlOVlVnVGJVa1pLYkZ2NHQxemNWNDlRNGZsYy9kQ3Nq?=
 =?utf-8?B?SEdyS2s1bmtMR2xZT0lGcTBXbGU5Um1DbDRJYldHUGJnRGliWkcxQmwrcHFX?=
 =?utf-8?B?aWt2ZmFxL0RkaFN1dHBqaE8vbEFDV01lc0lTRTRmRUlJK1BLUGdLdzFWR0kv?=
 =?utf-8?B?bTIyVEZhb0NOZjBCK2taQjlHWGZwUXorSGlwV2tGNzhONWhZM2R0RXJxemtX?=
 =?utf-8?B?QVFHVnpoelhoZGhHaEdXRWdvY1B1cnMySzM5VTRoVXFzbU5mc2N0aVhVazcz?=
 =?utf-8?B?anMrUGRPZW4wTEgySnZSRVpnNlZPNEpYb2dpdERIYXBTeXdhaEhScDlNVU5M?=
 =?utf-8?B?Qm1tbjBtdGxlQUZ3M2E3eVE3VTV3cnBxVEVjY1ZqdEFPQXV2SVVrQjZHZ3Rk?=
 =?utf-8?B?R3lnbnRpaXh3Qm5xRmdRUVZSb0RLVGFEamxwWjFmdG1HTUR4TzArMDFrelhv?=
 =?utf-8?B?c2liWXhuUlhTaTg2dmF4eUFMUG51dTRPME5sSU9SWnBYZXFpK3RoZzNEN0hW?=
 =?utf-8?B?U1lMRG5RMWZ3WVpWaXdJZHhaSE5qNnU0MG5oVkI4S3B5UDRJSnVleld3K0Mr?=
 =?utf-8?B?QlJTWENwWXQwWm84R05TRlpIci93WEpLM2FwM05WUE9CM3JoZFJsWkI0S3dz?=
 =?utf-8?B?akRTVTV2dXN5SjFlR2tISTZzQnJaTVVsbkZXTmdOQ2F1R01UYVBiWi9LZjJE?=
 =?utf-8?B?c1dQSzB4NjM3TXg2YTdQS2h3cU5TYnl3Z3ByL2x6QTJqVU53ZFlaY0xNSmk0?=
 =?utf-8?B?eVFsZnpESkZNaWZncmgvUlYwVk9MbktSR0QxR0pMUUtUeXlVMEhmUXdkY1RK?=
 =?utf-8?B?cWZlYWhTVXRlODRJMFpLNktEU0JWb2IweUN3SG5RbG9EUDh6UU5KU3FQTG5C?=
 =?utf-8?B?TGp4MTdDSExmMGlqZzVsNUZSNU1lMUtCOWdFUUpYdDVuSUEyeWVsTlczRk44?=
 =?utf-8?B?ZExoZWxwNzJVd00vSnNCU20zL1RZS1F3TlVXWXB2RWpzcnVCdTJ4MFRYRWxh?=
 =?utf-8?B?clNCRUg5Tkc2MVEzSTY4cWNhaGpaMXZDMXo2N1lmYXdMZkhVdE5MSGZocW5r?=
 =?utf-8?B?TzN2ZUlWa0lqeFJDYm9ER3ZIWVRUQldyMGc2b2U1Qm01dllKKzR1eENUSUVI?=
 =?utf-8?B?MSs5UjZBak1sNjZlK3FNZUwyQ0tBaTIzWUF4Y1lTcjhndDQ3T0c2N2g1ZWpq?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D160E31B358FD49B8B166880F676349@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef274b7-04d5-49ba-6350-08dbceb145bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 01:34:57.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xwbrhrub1Ql6QhQ/ybgYNuUbxsXkiuNgGAFHV124/3bY3V1hsQ9ow83KVNE/zjLX9BeZK0tXucrltb2GKcJz3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTE2IGF0IDE5OjEwIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMTYgT2N0IDIwMjMgMTY6MDk6NTIgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiBbLi4uXQ0KPiANCj4gPiBzdGlsbCBuZWVkIHRvIGZpeCB0
aGUgYnVnIG1lbnRpb25lZCBhYm92ZSBoZXJlLg0KPiA+IA0KPiA+IEkgcmVhbGx5IHRoaW5rIHlv
dSBzaG91bGQganVzdCBnbyB0aGlzIHNpbXBsZSB3YXk6DQo+ID4gDQo+ID4gV2hlbiB5b3Ugd2Fu
dCB0byB0YWtlIEVQQyBiYWNrIGZyb20gVk0sIGtpbGwgdGhlIFZNLg0KPiA+IA0KPiANCj4gTXkg
b25seSBjb25jZXJuIGlzIHRoYXQgdGhpcyBpcyBhIGNvbXByb21pc2UgZHVlIHRvIGN1cnJlbnQg
bGltaXRhdGlvbiAobm8gIA0KPiBvdGhlciBzYW5lIHdheSB0byB0YWtlIEVQQyBmcm9tIFZNcyku
IElmIHdlIGRlZmluZSB0aGlzIGJlaGF2aW9yIGFuZCBpdCAgDQo+IGJlY29tZXMgYSBjb250cmFj
dCB0byB1c2VyIHNwYWNlLCB0aGVuIHdlIGNhbid0IGNoYW5nZSBpbiBmdXR1cmUuDQoNCldoeSBk
byB3ZSBuZWVkIHRvICJkZWZpbmUgc3VjaCBiZWhhdmlvdXIiPw0KDQpUaGlzIGlzbid0IHNvbWUg
a2luZGEgb2Yga2VybmVsL3VzZXJzcGFjZSBBQkkgSU1ITywgYnV0IG9ubHkga2VybmVsIGludGVy
bmFsDQppbXBsZW1lbnRhdGlvbi4gIEhlcmUgVk0gaXMgc2ltaWxhciB0byBub3JtYWwgaG9zdCBl
bmNsYXZlcy4gIFlvdSBsaW1pdCB0aGUNCnJlc291cmNlLCBzb21lIGhvc3QgZW5jbGF2ZXMgY291
bGQgYmUga2lsbGVkLiAgU2ltaWxhcmx5LCBWTSBjb3VsZCBhbHNvIGJlDQpraWxsZWQgdG9vLg0K
DQpBbmQgc3VwcG9ydGluZyBWTU0gRVBDIG92ZXJzdWJzY3JpcHRpb24gZG9lc24ndCBtZWFuIFZN
IHdvbid0IGJlIGtpbGxlZC4gIFRoZSBWTQ0KY2FuIHN0aWxsIGJlIGEgdGFyZ2V0IHRvIGtpbGwg
YWZ0ZXIgVk0ncyBhbGwgRVBDIHBhZ2VzIGhhdmUgYmVlbiBzd2FwcGVkIG91dC4NCg0KPiANCj4g
T24gdGhlIG90aGVyIGhhbmQsIG15IHVuZGVyc3RhbmRpbmcgdGhlIHJlYXNvbiB5b3Ugd2FudCB0
aGlzIGJlaGF2aW9yIGlzICANCj4gdG8gZW5mb3JjZSBFUEMgbGltaXQgYXQgcnVudGltZS7CoA0K
PiANCg0KTm8gSSBqdXN0IHRob3VnaHQgdGhpcyBpcyBhIGJ1Zy9pc3N1ZSBuZWVkcyB0byBiZSBm
aXhlZC4gIElmIGFueW9uZSBiZWxpZXZlcw0KdGhpcyBpcyBub3QgYSBidWcvaXNzdWUgdGhlbiBp
dCdzIGEgc2VwYXJhdGUgZGlzY3Vzc2lvbi4NCg0K
