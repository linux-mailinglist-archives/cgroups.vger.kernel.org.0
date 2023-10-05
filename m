Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC197BA0E8
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjJEOm4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbjJEOio (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:38:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE6646A4;
        Thu,  5 Oct 2023 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514614; x=1728050614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nHAKKaeQGvgtllKSIzOXWqlFkBKQFN2DimRZqDrFmbs=;
  b=Xc71W98I974Cn0XvvJOgF0feCy+EsWmVJG8esgzOzhHi+D5KmF7n3EGb
   YHAlBjZhy2A/pqHWAcDPSykIsDmsD2jUqh9dTKuf+v4UuZfV6eTQfpNUf
   xd3dIz1KWnjDcuS3o9USJdD7+aVZGYK/Lmh9LW9swfoY8vH9buRqoSAs6
   uUNibmRzYLCLT2cvz37kuuTBW8kOFlooEHJIqTmFBOXfrbSAqcHA0YuS4
   /WmLzfS7LEjWHAoiyTjAC+8OpRFxlhqZuwYyk0qZ/3SF1LBEQk2J4jeEr
   1xfNVsDmtmWNO1RdkfjSeuYFC/5A4Q04gesJrVZFWVY+D3m9i1vSzPEPg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="382349187"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382349187"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755428998"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755428998"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 05:30:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 05:30:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 05:30:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 05:30:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 05:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm/yMl4LxPNGk/6amFmBMIPfAA/yTukoxm/InG5Rd5q2jJiZoR5oaJ4mCgMeU5Qc14lKAyVl6K8yqAPqT+fUiRmTvuskdZIJ6XZsH/zpp1msE3ZJZi2Pcsp2hDN+smi7vt5mJ6GrjYPYeqIDlpPbmDuK3WXATTlgQmK91sv/pRLjZYekx3EnOR7MdXekIWjh+rhDdpRtIJXmdG7tdk3akBGMJs1ZHoWZmrr4pZ0wYTKBnUaOePgYvKWLJmmF5go/FMCH8i0wrr1XSPO/Apc6XTfYjhmh3Py6j/lg7nZdZpHdyCtzG/e3oYIzYYaX7UAgS82FnnBr/q2Ega7KAEBRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHAKKaeQGvgtllKSIzOXWqlFkBKQFN2DimRZqDrFmbs=;
 b=GImuVHJrjzNXOumIjWTNKJj4aKh7c+wtg1Q9FTOsRD57+9LTbGsRAV/hfpn1qgYll7+2CNZ7fNdk2acZDss0G8ZFi/6zbM51Hkbzr8AFIiG3cxDbEuQwDpqPKGPTjIQDE+jB1QFnHxramNSdSnbKmhs65+nUiHSLCgjz7bszJ5SAae9fz0iufYZvYJtIJQj9qRIWjPZSq50fMQUlt1ang6X79L+osbySJMSkJ++rcKWMd/+wibYpnH6X6ZiTG0dgR6GZm9ddy2GGJK0U3ADwuH3v5tJo6Hy2xKmtu10KXibgVpShWwqzbzZ0tRyj2DTYfv1RSyHLINYg3uCz9Np8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6284.namprd11.prod.outlook.com (2603:10b6:930:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Thu, 5 Oct
 2023 12:30:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 12:30:46 +0000
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
Subject: Re: [PATCH v5 15/18] x86/sgx: Prepare for multiple LRUs
Thread-Topic: [PATCH v5 15/18] x86/sgx: Prepare for multiple LRUs
Thread-Index: AQHZ7cskH0aU/ns4bkS7BrOr4Ie+NLA7M+4A
Date:   Thu, 5 Oct 2023 12:30:46 +0000
Message-ID: <6f71642624812da126b900e94e76a72166d9aecd.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-16-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-16-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6284:EE_
x-ms-office365-filtering-correlation-id: 636bc8e6-8a1f-42c4-bccd-08dbc59ee68b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8pAeBzpcBjFARCqf9kr9uiGgJL7NVjD3aBPjqcdcLGaFRiUbu3FMLqBq2eqAMnZh4oaxZMDNXeHb9hhMtNIRT0VSKZlLgpEKgKMnEp/p7/F4/SH3zx/90F+wRA3AhQ3jFig3aBPx6CvjDpj7gwS3j+3z1gA/klbALhn0+MUsv+TefVkjKoDBcf8xkB7lQD17iFyzX7Jd2Fjn2db7nGwMaXR6FydhJ4X6DGOi2JqlJ1AphQWV1i2KOx4Etratash0b3MymJEhYCgH1hhCFDk/oGl+jC6wgxkpuGWdHTXbS9Sf0nsQ1SRKDT+oFCEleslSrqSaAKBinHTHV1gq3dkLgZq8j844Jp3UgKPxaNZWo1ahYioKbJ/NJey5sd4ognftIEq+yGbcL99mNecmOgZWuHHQ1sZBjc0Z4sRkJsIAxPNjI7OLTB6NHnYw7DcRGwRrSmxPSSWIL6MLeeG2Uhxgf5oP3v6nqrxpssvE5mA681V9BshmORJarSro3OEs0rAHn0I0K4sP26YZumhHMnXnGxBdgMUxGvyk/n05qK9ChOqRjNx3j2cSiJ2FXrcbtJ4RkSKDdkOa+Kqjimv1i10weWHHfMK3HzjOSoUprDc8b9Q30C37IS0h3kH3DtkQWz+VPthk3XZgOWspgiTqk1FRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6486002)(478600001)(6506007)(71200400001)(38070700005)(86362001)(122000001)(82960400001)(921005)(38100700002)(2906002)(7416002)(91956017)(2616005)(26005)(6512007)(66556008)(76116006)(4744005)(36756003)(110136005)(4326008)(316002)(66446008)(64756008)(54906003)(41300700001)(5660300002)(66946007)(8676002)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHJ6TW8xL1FOU2RqK0NPaFBVWGF2dFFhV1o1RHNsaHEzbjFGQVlXYlFtUHc1?=
 =?utf-8?B?TDRuZHZzWWMrSWVualhEaU53Zkpic3FoWTNFdmdZMy8wSWk2emE0YzBIUGhu?=
 =?utf-8?B?K2RVbFAwZGtKZlMzYkZyMkplcThKcHpQL21iTUhKOW5OU2RrY21JZkJ3Mnh3?=
 =?utf-8?B?b2QzazNWa0JZY3FkMGRjSWE0UnBNZHgwNzk0RG4rUVF2d3pHS1EzUVdrVktk?=
 =?utf-8?B?ZjRNQUFhcXpTQVNLcHZFWEVPQWR2RUk0ZmhsL250ZUJ1ZmFwQi80MnczZ3Mz?=
 =?utf-8?B?QXpaUitZZzRERWhoaStrZ28ybVZUL0NYc1doOFZUZmpab29MM3dFejk5TWpL?=
 =?utf-8?B?WHFuVkV4Ym5hMmNwTXNQb1dWT3RUUmFONmZUcDdwUGI0OE5qWjdTRGFxa0xr?=
 =?utf-8?B?RS9uM1hZNWx5eFkzcU16QlF0ZEQxUTkwSkNhK0RQUmhPUUxjM1h4QWxQZVpJ?=
 =?utf-8?B?TlArVm1jaWpRYVAwWDJ1RXhUNWhyeUNLdUlSVzVONVJndXQwZFEzRUVhaGt6?=
 =?utf-8?B?cEYraS9ZckRWRndOWXUwV0hYZ1k3RENMbGE1bHVaQ01EZGhJTEp3SThBbGZi?=
 =?utf-8?B?b3BGME8rajFkOXZQNkZKZHRxYUR4YWk3WnRHTldRbHdNdVM0OS9PU25FS3Jq?=
 =?utf-8?B?Sm1DejBWbTNNMm4zbHQxTEJmTStuM2pBek54NmdMZ3FvSG9ycjllVkZxdnB6?=
 =?utf-8?B?NGhuNUk0WCtDa04xeS9TZytGejZidjBqSVhUUTVhZmh4Rnp2WjNucXVHM2lX?=
 =?utf-8?B?Q2pDM0U3RWUveXVIMlM2eWlseDcxVjUzbTc1Ymg1bFpqaFZlNUNMbEtoUWxV?=
 =?utf-8?B?dFVNRGZkY1l3clB0VEtGaHlsRXJmT21vZjk0UytuZUFHNmp4SmNtbCtTNDJJ?=
 =?utf-8?B?YjZlbk1hUGI4WGZoTjgzcE1USDNYeU42bU5BdnlXVWxoL29jU3BFV0JjaHJl?=
 =?utf-8?B?ZVpTZnhDVEx2UGE1aVFrZFIxd0FZeW5hL0V0SkpnQzFwZmpFdzNzcHZtVHVl?=
 =?utf-8?B?d3lQbUEwbmdueWtSOEpjdDQwMFBUM25RMDVXK2dvckkrbTg1elpNM3VKVk1Q?=
 =?utf-8?B?NlNkbkMvWHZaSmloY1NMSHhLOVVtVTZlbWJJL3R5dk1uMUNKd2lTS1kyNnVV?=
 =?utf-8?B?cEpwY3NvbVBoRzNCVkVPZk44OFVTaVd2cmFNSkU0eUNCT0dhWXFSNUpWWlpj?=
 =?utf-8?B?NVNuNWM0eTdyajgzYitBWmxCU0xENkFVRmFHTjNOcXJFRzNHQ29pOEpNOUtt?=
 =?utf-8?B?RS9ZMm50M05CcUwvY2JDS3NMTzBHZ3dnRVcwZVhyeS9GbkJRejJRZTJaV2xF?=
 =?utf-8?B?bExnVUROQ3Zudjd5T3ZwR2xEc2gza3RLR0FWNzZJT21CdFNMYWZEZXhwd0Rk?=
 =?utf-8?B?emVhcmQxenBiWkxaaVZpZjYyOVU3ajYwOGhtc0VwQy9ZZzNua0xWaFJKeHJE?=
 =?utf-8?B?Mk92Um5wY3FhdnQraldtVXJOUjY1NU9YaElpd1FlaDQvQVZ5VHdSUGFXZlZh?=
 =?utf-8?B?aXoreEt1ZjQ1YnE2dFFsWHlUSnVwK3B1MEEwbm1SdTR6cm1wVmJ6WTU3aDFO?=
 =?utf-8?B?RWNIcUd0QTh4YThJOFlLVnJnRHFESXRwLzlXK0hMVEVZQ3NDREtjTVFHSTRQ?=
 =?utf-8?B?VEs3VVBmRVJQTDVLU1gwSXNPcUlhZkE1a1BCalFNcmUydEJDNi8rZFgvcUJ5?=
 =?utf-8?B?SXVnMWxheU5Nb2dDRmNzNGpQWE50Rkk2U3E3U1dnWTNTU2VpakJiQVIxYSsy?=
 =?utf-8?B?eVFzZEV3ektHYSsrZ1pJVUlSR0xSYkgxekorSkZuUGc1MFM4VEFJMk9RSFlq?=
 =?utf-8?B?eEpFbHVXeG91YmJienBuVXFyYWIxdzg1bE5PUWMxdm15cjhMdHAyU0NEL2hz?=
 =?utf-8?B?aVZrL3ptZlRONHZaaVZkWEtvYlFyaDhnY1cwVEFTRW1zWlIxTzFqOUVMZUtz?=
 =?utf-8?B?U0xwNWsxOWowTlczcG9ieGxlMkJ2RTdNTkdRRzUvN0dhcEdQTUk0U0lhOU9C?=
 =?utf-8?B?TGJUMmR3K3A1cS9lSk1HanAwUGl1MFAxQzB1SVJaUGVZSGErUnViUkdXT3Vh?=
 =?utf-8?B?ellJSmRBeXBsRVFoMzVsbGdwUHFjaDE2WlFhSjFNVDFkd2xwbDZ2MkVkejJL?=
 =?utf-8?B?N0pZRGd1a2JmY1hmYmQwRVBKS2I3WEhxbUlmd3o0MmlyZmd2Z05aaG4zaTZG?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB262D3BCD542E4BB8E0ACDAA06FB2AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636bc8e6-8a1f-42c4-bccd-08dbc59ee68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 12:30:46.6457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsDfFp8SMbMkozTPthnqeynjUr9Y8CkwEx6Gqc69bncxZ80GOvWVFFciacrCYt6xc07r3lW+0qfn5LEkYWvLGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6284
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBzZ3hfZXBjX2xydV9saXN0cyAqc2d4X2xydV9saXN0cyhz
dHJ1Y3Qgc2d4X2VwY19wYWdlICplcGNfcGFnZSkNCj4gK3sNCj4gKwlyZXR1cm4gJnNneF9nbG9i
YWxfbHJ1Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgc2d4X2Nhbl9yZWNsYWlt
KHZvaWQpDQo+ICt7DQo+ICsJcmV0dXJuICFsaXN0X2VtcHR5KCZzZ3hfZ2xvYmFsX2xydS5yZWNs
YWltYWJsZSk7DQo+ICt9DQo+ICsNCg0KU2hvdWxkbid0IHNneF9jYW5fcmVjbGFpbSgpIGFsc28g
dGFrZSBhICdzdHJ1Y3Qgc2d4X2VwY19scnVfbGlzdHMgKic/DQoNCkkgdGhvdWdodCB3ZSBhbHNv
IG5lZWQgdG8gY2hlY2sgd2hldGhlciBhIGNncm91cCdzIExSVSBsaXN0cyBjYW4gYmUgcmVjbGFp
bWVkPw0K
