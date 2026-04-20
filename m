Return-Path: <cgroups+bounces-15365-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPKKJYeR5WlNlgEAu9opvQ
	(envelope-from <cgroups+bounces-15365-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:37:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5F426580
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0194B3035893
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7A378D84;
	Mon, 20 Apr 2026 02:35:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D8378815;
	Mon, 20 Apr 2026 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652557; cv=none; b=kU4eMCtZHruUFvMMNPPtl8RTIRGrMnKgpkViNi3uxA9WkAyn2+KvUncVBqgyuC0otBkF2czx8/a+qMLc6wkEUxr3w6nPU8F9KiY3Zb7JY+AOS3gVTucsBCh7YXRULJaCm30a61nGrhwNqHZRWMywC88yvdTC8uoZZRwKs6WcWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652557; c=relaxed/simple;
	bh=jzKNATAd4EMprFr37lKdzxGwYC+ch+3R3nJ93zyWOCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8nxCcr4JwAazG5uo0G6NUiIbQysRIvVwFrSaIKVnXvdixBy0H1V8RCdNzk8qjHZu5M5WbfkvJ7uLWjteNwjTWA42xgRG0T1z/9+9kW5LCbg33XCi4CvnWCLXscdcLWSiMGEXXDQlKQ8iPbfycscxcL2MEMrsrWqnXCULGN7chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a1a3df903c6111f1aa26b74ffac11d73-20260420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0c690f79-0839-480e-8c21-0dc375d05e34,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:0c690f79-0839-480e-8c21-0dc375d05e34,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:3dfe6c0ce732333c153d0ec4da67bd9d,BulkI
	D:260418030341G5O2PQN4,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a1a3df903c6111f1aa26b74ffac11d73-20260420
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 435864654; Mon, 20 Apr 2026 10:35:44 +0800
Message-ID: <fae13102-24c1-4354-860c-9c6618ebbb07@kylinos.cn>
Date: Mon, 20 Apr 2026 10:35:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cgroup/cpuset: fix DL rollback accounting and add a
 selftest
To: Tejun Heo <tj@kernel.org>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 shuah@kernel.org, chenridong@huaweicloud.com, cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <3bccc1e5c1f5518cd140245956b0360e@kernel.org>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <3bccc1e5c1f5518cd140245956b0360e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15365-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 59F5F426580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/18 3:03, Tejun Heo 写道:
> Hello,
> 
> On Fri, Apr 17, 2026 at 11:37:40AM +0800, Guopeng Zhang wrote:
>> Guopeng Zhang (2):
>>   cgroup/cpuset: record DL BW alloc CPU for attach rollback
>>   selftests/sched_ext: add cpuset DL rollback test
> 
> Applied 1 to cgroup/for-7.1-fixes.
Hello Tejun,

Thanks for applying patch 1.
> 
> For 2, a cpuset test doesn't belong under selftests/sched_ext, but
> selftests/cgroup doesn't have the machinery to host a sched_ext-based test
> either, so there's no good home for it right now. If the rollback path can
> be exercised without a BPF scheduler, please rewrite it that way and resend
> targeting selftests/cgroup.
I will look into whether this can be rewritten without a BPF scheduler
and resent under selftests/cgroup.

Thanks,
Guopeng
> 
> Thanks.
> 
> --
> tejun


