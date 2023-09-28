Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C77B17BB
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjI1Jls (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Sep 2023 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjI1Jlq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Sep 2023 05:41:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1036A122;
        Thu, 28 Sep 2023 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695894103; x=1727430103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+QuiErjyAzGa5J6sEmJfa61wUPWa3cHY3QTH8mGr7wQ=;
  b=nT+a9N8Z2o6Xi8mGCCKmOs7pZuL5n1bvhl/DPYKf8aLSG/s8+WplUH2L
   svF3vscG6v8LT8+gF9cVv4UYfHUKBeO7uNHdpX3KPeY34pUcjYD5g8hB0
   LDlWk1sDkQLvXFh9oPOkzL91jVsCYu1hCRkGzrsW88b43Lr63/Ql3WUXc
   k7Ira8XxRYJgN+6l0iqWaHqEPXpte0vg7+uB75nbofVZxNn+/4SrM7r9X
   1XY7Idxbjxyv5FCDq1WYm8zWcjoYOUdOMpvYe+vvOZTD8iEPo7fXF0LkP
   yy2WfQ1wzJ5ap/xetbaXuz8yuMnRRQxOIcERTYYmBQ42ovk9NDtU2BLE+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367082208"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="367082208"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784633075"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784633075"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 02:41:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 02:41:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 02:41:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 02:41:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLU+W1I0KHgwT9AbRsq+e55Q3n6nOPbxfX5hYJLtMeYea1pdI0lNQtx9/k2f6CCtFMFm+gXg+3opQblxNCyZcCI6j1XYPPThyJWgVwT8jgHN+LGt1IdyG5MZoKu4YWjmep62JSNO1MgOU6HvJ3rRqooskDbRXOONnWwYGHWxHwnYQo2JItJbWWwJ0ZmC1voyCy8+3/5pq5lBssCKuEz0RrjyTfXI7T2IqoSB5n/GRp2saRFPTK7PwpVVa94pa5tFyVYu+Fm2QVnZz8v87ozJsD8wR3X4v6TsaIpKxqCO30BX5U+ihCa2SGkMQID9eXuLQXk2pf9G/WiOuuSe/fJChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QuiErjyAzGa5J6sEmJfa61wUPWa3cHY3QTH8mGr7wQ=;
 b=bjtqUsYCmuuYwlFYgeRnLQYHVk/jts+lq8yBW9VAqFtYaiKw4WIP2jx0EhhP/+p3qVWnN4QuXnA0UHlZWzoM7yMEZ/r5MhrwYEJNSfZHsO+CxMylzs74kxP4KmoOgx+6yne92V3snyILP3XrQFGurW7/18PAFoYwsXpmT5lYyaqKmXt5cOqF4AhN8UXNAfr+qIthhi7aOybyuGqOTc0pDZlNLgfbWsL4Es/Q+mtHMk4gZdE1aQE4lplAF87HZDS4p6m0zg/r9Z3N96cxb2ldxCng/tH77PpZRTk4gArjV7bVcq+NaMaTesGB8q8F+3DYnFGK2rkRmn/gww/08Lm0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 09:41:33 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 09:41:33 +0000
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
Subject: Re: [PATCH v5 11/18] x86/sgx: store unreclaimable pages in LRU lists
Thread-Topic: [PATCH v5 11/18] x86/sgx: store unreclaimable pages in LRU lists
Thread-Index: AQHZ7csbbOBwGIwhuE+AjDRhd4Uej7AwBFQA
Date:   Thu, 28 Sep 2023 09:41:33 +0000
Message-ID: <e36175f3fcf80929d97dbdf8cc144d30888ed301.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-12-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-12-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: ff15207b-7e51-4e64-c806-08dbc00719e1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIkG/pYWbOhZWHyUmGZZGh1hx0Cic1dXag6sBLJbapPjrJDfx62u0lACXpyYdRFHdleQlT9q2oGI1QR3BB5zsfBTug8OuYejGiXVWZldF/Bm2zGYhG4zAJLAej/JM+N2keBdLYpFwuoacwv385uX9DoIEudvgsqZCFN99KqRaI6IK1/NAJqvg00hEEP5zREK6ND5XFuU+RVkVeWOXRdbCs3pojc/vze3BPrpdkRMPVjMRt3gdAcoUnHIOEX+e8wO0atsPDaeQxz2tIQx/gLkGL8nubKF3a5m0uLTh49NsL/9kNRdhGcu/ROUVhjP9dIpkL5YuSoR0EqXtQQFOFJzs9nPK9O/XeYbAO6urFX/zhXNDOg86ATieox5Gv6OBu6Ws8YXN6iv9U8BPkjfxe0bZ9tZo2WQabzyUuLopVFkem55vM5rgWMvZzdkqVIJSEa0qubpUxGihEMC7Dr3U2dF7rJCs8kBaf74FnBCwxLBsV0iE58LYxmzmNtZCYlVVub60gN5eKpe6BY3gzWpXuBghRWxMNdtfQv/u/gYNfCUYvbj2yuavrsL/lq6o6z7RYzInSeRb54CS7HK7+QJ2zEYGCa4Ax5BbcwkSeQCGGRs75EsxjUn7sDFWxuNzMdv1o6nXthcXbFZ08Bhejn/3gtaOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(76116006)(41300700001)(316002)(921005)(122000001)(82960400001)(110136005)(64756008)(54906003)(66476007)(66446008)(66946007)(66556008)(478600001)(2616005)(91956017)(71200400001)(6506007)(6512007)(6486002)(26005)(5660300002)(86362001)(38070700005)(38100700002)(4326008)(8936002)(8676002)(36756003)(7416002)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkkybnNVRVNMd21nTTZvK1lpWit0QU9OODJnTHJBMUlBMG90TEtPd2ptSzlW?=
 =?utf-8?B?VmJ2ZkJXaVFPTUFNK2J4MUJyYmg4MVMyQU9CS0ZTbXNKaDkrdjBMTGl4V3F5?=
 =?utf-8?B?a0g1Z3FhQk9WbnFIYm5IYjUxTU4vMWw4Vk5qcVFOdmhmQUxITjVLN0tPN2hW?=
 =?utf-8?B?QTdFa2xobjloTHZ5Yjl4Q0RsbUVmeCtMTEdBR0NCNlFYMTBPU2swSDRDNDhP?=
 =?utf-8?B?cDNjNktBVit0TzZVQnNtRlYvNi9LNzlFblRLUHdZVEk1S3JuNW5QR0d5enor?=
 =?utf-8?B?RjhKcGVnMTRnZ1Zhb2xBS1N4bUs3dTV2aW1ncG9naTREc3RMbVROdjJWbXVq?=
 =?utf-8?B?c1M0SUt6YXoxeHdrS0JjNU5qZkZQME9BYVVwbmlhWTN0T3RKWU5mR2o1ejBp?=
 =?utf-8?B?VzdYY214ZGFGd0ozclUxVVJJcm5vVUR2T1lid1J0WDcxWXdubzVPcStGSGU4?=
 =?utf-8?B?d0xvb3h4amp5UUpXTTd1WEZDMXpFbGs4b2pzcEorNzhGeUZOQ2dYSnJYMmps?=
 =?utf-8?B?RW9YN2Jxcnpta1E2a2dXSWRWZ2VjVmxrYXhVcVRWOXdtZEdMeVBLQXY1Rkw1?=
 =?utf-8?B?UzNlejNPRGhFMUhiVnNZN2twc09Gb2hHQUIzMGR3WW5malRXSTZvQ2E5aE1a?=
 =?utf-8?B?SWhYMVozTEdFRjNUQ2RPTHNMaW1SY2NWeGI1QklOVFN5UnBvWGpWZ1ZFNjZI?=
 =?utf-8?B?Y01PVXNiRnNtTVVOQ09YTGxtZ3djS2hvV1ZBRTk4bkl1Vkt2WUFXREY3QkRw?=
 =?utf-8?B?cEQvMVZZbW93UkNtRnRaRHhpbGdEUWRvY1lRVnZuaDFvdVVvQWt4dWEvNTZP?=
 =?utf-8?B?S0ZlanpsNWJuMXkyRTN4OHNUckx0R0w4K3oxNDROV2UwKzlCY2VoVXRuaG1a?=
 =?utf-8?B?QWVXekp6d0laV0xCeW1ZalR0T3NtLzNxTWJmQThlTHMxbVdsYlhZQ0h1WFZ0?=
 =?utf-8?B?d0l2VUVyaEU1Z1ZuaHl1ZkhBUDZjSER5SzVaZmVubWZzUzlmQzdXczdoMnFu?=
 =?utf-8?B?NnU4YWh6RGd2VHA2aithaU5iVDhsdHdYaDdhWCs0dTZNc0Vkc3kzQmQwQlE2?=
 =?utf-8?B?aUJjdWUyUWgyOU04LzlHbUNvZ1lBd1ZBT20rY0d3U2FIaTNGN1ZndmQzeGZJ?=
 =?utf-8?B?aGJwQnhUTCtGNlhEc0NqTmJsd1A1NzdlS1pabFhiaTh0d3pUQ1B2VHhoVnNL?=
 =?utf-8?B?TDZRKzJOTk5FOEhpNzRTYW85VldiYVh1cW9yS1RGT0NWVHdLNGNMSkZqc3Rr?=
 =?utf-8?B?eHgyNW5BQUNjeEllU0xXaVg5UFd1bVdveXdQTk9adW5mcjhUTXBuekROYkpv?=
 =?utf-8?B?WnRYR1FTMGZRSG5LaE5HN25CYjk3NmFTOGcxL0J2cTRnWndmZ0wwUEdkeUJt?=
 =?utf-8?B?MDAwVk0rVVJxV3JNVFpTL0dvN3ZDNmF0OWZTSEovQ0Yyb2QweW5xY3JkZHpl?=
 =?utf-8?B?aE5TZHNGM1NCQmVDUFBwdVdqZ3c1MS9XbXNjcEhrc2hidFBTV2dZa21vd2g3?=
 =?utf-8?B?aWRyQnhESHIxd0p1dDlqeTBjUGR3cmt3RTdHNVJ4bDhjSndDMW9Zd2pBU0Iz?=
 =?utf-8?B?UFJtV3JTcTVtcUpXUTZkSXJNaVpOWTY5cDdZeVFpamptZ3lOOVpDaElnN2VM?=
 =?utf-8?B?RWFjZlhQdE82dk1hSzB5R0lwcTBoRFdkekxwOGh4UWJSRFRzZC9rSnA4ZnhP?=
 =?utf-8?B?RnFNQStWV0UxRGppOFo2SzZ5cm9hQXRPdjF1WEZuazZuVzZ6SmRFVmVDVTZ1?=
 =?utf-8?B?QmxOU3hoQTM0b0xjQkxUY2pIRy9YbTdqVzQzZ1dGZVl0amIzZUJZZGZJWWZK?=
 =?utf-8?B?VkJsNEp1Wkd0cEhHUjE5TjFNZ3gvY2pwNytWT0dVQWEwQkN5UmdxRCswU0Vl?=
 =?utf-8?B?OEN2NzFkejBLdEtIU1BZNEhNdlJScmpPbW9uNWl3S2pqUFlZUVF1ekNudVF1?=
 =?utf-8?B?M1VPMnlUdDVvbnhybmtleVV4bUFWL1JMZkVRcHdUd2gzNEhNWEZZdEVrSVd1?=
 =?utf-8?B?YUo0aEtjZHFUa1M1NE1zUGlTSmNvdDE4TU9qTXZWalBFZUxpbTl6WjJiOTRj?=
 =?utf-8?B?dDRjWVBLRlg3ZjFHQjUyWkQrYnNLNkljaG94LzdVWWo5cTlId21YL1Q2N215?=
 =?utf-8?B?QVhPRFFua1ozai81SEg2VEJWZ2N0bnlXMllaRzJTc3JEQ0hqVHhnWVV2dklT?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F75118557B1904EB408B6D3339EC9F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff15207b-7e51-4e64-c806-08dbc00719e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 09:41:33.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvBe4J4cZ+9fg1T4aixfHk7yRZLjjomp4Kly6qpkHkISaXrSQHKwJKHSmnYJRytI9hQOstxvG9XB2SbxhUGmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYw0KPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3NneC9lbmNsLmMNCj4gQEAgLTc0Niw2ICs3NDYsNyBAQCB2b2lkIHNneF9l
bmNsX3JlbGVhc2Uoc3RydWN0IGtyZWYgKnJlZikNCj4gIAl4YV9kZXN0cm95KCZlbmNsLT5wYWdl
X2FycmF5KTsNCj4gIA0KPiAgCWlmICghZW5jbC0+c2Vjc19jaGlsZF9jbnQgJiYgZW5jbC0+c2Vj
cy5lcGNfcGFnZSkgew0KPiArCQlzZ3hfZHJvcF9lcGNfcGFnZShlbmNsLT5zZWNzLmVwY19wYWdl
KTsNCj4gIAkJc2d4X2VuY2xfZnJlZV9lcGNfcGFnZShlbmNsLT5zZWNzLmVwY19wYWdlKTsNCj4g
IAkJZW5jbC0+c2Vjcy5lcGNfcGFnZSA9IE5VTEw7DQo+ICAJfQ0KDQpUaGUgInJlY29yZCIgb2Yg
U0VDUy9WQSBwYWdlcyBzaG91bGQgYmUgZG9uZSB0b2dldGhlciB3aXRoIHRoaXMuICBJIHNlZSBu
bw0KcmVhc29uIHdoeSB0aGUgInJlY29yZCIgYW5kICJkcm9wIiBhcmUgc2VwYXJhdGVkIGludG8g
ZGlmZmVyZW50IHBhdGNoZXMuDQo=
