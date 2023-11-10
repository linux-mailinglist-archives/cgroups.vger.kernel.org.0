Return-Path: <cgroups+bounces-302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F17E7622
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 01:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2820C2815B9
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABB80A;
	Fri, 10 Nov 2023 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T63LNHe+"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6BA47
	for <cgroups@vger.kernel.org>; Fri, 10 Nov 2023 00:57:19 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED53A8E;
	Thu,  9 Nov 2023 16:57:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1JejH0npmEfWZfR9FFXr8+d430VNg9bUsrVUNnSDmmqPC+oYWFWGMBSrQ81LIxjybOiJpEzRX4F74PeaFwx5U9qCrRwaetiXZ823QA+mXXibZcVGHjBqy+gi1LI2uNV7hWZrqIEQdHHgvz7iFaUakFyElOEUvJl4nkPn449mm1/MR1hLKRqdZQBdPuZicheU8LIWarZJIHdsH3uhTEZVb91CERWyXjJtIBY7/8Kr/Z/XoQJ8u1sCty2qNho3LBDiNKzwFy/0Oovfsn4EWX/5sySjCnNSGcomwUDI638+wBDHSkeWJY20twIWX7fbv8hIKLY6fIrIRDwgBF+BwhqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg/iDTOKJC636qXOyC1HkO3nRVZKhm5VcRobHmj536I=;
 b=mKeWhpue9X9A8wLo2dLVAwHs5K2msBHoNRfJcAhTcvsw0Vv3LOFW3JtHkbwolepL9jVQyfAeQvz3kCeSWYK37Xc5FQFeh8WFzQ/d8SSM4nEiCCIHJmRcRgPj65bHFYU90agJADg45hxB290uYiCO2sjqYUYR8fzCIxvBWzqvMHUJL/LS81a8PF2VGJidafXx7hmFXBvfNmItmHiiJUUM+lK0jWfqHU8405IWT4SeMtnuW+Y1zG1qM9n/vaatBeqpTH8RMqLGyXyKWDcx9Gs2Ll/lTM3YjXAzOF81InBZ45/MT1wsHqUPdJP19za4AO1qb48EGLHx8gmS4/1K76QSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg/iDTOKJC636qXOyC1HkO3nRVZKhm5VcRobHmj536I=;
 b=T63LNHe+fwjX/V6Gj+a/9pE1ikdAGBIgjGGIex26J1CaEoZc6YmDRSI6yObjCCklBMwuS6sdlMcQKVvsACtXMu4p2lyRavli5GGJixK9/65WKbeWvefkTlT7xhtf2ltnxNuWX/vmBJgYOQXH52RehHnkJ8sesa0WNbjX4KLd92A=
Received: from BL1PR21MB3282.namprd21.prod.outlook.com (2603:10b6:208:39a::6)
 by MW4PR21MB2028.namprd21.prod.outlook.com (2603:10b6:303:11f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.9; Fri, 10 Nov
 2023 00:57:15 +0000
Received: from BL1PR21MB3282.namprd21.prod.outlook.com
 ([fe80::29f5:2587:1af6:9dcb]) by BL1PR21MB3282.namprd21.prod.outlook.com
 ([fe80::29f5:2587:1af6:9dcb%6]) with mapi id 15.20.7002.008; Fri, 10 Nov 2023
 00:57:15 +0000
From: "Chris Yan (HE/HIM)" <chrisyan@microsoft.com>
To: "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>
CC: Anand Krishnamoorthi <anakrish@microsoft.com>, "bp@alien8.de"
	<bp@alien8.de>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "sohil.mehta@intel.com"
	<sohil.mehta@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "x86@kernel.org" <x86@kernel.org>, Jie Yang
	<yangjie@microsoft.com>, "Bo Zhang (ACC)" <zhanb@microsoft.com>,
	"zhiquan1.li@intel.com" <zhiquan1.li@intel.com>
Subject: RE: [PATCH] x86/sgx: Charge proper mem_cgroup for usage due to EPC
 reclamation by cgroups
Thread-Topic: [PATCH] x86/sgx: Charge proper mem_cgroup for usage due to EPC
 reclamation by cgroups
Thread-Index: AQHaE2wIHe1/xq8IH0SHFN+e0irTS7BytwNQgAACjzA=
Date: Fri, 10 Nov 2023 00:56:49 +0000
Deferred-Delivery: Fri, 10 Nov 2023 00:56:10 +0000
Message-ID:
 <BL1PR21MB32823912250A3EFDDDE90AD0D4AEA@BL1PR21MB3282.namprd21.prod.outlook.com>
References:
 <BL1PR21MB328244B74A622ECA3C040131D4AEA@BL1PR21MB3282.namprd21.prod.outlook.com>
 <BL1PR21MB328226E1D25E3BA189143BA5D4AEA@BL1PR21MB3282.namprd21.prod.outlook.com>
In-Reply-To:
 <BL1PR21MB328226E1D25E3BA189143BA5D4AEA@BL1PR21MB3282.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-10T00:22:48.2039589Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3282:EE_|MW4PR21MB2028:EE_
x-ms-office365-filtering-correlation-id: 55f80094-965c-4908-ded4-08dbe187fb26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FcD6qmD6Yyi0LQa77Os7Y+p5ZsiHMXfuXzGBtNwS0E6YyEsDLmm3cGhn5jKb5IbLlk0AbhsSRbFeQM+dIHiuA/N+BLu/0E9AbTo9ewt7W+qkAekZm6a5UIO0JZ+mA3fBwi80ifsxbpk92VZljjSauXDQAhFbbHOjPNGjTB/OrVrFw+pScChogcwZSxDr2ZIjcGle4pnbUvV6+hgKgfQQBWaPHe/nqCSWP8yTUIX8m4q9J+XA/8aHInLnT83nOq4Cbchg83+EQXGlg+6PGJjEWVmFSIwxTD4Kz9X2VsvFvSEM7/jQ26f1ybuySRyvHIjVflqGY8yttrklF/yH9dO/2D5iH2Qxc3IO7MMRA5sKkyocpVQUPolUvSenpGunYXRCvCarQQEjxkj3oHNyw7cyBo4LHeB695WAXa1QpTez8hvwB2g5iRp00vUKzywfRXrDrpG5KJRmSrjJx8bBiQC8AD42GFUqI/E7UyysO91A3bPM1q9jn1fs17Tz8fLdtNqvo5pQWQBHdP3kvS0Lfc8q/+S6+GgPubaPHAE4vElBYmRuJPKH+cYsuTZ0iaENGJymZC02jAYW0BfbtE5c5w1jbqgLrHECH1PlbMoYM8zbtXicwWsDMGLa+D4OuO/KJ11dPSdoekO63kM7ImWSKawXuJSiXp4GM0webQUu3j/Guow=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3282.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(6666004)(2940100002)(9686003)(7696005)(6506007)(478600001)(10290500003)(71200400001)(38100700002)(33656002)(122000001)(82960400001)(558084003)(86362001)(82950400001)(7416002)(41300700001)(66556008)(19618925003)(66446008)(54906003)(8990500004)(66476007)(64756008)(2906002)(4270600006)(66946007)(5660300002)(38070700009)(76116006)(52536014)(8676002)(8936002)(4326008)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jDtKfapGSEvlrIYRPxJ0W9zBeBGaW5rsXT0t4jHQL8s7Z/t5J2yLIEL3rLAv?=
 =?us-ascii?Q?TQDpVRXuInAD4L3IHKV0NrvQF+dYl4nQ4r4BPppmSfGiRlwvBY3JhlbC2IQx?=
 =?us-ascii?Q?m7mXD8m3i/LWmznvHZc9kRg3M0WQHDWIRIlh1P2z9QzChzwcDgZX2PD0/gSx?=
 =?us-ascii?Q?pbAqaqOg8gw3sFK3rTl8OmW3GjHvh4SWqI69yBPlrRkGfLtd8f6FstvJz92f?=
 =?us-ascii?Q?+wjNXNBCd8g6d71K3uNDWW5wPXjHWXV4o2ekt/9l4G3kswtjPRnuomVPuPUG?=
 =?us-ascii?Q?fujtkOvZTapW/ZF0/LbKkLdf88O6ipNIfLO2MvqDkWHRmI/gAcHkfkeNtT/e?=
 =?us-ascii?Q?3y5H6bIzVMogPd3Djr0tf14ktZqECsBeELIw5xdb3TMx0k0Tz9xYVU1ijq9K?=
 =?us-ascii?Q?OoqwRtQI5rXSbaYgvdjYqFWcbtglESD8HwSHCg/Qf0aXNcDlhjdDNgrRTlb4?=
 =?us-ascii?Q?RjL7KqnnqP9HqiaGZ6T3vocTB/3WtdBGAZID7gyVd+PwgEDt2Dnd6Sr2nFPb?=
 =?us-ascii?Q?L4p5vShinMjCYmPYS+Vw8o07xcV+YgkyUT7xNVhYUo/y/QS9/mxYCnmSi2RU?=
 =?us-ascii?Q?S5OtYykJC1cuqg/OFcI2xYqnPnZkYLe4TiRrU0byrer1H0Q/fV6wJtknss7o?=
 =?us-ascii?Q?0RS0POlGNwm4fo3sxeEfmmChw3ybexZAXIbYWRgRTouuIh2okre67mkRq848?=
 =?us-ascii?Q?eEh193BufiawT5I/uBxHbPpLQFiCcdsY5Kf0oCAAubUuUCbweFpgLZ/tK+FS?=
 =?us-ascii?Q?GF9eqsSAE/sJhyxxUlOfxXnbB2NlLaeg+RNhmVgJOH4JEVxyQx/PpJgJJ2lV?=
 =?us-ascii?Q?qS+jgRruw8j1AQDSYGSTVihl4A5JWFyqgy4jlN5+JdrW5FpmaVsKx8EgBMAd?=
 =?us-ascii?Q?V8ckcRb+lVGUL/SiPzivu92NpUp8mZJEtLlfwYl/tWG4+r+z9Ofy+aDgv6sK?=
 =?us-ascii?Q?5PaojPXEDBlKPQD6aOhETiLnUyxPbLa0BQbs88AFVCEPfa9lXA14s7siGsHG?=
 =?us-ascii?Q?BOtWvcq59QMjMBQGxplZmxxVtHq8czoO+IeiX1vlFijONAd0b6elxIE88BKK?=
 =?us-ascii?Q?EmwrpKD9FhtmjF4Xm64lspst0Za/jWGgmJzODj+cPjMzxWD1d9hV4ZQg3eso?=
 =?us-ascii?Q?8oxNG3tp1vuRh7SB4rAguupv+fIDFST1h5kPs59u8SAbaw/7zZU5sftHPS+R?=
 =?us-ascii?Q?y9kIFUDLYB2vQvJrOue4OEjmiDZI9YlOy6BCShhrFIUOQoDLUbHK2jUuCNZ2?=
 =?us-ascii?Q?3jomfWm4XhrpUzKLY9XKSrJ5HmKChEGTyH0R9V9BlSoXchTUkbMMgzz1PCac?=
 =?us-ascii?Q?r39YLYO7dT6nrcrv0YO8WMtB2LA5bDt0v81A1mOxG3/QGIDr6kIY/qd5kNN1?=
 =?us-ascii?Q?+xj/oaHTu69YgBzExuwLimHYZG3Bsplogjc5aul383YsXSu79i5sxzIjLdZb?=
 =?us-ascii?Q?8GY4p8Z/iRBklgC6vT9VwnuFVPc4jy8+BxCMWwF2Z/NIN8FG6OodaAIJjk1m?=
 =?us-ascii?Q?5xRAKGO+rU/K9mipCDA5dL4c5RpvhKWcVIqWa4/0Ufq3vmSOWnXjCNYS4JGi?=
 =?us-ascii?Q?vwOOXultqwm+Y6Efh9ugScwTgdj+k5CpklZaxGN6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3282.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f80094-965c-4908-ded4-08dbe187fb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 00:57:15.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +asr/9gRNnOhg0/9nkY73lOlpo5nFlt/spST3Lb+4W7m+ghiYJqsj06exSGxpSh2/3U0I5CpISDN3NxKQ+NdSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2028

Tested by: Chris Yan <chrisyan@microsoft.com>


