Return-Path: <cgroups+bounces-1277-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC7B84282E
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7721C23A2D
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6FC823DE;
	Tue, 30 Jan 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zrod7M8M"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1798823C9;
	Tue, 30 Jan 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629193; cv=fail; b=sdXtTmPxKpfgykBUVOnvE6UQqu5g8yh9QmCxYJDXhvB6LR4KhuiwRsHcQCJ9DsMYvL9LcVihzQqiN8hcWG58NnsYOV6QGrL6TgC4IFSQjoiAptiQPxyXM33nkIm/uvZGfp6AY3HRIBiljjZlKV8tiVKmzStlZH27mU86CUh1xsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629193; c=relaxed/simple;
	bh=NPs2QqM5RTMZ0mjRvsuKBs6dINJ9oJ/uofPSV2JQOdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MU0ffhIeFV/m/oNLutZq3ic+jUjnWXTUhf9/7vjEIIJEh76T+Nomo0VnoqtbMpLs7FL2kFT+ji4UF0BhsOnx2ynivdArlhIvZ9XYB/+ZPMCwVLAmX452Ux5Qy31k2Q/UcomxjZ45430cjrV0LWmlzm9hiWGGL/3uLC5SI9EF+Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zrod7M8M; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706629191; x=1738165191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NPs2QqM5RTMZ0mjRvsuKBs6dINJ9oJ/uofPSV2JQOdQ=;
  b=Zrod7M8MlwsLd1FNGh0jifFitgYdRXQLHFjE5bGGzY5uxdSEeZmR0i9M
   SrQDTiYS4PterFjOyjh1XNvJhBoSmnqJD0ryL3T1/ul5JudFa8+fgHk33
   pFb4jgI2tbA6GaeBebebzPhubM7uU8UYLlW22M/WB6LjO0SslvglDcx5g
   j8lpFbdssi+eafzGyva0WmiXzZqW2fZAKNg0rnFcbteE/BhiMhJEMkth0
   7u3aXaP8shVvNb3Q6KBzFJ/47YN49oT+KUZiQ8gImLEIXkwEpAARAPD+A
   GobSGTZjlDRho1tLrCxF/RL/OSWnqy7iFsMpKUvLcuCW3/rtkonzUyFwM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10061849"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10061849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737808439"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="737808439"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:39:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:39:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:39:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:39:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSU0kp0cz8jyPHgH+OJN3v0xQwMZOUg9+ck3v+BKPq/axbNxFy3Jauy8Er79nb/5qpWWY9aI0BJlMYPc5ReKqs0BPTUmlNKJFYHzchbMkrrE3KQWgIRJu7VugUwfAbcGVMW3QHu2Z+DsnYW9Z2Ih8R2ANDxRR0YSoxoFe9TtlqnfHqTjbuD2mUj0H+dMJmpGu5W1EVknQPSZod2k29u6gjhR6lnTor5zsE/Oc3HBxL3ebi3MUvnsI9cWU4m6aSnDcUXMw7g7lnL3Ov0iD7RdA08xtY7K98VStRhK9zbGg03+LwJLjIrZxAiz+jylaVGbwL3ZL20GFTflTdGrLMHWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNDNgISRuEi6fOV7QmqfhVGQ3TksSnjdIEe1tR3La2Q=;
 b=YEz0EVDz2YJt/XmgPqEG2AWGRBD0Tg3YrjsqhnC/zIiFh3RahD14I1v/WYERJW2jasiBhL4YYQrUcnU6fKe4jWXjVqeJhwjIQRgTxMUe2IhzYzyvQYtylU0tkOS6R3/nYiJRwBuQK4G2o3WAAIFHjceXXDSENrjSgTtxvJO9kHrHeTDnhfYlFtDnVEgXJUInx4mZiyD95RPiu/mPsp55MJKvo5Rty//5LB2BaKZJRnjPt2BhVIVrScg73mq55HypJMbTV0nG3+OKxZi9tNkGIqgkhw90grI064DFpLeD4C8BUWDpnNOU1LOT1CdVq2Wqm/Sq/HC30CcBDEKDMnykHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:39:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:39:44 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tj@kernel.org" <tj@kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>
CC: "Li, Zhiquan1" <zhiquan1.li@intel.com>, "kristen@linux.intel.com"
	<kristen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhang,
 Bo" <zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>,
	"mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>, "chrisyan@microsoft.com"
	<chrisyan@microsoft.com>
Subject: RE: [PATCH v8 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
Thread-Topic: [PATCH v8 07/15] x86/sgx: Expose sgx_reclaim_pages() for cgroup
Thread-Index: AQHaUyGZchgotqjrFkClyK7aZR52grDyfC3w
Date: Tue, 30 Jan 2024 15:39:44 +0000
Message-ID: <BL1PR11MB5978A8E4B6E1DC4CC0159FD0F77D2@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-8-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-8-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB6217:EE_
x-ms-office365-filtering-correlation-id: 1c97b437-e5e2-40d8-d318-08dc21a9aee4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGmJc+wESmzp6b5o/3MYPgnqY87uarg3KjYjcx5jvOXDMDQ5ij2KDw6oXKhTffByngTQUgqGfijmi5PfK/6GlqIDgzAmBX8xrHcx8CQ7+StB3lsmtFsGmTmRIYtgEOcVLosJ5X9ET5RQjezk5KFwWM3Tz+aEVHY3Z9IizPW/6t8W0/SX+dgdWoxtRz+q5uftpd2frmAW2vJSR4ZuRsq962pCcAtGjGMqAz0d+qCb0vQtEUSyX8uv75vDQMTCSSYpKXxjIBC3ztu2KMJljERmWPK3u5sdA1ZzyUDyD4yvFJ/1aXdcWSqp48ITy7luXh32t+KyDngp8PHxQvvO7aD5nzVO1duamLF6KhSWxRnOL7jD6+DUxWBZP3f1y1377zMy+3zkDIp4RTu/gEZR18lHF3/XtSMfZlX4XiV5pv9ILizqpVSW92B+W7eYwxyIhE6p7A9gocUIK2p7hsHmJGjj6VasEWyKO6kYmI52mofnZgNkgYSNyj7ULIlF+uWBBbMTJ6PT5R9cqmiRkyTl3HhlawmEPebnbhFnucWLCBD6EIcAc8LHtEbiUnxHGdaYUPMjyVInXoVjTieZ7rcRCn46Ic1UPTaDW274+5mCFHfpNtfM/p5OKs7DqSU4yxoml720
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(7416002)(2906002)(33656002)(921011)(41300700001)(38070700009)(110136005)(6636002)(316002)(66946007)(64756008)(66556008)(66446008)(54906003)(66476007)(9686003)(76116006)(55016003)(26005)(7696005)(478600001)(82960400001)(4326008)(71200400001)(83380400001)(6506007)(8936002)(38100700002)(8676002)(52536014)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XFQ5FZkdzkWcraiuogfb0ZShkFhC9QTc+gzXwpf2MwRFUi0+qzh+W0a4ZMVi?=
 =?us-ascii?Q?5TEYOIZDDIxPom0WlgmeiBPr4CoI98Z1E0oq0oz6CT6VQkyZ1S9eR+SNb8/m?=
 =?us-ascii?Q?eBZFZq31Nsps11Zjrj9WXpyoHYM6rlR1P82OdjynelwvJkonjAJKSHNTnH8P?=
 =?us-ascii?Q?WY6wxLF/sSr/wHD2m10WpAW51tsYuJOPxJ9+GNSgTodAxgBnAcK6guH5sbp4?=
 =?us-ascii?Q?PpAFTmLe/kyaKzrlEWyMKMfU85CCZ2uqwYcE/OfwupPFBnQHYiqwUA2iRSdI?=
 =?us-ascii?Q?uQkxh3jzJ3j+hWUXbMN8uS+gC6sXN6USTOJ4guv8Zic7yFoZvBDYPdDz2t4I?=
 =?us-ascii?Q?F1nk0ee3baGIvkUQ2ChtMlPcIOr5bYeZFdbYmmHWFzQSelXiD1BwTF+fZor1?=
 =?us-ascii?Q?WKY3LnoiyXjO/alQUOmNDlITSe76ijJAgLAi+DAK0Bz0IPux2ZTm9pkQ3SDK?=
 =?us-ascii?Q?VqT3VTSfDwH1dzdiCCdowhx8uPl/wTMy4fOaqmCk7iZdnsB8UBFQEz+InOAM?=
 =?us-ascii?Q?aMLAocINqv7qJQ7nmhHhKiyuq0vKU5Bwd59QcSNQPpHQBAC5JAIMYvS2bTtt?=
 =?us-ascii?Q?el/ij5I7X3doQtjYBRdbP2irvea1FV+GH79ppb7wSh3Mk/6w0tLThWcROyMk?=
 =?us-ascii?Q?kzmBZjCvKtZ+9EaN9orIm3TGayNjjxiSGEhyXfwA/xNSVoHmIiRDHpMFe2Zh?=
 =?us-ascii?Q?HCMO/QgNTjhTgoN9vqeIGDCDBL8TkJAFv4770g45PgiOTPMhWCt7a90Txw4G?=
 =?us-ascii?Q?GWy9PIX86lE2ypXq55HrZct5jNOsUEKJq7+ZOa0U04pwQxs+Lll+nO92cUoL?=
 =?us-ascii?Q?zwd2lM0vg+4KrCsPxp/gbn9tj3ju+SIMCmwtUOnY0mV/MIl2hCGuw08AwR5P?=
 =?us-ascii?Q?eHFG7ltXOxmrJn1UWwh4urLAMbhTOcc5SbGq+PN4OuhI+H1/CIQQ8D6XjPeQ?=
 =?us-ascii?Q?giaRVz1EMfxkz2PSBbRUylhXLn+BuTPI22p/0sFhNV8Hrk3In+p+C7151E61?=
 =?us-ascii?Q?aQE2auPJCreL8R6E17Eko0cZsKXlvudbUdZR0jM22smj9d0Q2jZV/BuLuWZI?=
 =?us-ascii?Q?6L+NyisAnPWIkH5AQ2AX0UrDhwn5kL66xYfwPaA6x25dp1VCrB0yHwEsDSeI?=
 =?us-ascii?Q?pdlKPjy/yg1Z18Hk7W+O16CIWlraQCv3XZjz2rFh104C6jXK10O6pLjmWP0U?=
 =?us-ascii?Q?7/MJB3wusBcohL1UqUynSBdspUrVTs6QJtWDiuTGsOWlkjqnyyR7p9KNZZ8Q?=
 =?us-ascii?Q?edvav7BShUXpQv+yVOKrPZkJcfjQ/Zs4pNun2nL36AMlWUxM26MJ41HiaQJ/?=
 =?us-ascii?Q?Ty02qZUyom+VQjuqfCEQtqiCGyuPXU0WXu6ErihYA507KJ/DhBHem1WQE9Un?=
 =?us-ascii?Q?bDwK1HQqqjEd3Vi5Jl8+pwJKJ5wlOi6eCG8p6nJTe8DraUZc5xKRgSeRIdJb?=
 =?us-ascii?Q?+mDauaivjc2b751uroyGDBvngut3ZoEnmErf8l3i+EUTm8ovCAmGkrNZEwjz?=
 =?us-ascii?Q?s6MDp2o9gQA3kUKzuBVeI25MHB1x9ZnDzVmGn9f4eH8xLkMCQkK0xs1sjYB+?=
 =?us-ascii?Q?g6lfKpOBrG+eJmNRfgxBhZCQ7gjSnhyiuJpbLLoH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c97b437-e5e2-40d8-d318-08dc21a9aee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:39:44.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OS/a/19e3YURkg8+p33fPgExm52nWR+4eeF6VS0plm5kwwp5enNz/fP21bsLP70myh4fGx5nPKTKxrKH8VgAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com

> + * @lru:	The LRU from which pages are reclaimed.
> + * @nr_to_scan: Pointer to the target number of pages to scan, must be l=
ess
> than
> + *		SGX_NR_TO_SCAN.
> + * Return:	Number of pages reclaimed.
>   */
> -static void sgx_reclaim_pages(void)
> +unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned
> +int *nr_to_scan)

Since the function is now returning the number of reclaimed pages, why do y=
ou need to make the @nr_to_scan as pointer?

Cannot the caller just adjust @nr_to_scan when calling this function based =
on how many pages have reclaimed?

I am not even sure whether you need @nr_to_scan at all because as we discus=
sed I think it's just extremely rare you need to pass "< SGX_NR_TO_SCAN" to=
 this function.

Even if you need, you can always choose to try to reclaim SGX_NR_TO_SCAN pa=
ges.

[...]

>=20
> +static void sgx_reclaim_pages_global(void) {
> +	unsigned int nr_to_scan =3D SGX_NR_TO_SCAN;
> +
> +	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan); }
> +

I think this function doesn't look sane at all when you have @nr_to_scan be=
ing a pointer?

I am also not sure whether this function is needed -- if we don't add @nr_t=
o_scan to sgx_reclaim_pages(), then this function is basically:

	sgx_reclaim_pages(&sgx_global_lru);=20

