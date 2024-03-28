Return-Path: <cgroups+bounces-2227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4028288FFA3
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 13:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AC71F26A9C
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE4E7F487;
	Thu, 28 Mar 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lE1qeDzw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814C7D416;
	Thu, 28 Mar 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630434; cv=fail; b=AYMzIZ9GGYWV0hhQChvs3/AfSXBJn5Fes2zBH2dSEBdOQQUJbm1GVTMhPCuHBLAQ8m8sEcl8+15MfvAvxXDPmKf9GIEDCpBHUrIQQuhe1Fq0iUGFaFbvRFR7DV9PnZyqNhAobLdONielbDjhFNTLIaCexlXBv07N8ayv4mppDas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630434; c=relaxed/simple;
	bh=3/bXIgJ8VvswPXOLlzUnh6fyF+jJnqkp5UBPT8mprFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TfKYwHLTjCmeyN6QLrHRgZn2IHnbILgrEdR1qLD8NiB/EoM5eKWgTdbsvOZ/E1mUT8mEb4OBGKL1AoUB2clSPGpSSMTKR65wn9/qTYshE87zDT1PC5ESlrefsFfIlksc9f9ZYu/GlW6/yaWYLqFvjiZvmrNqUkAh4x/S/IfTF8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lE1qeDzw; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711630431; x=1743166431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3/bXIgJ8VvswPXOLlzUnh6fyF+jJnqkp5UBPT8mprFk=;
  b=lE1qeDzwhgvZihfusLGU25spgyXNKO7wVGyAwGBGVJlkCw3ld6LTLIjo
   w9IcCPaeBaNlmfgwcdmtjdH3Lg7Ruf7vV0UqtRoPr1Vmun+MT+pDoZT9r
   BlkYQ0reMkQgBQaoLXPZv30bozwL49lApOYXUvzdQah0F59SuYKVFqF3B
   uieoUHo8JNdzujn+WbPaFUi2HyS0E0keoyYT2gsc/NpfuT0tNt4dxU8SS
   2evDA1BeOekem/MWd6c5Fijp7BmRc1I+IwHJalbKhCH/jT3OzI7Lwk/0B
   0h76aarkZXnVi2vMmGUxmqFSw25kalRS5luZw+a6U4MfqfdGMFOMXgblC
   g==;
X-CSE-ConnectionGUID: SYf4Qt0DTT+nIvunRPmlvQ==
X-CSE-MsgGUID: MZKeRiGSRqeb1ov6CgwhaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17329970"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17329970"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 05:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="16711163"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 05:53:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 05:53:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 05:53:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 05:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTrOIksewkycycs7b7+mYlBSHG7CPv+dDq7np65p+egzp4T5pZxecDovSwLfQKCcLswVt6pdixP2NjebaFgjO8KM19+8EEp44e2HjL7J6NvUv0G22SK1niJkEOHJ831A1YNX9UcJVRqravcWxkieRjk4EjN2B5HFSBjgWHPE3uLIrgZWJ61qx61lfHEEYTOiM7pHhxtdgpQaV4xNSuGMA7amVJ83a4nogmmXf9x40HK68xQnO3pKBEZ+bDVdS/b8SEwdPqsn64qgUw8NAG5JVecYJLxAnu5Y9+JKZY8YJTEIU+wzDRleUbPxB95a8ZlUSQaNF+PsGrpV+71cWj1S5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/bXIgJ8VvswPXOLlzUnh6fyF+jJnqkp5UBPT8mprFk=;
 b=SExQ4biNUyedtgemw5KBgLnPdoLLFbgErOFa2yVgu0dTRZ7OVaYnYsb9JGT3+XbR2WbEgKudfN+W6V3zRZDJfcy/O2FbVUYtZLIri1+WHQf+kNZIgCtP4GSwYEVIbuVzHr4hrWdjGRl7Wg74Dk2Iw+2q4XUPWysKhxRv2GD0Q6DMVXt9ifZGiARr8m1AZfWRtA2EVUQP0WU+2lxZOAEWw+7muCndrNoijjcsukannrqzI88VC30jYB2odiCf5qp+mfU02ICpgdl4djUXlyh+06DYbCXXLKIvAZhYEm4MW9crioeAdLwe3P2gVWg6J27ox5O3d4Lfto5QVo3xgCRHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 12:53:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 12:53:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHagKYLsFT4s142u0e+3dOpqX6L9LFNHJ0A
Date: Thu, 28 Mar 2024 12:53:45 +0000
Message-ID: <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-6-haitao.huang@linux.intel.com>
In-Reply-To: <20240328002229.30264-6-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6210:EE_
x-ms-office365-filtering-correlation-id: be7a7846-598d-4b27-8998-08dc4f261aaa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjVyp3OwW5f6N0qTfpeyYAdvlqFftDGL0FDuox01FZv5BhsLBFX+koqdPtdpaSY8Lr0dud64/njPB35vAMQKyFvWAwUqng9U8FAcJ8QUsqd0JXumDIDkdmXrjYqZrSrKsYH4YzH1ANW3pPRDRPNo9EikFBJy4gsOk+sahAL/NdK2zxh9bBKDQPot8zoiXA5ULibkkU48LYoW20AHODqWqzQPP+U97/f1ILb8f8gdcxzpw6Y3JnRasKai9Wh1f+Lpkp/yHXz1vLyLaU54P1nsm4oSwfRDOWCsSSWDTuDEvCHDgh7l696VBbzYZFcYF0L4Gs38FvXprC/r0cQ+LRY05uacQQYIG9fdrz0afNP1trZTMNVkZv0Cfo+EeQLaBdpiVEGT1N4WtI2ZXdX6lRhcUydF/qNrhvsHDKRAOvWwU0zlEZCW207WxMCDq1RtnckMPb0r9Gago6wqEsNu2fhRD+lmOLMKmYy+oeC9YSYP56BISHW+645pKVDA9wikNM8nPoXaZw0z+3EYaFy+jJUFiC5tdxr6QtUAz1RySTv1CfLGYqYpCOXoqK5vBNRziS5Keiun1emO/37tTIJYrJ0D0jkX6pmacN2fVN6sL7iTSFpsltDBB7eD/NLs9fK1nZGBUvJyZOF+SPhTbPGd7O3xf2YpXjAa5CLon1st8bKotPP1iCyy3b5iRr4Eks99ry0UCO7eNQ90ThQPu6/mIm50ZKhpCp4OgxiIhuAde262FEo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0lPNlFPK2dOdGVmS2s3UDBuQWR5TlZCV3p5NGxGMWRRT2dtcDBiZGlrMXcw?=
 =?utf-8?B?aW9FdUtWRlQrRi93VTJvR2wyc1Y5SnBPa1pORm5jWFVlYkN5S1BZclRYazhj?=
 =?utf-8?B?b0Y3OFI1YUROYmQzZFhXNFRpZnYyTjBhNFJlZjRKNjRXYjJiN21odTljNit5?=
 =?utf-8?B?Z05lTUtvSFREckhUbVFiSXI4Y09tQ1hqejBnMVh0STB0Szd5ZUNETW5vSjZ3?=
 =?utf-8?B?MGNLYVB4QTlnL25zT1Y1aEMrOGt5VVJKd3VOM20va3ljdmxsTjlLWWZhSEs2?=
 =?utf-8?B?OFpMTi9ncFd4anE3aXhyRUVMczAzUXRNSTJZejZ5RWFrZEhPRDB0T09HeFZU?=
 =?utf-8?B?VlZFS3NKekFLdVVQdFlIaXNONGN4N1hWTVR5Y2Z6TDh1L3BZZHZCbjAwWmxD?=
 =?utf-8?B?VU1sK1hld0FQekUxRmp6ZGE5QzZjdTVjNGlneGdvdDd3MTNSUVhpczU3ODRV?=
 =?utf-8?B?UWFsTm90ekIyZE5TZFhyWnFPdlpiVnBtQmRraUVvQWhJOVRGWEwrYm4wcWRC?=
 =?utf-8?B?b3VNK0dnV3NBY2F2WFZQNzV2R2JMNGZTd3JpaXNaY0tpZHdtOEUreThtcm1J?=
 =?utf-8?B?UlFZVHpOUlcvOC9DNjlVOXpMblE5dlRoNkFmeXlQRTI2NTRvQWFqM0FDVTdo?=
 =?utf-8?B?RTYvNVlJTHRDTzZBYys2cUxEMXJZWk9NWXNENFQ0Y2lNUDV5S0ZFUVhaY2dy?=
 =?utf-8?B?RWFRU3RpWUs2eWN0WXVxS2crSE1RSTVxOFY2Z2hpWkIwQ1Y1UDEycmtybklj?=
 =?utf-8?B?OWd3bXhnNE1qRzFzM0hwZFBZSHRnaFFlaTUzTlh2Rzh6YmpjNktnMXNEMTVm?=
 =?utf-8?B?WUtBaG5ERUpSakxsb2dPYnQwSlBmN2o4YmtNeW02RXFMMFBpOGhSeXd6Mzd5?=
 =?utf-8?B?K3VEODlRb3BTSUxzLzg2b1VrUVdkanZKTUJxcXN4T0NaSkNjckUzaUU2QXBV?=
 =?utf-8?B?dElWbi8wR3ByR0UxMDRGOEw2bXBjbnFqVVFPYVZvMXF1OFJLL2pnRUtLdWRK?=
 =?utf-8?B?SERJUGlwZ0d1UVA1Q21zdElmMytKUU8xL0Z2Y0hrd2JPRUtUVnE5VU5ZUGF4?=
 =?utf-8?B?YXBYOHcxMUlrY0EwcHlHREdQcENWYkFYYU0vYXhnM1Z3SWZpLzVBdmREN1F2?=
 =?utf-8?B?akJscFd0R0NUTVFEUE5oR0Y1ajhHUmtEaTJML2NDWlMzTHIyY2ZXUlJ3ZHNB?=
 =?utf-8?B?a1ZSM1VOUGt2VUxCWXZhMzF5U0RUZnhUcnJ5VUNLcHJ1Zis0OFBRUGJjL01W?=
 =?utf-8?B?RFprbkNYUExWRENtandNeml3YWRNbE5BOVRlb1JyM3I5R2d4R0xiNlQvT2FB?=
 =?utf-8?B?Mmd5b1FXcnd3M2k1emdyRW9oLzFmSlFWNHVNcVFIbW5WeE9QR2YxdjVoYmF3?=
 =?utf-8?B?cXhCOWplYnNJa01Id0grY0NrMTZZMXFHblNHTkVzaFViVTB4b1hiaWtNSFRa?=
 =?utf-8?B?MDZQQ0xoeHVsOEgraVVTeVp0cGovby9mejYra3NPOVdhaGNpNUlCRGlXUFM1?=
 =?utf-8?B?cmJadk5RMktNWG4zbjRQR04vcnJaWjZnUDNHMHRpV3BXbWZLUlF4SEFiaUlQ?=
 =?utf-8?B?NE8vZzV5M092ZWNUR0N5WDBURDF2cnduZkxwYjBDcTRBbmVFckpwN0FkQmI2?=
 =?utf-8?B?cG5xa2grbjU0eDNvVW5Ba3hlSDI2YlBTYWVBSnFaaTYwY0U0emNHd3VSOUdL?=
 =?utf-8?B?SUo5N1owWTZwdks5SDl0VlpIanRBTlp4Y2MwZzN4R0xhV2xBUmNaVzFNL2Vr?=
 =?utf-8?B?MGg5ekRHSm9YbjBqZUNHaTVZOXdUakdvLzY0a2EvVzlMTW8wSThiZk9rN0lC?=
 =?utf-8?B?Q2txZk5SaG5zYWNqUDZOT01iMVRzT1d6QlRzTWZNZ3ZOQ09USjlZYStJbGpB?=
 =?utf-8?B?aVNEYjFLOFAxUGEwRE51Z1NMeXRGTmM4YkxjSDVUbC83QTduTll6UWhpZTlN?=
 =?utf-8?B?b05iQTlCYklieitVaUtiNEl4ZFZmMWtibmp6Mk5KVXN0TktQeHVOYysxdzAv?=
 =?utf-8?B?ZDdqUG5mUGczNDNMVTJUcmZvYnpmSmRHMmdXK1p0eU5LV2lMdHFIdko5Z25K?=
 =?utf-8?B?YXB6NXR5OWcrSHVwY01XRXgyTUE1WDlveTdmaFBsaCs4MmUyVUhjekx1N1Bp?=
 =?utf-8?B?ZWpMcUZEa2lvZ0FkTVVSRzE2RWYwaGtSZlpTNWFjeHNqaWhjbmtHc1lqUnRi?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58B80FA42BF8B140B35338C4C6A4FB14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7a7846-598d-4b27-8998-08dc4f261aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 12:53:45.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cq/9Qnae5cWPXpHLLNhSb3nwLoVDaKfbxeJve5KpNtUMzSVGg30XcD5PiMSnYv0jNyrHC5PtTWXcDTRbKOqMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
X-OriginatorOrg: intel.com

DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZXBjX2Nn
cm91cC5jDQo+IEBAIC0wLDAgKzEsNzQgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ICsvLyBDb3B5cmlnaHQoYykgMjAyMiBJbnRlbCBDb3Jwb3JhdGlvbi4NCg0K
SXQncyAyMDI0IG5vdy4NCg0KQW5kIGxvb2tzIHlvdSBuZWVkIHRvIHVzZSBDIHN0eWxlIGNvbW1l
bnQgZm9yIC8qIENvcHlyaWdodCAuLi4gKi8sIGFmdGVyIGxvb2tpbmcNCmF0IHNvbWUgb3RoZXIg
QyBmaWxlcy4NCg0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgvYXRvbWljLmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+DQo+ICsjaW5jbHVkZSAiZXBjX2Nncm91cC5oIg0KPiArDQo+ICsv
KiBUaGUgcm9vdCBTR1ggRVBDIGNncm91cCAqLw0KPiArc3RhdGljIHN0cnVjdCBzZ3hfY2dyb3Vw
IHNneF9jZ19yb290Ow0KPiArDQo+ICsvKioNCj4gKyAqIHNneF9jZ3JvdXBfdHJ5X2NoYXJnZSgp
IC0gdHJ5IHRvIGNoYXJnZSBjZ3JvdXAgZm9yIGEgc2luZ2xlIEVQQyBwYWdlDQo+ICsgKg0KPiAr
ICogQHNneF9jZzoJVGhlIEVQQyBjZ3JvdXAgdG8gYmUgY2hhcmdlZCBmb3IgdGhlIHBhZ2UuDQo+
ICsgKiBSZXR1cm46DQo+ICsgKiAqICUwIC0gSWYgc3VjY2Vzc2Z1bGx5IGNoYXJnZWQuDQo+ICsg
KiAqIC1lcnJubyAtIGZvciBmYWlsdXJlcy4NCj4gKyAqLw0KPiAraW50IHNneF9jZ3JvdXBfdHJ5
X2NoYXJnZShzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2NnKQ0KPiArew0KPiArCXJldHVybiBtaXNj
X2NnX3RyeV9jaGFyZ2UoTUlTQ19DR19SRVNfU0dYX0VQQywgc2d4X2NnLT5jZywgUEFHRV9TSVpF
KTsNCj4gK30NCj4gKw0KPiArLyoqDQo+ICsgKiBzZ3hfY2dyb3VwX3VuY2hhcmdlKCkgLSB1bmNo
YXJnZSBhIGNncm91cCBmb3IgYW4gRVBDIHBhZ2UNCj4gKyAqIEBzZ3hfY2c6CVRoZSBjaGFyZ2Vk
IHNneCBjZ3JvdXANCj4gKyAqLw0KPiArdm9pZCBzZ3hfY2dyb3VwX3VuY2hhcmdlKHN0cnVjdCBz
Z3hfY2dyb3VwICpzZ3hfY2cpDQo+ICt7DQo+ICsJbWlzY19jZ191bmNoYXJnZShNSVNDX0NHX1JF
U19TR1hfRVBDLCBzZ3hfY2ctPmNnLCBQQUdFX1NJWkUpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
dm9pZCBzZ3hfY2dyb3VwX2ZyZWUoc3RydWN0IG1pc2NfY2cgKmNnKQ0KPiArew0KPiArCXN0cnVj
dCBzZ3hfY2dyb3VwICpzZ3hfY2c7DQo+ICsNCj4gKwlzZ3hfY2cgPSBzZ3hfY2dyb3VwX2Zyb21f
bWlzY19jZyhjZyk7DQo+ICsJaWYgKCFzZ3hfY2cpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWtm
cmVlKHNneF9jZyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgc2d4X2Nncm91cF9hbGxvYyhz
dHJ1Y3QgbWlzY19jZyAqY2cpOw0KDQpBZ2FpbiwgdGhpcyBkZWNsYXJhdGlvbiBjYW4gYmUgcmVt
b3ZlZCBpZiB5b3UgbW92ZSB0aGUgYmVsb3cgc3RydWN0dXJlIC4uLg0KDQo+ICsNCj4gK2NvbnN0
IHN0cnVjdCBtaXNjX3Jlc19vcHMgc2d4X2Nncm91cF9vcHMgPSB7DQo+ICsJLmFsbG9jID0gc2d4
X2Nncm91cF9hbGxvYywNCj4gKwkuZnJlZSA9IHNneF9jZ3JvdXBfZnJlZSwNCj4gK307DQo+ICsN
Cj4gK3N0YXRpYyB2b2lkIHNneF9jZ3JvdXBfbWlzY19pbml0KHN0cnVjdCBtaXNjX2NnICpjZywg
c3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZykNCj4gK3sNCj4gKwljZy0+cmVzW01JU0NfQ0dfUkVT
X1NHWF9FUENdLnByaXYgPSBzZ3hfY2c7DQo+ICsJc2d4X2NnLT5jZyA9IGNnOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW50IHNneF9jZ3JvdXBfYWxsb2Moc3RydWN0IG1pc2NfY2cgKmNnKQ0KPiAr
ew0KPiArCXN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2c7DQo+ICsNCj4gKwlzZ3hfY2cgPSBremFs
bG9jKHNpemVvZigqc2d4X2NnKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFzZ3hfY2cpDQo+ICsJ
CXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJc2d4X2Nncm91cF9taXNjX2luaXQoY2csIHNneF9j
Zyk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCg0KLi4uIGhlcmUuDQoNCj4gKw0KPiArdm9p
ZCBzZ3hfY2dyb3VwX2luaXQodm9pZCkNCj4gK3sNCj4gKwltaXNjX2NnX3NldF9vcHMoTUlTQ19D
R19SRVNfU0dYX0VQQywgJnNneF9jZ3JvdXBfb3BzKTsNCj4gKwlzZ3hfY2dyb3VwX21pc2NfaW5p
dChtaXNjX2NnX3Jvb3QoKSwgJnNneF9jZ19yb290KTsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaCBiL2FyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L2VwY19jZ3JvdXAuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
MDAwMDAuLjhmNzk0ZTIzZmFkNg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaA0KPiBAQCAtMCwwICsxLDcwIEBADQo+ICsvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiArLyogQ29weXJpZ2h0KGMpIDIwMjIg
SW50ZWwgQ29ycG9yYXRpb24uICovDQo+ICsjaWZuZGVmIF9TR1hfRVBDX0NHUk9VUF9IXw0KPiAr
I2RlZmluZSBfU0dYX0VQQ19DR1JPVVBfSF8NCj4gKw0KPiArI2luY2x1ZGUgPGFzbS9zZ3guaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9jZ3JvdXAuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9taXNjX2Nn
cm91cC5oPg0KPiArDQo+ICsjaW5jbHVkZSAic2d4LmgiDQo+ICsNCj4gKyNpZm5kZWYgQ09ORklH
X0NHUk9VUF9TR1hfRVBDDQoNCk5pdDogYWRkIGFuIGVtcHR5IGxpbmUgdG8gbWFrZSB0ZXh0IG1v
cmUgYnJlYXRoYWJsZS4NCg0KPiArI2RlZmluZSBNSVNDX0NHX1JFU19TR1hfRVBDIE1JU0NfQ0df
UkVTX1RZUEVTDQo+ICtzdHJ1Y3Qgc2d4X2Nncm91cDsNCj4gKw0KPiArc3RhdGljIGlubGluZSBz
dHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2dldF9jdXJyZW50X2NnKHZvaWQpDQo+ICt7DQo+ICsJcmV0
dXJuIE5VTEw7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzZ3hfcHV0X2NnKHN0
cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2cpIHsgfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIGludCBz
Z3hfY2dyb3VwX3RyeV9jaGFyZ2Uoc3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZykNCj4gK3sNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSB2b2lkIHNneF9jZ3JvdXBf
dW5jaGFyZ2Uoc3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZykgeyB9DQo+ICsNCj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBzZ3hfY2dyb3VwX2luaXQodm9pZCkgeyB9DQo+ICsjZWxzZQ0KDQpOaXQ6IEkg
cHJlZmVyIHR3byBlbXB0eSBsaW5lcyBiZWZvcmUgYW5kIGFmdGVyIHRoZSAnZWxzZScuDQoNCj4g
K3N0cnVjdCBzZ3hfY2dyb3VwIHsNCj4gKwlzdHJ1Y3QgbWlzY19jZyAqY2c7DQo+ICt9Ow0KPiAr
DQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2dyb3VwX2Zyb21fbWlz
Y19jZyhzdHJ1Y3QgbWlzY19jZyAqY2cpDQo+ICt7DQo+ICsJcmV0dXJuIChzdHJ1Y3Qgc2d4X2Nn
cm91cCAqKShjZy0+cmVzW01JU0NfQ0dfUkVTX1NHWF9FUENdLnByaXYpOw0KPiArfQ0KPiArDQo+
ICsvKioNCj4gKyAqIHNneF9nZXRfY3VycmVudF9jZygpIC0gZ2V0IHRoZSBFUEMgY2dyb3VwIG9m
IGN1cnJlbnQgcHJvY2Vzcy4NCj4gKyAqDQo+ICsgKiBSZXR1cm5lZCBjZ3JvdXAgaGFzIGl0cyBy
ZWYgY291bnQgaW5jcmVhc2VkIGJ5IDEuIENhbGxlciBtdXN0IGNhbGwNCj4gKyAqIHNneF9wdXRf
Y2coKSB0byByZXR1cm4gdGhlIHJlZmVyZW5jZS4NCj4gKyAqDQo+ICsgKiBSZXR1cm46IEVQQyBj
Z3JvdXAgdG8gd2hpY2ggdGhlIGN1cnJlbnQgdGFzayBiZWxvbmdzIHRvLg0KPiArICovDQo+ICtz
dGF0aWMgaW5saW5lIHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfZ2V0X2N1cnJlbnRfY2codm9pZCkN
Cj4gK3sNCj4gKwlyZXR1cm4gc2d4X2Nncm91cF9mcm9tX21pc2NfY2coZ2V0X2N1cnJlbnRfbWlz
Y19jZygpKTsNCj4gK30NCg0KQWdhaW4sIEkgX3RoaW5rXyB5b3UgbmVlZCB0byBjaGVjayB3aGV0
aGVyIGdldF9jdXJyZW50X21pc2NfY2coKSByZXR1cm5zIE5VTEw/DQoNCk1pc2MgY2dyb3VwIGNh
biBiZSBkaXNhYmxlZCBieSBjb21tYW5kIGxpbmUgZXZlbiBpdCBpcyBvbiBpbiB0aGUgS2NvbmZp
Zy4NCg0KSSBhbSBub3QgZXhwZXJ0IG9uIGNncm91cCwgc28gY291bGQgeW91IGNoZWNrIG9uIHRo
aXM/DQoNCj4gKw0KPiArLyoqDQo+ICsgKiBzZ3hfcHV0X3NneF9jZygpIC0gUHV0IHRoZSBFUEMg
Y2dyb3VwIGFuZCByZWR1Y2UgaXRzIHJlZiBjb3VudC4NCj4gKyAqIEBzZ3hfY2cgLSBFUEMgY2dy
b3VwIHRvIHB1dC4NCj4gKyAqLw0KPiArc3RhdGljIGlubGluZSB2b2lkIHNneF9wdXRfY2coc3Ry
dWN0IHNneF9jZ3JvdXAgKnNneF9jZykNCj4gK3sNCj4gKwlpZiAoc2d4X2NnKQ0KPiArCQlwdXRf
bWlzY19jZyhzZ3hfY2ctPmNnKTsNCj4gK30NCj4gKw0KPiAraW50IHNneF9jZ3JvdXBfdHJ5X2No
YXJnZShzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2NnKTsNCj4gK3ZvaWQgc2d4X2Nncm91cF91bmNo
YXJnZShzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2NnKTsNCj4gK3ZvaWQgc2d4X2Nncm91cF9pbml0
KHZvaWQpOw0KPiArDQo+ICsjZW5kaWYNCj4gKw0KPiArI2VuZGlmIC8qIF9TR1hfRVBDX0NHUk9V
UF9IXyAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jIGIv
YXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jDQo+IGluZGV4IGQyMTlmMTQzNjVkNC4uMDIz
YWY1NGMxYmViIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMN
Cj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jDQo+IEBAIC02LDYgKzYsNyBA
QA0KPiAgI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9rdGhy
ZWFkLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbWlzY2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L21pc2NfY2dyb3VwLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbm9kZS5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3BhZ2VtYXAuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9yYXRlbGltaXQuaD4NCj4g
QEAgLTE3LDYgKzE4LDcgQEANCj4gICNpbmNsdWRlICJkcml2ZXIuaCINCj4gICNpbmNsdWRlICJl
bmNsLmgiDQo+ICAjaW5jbHVkZSAiZW5jbHMuaCINCj4gKyNpbmNsdWRlICJlcGNfY2dyb3VwLmgi
DQo+ICANCj4gIHN0cnVjdCBzZ3hfZXBjX3NlY3Rpb24gc2d4X2VwY19zZWN0aW9uc1tTR1hfTUFY
X0VQQ19TRUNUSU9OU107DQo+ICBzdGF0aWMgaW50IHNneF9ucl9lcGNfc2VjdGlvbnM7DQo+IEBA
IC01NTgsNyArNTYwLDE2IEBAIGludCBzZ3hfdW5tYXJrX3BhZ2VfcmVjbGFpbWFibGUoc3RydWN0
IHNneF9lcGNfcGFnZSAqcGFnZSkNCj4gICAqLw0KPiAgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4
X2FsbG9jX2VwY19wYWdlKHZvaWQgKm93bmVyLCBlbnVtIHNneF9yZWNsYWltIHJlY2xhaW0pDQo+
ICB7DQo+ICsJc3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZzsNCj4gIAlzdHJ1Y3Qgc2d4X2VwY19w
YWdlICpwYWdlOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlzZ3hfY2cgPSBzZ3hfZ2V0X2N1cnJl
bnRfY2coKTsNCj4gKwlyZXQgPSBzZ3hfY2dyb3VwX3RyeV9jaGFyZ2Uoc2d4X2NnKTsNCj4gKwlp
ZiAocmV0KSB7DQo+ICsJCXNneF9wdXRfY2coc2d4X2NnKTsNCj4gKwkJcmV0dXJuIEVSUl9QVFIo
cmV0KTsNCj4gKwl9DQo+ICANCj4gIAlmb3IgKCA7IDsgKSB7DQo+ICAJCXBhZ2UgPSBfX3NneF9h
bGxvY19lcGNfcGFnZSgpOw0KPiBAQCAtNTY3LDggKzU3OCwxMCBAQCBzdHJ1Y3Qgc2d4X2VwY19w
YWdlICpzZ3hfYWxsb2NfZXBjX3BhZ2Uodm9pZCAqb3duZXIsIGVudW0gc2d4X3JlY2xhaW0gcmVj
bGFpbSkNCj4gIAkJCWJyZWFrOw0KPiAgCQl9DQo+ICANCj4gLQkJaWYgKGxpc3RfZW1wdHkoJnNn
eF9hY3RpdmVfcGFnZV9saXN0KSkNCj4gLQkJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiAr
CQlpZiAobGlzdF9lbXB0eSgmc2d4X2FjdGl2ZV9wYWdlX2xpc3QpKSB7DQo+ICsJCQlwYWdlID0g
RVJSX1BUUigtRU5PTUVNKTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICANCj4gIAkJaWYgKHJl
Y2xhaW0gPT0gU0dYX05PX1JFQ0xBSU0pIHsNCj4gIAkJCXBhZ2UgPSBFUlJfUFRSKC1FQlVTWSk7
DQo+IEBAIC01ODAsMTAgKzU5MywyNCBAQCBzdHJ1Y3Qgc2d4X2VwY19wYWdlICpzZ3hfYWxsb2Nf
ZXBjX3BhZ2Uodm9pZCAqb3duZXIsIGVudW0gc2d4X3JlY2xhaW0gcmVjbGFpbSkNCj4gIAkJCWJy
ZWFrOw0KPiAgCQl9DQo+ICANCj4gKwkJLyoNCj4gKwkJICogTmVlZCB0byBkbyBhIGdsb2JhbCBy
ZWNsYW1hdGlvbiBpZiBjZ3JvdXAgd2FzIG5vdCBmdWxsIGJ1dCBmcmVlDQo+ICsJCSAqIHBoeXNp
Y2FsIHBhZ2VzIHJ1biBvdXQsIGNhdXNpbmcgX19zZ3hfYWxsb2NfZXBjX3BhZ2UoKSB0byBmYWls
Lg0KPiArCQkgKi8NCg0KQWdhaW4sIHRvIG1lIHRoaXMgY29tbWVudCBzaG91bGRuJ3QgYmUgaGVy
ZSwgYmVjYXVzZSBpdCBkb2Vzbid0IGFkZCBhbnkgbW9yZQ0KaW5mb3JtYXRpb24uDQoNCklmIHlv
dSBjYW4gcmVhY2ggaGVyZSwgeW91IGhhdmUgcGFzc2VkIHRoZSBjaGFyZ2UoKS4gIEluIGZhY3Qs
IEkgYmVsaWV2ZSB0aGlzDQpkb2Vzbid0IG1hdHRlcjrCoA0KDQpXaGVuIHlvdSBmYWlsIHRvIGFs
bG9jYXRlLCB5b3UganVzdCBuZWVkIHRvIHJlY2xhaW0uDQoNCk5vdyB5b3Ugb25seSBoYXZlIHRo
ZSBnbG9iYWwgcmVjbGFtYXRpb24sIHRodXMgeW91IG5lZWQgdG8gcmVjbGFpbSBmcm9tIGl0Lg0K
DQpQZXJoYXBzIGl0IGlzIHVzZWZ1bCB3aGVuIHlvdSBoYXZlIHBlci1jZ3JvdXAgTFJVIGxpc3Qu
ICBJbiB0aGF0IGNhc2UgeW91IGNhbg0KcHV0IHRoaXMgY29tbWVudCB0aGVyZS4NCg0KPiAgCQlz
Z3hfcmVjbGFpbV9wYWdlcygpOw0KPiAgCQljb25kX3Jlc2NoZWQoKTsNCj4gIAl9DQo+ICANCj4g
KyNpZmRlZiBDT05GSUdfQ0dST1VQX1NHWF9FUEMNCj4gKwlpZiAoIUlTX0VSUihwYWdlKSkgew0K
PiArCQlXQVJOX09OX09OQ0UocGFnZS0+c2d4X2NnKTsNCj4gKwkJLyogc2d4X3B1dF9jZygpIGlu
IHNneF9mcmVlX2VwY19wYWdlKCkgKi8NCj4gKwkJcGFnZS0+c2d4X2NnID0gc2d4X2NnOw0KPiAr
CX0gZWxzZSB7DQo+ICsJCXNneF9jZ3JvdXBfdW5jaGFyZ2Uoc2d4X2NnKTsNCj4gKwkJc2d4X3B1
dF9jZyhzZ3hfY2cpOw0KPiArCX0NCj4gKyNlbmRpZg0KDQpBZ2FpbiwgSU1ITyBoYXZpbmcgQ09O
RklHX0NHUk9VUF9TR1hfRVBDIGhlcmUgaXMgdWdseSwgYmVjYXVzZSBpdCBkb2Vzbid0IGV2ZW4N
Cm1hdGNoIHRoZSB0cnlfY2hhcmdlKCkgYWJvdmUsIHdoaWNoIGRvZXNuJ3QgaGF2ZSB0aGUgQ09O
RklHX0NHUk9VUF9TR1hfRVBDLg0KDQpJZiB5b3UgYWRkIGEgd3JhcHBlciBpbiAiZXBjX2Nncm91
cC5oIg0KDQpzdGF0aWMgaW5saW5lIHZvaWQgc2d4X2VwY19wYWdlX3NldF9jZ3JvdXAoc3RydWN0
IGVwY19wYWdlICplcGNfcGFnZSzCoA0KCQkJCQkgICBzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2Nn
KQ0Kew0KI2lmZGVmIENPTkZJR19DR1JPVVBfU0dYX0VQQw0KCWVwY19wYWdlLT5zZ3hfY2cgPSBz
Z3hfY2c7DQojZW5kaWYJCQ0KfQ0KDQpUaGVuIEkgYmVsaWV2ZSB0aGUgYWJvdmUgY2FuIGJlIHNp
bXBsaWZpZWQgdG86DQoNCglpZiAoIUlTX0VSUihwYWdlKSkgew0KCQlzZ3hfZXBjX3BhZ2Vfc2V0
X2Nncm91cChwYWdlLCBzZ3hfY2cpOw0KCX0gZWxzZSB7DQoJCXNneF9jZ3JvdXBfdW5jaGFyZ2Uo
c2d4X2NnKTsNCgkJc2d4X3B1dF9jZyhzZ3hfY2cpOw0KCX0NCiANCj4gIAlpZiAoc2d4X3Nob3Vs
ZF9yZWNsYWltKFNHWF9OUl9MT1dfUEFHRVMpKQ0KPiAgCQl3YWtlX3VwKCZrc2d4ZF93YWl0cSk7
DQo+ICANCj4gQEAgLTYwNCw2ICs2MzEsMTQgQEAgdm9pZCBzZ3hfZnJlZV9lcGNfcGFnZShzdHJ1
Y3Qgc2d4X2VwY19wYWdlICpwYWdlKQ0KPiAgCXN0cnVjdCBzZ3hfZXBjX3NlY3Rpb24gKnNlY3Rp
b24gPSAmc2d4X2VwY19zZWN0aW9uc1twYWdlLT5zZWN0aW9uXTsNCj4gIAlzdHJ1Y3Qgc2d4X251
bWFfbm9kZSAqbm9kZSA9IHNlY3Rpb24tPm5vZGU7DQo+ICANCj4gKyNpZmRlZiBDT05GSUdfQ0dS
T1VQX1NHWF9FUEMNCj4gKwlpZiAocGFnZS0+c2d4X2NnKSB7DQo+ICsJCXNneF9jZ3JvdXBfdW5j
aGFyZ2UocGFnZS0+c2d4X2NnKTsNCj4gKwkJc2d4X3B1dF9jZyhwYWdlLT5zZ3hfY2cpOw0KPiAr
CQlwYWdlLT5zZ3hfY2cgPSBOVUxMOw0KPiArCX0NCj4gKyNlbmRpZg0KPiArDQoNClNpbWlsYXJs
eSwgaG93IGFib3V0IGFkZGluZyBhIHdyYXBwZXIgaW4gImVwY19jZ3JvdXAuaCINCg0Kc3RydWN0
IHNneF9jZ3JvdXAgKnNneF9lcGNfcGFnZV9nZXRfY2dyb3VwKHN0cnVjdCBzZ3hfZXBjX3BhZ2Ug
KnBhZ2UpDQp7DQojaWZkZWYgQ09ORklHX0NHUk9VUF9TR1hfRVBDDQoJcmV0dXJuIHBhZ2UtPnNn
eF9jZzsNCiNlbHNlDQoJcmV0dXJuIE5VTEw7DQojZW5kaWYNCn0NCg0KVGhlbiB0aGlzIGNhbiBi
ZToNCg0KCXNneF9jZyA9IHNneF9lcGNfcGFnZV9nZXRfY2dyb3VwKHBhZ2UpOw0KCXNneF9jZ3Jv
dXBfdW5jaGFyZ2Uoc2d4X2NnKTsNCglzZ3hfcHV0X2NnKHNneF9jZyk7DQoJc2d4X2VwY19wYWdl
X3NldF9jZ3JvdXAocGFnZSwgTlVMTCk7DQoNCj4gIAlzcGluX2xvY2soJm5vZGUtPmxvY2spOw0K
PiAgDQo+ICAJcGFnZS0+b3duZXIgPSBOVUxMOw0KPiBAQCAtNjQzLDYgKzY3OCwxMSBAQCBzdGF0
aWMgYm9vbCBfX2luaXQgc2d4X3NldHVwX2VwY19zZWN0aW9uKHU2NCBwaHlzX2FkZHIsIHU2NCBz
aXplLA0KPiAgCQlzZWN0aW9uLT5wYWdlc1tpXS5mbGFncyA9IDA7DQo+ICAJCXNlY3Rpb24tPnBh
Z2VzW2ldLm93bmVyID0gTlVMTDsNCj4gIAkJc2VjdGlvbi0+cGFnZXNbaV0ucG9pc29uID0gMDsN
Cj4gKw0KPiArI2lmZGVmIENPTkZJR19DR1JPVVBfU0dYX0VQQw0KPiArCQlzZWN0aW9uLT5wYWdl
c1tpXS5zZ3hfY2cgPSBOVUxMOw0KPiArI2VuZGlmDQoNCkNhbiB1c2UgdGhlIHdyYXBwZXIgdG9v
Lg0KDQpbLi4uXQ0KDQooQnR3LCBJJ2xsIGJlIGF3YXkgZm9yIGNvdXBsZSBvZiBkYXlzIGR1ZSB0
byBwdWJsaWMgaG9saWRheSBhbmQgd2lsbCByZXZpZXcgdGhlDQpyZXN0IHN0YXJ0aW5nIGZyb20g
bGF0ZSBuZXh0IHdlZWspLg0K

