Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2649A7B0361
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjI0L5a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 07:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjI0L52 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 07:57:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A2FC;
        Wed, 27 Sep 2023 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695815847; x=1727351847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5a/tsFJUcKlK6RUjwSt95hsVzn2VxrxWHlPjGk3Haaw=;
  b=Vk15jjuQgrIZAaj15e5dSwY4cIo1hpWx2EJin5fZ7r6b0Ak89aQlsGxb
   TcGNC28QNYv/x36BCFHzQrflFVT6VkxTUUk2GAL0Buw4221E7ec9xASn9
   JWiYY9WsuARyXQFb1elNZIX3O3M8eiq7o6yg7lxUtZ326QcALvJ2WvOpr
   YeK+ZYuA9KDlXy3VT5fZAGZzqufrBfMFExNFBf3ksGlf4/fw9XaH+yD6D
   bbcKiZeKSHtkbaSIQFHH7q3k2HcpS4Vl4jJfzcPhcCUsN40XUc4jNJsdo
   iAVo+/AUinunz2rhEjyxwfMQHQTuBLqrCYZ+8cXrwPup29uM5M6wM8X66
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="379081946"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="379081946"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 04:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864798731"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="864798731"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 04:57:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 04:57:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 04:57:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 04:57:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 04:57:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPkd42ACmNqXuzDrzag9c22QXy6DVsqUD0jjdLMjBa0KFN5Sq6BdyNm52WWHcLTGgnTpImfnsc3iwjjXkc9A74kDY71Mmh39uWfn6MLomncmljkovWmSn9Ymwp2v+6BfT63/ALju0wvuZcJyixgT0q3jP914iKzvu6JEn/VQEunuL7npY6X8sWjqfyCJB2Eg7oVdBPXeWMCCJ3VwCXkgInXm1pGu/UBemE9YdRzn/poOj0IpmuX/78hB3kuFxCAwS1woqsreJjmdB8UUYrPpVtLq4iujJOqTus6dtc+BVpmO4aLnz0Eil+XO5yTHOssNVLsZ40AqxK6Ak57XOdntAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a/tsFJUcKlK6RUjwSt95hsVzn2VxrxWHlPjGk3Haaw=;
 b=Ng1Bj+buehvdlwWIphJCAEqIfppU1Zn1hI+Eu23EfK0DZQHp53SFDjVxmw9FTS13Y0+LduZb0Z8habhQ9XsYRu+CuxjTOggk/gpWPE5RWxyo3bKVZOFIf39ydaKhX0fQEradCHHI8nSM70GORdZ7LVu6eCAtIGks/L2cMpms8hrBnSqqGZFToq/Fwed9BdZUDLtc9CHD8LyzNActCrLKqV6ueviKPhIuz/OXR13b3NDbNCfrffqw6ncW2Im14kUuuWwGpS1MfJ/5Uai1aT551tkMpgzeniNhQnIF8mPkFBbfohFAehRQuSqpayVgS5YbFzoTSdJ666mrVmg3z8RwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5508.namprd11.prod.outlook.com (2603:10b6:610:d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 11:57:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 11:57:18 +0000
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
Thread-Index: AQHZ7csbbOBwGIwhuE+AjDRhd4Uej7Aul+2A
Date:   Wed, 27 Sep 2023 11:57:18 +0000
Message-ID: <8263fc876ae932c4744c7870af90cfb01b8426e2.camel@intel.com>
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
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5508:EE_
x-ms-office365-filtering-correlation-id: 61f0e129-b8a9-4a48-576e-08dbbf50e61a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87z+sjVr7O7s8/BRu+GGFHj8JOUH3ZlpC4//ZMlz8+dgMJYe7Z7GKfNqg+OhY2AIsBg5quJOwaphC5ocK6fKvGZKeB7gxMYz1ddWGpn1B9EBsRpYAFll5JJKbixaxBsrqxVuQZWThFgqhmMFEy8a503IbwukJosRTlwdxSwP78EeTWr/1zov8R0WR2uphGvI3dRqYWYvzwhoa/xDNQYst8BVK17MfLwHndmXQyW3zhyFYeFqEsEfGtiHbjfNA0ECNSnZe3jwJdocs9GVuFaoRwgwmqOMw81v+71mHQjwv5SJOZdS/CcmAo1ZDwj1thSDHS0EwblRUzbgHyfTBu82f74L7M0CmLFg7E3xzW+lL3ELbh3/VLkRHYbjfH8UH9VwfcbZJPpRVxfwUbUoeKhWvaPKb3shWKxKUN1+nc6FkYksalXlTkIzhkH0Gpisam6b00dgNgwvPfrbLNcYRardBTIOtTgJtWZwXf3GRklpX0EXa4XJUJTkt0V9kXYT5pOr/qEp3bYVAtmwTRsKKWsX/XMoGG+OCvVXBDHUATHFYtDrZMebGuFx8TbngHLJIMrXxxJMriIJOWDrgYbP439GI+6kC4XzJGuDOGdngKV70MN6wMzugoPGZ9dhSIFaRptP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(66946007)(2616005)(71200400001)(66556008)(122000001)(66446008)(64756008)(316002)(83380400001)(6486002)(6506007)(66476007)(26005)(36756003)(921005)(6512007)(478600001)(54906003)(82960400001)(5660300002)(91956017)(8936002)(86362001)(110136005)(76116006)(2906002)(38070700005)(4326008)(38100700002)(8676002)(4744005)(7416002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0lJK0JONGVSY0RBNENUOW5yK1I2QXNudkhvMFVzVi9iWmhOSS83NFJ0YXh5?=
 =?utf-8?B?WWZNVjhueURxZ0lFa1R4WGM5TmZKRkp2SnhWWjF0NmFXNm9DaTlEUWpiM05N?=
 =?utf-8?B?aUhYSTZCRzB0a2VDTW9jRnBRb0x6QkFOSjdHMG41WDhqUkI1UnUyeVJjZk1k?=
 =?utf-8?B?T3JTbnQrUlJrTEx3alJVU3phZVpHL2xzWWk2eFRxR0lJa1RON0ZKVkdqK0I1?=
 =?utf-8?B?N3F6My9rTEhZUDU5M2dGOUVzYmFHSzhxUUVhUWE0UE5ubDNXSzNGenpVRzRz?=
 =?utf-8?B?Uk1HdEhjNGFKMjcrckJZcERJTkJEM3RMSitHa1kwK3ZZQ04xYU1heUJUMmtO?=
 =?utf-8?B?K2hQUlAwMnlUZ2lhM0x2NFYwUmt1cFlnRjNHS3huaiswZ3kwS0N1TklpWkNu?=
 =?utf-8?B?czRKZDBZY0dIcEtkQmlQY3ZWcVZnVkhzVGhXV2xGZ0V3MHZVYVJEajEvdUpC?=
 =?utf-8?B?bllVNlJ4Zk9xVDBhaHU4QnB6eDdoeGNQSUlkS3NRNkllaGJMSUJEcXl0b3NN?=
 =?utf-8?B?TS9kMENZMzhxNEtYaG9FbzhUci85YzMwKzcwQnBIOUFheENQR2N4SSthMkgv?=
 =?utf-8?B?QmdaQisyek1OS0JjWSs0Syt2OENFQmh3enhpRENHbWcrbzNTNm9GUE5pemZs?=
 =?utf-8?B?ajc5bHZsenpUS3FUeGNOejZKdkRZWkpzVWliRFBpUnplS1c0ajlPUllXa1do?=
 =?utf-8?B?bFEvdUt5TVNSR3RMYS8yMS9BRlh3YStySWhncC82djBsMGxCNlU3UzhNTHBr?=
 =?utf-8?B?Tmhld1hLQ254ZGdBZkFXRGZ5OUtwVVR1WTMxMlBrTTY1TC81dEd0aWc1eGsw?=
 =?utf-8?B?Sm5haDZFbzNyMytoTm1GREZ1cGRJR3dFSnh0NVZpR2pGZWwrZ2ErajR0ODlN?=
 =?utf-8?B?cFE1WmhKczBUdXhHOCt0OEVkT1VXM3JPeW81K1BsZ1NGMEcwMGdzdnpiWVcw?=
 =?utf-8?B?bGtESWttNTdvYzdlNXgyRjBiRlpqTnJYSUkwSkd3MWFsYWhoa01xWC9MVkZT?=
 =?utf-8?B?Uk9aNmh2eWRZcHNZc2YxdUxDMk1iZ2ovbUJPd3lyYmdDS1A2NFc4MGlLZFBn?=
 =?utf-8?B?bFhZcWp5S3dURGptNzlGb0wyRHc1VHhrV3RYTlpnQ3VnR01hSXRKTldKVUxu?=
 =?utf-8?B?OGtIclRjUmpzM01FaWYvRUtlazZOMkd4S1V5SldHeHhVUGpRWjNrQU8xdk5Y?=
 =?utf-8?B?QnJTdm15SlJxcnJQNGNoK3M5SmtXR2pqNjJQR0pvcEw5TzZHcHFMRVlEb3N2?=
 =?utf-8?B?YzU1VFVuS2xPQlRVVzZjTGVaRmwxa0V0VUc2SHI5V3BuTWZ5RTJqT09tNVBz?=
 =?utf-8?B?clR3cnFNL1h5Z0lsVDhLQ29KSlhMb1lyeHZZQTlHSlpjaGtVanBVaC80NzlR?=
 =?utf-8?B?V01yUmdRUUsrTkNCLzVSTmlLR0ppcEFqWTBOMjhqUndYSkxJUkVSSHhFT1Ju?=
 =?utf-8?B?aFd2b2NmdXBRWExKeGowbkUvVVE3dXlwdjV4VE0rdGlLcHZwSm9laVBxdS9j?=
 =?utf-8?B?UGR0a2w0SWhvbEVxZ01NbU50eW5mL0tPTmRLZ3ByUUc3YlFJQTNhRTZuYzcr?=
 =?utf-8?B?cUdJcFFzUklzSjg4S2RvSDlDVzZ3ZDQrdSt5TW1WdFhGY3BMSGM1TURIbjhs?=
 =?utf-8?B?N1FjL3Q3SjRpSXRCVU85enVpZzNURWVsU1ppb1VkWkdNM3BHTTVSTTZiclcy?=
 =?utf-8?B?WkFRejg5eTBTMkVZN1hxVzFidnRVSXJmVW16MnVzUHRyeXJ4L2U0dExpVkNo?=
 =?utf-8?B?S04xTUdyMkg4OTVoZ0V0U3Z4cSt6Ty9HSWJYcVlBN0E3NW1ZT3cvTWhqT3RX?=
 =?utf-8?B?eld2V0g2NlptL0swVVdBVWFVR1RxcjI1R1pNOURYamtLK3hobUkzdndRYjVv?=
 =?utf-8?B?V0gzV1lsUWdueE1oVUM1dEs4enl2QkdEQUtUSlEzTFU2SmJTc1BRSXFQSklo?=
 =?utf-8?B?ZWVoaDJMUDRkc0JENTY3dTdEMXp1Z2hZNkFTZFdDSmxmbUdsS2lsRktXTXho?=
 =?utf-8?B?MTBNeXd2N0tLUHFjYkQ2RjdOMmxqdnRpNGZqa1JyZnlJU3ovZU51MlhReW1Z?=
 =?utf-8?B?c2kwRW5GT0ZUQ01kTHdxMWRSZUZhREN3ZUdHaFRBQlBRMXcwd010ZUtkSEdH?=
 =?utf-8?B?cVh0TEphaE5aS05SelNOSlIycHpoRjNobDkvZTFROEhqcWNqbzBhZ3NrNVh6?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ADEA27ABD5ABA44928F98B5BD110005@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f0e129-b8a9-4a48-576e-08dbbf50e61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 11:57:18.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgyfeW2P2YMF79juVHK88pEMbtWnvd4KEzIr1SJc3RHPgIDtG74qNOpZJG0gxQtfWB7eTIlVF9lBR9JIO7PNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5508
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

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBXaGVuIGFuIE9PTSBldmVudCBvY2N1cnMsIGFsbCBwYWdlcyBhc3NvY2lhdGVk
IHdpdGggYW4gZW5jbGF2ZSB3aWxsIG5lZWQNCj4gdG8gYmUgZnJlZWQsIGluY2x1ZGluZyBwYWdl
cyB0aGF0IGFyZSBub3QgY3VycmVudGx5IHRyYWNrZWQgYnkgdGhlDQo+IGNncm91cCBMUlUgbGlz
dHMuDQoNCldoYXQgYXJlICJjZ3JvdXAgTFJVIGxpc3RzIj8NCg0KPiANCj4gQWRkIGEgbmV3ICJ1
bnJlY2xhaW1hYmxlIiBsaXN0IHRvIHRoZSBzZ3hfZXBjX2xydV9saXN0cyBzdHJ1Y3QgYW5kDQo+
IHVwZGF0ZSB0aGUgInNneF9yZWNvcmQvZHJvcF9lcGNfcGFnZXMoKSIgZnVuY3Rpb25zIGZvciBh
ZGRpbmcvcmVtb3ZpbmcNCj4gVkEgYW5kIFNFQ1MgcGFnZXMgdG8vZnJvbSB0aGlzICJ1bnJlY2xh
aW1hYmxlIiBsaXN0Lg0KDQpTb3JyeSBJIGRvbid0IGZvbGxvdyB0aGUgbG9naWMgYmV0d2VlbiB0
aGUgdHdvIHBhcmFncmFwaHMuDQoNCldoYXQgaXMgdGhlIGV4YWN0IHByb2JsZW0/ICBIb3cgZG9l
cyB0aGUgbmV3ICJ1bnJlY2xhaW1hYmxlIiBsaXN0IHNvbHZlIHRoZQ0KcHJvYmxlbT8NCg0KDQo=
