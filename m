Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49127BEFBA
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379165AbjJJA0I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379119AbjJJA0G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:26:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF208A3;
        Mon,  9 Oct 2023 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696897565; x=1728433565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bcKJnafFvrmvV5eix9YhY3Zq8r53X9bDaNnStAeJyDM=;
  b=GDjgJNHeZk+9bFTYHz4D+9PUZJjXi8Biy0Af7itmhcj7Ywnfhpa3qJS4
   BlAQWQWkcIdT6D4yoCt3L/UstNaLfmXm0QVfbGMyLSzKQvSZPwFUs4uFZ
   HV23x1eOaHD/e40diLgtHVREzTKEpCNRFsRHzAseIVk0bsqy3EGAcROzA
   zSW0J7g4wVR8nksJFc+qP6+0GuPkZ2IMN8pYFjarnOwLd4n6x9OmmmCIK
   26Q33+qa12kM0T9vASPRYC8HzTeVwuWk/Rttowu0TymtLD3IyJ1AKmsCu
   MO93MFLxlxhqFtHGVUrFuT5AHH8G5Pq6g/R9XDgWaVWQPq7Hjx5md9qLr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415270019"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="415270019"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="756897664"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="756897664"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 17:26:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:26:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 17:26:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 17:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ8qcZCAndZkw5AEAiqK8P6Amwz+A7m9xEcBPqk7ihqS1tWSjGBg/cUDnUgtbVtiPs0BBT+ZgYb7qj288MmOBtxz+qqFSUnyAt6oeVMEsd7fZwOcd3YlFDqJrCtqhW3fbNkqJWewtl4RK5dS6pcQylf3WHhVwTfFwBBwCfhCvLXjFK319N2w9ckKuq22DODi17Vf466TyRH6yTX5i1XVwvgPq91iD31RLTb9ah0JFIFobr1f1O60NpGke/yZorPeu8df7FIovSKxbmWQtIdPw4VdhHeRFOCC2DroZiZmV+CSyojAJWUJO5bxUJrlGZOXc/bAySzreVy1mPdZ7pbAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcKJnafFvrmvV5eix9YhY3Zq8r53X9bDaNnStAeJyDM=;
 b=GJfosd5GbY1MGVA9TdfE5/M5mRX/pGUYU6Ky1Uf8uh3xozZWxJ4rPHH/qTg2++1auDh/1TPEtBN2vwpibRjXgq7ibXEaAQg4id0W5JzENaVF+taIQpOxHPFsdPxBDJ0oy7gdog3PaF9tlUooO/wBECuwBlb3hDYd708QUAFyYljt8nHY0cZUG45bi+act64aJXFRv0P4HgIzxjYnbY+d2i29y64T3sZnjp+zTXFoa4rljIlBNl44ajQ5yM6vIQ48QFj+y0/O4vkeZLJES72+XAW5qoUlm9e9rNAkpNA1vEdCcqxpIRZcxQefqFou+nE9PZkn4yeuVxxqLNflyDjjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8576.namprd11.prod.outlook.com (2603:10b6:806:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 10 Oct
 2023 00:26:01 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 00:26:01 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Topic: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Index: AQHZ7csxMWGpeN5dZUG6Wyp0ITB+SrBCRRaA
Date:   Tue, 10 Oct 2023 00:26:01 +0000
Message-ID: <0005a998dab64c182c22abc436cbcd36de4240a1.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-17-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-17-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8576:EE_
x-ms-office365-filtering-correlation-id: 317f7daf-125d-4019-827a-08dbc9277b9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqqR1SARZ+BL76mXstr8xvlVQafHstE6hwudcoLG1LAjWSy7LbO3JZv5G4wXXmNBbl9ZcmHWBknx/0xSDTm+gx7vij+FhPfVg/c9je/mSHRRoeSv3Mk02Vuqv1CYwZ/GDInzhBsWOrV6FbECWms4XqBxoHDkXLdShgmZvxT6e5ebGHCRWKu3GkPiCsigWQFOHpGq+9IuxQJWH6mY7DpooZtkQOda9v29w0ETJy0QniUavbAPomjnSm95aDdxWbcOWpol5FcGW6ocQOeHygP/SDPVnMLBm2NQ39RcJQICsow10aczqN6dxfnRPpWm+yuDtZwt21vN4fghRuQy7C1n/3hjY8mOtXLFStQwmbE1gCKdtDdMPyaWjR84b8+1H7jvXXwQdS6fjf8HcGkWw3e54AYZkiQX8SNZLnS50H6iLCc3rK7Y78F5Ow3E86SP6iiUWtut73+/bb1TSiME0Lu2bz3w7XxksiDhb7SrrmVNPxZUkP+lGJ3dY7oxar8XfZhwEqdliAUJWJM9n6iGb5mXrXXSj4KC8MUKmkI/+YFehIUCB2AVrP0lhwpF1XyxHoD4EpdynosRVEuBSm3/sAPQ7Bj68uOUoYxaNQK8ZCfndIjjcqQJwEWSfEvLMZNy0D0EmLVmZhD7jrVsz/Lsw1yfPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(64756008)(66476007)(36756003)(122000001)(38070700005)(921005)(6506007)(6512007)(478600001)(91956017)(86362001)(82960400001)(71200400001)(2616005)(66446008)(26005)(66946007)(54906003)(316002)(6486002)(41300700001)(76116006)(38100700002)(8936002)(4326008)(8676002)(5660300002)(83380400001)(110136005)(66556008)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2ZBWVJLME1UNnpXUEQxYnRpNDR1K1EwK0hwUnZ6THo1TUNacWpONmdFTURz?=
 =?utf-8?B?L2hld1k4OUNqRE16am41eXFNMW1vSkYwL05HMDc4bExDdjltMjFVN28zTlhF?=
 =?utf-8?B?ZGYvRi8rdlFLcS9VdWM0KzlRL2xmTHQ4alhVL3k3SkwxYXFxTm1aUzJpNnB4?=
 =?utf-8?B?SW1aQlNnUDh1dXR3a004L2xDdlhCWnNZWmYybmlpV2JmaUY0YXdJOVQxbGE3?=
 =?utf-8?B?Rm04cEhMWFdWdnJnR2prakxyMzdIeldzRjluenhmQ0hzZnRweFB2T1pyZVNM?=
 =?utf-8?B?NVgrNWttZ2RMRlBKU2RiU3JoY3ZwM2FTZFZ2SllJYmp5ek1RdnFxZVc5MlRH?=
 =?utf-8?B?NjZxMFo3T2NhTTRScTZKc3ZRZXlmSFJ5Y3FLRVJWMmlWMk1keGdiUnYwT0hO?=
 =?utf-8?B?OFI2ZVdFQlZPTVhGRUFNTkFvK3hkaVhHNXVDWTUwNUtuRU9HSHpNVDdZT0lJ?=
 =?utf-8?B?dTFsWlBQd1kzMjF2d0RhZnJrendPT2Q4VFJOeXRQS3VKek1yb2EzY254Mmxv?=
 =?utf-8?B?Z2t5MHVrdHNxZGZEQ0tsZ0hlYzJhQ3JUU2RLQVZDRFBCSW1NY3dmN3hIejkw?=
 =?utf-8?B?NGlCZXdsUDF2NTNqYkZRM1BSTzdOalYxeHNLeDlFelo5MUluN1E4b3ZZL0Qy?=
 =?utf-8?B?YlluVjRicEZZZkExSFZ3STExNE42OFNYSHR5ZTZzZHdQbTBLTGFZdWFoYWhW?=
 =?utf-8?B?MXVkOHhhU2M2OUxVQTA3blFlS0tqR0Q5bHIwdk9TbXVvTnFDbEpGUnBTMkxQ?=
 =?utf-8?B?NlFxOWZqa2RaY2E5bjFZc01kdlBXaVRIR2Y3Y0l3VnBOd3N2ejY3YkJDNVdj?=
 =?utf-8?B?VE1BNkxKaEErOWRZUk1CL3hMVkRoZWVDZHFVZkRLeUY4eE9MbTRwcVNBY0Mx?=
 =?utf-8?B?UXowWGpIYUxiek5GdE1wazE3ZU9HSysxQzRHOE5ZL1ZYd1M0YjBnblpYK1Bw?=
 =?utf-8?B?Umo2S1R4dmVxZjRhREszeE9ReUJvdjdBVGxqRWwzdzFITE9adURybWozTTNt?=
 =?utf-8?B?ZzRtTUJIRlAvTStDOEF2VjkwaXMvdGdXNG1PNHNJS0wwRzVvT2FkdmRYbVJq?=
 =?utf-8?B?MUFicE01V0dNSHRHZmxkQitYSTBZR3FRaWFmZnVMcmpTQjRISzZBemZUajhS?=
 =?utf-8?B?aHdlWU5QMTEyWWZTM0c2ampMd05xRkVVMEdpTEZwSUQrV3R5NklYSmhVSlhx?=
 =?utf-8?B?YURIRmFobGlvNytFMjUxclNNVlIvS1VQTmxUbE5TZ21zZHR0QVFMQ2pPSzNt?=
 =?utf-8?B?S3JmN2FLVnpOQnF1SW5ZcHRnbmYvNEExWFZmZC9PM0tCSWlCV2VsREZJcE5w?=
 =?utf-8?B?UURHS0pDNlFVK3pQTHJHK1B6VzAydU1OdVkzb3R1R2FRanJkRk93M0NDYTVp?=
 =?utf-8?B?Zk93UTRUL1VIenlMNnFlN21yL2VObG9MVmV2ODlwYU9CbHhYTm5BbFFNYWVo?=
 =?utf-8?B?L1Y5UytXc3Y0R0E3cmVlOEM2ZjZDNURBYmkyaENWbFU2N0VKOFRya2hRM3Vz?=
 =?utf-8?B?M20wRHpkL0F4Zm5TdlFaSUY2T3BEVUxRL2xZcFdGU3JadnZFZHd2ODl0M3JV?=
 =?utf-8?B?cnpTK1psS0lqOHlGL2E4NVptV3dWd2JDZHFNeTBnRnFkaTB4ZDdrazcweDNB?=
 =?utf-8?B?ZEdNcSs5L1RqTkl4UlY1TjhPUVVpa1EzaUJubVBRS1VrT2VydVJwWFlvZDNn?=
 =?utf-8?B?MkN1Ky9FUm51NkRSR1BLckd0TExYMThYT2dreTlWTHBMV253aVFROVUvZmdu?=
 =?utf-8?B?MjZINXhlcWxCdlVGcjdsemQvUEprRTRTclFCd2c3NnliRzJPdkF0TGg5My96?=
 =?utf-8?B?ZzhiR3NiSDF6eUNNRHFYR2ZLUm5qVTl5TE5BemxnUEpZSzlESkdyZEN0VTZo?=
 =?utf-8?B?WGpVcWh1TnNPTDdYL1JMeW04MHBVVHpzSHEwcnZXTUF3ZkRFQllsS2xWdDBr?=
 =?utf-8?B?VmpWeVBRS2lCVDl6UlNRa2JjbHVJUW9YcHNVREpGZHhFQk9BNy9NckN4ZjNJ?=
 =?utf-8?B?K09HVkllRWUwSGpyYmdKMlhwanU3N0FWVFBFV09DMTNWcFVENDBlbHBxOEtV?=
 =?utf-8?B?bGt3UkZzNVdwR3VYOWJ3RDkvYVV6S3NMMkgxK2lIckhPM0V1NEkxUGhwQy9L?=
 =?utf-8?B?bHJUYTJlQUVRUGIrVVhHc2M4dThPb2tuWkhwL054RnRmZG1aZFc0NFAzaEdt?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1EF32C6B0C0F429A1C479671047E24@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317f7daf-125d-4019-827a-08dbc9277b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 00:26:01.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muwTHiQatLrqpmF15bIkby5SSlPjQDXrI4/LUeECDpv9y7rFfLLPOJSdrux1XpTLb8bXLFYhvV5Df99FjryK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+IEBAIC0zMzIsNiArMzM2LDcgQEAgdm9pZCBzZ3hfaXNvbGF0ZV9lcGNfcGFnZXMoc3RydWN0
IHNneF9lcGNfbHJ1X2xpc3RzICpscnUsIHNpemVfdCBucl90b19zY2FuLA0KPiAgICogc2d4X3Jl
Y2xhaW1fZXBjX3BhZ2VzKCkgLSBSZWNsYWltIEVQQyBwYWdlcyBmcm9tIHRoZSBjb25zdW1lcnMN
Cj4gICAqIEBucl90b19zY2FuOgkJIE51bWJlciBvZiBFUEMgcGFnZXMgdG8gc2NhbiBmb3IgcmVj
bGFpbQ0KPiAgICogQGlnbm9yZV9hZ2U6CQkgUmVjbGFpbSBhIHBhZ2UgZXZlbiBpZiBpdCBpcyB5
b3VuZw0KPiArICogQGVwY19jZzoJCSBFUEMgY2dyb3VwIGZyb20gd2hpY2ggdG8gcmVjbGFpbQ0K
PiAgICoNCj4gICAqIFRha2UgYSBmaXhlZCBudW1iZXIgb2YgcGFnZXMgZnJvbSB0aGUgaGVhZCBv
ZiB0aGUgYWN0aXZlIHBhZ2UgcG9vbCBhbmQNCj4gICAqIHJlY2xhaW0gdGhlbSB0byB0aGUgZW5j
bGF2ZSdzIHByaXZhdGUgc2htZW0gZmlsZXMuIFNraXAgdGhlIHBhZ2VzLCB3aGljaCBoYXZlDQo+
IEBAIC0zNDUsNyArMzUwLDggQEAgdm9pZCBzZ3hfaXNvbGF0ZV9lcGNfcGFnZXMoc3RydWN0IHNn
eF9lcGNfbHJ1X2xpc3RzICpscnUsIHNpemVfdCBucl90b19zY2FuLA0KPiAgICogcHJvYmxlbWF0
aWMgYXMgaXQgd291bGQgaW5jcmVhc2UgdGhlIGxvY2sgY29udGVudGlvbiB0b28gbXVjaCwgd2hp
Y2ggd291bGQNCj4gICAqIGhhbHQgZm9yd2FyZCBwcm9ncmVzcy4NCj4gICAqLw0KPiAtc2l6ZV90
IHNneF9yZWNsYWltX2VwY19wYWdlcyhzaXplX3QgbnJfdG9fc2NhbiwgYm9vbCBpZ25vcmVfYWdl
KQ0KPiArc2l6ZV90IHNneF9yZWNsYWltX2VwY19wYWdlcyhzaXplX3QgbnJfdG9fc2NhbiwgYm9v
bCBpZ25vcmVfYWdlLA0KPiArCQkJICAgICBzdHJ1Y3Qgc2d4X2VwY19jZ3JvdXAgKmVwY19jZykN
Cj4gIHsNCj4gIAlzdHJ1Y3Qgc2d4X2JhY2tpbmcgYmFja2luZ1tTR1hfTlJfVE9fU0NBTl9NQVhd
Ow0KPiAgCXN0cnVjdCBzZ3hfZXBjX3BhZ2UgKmVwY19wYWdlLCAqdG1wOw0KPiBAQCAtMzU1LDcg
KzM2MSwxNSBAQCBzaXplX3Qgc2d4X3JlY2xhaW1fZXBjX3BhZ2VzKHNpemVfdCBucl90b19zY2Fu
LCBib29sIGlnbm9yZV9hZ2UpDQo+ICAJTElTVF9IRUFEKGlzbyk7DQo+ICAJc2l6ZV90IHJldCwg
aTsNCj4gIA0KPiAtCXNneF9pc29sYXRlX2VwY19wYWdlcygmc2d4X2dsb2JhbF9scnUsIG5yX3Rv
X3NjYW4sICZpc28pOw0KPiArCS8qDQo+ICsJICogSWYgYSBzcGVjaWZpYyBjZ3JvdXAgaXMgbm90
IGJlaW5nIHRhcmdldGVkLCB0YWtlIGZyb20gdGhlIGdsb2JhbA0KPiArCSAqIGxpc3QgZmlyc3Qs
IGV2ZW4gd2hlbiBjZ3JvdXBzIGFyZSBlbmFibGVkLiAgSWYgdGhlcmUgYXJlDQo+ICsJICogcGFn
ZXMgb24gdGhlIGdsb2JhbCBMUlUgdGhlbiB0aGV5IHNob3VsZCBnZXQgcmVjbGFpbWVkIGFzYXAu
DQo+ICsJICovDQo+ICsJaWYgKCFJU19FTkFCTEVEKENPTkZJR19DR1JPVVBfU0dYX0VQQykgfHwg
IWVwY19jZykNCj4gKwkJc2d4X2lzb2xhdGVfZXBjX3BhZ2VzKCZzZ3hfZ2xvYmFsX2xydSwgJm5y
X3RvX3NjYW4sICZpc28pOw0KPiArDQo+ICsJc2d4X2VwY19jZ3JvdXBfaXNvbGF0ZV9wYWdlcyhl
cGNfY2csICZucl90b19zY2FuLCAmaXNvKTsNCg0KKEkgd2lzaCBzdWNoIGNvZGUgY2FuIGJlIHNv
bWVob3cgbW92ZWQgdG8gdGhlIGVhcmxpZXIgcGF0Y2hlcywgc28gdGhhdCB3ZSBjYW4NCmdldCBl
YXJseSBpZGVhIHRoYXQgaG93IHNneF9yZWNsYWltX2VwY19wYWdlcygpIGlzIHN1cHBvc2VkIHRv
IGJlIHVzZWQuKQ0KDQpTbyBoZXJlIHdoZW4gd2UgYXJlIG5vdCB0YXJnZXRpbmcgYSBzcGVjaWZp
YyBFUEMgY2dyb3VwLCB3ZSBhbHdheXMgcmVjbGFpbSBmcm9tDQp0aGUgZ2xvYmFsIGxpc3QgZmly
c3QsIC4uLg0KDQpbLi4uXQ0KDQo+ICANCj4gIAlpZiAobGlzdF9lbXB0eSgmaXNvKSkNCj4gIAkJ
cmV0dXJuIDA7DQo+IEBAIC00MjMsNyArNDM3LDcgQEAgc3RhdGljIGJvb2wgc2d4X3Nob3VsZF9y
ZWNsYWltKHVuc2lnbmVkIGxvbmcgd2F0ZXJtYXJrKQ0KPiAgdm9pZCBzZ3hfcmVjbGFpbV9kaXJl
Y3Qodm9pZCkNCj4gIHsNCj4gIAlpZiAoc2d4X3Nob3VsZF9yZWNsYWltKFNHWF9OUl9MT1dfUEFH
RVMpKQ0KPiAtCQlzZ3hfcmVjbGFpbV9lcGNfcGFnZXMoU0dYX05SX1RPX1NDQU4sIGZhbHNlKTsN
Cj4gKwkJc2d4X3JlY2xhaW1fZXBjX3BhZ2VzKFNHWF9OUl9UT19TQ0FOLCBmYWxzZSwgTlVMTCk7
DQoNCi4uLiBhbmQgd2UgYWx3YXlzIHRyeSB0byByZWNsYWltIHRoZSBnbG9iYWwgbGlzdCBmaXJz
dCB3aGVuIGRpcmVjdGx5IHJlY2xhaW0gaXMNCmRlc2lyZWQsIGV2ZW4gdGhlIGVuY2xhdmUgaXMg
d2l0aGluIHNvbWUgRVBDIGNncm91cC4gIC4uLiANCg0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50
IGtzZ3hkKHZvaWQgKnApDQo+IEBAIC00NDYsNyArNDYwLDcgQEAgc3RhdGljIGludCBrc2d4ZCh2
b2lkICpwKQ0KPiAgCQkJCSAgICAgc2d4X3Nob3VsZF9yZWNsYWltKFNHWF9OUl9ISUdIX1BBR0VT
KSk7DQo+ICANCj4gIAkJaWYgKHNneF9zaG91bGRfcmVjbGFpbShTR1hfTlJfSElHSF9QQUdFUykp
DQo+IC0JCQlzZ3hfcmVjbGFpbV9lcGNfcGFnZXMoU0dYX05SX1RPX1NDQU4sIGZhbHNlKTsNCj4g
KwkJCXNneF9yZWNsYWltX2VwY19wYWdlcyhTR1hfTlJfVE9fU0NBTiwgZmFsc2UsIE5VTEwpOw0K
DQouLi4gYW5kIGluIGtzZ3hkKCkgYXMgd2VsbCwgd2hpY2ggSSBndWVzcyBpcyBzb21laG93IGFj
Y2VwdGFibGUuICAuLi4NCg0KPiAgDQo+ICAJCWNvbmRfcmVzY2hlZCgpOw0KPiAgCX0NCj4gQEAg
LTYwMCw2ICs2MTQsMTEgQEAgaW50IHNneF9kcm9wX2VwY19wYWdlKHN0cnVjdCBzZ3hfZXBjX3Bh
Z2UgKnBhZ2UpDQo+ICBzdHJ1Y3Qgc2d4X2VwY19wYWdlICpzZ3hfYWxsb2NfZXBjX3BhZ2Uodm9p
ZCAqb3duZXIsIGJvb2wgcmVjbGFpbSkNCj4gIHsNCj4gIAlzdHJ1Y3Qgc2d4X2VwY19wYWdlICpw
YWdlOw0KPiArCXN0cnVjdCBzZ3hfZXBjX2Nncm91cCAqZXBjX2NnOw0KPiArDQo+ICsJZXBjX2Nn
ID0gc2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJnZShyZWNsYWltKTsNCj4gKwlpZiAoSVNfRVJSKGVw
Y19jZykpDQo+ICsJCXJldHVybiBFUlJfQ0FTVChlcGNfY2cpOw0KPiAgDQo+ICAJZm9yICggOyA7
ICkgew0KPiAgCQlwYWdlID0gX19zZ3hfYWxsb2NfZXBjX3BhZ2UoKTsNCj4gQEAgLTYwOCw4ICs2
MjcsMTAgQEAgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4X2FsbG9jX2VwY19wYWdlKHZvaWQgKm93
bmVyLCBib29sIHJlY2xhaW0pDQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiAgDQo+IC0JCWlmICgh
c2d4X2Nhbl9yZWNsYWltKCkpDQo+IC0JCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gKwkJ
aWYgKCFzZ3hfY2FuX3JlY2xhaW0oKSkgew0KPiArCQkJcGFnZSA9IEVSUl9QVFIoLUVOT01FTSk7
DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiAgDQo+ICAJCWlmICghcmVjbGFpbSkgew0KPiAgCQkJ
cGFnZSA9IEVSUl9QVFIoLUVCVVNZKTsNCj4gQEAgLTYyMSwxMCArNjQyLDE3IEBAIHN0cnVjdCBz
Z3hfZXBjX3BhZ2UgKnNneF9hbGxvY19lcGNfcGFnZSh2b2lkICpvd25lciwgYm9vbCByZWNsYWlt
KQ0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4gIA0KPiAtCQlzZ3hfcmVjbGFpbV9lcGNfcGFnZXMo
U0dYX05SX1RPX1NDQU4sIGZhbHNlKTsNCj4gKwkJc2d4X3JlY2xhaW1fZXBjX3BhZ2VzKFNHWF9O
Ul9UT19TQ0FOLCBmYWxzZSwgTlVMTCk7DQoNCi4uLiBhbmQgd2hlbiBhbiBFUEMgcGFnZSBpcyBh
bGxvY2F0ZWQsIG5vIG1hdHRlciB3aGV0aGVyIHRoZSBFUEMgcGFnZSBiZWxvbmdzIHRvDQphbnkg
Y2dyb3VwIG9yIG5vdC4NCg0KV2hlbiB3ZSBhcmUgYWxsb2NhdGluZyBFUEMgcGFnZSBmb3Igb25l
IGVuY2xhdmUsIGlmIHRoYXQgZW5jbGF2ZSBiZWxvbmdzIHRvIHNvbWUNCmNncm91cCwgaXMgaXQg
bW9yZSByZWFzb25hYmxlIHRvIHJlY2xhaW0gRVBDIHBhZ2VzIGZyb20gaXQncyBvd24gZ3JvdXAg
KGFuZCB0aGUNCmNoaWxkcmVuIHVuZGVyIGl0KT8NCg0KWW91IGFscmVhZHkgZ290IHRoZSBjdXJy
ZW50IEVQQyBjZ3JvdXAgYXQgdGhlIGJlZ2lubmluZyBvZiBzZ3hfYWxsb2NfZXBjX3BhZ2UoKQ0K
d2hlbiB5b3Ugd2FudCB0byBjaGFyZ2UgdGhlIEVQQyBhbGxvY2F0aW9uLg0KDQo+ICAJCWNvbmRf
cmVzY2hlZCgpOw0KPiAgCX0NCj4gIA0K
