Return-Path: <cgroups+bounces-16971-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jp/QGAsaMGpSNgUAu9opvQ
	(envelope-from <cgroups+bounces-16971-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 17:28:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF641687AA6
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 17:28:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16971-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16971-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AEAD30D59FC
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223A4028FE;
	Mon, 15 Jun 2026 15:22:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020090.outbound.protection.outlook.com [52.101.196.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335014028F4;
	Mon, 15 Jun 2026 15:22:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536936; cv=fail; b=GvTGqa4yQJuQ5Dr1waNBF9cAdMaeb2aJ8Ca+gB2q3rnMAzH7U/Up27AoZzPQ9lFAHLnHioYddlhwE26B6DEbkfrP76yR5xDums/D79Pn9UlQo2ySTuVw3j2NIiotYJyYZMf1ExYJhNW/6SCu7nKi8HNlfRiS8Zb4Q2Tqj5XE0Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536936; c=relaxed/simple;
	bh=5lkaCTU0McswHGuigaCbfp4za386DUNOuWtbUZBAFi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bk4srL6S+bIOzfdqKijEdeAVnxlvtCGO1NnagHrmx7BCurLJpO4AODe7uUPm3qHztpwQ/MOrFwxHY0FYrRmLTCTvBEzHinFrGEm3Qw83MMQB7qhQTqn68YGZawtHnL1uQDTfCfFbEZHV5ycqrJ7lINqS+9wFkouWtXfDOPdmGXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.90
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sej8Il35a6qcQ1G1InKgRuhreuFJ2S89kuDtfZgUxO0v5j4vjGCHjcnhjTjPLcSeKx1uTGTWfUE7xxaC80bHj4k7Bpx20qXvSjXf4lhNtnX0ryzu6whvQyeRIMG8dHJV2GXlUk2tTnWGzgoQnLmmRtj6Hn1hjGf/9Pdh8d6pRfNIRt24CA4A4QP7aD6xrwOP9gPAcSv6wG1Jp1fOwlZa119wCTCPeVjsbu8SipxVJJmJ1uq9UuVdzK+k4Sj2Hzx2h98bjvwV5tmoxBrSolmD9uDFqytyLuYNP8hpNxHbmAGA4U9xLUv6wTS/gTPEEThgmQIh87cOoT+usEXQatbc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ncvcZTgIGK77eePxGMFdvqM6QnkflC9bpfJlVvwj7To=;
 b=Q1zKFby549YtrqhaFDDN4iWVlPRVlXcglLQyspfKjnm2RcoPvNN2XLIfeaHW9HLyFleYifW1MktveebMSiQwLqwPZWNjNaYa4aPMpHcNz5zUopxYgSnwUwiYtRHoU7NPz3z2oCo86Z0iTFc4PlarvJi9PCtelGwzEvTgCcU4gtV6WPzdyyC6r5VnqgG4hURhZgwlR3e2MqQjUZBYbGsz/yceSZ6ITgwwsflZrIcTtr+D2pa8UrFWMjdUXkwfxULSZ4gmZvhkQed8NNLPfQaF3a0JSxQwIxgWPGTtSwFDcw8JnMtfMCr1RAIGKKvuEGqa9wtu+lrWhVWGBbHAI7GiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB7004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:22:10 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:22:10 +0000
Date: Mon, 15 Jun 2026 11:22:08 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: paul@paul-moore.com
Cc: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	chenridong@huaweicloud.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	omosnace@redhat.com, kees@kernel.org, neelx@suse.com, sean@ashe.io, 
	chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, nick.lange@gmail.com, 
	cgroups@vger.kernel.org, linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
Message-ID: <exlgb3dg2kwxgna6gx2qixexvwjjul7z2ya7npal2gz4jjtr7m@h4oxgd74gsbp>
References: <20260526142838.774711-1-atomlin@atomlin.com>
 <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
 <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
 <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
 <20260527195858.GC3493090@noisy.programming.kicks-ass.net>
 <6hqq5oxvlcpmjvyns42dy2vtfvvixy7q4xyyjrrn46jrvsx5ar@gkmjsteqlpzd>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6hqq5oxvlcpmjvyns42dy2vtfvvixy7q4xyyjrrn46jrvsx5ar@gkmjsteqlpzd>
X-ClientProxiedBy: LO4P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d3da7d-df1f-4b21-2ef2-08decaf1de8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|6133799003|5023799004|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GaUzuwQ9YHgiFgUDUs7jC+UwSAkLPlMB4us7VzWGffOSKaktWtuOJXUkgRLsfNvOdjbqGt3QqgzSxqWW/eI8+c+IrW0m7QxunGUD/mDTjjpe6DmHSwLFfFGLfvshw99njGoDIsL2HiDitCWz3iYTCzht5omZlZSuOrP6ekpkOySvsDXHpN6xVRYxj9bJadSq5r9NtF35Nh9/aTy/8P2gyMGPCOoYwDOA1g3VemPJ12syP3Sjo9qr2O8jX2DhJntzn+q32Sw/RX/Yyy0btrIq5/O/ysnfjtgeb/ouD8fTqtqLKsH8Cwr+n1UfCnuxB5wGAN/Sj6w8jeSJPFJ4eaYFjY0L1M9jzkWrLGURxLWR7nTHuH81KZOPLXWhIDi/gkS5X4+aoKsmjuOGPFpn9zEEQhbCdMTz+U2JTctCInsXOWOmtF9pLCti79nh/gze8s8k65BTTgbRHz9BAR1UxhsZKSuzRYS+mjZg7odqtuIDM3JFPNbuaFyG/ZnBKHZv/mTj5Vw73LCEis7F9dFCx2O3tH1UKqD3nHGCVPzo0GKtii/YayGelC/Sx7CnlymYuKxAJLAgSc9Dv1yswpI0sPST/fViexmJl3tCJxOj3bxrSr89aKdVIQEgjkoWaHrktetR0YI9QZtRhTm/fu/XBqsq6Em1/xCO1f3PZNbaUui+GO/CjZr/Nia/G/ZkKv4e19lnb4SpPv8Zh0E0eFEWDObLTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(5023799004)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG9hV25HRnc3Mk8ySlFHSkpiQ09TNHg2aWFPNWJGYUNUWkFqNWVSUzJDZ0Nm?=
 =?utf-8?B?OFZMaCtUSExCRm5sb0FXMTVtTkdFVWlCZmhZVHZtcHVMb2pQbjk3dlcxZ2N3?=
 =?utf-8?B?YS9lU21zSlhuYnhkT25SVWk5Y29nZFZmdzVRMUQzZ0NQYk1kSm1qM1hSVjE5?=
 =?utf-8?B?KytCS0FZa0FuY0VRK1pHdGJ5U3hpN0FWUXUrb1RyN0ViU3U0b2JFNERTQVpB?=
 =?utf-8?B?dzE1Vnh0WVFCdkxXMVhLbm1xb2c2VXpzOEdWMlVyRFZYWGlkblJIQlJackV6?=
 =?utf-8?B?NzVmNDhrZDV0TlA1OWduZUtVbmcza2ExMTV3b0hNN0dqWUFKRUtqZzZTZ1dS?=
 =?utf-8?B?YU1XMks5ZWxEZ1o5MW02Y09JNXZWYU1xMDFmMXhkMi94Vzlwc1JXUkhGc1BW?=
 =?utf-8?B?dHV3Tm5PKzBDQ2k3MHZLU0hWUzhsNXRaSTNYT3BRUFJlUnhleUxXbFJPakZx?=
 =?utf-8?B?RWtzTDBoa2k2OVNhalRYbDltYSsvSEhlakZNT0NBV0lCZlBLNUs0b0hQWDE2?=
 =?utf-8?B?aTQ4STllRHY5T0QxMDZKZXF5NDdlbFhabmFvaFRwaDN6TWdmWXFJZFl2OGxM?=
 =?utf-8?B?WWt0QUY4dTN3S3ZVaEZzcnhtWE44UlMzaHNJREVjM0w1ZURrVzBDdlgxM2E2?=
 =?utf-8?B?Y2s1VGdKRG9vbmtvQWJBQmtIOFAwZnYwTk04ejdNc1RNUHBlclpQeHJUS0RX?=
 =?utf-8?B?RURFWDVqVEdwTFBiMmpjd053M2R2aGFZcjZnS2FPQkFOWlJTMUZ6Qys0S3Ri?=
 =?utf-8?B?bnhoOG9GZVhXM29GQi9qWkpGUzI3Q2FwZENnQXowbzV4dWpUQm1YWXB2aHJr?=
 =?utf-8?B?MFJaaHJXU2FVQWwxWXBWK1RSWEtONFVoRDNWMW1TQUZmRE5HT0FoSlplOGtI?=
 =?utf-8?B?OWNtZDZBWW5nMTdnZnQxT2lQU05yZHJ5UTVzS1NFbmQrQllJTTRpK1BYK2xG?=
 =?utf-8?B?VzJQL3Z1b3NwTk1VSmZrV2srbW1sQ2FkQ1lYblp2RFpzL1Z6NEZUM0ZZYUZn?=
 =?utf-8?B?WnFOenZac3lpN1JTSC8vZ0g2eTB6dkVwYm83R2wzTWxIK3JuVktHb2lpUHcv?=
 =?utf-8?B?b2ttNDM3YW5kdFMwOXlDdjNtSTBrQ3ozaTRVOTkvems1eG1veU9UT0tadmhI?=
 =?utf-8?B?QzFDQ3Rtc3NyVjVnbEhBamQ4d0lXVHBuQ092ekl1dGtjNHJjVGZPRitndGV5?=
 =?utf-8?B?SmwrcFRrSUlMMUZhbHZSUlFRRVE3ajBvVXExZjdCMTF6cFMrVnREakVleEw0?=
 =?utf-8?B?eFZDR1pHS3FUcVFvRVNrc2IyeGg3WndzaVJLTjBHTlZHY3Myb1BUZEJ6M2t1?=
 =?utf-8?B?WWd1RTEzZGc2RTZJR0JqYjl2dG56QkxkZWxYdXdFdXlHS0hqMm1aVytGU0No?=
 =?utf-8?B?UEhxakR5YUxqWEVka0xhODZjN2F3eUNIL1VFKzRtQzJSV2pmMXhscFFzeVI5?=
 =?utf-8?B?M2t1R2Q5cDRSZ1BhWklpUUFNS2FHMzNTQ0paUnRoQk5yTElvY3kyYU9XeXRR?=
 =?utf-8?B?bUVqdDZnUDlXY3lOenVWVERZQkFxZ21vdmJ1VjNFeTZGc0FZN1A5Qm82OEFx?=
 =?utf-8?B?QXNXZkNlaXg2dzgyZUJETHlmMWp4M2JxWkx0RTBPREE2QnR6OXM1T3FmS1Ni?=
 =?utf-8?B?ZzNZb3NBdklpNUJWdjZBVG1ocHZqd2NWUUVYdlhQMzB0Z1llMmVQOUdqWkd2?=
 =?utf-8?B?enVNVk5pSUNWZ3R5K3VnOVlGbkpNWFJvZStUUHBaTy9LMWJvZEwwdHpRbm9K?=
 =?utf-8?B?RUczN3dXalRGN0dOZ1llUTZkTXE2elplQUc1WTdJUFZpYVFVKzNyU21nTWQw?=
 =?utf-8?B?aiswNHNIRldlMVllcnBLMFcxT05Pa1ozWWVra3BFbzlxMEptOXRqZ1FMdnQ5?=
 =?utf-8?B?UjhrdElUWVZJWDEzWGJzRk8yY2Jnd0xmdU1VQllabTlFYUlxaGgvcis3TWNN?=
 =?utf-8?B?T2RENlNjSWJ4REg2OEhGcU1TMCtIdmdSQjk1OGZXcWJBbzd5L0RBU3owZ1Qv?=
 =?utf-8?B?aHNleWxkcEZ6WGxQbzduTDlzNlNhMUMrK2c0MFFGd3pmVm56ZXFidnFkWGtG?=
 =?utf-8?B?Y2dMbGprQ2pHTmU0ekM4T1pwSlg3b3pmaE5wWFFLUnZRaDZrMi8vMDR6Z29s?=
 =?utf-8?B?QW5KSUhQUHk2S1pHdTRGRVB6WjV3MWIwQVFRYWU2Z092eXF6QVAzZmVtakJi?=
 =?utf-8?B?dzFJWEhQZ0hUL0E3UUIvNkpFUkVmQ1RIcC95UGwzUUUrQTlaZUZJbFZVSm9a?=
 =?utf-8?B?RGJCQzNycjNROHJQeEE5WUxEaTFQOU9GSzExVFZ6YVVCQURXaWEyU2g2cnUw?=
 =?utf-8?Q?tecn6hfKZacSeYFFK0?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d3da7d-df1f-4b21-2ef2-08decaf1de8f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:22:10.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19ohcmb8MNOsYQE/hGHPCtSppMFIXPQ7vFnUOlwoIuLY/43Ad8/REnmAEYtmVi8yr3enkuC0D9miqE0yw0rBAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7004
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16971-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:tsbogend@alpha.franken.de,m:jmorris@namei.org,m:serge@hallyn.com,m:mingo@redhat.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:stephen.smalley.work@gmail.com,m:casey@schaufler-ca.com,m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:chenridong@huaweicloud.com,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:omosnace@redhat.com,m:kees@kernel.org,m:neelx@suse.com,m:sean@ashe.io,m:chjohnst@gmail.com,m:steve@abita.co,m:mproche@gmail.com,m:nick.lange@gmail.com,m:cgroups@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stephensmalleywork@gmail.com,m:nicklange@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,atomlin.com:from_mime,h4oxgd74gsbp:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF641687AA6

On Wed, May 27, 2026 at 09:19:11PM -0400, Aaron Tomlin wrote:
> On Wed, May 27, 2026 at 09:58:58PM +0200, Peter Zijlstra wrote:
> > On Wed, May 27, 2026 at 01:41:52PM -0400, Aaron Tomlin wrote:
> > 
> > > > > The actual use case here is multi-tenant workload isolation and visibility.
> > > > > Passing the evaluated cpumask to the BPF LSM allows operators to write a
> > > > > simple eBPF program to detect spatial boundary overlaps (e.g., logging an
> > > > > event if a requested mask intersects with platform-reserved cores).
> > 
> > Why isn't cgroups good enough to enforce this? If you create a cgroup
> > hierarchy per tenant, and constrain them using the cpuset controller,
> > they should not be able to escape, rendering this event impossible.
> 
> Hi Peter,
> 
> You raise a very fair point. The cpuset cgroup controller is indeed the
> kernel's primary vehicle for spatial enforcement, and under normal
> circumstances, it successfully prevents a tenant from escaping their
> designated cores.
> 
> The cpuset controller does govern resource limits, but does not audit
> intent. When __sched_setaffinity() is invoked, the kernel compares the
> requested in_mask against the task's allowed cpuset. If there is only a
> partial intersection, the kernel silently truncates the requested mask to
> fit the cpuset, without raising any alarm.
> 
> The BPF LSM hook, conversely, receives the raw, untruncated in_mask,
> affording operators the visibility to detect, audit, and even reject these
> violations of intent before the kernel silently sanitises the input.
> 
> This patch does not seek to replace the cpuset controller, but rather to
> complement it by providing auditing capabilities.
> 
> > > We are not creating a bespoke BPF hook here; rather, we are rectifying a
> > > historical blind spot within the API. The existing LSM hook is invoked
> > > during sched_setaffinity(), yet it presently receives only the task_struct
> > > pointer. Consequently, the security module is essentially asked, "Should
> > > Process A be permitted to alter Process B's affinity?" without being
> > > informed of the proposed affinity itself. Providing in_mask simply
> > > furnishes the existing hook with the requisite payload to make an informed
> > > decision.
> > 
> > It occurs to me that this same argument would require to also pass in
> > the new sched_attr, no? That way the LSM can inspect the new policy
> > before it becomes effective.
> 
> I agree, the underlying logic does indeed extend perfectly to sched_attr.
> 
> Presently, the LSM is equally oblivious as to whether a process is
> requesting a benign transition to SCHED_BATCH, or attempting to escalate
> its privileges by requesting a real-time policy such as SCHED_FIFO with
> maximum priority. Just as with the CPU mask, providing the sched_attr
> payload would rectify this parallel blind spot, allowing BPF policies to
> inspect and mediate scheduling attributes before they become effective.
> 
> If you are amenable, I should be more than happy to expand the scope of the
> forthcoming patch to include this. Alternatively, we could address the
> sched_attr expansion in a separate, subsequent patch. Personally, I would
> favour the latter approach, but please do let me know your preference.
> 
> I very much look forward to hearing Paul's thoughts on whether this aligns
> with the broader LSM vision.

Hi Paul,

I am writing to politely follow up on the discussion above regarding the
proposed enhancement to the sched_setaffinity LSM hook.

As you will see from the thread, Peter Zijlstra and I have discussed the
architectural justification for this change. While the cpuset cgroup
controller effectively handles spatial enforcement, it silently truncates
requested affinity masks. Passing the raw in_mask to the LSM hook enables
security modules (such as the BPF LSM) to audit and mediate the actual
intent of the request before the kernel sanitises the input, a capability
that cgroups inherently lack.

Furthermore, Peter rightly observed that this reasoning extends naturally
to sched_attr. Presently, the LSM cannot inspect whether a process is
requesting a benign scheduling policy or attempting to escalate to a
real-time priority. I am entirely amenable to addressing this parallel
blind spot, preferably in a subsequent patch.

Before I proceed any further, I would be most grateful for your perspective
as the Security sub-system maintainer. Do you feel this expansion is
acceptable?

As a brief administrative aside, please note that Thomas Bogendoerfer has
already queued the MIPS-specific changes related to this work into the
mips-next tree [1][2].

I look forward to hearing your thoughts.

[1]: https://lore.kernel.org/lkml/psb6pxogv2dlknps4p3sh6rt2h7xuuxkoif6ock5vxfz2jimec@txa6iy65crtb/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=98e37db4a34d3af3fb2f4648295c25b5e40b20e3


Kind regards,
-- 
Aaron Tomlin

