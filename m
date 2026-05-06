Return-Path: <cgroups+bounces-15633-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OaIM2H9+mnjUwMAu9opvQ
	(envelope-from <cgroups+bounces-15633-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 10:35:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB74D7ED8
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCF0B300F158
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC363AA517;
	Wed,  6 May 2026 08:35:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5435DA46
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056539; cv=none; b=pOQpSVZjrP2qd++YhD98i3ejHqTZtFuxkodsKAUYhO2DMxZF8CKKqy2ll7JiZpXPM8UcVW1YMAn/36mHCbo3bujeTOy8dW+BmZIIq0Yma/9bw+0qmZm1qOkUpMWI3g0TuN0IXSWOTUOqSbF+HhuNT8sQ4f1Bn12KsHutBPsI3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056539; c=relaxed/simple;
	bh=5Mwy1fiKxBf3aoabqrLabHR/jCpwvd5MNMnPU1yGUx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4LNw5PZZNXepOsBUQGY8Gff/iSYGxmwDzvtNsMQDIcxmywSbsBpMBE8SFwIqwsFa/8mw6yevIiy6T0Mf6lmpnWPTcLqmeN5R3e2EcuYNYOMhem0lDS6TIx4ZnaGL1oTIGpUB++EPxRl0uoxYm3Rjusygf5xaC1bowX8rMgE1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 899a2838492611f1aa26b74ffac11d73-20260506
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM
	HR_CTE_8B, HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_NAME, HR_MAILER_MTBG, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2fddac4f-9d67-4979-8283-c3c6534c976e,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:2fddac4f-9d67-4979-8283-c3c6534c976e,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:60b3ffed58b7607931f3183f7f0dfef9,BulkI
	D:2604301735383I3MSLFX,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 899a2838492611f1aa26b74ffac11d73-20260506
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1208926187; Wed, 06 May 2026 16:35:29 +0800
Message-ID: <f374cebb-f8c1-4d7e-8771-aac018cbd9fd@kylinos.cn>
Date: Wed, 6 May 2026 16:35:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cgroup: Add basic tests for rdma controller
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org
References: <20260430084310.80662-1-cuitao@kylinos.cn>
 <afOT2cX2WOs0U05S@localhost.localdomain>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <afOT2cX2WOs0U05S@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46FB74D7ED8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15633-lists,cgroups=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]

Hello Michal,

Thank you for the review.

On Thu, Apr 30, 2026 at 04:43:10PM +0800, Michal Koutný wrote:
> IIUC, these are tests for proper parsing of the limits but not so useful
> wrt RDMA controller (test_rdmacg_max_read has apparently little use).

You are right. The initial test cases were modeled after the pids
controller selftests -- since both pids and rdma controllers track
non-reclaimable resources, I focused on the limit interface (rdma.max)
parsing and validation, similar to how test_pids.c verifies pids.max
defaults and limit enforcement via forking.

However, as you pointed out, this approach does not cover the essential
behavior of the rdma controller itself. I agree that testing whether
rdma.current actually responds to IB resource allocations and whether
rdma.max limits are properly enforced is more valuable.

> I see that you try to work with a first found device -- if that's
> available, it'd be good to have a test that checks whether respective
> rdma.current-s respond to object allocations.

> As I am looking at test_hugetlb_memcg.c that does only simple
> testing of the .current would be sufficient, not sure how difficult
> would be to implement a test for actual limit enforcement (but would be
> nice too).

I have reworked the tests in the next version to include:

  - test_rdmacg_current_response: verifies that rdma.current correctly
    tracks hca_handle and hca_object as IB resources (ibv_open_device,
    ibv_alloc_pd, ibv_dealloc_pd, ibv_close_device) are allocated and
    freed, similar to how test_hugetlb_memcg.c validates memory.current
    against hugetlb mmap/munmap operations.

  - test_rdmacg_limit_enforcement: verifies that exceeding the
    hca_object limit causes allocation failure (EAGAIN/ENOMEM) and that
    freeing a resource allows subsequent allocations to succeed.

These tests require libibverbs and will be skipped if no RDMA device
is available or the library is not present.

I will send the updated patch soon.

Thanks,
Tao Cui

