Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63B67B7261
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjJCUNa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjJCUN3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 16:13:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43E79B;
        Tue,  3 Oct 2023 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696364006; x=1727900006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wIWXn2orkHkdCuuv1eDfkVWa0HKn8GTn0D2F0bystUI=;
  b=R3+qF2WgyLwm9qqjKMaznJuAy8hHPpMXl+J9dkrZO/ypsl/4l4/nEXn+
   A/1O89WucXBTSArQhvvGnyyj55qWqamo74MxXTArBgC+xtRbseFyAmfHM
   WD1M/U1XjyKoOZQBpYx6/gDLL5FksTncjtAS12yNjinSE8syz0hZrcEC4
   AE5CPxiVYQ8Caz7KAF+0UadMV0gdUEXyqBwcJrFditg1sQMdYY3BI3Qbi
   Y8VOsioS5odLIzhojVnx8eSVCocx+IktRphXFCzVF2gvB9enubJe7QMd6
   1c5lR2vs1W+MT4iGoVeEtapEPlbCM/7XYX3jSloFYFtgD8x/yDPzZZqSn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447137052"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="447137052"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 13:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="754574711"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="754574711"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 13:13:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 13:13:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 13:13:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 13:13:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 13:13:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT5hArYOs9OS1vZKkiKHlZc2yn0OYqnBAwh55wpr/R7CAMMPhSijQ/bpyYR1Oy1UTZ5mUDC+seWZD3k3UYhCyQzAJzUR6SpEtRbprFNH6fLCsCjpOD3+PP7VuVagETS1SAn+7aqJbLeJye0A6m+4yAoY7ne0SpSFmT/8fpJSQMECnoAc7k9ea5tpGw1SW7UZ6Qo1MRbAteNYK4l69Deymd+32mRwoUMWN7Ye/hCwl6akwqjSYPvwvhvQ3vMXFcbV1IIMtqBtRwDP1VrQoEA/8om3P1QmyebciqGQ+BAwUo3G+B3c9lS04h/uBV4lrwtTqBdBgOfGvDGrT9QKJLD3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIWXn2orkHkdCuuv1eDfkVWa0HKn8GTn0D2F0bystUI=;
 b=Wesnw2VDXTBa/kpvPm024YzeKPjTeMvAPrSGiVvgbcLJt2sXCh7FLnW2mB3X+5dkCmbcdNJ56r0tZ+hAQjdgyx2tkADEBZeK/8R87ptzacOpi87BukR65su1vGmQ2MmTmIFUXGChsXDwLJp55eVRVdukaqfBVVZOYEJhaD4WbvQ777Ck3xuljs+QGrQt9/xxhQ9CyRyb9v8PnKFhrSXyZKLsh3RZg+8XNd8OS3kA0OjR0IGBmgdbssvAzBpRq8NgeMJnz3QAqe2ZbHW8xHikVxg/HMvVp/Dfn2h/0ZbNGJl3OfRkzXiQwnENjrGvhlWIaLyQQuAhzvPaaaO1qrGQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8322.namprd11.prod.outlook.com (2603:10b6:a03:549::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 3 Oct
 2023 20:13:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 20:12:59 +0000
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
Subject: Re: [PATCH v5 11/18] x86/sgx: store unreclaimable pages in LRU lists
Thread-Topic: [PATCH v5 11/18] x86/sgx: store unreclaimable pages in LRU lists
Thread-Index: AQHZ7csbbOBwGIwhuE+AjDRhd4Uej7AwBFQAgAeRWQCAAPq4AA==
Date:   Tue, 3 Oct 2023 20:12:59 +0000
Message-ID: <c3528ef6d35163a0964a560ed6db8a62170cdf70.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-12-haitao.huang@linux.intel.com>
         <e36175f3fcf80929d97dbdf8cc144d30888ed301.camel@intel.com>
         <op.2b73j62kwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2b73j62kwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8322:EE_
x-ms-office365-filtering-correlation-id: 0b76fe53-3228-4bc1-77a7-08dbc44d240d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kz9/HMi4Az2mtbyl2YSJriZqkPFaqAxyrtiT1qIQEpk1PceNaWW/wcD2B5scN0CTh4peyoBJ1LaCUJHGZvaw1BdAVtGwG63sRHy+3ROLlesL9BfMvzYGG1VZad0GAYWMs9uiO576NHDpJBSOWbGMjJS3MEcsGgKs/vIvoEkMA8aVpA9CqaeXa+lYu5wziN63OfYWIUtE2gkVNDnFcEJsRBdVOknO/A4w9UbUQvT17yXQNR8KQJBbCCRJNCUd167qUa4OXc8KL0zban0zjekJnD7398lO3p4TujVgbSFIExwjb/dwyxaF0RvP0xFyrQ5QqoX0SuCK7wly6VEMWbdcYyWWq3Zd2uyEiA0AWNI6ful8iyg8frCk4R6e+timT7zTo6RS2d8x0vLJ4fxAy1UG3aX4zKX053+NTWSv4kbMerq3FLnIdrRGyiC8enRx7SnKJU2dinqn9RD/QvYo9ZRlQYg5mcgoJK39AXkzvC/bDDC4KRGQA5K4sQWBVh6rzX/qk/KpsU+N2zzM+ZF4H4cyO2VgQ4j8mGXTmhLWih49lzJa8PjEEqqrU1UpdDe+BkVkDl1+OBtbYcHDUmFKcLqyKDbwAC+spKNjscKyUwM9Mqsdr4wux+g2BT+AJHssMhvd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(6506007)(6512007)(86362001)(38070700005)(921005)(82960400001)(38100700002)(122000001)(36756003)(7416002)(2906002)(26005)(71200400001)(6486002)(478600001)(6636002)(8936002)(4326008)(316002)(8676002)(41300700001)(5660300002)(66946007)(66476007)(110136005)(91956017)(54906003)(66556008)(66446008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1JWWUl5NlFiRU9xaDF0V0U3azZpdFd4RkVDR3M5YnpvQWFYUy9ibnpGNFA4?=
 =?utf-8?B?M0ZmWkh1VU9oc2dJajZ4OXVIRlRGRE1vdmxIZFVNV2hjSG9HUnU3cGZFQTFP?=
 =?utf-8?B?aWhQM1RxVWo5TDZQdEF6dzFiMERNcERLbWorTnBrUWc5MVlzTnhyN243Sjl0?=
 =?utf-8?B?b3Z5ek5yV2phRlpCNStHcTVPT0I5d2ozcjF6TmFLM0tCSVhSbUU1d2txSFBW?=
 =?utf-8?B?M0JmN2c2UGtzWGRlQU10elhpc2hGbzRHbDNSOWlBZ0xrZVVyeExCajVlc012?=
 =?utf-8?B?QmNNSDBCL00zSWExSEovQ3UvaUR1REJlUHBjMGY3ZGw1Vzkwd0RWQ3pQSmoz?=
 =?utf-8?B?OGNLeVp0YzdGLzZqYWFVUm14VDhUTTFoUDFSQURScU5WVDY5V2Y2eXpaTC9s?=
 =?utf-8?B?ZkNpTy9pOVFPclpLajcrUEQ2N2xWUWpud25ZQkNZUTFZclAxNHkzcVZ0Zks0?=
 =?utf-8?B?Q0xXVUt3YThWV2kvd3J4V0Y2bkwrYnF1MFJscW9Jd1kvZmZLTitOUU5ubVk0?=
 =?utf-8?B?WTVGcUdYY2VnUE40UjRJYkUxYmRIcUp3ZGRiZEZwdGo5ZkwvTlh4UUc2UUJr?=
 =?utf-8?B?ejRvVi93QWpXVXk1RVR3OWM1Y2c5Q0FFL1lwNzhjR0NCUlZBU0RFNmltVkRH?=
 =?utf-8?B?MmRDM1hPTWhKeVNMRDNZelJOb1k5QUtkMm9HQXIxM1ZVQldMZEN0cEZkUFpF?=
 =?utf-8?B?VXRlYW5lNFhsV2lEQlRzWlR4aHVCM0JoMTA1TTAxK2RvMm1lVEEwckx2V1gy?=
 =?utf-8?B?ZkNQQlVTWm84bDJvbWNJZlZicEpYUmYwTS9TdTd5K3d2QnpmSm9oK0FPSEZj?=
 =?utf-8?B?enNMMWU4MWlqamExT0lLQnhuRkU5TVlETSt4bFloNFU3L28rd3JjV1VhRmc2?=
 =?utf-8?B?c3dnVWNPUnJhV0xQVzFIVTA4cmZaYmNDakE1cVMvTFROMkZkRnBCYkZlTXVy?=
 =?utf-8?B?TzgvZGVZaTV3RkVQeW5UeWVVQWg4VUJ3NmxXRkZHTEcva0hXV2RObmdwOXEx?=
 =?utf-8?B?SnNHQVE2TFBiMkd6R2owQ3ZsaEpJQ3h1RDNRbzdDZ2hncDFGM3M0M0xiQ0E2?=
 =?utf-8?B?QUhuaklRYURFRTBuOENrN0JGVHRnYzhYSm16bm5IZUlTS3pkMmZhWFl4QzB6?=
 =?utf-8?B?WDJubklNcXo3OFp4Z1pzdHRSbkNWSFNSMDJvVjFvWWFVV1pKZ1Fwem1CYktB?=
 =?utf-8?B?UWwxSUJnSWtjYVBWTGNwS3FaWFVDRSt3WGJNZ2s3cm9MMHV0aXdzSlphSDQy?=
 =?utf-8?B?eDBCTGp0aUh1ZWJjeTZ6S25ybUF0WlZRU2NhTmpvTHV3dGlRWXB4M3NHL2xR?=
 =?utf-8?B?S0txZW52bGpocW5kRjJLTXhBYTVVR3BXc1RmOFY5V05vcENYOXpCWXB4UzFK?=
 =?utf-8?B?UWNxQ3duOVlHSGtuaVRHazlmSEpzK0UwKzM4a0ZENklPVm1mWitCYkRiQWVX?=
 =?utf-8?B?bFIybGlqZVdaRW5TbmpQVTVIOFRHb29yRXp5MmgwTS96d0txWlpmOS9KOXFr?=
 =?utf-8?B?ZmoyNVBLcDhEV1BrK0JZUTkwUEhaOGE0VlVJNVppVEsyVEswYTVRaHorS1Z2?=
 =?utf-8?B?WHphRTNwT1pjYkMvMGFzSitrRGFtblAzeEJxRFlTSDkrNWhvRHpGbjdULzJ1?=
 =?utf-8?B?UWhnNTg1WnJ1b2FrRzRpMFYwYlhGOWhrb1FSbUxxNDZadXJnZVJITDdZbUlQ?=
 =?utf-8?B?Vkt3dzdGNkpZNUtkeTJ4Z3g4d0h2eTNwRndhbEFtWm1UZXpSZ1JIMy9JRnRY?=
 =?utf-8?B?T1M2ZjdGNStqaThDMm5pTUtiaThyMmlYYkgzY0Y4Z2JTZUFlZGVmMUhFOXJZ?=
 =?utf-8?B?eXE0VE8xc0pMYVUxT3pxdUR2MVlvWlBqYyswdjdWZDdjb3BoMU10c3VkOEpX?=
 =?utf-8?B?Vm1TK1FnWTZuQ1FFbW1KRnBGLzJCdVpNS2pkSzMrZkZNQnp0ZnNMblVkSkMy?=
 =?utf-8?B?czJDbVdDbDhQSDdpUTFaWXdNU08vYlY0RjdLUDlmYmtvVHR1dmtZcCtyQWdY?=
 =?utf-8?B?RzZ1M2xjQ0ZvNmNpV0o3d0NGSisrTm1lT1FpR0E4bitKbGtrcHdiNjFmODFv?=
 =?utf-8?B?ZlAvNitoRmovV2t3UE9wTllBTEVzU2JqTzI4dm90Q21LTzJiS3ZBV1pQT2pH?=
 =?utf-8?B?SmZaYnNJNmxOdmswdEtyeG5FOE5aWXd6OTRpOUFYcDhGTk1DSW5OcXpIcGNr?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9D80613D00D4E48A93E1A7599318A2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b76fe53-3228-4bc1-77a7-08dbc44d240d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 20:12:59.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkb6MsPQcbyFFahYAg2uDC/lsXxXlwG2OvzFzvPD3PqaN5rop2JKDU1lZpvvUzIsYgjedE4OhmfPn8PSZEO2aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8322
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

T24gVHVlLCAyMDIzLTEwLTAzIGF0IDAwOjE1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFRodSwgMjggU2VwIDIwMjMgMDQ6NDE6MzMgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvc2d4L2VuY2wuYw0KPiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5j
bC5jDQo+ID4gPiBAQCAtNzQ2LDYgKzc0Niw3IEBAIHZvaWQgc2d4X2VuY2xfcmVsZWFzZShzdHJ1
Y3Qga3JlZiAqcmVmKQ0KPiA+ID4gIAl4YV9kZXN0cm95KCZlbmNsLT5wYWdlX2FycmF5KTsNCj4g
PiA+IA0KPiA+ID4gIAlpZiAoIWVuY2wtPnNlY3NfY2hpbGRfY250ICYmIGVuY2wtPnNlY3MuZXBj
X3BhZ2UpIHsNCj4gPiA+ICsJCXNneF9kcm9wX2VwY19wYWdlKGVuY2wtPnNlY3MuZXBjX3BhZ2Up
Ow0KPiA+ID4gIAkJc2d4X2VuY2xfZnJlZV9lcGNfcGFnZShlbmNsLT5zZWNzLmVwY19wYWdlKTsN
Cj4gPiA+ICAJCWVuY2wtPnNlY3MuZXBjX3BhZ2UgPSBOVUxMOw0KPiA+ID4gIAl9DQo+ID4gDQo+
ID4gVGhlICJyZWNvcmQiIG9mIFNFQ1MvVkEgcGFnZXMgc2hvdWxkIGJlIGRvbmUgdG9nZXRoZXIg
d2l0aCB0aGlzLiAgSSBzZWUgIA0KPiA+IG5vDQo+ID4gcmVhc29uIHdoeSB0aGUgInJlY29yZCIg
YW5kICJkcm9wIiBhcmUgc2VwYXJhdGVkIGludG8gZGlmZmVyZW50IHBhdGNoZXMuDQo+IA0KPiAi
cmVjb3JkIiBvZiBTRUNTL1ZBIHBhZ2VzIGFyZSBkb25lIGluIHRoaXMgcGF0Y2guIEJlZm9yZSBu
b3RoaW5nIGRvbmUgaW4gIA0KPiAicmVjb3JkIiBmb3IgdGhlbSBiZWNhdXNlIG5vIHRyYWNraW5n
IExSVSBsaXN0cyBmb3IgdGhlbS4gTm93IHRoZXkgYXJlICANCj4gdHJhY2tlZC4NCj4gDQo+IA0K
DQpJIHdhcyB0YWxraW5nIGFib3V0IGNhbGxpbmcgc2d4X3JlY29yZF9lcGNfcGFnZSgpIGZvciBT
RUNTL1ZBOg0KDQpAQCAtMTEzLDYgKzExMyw5IEBAIHN0YXRpYyBpbnQgc2d4X2VuY2xfY3JlYXRl
KHN0cnVjdCBzZ3hfZW5jbCAqZW5jbCwgc3RydWN0DQpzZ3hfc2VjcyAqc2VjcykNCiAJZW5jbC0+
YXR0cmlidXRlcyA9IHNlY3MtPmF0dHJpYnV0ZXM7DQogCWVuY2wtPmF0dHJpYnV0ZXNfbWFzayA9
IFNHWF9BVFRSX1VOUFJJVl9NQVNLOw0KIA0KKwlzZ3hfcmVjb3JkX2VwY19wYWdlKGVuY2wtPnNl
Y3MuZXBjX3BhZ2UsDQorCQkJICAgIFNHWF9FUENfUEFHRV9VTlJFQ0xBSU1BQkxFKTsNCg0KVGhp
cyBwaWVjZSBvZiBjb2RlICpsaXRlcmFsbHkqIGRvZXMgdGhlIHJlY29yZC4NCg0KDQoNCg==
