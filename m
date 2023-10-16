Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF15F7CA623
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 12:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJPK5s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJPK5r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 06:57:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9166183;
        Mon, 16 Oct 2023 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697453865; x=1728989865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pfpS3s9zTXhhwoO/3wVlC0meTxVqOVSmSKtH9kq0GTk=;
  b=fLrQ/4sXe32f7EKeBUBazcUT0v3fjDtVhUvWGUAi6waP97Xii/YEIOVj
   3j4QLhpjb1YCsqcCV43AWJ8da63WZRFIXjM34XGbulQWH5kG/ySitCVm4
   tsgkGd2q+Il3ymqpCMYU5oOK+tcmX/KbaKAjvZEnFG0056BERgNqJLu1p
   NOIpnCg8deP/oW2XR3Bx2C+Smq5p/vnGclX1Ca2Evif2o4x8hQz3nberU
   zLMq8cF60bKpLwYfbvvlJIN1UtKqg6sQI6/eA7uQuI19HFofjrJdxXR1q
   3uKdk2lQ6bDOzt67diWn+PQ9DmSq3lpWfNfZYTCBDrhWgvXMFNw0ahR5f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382721077"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="382721077"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 03:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790753531"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790753531"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 03:57:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 03:57:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 03:57:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 03:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3HJDBeeVNtAe2aMIOIxNztgSTxHzC0eGmDA0v2K/b5Ob0wX1GELMmdaIJB0CEFvnO2ebNvIt3dKlINIZ4rCDoZm/NZugj0eNjolXkcg8s73Elgi+CCCJab9eCav+E277Yiw57PFHLHd0r132YXFY8UH+uvdmK5DW1d/jcH/DauMrmA0dv+HhkYfCVF2uj0eEbc3pEl2FtwYOlV1XbX4g7pufbz9SjaC9B+oMWhlkp8DPwhywLFccaGhM9oJcQhPnlTIRlTJRZZR3UMNYff0DL4fqnSq/rdSNDzH4fJP6xxy0cFqRNIDQYuBvU3cTIuS31QxrsO5s36459KHj9moxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfpS3s9zTXhhwoO/3wVlC0meTxVqOVSmSKtH9kq0GTk=;
 b=Q2v6N5mgkSXrWegAj39/60PnwxrlvP7R7XlEysLPuyI3fyNx6o9w8cie4nHmQA80TIrRAee69g8KcI6KMnE51+M5hrJvnYCCTgusY1eIwhDM3z0Uw2SMTZKgKFFOtocSEqBXILOQxSJReMkalJKfcXp3LtAhre2ooRbliIiUCStDcm5ps4J0fYeOYI2YHGq+QqeXtsRWMrFW3TreNphJTgcXBBhHX+9h51bQ1V1oIGGSzSdH5DFzgGCmhkAyyEWfdQoMcnRDbZszArmVQgRFU5QoyrsHhjBTYcOvHC+03/uQJ/5Cu7dwWJRgI5uNX+t4vfi7FZTOfgzQuF4XLyc7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 10:57:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 10:57:37 +0000
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
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgIAADEaAgAD/w4CAAIaBAIACZaqAgAYfZAA=
Date:   Mon, 16 Oct 2023 10:57:36 +0000
Message-ID: <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
         <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
         <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
         <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
         <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5865:EE_
x-ms-office365-filtering-correlation-id: 582f664d-fd1e-4298-ce6e-08dbce36b529
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6Z0pm1bXEDVWow7LGh5FF03KMLMgdbjwPn5aVA4SGlYyLoeIaIGqbZzBY8JCUNaduNHl8LSZ8zQls0euUMnF2qKDe9J2BfCyjUVVr/WJMFQzhAdPaIkQbS3MIU7/cG9YBE8dCP0EF62TZAoh0bZTTAWHWWOB5lWhQpVsDTabClPx+cuQjHjV2iV82eOIdH7lfxUYLoPnGvqD4Scqyxv6tiqftQ4ulDEqn6v9lct7pKZ+BW3nUZZpHW9cOwCbvEnalHVpukEo5kJbgNy3wRr9cBfEl6C3TttbCswyL08hXdqapxmAEP36cGOP6BFEW7zOIBaMEzWoJVm5yAU1OwTRA/Cc/T+fsRoIBhS/bJvBosbNxIO1RoAmmnBLy6U990oASqwpc7tx+fR7QOtiS4Y4JQO0MmZWqqrP1oEgtmg3f4nHB+/dxBk91kM67B6bNDr1c8rHzk12vRnf3REMeZTBitmcUFKTaAzYCp9UfvAPWL3Nc+EyVBs+k1PphrJdoF6dIHYNoqn9jqpFNyx41OO/kPZs1ySujkwHr7j9Q/5ZA3h6Ogd+TuoH+4x5JjUt1e8Ax+Smoz2f7hU0rYGo0QC11uMBK9M/k/8WpKQhAn5JAAOJE++P89KNGYpWQP3AaiY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(36756003)(122000001)(82960400001)(38070700005)(38100700002)(26005)(71200400001)(6506007)(76116006)(66946007)(316002)(66476007)(478600001)(64756008)(66556008)(2616005)(66446008)(54906003)(91956017)(110136005)(2906002)(41300700001)(4001150100001)(86362001)(7416002)(6512007)(8676002)(5660300002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5GenZCZDVDV0hja1NkalYrRi93YzZ5T2NZOFNMbnBPMDBzVGFMNmtMQU5y?=
 =?utf-8?B?VHRraWJvRXUvdGhCZ2MwQlRieVNDN0xOWDk5bVUvYmp5VTB4amkvbit4d2tH?=
 =?utf-8?B?dndGUVd5TXRXMmVuK2lTWnRGL1JadTF5cFdJRlg3a1hEcTl0RUs5a3p6OVRM?=
 =?utf-8?B?QjBFWHlnVmZ4TWVsUWRXT29TNzNiK2RNQnJHbFg4Uk1iZDAyRlU4Y2kzZDJa?=
 =?utf-8?B?elkyN2JrUGtkZnJCMkc3VGorbzRrWEdXb2x2RmQ0UUdPQ2NQYzkyMWRCbE1y?=
 =?utf-8?B?YlBma3J5NE05b3NJQXR3ejlMVUxZS3NoM21DMkI2SzUwcUdkcVFpdGFDZjNv?=
 =?utf-8?B?RTVmdEZvRDc0bkxtcThESHRPQmY0YTRTVGFMSmVXNWM2enoxWVJDR09NUDlZ?=
 =?utf-8?B?NFZ0b3l6UlZMbGFmck9LRzVIZGU1TUtYTkwzMkhUVVZsYVBsQldwQkczb0Fa?=
 =?utf-8?B?aGh1Qk5kaWhJSHNKbmNVQlQ1alZjTGFpZHE4UnErZWp3NzNQRmJGdEV1Sm1T?=
 =?utf-8?B?M2JzS0lsTExDZmdRa2NzM2EzTU1EZ0pxQWJicGM2c0xnajZvK2N0TFFkU0cr?=
 =?utf-8?B?OTFHMkhUUWhOaFRPQkpOeC9zay8wMlJTVDRjVnROSUFoWmd6Y0w4SmRpSUV5?=
 =?utf-8?B?eFAwckVqUEhMZGxrK2tHcDFjR2VpZ2p2K2JaREQzeEFsbHBOd001d1hyVjVS?=
 =?utf-8?B?bkpvSG5iZHpDekpyckNPampwT3FPbjZtaFBoUTBjbml6bFF2OXBUMVFwV25Y?=
 =?utf-8?B?V1Zqb1MyeHBNU20wREdsSkcvUUVpNzlyb0VzRTVxdFM0V3prTk9ZdVdmK0Yx?=
 =?utf-8?B?Y21nR1M1NmZjT3I2YzJzQXBUV2lGeVJHWEdDeHhqdjh4RTBGQTBxR3BMQWhT?=
 =?utf-8?B?NXZsOXE2d21jOU9lZE1Qa1J2eHdvbVEzM2N6bmZIZFcrc2g4L09IU0NxZGhs?=
 =?utf-8?B?eUJnVC9UbDN2eFdLSzFjRHIzSno1dTdBdXdETHl5YXR2U282dmQ3NTVNdUFv?=
 =?utf-8?B?eU56WFZRa043K0pqWkFZblJkWUZQdThvc2hadS9FMFpwN3N5bE5vQ2dCbWx2?=
 =?utf-8?B?Y3ZhN2JhNG5odk1PRzlFWjA4SCtWY2ZkaWZhV1hhb0NQSjlacVZpcHJkMzU4?=
 =?utf-8?B?SWVxQlhEVzVqS2pLaVhiY2JNOGF0VkZmMjdZVHlmTVFqQ1oxak9FMStUUXZK?=
 =?utf-8?B?SjlwSGJTM1YvTEdZRkxncUJGejgxWWNsR09kWllTZ09SdklBVGdXaERtbnp6?=
 =?utf-8?B?N3dXbWVUK2o5UkFkcFR5eEUxMkhsN2xWVkJneXhxekY5S1p5ekNESE1oTVJ1?=
 =?utf-8?B?aGNtZElKLzR3T2dad2lxc2pObGhLZG8vWE9NeGdiZlZxcE16L3gxZ2hRQndh?=
 =?utf-8?B?Ym83cTgwM2p4WnpyNGtoUlc0Ni9hcDV6bHF1T3RsdUpaQWx2ZUVNUVhwVWE5?=
 =?utf-8?B?QkxSdFc2VE9BUjQrZFE1WWZLUktGS3RNQXpqSUxybGxSOTh2OTI2ZnNzQ3VP?=
 =?utf-8?B?ZG9CZmt6c2VKUHA1K3RlOExHUUU5SkdPVVd4L3ZKR2RkWC95QW04QXZJNTd0?=
 =?utf-8?B?bUg3eWYyU2J1T0ovaERhZnJISmVmTDJra05hWkMwZTFhUUlQbHc5THNNaFZn?=
 =?utf-8?B?Tm80YkZIdHBZYlIrL3NqOXV1N1dNZ2lYbEViSzlmSW5uNTl1SjkxWUY3MmtI?=
 =?utf-8?B?VnRsZ0hhQk5WREdTNW1KY1hxcjcyblVxS0tadk9XVmc3VHVkM25SekNPS2Rr?=
 =?utf-8?B?Y2pmNC95U0F4MVVRTG90SWptTkFnRkV1OEpkRURqSC9qQVVGdThlT2laOElj?=
 =?utf-8?B?alhNUVBEZlpyaERTM25qVDZIeTA0RnhMeWlwbVB5NWNEZUhVei9LTXJsYnFi?=
 =?utf-8?B?Y1RhMDBJalQ1aDZ1TWg4MWJWNmtqcmtudXFPbTBCOXhPSTVwRTRXeFdERXJj?=
 =?utf-8?B?MWY4dHFHeEloSkNsS281M0NZQllnRHdUOW13YUpvSDExcHN5MFNZY2pyYStv?=
 =?utf-8?B?NDFqd2FCZlQ1amFaVDQ0NmpINFdnVzlKNkVRNjlRTUZBaWhTRkRNTkVwY2Ns?=
 =?utf-8?B?L1I3WVg5ekV1Lzgwa3IyaTRUSWVPbVRKMkErL213cUdtYU5ML3dwaGw2alh1?=
 =?utf-8?B?c21YWFVGL1d3THZ1YVlpekVESDhHQ0ZRekUrNDlMeFp6TlV4cWtDdEtJczZy?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <835E089BCB2EE742A2CDBFBC4016CE46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f664d-fd1e-4298-ce6e-08dbce36b529
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 10:57:36.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxhfTySFHor/gdjF4I+9scQcgHV4SJyQY7ZjdQFYCmq7b9+qbJ+d1bu1lrkqcdi5xtsIyjXL7owDy8FnkZRpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865
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

T24gVGh1LCAyMDIzLTEwLTEyIGF0IDA4OjI3IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMTAgT2N0IDIwMjMgMTk6NTE6MTcgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+IChidHcsIGV2ZW4geW91IHRyYWNrIFZB
L1NFQ1MgcGFnZXMgaW4gdW5yZWNsYWltYWJsZSBsaXN0LCBnaXZlbiB0aGV5ICANCj4gPiBib3Ro
IGhhdmUNCj4gPiAnZW5jbGF2ZScgYXMgdGhlIG93bmVyLCAgZG8geW91IHN0aWxsIG5lZWQgU0dY
X0VQQ19PV05FUl9FTkNMIGFuZA0KPiA+IFNHWF9FUENfT1dORVJfUEFHRSA/KQ0KPiANCj4gTGV0
IG1lIHRoaW5rIGFib3V0IGl0LCB0aGVyZSBtaWdodCBiZSBhbHNvIGEgd2F5IGp1c3QgdHJhY2sg
ZW5jbCBvYmplY3RzICANCj4gbm90IHVucmVjbGFpbWFibGUgcGFnZXMuDQo+IA0KPiBJIHN0aWxs
IG5vdCBnZXQgd2h5IHdlIG5lZWQga2lsbCB0aGUgVk0gbm90IGp1c3QgcmVtb3ZlIGp1c3QgZW5v
dWdoIHBhZ2VzLiAgDQo+IElzIGl0IGR1ZSB0byB0aGUgc3RhdGljIGFsbG9jYXRpb24gbm90IGFi
bGUgdG8gcmVjbGFpbT8NCg0KV2UgY2FuIGNob29zZSB0byAianVzdCByZW1vdmUgZW5vdWdoIEVQ
QyBwYWdlcyIuICBUaGUgVk0gbWF5IG9yIG1heSBub3QgYmUNCmtpbGxlZCB3aGVuIGl0IHdhbnRz
IHRoZSBFUEMgcGFnZXMgYmFjaywgZGVwZW5kaW5nIG9uIHdoZXRoZXIgdGhlIGN1cnJlbnQgRVBD
DQpjZ3JvdXAgY2FuIHByb3ZpZGUgZW5vdWdoIEVQQyBwYWdlcyBvciBub3QuICBBbmQgdGhpcyBk
ZXBlbmRzIG9uIGhvdyB3ZQ0KaW1wbGVtZW50IHRoZSBjZ3JvdXAgYWxnb3JpdGhtIHRvIHJlY2xh
aW0gRVBDIHBhZ2VzLg0KDQpPbmUgcHJvYmxlbSBjb3VsZCBiZTogZm9yIGEgRVBDIGNncm91cCBv
bmx5IGhhcyBTR1ggVk1zLCB5b3UgbWF5IGVuZCB1cCB3aXRoDQptb3ZpbmcgRVBDIHBhZ2VzIGZy
b20gb25lIFZNIHRvIGFub3RoZXIgYW5kIHRoZW4gdmljZSB2ZXJzYSBlbmRsZXNzbHksIGJlY2F1
c2UNCnlvdSBuZXZlciByZWFsbHkgYWN0dWFsbHkgbWFyayBhbnkgVk0gdG8gYmUgZGVhZCBqdXN0
IGxpa2UgT09NIGRvZXMgdG8gdGhlDQpub3JtYWwgZW5jbGF2ZXMuDQoNCkZyb20gdGhpcyBwb2lu
dCwgeW91IHN0aWxsIG5lZWQgYSB3YXkgdG8ga2lsbCBhIFZNLCBJSVVDLg0KDQpJIHRoaW5rIHRo
ZSBrZXkgcG9pbnQgb2YgdmlydHVhbCBFUEMgdnMgY2dyb3VwLCBhcyBxdW90ZWQgZnJvbSBTZWFu
LCBzaG91bGQgYmUNCiJoYXZpbmcgc2FuZSwgd2VsbC1kZWZpbmVkIGJlaGF2aW9yIi4NCg0KRG9l
cyAianVzdCByZW1vdmUgZW5vdWdoIEVQQyBwYWdlcyIgbWVldCB0aGlzPyAgSWYgdGhlIHByb2Js
ZW0gbWVudGlvbmVkIGFib3ZlDQpjYW4gYmUgYXZvaWRlZCwgSSBzdXBwb3NlIHNvPyAgU28gaWYg
dGhlcmUncyBhbiBlYXN5IHdheSB0byBhY2hpZXZlLCBJIGd1ZXNzIGl0DQpjYW4gYmUgYW4gb3B0
aW9uIHRvby4NCg0KQnV0IGZvciB0aGUgaW5pdGlhbCBzdXBwb3J0LCBJTU8gd2UgYXJlIG5vdCBs
b29raW5nIGZvciBhIHBlcmZlY3QgYnV0IHlldA0KY29tcGxpY2F0ZWQgc29sdXRpb24uICBJIHdv
dWxkIHNheSwgZnJvbSByZXZpZXcncyBwb2ludCBvZiB2aWV3LCBpdCdzIHByZWZlcnJlZA0KdG8g
aGF2ZSBhIHNpbXBsZSBpbXBsZW1lbnRhdGlvbiB0byBhY2hpZXZlIGEgbm90LXByZWZlY3QsIGJ1
dCBjb25zaXN0ZW50LCB3ZWxsLQ0KZGVmaW5lZCBiZWhhdmlvdXIuDQoNClNvIHRvIG1lIGxvb2tz
IGtpbGxpbmcgdGhlIFZNIHdoZW4gY2dyb3VwIGNhbm5vdCByZWNsYWltIGFueSBtb3JlIEVQQyBw
YWdlcyBpcyBhDQpzaW1wbGUgb3B0aW9uLg0KDQpCdXTCoEkgbWlnaHQgaGF2ZSBtaXNzZWQgc29t
ZXRoaW5nLCBlc3BlY2lhbGx5IHNpbmNlIG1pZGRsZSBvZiBsYXN0IHdlZWsgSSBoYXZlDQpiZWVu
IGhhdmluZyBmZXZlciBhbmQgaGVhZGFjaGUgOi0pDQoNClNvIGFzIG1lbnRpb25lZCBhYm92ZSwg
eW91IGNhbiB0cnkgb3RoZXIgYWx0ZXJuYXRpdmVzLCBidXQgcGxlYXNlIGF2b2lkDQpjb21wbGlj
YXRlZCBvbmVzLg0KDQpBbHNvLCBJIGd1ZXNzIGl0IHdpbGwgYmUgaGVscGZ1bCBpZiB3ZSBjYW4g
dW5kZXJzdGFuZCB0aGUgdHlwaWNhbCBTR1ggYXBwIGFuZC9vcg0KU0dYIFZNIGRlcGxveW1lbnQg
dW5kZXIgRVBDIGNncm91cCB1c2UgY2FzZS4gIFRoaXMgbWF5IGhlbHAgdXMgb24ganVzdGlmeWlu
ZyB3aHkNCnRoZSBFUEMgY2dyb3VwIGFsZ29yaXRobSB0byBzZWxlY3QgdmljdGltIGlzIHJlYXNv
bmFibGUuDQoNCg0K
