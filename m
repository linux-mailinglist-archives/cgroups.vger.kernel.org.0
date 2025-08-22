Return-Path: <cgroups+bounces-9339-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA0B322E1
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 21:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925B81D6424C
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 19:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7CE227E83;
	Fri, 22 Aug 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="TLVe8mL3"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65034A1A
	for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891127; cv=fail; b=pAB9oKULOBj26ytjWf8tpN36HctxdRT5heepmOKUylbTa1kblnpW8/co4joP8FPJtEM7PoARJ6uYWc/868TF59hM72ZaX9pDJtwXD6Mbj/WSnV3LOsmpbi9yMQMReryS3AbDCQAo9TkM8bHmUezrPOr2WPkWK6gKGHTAS/1eZAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891127; c=relaxed/simple;
	bh=NTtCAVnFsg1WLMtSl2hwtdcPfZ6HvYwuVJdWozK1CaI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=iT3C5/k5rmD8OZET/IZluFgQRc+6XOQdlhR/EjoOQOCjMj/VeluuelOtoMDqN3QUbqpn0uYbaS1blbF8NBJkMmcI80GR8su9NYKTUwZ6ZmNa2eszl+Y3jqADUs1TFod2P3qn7ebV1jI1U+LPBWCAhpPQz+pDX/IVyHXPGwgC23E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=TLVe8mL3; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57MHrj7S1205317;
	Fri, 22 Aug 2025 19:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=uwkqQTMbs1MhjC/kS4b3
	dA4BzH3mC8xknT+gWCoLAGg=; b=TLVe8mL3KUL70roQuwyJ9JlJEpA9bzxyY/1n
	pzwIzr7LIrvopbj9efxS11N6SLPnhiBK7lW0lyp9y81PWJ1MD4QPUuarh2siT5gf
	jiRhTlA87ptUAHO0AyNEWrMKd2EwpSTRFS7Dixxg5x8VxXv2EYD77dQ/W5Wv4zPv
	D3xopMOmKqZMK3FtLj7FB5gLYDi96qRx0e7zLiXxYD3DgR3/3DNBYRKQHD8OeK9W
	DoZqB34tl9BJg29Xb+O0FD+ABZlj30eAs2AuOIS2T1AuStiCUwFST1nlvUOX9n1L
	yHaqeFfp4UOHBwzQ+3/zcMB832y2Q+bUkFZ1RlgfLCaiXpYZHA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48pwbq8377-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 19:31:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfpW1osIyBTEjuCSiYjFhcG0dzliMZjFV0Avi/dS0XwzrXJrznv2qQm2axN/6nWVIaBqcwe/8agLsi/A8tjbm/OxZy5YJzdfM3XC4lbCaf9Dnd+HyFNvnMXHvu6uXwoFrbU//IGBZ/swr8lAFvQFnIjpXvglTTrk9jsF0EiHQBOG3rwxHPs/bhVCt7+wZ/syzY1ompJJzOlA4mx4Mld0B5hgLsbZI4nW3JcAVgw4nfggx6Mmex8EfCHlovJ2o+bmmJ1Z0G/RkZ8flRF6QHxf77E5e58BOIr0yJsSWaNJs5rfVfUsuKRONKFfcfEsg/8HbdTy7caasUXtJQ9PnH3C9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwkqQTMbs1MhjC/kS4b3dA4BzH3mC8xknT+gWCoLAGg=;
 b=x51SwzQgotOqfL69BOBdEBWIDHxZ/I33pmv3/JvK9PJ7axZmn4O76eCWw0jPz5UFHFKuyPLJ+nw58+ZshvDG2WvTtIJyaFFBYm9XGiPzyI+s22mVSHbu06vj0VmPTxzFKxcYCi0W3RCX54IZc7kYlVSjw8GOJC+c+xwPxLVBl0ifVLZGi1OpmS6lojvVjly02Eq8rxefZzTh6117AbeVmCYGmgCYergUxbXo89om4oFThBV1Xdiu/LkgWQM8cweelxsBAcExIz90d/Vr2i+luBm4BeScnnhyAYBznEk+W8yiMXUmRoz4p7BzULnlcSi2wWBzoARNDJUJTGf1ORiyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by IA3PR11MB9135.namprd11.prod.outlook.com (2603:10b6:208:579::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 19:31:51 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%7]) with mapi id 15.20.9052.017; Fri, 22 Aug 2025
 19:31:51 +0000
Message-ID: <f5a182a3-ca68-4917-b232-721445fbc928@windriver.com>
Date: Fri, 22 Aug 2025 13:31:38 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cgroups@vger.kernel.org, lizefan@huawei.com
From: Chris Friesen <chris.friesen@windriver.com>
Subject: unexpected behaviour of cgroups v1 on 6.12 kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:408:c0::34) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|IA3PR11MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3560d875-24be-4a91-6182-08dde1b28ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZCs2dkIxT2pLZzhsOFpyYjcrRWhWUWpWZWl1NldIUzJBckx0c0pZYWNsWW53?=
 =?utf-8?B?U3ZQaDhBck51OU5qWTJxbTk0R2s0UzdLWFJGZ0xJWnJjUWNZSTd2Z3YxVkRn?=
 =?utf-8?B?b095Z0I2U1VIYmdHQjRsVnFwc2x3V2FzL0dzSllIa043dW1IbUJWOTdOeXFR?=
 =?utf-8?B?MEF0L3FPODBuWEZzcG9nbjBxVnRXaEJzaCtTb2xaWjZwWWduT0RIQjJiNThj?=
 =?utf-8?B?TnZMRzc5eHdmSmxMTXVEZm1pWU9nSUNUbnB3ZzltL3lmMTI2VzBhSG5nME95?=
 =?utf-8?B?NTlNYktDVXRJdXZYSHlYSzFzdTBHZzUyV2xqSjdxdEZtZDg5bFhuVVk5UjNE?=
 =?utf-8?B?VkZuOSs2WGtWYkZvaEhKbnBZZFExWjJ0b0JUN3hEWWE0RndRQXpCQVk3bzVx?=
 =?utf-8?B?NDVjUm9vMTVReHpTMzQwWnAvUUpBRnJ6cFlIRW43UWtQdHBLVHYxYzd4SUpY?=
 =?utf-8?B?SkVxMEMyb3RkYmgrVzFLdzY5NXZvQUNXbWZycHpuV1YzZDZLWHdlclpEekM2?=
 =?utf-8?B?NWxwUk5NVDNFMXQranBpTGlLWk5yY0Zya1VERG13eW4zTjl3THY0dDFQS0xm?=
 =?utf-8?B?dWVLL3VwK251QXdoTnN4QjU5aUZFYTlxSWp4WGpWUWRHZ1BLd0ZFT1crcnhE?=
 =?utf-8?B?OVdxc0RoUnF0UjJtbWFaZ2p1R3ZtZXdVNUlFZ1FIdUg2aSt4WmY5eW91bHB2?=
 =?utf-8?B?bHVYaTFWZEREK2V1emVVVXdWM3lqc0ZnYytwWnBURThSdEE3L2IwYWJ5VG80?=
 =?utf-8?B?ZmZqU09NK3VWYlhqSS8wWUFMMU9JVkcwSXBmRlBteW1hemc0VkNhaC9VMjVm?=
 =?utf-8?B?QXBPdlFkZ3AvRGpCUDZjRitNcFI2VE9aZ25wTmR6SEFsakVpUDBQWXJGRXlt?=
 =?utf-8?B?WGdiQmlRZUFUYjgyQjBMRVRQNjhzS2FXNlFyMFJYOWhySkpJM3AyUkl3Wlk4?=
 =?utf-8?B?cGlJWnJ0QWlMeXJ0SVhNKzhRZWJTblNaZWJtRmNRUHFrNGE5V1Vra055bWk1?=
 =?utf-8?B?L3N1R2ZWbFJUN3NWNk5BbEVJbi8vTUFPd2ZmSTF1d0FjMm9HTVlSVFRoS2p3?=
 =?utf-8?B?ekwwTW1ZVjVCalNmWUFweCt5eVFvU3o4d0RmMC9QMEM5ZTE2N2k2citXRE4z?=
 =?utf-8?B?Mm93aGVNdGQ3ZDVQRER6ei9BU2dNWHBUNXlpekFSMTFIZSt1UGV3VGxncGFT?=
 =?utf-8?B?dEEyK0pFd2drM0d4aCtaYWlDSm8zRm9zTmVaVjQrUGhpcWxLa3EvNWdDYkJH?=
 =?utf-8?B?cXEzbUxpdDNNU3lzcFh4eHdzQmV1Yml1bW9ZelpUT294ek5tV3N6THhvT2J0?=
 =?utf-8?B?bVBUU1VGL3c4SW9uSlNKclZZR3JNam5yTTFIZFQrS05jU1N5MnlvZ2wzSURD?=
 =?utf-8?B?MjR5VCtHZTA1WmcvR1dCakwvaDd0Ujh5ZHFnVmc0aDFhWmZaMStnQ3hZazJH?=
 =?utf-8?B?K015eUhuZGZxS2lXckw1di9DTmZkaTRON0dKU21QTXpCQnk5c2NhQUNUVnFP?=
 =?utf-8?B?R3BVTXJ5ckIxRE0rL1JBWk40bllNS1NhNGZiL0EwZGp3RnNHOFZldFdncTlY?=
 =?utf-8?B?dDNPNlFSQ0V2RXlxS0d1Sk1IdjFpaXlPTUozRS85TDhSeHU4a2RGamFPNXNS?=
 =?utf-8?B?TkIyTEg5WEFaT0pKSnBUQ3p2c21NaVRsc3RmcWhhYXFET0h2TWZBNzFIMHBW?=
 =?utf-8?B?N2I0eWRMWm9Iakl0aGFjNExndFVTbWxYZEl4UXBnZE9iVVRPakFwV1VWZW00?=
 =?utf-8?B?enU2bVNhNFBnSkwxWDVhV2ZUTStpOU1zMVBrRVdwWXBIYnhqcE9xOWxFNzM2?=
 =?utf-8?B?bW85ZVdxM1VGVzM2OVZQRm4yaHlHNE45SHFTZW1McDBNUCtVVlVzN2paYXJz?=
 =?utf-8?B?RFYzZ0lLT29TTEkyK0hIU01CKzhIN2lPd25BQTZmbjNMeVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnE5YnZPTG04dFc0YUUrZUkvUFNhY3FnU2kwVmcwUWt6QWVXU2ZwVVBzS1BT?=
 =?utf-8?B?MFhRdVkzZFdtZFBwcDlkeHNTek0veTk4VUNaVG5aOWtnY1JydXA3Zm1pRzJo?=
 =?utf-8?B?VW9KMG1DSDhnVUJ0Wm44SHN5RE9tbjVLN0UxcVRjdHZyb3ZyNE5PWkZIZ0J3?=
 =?utf-8?B?anl3Ny9EMjJXeDVhOUNIRFI5dnV4RmgvYmVkVXVIbjZ6T1JvVUo1bFM2amRp?=
 =?utf-8?B?QzlNUVpPYzdZZ1VhVzA3cjR6aE9UWEIxV2ptcUl3eEpLdG5sTTdnR1RZWkFp?=
 =?utf-8?B?SGdRSVQ3bnk4K2FUS1pEaXN0c0M5Q1pLSkNYNHVBOGIzNlMrSlc2OXJ1Rzl4?=
 =?utf-8?B?eGowUkJpSHNGMjR5YUd1elMwa2RoUjB5RVRqdDQ1NWJFVEcvNkpJbkJkdHFm?=
 =?utf-8?B?WTdpbVJuUG1NeENlRUZVYmptZkN6eGhvQzN1Ym5sN0JjQWFFWkRjblBLTHox?=
 =?utf-8?B?TE1rL1hpeDcvRWxJTUFBREJCSEdDUWR6eEhDNzA3Q0JSZHhCSU1TejUxVTl4?=
 =?utf-8?B?TGhZTFZkNG1lOU1kdHRMOHYwQ2ZXMWNVUHZ0cVdoL1I1azY0VC95d2g5bnVN?=
 =?utf-8?B?Q1d1cHZnWkwxQnpKT3dCTUYrcEpXSDJEYndhTVkwZUNDT3hQT1ljcWg1Q0tZ?=
 =?utf-8?B?aEFyd3g0UGJOQnF5THZ6cW5kaWRqakdyL2hLWWp2SWErM2VsMUdhOTFXM3Vs?=
 =?utf-8?B?d2UzZWI2c3hzTWwwVXNYemFWb0JEamhGRzVUM0h6RjNZMUd6elFqbHBnclkx?=
 =?utf-8?B?WUw5TDRjalh4MktTTjRFczFhOHF5ZFpjR09tVG93TWRKb0NGSGlJdTRodFRR?=
 =?utf-8?B?cjZWbENrQjRUZkp4eHkrUlFscHN4Q0hZNWxqSml1Y2RsTldwNUVNbHA5ZUhq?=
 =?utf-8?B?TlRuRm5nN0dkWEYvV1QwOXRwbG9OUG1UOG13M0ZwYVQyRU9GUDl2UDZFVWE2?=
 =?utf-8?B?TEpOMFZRcmFXWHlML1FhWXpSMVRyQ1RBSmxQdzM4UVl2NCswanZuZ21YdzBu?=
 =?utf-8?B?ekJxVFBvNk1jUVBvZ0RoOUZ2YW5wcEVFc2pjNkpJaDdySmpQWUEzK2gxTENU?=
 =?utf-8?B?NFhySXdJdXIrS1M1a3IxL2h5ZmR5dlpCRDUwbWVnWllqVEhRbVJUUUVGRWFW?=
 =?utf-8?B?VE1VSFd6bW5zeDVDNUUxVno5MFEyVSs3T0hpVTQwVjFNVE9CczZJeDF3bWVy?=
 =?utf-8?B?cDIxcDRadFAwY2dOZkxEejd2dWxldzVsa0d0SHgrRllkTTFMWDhrNm4vRmx3?=
 =?utf-8?B?dURJUXM4QkI0NTAveTY3dVBzOC9FSUpVMWkwRksxNnRNTzFnMzhJMm8wQzdX?=
 =?utf-8?B?R0plNUxNZExxdWFXV3FzTlpWdzhQWkh1UVBhUGg0NS9Nd00vNGlQUDV6TWVR?=
 =?utf-8?B?LzhYUjZaM0Z5aUQ0RTJqQWlPNDlzZzRzcFdqWTZZOFR0V3YxUnc3WjJjdzE3?=
 =?utf-8?B?K3d2aXNFblpRUWxQOWExWHRYN21wblozM1JOejREQXFPUk5qVzlWSkhUVVpZ?=
 =?utf-8?B?VmxadFhmbzdsSzBKWHdQVkNOeHh3S0xZWXhVbmprank2bStvZC82RTNEV1NJ?=
 =?utf-8?B?TzZUaEZaYjVvQXJ3N0VRQWo0NXprME9MTVh5QXNFbVU1QmFvN1lyWGxlZWUz?=
 =?utf-8?B?SUJhYmpZemFRdVIwVGh4aDVtZmFGa1FZRGFyZERrdmM3eFNtcXVXV0FxS1pW?=
 =?utf-8?B?Y1BHT0MwRzA3NzMrMEpsd1N4bUFQM1drL0phYWhxelBPYkdDQXRYOFNtckw5?=
 =?utf-8?B?NkNDZnlGVFhwTVRJcE96SmhUci91WDdCS1ZrcFRiaFNTLzg1K3QxSnM2cWRl?=
 =?utf-8?B?d1ExNkdwcS9Xb0lFbzI0MmNkRXpYTkU2djU1WGxKa0dOVTFqOTJJS3Z5WTdJ?=
 =?utf-8?B?ek0vMGcyYitzeEVMWFU0SUtJNjdlV1h3QXl2ZlZvWlRydmpxVkE3dGFkREsr?=
 =?utf-8?B?M0xoek5JVHdUajRYeFNLSUsxLzRwR2twaG90SE5lR1BDaExHU2lzTHliSHpw?=
 =?utf-8?B?bkEyWERxT2FleXQva21TUGhFdnJ5SHJsSHhKWXVVbk9PejIzVzY0a29GS3Z1?=
 =?utf-8?B?a2hXd3FvVVRSSkNNL0E3UnF5bC9semVkQ3BqN3l6eHRON2VEa2htZWJQQXVT?=
 =?utf-8?B?clovbGUxMEM3dXo1ZThjNnMzdFozT0JLYSt4Qmh6WVZla0JSTG9qMVJhUE82?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3560d875-24be-4a91-6182-08dde1b28ad2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:31:50.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqmAVK7o3FE7PcT+XQWVSsOk2lYFE43dbpF3GvFqQo3v31QNsuScSC1NLtu7pjVv3e2sqM21wEtkr3RuC/tx2Q2WhU521xPfD4momNCfBJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9135
X-Proofpoint-GUID: BPSsgHhcKBZkl0RGbwf8e7el80ZAwaBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE4MCBTYWx0ZWRfX2p4nLwRsvJ+C
 HiILBnsyRlP5i2BXxw4evj0PuWyieFHuyvoD/7U8i+cCOprToVTH+CvP+RoecNsE8YHzK4wPEW6
 zB4kPQYSKHninnKpnC3yDe1mSwpiG9levqWUZDV4s2FAaV40xUP9RdPpbMMx9co2Y83DNkYq1rg
 Cz7XwT5/1BBY60CsyzRg9AOsgsNRvhjxnM30yyIuXqAVMWjEPBhO8JJHdcegt+86WM78ITZtOlH
 rwubCUO6o8gqOvZwG+6KR9b7HeLduUZQJOheLaGFS3uUAlhpvZZXzlKS9rD/M+7dVYxVEujyyiy
 5kaptRittNuIHnqqk4TBj+dIfpKLHv/G4IPX0X8wz/hp1s/JBwQE3TladPm+Ak=
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68a8c5ab cx=c_pps
 a=d7fC0nPIUhrsivT49B8+Lg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=LvXSodZD071QKT2TqHcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BPSsgHhcKBZkl0RGbwf8e7el80ZAwaBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Hi all,

I'm not subscribed to the list, so please CC me on replies.

I'm seeing some unexpected behaviour with the cpu/cpuset cgroups 
controllers (with cgroups v1) on 6.12.18 with PREEMPT_RT enabled.

I set up the following cgroup hierarchy for both cpu and cpuset cgroups:

foo:   cpu 15, shares 1024
foo/a: cpu 15, shares 1024

bar:   cpu 15-19, shares 1024
bar/a: cpu 15, shares 1024
bar/b: cpu 16, shares 1024
bar/c: cpu 17, shares 1024
bar/d: cpu 18, shares 1024
bar/e: cpu 19, shares 1024

I then ran a single cpu hog in each of the leaf-node cgroups in the 
default SCHED_OTHER class.

As expected, the tasks in bar/b, bar/c, bar/d, and bar/e each got 100% 
of their CPU.  What I didn't expect was that the task running in foo/a 
got 83.3%, while the task in bar/a got 16.7%.  Is this expected?

I guess what I'm asking here is whether the cgroups CPU share 
calculation is supposed to be performed separately per CPU, or whether 
it's global but somehow scaled by the number of CPUs that the cgroup is 
runnable on, so that the total CPU time of group "bar" is expected to be 
5x the total CPU time of group "foo".

I then killed all the tasks in bar/b, bar/c, bar/d, and bar/e.  The 
tasks in foo/a and bar/a continued for a while at 83/16, then moved to 
80/20, and only about 75 seconds later finally moved to 50/50.    Is 
this long time to "rebalance" expected?  If so, can this time be 
modified by the admin user at runtime or is it inherent in the code?

As further data, if I have tasks in foo/a, bar/a, bar/b, bar/c then 
foo/a gets 75%, bar/a gets 25%, bar/b and bar/c both get 100%.

If I have tasks in foo/a, bar/a, bar/b then foo/a gets 66%, bar/a gets 
33%, bar/b gets 100%.  (But it started out with foo/a getting 75% and 
switched 10s of seconds later, which seems odd.)

Thanks,
Chris

