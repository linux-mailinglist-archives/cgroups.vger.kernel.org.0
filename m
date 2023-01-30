Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAC680ED9
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjA3N2U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 08:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjA3N2P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 08:28:15 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B7018154;
        Mon, 30 Jan 2023 05:28:11 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UCqZ7i008831;
        Mon, 30 Jan 2023 13:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WIHsb5JpPCYF+LWCn+6uV+U71uCxw88BhUtBF5ip6kQ=;
 b=DpMH9iW0aVzxWIzZIEan5gPlXOwT79Tds7M0A9lSWFPJBw13E/FhhdFQEXj0eSzay1rP
 a84UahsS/eTpvKBVd+ufNCtS3gYtcGkpafwaheu3QKGRUZ3oItPdE1hLyATQb+lLFfpm
 nK7+itt+n0ishBKy5VP+B4zXnbfGr/ivhVjobn5RBtETO04t6osDgEHf9yhcdCFe8d/I
 cFu6AFiDorRhh3LdlcmTbrBnnM+PemfLNN/JWpsZwdhgFQbJu7U/Fy5GRIU0anTFGSDl
 aapntVfjRVl2XX2glkTDKjLk/Jd9eDb5FElPr/IxOwfE3KFdzBkzaL8XJZhAqi1wA2av cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nee98gtr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:27:56 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UCqtKd011310;
        Mon, 30 Jan 2023 13:27:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nee98gtqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwxPe6acsAGW+ro3sKR8kMRNqhPkH6e64ckjfLEMYMctTcdcvYhlXotzJa0htThSntabcSt6DFkfireJi+8I2fnAVEt+JdtiMgKdDj3u7a8bpXMgtiJgnET/Yl+KUidiQS9v/a3xFIQaaQ1E58j9JGdIARTkpJG7xvsE5jBm4yEEQAwpRGhMiRF8cjL/VxDnfq2sEcY8k3W8J6/Vm7LKTtoJazzh5DRm8XMQmfCftkqoU141CQZbuI4zpgIADBQVls4OFD6Ai1E8ylImki3wfr33LXv9MhyIiQ87VyJovmG1FXyw5RF2a+iy5ATlBPpMKpm+F6QZq7f2glvCuxBNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIHsb5JpPCYF+LWCn+6uV+U71uCxw88BhUtBF5ip6kQ=;
 b=aFXFJZ3axqOwKLyNQ4G8imxgoeLSaBMQdyZ88uPxwcLZ1CBwsqEn+n9MDf+QZBG18z9JtusuWlBznacr5725aNB1+Sxop4dvmvRt4nAR+rcqg+gLpVl2EoKh0cEM9WikAWzW2VjhtwDDgL6C7qqakfF3urLXk+RKPpiqnmvIKbJUy68BFPqbEskes/kmGGV22ARD7ranonkez9oMa2bYQ+W8L86ZRtRcNl/C4XPf1zsrpRFCcZ3qd1tgqFQVnOGlwk6LEnDvO09YjZJEOmli3DEOtlt1v5zChJLYKMBDKgHEU0tVhy69+0b2MPC0OJxOsz6WYLm0TOkg8XEQSxcwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by PH0PR15MB4814.namprd15.prod.outlook.com (2603:10b6:510:a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:27:54 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:27:54 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Subject: RE: Re: [RFC PATCH 05/19] RMDA/siw: Convert to use vm_account
Thread-Topic: Re: [RFC PATCH 05/19] RMDA/siw: Convert to use vm_account
Thread-Index: AQHZNK6oQ0+1NhopQE2KM5ni/NwYqg==
Date:   Mon, 30 Jan 2023 13:27:53 +0000
Message-ID: <SA0PR15MB391928BD9B0B20F85A061A2E99D39@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <4f8b1d54ab5d6909c46ba5470065f8326f9fcc62.1674538665.git-series.apopple@nvidia.com>
 <Y8/tGIeg5mI9bDOa@nvidia.com>
 <SA0PR15MB3919F0CCF1D878DE8B243B0199C99@SA0PR15MB3919.namprd15.prod.outlook.com>
 <87lelkz23e.fsf@nvidia.com>
In-Reply-To: <87lelkz23e.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|PH0PR15MB4814:EE_
x-ms-office365-filtering-correlation-id: 0641e2b2-48a0-4de2-6eb4-08db02c5caed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bp5jKfmOMwkuWvq5n1FJVW0u9CnHpk++pPe8R+Po44Jtphj2DRszCH0rDOqT5QpieoD2VBMHojE5B8LRv4rXiQVFfDC3awDQpKZhYJHvDibFRXgLgVAzxKLE7N+0vnhnCYjDriXHNKSzI+a8mjt7P/gnkX/CD8EsRspfYIWp+1DtDcMhxjz0Cre0XYNyySaKImUg6jfSGx+qhoBoGPoK0/S1+zX0xPobskiwFSx7u7UKcbatbdQEXrI1qSwCVxCFmxhLtfS+FkvMhBnOENOAafKnzm59RyxT1ZDH2s4wuv6KroAKB8grNU7PQK8EWyPOaxKQROD/jn4eF26H1q1q8qrlqUjZcx3sHqDA+h81KA80EEt3uV48AQr3hUNA6a8V4uKN5hWHPa4W88ow/PbqT7SG45fcrRaM67sua3KRijCQH27Ewoo7UYSnBBAqneAMTnnDdgOyXsLwtFebotjNtEEGd9mZoI0GfQkJ38JqosyzNzgFqB/OeCCqjSuQ4JkOseyrbDtRnmhQV47ZJqejsxXy7sa9h0xSgHqVkTawbo15ItZOf9dIUz21cMTgl0UOSBGUyZdhayjqDIKwkgs5+TWlQDvkPly+XSIZCsNogT7y0uoG3815YovAjKoEzWcy5KGrDNiZ9LFsUXVZGxFPPF5GRvczrhn9z+gOFkRELiTHHPESileN5nyBVpqrFuJeztDeZk66NTH5nEDhaemptA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199018)(7416002)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(2906002)(7696005)(71200400001)(53546011)(6506007)(9686003)(186003)(478600001)(33656002)(55016003)(8676002)(66476007)(6916009)(66446008)(64756008)(66556008)(52536014)(8936002)(4326008)(41300700001)(76116006)(66946007)(54906003)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUhtUXhEK3N1VEtZUHV4UWQxeUd3SDM0RlhCQkRseG1WZ3p6dzIzWVVWY1pr?=
 =?utf-8?B?UGxtQ1JEVHlxRDFHaDdwT3A0Y2tIUTc5dTN1YzRKcHlCZ1Y1ZFYzM3NjOUNY?=
 =?utf-8?B?bHNNQjZwZElubk9tUW9tNmtrMEFoRE9lTlVyQjg2TE1FalRDVHhmS041ZnBj?=
 =?utf-8?B?VXdiTFlxa0cyc2lGaFRRT3RVRnR5eGZwODN3c2xkR2doN1QvMUlaOU9SelJL?=
 =?utf-8?B?TFdzeUY5TncrQy81UlJFS1lMTVdOVzFIMnpXY2dNNktoL05OMGFaTUEzdmRj?=
 =?utf-8?B?Q0paU1Z5azVHa3dhQ1hTTE9lS3lpY2JiekN4ZWtlSVpvQTBiWEhLa0RzMlpI?=
 =?utf-8?B?L2xpVkRUMmRQdkhXbjV3ZDh6MDNzR1EveTdJS3ZoMGYyVnpSUFkrQUxlRk9z?=
 =?utf-8?B?bnBTNFpwckxoSDZxYWpHLzAwTnR4bWN2NFphVktZM3Q1MU4va00wWmZuTlY4?=
 =?utf-8?B?RjdEblFJRGFUYU9xWVhROU4vSnB6TU5ESjlTaWZRbjZtZng3R3UzTzBYSCtN?=
 =?utf-8?B?aXZ6U1NQT2RDUElTV3czV1VoNUZ1ZEovTW1JR3BqN3FkSnAySU56NTdHLzUx?=
 =?utf-8?B?OUx2VW9aT09ZSDE4eXY1NE9jWUdWdENoSUo1ME0xMGo4Zm9DZE5Uc3dWdVBi?=
 =?utf-8?B?K3R0VGN4QUg2MXlGN2crK0Y3Mk5DY0tZdzc2VDBtRkJwdWR1c2tmbzNsaE1r?=
 =?utf-8?B?dDJhM3lSVHA5eXQyKytaaFlpLzFpT1V4c3AxQVQrOFJ1Y21LNG5mSytheWhp?=
 =?utf-8?B?dTVEWms5YlhjaGtCcVhzL0tqQjN2TzdMbjUyaEV4MkZiQjNGWHBEV3ZqNkg5?=
 =?utf-8?B?eldKTnVNTzJ2Q3RBdm50bFFzUlJLbnhBVUdORmJYMFQ5di9zcDVSUTlLdnAr?=
 =?utf-8?B?NG43T0VoRUNoeHQ3bnI2Q0tDekpZNUVlazl1KzhhdlFWbkErNXdjVE5TRHRv?=
 =?utf-8?B?SmVia09KZEJ0YktCVGNwQ2VJTGh0U3dwRmVFamRPenRRSlZPbkZnV1VnYnph?=
 =?utf-8?B?a1RLeVJTSDMzM0xDcExOT0pWWm94b1RmRmxPOFNUV3V3TVVJSXVOTFJCZGwz?=
 =?utf-8?B?WGtuSVE1aEM0b0Z5azRvVjBRbmEyQUZOZUtRRGJUWjJhZCt5TlB0WTlxUWNy?=
 =?utf-8?B?ZllVNGNYMlY3Rjl0ZmpvMDFhYnVvLzRweUtURFVnT0hoK0pZaVNzRWNpSDFk?=
 =?utf-8?B?Z3JLbVhLR0dhZDhSUXhIOE9tUVBVR09PWmdna3c2d0t3ZTFDTlN1cFN1Tjl5?=
 =?utf-8?B?clVFaituaUlBRXg2cWI4OWFkNHZyRnlQOU0wTDdoVjUvUkJLb0pzU1YrZXdj?=
 =?utf-8?B?KzBySk1UWGR3ZHlVVmpLSE1GWEdUM1p5dzl1YlUrL0pWMHI4S1BhOFdoSWNm?=
 =?utf-8?B?cUN5T3J5eGE5MERaYjQyOVlMTU1zckZnRW5UcHBsdTRmRmtUYUhWOXhuZmNz?=
 =?utf-8?B?cEtwbkZkc3duemg3Z2RwMmhSV1NtbGtWMzF3d2NPRHJwZWFRTzllTlBOTVBV?=
 =?utf-8?B?YTdUYitxY2gxeEpXbVZ2TSs1VGl2L0R1bTRNRUFEd1JqcHBlbVRKbll1V1NQ?=
 =?utf-8?B?R1hjVm1WcUsyb1pKZmFGVkFwblA1dXoyNjJxQnZSVUFubGdxS3FJM2RGMDg1?=
 =?utf-8?B?NUtNQjZsQzY1cHJucjRJMWd6RVFYNEVaVVgxT3FGL1dsN3lrL2wvT0VtL1dJ?=
 =?utf-8?B?V0JXUmp6VlpMQkRtWHV0SlNYU3hVeE1mTWN4Y1hqREdNR295ek55VUNQb3pC?=
 =?utf-8?B?OVExNDFMSkp2aFVwWXZXbk9PNkJyS3NmN3pDVU1YQXlpcThyZkRRSHZUYXl0?=
 =?utf-8?B?TW5WYmdvMThUb0UzaGl5Z09VZVQwak5yNXltMFIySENzRUpBaE9FUWxub2F0?=
 =?utf-8?B?QU1XMFRPaml6UFBZMWNvVmxNSGM3bFd6a3VXcVFxUGszNkpjQUZnUFRnSVJw?=
 =?utf-8?B?Y3pBbWlnMmIxZHptSkxFVXFtL2RkMDRnMHVzd0l3ZmZqSk1TZzdydHQ1T1lm?=
 =?utf-8?B?SjdtdWlSMXY5bUtwVU9UNm5oelhCdmZUSzNuTGJEZmFZOWNZRVZrTVQxbDZG?=
 =?utf-8?B?b3p0UXdaK3JLVmthejNLNytidWdFVThjMVFwZHFzQU1keGNvT2k0L0dtQUVF?=
 =?utf-8?B?MFhzVVZMVDlSVDR5aWYvcG1nYW9WR0FCYTU3a2YzT1YxY3grd210cTl1TCtE?=
 =?utf-8?Q?Zx8TpPAFfBTHASX9XAVOvKk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0641e2b2-48a0-4de2-6eb4-08db02c5caed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 13:27:53.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qC0LwNvV/OctkRjjjLTmK1M8ZWIm6X9NSI46WZ83GT0Zlh4Asdx3uo/BYzjgKzVApVIHXxMBxiNsguUdUmpySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4814
X-Proofpoint-GUID: S0Wwk2vc1xqY3ri1GsBaFTaoIgZYOx3H
X-Proofpoint-ORIG-GUID: T9viKNBDibxn6c5LluXQ8vT7V2Si5-5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_12,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgUG9wcGxl
IDxhcG9wcGxlQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgMzAgSmFudWFyeSAyMDIzIDEy
OjM1DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IEph
c29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IGNn
cm91cHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBqaHVi
YmFyZEBudmlkaWEuY29tOw0KPiB0am1lcmNpZXJAZ29vZ2xlLmNvbTsgaGFubmVzQGNtcHhjaGcu
b3JnOyBzdXJlbmJAZ29vZ2xlLmNvbTsNCj4gbWtvdXRueUBzdXNlLmNvbTsgZGFuaWVsQGZmd2xs
LmNoOyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47DQo+IGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtSRkMgUEFUQ0ggMDUvMTld
IFJNREEvc2l3OiBDb252ZXJ0IHRvIHVzZQ0KPiB2bV9hY2NvdW50DQo+IA0KPiANCj4gQmVybmFy
ZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+IHdyaXRlczoNCj4gDQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIDI0IEphbnVhcnkgMjAyMyAxNTozNw0KPiA+PiBU
bzogQWxpc3RhaXIgUG9wcGxlIDxhcG9wcGxlQG52aWRpYS5jb20+DQo+ID4+IENjOiBsaW51eC1t
bUBrdmFjay5vcmc7IGNncm91cHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgamh1YmJhcmRAbnZpZGlhLmNvbTsgdGptZXJjaWVyQGdvb2dsZS5j
b207DQo+ID4+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgc3VyZW5iQGdvb2dsZS5jb207IG1rb3V0bnlA
c3VzZS5jb207DQo+IGRhbmllbEBmZndsbC5jaDsNCj4gPj4gQmVybmFyZCBNZXR6bGVyIDxCTVRA
enVyaWNoLmlibS5jb20+OyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47DQo+ID4+
IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6
IFtSRkMgUEFUQ0ggMDUvMTldIFJNREEvc2l3OiBDb252ZXJ0IHRvIHVzZQ0KPiA+PiB2bV9hY2Nv
dW50DQo+ID4+DQo+ID4+IE9uIFR1ZSwgSmFuIDI0LCAyMDIzIGF0IDA0OjQyOjM0UE0gKzExMDAs
IEFsaXN0YWlyIFBvcHBsZSB3cm90ZToNCj4gPj4NCj4gPj4gPiBAQCAtMzg1LDIwICszODIsMTYg
QEAgc3RydWN0IHNpd191bWVtICpzaXdfdW1lbV9nZXQodTY0IHN0YXJ0LCB1NjQNCj4gbGVuLA0K
PiA+PiBib29sIHdyaXRhYmxlKQ0KPiA+PiA+ICAJaWYgKCF1bWVtKQ0KPiA+PiA+ICAJCXJldHVy
biBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+PiA+DQo+ID4+ID4gLQltbV9zID0gY3VycmVudC0+bW07
DQo+ID4+ID4gLQl1bWVtLT5vd25pbmdfbW0gPSBtbV9zOw0KPiA+PiA+ICAJdW1lbS0+d3JpdGFi
bGUgPSB3cml0YWJsZTsNCj4gPj4gPg0KPiA+PiA+IC0JbW1ncmFiKG1tX3MpOw0KPiA+PiA+ICsJ
dm1fYWNjb3VudF9pbml0X2N1cnJlbnQoJnVtZW0tPnZtX2FjY291bnQpOw0KPiA+PiA+DQo+ID4+
ID4gIAlpZiAod3JpdGFibGUpDQo+ID4+ID4gIAkJZm9sbF9mbGFncyB8PSBGT0xMX1dSSVRFOw0K
PiA+PiA+DQo+ID4+ID4gLQltbWFwX3JlYWRfbG9jayhtbV9zKTsNCj4gPj4gPiArCW1tYXBfcmVh
ZF9sb2NrKGN1cnJlbnQtPm1tKTsNCj4gPj4gPg0KPiA+PiA+IC0JbWxvY2tfbGltaXQgPSBybGlt
aXQoUkxJTUlUX01FTUxPQ0spID4+IFBBR0VfU0hJRlQ7DQo+ID4+ID4gLQ0KPiA+PiA+IC0JaWYg
KG51bV9wYWdlcyArIGF0b21pYzY0X3JlYWQoJm1tX3MtPnBpbm5lZF92bSkgPiBtbG9ja19saW1p
dCkgew0KPiA+PiA+ICsJaWYgKHZtX2FjY291bnRfcGlubmVkKCZ1bWVtLT52bV9hY2NvdW50LCBu
dW1fcGFnZXMpKSB7DQo+ID4+ID4gIAkJcnYgPSAtRU5PTUVNOw0KPiA+PiA+ICAJCWdvdG8gb3V0
X3NlbV91cDsNCj4gPj4gPiAgCX0NCj4gPj4gPiBAQCAtNDI5LDcgKzQyMiw2IEBAIHN0cnVjdCBz
aXdfdW1lbSAqc2l3X3VtZW1fZ2V0KHU2NCBzdGFydCwgdTY0IGxlbiwNCj4gPj4gYm9vbCB3cml0
YWJsZSkNCj4gPj4gPiAgCQkJCWdvdG8gb3V0X3NlbV91cDsNCj4gPj4gPg0KPiA+PiA+ICAJCQl1
bWVtLT5udW1fcGFnZXMgKz0gcnY7DQo+ID4+ID4gLQkJCWF0b21pYzY0X2FkZChydiwgJm1tX3Mt
PnBpbm5lZF92bSk7DQo+ID4+DQo+ID4+IEFsc28gZml4ZXMgdGhlIHJhY2UgYnVnDQo+ID4NCj4g
PiBCdXQgaW50cm9kdWNlcyBhbm90aGVyIG9uZS4gSW4gdGhhdCBsb29wLCB1bWVtLT5udW1fcGFn
ZXMga2VlcHMgdGhlDQo+ID4gbnVtYmVyIG9mIHBhZ2VzIGN1cnJlbnRseSBwaW5uZWQsIG5vdCB0
aGUgdGFyZ2V0IG51bWJlci4gVGhlIGN1cnJlbnQNCj4gPiBwYXRjaCB1c2VzIHRoYXQgdW1lbS0+
bnVtX3BhZ2VzIHRvIGNhbGwgdm1fdW5hY2NvdW50X3Bpbm5lZCgpIGluDQo+ID4gc2l3X3VtZW1f
cmVsZWFzZSgpLiBCYWlsaW5nIG91dCBiZWZvcmUgYWxsIHBhZ2VzIGFyZSBwaW5uZWQgd291bGQN
Cj4gPiBtZXNzIHVwIHRoYXQgYWNjb3VudGluZyBkdXJpbmcgcmVsZWFzZS4gTWF5YmUgaW50cm9k
dWNlIGFub3RoZXINCj4gPiBwYXJhbWV0ZXIgdG8gc2l3X3VtZW1fcmVsZWFzZSgpLCBvciBiZXR0
ZXIgaGF2ZSBhbm90aGVyIHVtZW0gbWVtYmVyDQo+ID4gJ3VtZW0tPm51bV9wYWdlc19hY2NvdW50
ZWQnIGZvciBjb3JyZWN0IGFjY291bnRpbmcgZHVyaW5nIHJlbGVhc2UuDQo+IA0KPiBZZXMsIEkg
c2VlIHRoZSBwcm9ibGVtIHRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LiBXaWxsIGZpeCBmb3Ig
dGhlIG5leHQNCj4gdmVyc2lvbi4NCg0KVGhhbmsgeW91ISBMZXQgbWUgc2VuZCBhIHBhdGNoIHRv
IHRoZSBvcmlnaW5hbCBjb2RlLA0KanVzdCBjaGVja2luZyBpZiBub3QgYWxsIHBhZ2VzIGFyZSBw
aW5uZWQgYW5kIGZpeCB0aGUNCmNvdW50ZXIgYWNjb3JkaW5nbHkuIE1heWJlIHlvdSBjYW4gZ28g
ZnJvbSB0aGVyZS4uPw0KDQpUaGFuayB5b3UsDQpCZXJuYXJkLg0KDQo=
