Return-Path: <cgroups+bounces-6215-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B03A148EE
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 05:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555B31686F6
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 04:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6131F667A;
	Fri, 17 Jan 2025 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C6nhazE+"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2083.outbound.protection.outlook.com [40.107.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A171F63C6;
	Fri, 17 Jan 2025 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088913; cv=fail; b=T3ckf0QqUiglrZhER7NscTko1A34KIUVmkpPrzzZitqtEndgIUNauzGnzRhsHOJH5no51Ev15Y3w5Dov6Dcul9Nuo+f2Z48bG5EjmOI0AyH1BmUeVknVlt1Pwh7QvXhIYdWzOrviBQQgZun5aP19+7QK0blKwGfPVzEG2E1BLeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088913; c=relaxed/simple;
	bh=DbQWrZ438J+lF5Pl48cwRo/kf4oUJbTJfThAJWPbfII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PT0aKa2nBjJma1wpqJMtpxOLdzEW+3X6RehYLIPFUFeQE9WoDPmSl7E2b660KvuuuF3COvCtNcCMqyOUiaPz2EemXMzQZad/d5tRB30UBCuYeEhvxw3gzWF3WYNb+gh4IqdtBKwyJDOcEWcFZXRyvA+7SdlSGy0bwzM9DF30m2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C6nhazE+; arc=fail smtp.client-ip=40.107.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUngBGMx9iBa/KZmQ+r3xkR7cNd1ffuTYhY4cN2zHnxEEiaJKGXlrwI/3a7RZcHjKHO8AE5IUYLOkhLBy7PJJPw81gB3U9ot7qOuFn4KZNhqNRQohoI6cpprFQaBjh0x5n92D6METbMxSVGnAiA6dqSMk9n0niWufdoDQHIKd1jbOu2Q6xlP16rh4Xg6tnbYoIBa+EDuMSmGAXJvS9PGtcbu7mH4VXyg522JMppvRrvlhOdUGuE+2FrF/3383RCoLQT+1YD0G9d4k06UXCq6U4mv5X463HelJOx2ZtqMNi/E+aojWxfmYSy3fO1yXBlcxpxP3x0eGe1k0Rw+FdHgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbQWrZ438J+lF5Pl48cwRo/kf4oUJbTJfThAJWPbfII=;
 b=H3dnfSxYrYYzrBUGxt+r+DCYj/1GlCjESVQOtOhwIODvCOsSV6lMK4een2ZLXWbZyGkzWkgYalZSOMNna/EV3C+g0Xg3W3chLNFDNMb/jmJzC0m5oAKsThSZCLgPnhB/x1pWVQ5/W4WT1slxYA75PttnSNCN6fmNR8XDCzFNnF9bld4BlTv19E3thUPezzAIjMsGX/Uje7Og2tnMtiM2ppbyRSdlsokpXV0Pcbo6rFSZ4DqBb6La2cxbo4srYq2lpBiYPG55hb3m0JvUfYcS3q3P2jMTy3UJHOwk5r9ph2spOBQIst4kOdQy2csmzKtodZSDRC/j1LaiztBO3FrHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbQWrZ438J+lF5Pl48cwRo/kf4oUJbTJfThAJWPbfII=;
 b=C6nhazE+q3oH5+sA7/lRN9GTiMnPE/exSZW4nh/Qt+lL/u3JK9lsdFxatP6jDbVPg+hpi8BcT9NL5m59o7xKBiZxMR8rPynlW1Cecs9/lxX6xH1VIIaGplMd84YVYoMthm7xOuio4MS7fRRLIeStYZvXkRKHI5HGWLp8L6mRXsbpOPwII5tOSttMoLxSEQq0vKD2QWfol4kxKCvhKrw6omzpmPHQvJAJpQMu/F7GcCmn6yaJ3UzPfrG8TZsa0czm0/iFGNq+/wqdldC7ogdJVxYjAg8fG7Fqj0B5kM40p0io/T4S90XnrMGYPJ0gWNlyDSds8w9gwZNkKOQDsRaNMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.6; Fri, 17 Jan
 2025 04:41:48 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 04:41:48 +0000
Message-ID: <a0c310ba-8a43-4f61-ba01-f0d385f1253e@vivo.com>
Date: Fri, 17 Jan 2025 12:41:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memcg supports freeing the specified zone's memory
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20250116142242.615-1-justinjiang@vivo.com>
 <Z4kZa0BLH6jexJf1@tiehlicka>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <Z4kZa0BLH6jexJf1@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PUZPR06MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: beb0481d-4841-4dfb-633d-08dd36b140fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RENaN1RrVnpmcUpqQXlrZkNNYVhqbW1jdHJoU0QwK0lWdDhvaHNsSTNwVmxH?=
 =?utf-8?B?b2Q4MjhuYU45cjdnVEpNbkJWSUpDTUZOZUU0Nkd4YmcxQlQ5M0o5dnRiQ080?=
 =?utf-8?B?S05NNVJIZVFReE1BOU9aelltSEdzbXExUVJmQzNwdmlnWEl0K0FDZ1BXd2Q4?=
 =?utf-8?B?OEI2YUIxTktLMTExdjlkd2tHWnErY0dBZWpkZDFHZ2FCNnBEVGdIbUZpSHA5?=
 =?utf-8?B?MU5yTkZ1TXJMMWdmSUozdkIrZEZuSjMxbjFheVlUckZmc2JZY1VFMytmWTVz?=
 =?utf-8?B?a05kZGJrdjVMS0VNRlBGbHVFNlIzelZRNGVMNHF3Q1JoR1JqMEFNNzVKd2hw?=
 =?utf-8?B?Z0FBNkFiN0ZXYXlHY3Z2L2ZySTUxQ1d4Q2I0aVhwWUdPWnBpR21pOW9aVUVN?=
 =?utf-8?B?di9DemlyUVNCd3QvYks3NExrTGl3bVpPRXVuU0N0R1ZRd1BlVmNCMm9pVFl3?=
 =?utf-8?B?NnlLbGJLWm9RQVZiV1FybzJnUFlTaVBiejRpOEhmdnF2Wkl6anJwY01BRnRU?=
 =?utf-8?B?K3I3QTFSczFCUk81TTRZM3FJQkFJUDAvQjFneVhKREZaWTkwYkVUNXZtc3pF?=
 =?utf-8?B?VUdwbkx1dmJ0Rys3MTJKc2R5Y2taQ05UNzh6RXBFejBFclhxKy9kdkR2WU5x?=
 =?utf-8?B?d2RxTU80SWd2TTV5QmhoUWQ1b1JURitYRVhmQnRqeWZ3UFVMTHpUWlhtby9o?=
 =?utf-8?B?WVI1T01oNS9hSkRXcFdydFMvcE5xZXpMWHB2RWZSTFAwczNNR2lGWHFMczZM?=
 =?utf-8?B?Y0lqMkFEemJsWGNOQ2ZWSGVVRDdwWXFxZU9KVXBGRkRVU2ErbVNIY1laWVZm?=
 =?utf-8?B?REl2ZDlOaFJhZVozZmtjYVNNcVEzdVQxdWtPTTVNeFZZVUJqNVBncGlhVHNC?=
 =?utf-8?B?TGRydFg0MGhIckdqQlRQZ2xEOUFteG1jZ2F2SzR0bW13YjVuNXVqNEFXb2Fv?=
 =?utf-8?B?YVpDcE9vcGM0WWc1aGNjZVNsUVdtM2lzRnB6bXVrbDZJZk5TU2kySFlZTDh3?=
 =?utf-8?B?RHB5WUF5bVFlcll2S3cxYnRyNWkvQm13b2pvTERsVGZ4YUpLVGRVZkF3S2Jh?=
 =?utf-8?B?WmtPdU96cGJWeXloNmErMzJrTmNwVmoyeFN4aUdEYzV4VldiaUxxSGZwSFpx?=
 =?utf-8?B?Y05aVGpZSXZMNzd2bzBTMlZMR0xZRHY2bWNFbWNtNVVFV3Zad1YxL0hiQ2xB?=
 =?utf-8?B?aHRYSXE1WkdDcHNMYkQ3MWpnbDN1a3VsaWRYaytYdEp4cHMwQlQwSlZ0bGYv?=
 =?utf-8?B?KzZxQmtldWxwais1NlJJVFoyS0pDMGRxY3dkbkdFUUVtQVJRQy9XaTVtTGFO?=
 =?utf-8?B?cUFNVzhzM25hN0g5cy96aUZGcktqdTF5cUVVL2RqOE5pSkFoVm9iRDI3Zjcw?=
 =?utf-8?B?YzhlaEtsSWNZL0xOcndDUVJqekFQcmEzYjgvSWNZM1NMKy9zMmM0S0hFQ1RL?=
 =?utf-8?B?V0gzWWxpdmRFNDZsOTF0ZWhEZlZ2empIeFZGKzBHbjBOd0lGLzZuRTI2Qi9K?=
 =?utf-8?B?VjJ1YmprYkQwNm9mUXRId0VRa2Rheit6VDBkZTRVNFh1SGNIT1p6d3VIdWlG?=
 =?utf-8?B?TGVWa2JrZGtWUXFsd0g3TnVYd3BKL0ZmSjB1b015S0FqbE03dUtRbzYrUlFt?=
 =?utf-8?B?WjgvQ2FzY25HbGZNR25xa3VSSERiNGpqcnMrK0VobUtiQkQyNWN1Z0xmMTZp?=
 =?utf-8?B?L01VS1crWERzSkMwK1IzMnFJWVFjTWt6TndZWU44enQwZXJPWFVRYkxpc1JU?=
 =?utf-8?B?NUVaelF4Y0lmQXBkMGpoNHVMbVZGekJsenQ5U0RKMFlERHN1M2RXNHdtUkEw?=
 =?utf-8?B?SnV6dDUwZFFWek1GWjZvS3JYWXJ2bGpua1BxNDVqZnNtTWkzdXV1czc4cXJr?=
 =?utf-8?B?T24xdVJFT21wVlpCR0x5Tnp2aXpLQWU4ekgrTjRmZklSWFBHQ2dZOXRzOElR?=
 =?utf-8?Q?mC+tP/1m1P79/yrxV/WTGfQ6+2SMwNpO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlV4T0FmTjlKbnppYU1XQmhXSnZKQ05GeE8zYWt4NkIxWW1zdkxWa1MzRS85?=
 =?utf-8?B?ZEhpUk9HOEdISEIzMmcwZDBMcEovTE9OZDlyTmsrcm9SYnVOejFEaWd4aGxX?=
 =?utf-8?B?SVZJdCtTcE9VTkV4dnVacU9MR0RudlNHL3dqVW9wTjJhc09JRHVqTkhyclA3?=
 =?utf-8?B?S0x6QUczOE5TdE9XNGpVQ3RVV1RRUEdsbVFxdExnTjRwRnpMaXg3OEs1Zmxq?=
 =?utf-8?B?MFpha1lucXEvTE54TVp4S09HN05VbGFRek55MGFjRTU0SkZxdlhQMjlSdlpj?=
 =?utf-8?B?OXd5bVB6Zkw1RTVaM0Y2S2ozWkZ6QVcvM2FDYnVkRTFnRExGRWpvdkFGUDlQ?=
 =?utf-8?B?c29GZGJrRGZ4RkFkdmRkeThlbVZxdkVpUEhOU3NxdE5FaHZxaTMwUHdLV2RP?=
 =?utf-8?B?TFI4ZkhnNGY5RjFkK0kzNCs3RXhHNUxVb3pYcXJnZlY3UndiblEyNU44a3ND?=
 =?utf-8?B?S2ZibEhFRjN4QWRQekNwdVFzblAwWXBCcExNbWd6RHhOK01pV1EyRVBwZmZj?=
 =?utf-8?B?dGRNYzhWUlZFL0JINDNzRkU1TzR6MmhQMmwzWnFUQThJdE9aVWppZURLdTZi?=
 =?utf-8?B?VThnaGF3bFJoakFKWjlWTEpZUlcwQnFlUWloTWhnQ2V3MnNBMGpRYjd0cWVO?=
 =?utf-8?B?bzNHWjJ6dXU1SXBleE1GbWNXWjdGVFhwdjFjNzJYcTllRkt2b1JsakJTSE5E?=
 =?utf-8?B?dlJMUlpoT1ZJdnY1NUd2ZkUweC9WRDZXZXFWMG1JK0JhakxCdDN4YzZsYXdF?=
 =?utf-8?B?MjhhYUovcXpBc0ZXZWJrRjZSdFBGTHhHRzZPVDRoeTM5bUZOdHNzdmxUam5a?=
 =?utf-8?B?cUtOR0tCbTR0QW9LeWRndnRRdTYvbzg2S201REl3WjZkY01vSUhuWkRVUU9T?=
 =?utf-8?B?V2Q4elBjZGIzaHlqaXlpK3pSbzBGSlZWM3VaYlJqU0xCYTA3bFczVVZKdFNI?=
 =?utf-8?B?aTk0aTJDSThuUnc1dlZWeDRHOUFCTWx5anVwN3BzMVNGZzJXR2V0d2ZFWXR0?=
 =?utf-8?B?djJkYi9HZFl1YVVzMGhlYmNOeGZnaVFPZ0pJYWd5dnZVcFBlSVBQN0dPTWIz?=
 =?utf-8?B?Vk9KQ3lZeHp3UnEzY2ZyckhCYTBsUFpaSHB0Vy9BR282N0IwOG80RWdFZURR?=
 =?utf-8?B?Zk0ycVVQbHRjeWNKelRvK0dMUHg5eDN4UUtETG9Lb2NPRWZqeUQvcmJLZERq?=
 =?utf-8?B?TzRXblEyVzIveDh4cmU4OW1qYlpKWjg0RGY4WmoxdnB6U1JLdHJkWFZPUDdR?=
 =?utf-8?B?bjZoeE5XUnRFUVhFS1BKaWxPdytGc0ZJWjJEZzhJelBHOGd1NUJmaEoxMHdR?=
 =?utf-8?B?R0ZqMDdNQjVlRE1KZ1FBV055ZWVEbnZnR29kbEk1andBRVFFQjNuZms5TGN2?=
 =?utf-8?B?a0p0bE05VTE1MXMyb2VQd2dUdHpCUS9ETEd0a2pSVGpmY0lNOTVPWGcrMjdK?=
 =?utf-8?B?TWRaYXRDcm9aNVpnYWtEYXlFaEVHd2hNRCtBYVRuNDRDRklONVV2RlpjS29o?=
 =?utf-8?B?SitCQ1BsbXdXQi9LaHZ0ZW03dThQVE9wbWthTjc5ZUtXQy9reE9LcDNud0hI?=
 =?utf-8?B?cmhUcGg5anlJRU1nQzBwVzhBUTVMYzlBb3o3VVd0M2lNQWZQdlFMYnRicHpM?=
 =?utf-8?B?ZXB0eUh4elZCTVZEKzRxbTFBRElDUWxON0JPcGg5a2JZaUJ4bnBkLzQyZjIw?=
 =?utf-8?B?SGkwQzJNUmEwT2JiZEt6Y2s2a0dYbVgvdk5PSklDSXB6L0FJVHNwLzZpYStQ?=
 =?utf-8?B?aCtpUE92ZDRjSVY2dS9qU0lhOU1wdlo1YlZQSEpkTWtqR09xYTlEOGlHeEZl?=
 =?utf-8?B?cVkzZFRqV3VsRCttQkZRaGlGTjNqMVhzUHpXdlRGcjhidkc3ZisvUzZZa1JQ?=
 =?utf-8?B?akhVNEg0ejE0aWowS2I1UnFxTG94bTV5K1J1V3BxN01wZFpRbVNxYjg3NTFi?=
 =?utf-8?B?bWhxam9JYTM1dW9PRnlzR0FuWEEwRkRoSWg4QllmaGVYa29zZnJNK0phODFL?=
 =?utf-8?B?aTQwR2VxUDRGSEZBcFVZQWk1MkVHS1BFekI5UkJOaUoyQnVCTE1jQXh2TXRW?=
 =?utf-8?B?THY5K3QrKzhPTVF5Z05DSzNiSFRNMWJ4VlIzNGZnemFjN1NXbGNrQ0FBckxy?=
 =?utf-8?Q?db3dsZ5AaL43CYuuo+QuGq6tt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb0481d-4841-4dfb-633d-08dd36b140fc
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 04:41:48.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KayqzZs0Thf1Rj5//B9JaJeCJYa3qsiGuuG13DXVp8O6SIPelf8DnbILqF+CHLaqPBqZhWm1eadWX5Z15uVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055



在 2025/1/16 22:36, Michal Hocko 写道:
> On Thu 16-01-25 22:22:42, Zhiguo Jiang wrote:
>> Currently, the try_to_free_mem_cgroup_pages interface releases the
>> memory occupied by the memcg, which defaults to all zones in the system.
>> However, for multi zone systems, such as when there are both movable zone
>> and normal zone, it is not possible to release memory that is only in
>> the normal zone.
>>
>> This patch is used to implement the try_to_free_mem_cgroup_pages interface
>> to support for releasing the specified zone's memory occupied by the
>> memcg in a multi zone systems, in order to optimize the memory usage of
>> multiple zones.
> Could you elaborate more on the actual usecase please? Who is going to
> control which zone to reclaim from, how and why?
Hi Michal Hocko,

Thanks for your comments.

In the memory allocation process, it can be known that the application
gfp flags determine which zones it can only alloc memory from.
__alloc_frozen_pages_noprof
   --> prepare_alloc_pages
       --> ac->highest_zoneidx = gfp_zone(gfp_mask);

The order of allocation from zones is as follows:
MOVABLE=>HIGHMEM=>NORMAL=>DMA32=>DMA.

For example, in a dual zone system with both movable and normal zones,
according to the GFP_ZONE_TABLE table, it can be known that which zone
can different gfp flags alloc memory from, as follows:

*       GFP_ZONE_TABLE
*       bit       result
*       =================
*       0x0    => NORMAL
*       0x1    => DMA or NORMAL
*       0x2    => HIGHMEM or NORMAL
*       0x3    => BAD (DMA+HIGHMEM)
*       0x4    => DMA32 or NORMAL
*       0x5    => BAD (DMA+DMA32)
*       0x6    => BAD (HIGHMEM+DMA32)
*       0x7    => BAD (HIGHMEM+DMA32+DMA)
*       0x8    => NORMAL (MOVABLE+0)
*       0x9    => DMA or NORMAL (MOVABLE+DMA)
*       0xa    => MOVABLE (Movable is valid only if HIGHMEM is set too)
*       0xb    => BAD (MOVABLE+HIGHMEM+DMA)
*       0xc    => DMA32 or NORMAL (MOVABLE+DMA32)
*       0xd    => BAD (MOVABLE+DMA32+DMA)
*       0xe    => BAD (MOVABLE+DMA32+HIGHMEM)
*       0xf    => BAD (MOVABLE+DMA32+HIGHMEM+DMA)

The gfps containing __GFP_MOVABLE | __GFP_HIGHMEM can alloc from both
the movable zone and the normal zone, while other gfp flags such as
GFP_KERNEL can only alloc from the normal zone, even if there is very
little free memory in the normal zone and a lot of memory in the movable
zone in the current system.

In response to the above situation, we need reclaim only the normal
zone's memory occupied by memcg by try_to_free_mem_cgroup_pages(), in
order to solve the issues of the gfp flags allocations and failure due
to gfp flags limited only to alloc memory from the normal zone. At this
point, if the memcg memory reclaimed by try_to_free_mem_cgroup_pages()
mainly comes from the movable zone, which cannot solve such problems.

In try_to_free_mem_cgroup_pages(), the sc.reclaim_idx will determine
which zones the memcg's memory are reclaimed from. The current
sc.reclaim_idx is fixed to MAX_NR_ZONES - 1, which means memcg is
fixed to reclaim all the zones's memory occupied by it.

Thanks
>


