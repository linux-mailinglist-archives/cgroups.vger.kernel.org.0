Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E207BEF4E
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 01:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379061AbjJIXpU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 19:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378992AbjJIXpS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 19:45:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD859D;
        Mon,  9 Oct 2023 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696895116; x=1728431116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xh47qZmooxcoDWfRg6MR/ksDTqYEek3qBxfJDd0HnE4=;
  b=nAldx1UvL6aEizMgopfgqnoDOCOap3JUE5+5BP7lPiikD5c3cANG8MuR
   LSWQk+6lj9a218iA7QHC4g2xGUICSFsPF4ZuJ09DvXpwjpmmzoXXODxXQ
   +nQs3pKomD4Nr5zzAX1cJsvzbFYWT8r3DdtwyE2HlfRbEn1/3VrVFjICr
   lnNw/gyzR+x4fv04sz4gxAOzCmp1CdAgjLg8CRjbnczk93yQJqkcvziYS
   gBtzO8xExPeBXjXWV+nl5AIKvTLdUig8JSBYT0QzuaPOj0j7l8nWFEFuv
   EVtIBYPJz4Vmej+JNcAGV7eS6wjb1MP+URYMuaL5jZn0jB1LQUlkU167C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="387113508"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="387113508"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 16:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869450209"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="869450209"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 16:45:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 16:45:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 16:45:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 16:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brzoXa3N+gIT7le+1fRspiBxOtQifPFqJDUsQAwjno3QHgUIP6zJNOrMmL4n6uikLQMQl7uoxE2NGmH0yUu8nKpsV9Aoi5DRe0aNgGHZqnCKMgT1ua/dBTDDhiAvvf703GoHDs+Wt2Q7iPuhnvA9fIT/q1k3u5ATGJujeEwlf0d4oN8eYqcR2mitMDOlbCtks3pdarEJsHA/eCQ8CLUa2vHKTqGILJO9Se4UgvUGkjk65UCwoWcZ6N7+B3ZFEBtNrgRbgFhJ1Oo6Tq26F7uiuBEVvh3LlV4x1vzMExe/rsQDrLvO9uSEVyVYvmQ3k0A5CP2iTYkMLUTZdJv9XyvAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh47qZmooxcoDWfRg6MR/ksDTqYEek3qBxfJDd0HnE4=;
 b=awHNOZTWc+6iOmU6X8kOF0QMVsMg9dV2Fva4un86Q9NWKCGOl9jem4FsxiDnhMa9Rv42dZr+ZbCh6fkQLSNqRB1USyq+kGRuUYEICQrah0ZYDmX6mNwZC2yaI+aHCGB3GKqM5T4yYK/OdFAZ62PQopwdq8Jx1azinhwYUp1KhnPkWXUdg2dtx6J84mOXwMcHoT2jU0095JofjbVX2ubhv+3ogmciVtKbUKDtrJVo8k0ouPUI9ciEsXKEcnWjYmlzLFz5pV/c0l6JvEIOqRlfudkMcZUQWlfKHQ/jGVmyWehJnYo5hUwLWP+BH1Dhi4hIcdZmNfUzM9x6km2isDIn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5418.namprd11.prod.outlook.com (2603:10b6:408:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 23:45:07 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 23:45:07 +0000
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
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacA
Date:   Mon, 9 Oct 2023 23:45:06 +0000
Message-ID: <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-13-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5418:EE_
x-ms-office365-filtering-correlation-id: e30a0586-c3f4-44c1-bb6f-08dbc921c46a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /of2b/fOgdw9Z+N05Kp3nv3xoFwyS5EItihtiC/10QVOjO6BjlI5Vc7LUDnBizHDoYXpmSHnRYYv1kahfobJrkTf8pjRXJXHzEaAjgWauEUK49Z4qkHouxWQ7ZmUTVsbb3tbJCC1aGJ6IxE6ZBktBD23QjXlhVyz7+Qkwh84hVEhYwmmItFgUwNmXzvysTbLQHLqLHpZ+WT8/bijoWtRacTQ9NdOD9Ie4wZj/V2L37n0BPRHL77iUZM6iTEjFqAowtuNt5QZY2AQnFwdrlqWvzkhpIZtGQcyiJVPg7l8kohW24Zc5skkguVoDx6ejMZx8y2qeyIA+xQ1ESveyXpnCtfaEH20CBB9oGQAqXA6UHA0jaFwQr+euu8T9i6yn8iQRDgJ8naeWnoNtB03mDLUN3a//C+fvErD+MFcJaC+8diBK2UZcLmKhKoRxZhVLAUnyGxto7WQPJAMzCkqf/qJ8mNOZ56wYt3jdPFvzz2wxpTJxRYTsCm5CZk8bzuhFO3wuWism41blis8XRTIVNA/eiddOqnVtmIwBXzx+t+fqWBds0q9kehe/hhk3fP/LMTJC+Ee9zIVcYYTRcKdEmDFAfNN+5mmJhJSoQSQ8A4NDtr+rBhzcwhSpInr14BHeUtN1dlab7SHQsmniTnqaneZZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82960400001)(86362001)(921005)(122000001)(38070700005)(38100700002)(36756003)(6512007)(2906002)(41300700001)(6486002)(478600001)(5660300002)(8676002)(71200400001)(8936002)(6506007)(83380400001)(4326008)(2616005)(66556008)(66946007)(66476007)(110136005)(64756008)(316002)(76116006)(54906003)(66446008)(91956017)(7416002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0F6ZFZWb2tpT0x2Mncxd3d3VVMyUkltUEs5U0NiazNFeG5qcFhndmFBb011?=
 =?utf-8?B?cDl5bFcwVGQ5Q0R2a1VKUi94NXN3eFdRbm04UlVsYkRWWUsyK1pZMkQ2SUFY?=
 =?utf-8?B?eUVzM2hJaHNzZjlOOUFwZ0krL09CN08wbU9LNjB5WlhVMUFWdVZUbGJMTnoz?=
 =?utf-8?B?NXk1T3dYYTdQS05EcFJnakJ4Q0sySWt0dFZLVkhaam1nZ08wblNMNGpUMi9w?=
 =?utf-8?B?WmMwK2REZUNSdFcxSEFONVRVZlF3ZjFvdlVCeG9VTGlqUUdxRjRmdlJTaXg0?=
 =?utf-8?B?ZGpIWkZLSlVHK01GRDh1QVVHUFdud0h1Q3lQdkNQMjlwa09sMTd6TlB0cC92?=
 =?utf-8?B?aE82V0lINHE0Y1d6bi96TEV4eXJrZDBNOWtNcTlGQis5bXNYMEpVS3NwSGMv?=
 =?utf-8?B?ZWNXUmhOdFFSelVqNnFSMkxPdURHOHZRYkM1VG9IVkp6NUV5L1U5UjNqcXRJ?=
 =?utf-8?B?N0F4aDU3ZkJWNlE5SUV3QjI2a3cwMWl6Rm52aWNNOVJnUUtkYkhxaE9waTM2?=
 =?utf-8?B?U25PYUMzZkJkb2lxNFRyK3hheDZUZXcxMXQ1YmM3SldEMlFnY3lUQTlhLzVt?=
 =?utf-8?B?eENGa1F1Vk1IZVRxRlcwaW1VbzNZZU9ZUFplZmJHTTVMNDkvcGYzWWZjQ0po?=
 =?utf-8?B?V1JYRzBZbkFIUWQ5bXMyaWFtUkVMbW1oMHdrWkpVRU91VDFVUjE4VXdBSHk0?=
 =?utf-8?B?U3NhQVNqem1uczFDUHI1b3NydW0wRDlxNmNvbC9USHpMRG8renBGaS9KZ3hH?=
 =?utf-8?B?d3NZWHQ0LzlEMWdqcE81NS9CQjh1bTRaOU83cnVoVVBOUE83ZG1USjlUMXJr?=
 =?utf-8?B?akduellXVFNaS0tpTW41T1lzcXJiNG5zaEwvZzJ4VWhaMWdibXpKN0VPd2VW?=
 =?utf-8?B?WnY4VWRnRVRZSElpSUtXWHNzLzZVbDdEUllxRi9GTEdEaHZadndvaFFpa2NW?=
 =?utf-8?B?RTY0UjJrb0NTVDFhQlJQc1NQRGQwS0RSY3ZhaCtiR1Q3VElnaFpLdlh1SXkz?=
 =?utf-8?B?OGt2M3VmamtDNENrWDJwWitZaWZhaDkvVVdWN0kxTys4UzhHOTk4cWs3bHgr?=
 =?utf-8?B?NkovVlVCUkFMcHBSdXR0ZmN4QWZJT2ErQWgvVDhjUDY1QUQxNzNlbWQzQW5X?=
 =?utf-8?B?ajlXZTZoUms1emY0Q1Noci94QUVhMWhvUVl2c2FDcjVMQy9FUlhzby9VRDRW?=
 =?utf-8?B?VGVOQlBoQXJ1SmJPQTZTY3FRUmFHRTBkemdjRytyTWE1YWJCWld3TnZXN1lF?=
 =?utf-8?B?b2F1ODl0VTBRQzlJMXdVWnA3MjZWVldRSk5UU0lsdHJFWW9yZUxuMk5nK0Nn?=
 =?utf-8?B?b1NHa0Rlc09ZQklRQ1p5L2lvRGdsL05aNjEvdUxtb1ZQcXpoNlhDSWthOER6?=
 =?utf-8?B?Ly9vYmk2Q0t0bzFNYWlEREt4V2IvYnlPNTZCVmcrNUpabjF6VlFyVDc1MUE5?=
 =?utf-8?B?T2hSWlpFWHFrRFhOMzhLVkRncVFPU3RpZWh4bzNaalQzM0JxNjdxbTl3TUlh?=
 =?utf-8?B?SkF3N25EYlNSbEZ6LzJuMVNiMDVVRUQ0OWdSYXZxSExXWmRYOTlzNzJsdnJO?=
 =?utf-8?B?eXZ0WjNDN3dUcGRkYVREZkgzMlRZMmplTG1nQnA2TDhvUzB2cm5kZVgyVFlR?=
 =?utf-8?B?NmJWcFBmcGFoREhiVnNleGtDSDIvVjBQYmkrL0l5OW9POUNTUkN2dFdVQTkw?=
 =?utf-8?B?TmZGRmd2aDJTRk1pNE81QzBReHQrK0VpVlMxcm5aQzZ4WGV0TDFzcy8yM1Nj?=
 =?utf-8?B?QjlCbXRKK1lzSUpyVUY4bndHOEk3TzNYREdWbmYrMGJzM05OTGxONDUvYktj?=
 =?utf-8?B?SmVuYVE2ZTArSE5QdEdjbFUxM01YY1llaG5aZTBOOW9PQ3ZzZkdXUDNZa0E3?=
 =?utf-8?B?aHVkUlpTK1NKZ1VhS2d4RnE5Yk5pNUJOMGxIZmNRVDdQTjRFODBDSmpBU2J6?=
 =?utf-8?B?MDBaNEFLQVgzeE5OT0tJRUczZGh0UGtHT0o3dlVMZjE3Yi93Q2hZTjJlOU4r?=
 =?utf-8?B?OEsxcVhQMmtDeEYvc2QxTDRlaGxvaGloVzlwakV2TDAzZEJwQ0dhbVY3SUtt?=
 =?utf-8?B?TWhsdmRyUXBxZ2l1VVFCc0hnZG1Fb0dhTWhLRmZ5SVcvY291aW90VzAyblNV?=
 =?utf-8?B?VzdWUWNwWGdkNlg3aVRxZFRuWjJTRU91R1ZGNGxGeHNMcXllU0ZlalRtbk1U?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DA90FD21BAB094FA99B8BF749BE487E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30a0586-c3f4-44c1-bb6f-08dbc921c46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 23:45:06.9587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2I19AFFBmO90WyLikV+zbwNVfCfrJfjON7agExv78uhM19tccZl5yQ0mo3Eqgl8QeVRXciKyINrFKg6RYRZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBJbnRyb2R1Y2UgdGhlIE9PTSBwYXRoIGZvciBraWxsaW5nIGFuIGVuY2xhdmUg
d2l0aCBhIHJlY2xhaW1lciB0aGF0IGlzIG5vDQo+IGxvbmdlciBhYmxlIHRvIHJlY2xhaW0gZW5v
dWdoIEVQQyBwYWdlcy4gRmluZCBhIHZpY3RpbSBlbmNsYXZlLCB3aGljaA0KPiB3aWxsIGJlIGFu
IGVuY2xhdmUgd2l0aCBvbmx5ICJ1bnJlY2xhaW1hYmxlIiBFUEMgcGFnZXMgbGVmdCBpbiB0aGUN
Cj4gY2dyb3VwIExSVSBsaXN0cy4gT25jZSBhIHZpY3RpbSBpcyBpZGVudGlmaWVkLCBtYXJrIHRo
ZSBlbmNsYXZlIGFzIE9PTQ0KPiBhbmQgemFwIHRoZSBlbmNsYXZlJ3MgZW50aXJlIHBhZ2UgcmFu
Z2UsIGFuZCBkcmFpbiBhbGwgbW0gcmVmZXJlbmNlcyBpbg0KPiBlbmNsLT5tbV9saXN0LiBCbG9j
ayBhbGxvY2F0aW5nIGFueSBFUEMgcGFnZXMgaW4gI1BGIGhhbmRsZXIsIG9yDQo+IHJlbG9hZGlu
ZyBhbnkgcGFnZXMgaW4gYWxsIHBhdGhzLCBvciBjcmVhdGluZyBhbnkgbmV3IG1hcHBpbmdzLg0K
PiANCj4gVGhlIE9PTSBraWxsaW5nIHBhdGggbWF5IHJhY2Ugd2l0aCB0aGUgcmVjbGFpbWVyczog
aW4gc29tZSBjYXNlcywgdGhlDQo+IHZpY3RpbSBlbmNsYXZlIGlzIGluIHRoZSBwcm9jZXNzIG9m
IHJlY2xhaW1pbmcgdGhlIGxhc3QgRVBDIHBhZ2VzIHdoZW4NCj4gT09NIGhhcHBlbnMsIHRoYXQg
aXMsIGFsbCBwYWdlcyBvdGhlciB0aGFuIFNFQ1MgYW5kIFZBIHBhZ2VzIGFyZSBpbg0KPiBSRUNM
QUlNSU5HX0lOX1BST0dSRVNTIHN0YXRlLiBUaGUgcmVjbGFpbWluZyBwcm9jZXNzIHJlcXVpcmVz
IGFjY2VzcyB0bw0KPiB0aGUgZW5jbGF2ZSBiYWNraW5nLCBWQSBwYWdlcyBhcyB3ZWxsIGFzIFNF
Q1MuIFNvIHRoZSBPT00ga2lsbGVyIGRvZXMNCj4gbm90IGRpcmVjdGx5IHJlbGVhc2UgdGhvc2Ug
ZW5jbGF2ZSByZXNvdXJjZXMsIGluc3RlYWQsIGl0IGxldHMgYWxsDQo+IHJlY2xhaW1pbmcgaW4g
cHJvZ3Jlc3MgdG8gZmluaXNoLCBhbmQgcmVsaWVzIChhcyBjdXJyZW50bHkgZG9uZSkgb24NCj4g
a3JlZl9wdXQgb24gZW5jbC0+cmVmY291bnQgdG8gdHJpZ2dlciBzZ3hfZW5jbF9yZWxlYXNlKCkg
dG8gZG8gdGhlDQo+IGZpbmFsIGNsZWFudXAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiBDby1kZXZl
bG9wZWQtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogS3Jpc3RlbiBDYXJsc29uIEFjY2FyZGkgPGtyaXN0ZW5AbGlu
dXguaW50ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1
YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFpdGFvIEh1YW5nIDxoYWl0
YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiBDYzogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vh
bmpjQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBWNToNCj4gLSBSZW5hbWUgU0dYX0VOQ0xfT09NIHRv
IFNHWF9FTkNMX05PX01FTU9SWQ0KPiANCj4gVjQ6DQo+IC0gVXBkYXRlcyBmb3IgcGF0Y2ggcmVv
cmRlcmluZyBhbmQgdHlwbyBmaXhlcy4NCj4gDQo+IFYzOg0KPiAtIFJlYmFzZWQgdG8gdXNlIHRo
ZSBuZXcgVk1BX0lURVJBVE9SIHRvIHphcCBWTUFzLg0KPiAtIEZpeGVkIHRoZSByYWNpbmcgY2Fz
ZXMgYnkgYmxvY2tpbmcgbmV3IHBhZ2UgYWxsb2NhdGlvbi9tYXBwaW5nIGFuZA0KPiByZWxvYWRp
bmcgd2hlbiBlbmNsYXZlIGlzIG1hcmtlZCBmb3IgT09NLiBBbmQgZG8gbm90IHJlbGVhc2UgYW55
IGVuY2xhdmUNCj4gcmVzb3VyY2VzIG90aGVyIHRoYW4gZHJhaW5pbmcgbW1fbGlzdCBlbnRyaWVz
LCBhbmQgbGV0IHBhZ2VzIGluDQo+IFJFQ0xBSU1JTkdfSU5fUFJPR1JFU1MgdG8gYmUgcmVhcGVk
IGJ5IHJlY2xhaW1lcnMuDQo+IC0gRHVlIHRvIGFib3ZlIGNoYW5nZXMsIGFsc28gcmVtb3ZlZCB0
aGUgbm8tbG9uZ2VyIG5lZWRlZCBlbmNsLT5sb2NrIGluDQo+IHRoZSBPT00gcGF0aCB3aGljaCB3
YXMgY2F1c2luZyBkZWFkbG9ja3MgcmVwb3J0ZWQgYnkgdGhlIGxvY2sgcHJvdmVyLg0KPiANCg0K
Wy4uLl0NCg0KPiArDQo+ICsvKioNCj4gKyAqIHNneF9lcGNfb29tKCkgLSBpbnZva2UgRVBDIG91
dC1vZi1tZW1vcnkgaGFuZGxpbmcgb24gdGFyZ2V0IExSVQ0KPiArICogQGxydToJTFJVIHRoYXQg
aXMgbG93DQo+ICsgKg0KPiArICogUmV0dXJuOgkldHJ1ZSBpZiBhIHZpY3RpbSB3YXMgZm91bmQg
YW5kIGtpY2tlZC4NCj4gKyAqLw0KPiArYm9vbCBzZ3hfZXBjX29vbShzdHJ1Y3Qgc2d4X2VwY19s
cnVfbGlzdHMgKmxydSkNCj4gK3sNCj4gKwlzdHJ1Y3Qgc2d4X2VwY19wYWdlICp2aWN0aW07DQo+
ICsNCj4gKwlzcGluX2xvY2soJmxydS0+bG9jayk7DQo+ICsJdmljdGltID0gc2d4X29vbV9nZXRf
dmljdGltKGxydSk7DQo+ICsJc3Bpbl91bmxvY2soJmxydS0+bG9jayk7DQo+ICsNCj4gKwlpZiAo
IXZpY3RpbSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJaWYgKHZpY3RpbS0+ZmxhZ3Mg
JiBTR1hfRVBDX09XTkVSX1BBR0UpDQo+ICsJCXJldHVybiBzZ3hfb29tX2VuY2xfcGFnZSh2aWN0
aW0tPmVuY2xfcGFnZSk7DQo+ICsNCj4gKwlpZiAodmljdGltLT5mbGFncyAmIFNHWF9FUENfT1dO
RVJfRU5DTCkNCj4gKwkJcmV0dXJuIHNneF9vb21fZW5jbCh2aWN0aW0tPmVuY2wpOw0KDQpJIGhh
dGUgdG8gYnJpbmcgdGhpcyB1cCwgYXQgbGVhc3QgYXQgdGhpcyBzdGFnZSwgYnV0IEkgYW0gd29u
ZGVyaW5nIHdoeSB3ZSBuZWVkDQp0byBwdXQgVkEgYW5kIFNFQ1MgcGFnZXMgdG8gdGhlIHVucmVj
bGFpbWFibGUgbGlzdCwgYnV0IGNhbm5vdCBrZWVwIGFuDQoiZW5jbGF2ZV9saXN0IiBpbnN0ZWFk
Pw0KDQpTbyBieSBsb29raW5nIHRoZSBwYXRjaCAoIiB4ODYvc2d4OiBMaW1pdCBwcm9jZXNzIEVQ
QyB1c2FnZSB3aXRoIG1pc2MgY2dyb3VwDQpjb250cm9sbGVyIiksIGlmIEkgYW0gbm90IG1pc3Np
bmcgYW55dGhpbmcsIHRoZSB3aG9sZSAidW5yZWNsYWltYWJsZSIgbGlzdCBpcw0KanVzdCB1c2Vk
IHRvIGZpbmQgdGhlIHZpY3RpbSBlbmNsYXZlIHdoZW4gT09NIG5lZWRzIHRvIGJlIGRvbmUuICBU
aHVzLCBJIGRvbid0DQpzZWUgd2h5ICJlbmNsYXZlX2xpc3QiIGNhbm5vdCBiZSB1c2VkIHRvIGFj
aGlldmUgdGhpcy4NCg0KVGhlIHJlYXNvbiB0aGF0IEkgYW0gYXNraW5nIGlzIGJlY2F1c2UgaXQg
c2VlbXMgdXNpbmcgImVuY2xhdmVfbGlzdCIgd2UgY2FuDQpzaW1wbGlmeSB0aGUgY29kZS4gIEF0
IGxlYXN0IHRoZSBwYXRjaGVzIHJlbGF0ZWQgdG8gdHJhY2sgVkEvU0VDUyBwYWdlcywgYW5kIHRo
ZQ0KU0dYX0VQQ19PV05FUl9QQUdFL1NHWF9FUENfT1dORVJfRU5DTCB0aGluZyBjYW4gYmUgZWxp
bWluYXRlZCBjb21wbGV0ZWx5LiDCoA0KDQpVc2luZyAiZW5jbGF2ZV9saXN0IiwgSSBndWVzcyB5
b3UganVzdCBuZWVkIHRvIHB1dCB0aGUgZW5jbGF2ZSB0byB0aGUgY3VycmVudA0KRVBDIGNncm91
cCB3aGVuIFNFQ1MgcGFnZSBpcyBhbGxvY2F0ZWQuDQoNCkluIGZhY3QsIHB1dHRpbmcgInVucmVj
bGFpbWFibGUiIGxpc3QgdG8gTFJVIGl0c2VsZiBpcyBhIGxpdHRsZSBiaXQgY29uZnVzaW5nDQpi
ZWNhdXNlOiAxKSB5b3UgY2Fubm90IHJlYWxseSByZWNsYWltIGFueXRoaW5nIGZyb20gdGhlIGxp
c3Q7IDIpIFZBL1NFQ1MgcGFnZXMNCmRvbid0IGhhdmUgdGhlIGNvbmNlcHQgb2YgInlvdW5nIiBh
dCBhbGwsIHRodXMgbWFrZXMgbm8gc2Vuc2UgdG8gYW5ub3RhdGUgdGhleQ0KYXMgTFJVLg0KDQpU
aHVzIHB1dHRpbmcgVkEvU0VDUyB0byAidW5yZWNsYWltYWJsZSIgbGlzdCwgaW5zdGVhZCBvZiBr
ZWVwaW5nIGFuDQoiZW5jbGF2ZV9saXN0IiBzZWVtcyB3b24ndCBoYXZlIGFueSBiZW5lZml0IGJ1
dCB3aWxsIG9ubHkgbWFrZSB0aGUgY29kZSBtb3JlDQpjb21wbGljYXRlZC4NCg0KT3IgYW0gSSBt
aXNzaW5nIGFueXRoaW5nPw0K
