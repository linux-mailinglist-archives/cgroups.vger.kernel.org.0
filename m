Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93518679E0D
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 16:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjAXP4s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 10:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjAXP4r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 10:56:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBEE4A1EE;
        Tue, 24 Jan 2023 07:56:45 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OE3sOE006372;
        Tue, 24 Jan 2023 15:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=N5IP4z0z/5Vfarfc/5X+XSUUoGuChSya1w3mM115v1M=;
 b=dBw+mrQIcMZB7MX+EPMllATo24wScriJg6zEiKVSrgGmRyYnx02QlXa24VbbfWKZ9naA
 YE3WkBXWU9GjoMmYRnBkTabMfS95ITMrgGGCGPoaFXAMoZ5Ry7oRSGj6Mr7ZyBdkqY+E
 ynuUdpJavNneQlAQQtGe6PrgXzFFalvSuKTJ0pXcO+BKjL4WS8DclgDcGh5DlsdeE9r2
 vrVUrqRUl+60EOe+Rq5aGX4nYFZJddVhqEehYJW1JboCXxMMwUspHxgHQ/L6h2UipfPi
 AlazEOoFzUuBdB6dbyBDtleU2p/xrIHLn8Yvpe/rRFq8T8JDPiDROoTJUDm+S2obqwND JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3na6vyrp60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 15:56:31 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30OFIEj4015840;
        Tue, 24 Jan 2023 15:56:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3na6vyrp56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 15:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlqWS4bR4myNYT8Ut0Gl1fcEN3q2kuc/j402FBOUekz8XIEg424OclNFEZrN6I4E0B7FJ/PpwK/cR3h1d/iwRBkjQKeBqCNBOq6l2J+FJq8j9AWpkM9cFL+N5+19pQLFVTlM39LRK6HOCGSbhF3NxMkog1aKahXVqTGe2zCb8lHnKyPZ/v3bqr8wUQYb/+AXw6eHB9s0PGy8nwl3Ffg4N8/63oH2fVvRPR2WEsoM2+I4Xxgl1nHa1KdzHy4WVXzjV85ZgdMmJp4BsJ4fsCRjOdf5CwEkVpzEg1DqhBl/uOxpz5BQG8y5Y51WkoPQ3261jJHSvsYfTWdNJV5dIUMlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5IP4z0z/5Vfarfc/5X+XSUUoGuChSya1w3mM115v1M=;
 b=nI0M6XE96qYVQ2s5UURobiyssB6AD6TQq1QMslFOI2dfeRE5HZh2TR+uwciCeUGmgIAA4Bb6l1tSuBEqTjsy6OV6Ce4dzjBGtmozvm8q3Otlxn3zXKH8dL6CJJmi0PaDCdbXLLiYFoF4ZZNm2U7NmDneK0TKqpU8i7az1/jk6EL/4wV8jDav/RsBKx6E6O+gz8VO7qU5fEkQL49bspkwf0YcavLd9xvIkexSYN1GQX5K//Z5dzDzmlHP93Kpch8FcfES9T6YLqxYGn+9GvTXep6W19+N+s6YHs6yQAV6On/JPZXuqkuZ6/DXDvwXLo/Gy9ry/Fsna9GS+Dth1SuBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA0PR15MB4031.namprd15.prod.outlook.com (2603:10b6:806:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:56:28 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%8]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:56:28 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "surenb@google.com" <surenb@google.com>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 05/19] RMDA/siw: Convert to use
 vm_account
Thread-Index: AQHZMAFcvDYXQj0ZBk+u14TQW21Sfq6ttMEQ
Date:   Tue, 24 Jan 2023 15:56:28 +0000
Message-ID: <SA0PR15MB3919F0CCF1D878DE8B243B0199C99@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <4f8b1d54ab5d6909c46ba5470065f8326f9fcc62.1674538665.git-series.apopple@nvidia.com>
 <Y8/tGIeg5mI9bDOa@nvidia.com>
In-Reply-To: <Y8/tGIeg5mI9bDOa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SA0PR15MB4031:EE_
x-ms-office365-filtering-correlation-id: 23dc9bdb-16cd-4cc0-11b1-08dafe238e0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSmR1lv7fLfZ/Yb1+OJ27qvYZF500AlbfI1t16AKisW/Akw3ychkHg0t8qNUt3yqSQhGu3nyz+vOTycQGydaouQN0tifqMMv0D/nhFfT0dFIc7pc4Jj+Zlqol93gax7Kae92HYDUmWiFv2O9lct1U7/9suaslxnPltDN0xhUZ0BH04gdmgzRSk3cgqp9csfBtHAEJOpRMhmUQvoWMIJJYorSTvX4zff2wS7l8SHbL89ckT6G1mIR0RVvDc/MpWqliltskae9XCP8jLgPQMyhCtgCuM1tdnuflEyKGdlrmTlw68yZuFbm1GvWh7ZMwbTAlMdsxlFRjaYTcvZCEM7ePYeIt1C2bLeYwHHMC1Q6bjQFOwh68401Z5fhzPiHbx6GThXvqPXjPm0w41Q1XHdpr3ZU363UZO6NVAjKKMKv0GjfRMki6OPUHD/fekdPHTlrj/0T4ESTMvdwV4PduXJe5gfvC8FmnV/4KqysdRxZu4eKG8DFe0eLOoLfISAOy4YLL+LbVckYDBdPq5rgutA1X80nhnULOLhI3XZN+Eb894NXdN5kqgBbk9t1uC/zuD8m3w9vc12JhS66OqZZupCmJiCjGHehjySc6/unj+DeX+cIzYfJwVL+hTw9mzykRfnLhhCgb6KZFyLvmJhYT9SlQ6fjHBc3HdjqUkkk0y+4XVRlH/uMjvozUclJ1KiyjxZY5hgKxnDi+XOTHnNLoK/QpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(2906002)(5660300002)(7416002)(38100700002)(38070700005)(52536014)(8936002)(4326008)(41300700001)(122000001)(83380400001)(86362001)(33656002)(66446008)(71200400001)(478600001)(7696005)(66476007)(110136005)(6506007)(53546011)(186003)(8676002)(26005)(9686003)(316002)(55016003)(66946007)(54906003)(76116006)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3RDWk9KYTduUFlwanN0VkFTOEw0VEZJa1p5ZktueExid3pkR2p3bXltMVZq?=
 =?utf-8?B?N2tJY0tlOXNmdVMzR05IVTYxSng2SG5ZL0Q4c1h6MHU4NStwMTFKeEd6bk1w?=
 =?utf-8?B?VlBBcnNZSlJlK2JseGVwaFNXeU1QdEJTSzM2RG5jMnJHOE10bTU3WFFjc1lB?=
 =?utf-8?B?K0FGcEJjc3BZWnBVT2J1N1o5K2F3YVVRUHdWcWVSeGFOVnhmV3Qxbm1lRElB?=
 =?utf-8?B?TFJwNXlhM0NrMXNiR3BFRWZMNzZMbmpWWm1uRnlWSzdHVjdmMjhPRjNnTXli?=
 =?utf-8?B?ckdHOEo3WVIrWUErdTg3NTB6T0ZLZlE2anZLdjhraUo2UnpLZVZYeGtFVEJm?=
 =?utf-8?B?a1Q3dnVwWWlFN1ZwdVZIZWF0ZmVGeUVMMTAxa1haZzZuQ1IrZWdjNGxiNldS?=
 =?utf-8?B?R25ZRktOMkJGY2NCRTM4cnBDZUtKNU9RbGVwUHEzVkl3RExvUm1LaFVtZTk3?=
 =?utf-8?B?TjdaMWtrOVZ4ZGV0Um1FUDNkZDR0ZnVMeFNxVU4rVVNFT29XMGQwMnYzcmtB?=
 =?utf-8?B?ajdXNVpQZWdoVE9oZTg5UXhQV2hhbTFEWldobURjOHZFcWpIM2p4N2NKbXBh?=
 =?utf-8?B?ZTlvMFp0MDRUdk9UYjdrVHo2eUpKUUxhcWdZZ0NoNHk3aEw1ZzhlQjZjaFlO?=
 =?utf-8?B?ZjJES3pvM2JnSHkwN0ROaE85Qzg1ZGZyZjI5Y0lHdCtPNVJhNjZ4dXMvVXU3?=
 =?utf-8?B?UStnSmx2aGs2ZmpXRnVkNzhnSUUxdGtpSUVVWWNnRXVxKzJHOENRSGpTNEo0?=
 =?utf-8?B?enpPL01wUmV4ZmlKaGt6NitGeFFhQlMyY1pVMnR4Z0M0ZlVrK1VNeHk5dDFZ?=
 =?utf-8?B?OGxRSCt1ZlhzVGdmclM3SldWRFg0WXY2SHMyc0RKU2plL215Y1NkMnJUMXM4?=
 =?utf-8?B?SXlXNDQxOStrdWY4MDJpNklHWTJHT3FpL1o1Q1FGSnRGaFR6aHdnY2E1azl0?=
 =?utf-8?B?b2Z2Vll4cjJsNVpSTU8xM2JsNWRJbFp5UVJuaHc3eXdnRkRPamN1RHNWTnRN?=
 =?utf-8?B?QURuU28rR2xSTHhCTjJadCtNQjUxZE43cmVyM0djc0x5Z2Q4Tmo1U1grUWN2?=
 =?utf-8?B?YkZyT081Q2FNSDVSMXFVUnljQ0k4YmVCZjYwODl0QXBHOGdKbXFJNERaSnRw?=
 =?utf-8?B?c2hCTjJEbE9LZ00rZU9vMnRoM3FpdVY3Z1VkUnZVNEUyUWpxYi9BcGg1SDdN?=
 =?utf-8?B?YUF1N2l5dE1QTjl3YWk3akdaVFY5RjZZSW5IMUlRVkNDbVMwRW5UNjhnd1B3?=
 =?utf-8?B?WExIdDYzeWplN2ZBRWl0Wlhpb2Y3OURsK05ybk1JNnMwRUJRRWE5Y2tETytE?=
 =?utf-8?B?QmljTGY0K3ZROVpxK2MwM1JQaTVVSmEzWjZQdVp0TzlMbHZkeTMxOWdCRjMz?=
 =?utf-8?B?QitmcW1NNDVUT1laRklLV0FMRkt6UncwUFN3ZS9idnlWa3BYWklXN1JhSFRD?=
 =?utf-8?B?Z29KUnNQM05MZWtGeE5TbmxFbHhxRnU4VGhTYXdhdTRZb0Z5RWtqNmh3aFdG?=
 =?utf-8?B?OTRjYzNzN1pIdVNIRlNhMTFDcGZJRjBMTW5ZVU81R1FiZ2NWTlhNYVF2MTlR?=
 =?utf-8?B?djhUVG8raVg5OCtHd1dKd1JKdEIxa2VKMWJ6MVY5aDVRd2l6LzMzRXNQNU5a?=
 =?utf-8?B?MjZjRUlOTmpwM2NkQWkwenpFNFllTTVjL0NjMU5ZaDBrb0Y4dEZBK2d0N1pt?=
 =?utf-8?B?MFRyd3FKOXd5bHFwR1BGTUJEV2M3NDZYZUQ5NUZ2UnFSVnJsaGdxTFF2YmZX?=
 =?utf-8?B?UW9VdDR5UzlhQy9DRm1NaWR3N2pnTTkrRDV0ckU3ckFlN2xLaTFYSVpZUndu?=
 =?utf-8?B?RjZxcnpZLzNWZ3psYnBJMytOTW53S1RldTlVcG13SXRpdmdlTkNCRkk4b1c1?=
 =?utf-8?B?ZUJHWVZ6NVVCS3dCb01iMU5DU2x0MlJuZUxaaFQ1WVk0MS9nWEo1QklNUkM3?=
 =?utf-8?B?UE5NMnFPMit3ckxrakwxN1lYSHNNZjUzWnFxUk9qSmRSUXZuWG0xWjVkZ0hh?=
 =?utf-8?B?aTNlWW1udFR4cFR4N3lkWGl1WEYraGR4YmhueHBrUDBMamJRSFFISHg2TVR4?=
 =?utf-8?B?MG8yOGt0bitmL3AyREpZMWdBZXpGWHFqSmZ2SGxuWklPZjkrbHBoSG84M1VB?=
 =?utf-8?Q?+xAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dc9bdb-16cd-4cc0-11b1-08dafe238e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 15:56:28.6590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cm7mdIRgCzt44DOLSZS0DXG4ZSfxEO6qUL4CJzzaOVacjuQaVQkyiWHSD7lpa/+Ta/CB85T2ywKAPI+Xqtxmww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4031
X-Proofpoint-GUID: zoEXbAq12pVff0C7vf5Rk_NobH7GEVtT
X-Proofpoint-ORIG-GUID: r8P7lVIRAwxFALB6pqmvUbD3pG4z1x_7
Subject: RE: [RFC PATCH 05/19] RMDA/siw: Convert to use vm_account
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301240141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMjQgSmFudWFyeSAyMDIzIDE1OjM3
DQo+IFRvOiBBbGlzdGFpciBQb3BwbGUgPGFwb3BwbGVAbnZpZGlhLmNvbT4NCj4gQ2M6IGxpbnV4
LW1tQGt2YWNrLm9yZzsgY2dyb3Vwc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBqaHViYmFyZEBudmlkaWEuY29tOyB0am1lcmNpZXJAZ29vZ2xlLmNv
bTsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBzdXJlbmJAZ29vZ2xlLmNvbTsgbWtvdXRueUBzdXNl
LmNvbTsgZGFuaWVsQGZmd2xsLmNoOw0KPiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJt
LmNvbT47IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsNCj4gbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1JGQyBQQVRDSCAwNS8x
OV0gUk1EQS9zaXc6IENvbnZlcnQgdG8gdXNlDQo+IHZtX2FjY291bnQNCj4gDQo+IE9uIFR1ZSwg
SmFuIDI0LCAyMDIzIGF0IDA0OjQyOjM0UE0gKzExMDAsIEFsaXN0YWlyIFBvcHBsZSB3cm90ZToN
Cj4gDQo+ID4gQEAgLTM4NSwyMCArMzgyLDE2IEBAIHN0cnVjdCBzaXdfdW1lbSAqc2l3X3VtZW1f
Z2V0KHU2NCBzdGFydCwgdTY0IGxlbiwNCj4gYm9vbCB3cml0YWJsZSkNCj4gPiAgCWlmICghdW1l
bSkNCj4gPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPg0KPiA+IC0JbW1fcyA9IGN1
cnJlbnQtPm1tOw0KPiA+IC0JdW1lbS0+b3duaW5nX21tID0gbW1fczsNCj4gPiAgCXVtZW0tPndy
aXRhYmxlID0gd3JpdGFibGU7DQo+ID4NCj4gPiAtCW1tZ3JhYihtbV9zKTsNCj4gPiArCXZtX2Fj
Y291bnRfaW5pdF9jdXJyZW50KCZ1bWVtLT52bV9hY2NvdW50KTsNCj4gPg0KPiA+ICAJaWYgKHdy
aXRhYmxlKQ0KPiA+ICAJCWZvbGxfZmxhZ3MgfD0gRk9MTF9XUklURTsNCj4gPg0KPiA+IC0JbW1h
cF9yZWFkX2xvY2sobW1fcyk7DQo+ID4gKwltbWFwX3JlYWRfbG9jayhjdXJyZW50LT5tbSk7DQo+
ID4NCj4gPiAtCW1sb2NrX2xpbWl0ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdFX1NI
SUZUOw0KPiA+IC0NCj4gPiAtCWlmIChudW1fcGFnZXMgKyBhdG9taWM2NF9yZWFkKCZtbV9zLT5w
aW5uZWRfdm0pID4gbWxvY2tfbGltaXQpIHsNCj4gPiArCWlmICh2bV9hY2NvdW50X3Bpbm5lZCgm
dW1lbS0+dm1fYWNjb3VudCwgbnVtX3BhZ2VzKSkgew0KPiA+ICAJCXJ2ID0gLUVOT01FTTsNCj4g
PiAgCQlnb3RvIG91dF9zZW1fdXA7DQo+ID4gIAl9DQo+ID4gQEAgLTQyOSw3ICs0MjIsNiBAQCBz
dHJ1Y3Qgc2l3X3VtZW0gKnNpd191bWVtX2dldCh1NjQgc3RhcnQsIHU2NCBsZW4sDQo+IGJvb2wg
d3JpdGFibGUpDQo+ID4gIAkJCQlnb3RvIG91dF9zZW1fdXA7DQo+ID4NCj4gPiAgCQkJdW1lbS0+
bnVtX3BhZ2VzICs9IHJ2Ow0KPiA+IC0JCQlhdG9taWM2NF9hZGQocnYsICZtbV9zLT5waW5uZWRf
dm0pOw0KPiANCj4gQWxzbyBmaXhlcyB0aGUgcmFjZSBidWcNCg0KQnV0IGludHJvZHVjZXMgYW5v
dGhlciBvbmUuIEluIHRoYXQgbG9vcCwgdW1lbS0+bnVtX3BhZ2VzIGtlZXBzIHRoZQ0KbnVtYmVy
IG9mIHBhZ2VzIGN1cnJlbnRseSBwaW5uZWQsIG5vdCB0aGUgdGFyZ2V0IG51bWJlci4gVGhlIGN1
cnJlbnQNCnBhdGNoIHVzZXMgdGhhdCB1bWVtLT5udW1fcGFnZXMgdG8gY2FsbCB2bV91bmFjY291
bnRfcGlubmVkKCkgaW4NCnNpd191bWVtX3JlbGVhc2UoKS4gQmFpbGluZyBvdXQgYmVmb3JlIGFs
bCBwYWdlcyBhcmUgcGlubmVkIHdvdWxkDQptZXNzIHVwIHRoYXQgYWNjb3VudGluZyBkdXJpbmcg
cmVsZWFzZS4gTWF5YmUgaW50cm9kdWNlIGFub3RoZXINCnBhcmFtZXRlciB0byBzaXdfdW1lbV9y
ZWxlYXNlKCksIG9yIGJldHRlciBoYXZlIGFub3RoZXIgdW1lbSBtZW1iZXINCid1bWVtLT5udW1f
cGFnZXNfYWNjb3VudGVkJyBmb3IgY29ycmVjdCBhY2NvdW50aW5nIGR1cmluZyByZWxlYXNlLg0K
DQpCZXJuYXJkLg0KPiANCj4gSmFzb24NCg==
