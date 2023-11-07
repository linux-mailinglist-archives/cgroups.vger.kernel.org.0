Return-Path: <cgroups+bounces-220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B067E4C81
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 00:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF29B21086
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 23:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158023066D;
	Tue,  7 Nov 2023 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1++QVbTP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q9HmUOOF"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE930667;
	Tue,  7 Nov 2023 23:10:17 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B01FE1;
	Tue,  7 Nov 2023 15:10:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJwQF020749;
	Tue, 7 Nov 2023 23:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FL00QVQAGA2zkQ5sy8oa/2TLw0UFzud7L1OBcIidWUk=;
 b=1++QVbTP2H2S5eI3Hx+HbIgb4OLloZKti7OCHY8BiONMr2rKwIKVgEXwV2v3jb4Ykn4X
 N88ZpIlru3Gyg7wTJ/9BvGeHmG2DuQVKUD1hhoy2YuBOmFn5HLOE5Wbinc15Ee23xNXp
 +xp8EPfK7ID11NgERVXxMAuWeTZ1T2j1WghhRTvsyKE478ma5hyI5Q5FZ/PCfUpBjb3s
 rvre0vnx7SJTuYKFng9bYexPwUfEDLofGCL6JeYicW84LAluCGPJd8o48WeCmVR0hhcS
 09slom0Qzdyr21sHebNodc0tJqt5f0zzeTcagyrG1BpZQipYPiqxgw7yMeQ6r76cXIzP KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2207ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Nov 2023 23:09:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N3tUw010979;
	Tue, 7 Nov 2023 23:09:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tva65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Nov 2023 23:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOpaPEevP0nBoAZgXWmGpBdD2oujShYvhJ1/fwceYGTr9zlyHKgbK9pystifWX+qLCzE6oKebwpV5BjivjZYqXHg0kJ3jff/z8HBAZXv1qowi5nUVlXWD7ecBvl80SoZJUaqra/5STYNq5O6fnscLBzxR3N6JnHib74YHEF6jaEVdOZz9F+sLPJITX6GL6QXO7/QAxSwp2TI4NAtHKi0SVLDVOMC9HmnILNgnukeFYsMPPRn66GfO6WEtTbCulbR+mUtBKMonZqCIRFpQ4FMMmVuMmsygDI5svdSAX+HC6py6/EkWtZYVRjJCo8tc6M162CyCgPrqf31bPpy7LLxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL00QVQAGA2zkQ5sy8oa/2TLw0UFzud7L1OBcIidWUk=;
 b=h0qsIoafo/aqw9th03PCBibuqCrKRYtcogyiUxxplPYRF2kvKS++zq4xQTKXcSVtuoQv8wFYhidK/7GAOceYFT4TTxynF4s9TGzLdhzkNZz3zcK1v6BNoLuHeDlF5IrrPzF42iAZpuy4PIEozDj6Zabbo8OWtJrRaCDdtVZ1tUPW7CKnHn8YhJ/cI5j2qi6dNrfc4OI+9+EvDJFyZeXEWRUXR6dB1sAx8evU1MAIJ46WqVNq10fhBGZ+iw9FhGhggecpb3uFXBMdQmf/RueYLQ8ZmOZILQ3ZuIKyCNYzz5zEJL3sWleurHG1pDa3/O5wHAlkxL5g9ocW/Vitniscsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL00QVQAGA2zkQ5sy8oa/2TLw0UFzud7L1OBcIidWUk=;
 b=Q9HmUOOFQKdMp5JhvYoXcIAmgx/Ibas6ZKG/6EsNAUlTgFtC4b2EoV8tsqujVs4QmgqT2ctiaa5RInmntai3m5DCeGN9pa6Fenbr8aSCcd0wiHQmctbj8i/Ao8zQ35tKaru1YsFuczxd6FascTupBRHZLkQ6xnxT3D6vDf5tI5Y=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:29 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:29 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        mingo@kernel.org, bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 76/86] treewide: block: remove cond_resched()
Date: Tue,  7 Nov 2023 15:08:12 -0800
Message-Id: <20231107230822.371443-20-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f9708c-521f-4f23-03ff-08dbdfe69848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pxk3/XWpuCJj685KqCYAQpy0YMRKR5z8J+7s7D0dlzlLRXUaiJMMrjr7F2I8Qm3Dvr3+4qqBCNzYFnVCAJQuIyKKPVG2C12ebkSk8vOO74bUf5MpDkcEXFjotoAsJXQgoU8ykRNaIRhHfC+fDuh+O3C7PH6EqC8wAy7VoE131NFPULqkNfEb+P4N/x9gmM9zGl5a0aPXh2rWhBnja0f4+8TXz0YBjdMt7Mhsii4FnpdqS3RpJbVNJGDwy58Nim9qGr3jJctbaEKnsm9xLanE8XFhb+2mTqxq3s13EsrJXwXDHWSfNN3rT0QQAOBGwXu5ay8V88674btpCU+K7Ek9YGhYh2aeneuZZdsICT1un6tjBo7nSobBWcvlngwXzPaiM53vmgW4NUNsZBQ78PoNNlwFEngdwkSP68XIvEumMjs4uaG6yNXD4/T+qmnIiKbVugLFUMUBe+AyXQan+3IdsVE1q8RUlEOgE4cD7eeKSiEHOj6dgd2N38qO3dau10zjXXAYiYx/Hn3WpQ0wVMLaA8KOG0pOpbgx/f1nRueWs9c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2jrNO4oN6KTBJeLuH23CCQFhBA2WGjR1B3UDIYBzZuDH2j+2rjYgp323ff9i?=
 =?us-ascii?Q?R2TE1JD140d4BFMJojBAM4wwByBxBkaGZfjgU/6bFhnfJWTRk6//+nl9At8a?=
 =?us-ascii?Q?LKWpbo1iLFmTT1G6S47yu7AdlZ4Y5+C4B88sbwRHFa9c3Xw0wYxecOFyzME0?=
 =?us-ascii?Q?J6j6V76OTboZkoba6ALZ0Gk8ApzhMbLjWf0rxGDEVN/fghgUqp7whoSbXwxE?=
 =?us-ascii?Q?TD2MErbUP3IbKF+4N7P4DI7J6iBJODwMkcbDYj8LuX/OpPBTj9B5XqaNAwuN?=
 =?us-ascii?Q?0Dy6u61I/Z+/82umcXlcdKHu6oVtgeHP3171YkADXTkC9hVIu1Jj7UlmVrhH?=
 =?us-ascii?Q?qbz+tzsR8uEbCb6+o666VC6Y74kCfEiVOERhdUn00ED5SgJuMFDDrBOSzZ5G?=
 =?us-ascii?Q?uhCTYf7SVoUxJmr1gDsGv4vPlhXAehPXmZpdeEJm5R30MDsqdn169uerafG+?=
 =?us-ascii?Q?nf08DscdRSGUddSRttFxme9ikST+B8YjqbuB0Yp00i9xzeUDxGmaBngA2I4u?=
 =?us-ascii?Q?3uQP85Dx5NlPn58XIocgXe/NanFpI/tO926J6ieE/XzGdv9o9UjWDawkns9i?=
 =?us-ascii?Q?JtFkHCNxq53FGVDFYb626xUGk1eJTXLNjy6h4ru+jfBm5zemAuPpKmOTKtuP?=
 =?us-ascii?Q?DiFX45x87YVOgt4v1Ff11bSsl1cGUHngv3wG4n7/vcdrVWIm1P9gp+mumqUK?=
 =?us-ascii?Q?QO3ocH2kLp9oNc3r6N3IGlQ10Q8CRAg3cOagfR9YUQ9UycQ/aMyAoJfQqX6P?=
 =?us-ascii?Q?lCtO9Nb6Wk734gRSfYzrAI+1yMS69E1kJ/aHQsYhphK4CFGgg1Cyi/0TRy5f?=
 =?us-ascii?Q?lTHU5mS9rV0XNAAOZzpKqQc/UBnrQpxorUuBKTXtn7mobDBo/dx1p4Mgr/Z/?=
 =?us-ascii?Q?DkpjzH8cocAWXX9N5ESWulCCG89+8kE0FpFBnBRsWdnCn8bYzgeuOvNrLblz?=
 =?us-ascii?Q?YfHvw1RFgpCBYrz3CyuoLIpG6TMTmEwxoZ+9ZfBdTbsW83FDqbAn/R6ZVcmk?=
 =?us-ascii?Q?EYkKCGUJITgQmTIw7WQDFzaVHbnHOcNpTny127Rx7IlErr5A4NPxI1aBWDs8?=
 =?us-ascii?Q?yiWZ4Lom6J2zckhQJDwfRig4fpVqhzrR5aNCW2Wj3x5s5Ev5EadNIsB44FnT?=
 =?us-ascii?Q?K1QEtviq24vPVPW35Lr0uVHfAgrjJHJVCJVy2Fy2a4lCEeUsQByohSh0xElh?=
 =?us-ascii?Q?oE86duQfC8aDZS4iDVLRUz9hAGmoU6W9zJu9HoM2kdEaqxWKv9t3s8SjBBFZ?=
 =?us-ascii?Q?FOV/0KP2AngHzwg1/u3Z8i+q2CjXLHGboMiQMHMDwd5yWtkGfjAOAwat3cnR?=
 =?us-ascii?Q?W7cWPVn8GSpQIhenBYCWp93Tugjb7JJjbDwftmmWyN2Zy9P/kQ5YIyT33vCg?=
 =?us-ascii?Q?uLwRHFQjvumIs+ExhXSUBT9GkK4fgNfwZuES7hB64ufxzk8pqdyGOFmuPTcA?=
 =?us-ascii?Q?bLz8a5kb/WLd55RGa6IrYT9d4FDAUsWdy3VmEcrE0jiKr1+M6kQ2aWdDPM/A?=
 =?us-ascii?Q?KTmNt8h7yHKpG2OhpG4eehcsb3dwuBsQ5WXBeAT5+bTBEfV+aqfPuloDc9Wy?=
 =?us-ascii?Q?JgR/RNbhYEhrehYcmoSDL95x8RzyuLHFaP6s2URwKdJ/cu5D0Md1PzCyv84B?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?8CkdYCzT+/dOHS8QMk04up4tMn0cUf9gGe+fRs/puSswxVnhe7kKuj0QdGLO?=
 =?us-ascii?Q?ozwZSi0Kh2YpmxeqT/aPUFLw/5BccxRmK3xI19SVQv1u1rwWKyB26BK9hp1E?=
 =?us-ascii?Q?jgTMwYIuK9sk7FRMpTM719UWNezmMYnxvrVMzwmuCHXMxLajWovJWeYFFSNc?=
 =?us-ascii?Q?V9giQA2zvuuAlifZQpi7toUuipBhSKpepSP79DG75X2mxZLYPzDohiAh/klx?=
 =?us-ascii?Q?49SnUHaFRp6H9WpKkmqFgy9iyBt/zvr9wH1X9tSgHBiN9PNuInwtEhm/cV5k?=
 =?us-ascii?Q?Uxqj4emOzLjlsmmiBV+VQZQUh8HxgpEPjhgovc/vWbqMc1OzAN86pCemnykO?=
 =?us-ascii?Q?OQNwbqshzoL7Ph+AkuNvcLMeOA53bCa1iPVnfXfx9kPAlPl8z2X0vM60HDFD?=
 =?us-ascii?Q?Jmw7swqdi5QD+7EmbP6Ba7fecVu4au8EiM0d6Z0OlrXMRIKWc2JR2j5KexgZ?=
 =?us-ascii?Q?Yy8t6OK5XiCbVl0RHIc8F3qkTi3LJsO/mWK+fAoLM+LB+z1th0rKAHxqFN/j?=
 =?us-ascii?Q?l2kp2EBZYA3oi9CqW8y2bcMVM3phQIxXmCKAVllrxVViGfFu4FO3XOMsxxkC?=
 =?us-ascii?Q?k6nr+AwWklYOe2ToMwtZN1hmmO5l7o4VfR07lShPFhEs2ck3VgjlReuhJbwt?=
 =?us-ascii?Q?hnc8Xs3zaPWKg86FW4S4AP7z1qrrGYItVmPBYCiMdp9JLRhRadnwFTVkb9r3?=
 =?us-ascii?Q?Vif/HZYaRsFeFXOPwyCpAQ3piSGKHNjNPcy+JoOtKIZxAHPRL9NzdL471UQ6?=
 =?us-ascii?Q?OTU0tFTvPVzsoSfMJmFqVFSvFx93A9HFu5ifNWGjbuy800GGbmTQU7OxNEY3?=
 =?us-ascii?Q?V5gsuTpyrW1U542eRhh8n1E6QQhUsL3DrmshylvwH1tCpelYb3zJPGFPGFY+?=
 =?us-ascii?Q?woZ2p/t09teosZhIQdn1sPPcAm/e7CM4FWsvAJuaDArYebz0yhCL8F6qhDP0?=
 =?us-ascii?Q?LGhy4SiTqGBlVaiNWdDiJp12RG7indRahny0mkTMjsERf1DL3OkfREf6ySLN?=
 =?us-ascii?Q?Sa7c0Qdd6xWnrJ/Kt4HoSgGtcdQojQT9lJ9lCRuLIHsQwYhvGBP1q+HFd9B5?=
 =?us-ascii?Q?eVh26n8HEycgpyekyvtv7vk1y9cgXKes1ZA+BJItm1Q29ncVVqEtmn9J3eg4?=
 =?us-ascii?Q?Z1kqoD6puCTXMgfMeRa2RIV03CnfiPuDEPL8lmpuRKjZlpRMe5uNQX+H8Ym+?=
 =?us-ascii?Q?SUG6xZUaaKvJaOUEcxJEy3sjWibryKncYv9OpuhFRtRG5jEhgwgYMrGdI+bo?=
 =?us-ascii?Q?p82NgIwwm9ozXT5TAWA1UxgwyG8MVJyMB/LDstaGrEOUi7BTcZ+Bp+L6J/l3?=
 =?us-ascii?Q?61PuIspyv2jZieWxUj0lG19B4BbmTU+VK8Hx059AefANvqOcKJ+bkqUchp45?=
 =?us-ascii?Q?UQjOqJrHXemhJ92BQtcaNr4Gn/0OyQF+/erzeO9jn7TSo/F3bmuyaXEPtXGY?=
 =?us-ascii?Q?+wItW9NtwcVekknKji5yQLLXgd2NTj3mspFGWDmYx7HeErREayNgAJUZHzHW?=
 =?us-ascii?Q?8/uu2p4IaqVdO704gqOfcjMF37c+ntNdfWl4wEUhUE6xSlSfL0H2HaqXWh/7?=
 =?us-ascii?Q?3ZkaQqCCdUQ/nBrDvRF5lQ88vMTI2PGK9+S4tIA4F0qA6jbKMFwG9X9OOPLo?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f9708c-521f-4f23-03ff-08dbdfe69848
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:29.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFUO9L0loQ9i+wYa8NR6REyRwCyvAetKzQ+YEBVEYNHAAHJ2OazdpNksMmfOtFimjKRq1xFZvtDKwCu56ffh/pfF2SbXXJduIV1DKHQus5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: 4pr5R9tqCFASHtB4-T7wZSrH4TcQ0TtP
X-Proofpoint-ORIG-GUID: 4pr5R9tqCFASHtB4-T7wZSrH4TcQ0TtP

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

All the uses here are in set-1 (some right after we give up the
lock, causing an explicit preemption check.)

We can remove all of them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org
Cc: linux-block@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 block/blk-cgroup.c |  2 --
 block/blk-lib.c    | 11 -----------
 block/blk-mq.c     |  3 ---
 block/blk-zoned.c  |  6 ------
 4 files changed, 22 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4a42ea2972ad..145c378367ec 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -597,7 +597,6 @@ static void blkg_destroy_all(struct gendisk *disk)
 		if (!(--count)) {
 			count = BLKG_DESTROY_BATCH_SIZE;
 			spin_unlock_irq(&q->queue_lock);
-			cond_resched();
 			goto restart;
 		}
 	}
@@ -1234,7 +1233,6 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 			 * need to rescheduling to avoid softlockup.
 			 */
 			spin_unlock_irq(&blkcg->lock);
-			cond_resched();
 			spin_lock_irq(&blkcg->lock);
 			continue;
 		}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..0bb118e9748b 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -69,14 +69,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
 		nr_sects -= req_sects;
-
-		/*
-		 * We can loop for a long time in here, if someone does
-		 * full device discards (like mkfs). Be nice and allow
-		 * us to schedule out to avoid softlocking if preempt
-		 * is disabled.
-		 */
-		cond_resched();
 	}
 
 	*biop = bio;
@@ -145,7 +137,6 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 			bio->bi_iter.bi_size = nr_sects << 9;
 			nr_sects = 0;
 		}
-		cond_resched();
 	}
 
 	*biop = bio;
@@ -189,7 +180,6 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 			if (bi_size < sz)
 				break;
 		}
-		cond_resched();
 	}
 
 	*biop = bio;
@@ -336,7 +326,6 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 			bio_put(bio);
 			break;
 		}
-		cond_resched();
 	}
 	blk_finish_plug(&plug);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..f45ee6a69700 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1372,7 +1372,6 @@ static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
 		blk_hctx_poll(rq->q, rq->mq_hctx, NULL, 0);
-		cond_resched();
 	} while (!completion_done(wait));
 }
 
@@ -4310,7 +4309,6 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		if (!__blk_mq_alloc_map_and_rqs(set, i))
 			goto out_unwind;
-		cond_resched();
 	}
 
 	return 0;
@@ -4425,7 +4423,6 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 				__blk_mq_free_map_and_rqs(set, i);
 			return -ENOMEM;
 		}
-		cond_resched();
 	}
 
 done:
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 619ee41a51cc..8005f55e22e5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -208,9 +208,6 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
 				   gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
-
-		/* This may take a while, so be nice to others */
-		cond_resched();
 	}
 
 	if (bio) {
@@ -293,9 +290,6 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		bio = blk_next_bio(bio, bdev, 0, op | REQ_SYNC, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
-
-		/* This may take a while, so be nice to others */
-		cond_resched();
 	}
 
 	ret = submit_bio_wait(bio);
-- 
2.31.1


