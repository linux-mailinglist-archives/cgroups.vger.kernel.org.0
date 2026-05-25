Return-Path: <cgroups+bounces-16233-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 932jDfqSE2q+DgcAu9opvQ
	(envelope-from <cgroups+bounces-16233-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 02:08:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F5C5C4FCF
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 02:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9B183008292
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 00:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E32524F;
	Mon, 25 May 2026 00:08:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022105.outbound.protection.outlook.com [52.101.101.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B8632;
	Mon, 25 May 2026 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667700; cv=fail; b=c3M638rltih+o+7u8nbhLWyOcKMBVPCu09/nNxmhiO19oOAbbOUhLxOpdCpDpqaGXZ4P+FazAoByT/NedCUm54MoeKwc0ZMdLfZmfUaGfTjVykjWNVp/eNrzxztDIKUokesOPrBVLokbAPlQn66wviVbzVLrpx1rSJIIDhzNHM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667700; c=relaxed/simple;
	bh=Ck9z+IwIKKpoRhUEBKYM+8dg2hRNn5gfuzJp1hfl8Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJPZJsn4E0XWVQnWd5DDu1J7zJzKpFHquHuLIfq2NnQHwNW/eQNWNg9SLDkN3AB+0rqD0+g+pvUE8nwtQxahYG1SMGXZVfEGT8zOxPOwh4cSH6Vw3VZZvVez9TLubkP57VAeA0J5dLk7djlqlN81M4YoDu4pL4oC/xmf7LnWKNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSTOvp+F9LY6UJY7LOyKAz/S+OXTJxaZukLV1lAzLujJt+oVoVyvvtwhdhX6IvFusVGizsFd4dl4dBev4GJUN1fMJ/BidXK+smPac36M3SSn7se/3DVSWrOACjlrIYGlSgNlpgJ3aBQkF/s8+Zo2ftQwXLOw7HzudLgYOCbdrJAHXldoxpJx7RJteq91VxUKqhSEabIpk7/S8S++g5DDCYGwvkwT9eI3RX+jpo7/UbWoOxndH/tRsG2IUbfzoCpXENqJHfPSzwXtxxpr/SMtx2Mn21PunLFSYg43xyBd50werxiqgQbyMfbvfVOuvzjGWpgS7aBgZdsvRc63hI8qzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U91hqdHvtuQCKkRjKMSpPFIXF0SCBq5m/ay8vl/Pgsw=;
 b=AYFugpwPl+/v11CNg5uKDXvWLG6WkWDj7BS8EgxnMQVXHZL7ym1GXbTA66wLs604IFEU7aaZR3KXRJ1pHzRiERTunE2RD4WEgq42CWXdj63LJ/Pf7jVBJI9rVN04mY/qkmVOVDxnrRYtiWrwUTn/xOFcgSu3sj+ybu1Z0zmkvE3gJbliV1p0LZ8lT7ARtTbMqUWEnoLBm0lg3IYtvUgD3bVeEmXfo12g5ZI94ZYg7qABk5umI+EI7wbfU8CPtPUSYhn9Cr7GyJFM2/PZ1iBdryZ9vu7wfv0IcIrxo+dpHg1ZyI0bavSQhylWHF9nATXGHjZYXBW881XOQGBlLLfQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5963.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 00:08:14 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 00:08:12 +0000
Date: Sun, 24 May 2026 20:08:09 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-next v2 1/5] cgroup/cpuset: Add a
 cpuset_reserve_dl_bw() helper
Message-ID: <sz7alhvlwecdbf67jyxqhc634rh432xgnhll6qiz2dlti2ievk@ojfgentx7ud2>
References: <20260516042448.698216-1-longman@redhat.com>
 <20260516042448.698216-2-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516042448.698216-2-longman@redhat.com>
X-ClientProxiedBy: BN9PR03CA0556.namprd03.prod.outlook.com
 (2603:10b6:408:138::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb83588-2046-452c-3d6c-08deb9f1b5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aVn6j9mbA3zUHem+VmlEfAc66mRSYbrtubmFSsckYC55+F+2O+nU/VbJv0OckZX0pfQWHUOolwOxwUtJSzRDbzVWyfVYFwFalF7SSlNp7b4W6M4MWbxMBPdJbXcWCghLliEE3mZcBgQjVMF01ElH6C2M7LbLSEpxDlUq2TTh6MXCZvfF3C4XKimOm3HD8/SrztcEbERO5jeH9uICyKtZW3D7XriGN83spzChfKjCJiflvPWKYwEnP1K6cGnmAwIBXU9XB7SnzPPV1dOHXUHWRvAhP34vjNmJlI/dvcMjQg+GqHEwMZY6wFHehySTdd2UzWZnoNSIa2lPLrvnm38J4bAEeL0SwtOrGNeq9Z5qSSLlzb4KoCaVZWobi0e1qmiuZzM5nynBHfeTSuHgqhVnkt5tY0vcWp39emnVXdcj+PshYxqvBX79biH4rGKpiS/CFShGCvv68Kcvm29xtGdCiEDsEmtdAW8CTrzWxrJRS5NW1bfaDua828uUVoTPDT7nPV/8GPeoj/eIz06bcJ+Ab2KTa1P1SHNzURrsKzAfj2O58/Zst0OXMv+mxnfIyXTVTQGXk8F86NzzJApN1sbtoE/JB2yA7G7sA+TSNsUuaz0rqRcMlEM5QJzANgZZ811wY4eJTHcQ4qASOw4Almy4D8xQnAdPIBTCX5QPEUpdXpx5vIWWelFi6sJ/4tDtgE/i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFJhSnF6TUhxMXBKMTB1MzE0b0ZEZXFqV0M2dzBoS0dRaitaZHdJTmEwbmZJ?=
 =?utf-8?B?eDFNbXk0NVJWRThYc01sUDh6L2JseC9HdzFINlB1TncyNHRzVDRGVnQ2a3lS?=
 =?utf-8?B?SUpqQmtwKzV2em9uK1J5SERHQVlsNU5xVm9XOUMzcXY3eEV3aUNjMjVvaDcz?=
 =?utf-8?B?K01jWGJDSnA5aEl3RExveDd6ZTNWYlZNSGpNb3cyUmdjTnFpWUdUL0poR09p?=
 =?utf-8?B?eU1OajhQZDI3elV2SG5wMEtmV1Q3L1B5ZWRzM1RFQ0RHRGlhUzU0TGg2bGxq?=
 =?utf-8?B?a3dUTlpCSXVtZVlYc0tqeXhqRlN1cGU1WE1lbnRCU1Npb0FMSE1EQ3Awa2h2?=
 =?utf-8?B?OVpkYlQ3V1lBMFY4ZytNVTFrT0VtWWZJT0E0ZCtKRUg4R2pNUVJ4RXFwWmpn?=
 =?utf-8?B?Rk9zTEVIR2JsTFMzY3l6SUlYV0M0ZzFueXN3ZzZPQmhIVFRPVVFiZ3JzZDVZ?=
 =?utf-8?B?ZlMzVlhuS2xkOGR1QlA0TXAzMFQ5aG80YmYyUHFWcE9VNjVTblZGUktOakIv?=
 =?utf-8?B?TmhteDF5bkxZYVgzQWdCcVJWczF3QjlPZ09ueWFDbEtlZm9FV2hWK21NUVJV?=
 =?utf-8?B?U3l0WFFCSmZqYWcveStIY28rWFBPQzdEQW5MNDcvd3RqeVI4aG1nUGpWbXlh?=
 =?utf-8?B?NWQyR3lKSExEY3VFUmhXd0h2WGl1eUVOVjVReHlsVzQ1WkRLb3dId1pvUExN?=
 =?utf-8?B?dTFDOU1YUVpVVXJsV3BPNTl3V1o1cHM2ckhrcDcwRjlJdWMvS1JaQkh2UkU1?=
 =?utf-8?B?b1JFT1ZWQzZ3TFJwZHRyRDJoK0lva2RRR3I5Tm1DZTgrSHdmaVhqN2xaSjZo?=
 =?utf-8?B?R1FYcnlJbFRmSCt5cm91Q1N3aTQvNkZKZW9oTmMzSlJrZm10NGYyeUx1K0Rj?=
 =?utf-8?B?K2lyc1ZxWXJVRmRXMjRZWWpmV292a0FVaSsyYnI2NkFudDB4VUVDMHoxRVF6?=
 =?utf-8?B?V3llQ1Z3NHFlS0RicTF5NS9VU2FrSzBJb1N4bTFTeG15OFJKME5XY09DUDBk?=
 =?utf-8?B?R1BTOFFIaVdFRjZYVW9IaDVLTnZZaWFxVmJVMHNMOGxiTUswbk9yakMzbXNQ?=
 =?utf-8?B?eS93R1VyRS9iaU9aWU5lN2N5U2RHN0ZTWEc4N20zK0tTZU9EV3BQdDNKeTdT?=
 =?utf-8?B?SjdSSWg1QXpvTXQ3c3cwL0FDVEt2aWZsMzRuNlRrTTJxcTlDTzNWc0pPcHpU?=
 =?utf-8?B?TUhxVWhScU42SlpQTUcvUGVXM0RwSkJGMVN6QjltYzFoLzVBbmNDQXVrQS9T?=
 =?utf-8?B?bXhvcTdZYk1ia1dxQnpnS1kwazloYmVmM1hBUDlxQ3M5ZzRrY2RDVjRGYVIz?=
 =?utf-8?B?LzFvOWdBTEtMaER5VzlDVVNUbGYya3FiQkR2NGtIdElCekRUczFZVzJka2Zp?=
 =?utf-8?B?ckNCME1CQXJ5TyszbkhXckd6VW96L2wrL3FJUUZnNFZoSkVMaFN3RUxCNFAw?=
 =?utf-8?B?bnYzTGw2KzJhLzllak1kNTdranh4VFhsZnlzVGNodFlWTllmNUNvclFoNVhj?=
 =?utf-8?B?bTVOUURONjFnR0VHN1g4QzhKUFNMRTQ0MDdjY2M0eE5sSWJKaFo5K3M2Y0lN?=
 =?utf-8?B?SDMrd0ZHamFSM2pkZDJUVldGOE5ROFN6Qk1JV041WUYyN3U2V2tld002Qnhu?=
 =?utf-8?B?L3A3N0ZTS0QvWnBoeWFjSWwza25QMFpmUE1xOVNjSzFIUWxOZ3cvUytmZ25l?=
 =?utf-8?B?ZDlFZDlBY1AzUjluSXhZS2VWQTl4WlEvTjdKeEcrelYyYU5HQWVwR1EwYk85?=
 =?utf-8?B?Y05zNjA3SWRsL2crcjdwV285b3I1K2UzaVVETlFHdHBndmt1aStIMlhCUGZE?=
 =?utf-8?B?Rit2WjZ0eEFzK3JpYWJkM0ttcU8vdlROK01vcGNBUHZXcWViTVQ1WjFJSWVS?=
 =?utf-8?B?TXlJdVI2K0tOSlhVNWc4RVIvSjk3czdURElGdERWTVI4QnhWMGZ1bmRvbCs1?=
 =?utf-8?B?NHNjUlBtUHFDTXhobXQ3K051N1VaajZrd1JPOGdPckhOSnl4Zit0MzdpWTA5?=
 =?utf-8?B?VDdYYkNSRG5RVnQ3ZVFjMC9vVnFHc1RENTE2akN3RkcyVEY4VTJPUXJhTEdM?=
 =?utf-8?B?MXAvMmU2eStUZVJ1TThYemVBbE1FZ2hzQWZMaXlCbkdUSDhncHR5ZmNTUjVV?=
 =?utf-8?B?ajB0Y0Q1UFZjamRmaGF5L0RhRXo0bUJTMUlkbGh5Wjhpd3ZweDE3UVl0cGkx?=
 =?utf-8?B?Mmo3SU1hbzBkZGRVb2ZsaGFzYWZoQUVuVzBDTnNFSGliajQ0RmRUV0ptKzlv?=
 =?utf-8?B?MGU3eFUxbFBPSWhxTURDMXZDenpVYkdrSzJEUHNGVzBMaEpnNUtlZjBwV3Ry?=
 =?utf-8?B?U1BuVmthYUxzbXAvczZwczl6enpMejhtUFJySHovc25yNWt4emhTdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb83588-2046-452c-3d6c-08deb9f1b5f2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 00:08:12.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLPD5NR1X+UO8YSjHaF6OyJFNe/E53poB9AFjChurSaKmbvHGvM0yx1BC5egIcT3ixqbhbO/UBBah8x279EOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5963
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16233-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,atomlin.com:email]
X-Rspamd-Queue-Id: 98F5C5C4FCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 16, 2026 at 12:24:44AM -0400, Waiman Long wrote:
> Extract the DL bandwidth allocation code in cpuset_attach() to a new
> cpuset_reserve_dl_bw() helper to simplify code.
> 
> No functional change is expected.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 53 ++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bcefc9f50ac5..7cae47829013 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2980,6 +2980,25 @@ static int cpuset_can_attach_check(struct cpuset *cs)
>  	return 0;
>  }
>  
> +static int cpuset_reserve_dl_bw(struct cpuset *cs)
> +{
> +	int cpu, ret;
> +
> +	if (!cs->sum_migrate_dl_bw)
> +		return 0;
> +
> +	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> +	if (unlikely(cpu >= nr_cpu_ids))
> +		return -EINVAL;
> +
> +	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> +	if (ret)
> +		return ret;
> +
> +	cs->dl_bw_cpu = cpu;
> +	return 0;
> +}
> +
>  static void reset_migrate_dl_data(struct cpuset *cs)
>  {
>  	cs->nr_migrate_dl_tasks = 0;
> @@ -2994,7 +3013,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	struct cpuset *cs, *oldcs;
>  	struct task_struct *task;
>  	bool setsched_check;
> -	int cpu, ret;
> +	int ret;
>  
>  	/* used later by cpuset_attach() */
>  	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> @@ -3050,31 +3069,19 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  		}
>  	}
>  
> -	if (!cs->sum_migrate_dl_bw)
> -		goto out_success;
> -
> -	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> -	if (unlikely(cpu >= nr_cpu_ids)) {
> -		ret = -EINVAL;
> -		goto out_unlock;
> -	}
> -
> -	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -	if (ret)
> -		goto out_unlock;
> -
> -	cs->dl_bw_cpu = cpu;
> -
> -out_success:
> -	/*
> -	 * Mark attach is in progress.  This makes validate_change() fail
> -	 * changes which zero cpus/mems_allowed.
> -	 */
> -	cs->attach_in_progress++;
> +	ret = cpuset_reserve_dl_bw(cs);
>  
>  out_unlock:
> -	if (ret)
> +	if (ret) {
>  		reset_migrate_dl_data(cs);
> +	} else {
> +		/*
> +		 * Mark attach is in progress.  This makes validate_change() fail
> +		 * changes which zero cpus/mems_allowed.
> +		 */
> +		cs->attach_in_progress++;
> +	}
> +
>  	mutex_unlock(&cpuset_mutex);
>  	return ret;
>  }
> -- 
> 2.54.0
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

