Return-Path: <cgroups+bounces-1236-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06883DC21
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 15:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BC11C2108A
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A56B1B59A;
	Fri, 26 Jan 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCdJ5n/c"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5071C2A8;
	Fri, 26 Jan 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279853; cv=fail; b=Qs8+uJs9KRc2nb07F2EhXhNteKfwyunfRBIg5WW51pOCw1ACnGaP6ft4eBa5PBNeFz5v9rGJ9txTSzbQZH+kkFKUDH+7w7HvUCHnGYPpzVHFcEGbuAUKGCfk6YSCY3SeXC2+14f9z/FdSmVX14s2nj0lSCDzt+MpBgLM+eMWCtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279853; c=relaxed/simple;
	bh=WjF81k3Oh978v/qC4C8FwMUitDQe2YSsm6OT3/LbTlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NXELa4Kja0egXVxGmVA5xzrEBss92Qy+9fgzZUpceHdNCJuO3zRKkP4BwxPWWSdPn25H5ghlVt4Cxz8geUn1nztZKbCu2ktZKSIaw+MxI2ne+gQ2/YoDgVMP68ZflfQAGyu1pY4JdYN5Ya17UubD6cnfTymwcUmeTmM7cdpgaPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCdJ5n/c; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706279851; x=1737815851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WjF81k3Oh978v/qC4C8FwMUitDQe2YSsm6OT3/LbTlw=;
  b=CCdJ5n/cA/woHB0uvFr7k/GZsmGGbJskedMoMDUMeTF+ZjIuBJ0bNDGR
   q3ZTqDmEvKwfATefojFS62FqMAsD+6ielNM+nI3bToI2rRhhWNeA5JSg+
   BgSK4ms/N0L0+V05VIzIJAwDGzcM0R8yeR6i+eetqJNT/hcoDljmvwJI9
   1Wt6QH91Vt0dEvcmIZ1GZESsbSqDuw9mz0JAHHTmdtcUCFddZKtdI+w55
   2vnFo8XSglBvn9njJgLKVekNHEEkLmc6i82B3uwd0ZWoBiCWwScgj4Hk5
   A/Hqv6AVBewkaNO5uvIyUTpf5Q1jq3M/M11vnQr4qRJQq0mc4Ggk7xCHL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="433635713"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433635713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 06:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28837976"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 06:37:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:37:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 06:37:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 06:37:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0lbh+mWG61Mz3jYGxVw7/qBo8w6wdYdt/bVd86yDAGlDPNk0Jm3gJvFfeU/08jtVgJHBlYzVL+wwNieMjymrJJD2a8fwx7L37iAxXTCfO739w5YdCHzzOtl5q5lvFTdBzINqDi9TWC2rCoSgyWeToUd/MrSP1cfO0b+rWgrlr0X5LH1egxcJgxYCfpKiRR1C4ILQTYGLF9oZ9dAtnJUefSO8T1SdHjoVvOcc/wgCjN5L1ZO+cQyuGoKpxh9BKpJurtbr09jIkJAm1D+TGifqw9BnluH51CZUAfF0aRYDxSIbLB/ysUYw7CJ3FruNDphZM1hnqxry/32RLOi45h1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjF81k3Oh978v/qC4C8FwMUitDQe2YSsm6OT3/LbTlw=;
 b=nYWUP+pqm0KYUnQqeC/CbH2LUN93b0uTH7ZSQhjEFLCAbuXXQNWI4FTaxc0VsrghXFZXgdOR1K+y65FpeGY1ni7hHptJYQPXhmXlwagGyyXieRJeMKVngPC/DKq79MmAXXBr8Kq9WgUyVLbG2tx3TqFwrNSw1eSNOHv1axvfcYUkbPTdLyqwE+4lKa3g+fnRpPwbkWgr7YFWzJsDJKl8v7YsXq/+IS68Lq4lvGwVM1HtPKdbG4U4bPEFYzj7rhwo+W2CWC7SW6+noAdATuIAluXwFUmcwmViJ/aq225Z8CAWKxrnzTzgzyHSjGVKtctqTWJ/qQJQe67nMAb17ZYpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 14:37:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 14:37:26 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "kristen@linux.intel.com" <kristen@linux.intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
	<zhiquan1.li@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>, "Zhang, Bo"
	<zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v7 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
Thread-Topic: [PATCH v7 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
Thread-Index: AQHaTVwK9jw8rcjY3UmSyTqd/ltFGrDsL6CA
Date: Fri, 26 Jan 2024 14:37:25 +0000
Message-ID: <195eff7f2814b918a570b8c2c9e21288ac9df4b7.camel@intel.com>
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
	 <20240122172048.11953-10-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-10-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7395:EE_
x-ms-office365-filtering-correlation-id: d2eec5d1-9617-4402-f2c2-08dc1e7c50c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hvp6MfRt+gUHvuAWinA9JzN1Int+nfG2Uo/T1o+GmWLhl6HiGHtKl7jnraslXaoFCKfLPLzdgj3S/VeALiGSa5pxR3K6bnmifm9ihs/L7xRrfXnIgkJGYHZonUvMxP6nXjNXf33ofFhO9/x6c3Z3tfpkKBLZakWDJ5R5g1lQFqrvIjMZpXNHh62IJsyuoGTS/pbw5C9/rh51v5/JLxKVYu4KcZ1m2oGUs3zrj6/QMSfSxTYy+8h8o73BwnBcLNFcnRV2oTCK40TFitoTzaSVBdQR7/Ozn5lhe7xxA9AaLGIS0PziJQ/Kc5RBvAKPXqw2brJe4uaPjBfcAJ7mRFPnqK4Q44BvrD02DNZ20OAtG1GGL3F7euZFwrCcg56dQCBcP4ZzkcubjQvkSciFiNMn33oqN60WZIV+1mrFXOq6IEDpSYYB4cey1G7jPkw6C1+ECWRvocZtJ9JgTuaLWPfWXnNvEK9uYrtIe3dV9cbs66iyrrNWKZgdK7WBvuzsy4yRUU3Ve6Dn7UsfA/YSSs89raXn8gcqnKnGxGCxrs9JcXuMJB+ZARLyThphvPmeEUwJpFGLswLQzzZSUOdSuGB4AnZzNcO2RLkdveTrFrhng7u+PdMLCvx9XrDe0UwbKbLih74G4kfhQeFCZ7l+GjKhonL4a+vZYmx5uCR7nwBjvlu2xjcq6eKcv6BnwtYQABWx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(41300700001)(6506007)(26005)(4744005)(6512007)(38100700002)(2616005)(66556008)(4326008)(7416002)(8936002)(5660300002)(8676002)(66476007)(110136005)(64756008)(66446008)(2906002)(71200400001)(6486002)(478600001)(76116006)(122000001)(316002)(54906003)(66946007)(91956017)(921011)(38070700009)(82960400001)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmlqb2Z1U3dvV21XYXZMS2JBOUtBSEZmOWtWU3l1bTcxS3JyeFA5S2FQTEVF?=
 =?utf-8?B?a0p5bHRUdyswQks3MUd1U3lZRGwyUTdJZTYzcWVyMkF3SDBRMkx1VFBrWDIz?=
 =?utf-8?B?Q0hzMC91R0Rka1pud3BhZEQ3dWdpMDJDeWVRUC9BWVR0SzBoc0ZoRHdaRU9Y?=
 =?utf-8?B?aW1nRFhXdFFwaHcyT1ZMektXODUzNk9mUHJFTEYwQmNRdFZKSWhrVmJWWDV2?=
 =?utf-8?B?THExUWVpeWE3aEIxdEVQWG42U1dTejl4UXJDa3RtNnpPYWNFSzR5Y1JmV0xW?=
 =?utf-8?B?VDBnQkxqclR3a1g3U05PaVpuTWhXZDNyRGE1d0NTYTdQL1h1WVorQkU1N0dO?=
 =?utf-8?B?QU92R2FjNFN2dnJiMEFTNTljdzB4YjBmYjJqY045Y3F2eXBMUWFhQzNCMWZY?=
 =?utf-8?B?RUR5STd1VWxma0VoV0FkcDBldjN4S1JZdDQ4YUR4dGhicmVvbHJmT3pzVmZj?=
 =?utf-8?B?OGVoeFJCZEpHNlF2M2VVeDR0MmN3d3VpYjR5T2FOby9NTUdPN0dBTG1nRzFH?=
 =?utf-8?B?YlBGUUJkSzBoNlNuOHEyMmhjTTFSaDBOUzhyOEpyU0M5NW5uRTA1eExHbU9R?=
 =?utf-8?B?Y2JKb0gzMGR3VW55b04vbXJTTE5WdDByY2h1Q0k4dEtudlJrb1J3V3F5NVNs?=
 =?utf-8?B?cHVvN1NrUG42S3huT1RhSGt3QmI5Q1dqSDNoUnlJeGZ1TWpiWkFGbjZDUm5C?=
 =?utf-8?B?ajk5ZER1VUtTeUQ1MUhCMmRXRnhmR0FDRDhwOTBBQ2dBNGk1M2U0Mng2NlJq?=
 =?utf-8?B?TGtzWk1ydnRDaHBzS0EzK1g0Ui9YcVQvYW9sMjNMbkh3TXlNS1kvV2tNZVZ6?=
 =?utf-8?B?Z29FZlZHbjlkVjN4T0tkanIydkwzeU5JQ2NZS1RtZGREYnRGaUxUVEpnN3Jo?=
 =?utf-8?B?YXpqOVZtMXhaVDd4RitvZzgyTWE0clFsb0VVZ1ZJZHQzTEpPQjhBU1d2eVUw?=
 =?utf-8?B?aEVPM3JPQ1VKQmJZb0d1WW9ZdWNTM2xHdkExWXBuUlVkcmxiZmFpYjUxWS9u?=
 =?utf-8?B?MUZDMHZWcVFFZE1aRjl4cFFyS2IwclFpVU9wMXB5THlWeSt6bTFWTll4ZnFR?=
 =?utf-8?B?dzhKb29EVWZtSTNWOEl3cGtZdnpITWUyWjc3emJEL1NGWXpXNDRBSHhnT3pn?=
 =?utf-8?B?SnZXd200aGxxVzIxUkVQanZYVW93TTNxTGU4UHpJeVRWamVYSnhLbk5XcnNa?=
 =?utf-8?B?Qm5PWiszd2p6dUYyQjJ0VkhoQk5Zek94QTJkbnVVd093Z3plUERiZnc5S3ZM?=
 =?utf-8?B?OEJaRG5PWWhVMmhXZzFnT3N4bkNMNm5sdlMvQkV0ZWlta1R6TmQ0NENlOGRE?=
 =?utf-8?B?YURjV1g5cDgzQkxOSksyVkJFY2d6Uks1Wk1PVm5jblZST3lmWmF4Q2xFQTZI?=
 =?utf-8?B?WkpZUUZzblRMNzU5UVR5Yy9HcW1KQzByMGg1d0JPOVhTY0ZtSlN0NS9SZGhq?=
 =?utf-8?B?UlJMUjFPS2NmM3BkelZKTndnY1h2RkR2WDQyM2Qwblp5VjVqNkM0bUtLSlEv?=
 =?utf-8?B?RWU3UUZ1M3ZhWlVKYjJpd3p6cWdYVmpGZzZoK2VYbDFpbGdmcHBpS0pKVDdv?=
 =?utf-8?B?aVFTRTVGa2Y0TmlGUXJNM2VXYmJUMm90WFgvV1lscHFpU0g4MGdPVUNBVFlu?=
 =?utf-8?B?QUNxS29GZkJva29nS0FhZmx0S0l6OGt2RmxnYng1am05bWJON0xPeDJQOEpk?=
 =?utf-8?B?SWZ1bXIzb28wT24raVcwN0swM0JFQ2RqUzRDbWIwSG03eG9MZHZXVkZmMDdv?=
 =?utf-8?B?Y1VwcTJVdGx1bnd1L0dZSVZ6UmVkTHcrVWErZ2V2V1d0RStuUjk0cW5YeGFm?=
 =?utf-8?B?SWFhUjdRU0tESTM2enY1SWdNMHFzaldhMWl2Qlo5clcyWkNNcnNzOVZoaHBO?=
 =?utf-8?B?SU83K3ZtdEtXYjFzN2RmZGRxZUZIY2hXZVdxYTBGMnFuRGFHZUtyYmpweW5j?=
 =?utf-8?B?Yzh3blhieXBzWjJ0S0ZKYldXeEh3TE5nelRxdStNSE8yWFFlTy83WFNSS3Q4?=
 =?utf-8?B?YXhwdThhV1dDMGQ5N3VXamI4ckxVMmN5MGVMRktHRnBxNFh0SXB6UjJ0VVk2?=
 =?utf-8?B?NG1rcWNOd1hoMWFueWVlYUZxeEdBQ2NXL09pNDVqVEo0WmVGVlNkUU1PKzkr?=
 =?utf-8?B?bjFORE1sK3NybWRWKzh5WHJQeTRrYnhEdXpEUG9LM3JNVU0rMEowbHFXWlBS?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02D80D1ABC2CF74CB725D616FFE2E5E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eec5d1-9617-4402-f2c2-08dc1e7c50c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 14:37:25.9591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDsr1SSDEKS6yREO7aJ4vnJyht+WJ+7xfSYMZPmTKAhDJ4nxrwMGAOJ73m6lvpZ4R2yjbbGS4oY80aYejfe73g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com

DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0BsaW51eC5p
bnRlbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBNaWtrbyBZbGluZW4gPG1pa2tvLnlsaW5lbkBsaW51
eC5pbnRlbC5jb20+DQo+IC0tLQ0KDQpOb24tdGVjaG5pY2FsIHN0YWZmOg0KDQpJIGJlbGlldmUg
Y2hlY2twYXRjaCByZXF1aXJlcyB5b3UgdG8gaGF2ZSBhICJDbG9zZXMiIHRhZyBhZnRlciAiUmVw
b3J0ZWQtYnkiDQpvdGhlcndpc2UgaXQgY29tcGxhaW5zIHNvbWV0aGluZyBsaWtlIHRoaXM6DQoN
CiAgV0FSTklORzogUmVwb3J0ZWQtYnk6IHNob3VsZCBiZSBpbW1lZGlhdGVseSBmb2xsb3dlZCBi
eSBDbG9zZXM6IHdpdGggYSBVUkwNCiAgdG8gdGhlIHJlcG9ydA0KDQpOb3Qgc3VyZSBob3cgc3Ry
aWN0IHRoaXMgcnVsZSBpcywgYnV0IHNlZW1zIHlvdSBmb3Jnb3QgdG8gcnVuIGNoZWNrcGF0Y2gg
c28ganVzdA0KYSByZW1pbmRlci4NCg==

