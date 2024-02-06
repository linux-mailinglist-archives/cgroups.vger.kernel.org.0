Return-Path: <cgroups+bounces-1374-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB784ABC2
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 02:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5A2855F1
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C61391;
	Tue,  6 Feb 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="MKNEgE+5"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A61138A;
	Tue,  6 Feb 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184061; cv=fail; b=KxosjBnRHcgAVD2ZX8+ESPZCxj98BffOXAJjlorlGbgVZ9aa+PoTq+sKysLAF/Jk0cLq4EO4FSXj1vXMsWUBG/iKdT/QW+yR2IwPF2483afBRs467JiMLIWRz3ZjuiCCwIZ/mje4XzwDvK7XP8XcEXQkRpFx/ZISZzroMDxq1eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184061; c=relaxed/simple;
	bh=qJ9dhGxBtAd+2rXQoyLV7a0ofnnQnnDMMcs53JTsCew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DEKIYBGOTfc9Y/dStqiPaQLeNMtmEBAzpZYxpfOVmdvl99ZE8LaD/6z+Mdlsy5GFj6yjjmeJzkC8dMssVfLB8xAaHUJd8dE+ks6pMqWa65+NYvg9SCdreesNzlQNj/zeCfLqQtVwwMLuPbsrWCv+ACYza74ypfMUuDmoQ2fOg1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=MKNEgE+5; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415BdTwa003214;
	Mon, 5 Feb 2024 17:46:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=RpXQAz3xy8DswYUm1f5zwPK/N+RI2qKKfukPMjwp9dQ=; b=
	MKNEgE+5nWRmJRBc/rtMzNRyuPRm7exiiPJQrYRKtM7MF8Qm9aHySwED+EKCOKm6
	deNAZAEd2hwDdZCfbGq3f6MAd0q+Oc5bdqqcmIamzO4Z7A2j/eCVBrzMFDhBYzOu
	dBULZcJnr0Ki50Htt6yH/oi7YwEcAYjkLLkdZbl7QvidiQQAB81UdCR+/ePSen/L
	YiiO3iFt4OXHDfL0ddJ7/4FuuIJQGbRxzqlIaK+Oxyw7L5KOevOWZ4AvJrrKbQ3p
	8CJDKCzNpoKN+PqKRB9WLGgjPuAU47TKYLTYrGYcWg8o6MbV3DHOUpZ0ubW8Rk3c
	O8UGr8hrg6uAr65UhoegtA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w1nvm25b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 17:46:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no8knd0tCxZzpvyKGVEtpUiAk6rVSUyo/VUzMr93ACmX5b8HTvga0gOtTGwZcH2aV7zEuIs/e6v0dbn0qmEZvCYi+bqmNsqaFXzly2aALi+yCEpcUa2m7bRvpwrwgFeaaOCs8gp/Mv8AUC++KCTVbaZ68ypdAjz3jdrY4TL8bj5U8Cwt8w+Xy8D8LJoYP/ZC8hTN9JHmZUKrwWXyQAdmWR3UgdbVhBOWFN6QLgLDNcT4qF/H9U1Xr+W2KCW4e8CfevgK2bG0WhJIRNOl374NKrmlPmCjkWyTC19/aRgWW8zEM/BKh9J3Rl2tLziSXAOmwO1qvbGURzts/BlnrTEtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpXQAz3xy8DswYUm1f5zwPK/N+RI2qKKfukPMjwp9dQ=;
 b=Jfa8h77B60DrQBhKMqw90bxsHZvQ8mcNn/ykmkm4qVYsVt3BNuCigLFJZB1d6+EGvs6gsYnMCz39pR57u62OgYuLo6+OLqAFOKf8ilo/3utN+UZYm2336O0Q7IihjmfLO5asw2UCzAO6BBS0JHw5v43h8deoAw4hoHzPH8aQXNWg1C+ejgFRT+j19z3wTeVHoh1pwRt/CbGHcLYV6vKrp6XNRSUCaSAVozYIYxxg/S9YZPt48X4bOol0Frm3UfcFz6hftKC1fyvzaCAlnoTEMgubibijqHmD6ugW2BrGzSSaBvov2yagC13D4dFn+NKkFuS+g2A7BcTCOKqnTU5rwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 01:46:42 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 01:46:42 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: "Christoph Lameter (Ampere)" <cl@linux.com>,
        Waiman Long
	<longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka
	<vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
        Steven Rostedt
	<rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Chengming Zhou
	<zhouchengming@bytedance.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Thread-Topic: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Thread-Index: 
 AQHaVJOwDQcymv+I4UO4s807/1z5zrD0f7qAgAAEDwCAAIJ+gIAEbPWAgAKbKICAAIK+IA==
Date: Tue, 6 Feb 2024 01:46:42 +0000
Message-ID: 
 <PH0PR11MB5192FC6A7AA3CB84BA3BC7E6EC462@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240131172027.10f64405@gandalf.local.home>
 <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
 <61af19ca-5f9a-40da-a04d-b04ed27b8754@suse.cz>
 <698633db-b066-4f75-b201-7b785819277b@linux.dev>
 <PH0PR11MB519280092AA66FAE6BB3FACEEC402@PH0PR11MB5192.namprd11.prod.outlook.com>
 <fb8161d9-16c0-da8c-09ee-905e39ae199b@linux.com>
In-Reply-To: <fb8161d9-16c0-da8c-09ee-905e39ae199b@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|MW3PR11MB4732:EE_
x-ms-office365-filtering-correlation-id: 001f221a-50b0-4fa4-f40d-08dc26b577d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aieTClzy6EOijeo2cBH/ZY65JR5LnNHGfEygDEIyT6uL2GCakgMSCfukF11MAKm//29vwJc3zX/51+LyCRQbDNXiCj+S+PAgSjRNmFa01pOncn9c7dYvlb5B8+L7EZTEtxAMr9LWPR1qLlJ0k4RlzVjYhVfywVNPy3NEIqq5OjeDNnqX3k+k4z6OPytQ9Zwq4J6Wudbatf6zSY2cPnFq5Tf7uw4SoVd+7tEHDAdZ1y8Kfa5P9Qux83HHK4aiamA6xo245R/5aHwDC1Y0XEWIaKJaFjsRDPB/BNMcY2wk5EYME5iLbbPW77hvIeZ0nj4DL2BoyctBfiz7bjbaZ8S4Eq87diBtHj906yymCyvmtPL8T/X4EW24wjhujV3k4040SkV5TWFnu0K2tjHg53xPcz+WYp0vS4A8TD8VeBmYra4ChmoxsEgo4aKuM1YxVp5KST2dZDFFQfNr6UE4+2Bp2e3TDaHJic7M9OjqFSd9e+Eez92F98K1zmtH8U91n763kkZsp0GupAvwfJwbUGg6pFqfMarCrXvYiq3B/WMpYMupsQ+PaoiQbZQmC5vDsbRH1CwvmQpDsvN5pXD4+0abbiqQM42xHMAUZMGhUITw+gavk5gxsw1OD3cTgtRCY/Nq
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39850400004)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(86362001)(33656002)(26005)(71200400001)(6506007)(7416002)(2906002)(7696005)(9686003)(4744005)(41300700001)(38070700009)(66556008)(316002)(66946007)(76116006)(54906003)(64756008)(66476007)(4326008)(52536014)(66446008)(110136005)(38100700002)(478600001)(122000001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zB84SI7Ltu5kWgO8krj2uDw4w3ag3PJAb5s01tj3/fUEhePXe/gdu7o8Tcvu?=
 =?us-ascii?Q?6Ht9d0yXCYuYUxx0R2hCrS2zqtadBdjWa65ctgQEK6NbAQKTMPfnJ3d6jq61?=
 =?us-ascii?Q?Hx9/hA1KBTZS20g46jayeCeuW+wo3ytHuy2iEBrAUXkOVzAvLQablJ4th+6Y?=
 =?us-ascii?Q?5znVvTN9Dw8f0GVyblPsjc3ZmHpWPwjSSRAZWUSDSblB2H5kfMB960EUjGW8?=
 =?us-ascii?Q?TBXKSRqf4i30qOFCMjzDMRByGAW9GrXylKUTJAdQEzBVB00jBwd7+oPHN5YR?=
 =?us-ascii?Q?H3glqf51nOfCDnZtgYo1Ym5kjBPUR4dzOfbCvyk5oSXZORSwbPREG1Zk215e?=
 =?us-ascii?Q?4DF6VmfVoBIhQCQZiVoTT7ApcXfKtKY3Y1hfTV3RWyhXKRbs6qcHxjLeNZHY?=
 =?us-ascii?Q?mB19ElgmaKvOPzmt58Bw7q/ANS8/5ozjUzN0xWV7LVnyautwUssYvu/Y9wlG?=
 =?us-ascii?Q?8KcP0SwRhdDOkitO5EazSCqxd6P8SlwEwukQdikcHmJquP5XKyvG8rdU75Ol?=
 =?us-ascii?Q?85hfEPAsL4afyma8qsEbSsC0E4rOce9FiY2sYIMnXn825oTee94SoxAquNvD?=
 =?us-ascii?Q?XLcF26l+8H7zhQP6UpcGDjDmtDNpslDXST61WANVlbhjd4iTnyn7HAFqRGBn?=
 =?us-ascii?Q?XACRRDmM8mVsPrkNW+bVOGX3o15Na1BKd5gWXQKGEEf5/nTRPZ1akgowUecj?=
 =?us-ascii?Q?1IGKSifCgDW+5rnSJKHENRGh4VwYACM3TX687Os5urelHxKK8y/tfiYhPr/A?=
 =?us-ascii?Q?CyTlnibAvMFdfFX2uRJuqh/L6JRA0dM6FNdlVkZ2yuUB9YRXWB16W6meUkXR?=
 =?us-ascii?Q?arIyoxOYOgStUz4zviOetf7RSw5cBSOT4I/vUpMDs9uhxtZg9z+kensWeTLC?=
 =?us-ascii?Q?mNT2/DrWGMj4t5PNBEhEV0o887Y4RbzEk+c6fnFQanhzZwRGn1BaaXOzNJYQ?=
 =?us-ascii?Q?mG6rzsZ5mf6QBOpQAO1KVPsaWRTgJ1NJuPaKgrYc6pPnDbJFGu9nANtlbaGf?=
 =?us-ascii?Q?TwJsTc1PJuLsV0uO4EUlSXY55JL1G/R02wr1MZgBVK13282MpRJlBbGVhvww?=
 =?us-ascii?Q?QpSYbuwirVkVSZfzRuCnAgmEpxc5Cr5/pmmgPxmrSJapiwJvFv3ukU9W66OA?=
 =?us-ascii?Q?TfCq2mlwCDbq/G8NW6ahqHBSZxNWCDw+gnMX0O/qctjKAu9UHfaljSEqJU0D?=
 =?us-ascii?Q?VSKz4gOCvAk8lKRbIg1JUK/tgcjmOwTk4FSrdHxHneihpR8htjKAs+ts91Z4?=
 =?us-ascii?Q?EpnFFX7GeUDEFAklD3lH+8bMdoa0TgmbEb6ZMMa4PgcMyWFBX8xGQY71xngN?=
 =?us-ascii?Q?hT8pki35fx9L3CsxyCQ+yar1vyStioyr2djXXlhnUhtaQWQ6Li34VD4nyBgK?=
 =?us-ascii?Q?8CoH+gzg/v3vEflLPcjEbWEnkW+qNnp/fRnhGMyvpoIN5INuoo4rPdDDSAtM?=
 =?us-ascii?Q?orP/bLYIIlr+TmDDNSWbIaEraR1naOze2R6z9rccyzAcfHvQQqBKTa9KfIMJ?=
 =?us-ascii?Q?C3TOMrfAzEl2sqOJhbGmXhh57kjbuG7ssjrowWM5QwChhl/i8XJhZsuZ3HOG?=
 =?us-ascii?Q?uea2dSm6nB0T8lk+6fkUdEIfw+pLUX0jLywTm0U9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001f221a-50b0-4fa4-f40d-08dc26b577d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 01:46:42.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAvAVl/2ynTFvHTZEfEserBpsbLobyyL7SJ+9D15teAP+UArLUJsFYAMsEMhovSQlBPQG5v1LfY1hITYvU4s8jlsrDdjqq5kM+PxpYLaFE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-Proofpoint-GUID: W46dF52pcogYQ_TE34G8H6Msb-AXaNEW
X-Proofpoint-ORIG-GUID: W46dF52pcogYQ_TE34G8H6Msb-AXaNEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=501 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060011

Adding the maintainers of cpuset of cgroup.

>=20
> On Sun, 4 Feb 2024, Song, Xiongwei wrote:
>=20
> > Once SLAB_MEM_SPREAD is removed, IMO, cpuset.memory_spread_slab is usel=
ess.
>=20
> SLAB_MEM_SPREAD does not do anything anymore. SLUB relies on the
> "spreading" via the page allocator memory policies instead of doing its
> own like SLAB used to do.
>=20
> What does FILE_SPREAD_SLAB do? Dont see anything there either.

The FILE_SPREAD_SLAB flag is used by cpuset.memory_spread_slab with read/wr=
ite operations:

In kernel/cgroup/cpuset.c,=20
static struct cftype legacy_files[] =3D {
... snip ...
        {
                .name =3D "memory_spread_slab",
                .read_u64 =3D cpuset_read_u64,
                .write_u64 =3D cpuset_write_u64,
                .private =3D FILE_SPREAD_SLAB,
        },
... snip ...
};

Regards,
Xiongwei

