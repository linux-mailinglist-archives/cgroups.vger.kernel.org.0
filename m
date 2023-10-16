Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEF57CB519
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 23:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjJPVKd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjJPVKc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 17:10:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C959AC;
        Mon, 16 Oct 2023 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697490630; x=1729026630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eGZg9Yf/30P3LEiBGMdZFa4t8gqQU+eFLNr6ddMrTTE=;
  b=ZyupHWr7OhtCgus/go6rGBFEFSwJU5K4Q3O9yyOvlCF7HD1ynz8dQ+do
   XPUKxaPIUOJOkIRemE3e0ZYWOlnCP1JRWwm0enjuX3cKhl875orZGkbTK
   wsxwZ7BfyjuZEzg/cpC+bUFGEQS3KupC5k71vhtGOm7W4KzQrzR3vRXMH
   NDQBCfPzWhABEhFbfgQ+92e9jhzt2MMkNfY2oN0vSP9nzAElgWBKlYJQx
   3YOVRILAiWRJr0sXczP+vLX9wPLVpXTksbvVeujaopTPgE7zG4+KISFP7
   RMqSaYxtV+YlTx6mlIHKjPuTbfOTGpwCFol79JsHUdmUTYSHb5oaQRUjw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449859102"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="449859102"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="790954542"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="790954542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 14:09:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 14:09:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 14:09:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 14:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG8JQrm79hlETZOAiMOMS/Da1+vmpZrL+Qkg5FAp3LGzSP0JFcYTC970fh8kyGQy1Do0fnAjR+NeWdH/igNMNgvM6VhgpYndzskAZJtw57MW/Azc8bZn0w9jrJZAwBu7ZwHWJMqhPhCDtT9ZCJ2tD6K8aQmYZIqDolP+tCQ7WD75nse7f7zEZDwiYjO6s1CLNu3F5b3Y0xQSd9Q2SWOzPZlk8ZNZIdrnUn0uTN+B6XLgJNWFqHJRD4kNyxeenkHpMPSe7GOZF3+H7aYUEFE3EnoOWMCqPne1chiHDcPLU+SeBDal8xMnPifnOb5oIYUfS8Y8gMPcgw5X9a3U/iHIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGZg9Yf/30P3LEiBGMdZFa4t8gqQU+eFLNr6ddMrTTE=;
 b=K/om6cDR3f+ZteUuHBrJPVLYzpIxOSvPD3ioaIHRRaIExgTz+pTFQ1qgHtRJJNYNLZgL+Pkng1o/HcaKG3FpAHbCkfrZp8uLSzv2qrC/mtWHZD9EfYeq26KPBYtnjcpbruCI/MYCqrr1uZIWEC0MbEsevfnUTgX/9cNkau8qHtAJHhh9OdadXgLJcEVf+lOqWwIlB0OImbaA3mxA0kXQe+2FvV1cLkfdvXc+k6Nleh7aYKzgQ2spQbJeMvh9iY6/9m1Wf9xM6sCoOrKS084NHh4iXZUdx8Sv5o3xOvXUiyNcfre4AYsDbBPhrwnt5mVU3h3ciYs2Yf62TeuHKaj0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 21:09:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 21:09:52 +0000
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
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgIAADEaAgAD/w4CAAIaBAIACZaqAgAYfZACAAJVwgIAAFaKA
Date:   Mon, 16 Oct 2023 21:09:52 +0000
Message-ID: <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
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
In-Reply-To: <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8706:EE_
x-ms-office365-filtering-correlation-id: a79eb942-1034-4161-15a6-08dbce8c3d9b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPNO8aUwJDIsBkd9cx6z8Y1TG1ig4Cymy4ZZcSDXzirUZRANxg8RYtCuNyjWkMNyOe5wJOmWMbDpODWeRlBzbpwI56ndOn9wNgrUvS2+5KeSJ+we+foAiQ8xJryxrs9D4WJVR9Ci9eo40qjQQwwPqW//RQU9OMRTi1AoRka9se37CDpGm41vzY9azRD2gR4Dh5+i0AcvP3yKIeSMJ8v1C/4kiS1NMI1lVyXyekX6XqjV7W4Rh93Ctn/U7SsY8tU0vMR7HxqHn+Ur4n4VBxrPi+4dU4ECQtesvqb3W+ByYW9hPXTutId6xcxig87v5mXo+U1y+cbZrptDZSgIyFN705xdIZCeEw7Sh4Rp9E/PVz7uLVJ0vomPuCVzdDk/yW/fk7Izff6svIDwpDuhpU1if+sENh4uUV/x8ui6nzj0oK1AJKYNfsNJo++cEKb6NqHPIih9ZQQaXiwYa5qPzhOTSumD//PsbXKjhqygsQcs4vC3jK92D6soSVDQ3WbX3cyYwvTnkeFlDnaRn0GZRUkBqP0au1nxp25ylsAEqucAMZt/wjfFSGeHMMO67CZwR9g2hXDaQ8INd5kUE0MVxBpl3LcTmjus/yRXSsw2gx890iWEoo/8cPvM1I4XjOxclm8w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(6486002)(66476007)(76116006)(91956017)(66556008)(66946007)(64756008)(54906003)(71200400001)(66446008)(110136005)(316002)(82960400001)(83380400001)(86362001)(38100700002)(6512007)(26005)(2616005)(6506007)(36756003)(41300700001)(122000001)(38070700005)(5660300002)(8936002)(8676002)(4326008)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1QxdkxFTml0TDJUVDlhUTBvOGdzQ1FGVU56ZUdOdzBnUDN1a3h0dmxqYlM1?=
 =?utf-8?B?RFlMbnVLd2lJRFlhSmZobm9XY2t4RFZYcktSYXJsaWdSRnRvdHNXa29VWllM?=
 =?utf-8?B?THJEQnM0YWdjcjlFbWt4Tk9XQjAwb3FzZUZCY1JIOUpsM2h6TGVUUVp4enZj?=
 =?utf-8?B?U2FrQzdjNHVqQ0hwMlorU245aE1HSTB6dkJxVUl1NWlJNXcvOGZiR1VFUTlU?=
 =?utf-8?B?UDl1QytraG1QOVNrakpzaWo5NzRkSHZ0cXdGazBXL001aFVxNm1xb2V6WXRD?=
 =?utf-8?B?ajkvY09YQ2ZCc09Ebkh6QmN0UFJWSk5qRHNoM1BMR0duMW5wNnZ2Q1BBS0hU?=
 =?utf-8?B?aDB1eTIvK1ZJZ3NBSUh1VE04UktTNUREVU10allKV0VwOHRqbnJzRXo0V2Fo?=
 =?utf-8?B?RzhWZDBhYjRBWlhpNVVqSmVQdGo0Q0t1SzNTU3JTQ2hNU3l2enZvV1ZXb1RR?=
 =?utf-8?B?SFI3dFF1dkZKQitlSnFoWnNVMW4yRjNDUStGdk15UjJzTjVkd29ITnhzYmJq?=
 =?utf-8?B?ZHJzcmxWeDNjNnUyWnY2Wk1vQjZzNExWODQwYVpnZE1qZm9id014amdxcXlJ?=
 =?utf-8?B?NGJVYlNOYS8ySEZHMTEvRm1FWXhtZGhUZlg2cHRJS3phQnBMaG5PdGhvWDJ0?=
 =?utf-8?B?cG1DWExPREg3OW96cXFzUkppTFRNYnAwUVVHcDA4UzhMQlFnZ3Vhc0FyZXJ3?=
 =?utf-8?B?aFkvSVVydFp6SXpVQld2WlhldjVOOTk0dnMwNUJFKzdoeU5Cak4vT0pnWkZC?=
 =?utf-8?B?NUc1NGo1STJ4dGFJQ0Q3S1JZWmtEWE5MZ3VoWTcwTTVpaUpWMC9CekJ0TVI4?=
 =?utf-8?B?Vi9yT0xlQ2ZjUTE4aTJUVlozMHE2bXdodGl5Y2pVQTE0c0NGVUZSeVpVbmI3?=
 =?utf-8?B?eDlmb1V5aTJpVXF2TXJnSW0yeFZmTkRtTUhybVRGeDliUndLbjR5czhld0Zk?=
 =?utf-8?B?Q3ZtSmNwZ3BQVnN5ZThMRFAzNzhUbnFzVkFuTjBnNlNiMXVnT2RpeHBuc08r?=
 =?utf-8?B?dFErMGphUm42b3FOa2hlQTZEaGhDcHA3SGxsOVFmUDR6YlFnVmh3RjMwc3A0?=
 =?utf-8?B?Q3NFMy8vdlRFMUR0dVYzRkFtSVRrZWxZM3BCamFwblI0RlFFaFdGOEtLZlBX?=
 =?utf-8?B?TTNTblNNZ2M2dURSSnlGbmhtS3gxS055N1c2MUU0NVlCak91OGQzSnlqUCti?=
 =?utf-8?B?ckVqa0JEK01QSDE4d0ZQMlB2OVFiRG4yd0FaV0h6RzVGd3d5c3JpUGtmenl2?=
 =?utf-8?B?em1ZODdxVUFwc29QUGg0ckxhUGM0NkRjVE9ZQitaYjlrbFVkU3B6R2JaRVNa?=
 =?utf-8?B?K3llblU4VnpoTTlra1dyS0dFbWYrUjNiNGtaN3FoS2U2RTJVTE1UTjNjaklH?=
 =?utf-8?B?bkZtU2oxT0pKaVFCYnI2ZXBZTW1qb3BjbXkwOFcyUE92ZTE2QTM5Z2p4QmI4?=
 =?utf-8?B?a0lxaVp4c05sQ1dPcExKd1psY0tYbXNkMFoyNUV2ZGhLaW12OUdsUnYyM2Uw?=
 =?utf-8?B?S0xnWFpSNGFjdkY2RlJ4SHJMK0dDREpudTF6MHFEelRSdEZiZ3U1ZFl3Q05M?=
 =?utf-8?B?QXhhRGNNQkg5blh6VkU4NW81UHREaVFOd2E4NUNRTHZGZWJaVXkzYkZGUmE2?=
 =?utf-8?B?MkVjUSs1ZWhkTmZHczJHMGwxaUZLaWN3djY5TmxvSkVsclUzci8xcmFnQU5S?=
 =?utf-8?B?S2lZWFBucE4ya2ZjVXhMb3hseFZGalRWVEpxc01hdnhXZVhhQjNsVDU4d1ZI?=
 =?utf-8?B?UVVlSUlMUFJZNmRhWHF4MmpPS2lBRFBEUVFxV1VJQ1ZJYzc4b2Z2REI0WnBL?=
 =?utf-8?B?OFVNLzdGYVNlYjJoM2xGUHpOTi9PeWp1Ym1vQ1JzNDEzbWNobVBKU05vNUJP?=
 =?utf-8?B?TElzS2ovaE1iOUdOSGxRc0NRc0NmTXhNOFFJVENTdTcwQ0t6eDIrS1VGQm9q?=
 =?utf-8?B?eTZIcC9qelFHeFJLbDhNTlR0MzlDYmdvS1FtbzRXejJoakRVWThad25PeGZt?=
 =?utf-8?B?NVpuTUZVaWFNc1BDcWxISnNCc081bU1GWE1qTVcwbytrckYxMFNWZmh0c0FT?=
 =?utf-8?B?a2Z2am5RdG14ak01SkF0UEwydTN6dTBEZWRaUFR3RlFXOTdNZFlCSFAxekty?=
 =?utf-8?B?VitwWDlMZkhuZm9XT3hWWGFiWGk5WTRua2VWaUg4ZCszSVZPV1ZOeVBJOG56?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4749C9DCEF37E14A8C8857D91926E602@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79eb942-1034-4161-15a6-08dbce8c3d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 21:09:52.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVF6+yrb7R2mTgXwYzanFHDgYHLHb96gbmALTV8XBJMN62t0EYLeXysE9PMR9mgE408Sk6vHT7uiLLYv5optNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
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

PiANCj4gDQo+ICBGcm9tIHRoaXMgcGVyc3BlY3RpdmUsIEkgdGhpbmsgdGhlIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gaXMgIA0KPiAid2VsbC1kZWZpbmVkIjogRVBDIGNncm91cCBsaW1pdHMgZm9y
IFZNcyBhcmUgb25seSBlbmZvcmNlZCBhdCBWTSBsYXVuY2ggIA0KPiB0aW1lLCBub3QgcnVudGlt
ZS4gSW4gcHJhY3RpY2UsICBTR1ggVk0gY2FuIGJlIGxhdW5jaGVkIG9ubHkgd2l0aCBmaXhlZCAg
DQo+IEVQQyBzaXplIGFuZCBhbGwgdGhvc2UgRVBDcyBhcmUgZnVsbHkgY29tbWl0dGVkIHRvIHRo
ZSBWTSBvbmNlIGxhdW5jaGVkLiAgDQo+IEJlY2F1c2Ugb2YgdGhhdCwgSSBpbWFnaW5lIHBlb3Bs
ZSBhcmUgdXNpbmcgVk1zIHRvIHByaW1hcmlseSBwYXJ0aXRpb24gdGhlICANCj4gcGh5c2ljYWwg
RVBDcywgaS5lLCB0aGUgc3RhdGljIHNpemUgaXRzZWxmIGlzIHRoZSAnbGltaXQnIGZvciB0aGUg
d29ya2xvYWQgIA0KPiBvZiBhIHNpbmdsZSBWTSBhbmQgbm90IGV4cGVjdGluZyBFUENzIHRha2Vu
IGF3YXkgYXQgcnVudGltZS4NCj4gDQo+IFNvIGtpbGxpbmcgZG9lcyBub3QgcmVhbGx5IGFkZCBt
dWNoIHZhbHVlIGZvciB0aGUgZXhpc3RpbmcgdXNhZ2VzIElJVUMuDQoNCkl0J3Mgbm90IGFib3V0
IGFkZGluZyB2YWx1ZSB0byB0aGUgZXhpc3RpbmcgdXNhZ2VzLCBpdCdzIGFib3V0IGZpeGluZyB0
aGUgaXNzdWUNCndoZW4gd2UgbG93ZXIgdGhlIEVQQyBsaW1pdCB0byBhIHBvaW50IHRoYXQgaXMg
bGVzcyB0aGFuIHRvdGFsIHZpcnR1YWwgRVBDIHNpemUuDQoNCkl0J3MgYSBkZXNpZ24gaXNzdWUs
IG9yIHNpbXBseSBhIGJ1ZyBpbiB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiB3ZSBuZWVkIHRv
DQpmaXguDQoNCj4gDQo+IFRoYXQgc2FpZCwgSSBkb24ndCBhbnRpY2lwYXRlIGFkZGluZyB0aGUg
ZW5mb3JjZW1lbnQgb2Yga2lsbGluZyBWTXMgYXQgIA0KPiBydW50aW1lIHdvdWxkIGJyZWFrIHN1
Y2ggdXNhZ2VzIGFzIGFkbWluL3VzZXIgY2FuIHNpbXBseSBjaG9vc2UgdG8gc2V0IHRoZSAgDQo+
IGxpbWl0IGVxdWFsIHRvIHRoZSBzdGF0aWMgc2l6ZSB0byBsYXVuY2ggdGhlIFZNIGFuZCBmb3Jn
ZXQgYWJvdXQgaXQuDQo+IA0KPiBHaXZlbiB0aGF0LCBJJ2xsIHByb3Bvc2UgYW4gYWRkLW9uIHBh
dGNoIHRvIHRoaXMgc2VyaWVzIGFzIFJGQyBhbmQgaGF2ZSAgDQo+IHNvbWUgZmVlZGJhY2sgZnJv
bSBjb21tdW5pdHkgYmVmb3JlIHdlIGRlY2lkZSBpZiB0aGF0IG5lZWRzIGJlIGluY2x1ZGVkIGlu
ICANCj4gZmlyc3QgdmVyc2lvbiBvciB3ZSBjYW4gc2tpcCBpdCB1bnRpbCB3ZSBoYXZlIEVQQyBy
ZWNsYWltaW5nIGZvciBWTXMuDQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGlzIHRoZSAiYWRk
LW9uIiBwYXRjaCB5b3UgYXJlIHRhbGtpbmcgYWJvdXQuDQoNCkkgbWVudGlvbmVkIHRoZSAidHlw
aWNhbCBkZXBsb3ltZW50IHRoaW5nIiBpcyB0aGF0IGNhbiBoZWxwIHVzIHVuZGVyc3RhbmQgd2hp
Y2gNCmFsZ29yaXRobSBpcyBiZXR0ZXIgd2F5IHRvIHNlbGVjdCB0aGUgdmljdGltLiAgQnV0IG5v
IG1hdHRlciB3aGF0IHdlIGNob29zZSwgd2UNCnN0aWxsIG5lZWQgdG8gZml4IHRoZSBidWcgbWVu
dGlvbmVkIGFib3ZlIGhlcmUuDQoNCkkgcmVhbGx5IHRoaW5rIHlvdSBzaG91bGQganVzdCBnbyB0
aGlzIHNpbXBsZSB3YXk6IA0KDQpXaGVuIHlvdSB3YW50IHRvIHRha2UgRVBDIGJhY2sgZnJvbSBW
TSwga2lsbCB0aGUgVk0uDQoNCkFub3RoZXIgYmFkIHRoaW5nIGFib3V0ICJqdXN0IHJlbW92aW5n
IEVQQyBwYWdlcyBmcm9tIFZNIiBpcyB0aGUgZW5jbGF2ZXMgaW4gdGhlDQpWTSB3b3VsZCBzdWZm
ZXIgInN1ZGRlbiBsb3NlIG9mIEVQQyIsIG9yIGV2ZW4gd29yc2UsIHN1ZmZlciBpdCBhdCBhIGhp
Z2gNCmZyZXF1ZW5jeS4gIEFsdGhvdWdoIHdlIGRlcGVuZCBvbiB0aGF0IGZvciBzdXBwb3J0aW5n
IFNHWCBWTSBsaXZlIG1pZ3JhdGlvbiwgYnV0DQp0aGF0IG5lZWRzIHRvIGF2b2lkZWQgaWYgcG9z
c2libGUuDQoNCg==
