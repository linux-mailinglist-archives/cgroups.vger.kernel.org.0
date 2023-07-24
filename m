Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4775F258
	for <lists+cgroups@lfdr.de>; Mon, 24 Jul 2023 12:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjGXKMt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjGXKMc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 06:12:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13735FCB;
        Mon, 24 Jul 2023 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690193115; x=1721729115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xoUy+sVThULwB+gO/87BBgov24OO84qnKGkh8g5AmU4=;
  b=VBjnUFau6+tHXoDyhpdmGDu9tlq/EiRRzkheuzkGPiK2IcQWf5KQLDHR
   uaF3ffuCy4xaknq3SHlJch2lOCz1p+xCwMVtjtoHzBonE/zmFgc81VVvd
   tP762t0jVg3QoJetX63MneLomI+dRfmC/Nd6ipxqBe+GjSaE+LT90OTVp
   cEdcZqpFggW6VXifSmtzKpK7CDwSWBQyCgqU9zOYHCmDU/npfpqtWLQLg
   6udZ/3vF7zQXEbrB9F0Q3oZAJm8Dz4hVjTCzoRFln08Lvh4nYGF3x2IV3
   HB1+l9Js8/gmOELT1S/BGqu8vsTsZbBmJMhBB/YiR3FA2UQTQfMXwEgat
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="367426822"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="367426822"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="702818469"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="702818469"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2023 03:04:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 03:04:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 03:04:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 03:04:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 03:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goFKS2EodL/QQeQ4sKFEdyeKOrIumsVbFdI8Q/Pi8smirtSCaiVDn+exgmxTdJMfTC9we7i7sC9jU9fh3ZlaIsVpe7ZDM8gi9myGZUDU6nDUnQrYZbtPMJHpXeS85Wta4TA/3HygXdHOEDCR/E0YA0XLC7O9QOhSO5YfdR6xrWQhkpxOllsRy5HSmkh7ACmZDUQDWMn1FsioRxF6qDJnaiU2MRnVKVBthmVNshNrdNJ8FdKo1Wp7BbydqKmMRwAIYUfxRrH7l2/Ca/AyRlo+wgujvs8GgqEjwXPQIn9N/2YBUXKxTpNB8ozZxIR398J0CdDYKOVx8HRkvX1jxss0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoUy+sVThULwB+gO/87BBgov24OO84qnKGkh8g5AmU4=;
 b=diayFZu5bqsVmDtucLCntIITZK6PVa96mdP8pjdM4xBIGpRWk9/ZGV/ZZ8x6uax68Z9a4suJ57v8Lgu2947pqdpvjT9toTrlM6xil1QVocB+nejH7SqKU7+yKkyzmZLNst8/wdk8lUN4fler2gLxfGx1xC3DvP/diQjTScjtpjykG5lyjnmzoIjtzxQ8SrReVFbgSRxB0Ku22NgdWBgf+0pxLDcul5+ji4BzLRt+1rKFZR0byiSHXnZc4wsZWa8UX49+YGTS+d9sNYt7DW0mTOAC/BkzRWGYDM/lNImVyWQjQxPhyYLMLXJVDegmibVKlJM+TPYq89a73v3/xm3pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 24 Jul
 2023 10:04:49 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 10:04:48 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
Thread-Topic: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
Thread-Index: AQHZtRTp1D+N9/I/okeNxDL9R1Ot76+97wAAgAAKcwCACsjugA==
Date:   Mon, 24 Jul 2023 10:04:48 +0000
Message-ID: <4f5496d2e0ea8edba430e7de7304bdd840616146.camel@intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
         <20230712230202.47929-4-haitao.huang@linux.intel.com>
         <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
         <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB7770:EE_
x-ms-office365-filtering-correlation-id: 0dfd20ea-bcbf-4860-3e46-08db8c2d6a02
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7CoA7xua+PHk2kg7UDYbtcY92nsi53hjM+AynutIFMOIeg7n50J7+gVQxq4DpTUPDx7g5QySi6l+xOjU62DQ/l0YugrdXf6zdtwDFs9q9Zd7iwbQjO0+Sju20UXhvAQjORk512eiEOaIowO8+rrD4OsAycpihiG/ZQi7wLqwKi9rvunuXlDzGMkiL9YXMt03i1faEYa4Gb6q9VE1Y4Gp+BhtoVrN0v2n5ojQse9h2Ex7dSMG7RXafz9FjaDQKCsK++lDFmiKUmD9H4wOh/qGuSoZT2J5QBYGujmikz/F1jmj7UPn+s1AD+yx70FGLLSs/Yr+H0hoePERWBzvOfyAvS5fA0hfa6es0ppCB37ieJOFbXjB0PfDRsZ0VKSD87Hb4bcO078xdHgkEgyhIiiCqzNLLE+fla6XlLBEZ0TywqcS1H6/4u+qSRIc9qFu+Y0RUBHXJoeaDL4IuiaBmKnf2KLm890KR6h/7GxtlZHWz8bA9EmwMCKTaS6xIcsKajctCrE7mGaKrOj2THKzq3sSs6OiLtM+E101mX04yk4IsteFBjP7LuzXNE3fJC/S8XiuJvQK90OKLTGqifDdEvT6TW+MwF4gOMOmrW2s8NL/lQn9Qe+S+5MexL9MdIxeyGr982DdGEwyLgnXAKQ52VYyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(83380400001)(38070700005)(2906002)(2616005)(82960400001)(122000001)(38100700002)(921005)(71200400001)(76116006)(66946007)(4326008)(91956017)(66476007)(316002)(66446008)(64756008)(66556008)(41300700001)(6506007)(36756003)(186003)(478600001)(26005)(6512007)(110136005)(54906003)(5660300002)(6486002)(8676002)(7416002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDVIR3MxeEFwN3RJSkdadzhkOWVoVTdJakFCZkRyWEt5a3RRUC9QdlQxdWpV?=
 =?utf-8?B?VmtqTUFhZ0JVWVIzQkp0dHBCR2VvekNGZm9YMi9vZ2JiUk0yamRLaWhlNWRV?=
 =?utf-8?B?eHZvNkVYMGNEQVVXNndEQWx2MTFNUVBtWW9lZXNZMjA2S1F5aGVlTnc0NTM1?=
 =?utf-8?B?emU4M0NKQ0xtMGZncmQ4bE1iY3R0dVptWmJFbko5NDg3RFB5Q282dTlEbmJC?=
 =?utf-8?B?dnYwMmtoZng5alo4T1pEbEU4R0l0eUk5SnZXSGRPU0xwNnV5ZTYxdEVYN3Nn?=
 =?utf-8?B?YjR4QXBTclRlQy9KOXNsZHIvQ1hZNExYbFBjNVkxK25mRHRvQ3dkVi9UMVlO?=
 =?utf-8?B?N054VVRzSGdoUVMzbDR0Q0ZqYng3TTJzaVBkQVdEcUZpUUtSemVvN2cxR05j?=
 =?utf-8?B?UytCWk5Sd2VUWmFyU1J2M3EzOVZ3dFVoaGxLWXRKc0pwV0MwaUZvZXpDYml4?=
 =?utf-8?B?cWFjV3JnSG9Rcy9QRWZQN3NEVFVkTEpjOGxVZGdmTUZuWVY0SkFxVDRlREh4?=
 =?utf-8?B?OFJYVWNtRzh6NURsOHBzUmM2MXZqMUJDMmpvKzU3NUlwUHd4TGRJYWdIaFNF?=
 =?utf-8?B?YVlYQXVtakdLYjB1LzJYR1J2Rjh2SUoyNTRGaTNIWmhkdGxoMC9paUVDNUFC?=
 =?utf-8?B?cjA1VHB4eDdGejFvV2czNG1MQjMydHcrYVZSUmR5eFBZS2VuWkpQcVJTR3Zq?=
 =?utf-8?B?SiszT1lseXNreGc3QysxVVlVb3Z4T1Y1RWtBQ242eHVCdzF3WURHZGZ0NURK?=
 =?utf-8?B?MWFXTFhxb1FYMUlac08zWk1TempFQllNTE9Mb3J0SzJpak5lM2NwTHpDYm9u?=
 =?utf-8?B?eFZBL1pUdHBTam9rajBPalA2YS83SnMvKys5M3hqd3VVUlUyNWxoeVRZMGhU?=
 =?utf-8?B?aExjQ2NMMGJjTldISHNOendsaEZpMUt2YTllbWRRYVhnNG5iN1MzcEN1ZDRp?=
 =?utf-8?B?UjVheWI5cnNVUGYrUlREZ3JoYzV4amp1L1RESHB4UEtjTWltNmhQM0RWanBo?=
 =?utf-8?B?MmZIZjRJb3duZ2tLUFY3bWs4ek5jZzJoeXBVMFlENmEydXdiaXgvMmlmeExo?=
 =?utf-8?B?RHdtdENTZlliWmMrQlBBZ0kvamJzREZVbWNHZTJmQ2pXY0ZlejNXZkYrTXVH?=
 =?utf-8?B?ZlhjN1lYNUFZVExkK05GVWllQ1dZenBjK3VNWTNoYVNOcDQ4QndKaG9YTkww?=
 =?utf-8?B?YmM5RElxUTFHaXpBeEhrMGt5SGtxVk1hazh6akpaYzZWWi80am9GUWFXSjhh?=
 =?utf-8?B?V2JmeXJuSlZGSHY1NEMyUDFXYi9zNFlSZmJNNGoySXF1SnJmL0t3QnRGU1R5?=
 =?utf-8?B?UFNRblpjVFB3dlRRK0syek9ENmpYMzliN1p1bVIySEkraFNXcFFDbi83MVZz?=
 =?utf-8?B?T29JUU1rNGJKcE80T1BZeFVIKzRJbWhwOFI4UFhHcTNGaVh6UStidHBmMzJE?=
 =?utf-8?B?QUVxaXVjYTFZMklJQnJBeWZTd1VVM1lVZTZLazAxaENKNHNweTBBUFpDUDc5?=
 =?utf-8?B?Qmw2TEZyL1hMeCtLS0JNSUEyaEwyQVhUVTdUY0IxZEdabFY3by9Mcjd3YmIr?=
 =?utf-8?B?OHZXWDNOenJ6VEcrUWdseWpabnhnRnVyQ3FrME1jNXA3WFNDU3pYeC83SzVP?=
 =?utf-8?B?ejMxQmxwT05KUlg3OUZsdlRWUTlZcU82MkZSR3JQaENIRHcrUVIvRnJZSWlX?=
 =?utf-8?B?aEVUd09JQ0pQYVVLbkQ2Rk9EQlNjeVUvR3p3U0VvTXBMcUtERURyN1FINXll?=
 =?utf-8?B?SHZoQ2Z2VERVMzJUMk5TR0ZnTEFpc2p1bzcrM0lsVnFoNDBwWWlYQ2lHRC9R?=
 =?utf-8?B?TTVna1ZlTEJIUkxYT1dXeFNBWWdIMzIrVmlzblZGSGc0RXBtdHZpOVgyQ3JG?=
 =?utf-8?B?RElBYUJaNG95L3ZyUFpIS0gvcVY5dklIaHpyUXJHQnlkaHNyaDdLUWdIdU1y?=
 =?utf-8?B?YlFJY1Jxb1hkMHkxSFdmWm5iZjdvZnhONkxUNzFPdkNFUm5ENEFYQjI2aG50?=
 =?utf-8?B?SFhtWVhTS2wyT3gzVk1ybVpYTXpSMHlOQmFaWEZPMFFRZkdnanZaVlc2ZHg5?=
 =?utf-8?B?YzFLcTgxWk1vT21CVGFYc2dPNitNazZId3BvODFyMHhNUlM5SlZXL0FXZmtR?=
 =?utf-8?Q?k9coBfnF2jdcMNyxpGgM+fnov?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7F7F2AA4E911044B1C876BDA49C80EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfd20ea-bcbf-4860-3e46-08db8c2d6a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 10:04:48.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JZeTQSOOkY/B0tJG1zppX+LKjLQA+pTXMkKOcW/TyvXMph/zfhTMr2AM7ebd2/mjZqf29Adohk0Da8LuhSuNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDA4OjIzIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMTcgSnVsIDIwMjMgMDc6NDU6MzYgLTA1MDAsIEphcmtrbyBTYWtraW5lbiA8amFy
a2tvQGtlcm5lbC5vcmc+ICANCj4gd3JvdGU6DQo+IA0KPiA+IE9uIFdlZCBKdWwgMTIsIDIwMjMg
YXQgMTE6MDEgUE0gVVRDLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+ID4gPiBGcm9tOiBLcmlzdGVu
IENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+
IEludHJvZHVjZSBhIGRhdGEgc3RydWN0dXJlIHRvIHdyYXAgdGhlIGV4aXN0aW5nIHJlY2xhaW1h
YmxlIGxpc3QNCj4gPiA+IGFuZCBpdHMgc3BpbmxvY2sgaW4gYSBzdHJ1Y3QgdG8gbWluaW1pemUg
dGhlIGNvZGUgY2hhbmdlcyBuZWVkZWQNCj4gPiA+IHRvIGhhbmRsZSBtdWx0aXBsZSBMUlVzIGFz
IHdlbGwgYXMgcmVjbGFpbWFibGUgYW5kIG5vbi1yZWNsYWltYWJsZQ0KPiA+ID4gbGlzdHMuIFRo
ZSBuZXcgc3RydWN0dXJlIHdpbGwgYmUgdXNlZCBpbiBhIGZvbGxvd2luZyBzZXQgb2YgcGF0Y2hl
cyB0bw0KPiA+ID4gaW1wbGVtZW50IFNHWCBFUEMgY2dyb3Vwcy4NCg0KQWx0aG91Z2ggYnJpZWZs
eSBtZW50aW9uZWQgaW4gdGhlIGZpcnN0IHBhdGNoLCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcHV0
IG1vcmUNCmJhY2tncm91bmQgYWJvdXQgdGhlICJyZWNsYWltYWJsZSIgYW5kICJub24tcmVjbGFp
bWFibGUiIHRoaW5nIGhlcmUsIGZvY3VzaW5nIG9uDQpfd2h5XyB3ZSBuZWVkIG11bHRpcGxlIExS
VXMgKHByZXN1bWFibHkgeW91IG1lYW4gdHdvIGxpc3RzOiByZWNsYWltYWJsZSBhbmQgbm9uLQ0K
cmVjbGFpbWFibGUpLg0KDQo+ID4gPiANCj4gPiA+IFRoZSBjaGFuZ2VzIHRvIHRoZSBzdHJ1Y3R1
cmUgbmVlZGVkIGZvciB1bnJlY2xhaW1hYmxlIGxpc3RzIHdpbGwgYmUNCj4gPiA+IGFkZGVkIGlu
IGxhdGVyIHBhdGNoZXMuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0
b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0BsaW51eC5p
bnRlbC5jb20+DQo+ID4gPiBDYzogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5j
b20+DQo+ID4gPiANCj4gPiA+IFYzOg0KPiA+ID4gUmVtb3ZlZCB0aGUgaGVscGVyIGZ1bmN0aW9u
cyBhbmQgcmV2aXNlZCBjb21taXQgbWVzc2FnZXMNCg0KUGxlYXNlIHB1dCBjaGFuZ2UgaGlzdG9y
eSBpbnRvOg0KDQotLS0NCiAgY2hhbmdlIGhpc3RvcnkNCi0tLQ0KDQpTbyBpdCBjYW4gYmUgc3Ry
aXBwZWQgYXdheSB3aGVuIGFwcGx5aW5nIHRoZSBwYXRjaC4NCg0KPiA+ID4gLS0tDQo+ID4gPiAg
YXJjaC94ODYva2VybmVsL2NwdS9zZ3gvc2d4LmggfCAxNyArKysrKysrKysrKysrKysrKw0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9zZ3guaCAgDQo+ID4gPiBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvc2d4L3NneC5oDQo+ID4gPiBpbmRleCBmNmUzYzU4MTBlZWYuLjc3ZmNlYmE3
M2EyNSAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oDQo+
ID4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9zZ3guaA0KPiA+ID4gQEAgLTkyLDYg
KzkyLDIzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCAqc2d4X2dldF9lcGNfdmlydF9hZGRyKHN0cnVj
dCAgDQo+ID4gPiBzZ3hfZXBjX3BhZ2UgKnBhZ2UpDQo+ID4gPiAgCXJldHVybiBzZWN0aW9uLT52
aXJ0X2FkZHIgKyBpbmRleCAqIFBBR0VfU0laRTsNCj4gPiA+ICB9DQo+ID4gPiANCj4gPiA+ICsv
Kg0KPiA+ID4gKyAqIFRoaXMgZGF0YSBzdHJ1Y3R1cmUgd3JhcHMgYSBsaXN0IG9mIHJlY2xhaW1h
YmxlIEVQQyBwYWdlcywgYW5kIGEgIA0KPiA+ID4gbGlzdCBvZg0KPiA+ID4gKyAqIG5vbi1yZWNs
YWltYWJsZSBFUEMgcGFnZXMgYW5kIGlzIHVzZWQgdG8gaW1wbGVtZW50IGEgTFJVIHBvbGljeSAg
DQo+ID4gPiBkdXJpbmcNCj4gPiA+ICsgKiByZWNsYW1hdGlvbi4NCj4gPiA+ICsgKi8NCg0KSSdk
IHByZWZlciB0byBub3QgbWVudGlvbiB0aGUgIm5vbi1yZWNsYWltYWJsZSIgdGhpbmcgaW4gdGhp
cyBwYXRjaCwgYnV0IGRlZmVyDQp0byB0aGUgb25lIGFjdHVhbGx5IGludHJvZHVjZXMgdGhlICJu
b24tcmVjbGFpbWFibGUiIGxpc3QuICBBY3R1YWxseSwgSSBkb24ndA0KdGhpbmsgd2UgZXZlbiBu
ZWVkIHRoaXMgY29tbWVudCwgZ2l2ZW4geW91IGhhdmUgdGhpcyBpbiB0aGUgc3RydWN0dXJlOg0K
DQoJc3RydWN0IGxpc3RfaGVhZCByZWNsYWltYWJsZTsNCg0KV2hpY2ggYWxyZWFkeSBleHBsYWlu
cyB0aGUgInJlY2xhaW1hYmxlIiBsaXN0LiAgSSBzdXBwb3NlIHRoZSBub24tcmVjbGFpbWFibGUN
Cmxpc3Qgd291bGQgYmUgbmFtZWQgc2ltaWxhcmx5IHRodXMgbmVlZCBubyBjb21tZW50IGVpdGhl
ci4NCg0KQWxzbywgSSBhbSB3b25kZXJpbmcgd2h5IHlvdSBuZWVkIHRvIHNwbGl0IHRoaXMgb3V0
IGFzIGEgc2VwYXJhdGUgcGF0Y2guICBJdA0KYmFzaWNhbGx5IGRvZXMgbm90aGluZy4gIFRvIG1l
IHlvdSBzaG91bGQganVzdCBtZXJnZSB0aGlzIHRvIHRoZSBuZXh0IHBhdGNoLA0Kd2hpY2ggYWN0
dWFsbHkgZG9lcyB3aGF0IHlvdSBjbGFpbWVkIGluIHRoZSBjaGFuZ2Vsb2c6DQoNCglJbnRyb2R1
Y2UgYSBkYXRhIHN0cnVjdHVyZSB0byB3cmFwIHRoZSBleGlzdGluZyByZWNsYWltYWJsZSBsaXN0
IGFuZMKgDQoJaXRzwqBzcGlubG9jayAuLi4NCg0KVGhlbiB0aGlzIGNhbiBiZSBhbiBpbmZyYXN0
cnVjdHVyZSBjaGFuZ2UgcGF0Y2gsIHdoaWNoIGRvZXNuJ3QgYnJpbmcgYW55DQpmdW5jdGlvbmFs
IGNoYW5nZSwgdG8gc3VwcG9ydCB0aGUgbm9uLXJlY2xhaW1hYmxlIGxpc3QuDQoNCg0KPiA+ID4g
K3N0cnVjdCBzZ3hfZXBjX2xydV9saXN0cyB7DQo+ID4gPiArCS8qIE11c3QgYWNxdWlyZSB0aGlz
IGxvY2sgdG8gYWNjZXNzICovDQo+ID4gPiArCXNwaW5sb2NrX3QgbG9jazsNCj4gPiANCj4gPiBJ
c24ndCB0aGlzIHNlbGYtZXhwbGFuYXRvcnksIHdoeSB0aGUgaW5saW5lIGNvbW1lbnQ/DQo+IA0K
PiBJIGdvdCBhIHdhcm5pbmcgZnJvbSB0aGUgY2hlY2twYXRjaCBzY3JpcHQgY29tcGxhaW5pbmcg
dGhpcyBsb2NrIG5lZWRzICANCj4gY29tbWVudHMuDQoNCkkgc3VzcGVjdGVkIHRoaXMsIHNvIEkg
YXBwbGllZCB0aGlzIHBhdGNoLCByZW1vdmVkIHRoZSBjb21tZW50LCBnZW5lcmF0ZWQgYSBuZXcN
CnBhdGNoLCBhbmQgcnVuIGNoZWNrcGF0Y2gucGwgZm9yIGl0LiAgSXQgZGlkbid0IHJlcG9ydCBh
bnkgd2FybmluZy9lcnJvciBpbiBteQ0KdGVzdGluZy4NCg0KQXJlIHlvdSBzdXJlIHlvdSBnb3Qg
YSB3YXJuaW5nPw0K
